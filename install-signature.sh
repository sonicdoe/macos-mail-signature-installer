#!/usr/bin/env bash
set -euo pipefail

signatureUniqueId="$(uuidgen)"
signaturesDirectory="$HOME/Library/Mail/V2/MailData/Signatures"

if [ ! -f "$signaturesDirectory/AllSignatures.plist" ]; then
	>&2 echo "Could not find AllSignatures.plist in $signaturesDirectory."
	exit 1
fi

if [ -t 0 ]; then
	>&2 echo "stdin seems to be empty."
	exit 1
fi

/usr/libexec/PlistBuddy -c "Add :0 dict" "$signaturesDirectory/AllSignatures.plist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureIsRich bool true" "$signaturesDirectory/AllSignatures.plist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureName string '$1'" "$signaturesDirectory/AllSignatures.plist"
/usr/libexec/PlistBuddy -c "Add :0:SignatureUniqueId string '$signatureUniqueId'" "$signaturesDirectory/AllSignatures.plist"

cat <<EOF > "$signaturesDirectory/$signatureUniqueId.mailsignature"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8
Message-Id: <$(uuidgen)>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))

EOF

cat | perl -MMIME::QuotedPrint -pe '$_=MIME::QuotedPrint::encode($_)' >> "$signaturesDirectory/$signatureUniqueId.mailsignature"

echo "Installed “$1” signature with ID $signatureUniqueId."
