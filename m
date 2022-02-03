Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E074A875C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiBCPNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 10:13:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56038 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiBCPNQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 10:13:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BF86B8343E
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 15:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55343C340E4;
        Thu,  3 Feb 2022 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643901193;
        bh=1meQHvHAOhMbrFDpS1HJ6jOT7GF3WDlSvyMPnLQr9bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrfJzCGILYZriPY4nKD0A2pbqzvZSDxM8R6Rqnlwl/PBvOy2GZTL0ZC/C1zVgi5Ui
         qd71CnkRDVGnzjcZiR6B3bRcv5prfaN9jL2G4I90kYMTzp/f+5PrknbNQt7s9LOPoI
         3CVZ5Otp7QcrgSe0JTohLGoR2t/JzfWJkgfoSHtn36Tk3lMfROPNzOJt5HWjkP/BhB
         dMDExkIstouxACmKhrmZGgClllOf+zZ6Jdz28ma1YgYHn8MeLvrDsG+Qweb7CCmJNv
         fPDKuCtrwPKDU27eiQUYxyovkqxyOCHA8URRC83TpkoV5LHGMXO9FiboeE3AlKOtxt
         xj4MLyo+saXWw==
Date:   Thu, 3 Feb 2022 16:13:09 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/5] mt76: mt7915: fix/rewrite the dfs state handling
 logic
Message-ID: <YfvxBeHmDFKQNAt2@lore-desk>
References: <20220203133600.92211-1-nbd@nbd.name>
 <20220203133600.92211-3-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ky2C091xdo9JUv8Y"
