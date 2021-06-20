Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D63ADDE5
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFTJmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 05:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhFTJmj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 05:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21FE360FE8;
        Sun, 20 Jun 2021 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624182026;
        bh=8BhNwEcPn00QGGh83CZRkbLFwXQHbHpWp1rXZGdhOnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRywM2k0SzNMdNYmHg89Ohft1OfWXtJppgI1SGrf+WLy2AyzGTweQsC7vCLfYmwNE
         r+QH3xy9emDDlhpm5D79e0BwMg5y5gSIq13wqIlYvWflmSmvMOghqNPfCmEhIOnDPA
         MboBBPTBdvDKhGXGld/xudHTDXW2Gav2gKXlfjcHs1Gy9guX40NqfDTMWD8s6PhcNM
         nA82EaTUlQJZwca4gRYblD5s1Eu9RoGnpEcAbOMyuNVVxRcw2qElBU2peK6/dOJ1SI
         +aUntDkLCXYiL+JmgktJy3U5SZu/DTHxbImw/yV2hwUKdZITUoBjbPFQ4zcLIMtVDy
         OyOxfHe8OnUAQ==
Date:   Sun, 20 Jun 2021 11:40:21 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: add .set_sar_specs support
Message-ID: <YM8NBUZp+/97kiIH@lore-desk>
References: <05d4551875d7ddf8de6679612ca3e650bded9926.1624167097.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s+HmzexPvHMkCcA1"
Content-Disposition: inline
In-Reply-To: <05d4551875d7ddf8de6679612ca3e650bded9926.1624167097.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--s+HmzexPvHMkCcA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: YN Chen <YN.Chen@mediatek.com>
>=20
> add .set_sar_specs to allow configuring SAR power limitations on the
> frequency ranges from the userland.
>=20
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 +++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 24 +++++++++-
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 21 +++++++++
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 45 +++++++++++++++++++
>  5 files changed, 97 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 25c5ceef5257..63ce5242c4d5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -636,6 +636,9 @@ struct mt76_phy {
>  		struct sk_buff **tail;
>  		u16 seqno;
>  	} rx_amsdu[__MT_RXQ_MAX];
> +
> +	void *frp_data;
> +	u8 num_frps;
>  };
> =20
>  struct mt76_dev {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index f49d97d0a1c5..95c7d1cac7c4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -83,6 +83,11 @@ struct mt76_connac_coredump {
>  	unsigned long last_activity;
>  };
> =20
> +struct mt76_connac_freq_range_power {
> +	const struct cfg80211_sar_freq_ranges *range;
> +	s8 power;
> +};
> +
>  extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
> =20
>  static inline bool is_mt7921(struct mt76_dev *dev)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 5c3a81e5f559..07f45cb4f500 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -1749,6 +1749,24 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8=
 *sku,
>  	}
>  }
> =20
> +static s8 mt76_connac_get_sar_power(struct mt76_phy *phy,
> +				    struct ieee80211_channel *chan,
> +				    s8 target_power)
> +{
> +	struct mt76_connac_freq_range_power *frp =3D phy->frp_data;
> +	int freq, i;
> +
> +	freq =3D ieee80211_channel_to_frequency(chan->hw_value, chan->band);
> +	for (i =3D 0 ; i < phy->num_frps; i++) {
> +		if (frp[i].range &&
> +		    freq >=3D frp[i].range->start_freq &&
> +		    freq < frp[i].range->end_freq)
> +			target_power =3D min_t(s8, frp[i].power, target_power);

can we have overlapping freq range? if not I guess you can add a break here.

> +	}
> +
> +	return target_power;
> +}
> +
>  static int
>  mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>  				  enum nl80211_band band)
> @@ -1816,9 +1834,13 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy =
*phy,
>  				.hw_value =3D ch_list[idx],
>  				.band =3D band,
>  			};
> +			s8 sar_power;
> +
> +			sar_power =3D mt76_connac_get_sar_power(phy, &chan,
> +							      tx_power);
> =20
>  			mt76_get_rate_power_limits(phy, &chan, &limits,
> -						   tx_power);
> +						   sar_power);
> =20
>  			tx_power_tlv.last_msg =3D ch_list[idx] =3D=3D last_ch;
>  			sku_tlbv.channel =3D ch_list[idx];
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index a9ce10b98827..e7f66d988a49 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -24,6 +24,20 @@ static const struct ieee80211_iface_combination if_com=
b[] =3D {
>  	}
>  };
> =20
> +const struct cfg80211_sar_freq_ranges mt7921_sar_freq_ranges[] =3D {
> +	{ .start_freq =3D 2402, .end_freq =3D 2494, },
> +	{ .start_freq =3D 5150, .end_freq =3D 5350, },
> +	{ .start_freq =3D 5350, .end_freq =3D 5470, },
> +	{ .start_freq =3D 5470, .end_freq =3D 5725, },
> +	{ .start_freq =3D 5725, .end_freq =3D 5950, },
> +};
> +
> +static const struct cfg80211_sar_capa mt7921_sar_capa =3D {
> +	.type =3D NL80211_SAR_TYPE_POWER,
> +	.num_freq_ranges =3D ARRAY_SIZE(mt7921_sar_freq_ranges),
> +	.freq_ranges =3D &mt7921_sar_freq_ranges[0],
> +};
> +
>  static void
>  mt7921_regd_notifier(struct wiphy *wiphy,
>  		     struct regulatory_request *request)
> @@ -75,6 +89,13 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
>  	wiphy->max_sched_scan_reqs =3D 1;
>  	wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>  	wiphy->reg_notifier =3D mt7921_regd_notifier;
> +	wiphy->sar_capa =3D &mt7921_sar_capa;
> +
> +	phy->mt76->frp_data =3D devm_kcalloc(dev->mt76.dev,
> +					   wiphy->sar_capa->num_freq_ranges,
> +					   sizeof(struct mt76_connac_freq_range_power),
> +					   GFP_KERNEL);

