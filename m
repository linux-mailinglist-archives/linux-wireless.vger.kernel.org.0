Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C259396592
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhEaQky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 12:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhEaQis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 12:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622479027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRiaPq4HrVEZoadvbfaVcc8TG6Dzr80c9q09+g6SHSA=;
        b=L6Fi/6LGGH7MUWALex2NjJ8rvWPz9wPf7uGPawiNJDwoiZiRbYUhk4WVfiWbw7SH0kNDn3
        zji1xghW8Cg5g8GSlHqrelcMEhq+CwfIZJs1Q15ZPrdustPKuRSHUXOhWIVapeIae/kUfM
        Hyh5TJ046PqBrfxTGtGSToCMLTqsM8s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-8CYJobbbNZi0AM7KAIufnA-1; Mon, 31 May 2021 12:37:06 -0400
X-MC-Unique: 8CYJobbbNZi0AM7KAIufnA-1
Received: by mail-ej1-f70.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso2595522ejc.7
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 09:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRiaPq4HrVEZoadvbfaVcc8TG6Dzr80c9q09+g6SHSA=;
        b=lEZsnJ0vTKkhwiXEvnCxVMi7A9rmzO23S8KkIeDwhxlerctFWZpZYCW7aYzh9Q8Z31
         9pngKoQMmNnKeXnynxHPpFZOZuXoEOB0igyNfxydiAsKZzT+gc8wdklGEMxx0YD5aT22
         xWMExtT8PEBcBGIfU2uthyb2EtkfRr03qHqFuvzEN4psHjF2yGgkZcEhj0WuHqvvHKVz
         Y6kIqVB8JOVtAkBnJGITn3xP93M5nzf/6TBHVGEqPxVoCmGhQ7K2fGrGZRmUKspbtvzJ
         c+37v3CNsiBBmT8eeppNA2ZbP6EAnK9uBgebTTXWUrnZ9Qw8VZ12R63TBVJDSv6ROuhZ
         WoaQ==
X-Gm-Message-State: AOAM531A1JBWG43GstdomSosVcDQ0QtBXstgCstiY54isyIxXeMsBcGt
        +N0EbxHn1DVF5enTJklJQDsZhrmCuWZxOWgsl5BUOfnH5YDQ4GcPjGIhsBbJ1lvkUD0ByJzBGI/
        qhwvRnCPCfXLYO3LmZBazHCbaXDw=
X-Received: by 2002:aa7:d294:: with SMTP id w20mr11467886edq.229.1622479020663;
        Mon, 31 May 2021 09:37:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvS/6Ym1pqZPPg1Kkro2Oc+uWf6FJ0dXo00/t+ZtJRpvh+39HKAPQXNBnjmjSnrJqTC6GEeQ==
X-Received: by 2002:aa7:d294:: with SMTP id w20mr11467860edq.229.1622479020456;
        Mon, 31 May 2021 09:37:00 -0700 (PDT)
Received: from localhost (net-93-71-117-34.cust.vodafonedsl.it. [93.71.117.34])
        by smtp.gmail.com with ESMTPSA id c26sm7157400edu.42.2021.05.31.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:36:59 -0700 (PDT)
Date:   Mon, 31 May 2021 18:36:56 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, jemele@google.com,
        yenlinlai@google.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: enable random mac address during sched_scan
Message-ID: <YLUQqIqbojUNRZVA@lore-desk>
References: <14360a28083d56520a2cabc87841d9dee3d97a01.1622476643.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/UgLne4xHOsvro2G"
Content-Disposition: inline
In-Reply-To: <14360a28083d56520a2cabc87841d9dee3d97a01.1622476643.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--/UgLne4xHOsvro2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Enable src address randomization during scheduled scanning
>=20
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>

Here we are missing my SoB, it should be:

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   | 14 ++++++++------
>  .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  4 +++-
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c   |  3 ++-
>  3 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 73359defa176..b155e7b8d89d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1515,14 +1515,16 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_ph=
y *phy,
>  	req->version =3D 1;
>  	req->seq_num =3D mvif->scan_seq_num | ext_phy << 7;
> =20
> -	if (is_mt7663(phy->dev) &&
> -	    (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)) {
> -		get_random_mask_addr(req->mt7663.random_mac, sreq->mac_addr,
> -				     sreq->mac_addr_mask);
> +	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
> +		u8 *addr =3D is_mt7663(phy->dev) ? req->mt7663.random_mac
> +					       : req->mt7921.random_mac;
> +
>  		req->scan_func =3D 1;
> -	} else if (is_mt7921(phy->dev)) {
> -		req->mt7921.bss_idx =3D mvif->idx;
> +		get_random_mask_addr(addr, sreq->mac_addr,
> +				     sreq->mac_addr_mask);
>  	}
> +	if (is_mt7921(phy->dev))
> +		req->mt7921.bss_idx =3D mvif->idx;
> =20
>  	req->ssids_num =3D sreq->n_ssids;
>  	for (i =3D 0; i < req->ssids_num; i++) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index d64b8058b744..3076417ead5f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -779,7 +779,9 @@ struct mt76_connac_sched_scan_req {
>  		} mt7663;
>  		struct {
>  			u8 bss_idx;
> -			u8 pad2[63];
> +			u8 pad2[19];
> +			u8 random_mac[ETH_ALEN];
> +			u8 pad3[38];
>  		} mt7921;
>  	};
>  } __packed;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 59da29032645..19ce9ca72542 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -76,7 +76,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
>  	wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>  	wiphy->reg_notifier =3D mt7921_regd_notifier;
> =20
> -	wiphy->features |=3D NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
> +	wiphy->features |=3D NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
> +			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
> =20
>  	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
> --=20
> 2.18.0
>=20

--/UgLne4xHOsvro2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLUQowAKCRA6cBh0uS2t
rOwXAP9J1ny4dm2+BniqHq6bBBulK4VdbKtFPJKhnCp002GyrgD/U2sfaKpHQBFy
cE3lFXkvdUPo8gi9E+OFBQEuM7vH2g0=
=1H2n
-----END PGP SIGNATURE-----

--/UgLne4xHOsvro2G--

