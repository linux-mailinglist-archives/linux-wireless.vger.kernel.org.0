Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D623F9F14
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhH0Spr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 14:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhH0Spo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 14:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630089894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKTEKILYopUZMceo/SvcBY7xL5qbjDWf3wbuGwU275M=;
        b=UUt/y0yGeTjUqRywca2StjR1+1SbkSfi38Xj85kNFN2Fv3vDyZZT16yLtE0q4fHZQ4TAxD
        7PbsBQBLX0Zc9+QEfDV+tmGFmGeD40mnxj37JAyCnmrZ5eSfwquGxrWoP4qVzI4AHmXBXU
        +UKVfKYh322Wk3X5mVIeu8UoPfMft90=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-IM_7fkAXPKOSCjmGBL5fdA-1; Fri, 27 Aug 2021 14:44:53 -0400
X-MC-Unique: IM_7fkAXPKOSCjmGBL5fdA-1
Received: by mail-ej1-f69.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso2209241ejc.22
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 11:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKTEKILYopUZMceo/SvcBY7xL5qbjDWf3wbuGwU275M=;
        b=lGDvshFkknDqifKrQLcbcCC6dSO8V5z9G+dEITJ/np6vgAQZow/9Xafhdmbv3PtgqI
         ls1nQ0Dgtw6IGInImULM2jhoJm57r8v6ZhSmbIScgS9E3jnSc7EkCgZa4RJWdIJB4lKa
         csNpFOjHPnP5YtWih41rDGwJXRXa/GoyQlsZzltYo1epm81iEsqJHnCj3MQ8CDJ8reDN
         BoKPI032bgSyeO+Ej9MLHRNSTIZFCL6s7BsuU43LWgtjdZvvbC1oo/vjJN4bEvfmTPdS
         yVZnqwknhV4yIxkXtmY3/m8PHZLmANE7lj+vOd4gN3uLSgOPoLcAxssItfnhzY8Mf/gt
         ncWQ==
X-Gm-Message-State: AOAM532Nwd/HNhCGr2pq4i4qSxJEWvaChhg+72ulKI+x1Q2wa4hDjQjf
        IxV/zQLqqvG2qgCukdlgEO4+duf2uN8RYvhtAnOgkC3gRFTB7EZTOIwkOeu7xSqaJU3BsOh1eVJ
        rnJOl4y9Q3xvHQWQbKyYub9C3dK8=
X-Received: by 2002:a17:906:93ef:: with SMTP id yl15mr11641545ejb.229.1630089891390;
        Fri, 27 Aug 2021 11:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn8kDZv8r73ghWNHOsZxx+Cr88NJ+Zr3y719xbWWZYCEM/Y7Gq78VMeXuFODeiUjr7VUgnOA==
X-Received: by 2002:a17:906:93ef:: with SMTP id yl15mr11641526ejb.229.1630089891117;
        Fri, 27 Aug 2021 11:44:51 -0700 (PDT)
Received: from localhost (net-47-53-3-199.cust.vodafonedsl.it. [47.53.3.199])
        by smtp.gmail.com with ESMTPSA id y13sm3818191edd.45.2021.08.27.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:44:50 -0700 (PDT)
Date:   Fri, 27 Aug 2021 20:44:47 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chad Monroe <chad@monroe.io>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH 2/2] mt76: mt7615: fix radar detector logic
Message-ID: <YSkyn9eqQKLXcncf@lore-desk>
References: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
 <4a4bb98aa6dd1c7f4671d11a901fb8cf35f49308.1630081048.git.chad@monroe.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="znaAPSv3wzvrJXLm"
