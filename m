Return-Path: <linux-wireless+bounces-488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7F806E4D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 12:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2FB1C209AE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4034552;
	Wed,  6 Dec 2023 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="U0Y3VTBE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45866112
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701863299; x=1702468099; i=zerobeat@gmx.de;
	bh=HlzYTxyJM6e6XJ3nYflroePul9idSjxW95FtA152fjY=;
	h=X-UI-Sender-Class:Date:From:Subject:Cc:To;
	b=U0Y3VTBE8bAwwidoQMCNBregDclxBPOkqdTTpINy9Z6vdGDRiPx1RMtR4f27ZT2g
	 /57abovHDifLKCn7ABkx5DOfFJ5XBlnRRZ+Py3Xg0wRowmY+/58oDUdqFrkRWMMiL
	 jj8UShWGlIJKt9pb2o2pGgClWyR/GH3lg9GfC4+1Ggndj+WRRPc2HLyDGRE4FZJXq
	 BcGbXOTP7MUfzA1FJoUnIe2MHzp8NhTpkxigxU8/+ZKzQFz1kM/PIUEqkZbbmXABD
	 b25JHdStxtUBBD4lBPBlAqNB5xPAS5lqJMxSFmlEugriq/GEhKq5DrIyGmJ2cCND9
	 T8M/HEjHP6mz85y/Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.252.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1rEP9z43LB-003ftQ; Wed, 06
 Dec 2023 12:48:19 +0100
Message-ID: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
Date: Wed, 6 Dec 2023 12:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US, fr-FR
From: ZeroBeat <ZeroBeat@gmx.de>
Subject: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Cc: Jes.Sorensen@gmail.com
To: linux-wireless@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hp1HxFeJf544bPaqdaUh21ei"
X-Provags-ID: V03:K1:3DLyDw3lG7ZiccNR90YM92kVn5GPspuTpHtqP0RjMTKfIRQxXA1
 t6wVDTpZkPEES2pD/QN2JEgG7zx/gAVupwCikDO63xsTyL/6rnxkwqws9uonYIrgLB9nBxV
 xprlbApGIjfY0EERxDP1BpbEpbV8fZFf+fvhU7QhFTvw3MSCIU65nL3p9nS+xUBAoYmasZk
 E4wxEWp7SrE4lUGrLUP+g==
