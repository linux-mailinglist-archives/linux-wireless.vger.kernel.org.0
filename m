Return-Path: <linux-wireless+bounces-529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256848083BB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D558D283D3C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7A1DA2E;
	Thu,  7 Dec 2023 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="SVLM3Gmt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23A19A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 01:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701939748; x=1702544548; i=zerobeat@gmx.de;
	bh=nCoWDj+94biRTSBEEn5UWu6toGrQLJo4sRq372HXMns=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SVLM3GmtJSr17zXjhqrsbwlm2/E2fS4NUXyOI4RVLWqmvSUNGobF+ZkxC69cn7uH
	 ZT3tg2gnVFAUbcNbP0IVyWCl3CbiCyAJ5+QMEqpz4omB77tFFkwcY/BHT5DFWWEBd
	 OdCw3nLapkc7Q10Xcq1uxH9smJH5+IlkDiCzW85jxElyIgu3W2msUVQqFrliJitzP
	 Vn6mshFk3d/kUyJ2uzEBtK+gEXDg1eIE1W35yMqZVYgVJijiP0YFUxXc07XpZ5lnF
	 etB+vOeRucep9pVWj6Y+HFlky2bECAYYFXXDkezkvjXIcXHX/gYZGukfxsHamMInc
	 D8ke4eAIx7M2vcEDcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.252.215]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2Jt-1rfZLf3RDN-00e3G5; Thu, 07
 Dec 2023 10:02:26 +0100
Message-ID: <f68e8ae0-e4c5-4a10-8b5f-f9ab3bc55068@gmx.de>
Date: Thu, 7 Dec 2023 10:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
From: ZeroBeat <ZeroBeat@gmx.de>
In-Reply-To: <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9xJEXvQYjrIFoz46bZaJFkrq"
X-Provags-ID: V03:K1:hIYKZOrO76ABuCq262jRA7E9m3AEkDsah+gIVwMRPvIQ06PXB6e
 DnXGeVKrDhYmjpnF1l8/AeRHYg4BPswWtGTkQNuex8zSKxBY+QVO2pqRtwrFa1gImgHPMX/
 1pS5ZUyhXIFI6uuUcj/jC80CF92Bk5BxDj9mvQBWm57Jikfmm7BzEetbIC/W9SFsvCZ57Ui
 POVQReyr5NEjf06H4KlUA==
UI-OutboundReport: notjunk:1;M01:P0:3R+X0zvukVM=;IZqvHuGZtcyERllSESD2uSVtI9n
 +WYJX5Ctv63bd9lnh2KNzCnGSmWoxQZsmlnxMQiNnc3mzzMjxr1ITeFzsRpc7p+AcUoKcOJ+r
 frMlnhFoPKCeNR/Qy4D86CVyDRkb9Ef3trEt9M80C/TDYPvo1CmIlHdUn6yWJ0mbnXECFw/W3
 NZrajTAUksvm+01tjRD598EA1c7VdlGLEFfKbKOFpwAXfQoDaXeCEozrZnjNx504b+wFsifan
 ZzfkLmo14QIQ9gdL2dmmuQQFFY2Hs8MvdDFqlpA6QlRXWAH9ocd/xJwJD2thcNzSjPfU+UwI/
 65XG039c8FMFHqu4sDAmsyslkDyoQMgl3iHSX6j1lQgmhlliqorF0hFNxkK9wg+bFvXUtt51O
 YzWmD1i8gJyX4FmFQcneBixJd2s6Vxz1PfCmXWOfrpG3+ZSQ/wkvdQVFgbjr/3Txqwy35LaGN
 HlNvLx0Q4gF7WxGYiJ+g4n/kGpOtq/37yiApHUybPyLVcf+56y4QM6zVTtK9g9nIs+ByG8uj/
 WqiriDR9wyDsPE6aC1U49S1OiK8XSapxF4WZ69tlyeeGUjqSvlqkfZhn1jdRxyNTiiWRbiCa8
 fi/oarLdJpWkoV2yG4hwaN5Hx4RPg0TGRDmd+Ly5aREJ+WZlK+s9MqONyDb5kTX6idNkWmbIe
 g+LtNVt2KnOfy82glLxictpc3VZaupevCkCbcO//5edhmjF6I8pFjr+PLW339l4PFYYprdJRq
 HFqlo59Sf6P+cjKaM57re2OOOVKtdxQGQ/4WV5+1K4mxtrsAc9zHrWBHv1gFn2BM3ZDKFTQjk
 wO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9xJEXvQYjrIFoz46bZaJFkrq
