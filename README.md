# SSD工具包说明
作者:沈牧天


Shortest-Solution-guided Decimation算法,以欠定线性方程组$Dx=y$解空间中的欧几里得最短解作为索引,由$D$和$y$反推出原始稀疏信号$x_0$.
作为例子,可以在MATLAB中产生2000\*10000的矩阵`D`以及10000\*1的原始稀疏(稀疏度=0.05)信号`x_0`:

    D = randn(2000,10000);
    x_0 = random_vector(10000,0.05);

函数`random_vector`是容易实现的.`x_0`包含500个非零元素.之后运行代码:

    y = D*x_0;
    result = ssd(D,y,10);

之后可以比较`result`和`x_0`,发现它们van♂全一致.

## 代码说明
`ssd.m`是主程序,`guidance_convex.m`使用*Dual Ascent*优化方法求得欧几里得最短解:目前来看是最快的一种方法.
将这两者分开是为了应对未来可能的改动.
