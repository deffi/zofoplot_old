import os

from matplotlib import pyplot as plt

print("moo")


x1=[2,3,4,5]
y1=[4,9,16,25]

x2=[2.5, 3.4, 4.3]
y2=[9, 11, 11.5]


left, width = 0.1, 0.8
rect1 = [left, 0.7, width, 0.2]
rect2 = [left, 0.3, width, 0.4]
rect3 = [left, 0.1, width, 0.2]

fig = plt.figure(facecolor='white')

ax1 = fig.add_axes(rect1)
ax2 = fig.add_axes(rect2)
ax3 = fig.add_axes(rect3)

l1 = ax2.plot(x1, y1, 'o-', label="Square")
l2 = ax2.plot(x2, y2, 'o-', label="Whatever this line is")


handles, labels = ax2.get_legend_handles_labels()

leg = ax2.legend(handles, labels, loc="center left", bbox_to_anchor = (1, 0.5))

#leg = plt.legend(loc="center left", bbox_to_anchor=(1,0.5), numpoints = 1, borderaxespad = None)
#leg = plt.figlegend(handles, labels, loc="center right", bbox_to_anchor=(1,0.5), borderaxespad = None)
#leg = plt.legend(loc="center right", bbox_to_anchor=(0,0,1,1), numpoints = 1, borderaxespad = None, bbox_transform=fig.transFigure)

#ax1.set_title("Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla title")
12
ax1.set_title("Bla bla title")
#fig.savefig('matplotlib_test_output.png', bbox_extra_artists=(leg,), bbox_inches='tight')
fig.savefig('matplotlib_test_output.png', bbox_inches='tight')
os.system("start matplotlib_test_output.png")

#plt.show()
