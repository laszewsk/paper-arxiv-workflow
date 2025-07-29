# paper-frontiers

To compile/render this paper and preview it continuously, execute
`make watch`.

Latexmk is required to do this. Installation instructions
are located at <https://mg.readthedocs.io/latexmk.html>
We recommend choosing "Yes" when asked "Install missing packages on-the-fly"
during the MiKTeX installation.

The order of installing required programs to compile the paper is:

* MiKTeX (if Windows)
* latexmk (installed from the Packages tab in MiKTeX console)
* Okular
* make

We recommend installing Okular to utilize `make watch` continuously,
because Okular does not lock the file unlike other PDF viewers such as
Acrobat.

If on Windows, get make by using `choco`. If chocolatey is not installed,
follow the documentation at <https://chocolatey.org/install>.
Then use `choco install make`.