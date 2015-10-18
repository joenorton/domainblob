@statesArray = %w(Alabama 
Alaska 
Arizona 
Arkansas 
California 
Colorado 
Connecticut 
Delaware 
Florida 
Georgia 
Hawaii 
Idaho 
Illinois Indiana 
Iowa 
Kansas 
Kentucky 
Louisiana 
Maine 
Maryland 
Massachusetts 
Michigan 
Minnesota 
Mississippi 
Missouri 
Montana Nebraska 
Nevada 
New Hampshire 
New Jersey 
New Mexico 
New York 
North Carolina 
North Dakota 
Ohio 
Oklahoma 
Oregon 
Pennsylvania Rhode Island 
South Carolina 
South Dakota 
Tennessee 
Texas 
Utah 
Vermont 
Virginia 
Washington 
West Virginia 
Wisconsin 
Wyoming
)
@locationSuffixArray = %w(house 
central 
point 
home 
place 
garden 
site 
spot 
park 
dome 
bay 
web 
net 
cave 
base 
heaven 
portal 
world 
camp 
network 
county 
street 
city 
alley 
depot 
valley
)
@suffixArray = %w(
now 
resources 
tools 
source 
review 
system 
book 
guide 
talk 
data 
vision 
load 
box 
focus 
beat 
voice 
share 
cafe 
nexus 
zone 
sight 
link 
lab 
insight 
vine 
board 
flow 
signs 
network 
wire 
cast 
ville 
nation 
egg 
cove 
news 
today 
future 
fun 
watch 
story 
fever 
coast 
side 
road 
heat 
bite 
insider 
club 
connect
)
@prefixArray = %w(
the 
my 
i 
me 
we 
you 
e 
top 
pro 
best 
super 
ultra 
all 
cyber 
simply 
free 
1st 
meta 
re 
metro 
urban 
head 
hit 
front 
techno 
ever 
rush 
think 
solo 
radio 
vip
)
@latinPrefixArray = %w(
ubi 
bis 
ad 
ambi 
inter 
liber 
mono 
poli 
tele 
omni 
exo 
extra 
hyper 
hypo 
intro 
proto 
intra 
micro 
macro 
multi 
neo 
iso 
mono
)
@latinPreAndSuffixArray = %w(
io 
virtus 
ego 
vox 
ex 
ideo 
novo 
novus 
pax 
rex 
velox 
verus 
vivo 
nova
)
@bothPreAndSuffixArray = %w(
media 
direct 
access 
ez 
easy 
info 
interactive 
biz 
buzz 
bit 
byte 
up 
tech 
on 
out 
auto 
pulse 
x 
venture 
trend 
life 
retro 
secret
)
@scientificPrefixArray = %w(
aero 
cosmo 
deca 
eco 
geo 
hex 
oxy 
uni 
poly
)
@prefix_hash = Hash[
    "main" => @prefixArray,
    "scientific" => @scientificPrefixArray,
    "tech" => @bothPreAndSuffixArray,
    "latin" => (@latinPrefixArray + @latinPreAndSuffixArray)
]
@suffix_hash = Hash[
    "main" => @suffixArray,
    "location" => @locationSuffixArray,
    "tech" => @bothPreAndSuffixArray,
    "latin" => @latinPreAndSuffixArray
]