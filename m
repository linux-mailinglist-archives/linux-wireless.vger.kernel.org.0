Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BEB2CA0C8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgLALBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 06:01:24 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:32980 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgLALBY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 06:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1606820442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jABW0WRckyyOQxJVHxldJSJ3qQ5Xtm/TtiSO8p6ao4o=;
        b=m5EjMGWy01G8oHNHQldWlB7K3DcSregc3lVob5Nwj2HoxiAAv2Nj518a6y4JRa4sUv16RC
        DOvekJQ3qs8RmoTozr+tBoGo+0fk17HM92Y3B2X+rHlrnGJlq5eOeAkF+W+2p3RBb/Ec39
        oc7/luLs6PhF4XXdaVn7AX+lTsITR5c=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: ath10k: Missing airtime scheduler parts
Date:   Tue, 01 Dec 2020 12:00:35 +0100
Message-ID: <3078279.oiGErgHkdL@ripper>
In-Reply-To: <87a6uxx092.fsf@toke.dk>
References: <2631481.BEx9A2HvPv@ripper> <87a6uxx092.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6209904.G0QQBjFxQf"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6209904.G0QQBjFxQf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: linux-wireless@vger.kernel.org, Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@redhat.com>
Cc: ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: ath10k: Missing airtime scheduler parts
Date: Tue, 01 Dec 2020 12:00:35 +0100
Message-ID: <3078279.oiGErgHkdL@ripper>
In-Reply-To: <87a6uxx092.fsf@toke.dk>
References: <2631481.BEx9A2HvPv@ripper> <87a6uxx092.fsf@toke.dk>

Hi,

thanks for the reply. I will forward the information.

On Tuesday, 1 December 2020 11:56:57 CET Toke H=F8iland-J=F8rgensen wrote:
> I did recently rebase that patch to the current mac80211-next, actually.
> Sent it off to Felix for some testing, but if you wan to give it a go I
> can post it to the list as well=20

Thank you for the offer. But I doubt that I will find time for it before ne=
xt=20
year.

Kind regards,
	Sven
--nextPart6209904.G0QQBjFxQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl/GIlMACgkQXYcKB8Em
e0a5/A/+N77S12qcvEHA0Y615C9Kw6qOIjvjnlqG72OUGj/yDLtCU9O1uKsxXVZo
nkknjHDDjv3Nkc3rMDZ/SX/v/AutpHBGxQh8cw2ig0zQheZqAn3PrS+kPINs70m+
pQ7i0DG1tUfB3pbJgrV9GEMGc2LjnbLTfv1+AOXkihaUgcDx2Njq7Az8qL9SwKiS
FErNhFoMnSWuQSJn1/0GyempvNggT8jbEGs137KluXp1mFYmZiItrPXCXZ91b2PB
ClpQIslNHYmxifDE06TnPlnSRgHmUC42d0h4FdUqtX1HjwuLMR3Kg25TnXPTzkB1
3tucqkv/7BiTLbRINNhN3h9/rkyCoffsESEGavpGAAAT5jRtEyz3C0f4dlyCoj2Y
NiHIReLsuWALlNULyq/ZrwjA1XwDG02LPAd8NAqSj5gdKUaYCEgMiDalu+1rby4K
38trRnsFFGIRfCIje1vlx7yk3JxRbc8X241c/Mvn8Jvm79IMVpDFJk5pn/ZkL8tr
YWkNd8ZgwvJoyDFjOtSNShHIv0T3vsp6VpqEHJaSY7wUi4fq4YquyJzHskzyR71U
IFRBXTaK0rHFjYkH8vrfAsl/oBk88z86BZY/zL65tGjwh1gCslSmkhDrM2kyfT0f
6+LcVF23pgFe1AVRX4qbTlaos2qi+LKf1PqyMZoBvPC0/9+rNRU=
=HmUU
-----END PGP SIGNATURE-----

--nextPart6209904.G0QQBjFxQf--



