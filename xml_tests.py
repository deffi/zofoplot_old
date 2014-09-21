from collections import defaultdict, namedtuple
from cssutils.css.cssrule import CSSRule

xml_document = '''\
<zofoplot version="1">
    <chart class="polynomials">
        <dataset id="constant"  class="even" x="0,1,2,3,4,5" y="1,1,1,1,1,1" />
        <dataset id="linear"    class="odd"  x="0,1,2,3,4,5" y="0,1,2,3,4,5" />
        <dataset id="quadratic" class="even" x="0,1,2,3,4,5" y="0,0.1,0.4,0.9,1.6,2.5" />
        <dataset id="cubic"     class="odd"  x="0,1,2,3,4,5" y="0,0.1,0.8,2.7,6.4,12.5" />
    </chart>
</zofoplot>
'''

css_document = '''\
chart.polynomials, chart.exponentials { color: red } /* Not red, overridden later */
chart.polynomials, chart.exponentials { color: black } /* Must be black */
chart { background-color: white; color: brown } /* Not brown, less specific */
point { marker-size: 4 }
dataset.even point { filled: true }
dataset.odd point { filled: false }
'''

from lxml import etree
xml_tree = etree.fromstring(xml_document)
# 
from lxml.cssselect import CSSSelector
# sel = CSSSelector('dataset')
# sel(xml_tree)


import cssutils

# A value with a specificity. This allows us to store multiple conflicting
# values and select the one with the highest specificity
XmlPropertyValue = namedtuple("XmlPropertyValue", ('value', 'specificity'))

# A list of values with associated specificities
class XmlPropertyValueList(list):
    'Contains XmlPropertyValues' 
    def resolve(self):
        sort_key = lambda property_value: property_value.specificity
        return sorted(self, key = sort_key)[-1].value

# A dictionary mapping a property name to a value list
class XmlPropertyDict(defaultdict):
    def __init__(self):
        value_list_generator = lambda: XmlPropertyValueList()
        super(XmlPropertyDict, self).__init__(value_list_generator)
    def resolve(self):
        for property_name in self.keys():
            self[property_name] = self[property_name].resolve()
    def __repr__(self):
        return repr(dict(self))

# A dictionary that maps an element to a property dictionary
xml_properties = defaultdict(lambda: XmlPropertyDict())

 
rule_index = 0
css = cssutils.parseString(css_document, validate = False)
rules = css.cssRules
for rule in rules:
    rule_index += 1
    if rule.type == CSSRule.STYLE_RULE:
        selectors = rule.selectorList
        properties = rule.style.getProperties()
 
        for selector in selectors:
            selector_text = selector.selectorText
            specificity   = selector.specificity + (rule_index, )
             
            for property_ in properties:
                name  = property_.name
                value = property_.value
                #print(selector_text, specificity, name, value)
 
                xml_elements = CSSSelector(selector_text)(xml_tree)
                for xml_element in xml_elements:
                    print(xml_element, name, value, specificity)
                    xml_properties[xml_element][name].append(XmlPropertyValue(value, specificity))


for _, property_dict in xml_properties.items():
    property_dict.resolve()

for element, property_dict in xml_properties.items():
    print("%s: %s" % (element, property_dict))
