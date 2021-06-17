Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087753AB538
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhFQNyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 09:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231299AbhFQNyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 09:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623937950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8y98L/La9x4KilFgUirdLHSyWfxKWG7oJ+i1N0Sw+rE=;
        b=N/OLcEAuvQwCNv7KsGQlVbdd5lmroENjooplUzTLR7fr/ZAbu+T7G+cebgSFo1vYxE797Y
        K7nyQnqNGYPejOgstLVOi26Q5w4wBofaqTd1sMU9uYu1KhPupZW6hwYXMDJ+iZ/Da7RjVu
        wp1yIzGaeVQ86icZ0sudBH1aQbe7VFw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-ZT4q3pdNNpWCvYyw3qSHUQ-1; Thu, 17 Jun 2021 09:52:26 -0400
X-MC-Unique: ZT4q3pdNNpWCvYyw3qSHUQ-1
Received: by mail-ed1-f72.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so1569176edb.9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8y98L/La9x4KilFgUirdLHSyWfxKWG7oJ+i1N0Sw+rE=;
        b=cTsUW3pXLJXlXl4UeibzSiOP+VT6y9aWs1G7G0TJ1LW1gZpXJ0DXaqiqzRG+JhaPCj
         rhLHSBUwZ5UyASm2NhbX8ygpozZSpgO0/nlYJCwDrEH6N4dFXU31mpr67sibCwa2Slct
         /RGZ9nPaWvvX9AVBAJRHBmA3VlrKlmQXPEE7P6s0JrlNYMlRy8KDD55QfD4J5/Bt7zdc
         7HblANBc3l+UpryvSsxgVHWJ4mGRd7QMlPMWIaOPt6EgPuFsO/ynBsvHLAzcTXs1yX0A
         aW+lLcmy0PoS8OVJ2bvjvMnkU57fljW3FL4sfU106uFsyNcSZad1i/GyDWJLbfHsKg55
         JDEQ==
X-Gm-Message-State: AOAM533LfkdEWHI6I8XLQHlh4QKiWNN9oND2zLZpG2p0PprCUbUf3oCA
        WyFsTtADFi0obFbDqi8ZTtw8XV3ZxPRcobEvRlM3QzheGCcPYBDghCMgxkffQqnHpgrQ4nxtjUa
        gf+OTRrFng8221+3CYL8aqMNx3Oo=
X-Received: by 2002:a17:906:ac4:: with SMTP id z4mr5401312ejf.303.1623937945424;
        Thu, 17 Jun 2021 06:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVnvDt8sJxsVa0fDP6Dfi05+2CsBlMMecSDxuktxQNzHRmcOB6hhGTbOV8xxEslBGQUip1PQ==
X-Received: by 2002:a17:906:ac4:: with SMTP id z4mr5401288ejf.303.1623937945287;
        Thu, 17 Jun 2021 06:52:25 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id i15sm3849945ejk.30.2021.06.17.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 06:52:24 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:52:21 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: fix the coredump is being truncated
Message-ID: <YMtTlS3Nh4uGnJvq@lore-desk>
References: <2ebb95099102ffe62c0fa8aedd95d7e77b5ca385.1623884856.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/rucmuLPAqyrwX+6"
Content-Disposition: inline
In-Reply-To: <2ebb95099102ffe62c0fa8aedd95d7e77b5ca385.1623884856.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--/rucmuLPAqyrwX+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix the maximum size of the coredump generated with current mt7921
> firmware. Otherwise, a truncated coredump would be reported to userland
> via dev_coredumpv.
>=20
> Also, there is an additional error handling enhanced in the patch to avoid
> the possible invalid buffer access when the system failed to create the
> buffer to hold the coredump.
>=20
> Fixes: 0da3c795d07b ("mt76: mt7921: add coredump support")
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 9b3f8d22f17e..d93ab1ece8ae 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -13,7 +13,7 @@
>  #define MT76_CONNAC_MAX_SCAN_MATCH		16
> =20
>  #define MT76_CONNAC_COREDUMP_TIMEOUT		(HZ / 20)
> -#define MT76_CONNAC_COREDUMP_SZ			(128 * 1024)
> +#define MT76_CONNAC_COREDUMP_SZ			(1300 * 1024)
> =20
>  enum {
>  	CMD_CBW_20MHZ =3D IEEE80211_STA_RX_BW_20,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index fb4de73df701..905dddbfbb0b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1557,7 +1557,7 @@ void mt7921_coredump_work(struct work_struct *work)
>  			break;
> =20
>  		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
> -		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
> +		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {

why not just return if dump allocation fails? Doing so we will reset the de=
vice
even if dump is NULL, do you think it is a real use-case?

Regards,
Lorenzo

>  			dev_kfree_skb(skb);
>  			continue;
>  		}
> @@ -1567,7 +1567,10 @@ void mt7921_coredump_work(struct work_struct *work)
> =20
>  		dev_kfree_skb(skb);
>  	}
> -	dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
> -		      GFP_KERNEL);
> +
> +	if (dump)
> +		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
> +			      GFP_KERNEL);
> +
>  	mt7921_reset(&dev->mt76);
>  }
> --=20
> 2.25.1
>=20

--/rucmuLPAqyrwX+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYMtTkgAKCRA6cBh0uS2t
rIHjAQCqNVvge4z+NsfUu91P1Cey8w++PXYbKlGOEW8i9n++kgEAjU5Q6TPVUx/n
1Wzjj3kkXpDbJSvZuKl+IZJbOnRKzwo=
=rDOE
-----END PGP SIGNATURE-----

--/rucmuLPAqyrwX+6--

