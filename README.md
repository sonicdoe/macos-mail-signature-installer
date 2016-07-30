# OS X Mail Signature Installer

Easily install HTML signatures in OS X’s Mail application.

## Usage

Pipe your signature file into `install-signature.sh` and pass the desired name of your signature as the first argument, for example:

```sh
$ cat my-signature.html | ./install-signature.sh "My Signature"
```

## Acknowledgments

Thanks to [@coneybeare](https://github.com/coneybeare) for [his tutorial on making an HTML signature in Apple Mail](http://matt.coneybeare.me/how-to-make-an-html-signature-in-apple-mail-for-el-capitan-os-x-10-dot-11/).

## License

`osx-mail-signature-installer` is licensed under the BSD 2-clause license. See [LICENSE](./LICENSE) for the full license.