Here I guess we need to check if devm_kcalloc fails returning an int from
mt7921_init_wiphy()

> +	phy->mt76->num_frps =3D wiphy->sar_capa->num_freq_ranges;
> =20
>  	wiphy->features |=3D NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
>  			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 7fd21049ff5a..e9b5d79e139f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1171,6 +1171,50 @@ static void mt7921_sta_set_decap_offload(struct ie=
ee80211_hw *hw,
>  					     MCU_UNI_CMD_STA_REC_UPDATE);
>  }
> =20
> +static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
> +				const struct cfg80211_sar_specs *sar)
> +{
> +	const struct cfg80211_sar_capa *capa =3D hw->wiphy->sar_capa;
> +	struct mt76_connac_freq_range_power *frp_data, *frp;
> +	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> +	struct mt76_phy *mphy =3D hw->priv;
> +	int err;
> +	u32 i;
> +
> +	mt7921_mutex_acquire(dev);
> +
> +	if (!sar || sar->type !=3D NL80211_SAR_TYPE_POWER ||
> +	    sar->num_sub_specs =3D=3D 0) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}

I guess you can move this out of the lock

> +
> +	frp_data =3D mphy->frp_data;
> +
> +	for (i =3D 0; i < sar->num_sub_specs; i++) {
> +		u32 index =3D sar->sub_specs[i].freq_range_index;
> +		/* SAR specifies power limitaton in 0.25dbm */
> +		s32 power =3D sar->sub_specs[i].power >> 1;
> +
> +		if (power > 127 || power < -127)
> +			power =3D 127;
> +
> +		if (index >=3D mphy->num_frps)
> +			continue;
> +
> +		frp =3D &frp_data[index];
> +		frp->range =3D &capa->freq_ranges[index];

I guess there is an use-after-free here since sar is freed at the end of
nl80211_set_sar_specs, right?

Regards,
Lorenzo

> +		frp->power =3D power;
> +	}
> +
> +	err =3D mt76_connac_mcu_set_rate_txpower(mphy);
> +
> +out:
> +	mt7921_mutex_release(dev);
> +
> +	return err;
> +}
> +
>  const struct ieee80211_ops mt7921_ops =3D {
>  	.tx =3D mt7921_tx,
>  	.start =3D mt7921_start,
> @@ -1209,4 +1253,5 @@ const struct ieee80211_ops mt7921_ops =3D {
>  	.set_rekey_data =3D mt7921_set_rekey_data,
>  #endif /* CONFIG_PM */
>  	.flush =3D mt7921_flush,
> +	.set_sar_specs =3D mt7921_set_sar_specs,
>  };
> --=20
> 2.25.1
>=20

--s+HmzexPvHMkCcA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYM8NAwAKCRA6cBh0uS2t
rPO8APwMPm+IbwGECFPvMko76rrnHWifWvKBYyiLm6535Y7P0QEA5rYMFdl1QvVO
2f7NBsh1RPs6Ln16wcIpeDAsJE7jdw4=
=wFmb
-----END PGP SIGNATURE-----

--s+HmzexPvHMkCcA1--
