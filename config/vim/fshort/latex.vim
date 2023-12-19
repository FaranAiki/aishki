" Only for Latex

" Important to unmap ' and "
iunmap '
iunmap "

inoremap ;; \emph{}<Left>
inoremap ;. \textbf{}<Left>
inoremap ;, \textit{}<Left>

inoremap #ce \begin{center}<CR> <CR>\end{center}<Up>

inoremap #eq \begin{equation}<CR> <CR>\end{equation}<Up>
inoremap #eq* \begin{equation*}<CR> <CR>\end{equation*}<Up>
inoremap #en \begin{enumerate}<CR> <CR>\end{enumerate}<Up>
inoremap #al \begin{align}<CR> <CR>\end{align}<Up>
inoremap #al* \begin{align*}<CR> <CR>\end{align*}<Up>
inoremap #ml \begin{multlined}<CR> <CR>\end{multlined}<Up>
inoremap #matr \begin{bmatrix}<CR> <CR>\end{bmatrix}<Up>
inoremap #pict \includegraphics{}<Left>
