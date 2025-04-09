// 导入包与主题设置部分  
#import "@preview/touying:0.6.1": *  
// 导入 Touying 幻灯片包（版本0.6.1）及其所有组件，Touying 是制作幻灯片的主要工具包  

#import themes.university: *  
// 导入 Touying 中的 university 主题，这是一个学术风格的演示主题  

#import "@preview/cetz:0.3.2"  
// 导入 CeTZ 包（版本0.3.2），用于创建矢量图形和图表  

#import "@preview/fletcher:0.5.5" as fletcher: node, edge  
// 导入 Fletcher 包（版本0.5.5）重命名为 fletcher，并只导入 node 和 edge 组件，用于创建流程图和节点图  

#import "@preview/numbly:0.1.0": numbly  
// 导入 Numbly 包（版本0.1.0），用于自定义编号格式  

#import "@preview/theorion:0.3.2": *  
// 导入 Theorion 包（版本0.3.2）及其所有组件，用于创建定理、证明等数学环境  

#import cosmos.clouds: *  
// 从 cosmos 包中导入 clouds 模块的所有组件，提供额外的样式选项  

#show: show-theorion  
// 应用 Theorion 包的样式到整个文档，启用定理环境的样式  

// cetz and fletcher bindings for touying  
// 为 Touying 创建 CeTZ 和 Fletcher 的绑定，以便在幻灯片中使用这些绘图工具  
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))  
// 创建一个函数，将 CeTZ 画布与 Touying 的动画系统集成，使图形可以在幻灯片中动态显示  

#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)  
// 创建一个函数，将 Fletcher 图表与 Touying 的动画系统集成，使流程图可以在幻灯片中动态显示  

// 应用幻灯片主题设置  
#show: university-theme.with(  
  aspect-ratio: "16-9",  // 设置幻灯片的宽高比为16:9（宽屏格式）  
  // align: horizon,     // 注释掉的水平对齐设置  
  // config-common(handout: true),  // 注释掉的讲义模式设置  
  config-common(frozen-counters: (theorem-counter,)),  // 设置定理计数器在动画期间保持不变  
  config-info(  // 设置幻灯片的基本信息  
    title: [Title],      // 幻灯片标题  
    subtitle: [Subtitle],  // 幻灯片副标题  
    author: [Authors],   // 作者信息  
    date: datetime.today(),  // 日期，使用当前日期  
    institution: [Institution],  // 机构信息  
    logo: emoji.school,  // 使用学校表情符号作为logo  
  ),  
)  

// 设置标题的编号格式  
#set heading(numbering: numbly("{1}.", default: "1.1"))  
// 使用 Numbly 包设置标题编号格式，一级标题使用"1."格式，其他级别默认使用"1.1"格式  

// 创建标题幻灯片  
#title-slide()  
// 显示标题幻灯片，包含前面config-info中设置的所有信息  

// 大纲页设置  
== Outline <touying:hidden>  
// 创建一个名为"Outline"的二级标题，<touying:hidden> 标记表示在导航中隐藏此幻灯片  

#components.adaptive-columns(outline(title: none, indent: 1em))  
// 使用自适应列布局显示大纲，不显示大纲标题，缩进1em  

// 动画部分开始  
= Animation  
// 创建名为"Animation"的一级标题/章节  

// 简单动画示例  
== Simple Animation  
// 二级标题"Simple Animation"  

We can use `#pause` to #pause display something later.  
// 文字说明，并使用#pause命令创建一个暂停点，使后面的内容在点击后才显示  

#pause  
// 创建一个暂停点，点击后才显示下面的内容  

Just like this.  
// 这一行将在点击后才显示  

#meanwhile  
// #meanwhile 命令用于并行显示内容，即在同一个幻灯片上显示多组不同时间出现的内容  

Meanwhile, #pause we can also use `#meanwhile` to #pause display other content synchronously.  
// 文字说明，同时使用#pause创建更多暂停点  

#speaker-note[  
  + This is a speaker note.  
  + You won't see it unless you use `config-common(show-notes-on-second-screen: right)`  
]  
// 创建演讲者笔记，这些内容只有演讲者能看到，通常在演示模式中的第二屏幕显示  


// 复杂动画示例  
== Complex Animation  
// 二级标题"Complex Animation"  

At subslide #touying-fn-wrapper((self: none) => str(self.subslide)), we can  
// 显示当前子幻灯片编号，touying-fn-wrapper是一个函数，用于获取当前子幻灯片的编号  

use #uncover("2-")[`#uncover` function] for reserving space,  
// 使用#uncover函数，从第2个子幻灯片开始显示内容，但会预留空间  

use #only("2-")[`#only` function] for not reserving space,  
// 使用#only函数，从第2个子幻灯片开始显示内容，不预留空间  

#alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.  
// 使用#alternatives函数在多个选项中选择一个显示，第一个选项显示叉号，第二个选项显示勾号  


// 回调式动画示例  
== Callback Style Animation  
// 二级标题"Callback Style Animation"  

#slide(  
  repeat: 3,  // 重复此幻灯片3次，用于创建子幻灯片序列  
  self => [  // 使用回调函数处理幻灯片内容  
    #let (uncover, only, alternatives) = utils.methods(self)  // 从当前幻灯片对象获取方法  

    At subslide #self.subslide, we can  // 显示当前子幻灯片编号  

    use #uncover("2-")[`#uncover` function] for reserving space,  // 同上，使用uncover函数  

    use #only("2-")[`#only` function] for not reserving space,  // 同上，使用only函数  

    #alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.  // 同上，使用alternatives函数  
  ],  
)  


