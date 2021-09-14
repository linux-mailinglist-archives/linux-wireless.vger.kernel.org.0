Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D21240B6C6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhINSZR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhINSZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 14:25:14 -0400
Received: from mout0.freenet.de (mout0.freenet.de [IPv6:2001:748:100:40::2:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B772C061764
        for <linux-wireless@vger.kernel.org>; Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
Received: from [195.4.92.119] (helo=sub0.freenet.de)
        by mout0.freenet.de with esmtpa (ID andreas.tepe@debitel.net) (port 25) (Exim 4.92 #3)
        id 1mQD60-0003oy-Er; Tue, 14 Sep 2021 20:23:52 +0200
Received: from p200300dd2f146d00dacb8afffe3dcff0.dip0.t-ipconnect.de ([2003:dd:2f14:6d00:dacb:8aff:fe3d:cff0]:49808)
        by sub0.freenet.de with esmtpsa (ID andreas.tepe@debitel.net) (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (port 465) (Exim 4.92 #3)
        id 1mQD60-0008P1-BM; Tue, 14 Sep 2021 20:23:52 +0200
Subject: Re: Patch for Atheros QCA6174
To:     Peter Oh <peter.oh@eero.com>, linux-wireless@vger.kernel.org
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
 <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
From:   Andreas Tepe <andreas.tepe@debitel.net>
Message-ID: <eea98052-4630-c058-22d4-36329d3c5721@debitel.net>
Date:   Tue, 14 Sep 2021 20:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sP1yy8XhVyMhSvtscWNPC9XL3itKbSDOL"
X-Originated-At: 2003:dd:2f14:6d00:dacb:8aff:fe3d:cff0!49808
X-FNSign: v=2 s=6CE044112E6307E883C9173D32CFCABD2F83CE6731357ACEC3A75B99E7FF69F7
X-Scan-TS: Tue, 14 Sep 2021 20:23:52 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sP1yy8XhVyMhSvtscWNPC9XL3itKbSDOL
Content-Type: multipart/mixed; boundary="oJDWJzBrFMlNc48eDSQy2Q6n9BRpLxbMA";
 protected-headers="v1"
From: Andreas Tepe <andreas.tepe@debitel.net>
To: Peter Oh <peter.oh@eero.com>, linux-wireless@vger.kernel.org
Message-ID: <eea98052-4630-c058-22d4-36329d3c5721@debitel.net>
Subject: Re: Patch for Atheros QCA6174
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
 <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
In-Reply-To: <839a16ab-7535-c719-2be7-10100c84a738@eero.com>

--oJDWJzBrFMlNc48eDSQy2Q6n9BRpLxbMA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Peter,

thanks for the information and the very quick answer!

When I saw that in the patch, I had the same question, but it still
worked. I have to admit that I copied it without knowing why it works.

Who defines the codes? Is it possible to set it to CTRY_KOREA_ROC4 which
is not in use yet? In that case drivers/net/wireless/ath/regd.h also
would need an additional entry line after row 128

CTRY_KOREA_ROC4 =3D 413,

413 apparently is not in use yet.

Cheers,
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


--oJDWJzBrFMlNc48eDSQy2Q6n9BRpLxbMA--

--sP1yy8XhVyMhSvtscWNPC9XL3itKbSDOL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEvcFuJkAJt57KoGjB0LMkQvxvVJcFAmFA6LcFAwAAAAAACgkQ0LMkQvxvVJe6
4xAAtKcxiBlrQw8JkNuN1dMuEd3UJvbrvjEhhunjDols1k3rtQja8JOxaR32tw+xCOH5WymB9Nqk
mriHjhXH3EZO1ZXyyo2ZevgK4DFxoJFKuITyzWbK1O7P/Ev0HmzazD5eYBY111AVKMwhJcqXg5hi
KdQxfjfb027pO09dR1PvgK8PasFOabby00RxLkMoUjG1MuWl3VOKSu9QAaRbhPCJ5ORGwxiQ9LLn
8M+9nMms5BBzFmVtLWUcTLF9G6P0EzB2iOe8sBWvavxWJJmb3rlRCJ+aFIt1fSDZr/A5z8LQ3nA/
i0dt0odu3maNNj+9fKF2r/jUYkmGa3ebk1LcnMUHK3Oaiqd50MEEYFAabWSM+XKuE0+5nhROWrtT
BDntOe0XES+2ZHjGOpKKEYC76oMdEJjncI7TzGFbhK2D8zekzb6miLmBvKzN3AiOLQm4EKWSxEJP
dwdASL3SUPlWUxgYPSig40NOp3AEu8JGpZY/ns01YsB1sBKxDpFCwaU5o4EQfUrLD5Dvuq7aDP1p
9DKP0ySpWc7lfCNZOzLsEX4oXdIxW+dn4g2BS9xyL2GAFYG6DC/VGEniHr/GrYqphgebvo2RfJTN
RoRblh1k5t83xOFDcdNFQUPv2x0ArK1JAtoVelvJoT/3jseqI3Oy10rFhdR/ovGY8YYqpJc0OBoA
s6E=
=LACU
-----END PGP SIGNATURE-----

--sP1yy8XhVyMhSvtscWNPC9XL3itKbSDOL--
