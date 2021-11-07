Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD8447293
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Nov 2021 11:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhKGKry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Nov 2021 05:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhKGKry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Nov 2021 05:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636281911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RE6EFAuJXOYv4UHVe2iYkIAN9i0e/KfF1f5Ap0JKFL4=;
        b=UYaLUHaNDdXhr4pqdamEf9F4Bl92sOqb8m+eTFPxZs+RuBQCwTtIGPb00hUlk9tXLta6jK
        Q0GNEbI8qAX7WPYEt6Vyfn76MTgbZYPfKNZNH6vLq8iHRkkKrc7WUijA6dZYgWYqRMFMKV
        NQk9avgpmT/1uolURogw7H20KkN1VZ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-7du913Y1OkeTmNUp8c_m9w-1; Sun, 07 Nov 2021 05:45:10 -0500
X-MC-Unique: 7du913Y1OkeTmNUp8c_m9w-1
Received: by mail-ed1-f72.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso12561221edj.13
        for <linux-wireless@vger.kernel.org>; Sun, 07 Nov 2021 02:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RE6EFAuJXOYv4UHVe2iYkIAN9i0e/KfF1f5Ap0JKFL4=;
        b=2GEFxxZp3UHHzd9uc0wkRZBcHAcULZ3jQw3+E62evLWKunFZLPk5A/1nV6GQ6Gf5Yd
         sWXIZJw/aG1fP0BKoe//VK9+VlQjFV68tvYG02XyfC0a5cnreslTSy63tWpNI+uPw2q+
         8g29irje0Vui2XXZRHNfXNo/T4BERXFLGO/Ao/mSs2xHQgwD3YRZZl6cZ8jTUVXMYRW9
         cukRO9+NEjc/fRNiTtUjDwIS+KADUWFM1U7rz7D76g763YkreZmd5Fj8dVvaYa6EgvQJ
         qzykBTKLhvK4vOflfham7I+qTh/Smopi9Kml73fzi4jEP0wG3SghgpRoueVIhLn+67pg
         lvCA==
X-Gm-Message-State: AOAM530oNi6bM6o5nvA0BeRgwjM1E+4cJEmlw3JWQrecEEbDFqcVK2lN
        hX0pWLJNjWqH+xScnB58agSGkrDaDrzuYb7q8MeRjbSQjr9TTyTFcbC/MTE6uclglxzhaKAL+d5
        GfMhV8orNuF6cgNatJ9M6Tj+1mVA=
X-Received: by 2002:aa7:cd8a:: with SMTP id x10mr52255672edv.3.1636281909173;
        Sun, 07 Nov 2021 02:45:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4V9qqqwMnFSOOA4xPXMVq94YF5bwuZX+sW66L0U8om9LRXvWMJN5vnyhSCrVbIrMDGVTq+w==
X-Received: by 2002:aa7:cd8a:: with SMTP id x10mr52255632edv.3.1636281908927;
        Sun, 07 Nov 2021 02:45:08 -0800 (PST)
Received: from localhost (net-37-119-217-95.cust.vodafonedsl.it. [37.119.217.95])
        by smtp.gmail.com with ESMTPSA id j3sm6532546ejo.2.2021.11.07.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 02:45:08 -0800 (PST)
Date:   Sun, 7 Nov 2021 11:45:06 +0100
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
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: introduce 160 MHz channel bandwidth support
Message-ID: <YYeuMs+QD067Fc5R@lore-desk>
References: <d4e93e0ffa11d7126b2ab48a34d0b4a4a17f2134.1636207928.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pFtmkrBWDeyFXsfP"
Content-Disposition: inline
In-Reply-To: <d4e93e0ffa11d7126b2ab48a34d0b4a4a17f2134.1636207928.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pFtmkrBWDeyFXsfP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Introduce the basic configuration for chips with BW160 capability
>=20
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h            |  1 +
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  1 +
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  4 ++++
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 12 ++++++++++++
>  4 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index e2da720a91b6..babca8086027 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -346,6 +346,7 @@ struct mt76_hw_cap {
>  	bool has_2ghz;
>  	bool has_5ghz;
>  	bool has_6ghz;
> +	bool has_bw160;
>  };
> =20
>  #define MT_DRV_TXWI_NO_FREE		BIT(0)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 26b4b875dcc0..4da20537aaf9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1775,6 +1775,7 @@ static void mt76_connac_mcu_parse_phy_cap(struct mt=
76_dev *dev,
>  	dev->phy.chainmask =3D dev->phy.antenna_mask;
>  	dev->phy.cap.has_2ghz =3D cap->hw_path & BIT(WF0_24G);
>  	dev->phy.cap.has_5ghz =3D cap->hw_path & BIT(WF0_5G);
> +	dev->phy.cap.has_bw160 =3D (cap->max_bw >=3D IEEE80211_STA_RX_BW_160);

Hi Deren,

just out of my curiosity, what are the possible values of cap->max_bw here?

Regards,
Lorenzo

>  }
> =20
>  int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 210998f086ab..30c0246fba3a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -264,6 +264,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
>  			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
>  			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
> +	if (dev->mt76.phy.cap.has_bw160)
> +		dev->mphy.sband_5g.sband.vht_cap.cap |=3D
> +			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> +			IEEE80211_VHT_CAP_SHORT_GI_160;
> =20
>  	dev->mphy.hw->wiphy->available_antennas_rx =3D dev->mphy.chainmask;
>  	dev->mphy.hw->wiphy->available_antennas_tx =3D dev->mphy.chainmask;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 633c6d2a57ac..af8c675f909f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -128,11 +128,23 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl=
80211_band band,
>  				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
>  				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
>  				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
> +
> +			if (phy->mt76->cap.has_bw160) {
> +				he_cap_elem->phy_cap_info[0] |=3D
> +					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
> +				he_cap_elem->phy_cap_info[8] |=3D
> +					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
> +					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
> +			}
>  			break;
>  		}
> =20
>  		he_mcs->rx_mcs_80 =3D cpu_to_le16(mcs_map);
>  		he_mcs->tx_mcs_80 =3D cpu_to_le16(mcs_map);
> +		if (phy->mt76->cap.has_bw160) {
> +			he_mcs->rx_mcs_160 =3D cpu_to_le16(mcs_map);
> +			he_mcs->tx_mcs_160 =3D cpu_to_le16(mcs_map);
> +		}
> =20
>  		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
>  		if (he_cap_elem->phy_cap_info[6] &
> --=20
> 2.18.0
>=20

--pFtmkrBWDeyFXsfP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYYeuMgAKCRA6cBh0uS2t
rDZRAPwKmeF6/0MuMzQcTou3JM4/mLpNEXiHQKOGPkIdpHk6VQD/dtMQo54IVMUP
klNiHyYxzV/4+q+IExvrsnf65wJcbAo=
=6xyL
-----END PGP SIGNATURE-----

--pFtmkrBWDeyFXsfP--

