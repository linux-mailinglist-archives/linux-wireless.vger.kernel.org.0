Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600D631690
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKTVWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKTVWr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 16:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD41FCE9
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 13:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668979311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJ9CZnpTUcwMqf4ihmpIJM7YZPqQhfaqzkOhwCN61mg=;
        b=WDF7nr+VmR49Zt/G553Kc3e0loDXa6GMQBWMkl/zX6oQ8zZNnBHn1bzbVTlS7AJBUNkjo3
        A7yh5x8fxtNwBkifNdBGsM22tO90K6EOCK3gdxS1/ABFijODuTxxDda7UETUcB6MkZ4M2d
        HMvA1Yxneju2BA8F7kazwdNv50jcwy4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-1E-kIG3GO36UxqCaKpucBg-1; Sun, 20 Nov 2022 16:21:49 -0500
X-MC-Unique: 1E-kIG3GO36UxqCaKpucBg-1
Received: by mail-wm1-f69.google.com with SMTP id v125-20020a1cac83000000b003cfa148576dso5604533wme.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 13:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ9CZnpTUcwMqf4ihmpIJM7YZPqQhfaqzkOhwCN61mg=;
        b=osFOZr6YWsCM4VsETSUwEByF3mcELtooI8WyTMQllog6IzQ2efO/TS11B4G5OHLUBR
         KQHfKOUyT5ml92R/xSOxPgUOSy36v6c4WvFbz5KDQRB4M0HC1rjLTUccXpaDtKZVp9Lw
         M1Iwtsm5k6m98CYcVU7C75U5VzM9BOwNw/gFcZdWdBYYCUBSe4yui5WsOupaYBp0Q27d
         2oomSbnsK0VyUCvDOQklMfdxY1+VXuMkTXm0R4lHn1ZlaZfnj/bmJvlf4AKvwAxNJfb2
         iLYXp5QBoalgdwvmHwYysohcIi5LXGaYAL4ui3LBHaeXE0aOYEwuuNMoikntZRPblaRk
         yoJg==
X-Gm-Message-State: ANoB5pl1AbiFvUL+k5kmY2RV3A42F8RCL+TQvVIUoo2veEgccttDcsIj
        kURvRVgnCIpMyKu+jC5ph6I9Qcd3nxlvyjAYsRm6V0eldXqh6PXIjZTRfVsPvZpXeJ3X1k8va9C
        utBfrqg2XFke774JVoiuJ9BnyUjk=
X-Received: by 2002:adf:ce0c:0:b0:22e:34c2:c6f0 with SMTP id p12-20020adfce0c000000b0022e34c2c6f0mr9215642wrn.232.1668979308282;
        Sun, 20 Nov 2022 13:21:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7pjMZAilKCfwy3p+OSy3gXJ8HsEy92GKeyF9OXaaCxCguK5aagexZxU9fLXH4epKCygqxehA==
X-Received: by 2002:adf:ce0c:0:b0:22e:34c2:c6f0 with SMTP id p12-20020adfce0c000000b0022e34c2c6f0mr9215637wrn.232.1668979308002;
        Sun, 20 Nov 2022 13:21:48 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b003c6b874a0dfsm13629807wmq.14.2022.11.20.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:21:47 -0800 (PST)
Date:   Sun, 20 Nov 2022 22:21:45 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] wifi: mt76: mt7915: enable .sta_set_txpwr support
Message-ID: <Y3qaafXBuVgjxXR2@lore-desk>
References: <c73db8d9bb03efe8cb403434aeedad25d958e258.1668973479.git.ryder.lee@mediatek.com>
 <c843e72587751adf0438f6e85de9e9c5b8323bf4.1668973479.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpPvvVISQbvq9kas"
Content-Disposition: inline
In-Reply-To: <c843e72587751adf0438f6e85de9e9c5b8323bf4.1668973479.git.ryder.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cpPvvVISQbvq9kas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This adds support for adjusting the Txpower level while pushing
> traffic to an associated station. The allowed range is from 0 to
> the maximum power of channel.

Very cool, iiuc the hw/fw is capable of adjusting tx power according to the=
 trasmitted
frame, right? Is it possible to specify it on per-packet basis or just
per-station?