Content-Disposition: inline
In-Reply-To: <4a4bb98aa6dd1c7f4671d11a901fb8cf35f49308.1630081048.git.chad@monroe.io>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--znaAPSv3wzvrJXLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Before this patch, if AP went from ch 100 to ch 36, the radar detector
> logic in the firmware was not being disabled.  This made the AP appear
> to be up, but no beacons were seen on air until module reload or
> reboot.
>=20
> To reproduce this, I change hostapd.conf and restart hostapd.  Others
> on openwrt used their UI to make changes and problem was seen, but
> stil others changed channels in some other way and/or had some other
> difference and could *not* reproduce it.  So, something perhaps a
> bit subtle.
>=20
> To fix the problem, stop depending on comparing dfs_state, store last
> freq/bandwidth to detect changes in that, and streamline code that
> checks to enable/disable radar detection.  And add in error checking
> and dev_dbg logic so one can see what is actually happening if need
> to debug this again.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Chad Monroe <chad@monroe.io>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  12 ++-
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 102 ++++++++++++------
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  25 ++++-
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 +-
>  4 files changed, 104 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/init.c
> index 05235a60d413..23dde13c2703 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -333,6 +333,7 @@ mt7615_regd_notifier(struct wiphy *wiphy,
>  	struct mt76_phy *mphy =3D hw->priv;
>  	struct mt7615_phy *phy =3D mphy->priv;
>  	struct cfg80211_chan_def *chandef =3D &mphy->chandef;
> +	int ret;
> =20
>  	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
>  	dev->mt76.region =3D request->dfs_region;
> @@ -342,14 +343,18 @@ mt7615_regd_notifier(struct wiphy *wiphy,
> =20
>  	mt7615_mutex_acquire(dev);
> =20
> -	if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
> -		mt7615_dfs_init_radar_detector(phy);
> -
>  	if (mt7615_firmware_offload(phy->dev)) {
>  		mt76_connac_mcu_set_channel_domain(mphy);
>  		mt76_connac_mcu_set_rate_txpower(mphy);
>  	}
> =20
> +	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> +		ret =3D mt7615_dfs_init_radar_detector(phy);
> +		if (ret < 0)
> +			dev_err(dev->mt76.dev, "init-wifi: dfs-init-radar-detector failed: %d=
",
> +				ret);

I guess this chunck does not make any difference since mt7663 does not supp=
ort
dfs (w offload fw).

> +	}
> +
>  	mt7615_mutex_release(dev);
>  }
> =20
> @@ -550,7 +555,6 @@ void mt7615_init_device(struct mt7615_dev *dev)
>  	dev->pm.stats.last_wake_event =3D jiffies;
>  	dev->pm.stats.last_doze_event =3D jiffies;
>  	mt7615_cap_dbdc_disable(dev);
> -	dev->phy.dfs_state =3D -1;
> =20
>  #ifdef CONFIG_NL80211_TESTMODE
>  	dev->mt76.test_ops =3D &mt7615_testmode_ops;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index 78b55e872da0..571fa73baa76 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -2101,14 +2101,29 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(mt7615_tx_token_put);
> =20
> -static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
> +int mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy, bool ext_phy)
>  {
>  	struct mt7615_dev *dev =3D phy->dev;
> +	int err;
> +
> +	dev_dbg(dev->mt76.dev, "dfs-stop-radar-detector, rdd-state: 0x%x",
> +		phy->rdd_state);
> +
> +	err =3D mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy,
> +				 MT_RX_SEL0, 0);
> +	if (err < 0) {
> +		dev_err(dev->mt76.dev, "mcu-rdd-cmd RDD_NORMAL_START failed: %d",
> +			err);
> +		/* I think best to carry on, even if we have an error here. */
> +	}

I guess you just moved mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ..) here b=
ut
the logic is the same as before, right? If so I think we can drop it

> =20
>  	if (phy->rdd_state & BIT(0))
>  		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
>  	if (phy->rdd_state & BIT(1))
>  		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
> +	phy->rdd_state =3D 0;
> +
> +	return err;
>  }
> =20
>  static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
> @@ -2116,11 +2131,14 @@ static int mt7615_dfs_start_rdd(struct mt7615_dev=
 *dev, int chain)
