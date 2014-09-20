xml_document = '''\
<zofoplot version=1>
    <chart class="polynomials">
        <dataset id="constant"  class="even" x="0,1,2,3,4,5" y="1,1,1,1,1,1">
        <dataset id="linear"    class="odd"  x="0,1,2,3,4,5" y="0,1,2,3,4,5">
        <dataset id="quadratic" class="even" x="0,1,2,3,4,5" y="0,0.1,0.4,0.9,1.6,2.5">
        <dataset id="cubic"     class="odd"  x="0,1,2,3,4,5" y="0,0.1,0.8,2.7,6.4,12.5">
    <chart>
</zofoplot>
'''

css_document = '''\
chart#polynomials { color: black }
chart { background-color: white; color: brown }
point { marker-size: 4 }
dataset.even point { filled: true }
dataset.odd point { filled: false }
'''