Content-Type: multipart/mixed; boundary="------------LXhzwqtZwp5UzGfV43egS0Yh";
 protected-headers="v1"
From: ZeroBeat <ZeroBeat@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Message-ID: <f68e8ae0-e4c5-4a10-8b5f-f9ab3bc55068@gmx.de>
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
In-Reply-To: <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>

--------------LXhzwqtZwp5UzGfV43egS0Yh
Content-Type: multipart/mixed; boundary="------------Wy0zd1CIZzO5dU7tJCjX2KOy"

--------------Wy0zd1CIZzO5dU7tJCjX2KOy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T2suIFBsZWFzZSBnaXZlIG1lIGF3aGlsZSB0byB1bmRlcnN0YW5kIHRoZSBlbnRpcmUgcHJv
Y2VkdXJlDQpob3cgdG8gZG8gdGhhdCBpbiB0aGUgcHJlZmVycmVkIHdheS4NCg0KDQoNCkFt
IDA3LjEyLjIzIHVtIDA5OjUyIHNjaHJpZWIgUGluZy1LZSBTaGloOg0KPiANCj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBaZXJvQmVhdCA8WmVyb0JlYXRAZ214
LmRlPg0KPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgNDo0NiBQTQ0KPj4g
VG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPj4gQ2M6IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVzLlNvcmVuc2VuQGdtYWlsLmNvbQ0KPj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gd2lmaXdpZmk6IFJlYWx0ZWs6IHJ0bDh4eHh1IEFkZCBuZXcg
ZGV2aWNlIElEDQo+Pg0KPj4gQmV0dGVyIG5vdz8NCj4+DQo+IA0KPiBZb3VyIHBhdGNoIGlz
bid0IG11Y2ggbGlrZSBvdGhlcnMuIFBsZWFzZSBjaGVjayBwYXRjaGVzIFsxXSBtYWRlIGJ5
IG90aGVycy4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJl
bGVzcy8NCj4gDQo+IA0K
--------------Wy0zd1CIZzO5dU7tJCjX2KOy
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

--------------Wy0zd1CIZzO5dU7tJCjX2KOy--

--------------LXhzwqtZwp5UzGfV43egS0Yh--

--------------9xJEXvQYjrIFoz46bZaJFkrq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEWSDOHFZ5SK/SwKm3N1UWpF24hjAFAmVxiiEFAwAAAAAACgkQN1UWpF24hjAG
Hwf8D11ks4PZOsImi+xnqleswxyrBV61wSqKzR79aA0DIWVyBilflgZveqLHhevZGkKfdb6338bQ
iq/C/56j9UAAX6P08Mih0xTJVW2DF9JDf82RUhYPJpoGpDbPK9tx1uBidp6v1eSCIyb1ubkr71GP
4WjP/uI94kndttfpAQG/5M2NxbhcUFO4HbzL3afxdroOxY+rbrqysIytwhTN6xP/ezMipgEtvWTk
aWOte9HU2H+QR6AcwGss/CBt0an97QeT4FbuCsOZdwUH/GDrUo6mfbUZbD8dubRF5nTxTwk1rD6j
CtdAvofmL1fEvUgQ8PCeN9QoR7dO6NZ9OOweoHWSNQ==
=Xgjy
-----END PGP SIGNATURE-----

--------------9xJEXvQYjrIFoz46bZaJFkrq--