>  	int err;
> =20
>  	err =3D mt7615_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
> +
> +	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_START rv: %d", err);
>  	if (err < 0)
>  		return err;
> =20
> -	return mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
> -				  MT_RX_SEL0, 1);
> +	err =3D mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain, MT_RX_SEL0, 1);
> +	dev_dbg(dev->mt76.dev, "dfs-start-rdd, RDD_DET_MODE rv: %d", err);
> +	return err;
>  }
> =20
>  static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
> @@ -2227,48 +2245,70 @@ int mt7615_dfs_init_radar_detector(struct mt7615_=
phy *phy)
>  	if (is_mt7663(&dev->mt76))
>  		return 0;
> =20
> -	if (dev->mt76.region =3D=3D NL80211_DFS_UNSET) {
> -		phy->dfs_state =3D -1;
> -		if (phy->rdd_state)
> -			goto stop;
> +	dev_dbg(dev->mt76.dev,
> +		"dfs-init-radar-detector, region: %d freq: %d chandef dfs-state: %d",
> +		dev->mt76.region, chandef->chan->center_freq,
> +		chandef->chan->dfs_state);
> =20
> +	if (test_bit(MT76_SCANNING, &phy->mt76->state)) {
> +		dev_dbg(dev->mt76.dev, "init-radar, was scanning, no change.\n");
>  		return 0;
>  	}
> =20
> -	if (test_bit(MT76_SCANNING, &phy->mt76->state))
> -		return 0;
> +	if (dev->mt76.region =3D=3D NL80211_DFS_UNSET) {
> +		dev_dbg(dev->mt76.dev,
> +			"dfs-init-radar, region is UNSET, disable radar.");
> +		goto stop;
> +	}
> +
> +	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR)) {
> +		dev_dbg(dev->mt76.dev,
> +			"dfs-init-radar, chandef does not want radar.");
> +		goto stop;
> +	}
> +
> +	ieee80211_iterate_active_interfaces(phy->mt76->hw,
> +					    IEEE80211_IFACE_ITER_RESUME_ALL,
> +					    mt7615_vif_counts, &counts);
> +
> +	if (!(counts.ap + counts.adhoc + counts.mesh)) {
> +		/* No beaconning interfaces, do not start CAC */
> +		dev_dbg(dev->mt76.dev,
> +			"dfs-init-radar, no AP/Mesh/Adhoc vifs active, stop radar.");
> +		goto stop;
> +	}
> =20
> -	if (phy->dfs_state =3D=3D chandef->chan->dfs_state)
> +	/* At this point, we need radar detection, see if we have started
> +	 * it already.
> +	 */
> +	if (phy->rdd_state) {

Are you sure this approach works with DBDC? in this case phy->rdd_state is =
not
0 but the radar detection has not started on this phy.

> +		if (chandef->chan->dfs_state =3D=3D NL80211_DFS_AVAILABLE) {
> +			/* CAC is already complete. */
> +			dev_dbg(dev->mt76.dev,
> +				"init-radar, RADAR started and DFS state is AVAILABLE, call RDD_CAC_=
END");
> +			return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
> +						  MT_RX_SEL0, 0);
> +		}
> +		dev_dbg(dev->mt76.dev,
> +			"init-radar, rdd_state indicates RADAR already started,"
> +			" DFS state: %d not YET available, rdd_state: 0x%x",
> +			chandef->chan->dfs_state, phy->rdd_state);
>  		return 0;
> +	}
> =20
>  	err =3D mt7615_dfs_init_radar_specs(phy);
>  	if (err < 0) {
> -		phy->dfs_state =3D -1;
> +		dev_err(dev->mt76.dev, "dfs-init-radar-specs failed: %d",
> +			err);
>  		goto stop;
>  	}
> =20
> -	phy->dfs_state =3D chandef->chan->dfs_state;
> -
> -	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> -		if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE) {
> -			ieee80211_iterate_active_interfaces(phy->mt76->hw,
> -				IEEE80211_IFACE_ITER_RESUME_ALL,
> -				mt7615_vif_counts, &counts);
> -			if (counts.ap + counts.adhoc + counts.mesh)
> -				mt7615_dfs_start_radar_detector(phy);
> -			return 0;
> -		}
> -		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
> -					  MT_RX_SEL0, 0);
> -	}
> +	err =3D mt7615_dfs_start_radar_detector(phy);
> +	dev_dbg(dev->mt76.dev, "dfs-start-radar-detector rv: %d", err);
> +	return err;
> =20
>  stop:
> -	err =3D mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy, MT_RX_SEL0, =
0);
> -	if (err < 0)
> -		return err;
> -
> -	mt7615_dfs_stop_radar_detector(phy);
> -	return 0;
> +	return mt7615_dfs_stop_radar_detector(phy, ext_phy);
>  }
> =20
>  int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/main.c
> index 7154acf3eb9b..484c8803726f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -291,6 +291,8 @@ static void mt7615_init_dfs_state(struct mt7615_phy *=
phy)
>  	struct mt76_phy *mphy =3D phy->mt76;
>  	struct ieee80211_hw *hw =3D mphy->hw;
>  	struct cfg80211_chan_def *chandef =3D &hw->conf.chandef;
> +	struct mt7615_dev *dev =3D phy->dev;
> +	bool ext_phy =3D phy !=3D &dev->phy;
> =20
>  	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
>  		return;
> @@ -298,11 +300,23 @@ static void mt7615_init_dfs_state(struct mt7615_phy=
 *phy)
