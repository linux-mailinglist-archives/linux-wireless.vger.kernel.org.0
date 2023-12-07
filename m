Return-Path: <linux-wireless+bounces-527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53999808375
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 09:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0828F283CCC
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA04328B5;
	Thu,  7 Dec 2023 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="LILqz1N4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93C126
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701938770; x=1702543570; i=zerobeat@gmx.de;
	bh=9C2hsguUn+/bLYskaANKoZeWOTFAEcE2qdnuLd0ZgeI=;
	h=X-UI-Sender-Class:Date:From:Subject:Cc:To;
	b=LILqz1N4Yfb3FwVOMJslh/fsc3mwXyfYS7TIkE2RshB074dJfCJq4MgB9L+0duNr
	 ICx2DdYOY/F6S46piibfPgFE/DoB7Tt9YjwsMnLfc488848VX/FG5Tf/1llfu2gOv
	 zPgxrnazFdcubPsrgf8adP3eLqYagBmYiO+wO4gPKevVywDMPkA2EvywVCIh0u6yy
	 Uk2XrdoGANrkZrAIL4tYprFED6mjJe+RMUlRYRWKZTHPmrEqZL2312vvoEZ7AXqfT
	 dgyHndqHCmENqdJY3wvBGlQiyBbmby1BJLUDkltBZpMxVg6FY3PU6IY1Dn0jm1xux
	 DTivrz7CDCcGMnkE6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.252.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1rKCSf067P-010ZdE; Thu, 07
 Dec 2023 09:46:10 +0100
Message-ID: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
Date: Thu, 7 Dec 2023 09:46:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US, fr-FR
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Cc: linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
To: Ping-Ke Shih <pkshih@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vJg00rx6SFz6JbrmWQIPxqtn"
X-Provags-ID: V03:K1:pf0RlrNKzxnSHMqprXdwsK7rMmYw4YXi4zJ17KcV7/M5U9zlYAl
 4VRgQY5NY7R4IS1pEZA6xqybMZdEBNl/xTioL8C+t6uV0lGcxZxI/rZlGdOyZp2EBZJmAHI
 Xv0mpw5ruYPkGPlrmFJUDCuKnxxVLcbJ4BSKvOexICogNv+1rOK53CqUk6gwiuuGr2Ngr6T
 hNRIkoVYRRQIvN5WJHOaA==
UI-OutboundReport: notjunk:1;M01:P0:ntaBeEBczn4=;4VfY9ms+QvyF1QTjmLB6HgQJZK3
 PlKCPZrFfMnY4fIRhgNH+XHXVXnltGR3+ZUSdPirqed+9d9twTPhaKexfiMoYO7ecQY/CkhJS
 s010ji8AaEjJPRz72U2KWNCeyPpPMCd4qciwwWiwPKJn9wX8UDDQeHmBMVpKzgjfUft0j1Csi
 Xm4JFTEO5dKC8fyPkULbD8FydV0ZgAD2ev3j8tOD8kjZB7EtobvBR4QYyxiL0nv5e0tdKyPSi
 2EjTNZHZrfdiVBtkL/Tw4Ij6a34A+g8jbOFaiqbKl1+BFX8J8ZPoNd82g0XjUIBNZlfGiKUZm
 U+zqSRso5Dqv8VuN1YLQ1Ydxbt2AD0gIdmLXPZ04j85c4iWFUqunStCKJfCUmfKwd0jGcXx40
 0qqqjxmrAbtvwZqO4npVrAeyWQhDJjG61zJ856JPL/1DqTRLXz6Hd7nXA/9lnkc8aH9sLeNWa
 nCvPhRWdLeK8MoWCfRB+E0fPpxBHQHQ4OyTSAVZ1iWe2kjkXd6qNULr37i1UO3FNtMUVJK8nK
 mY1tF8l4zsu52CxIyuafzJLs7aSeslqYDP516fp83rvoFfvcojuNA+of34kmiAMQqyX/32jHo
 XPy3/54zpjzIWAqWJYMGvnSvFf9dvu5IgoxgrtrU8cAmHOGzc+Mw/JIuoi1195PiKONJmyfWv
 5oj3VPjsHwcZnUP75xseIhlczHWTJZHTKu0RrzeCKa00RX/kxJF00/9y7mePAaGId5nKOg2Ky
 E8rm1mO6fgN+sOpFDnkmRyWrEaAuv2PBxGCi/rfc9NRFJRMknCbBCUPQlP5xmxlnPV2sn4WHE
 kme0wYrqyjijZcEdb9DBGqpvTSOAG4O8oZjswUhMZVOyd8QkTkkyxIRjYH7ObeOM3XZyi0kv5
 rW5kehJKWAcfRqOTgeSfqFRf9pseTvoAl/xmjCNWJJU23HUVXSZ3ZGXi2th2w//PR5lNzp3V4
 U5gQ/2TMQz2elZ+2z5LjceOKtM4=

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vJg00rx6SFz6JbrmWQIPxqtn
Content-Type: multipart/mixed; boundary="------------7D80VtUTWN9Oe71hELWS8NOU";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
Message-ID: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID

