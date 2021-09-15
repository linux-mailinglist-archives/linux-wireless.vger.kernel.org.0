Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C040C99C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhIOQCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhIOQB5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 12:01:57 -0400
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CFAC0613C1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 09:00:24 -0700 (PDT)
Received: from [195.4.92.121] (helo=sub2.freenet.de)
        by mout1.freenet.de with esmtpa (ID andreas.tepe@debitel.net) (port 25) (Exim 4.92 #3)
        id 1mQXKh-000804-Bq; Wed, 15 Sep 2021 18:00:23 +0200
Received: from p200300dd2f12cd00dacb8afffe3dcff0.dip0.t-ipconnect.de ([2003:dd:2f12:cd00:dacb:8aff:fe3d:cff0]:42916)
        by sub2.freenet.de with esmtpsa (ID andreas.tepe@debitel.net) (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (port 465) (Exim 4.92 #3)
        id 1mQXKh-0003oN-8y; Wed, 15 Sep 2021 18:00:23 +0200
Subject: Re: Patch for Atheros QCA6174
To:     Peter Oh <peter.oh@eero.com>, linux-wireless@vger.kernel.org
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
 <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
From:   Andreas Tepe <andreas.tepe@debitel.net>
Message-ID: <520a5f75-44bb-94b9-d67b-3fe42cdec044@debitel.net>
Date:   Wed, 15 Sep 2021 18:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EkrhwH3AEBhHdOFRGmOFhwNTpuc30zOM7"
X-Originated-At: 2003:dd:2f12:cd00:dacb:8aff:fe3d:cff0!42916
X-FNSign: v=2 s=ACC08A8CAA33BC72CF24683A9A1E2E75E22927157B1CE1D3D2A8D0C97869CDC3
X-Scan-TS: Wed, 15 Sep 2021 18:00:23 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkrhwH3AEBhHdOFRGmOFhwNTpuc30zOM7
Content-Type: multipart/mixed; boundary="3AAuioVg0KBjEk4dOBR8fX0avC8xtibse";
 protected-headers="v1"
From: Andreas Tepe <andreas.tepe@debitel.net>
To: Peter Oh <peter.oh@eero.com>, linux-wireless@vger.kernel.org
Message-ID: <520a5f75-44bb-94b9-d67b-3fe42cdec044@debitel.net>
Subject: Re: Patch for Atheros QCA6174
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
 <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
In-Reply-To: <839a16ab-7535-c719-2be7-10100c84a738@eero.com>

--3AAuioVg0KBjEk4dOBR8fX0avC8xtibse
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello Peter,

here the patches for kernel linux-5.15-rc1:

diff --git a/linux-5.15-rc1/drivers/net/wireless/ath/regd_common.h~
b/linux-5.15-rc1/drivers/net/wireless/ath/regd_common.h
index c4bd26e..cdb1e9a 100644
--- a/linux-5.15-rc1/drivers/net/wireless/ath/regd_common.h~
+++ b/linux-5.15-rc1/drivers/net/wireless/ath/regd_common.h
@@ -76,6 +76,7 @@ enum EnumRd {
        APL7_FCCA =3D 0x5C,
        APL8_WORLD =3D 0x5D,
        APL9_WORLD =3D 0x5E,
+       APL10_WORLD =3D 0x5F,

        WOR0_WORLD =3D 0x60,
        WOR1_WORLD =3D 0x61,
@@ -204,6 +205,7 @@ static struct reg_dmn_pair_mapping regDomainPairs[] =3D=
 {
        {APL6_WORLD, CTL_ETSI, CTL_ETSI},
        {APL8_WORLD, CTL_ETSI, CTL_ETSI},
        {APL9_WORLD, CTL_ETSI, CTL_ETSI},
+       {APL10_WORLD, CTL_ETSI, CTL_ETSI},

        {APL3_FCCA, CTL_FCC, CTL_FCC},
        {APL7_FCCA, CTL_FCC, CTL_FCC},
@@ -426,6 +428,7 @@ static struct country_code_to_enum_rd allCountries[] =
=3D {
        {CTRY_KOREA_ROC, APL9_WORLD, "KR"},
        {CTRY_KOREA_ROC2, APL2_WORLD, "K2"},
        {CTRY_KOREA_ROC3, APL9_WORLD, "K3"},
+       {CTRY_KOREA_ROC4, APL10_WORLD, "K4"},
        {CTRY_KUWAIT, ETSI3_WORLD, "KW"},
        {CTRY_LATVIA, ETSI1_WORLD, "LV"},
        {CTRY_LEBANON, NULL1_WORLD, "LB"},


diff --git a/linux-5.15-rc1/drivers/net/wireless/ath/regd.h~
b/linux-5.15-rc1/drivers/net/wireless/ath/regd.h
index 8d5a16b..774419c 100644
--- a/linux-5.15-rc1/drivers/net/wireless/ath/regd.h~
+++ b/linux-5.15-rc1/drivers/net/wireless/ath/regd.h
@@ -126,6 +126,7 @@ enum CountryCode {
        CTRY_KOREA_ROC =3D 410,
        CTRY_KOREA_ROC2 =3D 411,
        CTRY_KOREA_ROC3 =3D 412,
+       CTRY_KOREA_ROC4 =3D 413,
        CTRY_KUWAIT =3D 414,
        CTRY_LATVIA =3D 428,
        CTRY_LEBANON =3D 422,


Kind regards,
Andreas


Am 14.09.21 um 20:07 schrieb Peter Oh:
>=20
> On 9/14/21 9:59 AM, Andreas Tepe wrote:
>> @@ -426,6 +428,7 @@ static struct country_code_to_enum_rd
>> allCountries[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_KOREA_ROC, APL9=
_WORLD, "KR"},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_KOREA_ROC2, APL=
2_WORLD, "K2"},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_KOREA_ROC3, APL=
9_WORLD, "K3"},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_KOREA_ROC, APL10_WORLD, "K=
R"},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_KUWAIT, ETSI3_W=
ORLD, "KW"},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_LATVIA, ETSI1_W=
ORLD, "LV"},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {CTRY_LEBANON, NULL1_=
WORLD, "LB"},
>=20
> The same country number CTRY_KOREA_ROC(410) cannot be used for differen=
t
> regDomainPairs.
>=20
>=20
> Thanks,
>=20
> Peter
>=20


--3AAuioVg0KBjEk4dOBR8fX0avC8xtibse--

--EkrhwH3AEBhHdOFRGmOFhwNTpuc30zOM7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEvcFuJkAJt57KoGjB0LMkQvxvVJcFAmFCGJYFAwAAAAAACgkQ0LMkQvxvVJds
sg/9EsMFlVgNwYnRTBIewDYPXKGWohZeabkzs9nAi9kgdWimLZXD7swIljh7nSjvjPoCI+yr/ul2
fbdIqLn8j7vu1FoPnglR0QAYxkBd6sqaHS42YYxKmeC5nY+XB/IUfx6TVcawZKwmAg2Z359u0cfG
VGi5lLTY4ukHB1A7w8riBRJ8rgydarGeWql9OuLK3/Dgi6+GDvi6J3MarONkZnZqOGI1Ze/1L4h1
uUuzf5D2yOTLDYRhLs6fkhaahbb+tZuQGSEFwiFnTrVjxX+p7LgdgUIYUGhNKhx0DqcUk+fWf0Qe
ECQVp9LqMd+aErnKgnUwX7VpdT5Yi1fQ+lG6OVKCE1eQ8HkI4OCHgLt8RRmStq+uUBt35C3t19zW
xi04e8RChQEfUbstIRJqY0MZhW4rzZuAA2C6qSGkloVQShbZjikZpnNABv9Rwd2K9mT4QPHhz3HN
nierBW83m245pmI6YIl0Zar49zLdu8Jmxxbd8FEGlz6rDe4QMjm4prGrLfVfxnZ7VzVZlDh1EMEu
FAn0U7cKVqM+eDHKPdctWm1uNKL6c8vYoZMpLep8K9UFlYiV7mHY4LRmcOzwWzsBpBMyp4SLo6xy
9060dS8EiTw4ASs8A7MWxd2N8sD1FCWgq+D1bBJscAWVSfBk7fkcJ6Ymk0OGeVcLjYTAmdlCXsk3
GAo=
=usDs
-----END PGP SIGNATURE-----

--EkrhwH3AEBhHdOFRGmOFhwNTpuc30zOM7--