UI-OutboundReport: notjunk:1;M01:P0:755svPSACps=;ucTf8hskGeI9djHP0qrB+X/ELmT
 wYTl2luDFPHvVjKASCv+XWRg28FfrN2Gq9gJtc0uSKo3A15ow4rQbLngkA9/9qknLNLx+RCgc
 jkUGZPhOkfGM68qfuPRfis30bfc2ijR0LtC5h749dhD8qLvVc+N/XfYY25ttG2AgCrs9zVsq0
 +EBJLlFLoHgF61bjOhBfpzicc5fDXseTwZkQgOfpdwvNRS31lz9i1qLSM8/AJ5rwdc/ipof0A
 zJsKvqTJQ8J6b6vSpEPPscfGrnGDelIqx2kzPyYDyJYg1SbtJyBYGm9vA22Ez4DwLtot7U7Ox
 X/yhIACrj8MmEQg/FF15JTERdEFvcKu9hRhpZc3WDiZKSVOOBsXMw7yW9Vw4jkqf6apdxwHVO
 eWNyF/FG1gQz6GdcanIcGi8X0eOHrIs857Y3458pGdv4umqCOD0lKtIEwRV7AHA615UuhqYij
 AvgXxvHSYCDB97mdLqAZLhwWPgIBkRZU8cN5Qzu5LbfTKxGDWNpYjemFgkX6OdGP5CdzV7Ef6
 NU4VPwmWoVDUJCwVor8VTz0ne+2lV1cSkMTbPMX1IpNVVG3P3O94TEpbr2apb9q/G4ZzG9x0b
 5+zEW1SDpNw8oCMKnKGZ5i34fNnISt8v4WljrtIWdW7nON1NAi4NpteDkN1GV/SJ99nngwHM1
 7xUPKA19Ys/L3IQN/FzTZaUWCIppW23XwQyx9Fd1SvedSyU8UjEVrWvvTRERK2RnXa60lW442
 md0pEGb1u0QxKcTGl7vf4jxEAK1SWLzK2H6ukLrU3TFWHkW2ke0YfRo+fC715YG490EgnZFJG
 IliyNMuUVqfnEUSNiB2JWg7Yg5tGH02YeU+zXCUnOMFgtPgJD0NXC3WXeVg2u3hd/mZpRMVdu
 hqxbDzSbctm74lMTAo0XmOyPL4BWTVP2u5Gpx1rO1Oqpr/1TJ/yCU0LMpmLkxmMu03Tr9AuzF
 Q4jHY7NizslcHU3RF1YmdVs2Dn4=

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hp1HxFeJf544bPaqdaUh21ei
Content-Type: multipart/mixed; boundary="------------UUHZ120Ou9lnKdtUdVR9CP00";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: linux-wireless@vger.kernel.org
Cc: Jes.Sorensen@gmail.com
Message-ID: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
Subject:  [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID

--------------UUHZ120Ou9lnKdtUdVR9CP00
Content-Type: multipart/mixed; boundary="------------j1ma7gwnakpNZGCOZ8VU0Uix"

--------------j1ma7gwnakpNZGCOZ8VU0Uix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFlbCBEaWVja21hbm4gKGh0dHBzOi8vZ2l0aHViLmNvbS9aZXJCZWEpDQpU
bzogbGludXgtd2lyZWxlc3MNCg0KU3ViamVjdDogW1BBVENIXSB3aWZpOiBSZWFsdGVrOiBy
dGw4eHh4dSBBZGQgbmV3IGRldmljZSBJRA0KDQpUaGlzIHBhdGNoIHdpbGwgYWRkIGEgbmV3
IGRldmljZSBJRC4NClBhdGNoIHdpbGwgY2xvc2U6IGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4MjMxDQoNCg0KVFAtTGluayBUTC1XTjgyMDBORChV
TikgdjMuMA0KSUQgMjM1NzowMTI2IFRQLUxpbmsgODAyLjExbiBOSUMNCmh0dHBzOi8vd3d3
LnRwLWxpbmsuY29tL2RlL2hvbWUtbmV0d29ya2luZy9hZGFwdGVyL3RsLXduODIwMG5kLw0K
U29sZCBpbiBHZXJtYW55Lg0KDQoNCi0tLSBsaW51eC9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2NvcmUuYy5vcmlnCTIwMjMtMTItMDYgMTI6Mzg6
NTEuOTI5NDg0MjUyICswMTAwDQorKysgbGludXgvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMJMjAyMy0xMi0wNiAxMTo1NDoxMi41MjQz
MDIyNzYgKzAxMDANCkBAIC03OTU3LDYgKzc5NTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHVzYl9kZXZpY2VfaWQgZGV2X3RhDQogIC8qIGZvdW5kIGluIHJ0bDgxOTJldSB2ZW5kb3Ig
ZHJpdmVyICovDQogIHtVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIzNTcsIDB4
MDEwNywgMHhmZiwgMHhmZiwgMHhmZiksDQogIAkuZHJpdmVyX2luZm8gPSAodW5zaWduZWQg
bG9uZykmcnRsODE5MmV1X2ZvcHN9LA0KK3tVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5G
TygweDIzNTcsIDB4MDEyNiwgMHhmZiwgMHhmZiwgMHhmZiksDQorCS5kcml2ZXJfaW5mbyA9
ICh1bnNpZ25lZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQogIHtVU0JfREVWSUNFX0FORF9J
TlRFUkZBQ0VfSU5GTygweDIwMTksIDB4YWIzMywgMHhmZiwgMHhmZiwgMHhmZiksDQogIAku
ZHJpdmVyX2luZm8gPSAodW5zaWduZWQgbG9uZykmcnRsODE5MmV1X2ZvcHN9LA0KICB7VVNC
X0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oVVNCX1ZFTkRPUl9JRF9SRUFMVEVLLCAweDgx
OGMsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KDQoNClRoYW5rcyBmb3IgbWFpbnRhaW5pbmcgdGhp
cyBkcml2ZXIuDQpCZXN0IHJlZ2FyZHMNCk1pY2hhZWwgRGllY2ttYW5uDQo=
--------------j1ma7gwnakpNZGCOZ8VU0Uix
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

--------------j1ma7gwnakpNZGCOZ8VU0Uix--

--------------UUHZ120Ou9lnKdtUdVR9CP00--

--------------hp1HxFeJf544bPaqdaUh21ei
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmVwX4IFAwAAAAAACgkQN1UWpF24hjCN
YQf/ZYmFier0OKwF3GYLM6Id+KAzRil1cy6CM1ppzlHN4OfqUfler2+IN0PHue1anoQUG3OiuOfo
zCH9iJYfYG/bhCLqVkfLrhED1SP6YnBwOCpsK6xSsnXx7YIaxfAhbDFk1+gO0z5IErcSRQGDfO/F
2zuuzs0p8u6zTtw/C1AXqBMYljPN1bOYj5maUCE71nsQgY2DtRgGcHBgHaMN18v9GKDiGOnmnKs7
Ef6hOyXtrUGEa5P0aF+Hua5lDoMA/jGl+YuoRdqCyj8qKXtCLy4YJg1lBORPsFEq28DWJ1hE77Yq
LFmft5aAYmCvObpLypGSlmCCoibDrbLYbR9ConIvHA==
=K+6K
-----END PGP SIGNATURE-----

--------------hp1HxFeJf544bPaqdaUh21ei--