--------------7D80VtUTWN9Oe71hELWS8NOU
Content-Type: multipart/mixed; boundary="------------vm1Pyk10iykUH5Nfz84MCihe"

--------------vm1Pyk10iykUH5Nfz84MCihe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QmV0dGVyIG5vdz8NCg0Kc3ViamVjdDogd2lmaTogcnRsOHh4eHU6IEFkZCBuZXcgZGV2aWNl
IElEDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4
eHh1L3J0bDh4eHh1X2NvcmUuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfY29yZS5jDQppbmRleCA0M2VlNzU5MmJjNmUuLjQ3YjVlNmQyMGU1
NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bDh4eHh1L3J0bDh4eHh1X2NvcmUuYw0KQEAgLTc5NTcsNiArNzk1Nyw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCBkZXZfdGFibGVbXSA9IHsNCiAgLyogZm91bmQg
aW4gcnRsODE5MmV1IHZlbmRvciBkcml2ZXIgKi8NCiAge1VTQl9ERVZJQ0VfQU5EX0lOVEVS
RkFDRV9JTkZPKDB4MjM1NywgMHgwMTA3LCAweGZmLCAweGZmLCAweGZmKSwNCiAgICAgICAg
IC5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQore1VT
Ql9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9JTkZPKDB4MjM1NywgMHgwMTI2LCAweGZmLCAweGZm
LCAweGZmKSwNCisgICAgICAgLmRyaXZlcl9pbmZvID0gKHVuc2lnbmVkIGxvbmcpJnJ0bDgx
OTJldV9mb3BzfSwNCiAge1VTQl9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9JTkZPKDB4MjAxOSwg
MHhhYjMzLCAweGZmLCAweGZmLCAweGZmKSwNCiAgICAgICAgIC5kcml2ZXJfaW5mbyA9ICh1
bnNpZ25lZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQogIHtVU0JfREVWSUNFX0FORF9JTlRF
UkZBQ0VfSU5GTyhVU0JfVkVORE9SX0lEX1JFQUxURUssIDB4ODE4YywgMHhmZiwgMHhmZiwg
MHhmZiksDQoNClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgRGllY2ttYW5uIDx6ZXJvYmVhdEBn
bXguZGU+DQotLS0NCiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMgfCAgMiArKw0KDQoNCg0KID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCiA+IEZyb206IFplcm9CZWF0IDxaZXJvQmVhdEBnbXguZGU+DQogPiBTZW50OiBX
ZWRuZXNkYXksIERlY2VtYmVyIDYsIDIwMjMgNzo0OCBQTQ0KID4gVG86IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZw0KID4gQ2M6IEplcy5Tb3JlbnNlbkBnbWFpbC5jb20NCiA+
IFN1YmplY3Q6IFtQQVRDSF0gd2lmaXdpZmk6IFJlYWx0ZWs6IHJ0bDh4eHh1IEFkZCBuZXcg
ZGV2aWNlIElEDQoNCnN1YmplY3QgcHJlZml4IHNob3VsZCBiZSAid2lmaTogcnRsOHh4eHU6
IC4uLiINCg0KID4NCiA+IEZyb206IE1pY2hhZWwgRGllY2ttYW5uIChodHRwczovL2dpdGh1
Yi5jb20vWmVyQmVhKQ0KID4gVG86IGxpbnV4LXdpcmVsZXNzDQogPg0KID4gU3ViamVjdDog
W1BBVENIXSB3aWZpOiBSZWFsdGVrOiBydGw4eHh4dSBBZGQgbmV3IGRldmljZSBJRA0KID4N
CiA+IFRoaXMgcGF0Y2ggd2lsbCBhZGQgYSBuZXcgZGV2aWNlIElELg0KID4gUGF0Y2ggd2ls
bCBjbG9zZTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MTgyMzENCiA+DQogPg0KID4gVFAtTGluayBUTC1XTjgyMDBORChVTikgdjMuMA0KID4gSUQg
MjM1NzowMTI2IFRQLUxpbmsgODAyLjExbiBOSUMNCiA+IGh0dHBzOi8vd3d3LnRwLWxpbmsu
Y29tL2RlL2hvbWUtbmV0d29ya2luZy9hZGFwdGVyL3RsLXduODIwMG5kLw0KID4gU29sZCBp
biBHZXJtYW55Lg0KDQpNaXNzZWQgeW91ciBzaWduLW9mLWJ5LCBhbmQgdGhpcyBwYXRjaCBs
b29rcyBpcnJlZ3VsYXIuDQpQbGVhc2UgcmVmZXJlbmNlIHRvIGh0dHBzOi8vd2lyZWxlc3Mu
d2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJtaXR0aW5n
cGF0Y2hlcw0KDQogPg0KID4NCiA+IC0tLSBsaW51eC9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYy5vcmlnCTIwMjMtMTItMDYgMTI6Mzg6
NTEuOTI5NDg0MjUyDQogPiArMDEwMA0KID4gKysrIGxpbnV4L2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHVfY29yZS5jCTIwMjMtMTItMDYgMTE6NTQ6
MTIuNTI0MzAyMjc2ICswMTAwDQoNClRoZSBkaXJlY3RvcnkgcGF0aCBpcyBpbmNvcnJlY3Qu
DQoNCiA+IEBAIC03OTU3LDYgKzc5NTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9k
ZXZpY2VfaWQgZGV2X3RhDQogPiAgIC8qIGZvdW5kIGluIHJ0bDgxOTJldSB2ZW5kb3IgZHJp
dmVyICovDQogPiAgIHtVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIzNTcsIDB4
MDEwNywgMHhmZiwgMHhmZiwgMHhmZiksDQogPiAgIAkuZHJpdmVyX2luZm8gPSAodW5zaWdu
ZWQgbG9uZykmcnRsODE5MmV1X2ZvcHN9LA0KID4gK3tVU0JfREVWSUNFX0FORF9JTlRFUkZB
Q0VfSU5GTygweDIzNTcsIDB4MDEyNiwgMHhmZiwgMHhmZiwgMHhmZiksDQogPiArCS5kcml2
ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQoNClRoZSBpbmRl
bnRhdGlvbiBpcyBkaWZmZXJlbnQgZnJvbSBvdGhlciBleGlzdGluZyBvbmVzLg0KDQogPiAg
IHtVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIwMTksIDB4YWIzMywgMHhmZiwg
MHhmZiwgMHhmZiksDQogPiAgIAkuZHJpdmVyX2luZm8gPSAodW5zaWduZWQgbG9uZykmcnRs
ODE5MmV1X2ZvcHN9LA0KID4gICB7VVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oVVNC
X1ZFTkRPUl9JRF9SRUFMVEVLLCAweDgxOGMsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KID4NCiA+
DQogPiBUaGFua3MgZm9yIG1haW50YWluaW5nIHRoaXMgZHJpdmVyLg0KID4gQmVzdCByZWdh
cmRzDQogPiBNaWNoYWVsIERpZWNrbWFubg0K
--------------vm1Pyk10iykUH5Nfz84MCihe
Content-Type: application/pgp-keys; name="OpenPGP_0x375516A45DB88630.asc"
Content-Disposition: attachment; filename="OpenPGP_0x375516A45DB88630.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBE5aUQ0BCADlsVJE1z92lgySX+Nro7RSqTCAd6y41EljlISd8fGCoFbu0UBO
OPHFVQ1RYvjdRf29IUqfrtGjzucMBFs0Z061rna+omw4LqwMeMlMk1GLMWttCAnm
PQIYqj5BcqtIp5jh1vRggdg3Am6DTHhjqAAnGO+94sW2XnBLESRayGdBrQtUH2UL
Qe1XvTtG066HB3RtzPNO7irB/UDBs7PfJgXmvF1sQB7UyqEMaMr1Oi5DzYGn8AVa
zWTjuN7nQ5D8w3hnGbXmtPwm8dhKUO/UQjtOty8K95/0dP4Py/roBUTbNxzrC+Iz
FAiU5t4l83T1cg8fERl9a3kBB++A0y3OFmi7ABEBAAHNGlplcm9CZWF0IDxaZXJv
QmVhdEBnbXguZGU+wsB4BBMBAgAiBQJOWlENAhsjBgsJCAcDAgYVCAIJCgsEFgID
AQIeAQIXgAAKCRA3VRakXbiGMJLfB/4uTRxIRDrMrKXoy5IshxbyPpcKPt2fFsyJ
7lwozr8bZbYJfbrdXpYH2Arzegqy+gStJ94UNw3e2heihS0x+x8ukOHJ4XmzocDT
TgQDiciLF/y/T9GwvEeHiaws024hZ729w5eA/Gaa046lkYt6eqfW9+VIkzWMAl0V
/pNa63QVfHhZWBuj8EYIyCVhysxBa0tDyRPK1Ulih42lDXWCd1yN/ddaKE+m/+Nu
yWSybV2w/yaboWLQWZNVRRLcdFnognXUo2P3+MM8XNP6EePtQgJaKQ7vfm7RmM8F
3R8gX6lOiDIPZCoatsbSyPdlQ/rVkIDZ6FT0VW9yfdkV1RRLoCd5zsBNBE5aUQ0B
CADV1OCkQeXFo+C76N4QMxGf72FGrbbdTMQcyTtVAEgMh5Kkzuuf5OfP5FCGxOtw
YVXFe8mZeO3C6RrYid2GR0HFkx/wV4w/W68bRa85Hb6hxVddgmPhwvsJQpXItTaX
AjKH5soPHBmPZcl+3KUfqfL/nA4x4JrUJeMaM/X8Gek+uVbTKhwTvObSxPG6DvOd
mfHyUM0bhFV48ooC6IIc+VaHwyY1cgCLliErHrpKhIqP/N+UZpwDtZ+r0fFYIkuw
eJvU+qJmgEgyKrSHY06GspHOMSk5OclLQ8vxvyPbTeemz7fnnYlDc+yBLUfi5/wf
hW0vBI/pAhFVIvTCOtuLbgVhABEBAAHCwF8EGAECAAkFAk5aUQ0CGwwACgkQN1UW
pF24hjC74gf/V9YDe9ZnOUobCghW5qMK0wT2EGcl85rAQ878Awt0/ZMiHaCyAvXp
gsXVKeBFwfGzLdp5RGZJGYnEv3SltrF8uPslcCVmiFe+sZzR8RP61b6fdtRj8x+u
UMKMojonhQWNbkGcFtjbFZcbL91kjTwXJP8QV/KRaw6w2BtZf8he4LiCU3Mj1VVw
DIu16iodSb84NyvRRJtoW9qRakS78aDCHhJuPV0o8dDhZie1OqJDFODrlRsfPSCK
59xYsi6FMxT1fTp9mnh52Qre1YEvOtYgaps8mvtLI0wuJ4QwLgbGPk5WJvooGkKS
9e9rzZBHTO1QuH+ZvMR4+BDER+Pj9nXw4Q=3D=3D
=3D5ikK
-----END PGP PUBLIC KEY BLOCK-----

--------------vm1Pyk10iykUH5Nfz84MCihe--

--------------7D80VtUTWN9Oe71hELWS8NOU--

--------------vJg00rx6SFz6JbrmWQIPxqtn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmVxhlEFAwAAAAAACgkQN1UWpF24hjAo
qwf+I5CAlVKnQq+tpvwu8Ti8htQQsoV2mgT/wpfOpehgGIp1EahvvvtQJFpLCHfzCH4l6Aat36PB
V5yS1wKw/9xyaAEGBJ+I9CSFHdfHnAzRCZwQit7wriASSfsUmd4JGkTYJfEod4mI9WdFJ3URb2p6
BA6LSy4686E1BUOdgfjHkIq9bd4EhtjslWnRARjKEmH3RADdycbulCIxQA5oZ6f3OUFtcTAYOTEM
BhEOuCsUvDHOIOewi5gR1ckBe6JSMMe1ZbyEChpYr6WDkHTu+chIbYxBJUER7CjY/JXwH9iXiXW5
bdeLLlE4NbnfHVx6fdKPfpoYYhYCBNlpvF7trPy2bw==
=I924
-----END PGP SIGNATURE-----

--------------vJg00rx6SFz6JbrmWQIPxqtn--