>  	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
>  		return;
> =20
> -	if (mphy->chandef.chan->center_freq =3D=3D chandef->chan->center_freq &&
> -	    mphy->chandef.width =3D=3D chandef->width)
> +	if (phy->dfs_center_freq =3D=3D chandef->chan->center_freq &&
> +	    phy->dfs_ch_width =3D=3D chandef->width)
>  		return;

Why do we need phy->dfs_center_freq and phy->dfs_ch_width? if I read correc=
tly
the code mphy->chandef.* is updated in mt76_set_channel() so we do not need
them for thec check above, right?

Regards,
Lorenzo

> =20
> -	phy->dfs_state =3D -1;
> +	/* We are being moved to a new frequency/bw, still on DFS.  Stop
> +	 * any existing DFS, then will start it again in the
> +	 * init-radar-detector logic.
> +	 */
> +	if (phy->rdd_state) {
> +		dev_dbg(dev->mt76.dev,
> +			"init-dfs-state, channel changed, old: %d:%d  new: %d:%d, stopping ra=
dar.",
> +			phy->dfs_center_freq, phy->dfs_ch_width,
> +			chandef->chan->center_freq, chandef->width);
> +		mt7615_dfs_stop_radar_detector(phy, ext_phy);
> +	}
> +	phy->dfs_center_freq =3D chandef->chan->center_freq;
> +	phy->dfs_ch_width =3D chandef->width;
>  }
> =20
>  int mt7615_set_channel(struct mt7615_phy *phy)
> @@ -336,8 +350,11 @@ int mt7615_set_channel(struct mt7615_phy *phy)
> =20
>  	mt7615_mac_set_timing(phy);
>  	ret =3D mt7615_dfs_init_radar_detector(phy);
> -	if (ret)
> +	if (ret < 0) {
> +		dev_err(dev->mt76.dev, "set-channel: dfs-init-radar-detector failed: %=
d",
> +			ret);
>  		goto out;
> +	}
> =20
>  	mt7615_mac_cca_stats_reset(phy);
>  	ret =3D mt7615_mcu_set_sku_en(phy, true);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers=
/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index 58a98b5c0cbc..6a3209439492 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -164,8 +164,9 @@ struct mt7615_phy {
>  	u8 slottime;
> =20
>  	u8 chfreq;
> -	u8 rdd_state;
> -	int dfs_state;
> +	u8 rdd_state; /* radar detection started bitfield */
> +	enum nl80211_chan_width dfs_ch_width;
> +	u32 dfs_center_freq;
> =20
>  	u32 rx_ampdu_ts;
>  	u32 ampdu_ref;
> @@ -540,6 +541,7 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, boo=
l enable);
>  int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
>  int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
>  int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
> +int mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy, bool ext_phy);
> =20
>  int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
>  		       struct ieee80211_channel *chan, int duration);
> --=20
> 2.20.1
>=20

--znaAPSv3wzvrJXLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYSkynQAKCRA6cBh0uS2t
rMOGAQD43z+Ip6lJ2NYlurzOczMIQWFy50dl+DDWkP6lHqdxQgD9F0z/wHXE2huu
tnzRI3u2ED4Cqx42W6l7o+flNkzk1gA=
=OpuX
-----END PGP SIGNATURE-----

--znaAPSv3wzvrJXLm--