>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 33 +++++++
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 92 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  8 ++
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
>  5 files changed, 134 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index b48c2ba9273d..79bd7bf93f33 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -355,6 +355,9 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
> =20
> +	if (!is_mt7915(&dev->mt76))
> +		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
> +
>  	if (!mdev->dev->of_node ||
>  	    !of_property_read_bool(mdev->dev->of_node,
>  				   "mediatek,disable-radar-background"))
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index a29cbdb47801..9792831090c7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1126,6 +1126,38 @@ static void mt7915_sta_set_decap_offload(struct ie=
ee80211_hw *hw,
>  	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>  }
> =20
> +static int mt7915_sta_set_txpwr(struct ieee80211_hw *hw,
> +				struct ieee80211_vif *vif,
> +				struct ieee80211_sta *sta)
> +{
> +	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> +	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
> +	s16 txpower =3D sta->deflink.txpwr.power;
> +	int ret;
> +
> +	if (sta->deflink.txpwr.type =3D=3D NL80211_TX_POWER_AUTOMATIC)
> +		txpower =3D 0;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	/* NOTE: temporarily use 0 as minimum limit, which is a
> +	 * global setting and will be applied to all stations.
> +	 */
> +	ret =3D mt7915_mcu_set_txpower_frame_min(phy, 0);
> +	if (ret)

we need to relase the lock here

Regards,
Lorenzo

> +		return ret;
> +
> +	/* This only applies to data frames while pushing traffic,
> +	 * whereas the management frames or other packets that are
> +	 * using fixed rate can be configured via TxD.
> +	 */
> +	ret =3D mt7915_mcu_set_txpower_frame(phy, vif, sta, txpower);
> +
> +	mutex_unlock(&dev->mt76.mutex);
> +
> +	return ret;
> +}
> +
>  static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] =3D {
>  	"tx_ampdu_cnt",
>  	"tx_stop_q_empty_cnt",
> @@ -1491,6 +1523,7 @@ const struct ieee80211_ops mt7915_ops =3D {
>  	.set_bitrate_mask =3D mt7915_set_bitrate_mask,
>  	.set_coverage_class =3D mt7915_set_coverage_class,
>  	.sta_statistics =3D mt7915_sta_statistics,
> +	.sta_set_txpwr =3D mt7915_sta_set_txpwr,
>  	.sta_set_4addr =3D mt7915_sta_set_4addr,
>  	.sta_set_decap_offload =3D mt7915_sta_set_decap_offload,
>  	.add_twt_setup =3D mt7915_mac_add_twt_setup,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 3a0d97dad96f..d911512f31a6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -3083,6 +3083,86 @@ int mt7915_mcu_set_thermal_throttling(struct mt791=
5_phy *phy, u8 state)
>  				 &req, sizeof(req), false);
>  }
> =20
> +int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower)
> +{
> +	struct mt7915_dev *dev =3D phy->dev;
> +	struct {
> +		u8 format_id;
> +		u8 rsv;
> +		u8 band_idx;
> +		s8 txpower_min;
> +	} __packed req =3D {
> +		.format_id =3D TX_POWER_LIMIT_FRAME_MIN,
> +		.band_idx =3D phy !=3D &dev->phy,
> +		.txpower_min =3D txpower * 2, /* 0.5db */
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76,
> +				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
> +				 sizeof(req), true);
> +}
> +
> +int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_sta *sta, s8 txpower)
> +{
> +	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +	struct mt7915_dev *dev =3D phy->dev;
> +	struct {
> +		u8 format_id;
> +		u8 rsv[3];
> +		u8 band_idx;
> +		s8 txpower_max;
> +		__le16 wcid;
> +		s8 txpower_offs[48];
> +	} __packed req =3D {
> +		.format_id =3D TX_POWER_LIMIT_FRAME,
> +		.band_idx =3D phy !=3D &dev->phy,
> +		.txpower_max =3D DIV_ROUND_UP(phy->mt76->txpower_cur, 2),
> +		.wcid =3D cpu_to_le16(msta->wcid.idx),
> +	};
> +	int ret;
> +	s8 txpower_sku[MT7915_SKU_RATE_NUM];
> +
> +	ret =3D mt7915_mcu_get_txpower_sku(phy, txpower_sku, sizeof(txpower_sku=
));
> +	if (ret)
> +		return ret;
> +
> +	if (txpower > req.txpower_max || txpower < 0)
> +		return -EINVAL;
> +
> +	if (txpower) {
> +		u32 offs, len, i;
> +
> +		if (sta->deflink.ht_cap.ht_supported) {
> +			const u8 *sku_len =3D mt7915_sku_group_len;
> +
> +			offs =3D sku_len[SKU_CCK] + sku_len[SKU_OFDM];
> +			len =3D sku_len[SKU_HT_BW20] + sku_len[SKU_HT_BW40];
> +
> +			if (sta->deflink.vht_cap.vht_supported) {
> +				offs +=3D len;
> +				len =3D sku_len[SKU_VHT_BW20] * 4;
> +
> +				if (sta->deflink.he_cap.has_he) {
> +					offs +=3D len + sku_len[SKU_HE_RU26] * 3;
> +					len =3D sku_len[SKU_HE_RU242] * 4;
> +				}
> +			}
> +		} else {
> +			return -EINVAL;
> +		}
> +
> +		for (i =3D 0; i < len; i++, offs++)
> +			req.txpower_offs[i] =3D
> +				txpower - DIV_ROUND_UP(txpower_sku[offs], 2);
> +	}
> +
> +	return mt76_mcu_send_msg(&dev->mt76,
> +				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
> +				 sizeof(req), true);
> +}
> +
>  int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
>  {
>  	struct mt7915_dev *dev =3D phy->dev;
> @@ -3094,7 +3174,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *p=
hy)
>  		u8 dbdc_idx;
>  		s8 val[MT7915_SKU_RATE_NUM];
>  	} __packed req =3D {
> -		.format_id =3D 4,
> +		.format_id =3D TX_POWER_LIMIT_TABLE,
>  		.dbdc_idx =3D phy !=3D &dev->phy,
>  	};
>  	struct mt76_power_limits limits_array;
> @@ -3144,11 +3224,11 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy =
*phy, s8 *txpower, int len)
>  		u8 band;
>  		u8 _rsv;
>  	} __packed req =3D {
> -		.format_id =3D 7,
> +		.format_id =3D TX_POWER_LIMIT_INFO,
>  		.category =3D RATE_POWER_INFO,
>  		.band =3D phy !=3D &dev->phy,
>  	};
> -	s8 res[MT7915_SKU_RATE_NUM][2];
> +	s8 txpower_sku[MT7915_SKU_RATE_NUM][2];
>  	struct sk_buff *skb;
>  	int ret, i;
> =20
> @@ -3158,9 +3238,9 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *p=
hy, s8 *txpower, int len)
>  	if (ret)
>  		return ret;
> =20
> -	memcpy(res, skb->data + 4, sizeof(res));
> +	memcpy(txpower_sku, skb->data + 4, sizeof(txpower_sku));
>  	for (i =3D 0; i < len; i++)
> -		txpower[i] =3D res[i][req.band];
> +		txpower[i] =3D txpower_sku[i][req.band_idx];
> =20
>  	dev_kfree_skb(skb);
> =20
> @@ -3198,7 +3278,7 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, b=
ool enable)
>  		u8 dbdc_idx;
>  		u8 rsv;
>  	} __packed req =3D {
> -		.format_id =3D 0,
> +		.format_id =3D TX_POWER_LIMIT_ENABLE,
>  		.dbdc_idx =3D phy !=3D &dev->phy,
>  		.sku_enable =3D enable,
>  	};
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.h
> index 2fc09fd53777..46c517e50ae4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -419,6 +419,14 @@ enum {
>  #define RATE_CFG_PHY_TYPE		GENMASK(27, 24)
>  #define RATE_CFG_HE_LTF			GENMASK(31, 28)
> =20
> +enum {
> +	TX_POWER_LIMIT_ENABLE,
> +	TX_POWER_LIMIT_TABLE =3D 0x4,
> +	TX_POWER_LIMIT_INFO =3D 0x7,
> +	TX_POWER_LIMIT_FRAME =3D 0x11,
> +	TX_POWER_LIMIT_FRAME_MIN =3D 0x12,
> +};
> +
>  enum {
>  	SPR_ENABLE =3D 0x1,
>  	SPR_ENABLE_SD =3D 0x3,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 0bad78cf32c7..015c7190d79f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -526,6 +526,10 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 ac=
tion, u8 set, u8 band);
>  int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
>  int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
>  int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int =
len);
> +int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower);
> +int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_sta *sta, s8 txpower);
>  int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action);
>  int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val);
>  int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
> --=20
> 2.36.1
>=20

--cpPvvVISQbvq9kas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY3qaaAAKCRA6cBh0uS2t
rNOrAPsHH1JSEIYyMupWzWPiYvXacAafYrZRE3v2MYwfu7RxowD/REQjzYN9JNt1
44FRxoUhOnZb4zJeGRmsZcNRoBa92Qg=
=w2Ox
-----END PGP SIGNATURE-----

--cpPvvVISQbvq9kas--

