Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D6B9144
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfITN6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 09:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfITN6X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 09:58:23 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAA574ACA5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 13:58:22 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 190so1261410wme.4
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 06:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spCZuDFD0EPU5ozujvfnvvEa34kbUMxIApAez+Dggu8=;
        b=e1CKtjA+gIwKrRqEQHsqdxM9+2EaKJMQ3Yx/Tt0nvgMXl9JRYoWDIZYk4kAVF4BWSN
         KzbC39EAZUNOSwMWPaw9Za6wL+JPnz0UL6o29ORPjbsmBoRl0qD04Bc9CD5+gk7cjlpD
         r45kBb9yg63NkMMOGars/fQmSxamnhZv+bX6skg3zD+t/GNn3wGTdr71ICZUR/UIWvLO
         8tVUdRSVwpYYgdeWQHqIsN+qEu4q5N8PoCg76TAWHWsByqEqfDkPwy32UnfmCovec5pr
         z/W1Q/X2UpNWDtyBlZ3pmOB7X0Boey8+jal/4qP+/5R3w4HyBHii1PC7mYFKl4OBgXwD
         SvAw==
X-Gm-Message-State: APjAAAXxWMbka0p1SiXPLFWwJinjt902/Jfwx4FG9goLoAaQlG7wTYSx
        /uWu7k4lPdDbch9XmbkteprHJjNHskTWwB4SfANtS37QvCJqGFqDEmR8FTAw6HLuH+gZL1cZWE5
        Ir2ClOYwBcF3oCAp1rJRtx2lXBnk=
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr3641700wmj.162.1568987901451;
        Fri, 20 Sep 2019 06:58:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaL42VK6Hbg90QmZTlVy0wuDzSPLddZwEiO+ZOepAYrKU0ro0hZ5/EONlchkImHxvmp3T81A==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr3641679wmj.162.1568987901220;
        Fri, 20 Sep 2019 06:58:21 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id r6sm1834884wmh.38.2019.09.20.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:58:20 -0700 (PDT)
Date:   Fri, 20 Sep 2019 15:58:17 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jakub Kicinski <kubakici@wp.pl>, Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt7601u: phy: simplify zero check on val
Message-ID: <20190920135817.GC6456@localhost.localdomain>
References: <20190920125414.15507-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20190920125414.15507-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the zero check on val to break out of a loop
> is a little obscure.  Replace the val is zero and break check
> with a loop while value is non-zero.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wireless/mediatek/mt7601u/phy.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wi=
reless/mediatek/mt7601u/phy.c
> index 06f5702ab4bd..4e0e473caae1 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/phy.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
> @@ -213,9 +213,7 @@ int mt7601u_wait_bbp_ready(struct mt7601u_dev *dev)
> =20
>  	do {
>  		val =3D mt7601u_bbp_rr(dev, MT_BBP_REG_VERSION);
> -		if (val && ~val)
> -			break;

I think this is not correct since (not considering the cast) we should break
=66rom the loop if val !=3D 0 and val !=3D 0xff, so the right approach I gu=
ess is:

diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wire=
less/mediatek/mt7601u/phy.c
index 06f5702ab4bd..d863ab4a66c9 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -213,7 +213,7 @@ int mt7601u_wait_bbp_ready(struct mt7601u_dev *dev)
=20
 	do {
 		val =3D mt7601u_bbp_rr(dev, MT_BBP_REG_VERSION);
-		if (val && ~val)
+		if (val && val !=3D 0xff)
 			break;
 	} while (--i);

> -	} while (--i);
> +	} while (val && --i);
> =20
>  	if (!i) {
>  		dev_err(dev->dev, "Error: BBP is not ready\n");
> --=20
> 2.20.1
>=20

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYTa9wAKCRA6cBh0uS2t
rETyAP42WJmgG0YWFN4dtvNtHUZL2FS46W+Tt/OXQTdrQfEfYQEA6DLVOjMTQzuG
hmE5irsv5UEh9sDb73OcIUNJYu7aPAg=
=LFi7
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