// 数学方程动画示例  
== Math Equation Animation  
// 二级标题"Math Equation Animation"  

Equation with `pause`:  // 标题：使用pause的方程  

$  
  f(x) &= pause x^2 + 2x + 1 \  // 在数学环境中的暂停点，第一步显示f(x) =  
  &= pause (x + 1)^2 \  // 第二步显示 = (x + 1)^2  
$  

#meanwhile  // 同时显示另一组内容  

Here, #pause we have the expression of $f(x)$.  // 同步解释第一步  

#pause  // 暂停点  

By factorizing, we can obtain this result.  // 同步解释第二步  


// CeTZ图形动画示例  
== CeTZ Animation  
// 二级标题"CeTZ Animation"  

CeTZ Animation in Touying:  // 标题  

#cetz-canvas({  // 开始CeTZ画布  
  import cetz.draw: *  // 导入CeTZ绘图功能  

  rect((0, 0), (5, 5))  // 绘制一个大矩形，从(0,0)到(5,5)  

  (pause,)  // 在CeTZ中插入暂停点  

  rect((0, 0), (1, 1))  // 绘制三个小矩形  
  rect((1, 1), (2, 2))  
  rect((2, 2), (3, 3))  

  (pause,)  // 又一个暂停点  

  line((0, 0), (2.5, 2.5), name: "line")  // 绘制一条线  
})  


// Fletcher流程图动画示例  
== Fletcher Animation  
// 二级标题"Fletcher Animation"  

Fletcher Animation in Touying:  // 标题  

#fletcher-diagram(  // 开始Fletcher图表  
  node-stroke: .1em,  // 设置节点边框宽度  
  node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),  // 设置节点填充为径向渐变  
  spacing: 4em,  // 设置节点间距  
  edge((-1, 0), "r", "-|>", `open(path)`, label-pos: 0, label-side: center),  // 创建第一条边，带有标签  
  node((0, 0), `reading`, radius: 2em),  // 创建"reading"节点  
  edge((0, 0), (0, 0), `read()`, "--|>", bend: 130deg),  // 创建自循环边  
  pause,  // 暂停点  
  edge(`read()`, "-|>"),  // 动画后添加边  
  node((1, 0), `eof`, radius: 2em),  // 动画后添加"eof"节点  
  pause,  // 另一个暂停点  
  edge(`close()`, "-|>"),  // 动画后添加边  
  node((2, 0), `closed`, radius: 2em, extrude: (-2.5, 0)),  // 动画后添加"closed"节点  
  edge((0, 0), (2, 0), `close()`, "-|>", bend: -40deg),  // 动画后添加另一条边  
)  


// 定理部分  
= Theorems  
// 创建名为"Theorems"的一级标题/章节  

// 素数定义和示例  
== Prime numbers  
// 二级标题"Prime numbers"  

#definition[  // 创建定义环境  
  A natural number is called a #highlight[_prime number_] if it is greater  
  than 1 and cannot be written as the product of two smaller natural numbers.  
]  
#example[  // 创建示例环境  
  The numbers $2$, $3$, and $17$ are prime.  
  @cor_largest_prime shows that this list is not exhaustive!  // 引用后面的推论  
]  

#theorem(title: "Euclid")[  // 创建带标题的定理环境  
  There are infinitely many primes.  
]  
#pagebreak(weak: true)  // 创建可选的分页符  
#proof[  // 创建证明环境  
  Suppose to the contrary that $p_1, p_2, dots, p_n$ is a finite enumeration  
  of all primes. Set $P = p_1 p_2 dots p_n$. Since $P + 1$ is not in our list,  
  it cannot be prime. Thus, some prime factor $p_j$ divides $P + 1$. Since  
  $p_j$ also divides $P$, it must divide the difference $(P + 1) - P = 1$, a  
  contradiction.  
]  

#corollary[  // 创建推论环境  
  There is no largest prime number.  
] <cor_largest_prime>  // 设置标签，用于引用  
#corollary[  // 另一个推论  
  There are infinitely many composite numbers.  
]  

#theorem[  // 另一个定理  
  There are arbitrarily long stretches of composite numbers.  
]  

#proof[  // 该定理的证明  
  For any $n > 2$, consider $  
    n! + 2, quad n! + 3, quad ..., quad n! + n  
  $  
]  


// 其他功能示例  
= Others  
// 创建名为"Others"的一级标题/章节  

// 并排布局示例  
== Side-by-side  
// 二级标题"Side-by-side"  

#slide(composer: (1fr, 1fr))[  // 创建两列布局的幻灯片，每列占一份空间  
  First column.  // 第一列内容  
][  
  Second column.  // 第二列内容  
]  


// 多页示例  
== Multiple Pages  
// 二级标题"Multiple Pages"  

#lorem(200)  // 插入200字的随机拉丁文，用于示例多页效果  


// 附录部分  
#show: appendix  // 切换到附录模式  
// 此命令会改变幻灯片的计数和样式，表示从这里开始是附录  

= Appendix  
// 创建名为"Appendix"的一级标题/章节  

== Appendix  
// 二级标题"Appendix"  

Please pay attention to the current slide number.  // 提示注意当前幻灯片编号（会显示为A-1之类的格式）  