Content-Disposition: inline
In-Reply-To: <20220203133600.92211-3-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Ky2C091xdo9JUv8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Client mode on DFS channels was broken, because the old code was activati=
ng
> the DFS detector on radar channels while leaving it in CAC state.
> This was caused by making the decision based on the channel radar flag,
> instead of hw->conf.radar_enabled.
> In order to properly deal with the various corner cases, rip out the state
> handling code and replace it with something that's much easier to reason
> about.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 28 ++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  9 ++++
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 +--
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 51 +++++++++++--------
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 --------
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
>  7 files changed, 69 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 148e126b9215..a4bb281a74e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -823,6 +823,10 @@ void mt76_set_channel(struct mt76_phy *phy)
>  	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
>  	mt76_update_survey(phy);
> =20
> +	if (phy->chandef.chan->center_freq !=3D chandef->chan->center_freq ||
> +	    phy->chandef.width !=3D chandef->width)
> +		phy->dfs_state =3D MT_DFS_STATE_UNKNOWN;
> +
>  	phy->chandef =3D *chandef;
>  	phy->chan_state =3D mt76_channel_state(phy, chandef->chan);
> =20
> @@ -1604,3 +1608,27 @@ void mt76_ethtool_worker(struct mt76_ethtool_worke=
r_info *wi,
>  	wi->worker_stat_count =3D ei - wi->initial_stat_idx;
>  }
>  EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
> +
> +enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
> +{
> +	struct ieee80211_hw *hw =3D phy->hw;
> +	struct mt76_dev *dev =3D phy->dev;
> +
> +	if (dev->region =3D=3D NL80211_DFS_UNSET ||
> +	    test_bit(MT76_SCANNING, &phy->state))
> +		return MT_DFS_STATE_DISABLED;
> +
> +	if (!hw->conf.radar_enabled) {
> +		if ((hw->conf.flags & IEEE80211_CONF_MONITOR) &&
> +		    (phy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
> +			return MT_DFS_STATE_ACTIVE;
> +
> +		return MT_DFS_STATE_DISABLED;
> +	}
> +
> +	if (phy->chandef.chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
> +		return MT_DFS_STATE_CAC;
> +
> +	return MT_DFS_STATE_ACTIVE;
> +}
> +EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 43abf0679876..8d5c484eee58 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -105,6 +105,13 @@ enum mt76_cipher_type {
>  	MT_CIPHER_GCMP_256,
>  };
> =20
> +enum mt76_dfs_state {
> +	MT_DFS_STATE_UNKNOWN,
> +	MT_DFS_STATE_DISABLED,
> +	MT_DFS_STATE_CAC,
> +	MT_DFS_STATE_ACTIVE,
> +};
> +
>  struct mt76_queue_buf {
>  	dma_addr_t addr;
>  	u16 len;
> @@ -639,6 +646,7 @@ struct mt76_phy {
>  	struct ieee80211_channel *main_chan;
> =20
>  	struct mt76_channel_state *chan_state;
> +	enum mt76_dfs_state dfs_state;
>  	ktime_t survey_time;
> =20
>  	struct mt76_hw_cap cap;
> @@ -1184,6 +1192,7 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif,
>  		  const u8 *mac);
>  void mt76_sw_scan_complete(struct ieee80211_hw *hw,
>  			   struct ieee80211_vif *vif);
> +enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy);
>  int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		      void *data, int len);
>  int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index e908d56a9e21..705f362b8f7b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -288,7 +288,6 @@ mt7915_regd_notifier(struct wiphy *wiphy,
>  	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
>  	struct mt76_phy *mphy =3D hw->priv;
>  	struct mt7915_phy *phy =3D mphy->priv;
> -	struct cfg80211_chan_def *chandef =3D &mphy->chandef;
> =20
>  	memcpy(dev->mt76.alpha2, request->alpha2, sizeof(dev->mt76.alpha2));
>  	dev->mt76.region =3D request->dfs_region;
> @@ -299,9 +298,7 @@ mt7915_regd_notifier(struct wiphy *wiphy,
>  	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
>  	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
> =20
> -	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
> -		return;
> -
> +	mphy->dfs_state =3D MT_DFS_STATE_UNKNOWN;
>  	mt7915_dfs_init_radar_detector(phy);
>  }
> =20
> @@ -976,8 +973,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
> =20
>  	mt7915_init_wiphy(hw);
> =20
> -	dev->phy.dfs_state =3D -1;
> -
>  #ifdef CONFIG_NL80211_TESTMODE
>  	dev->mt76.test_ops =3D &mt7915_testmode_ops;
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 88bc4cf0dd79..59f0334ef8d2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -2439,41 +2439,48 @@ mt7915_dfs_init_radar_specs(struct mt7915_phy *ph=
y)
> =20
>  int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
>  {
> -	struct cfg80211_chan_def *chandef =3D &phy->mt76->chandef;
>  	struct mt7915_dev *dev =3D phy->dev;
>  	bool ext_phy =3D phy !=3D &dev->phy;
> +	enum mt76_dfs_state dfs_state, prev_state;
>  	int err;
> =20
> -	if (dev->mt76.region =3D=3D NL80211_DFS_UNSET) {
> -		phy->dfs_state =3D -1;
> -		if (phy->rdd_state)
> -			goto stop;
> +	prev_state =3D phy->mt76->dfs_state;
> +	dfs_state =3D mt76_phy_dfs_state(phy->mt76);
> =20
> +	if (prev_state =3D=3D dfs_state)
>  		return 0;
> -	}
> =20
> -	if (test_bit(MT76_SCANNING, &phy->mt76->state))
> -		return 0;
> -
> -	if (phy->dfs_state =3D=3D chandef->chan->dfs_state)
> -		return 0;
> +	if (prev_state =3D=3D MT_DFS_STATE_UNKNOWN)
> +		mt7915_dfs_stop_radar_detector(phy);
> =20
> -	err =3D mt7915_dfs_init_radar_specs(phy);
> -	if (err < 0) {
> -		phy->dfs_state =3D -1;
> +	if (dfs_state =3D=3D MT_DFS_STATE_DISABLED)
>  		goto stop;
> -	}
> =20
> -	phy->dfs_state =3D chandef->chan->dfs_state;
> +	if (prev_state <=3D MT_DFS_STATE_DISABLED) {
> +		err =3D mt7915_dfs_init_radar_specs(phy);
> +		if (err < 0)
> +			return err;
> +
> +		err =3D mt7915_dfs_start_radar_detector(phy);
> +		if (err < 0)
> +			return err;
> =20
> -	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> -		if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
> -			return mt7915_dfs_start_radar_detector(phy);
> +		phy->mt76->dfs_state =3D MT_DFS_STATE_CAC;
> +	}
> +
> +	if (dfs_state =3D=3D MT_DFS_STATE_CAC)
> +		return 0;
> =20
> -		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
> -					       ext_phy, MT_RX_SEL0, 0);
> +	err =3D mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
> +				      ext_phy, MT_RX_SEL0, 0);
> +	if (err < 0) {
> +		phy->mt76->dfs_state =3D MT_DFS_STATE_UNKNOWN;
> +		return err;
>  	}
> =20
> +	phy->mt76->dfs_state =3D MT_DFS_STATE_ACTIVE;
> +	return 0;
> +
>  stop:
>  	err =3D mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
>  				      MT_RX_SEL0, 0);
> @@ -2481,6 +2488,8 @@ int mt7915_dfs_init_radar_detector(struct mt7915_ph=
y *phy)
>  		return err;
> =20
>  	mt7915_dfs_stop_radar_detector(phy);
> +	phy->mt76->dfs_state =3D MT_DFS_STATE_DISABLED;
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 989298ffffbc..dee7fc011cdf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -302,26 +302,6 @@ static void mt7915_remove_interface(struct ieee80211=
_hw *hw,
>  	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
>  }
> =20
> -static void mt7915_init_dfs_state(struct mt7915_phy *phy)
> -{
> -	struct mt76_phy *mphy =3D phy->mt76;
> -	struct ieee80211_hw *hw =3D mphy->hw;
> -	struct cfg80211_chan_def *chandef =3D &hw->conf.chandef;
> -
> -	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> -		return;
> -
> -	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
> -	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
> -		return;
> -
> -	if (mphy->chandef.chan->center_freq =3D=3D chandef->chan->center_freq &&
> -	    mphy->chandef.width =3D=3D chandef->width)
> -		return;
> -
> -	phy->dfs_state =3D -1;
> -}
> -
>  int mt7915_set_channel(struct mt7915_phy *phy)
>  {
>  	struct mt7915_dev *dev =3D phy->dev;
> @@ -332,7 +312,6 @@ int mt7915_set_channel(struct mt7915_phy *phy)
>  	mutex_lock(&dev->mt76.mutex);
>  	set_bit(MT76_RESET, &phy->mt76->state);
> =20
> -	mt7915_init_dfs_state(phy);
>  	mt76_set_channel(phy->mt76);
> =20
>  	if (dev->flash_mode) {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index e8c68e47b613..462c7da93b60 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2786,7 +2786,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy=
, int cmd)
> =20
>  	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
>  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> -	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
> +	else if (phy->mt76->hw->conf.radar_enabled &&
>  		 chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
>  		req.switch_reason =3D CH_SWITCH_DFS;
>  	else
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index bc3a3dcdb3a0..96653d64d161 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -230,7 +230,6 @@ struct mt7915_phy {
>  	u8 slottime;
> =20
>  	u8 rdd_state;
> -	int dfs_state;
> =20
>  	u32 rx_ampdu_ts;
>  	u32 ampdu_ref;
> --=20
> 2.32.0 (Apple Git-132)
>=20

--Ky2C091xdo9JUv8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYfvxBQAKCRA6cBh0uS2t
rCmqAP4y0T8+WdVF60/53gVYVC6wKgnYQyv53ppJuPagng50RQD9EeM0dVSl1eIA
mNLB6tFGIOLFuxLfhF570dPbd9Nl9QQ=
=3kcb
-----END PGP SIGNATURE-----

--Ky2C091xdo9JUv8Y--
