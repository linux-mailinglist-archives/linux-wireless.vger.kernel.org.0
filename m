Return-Path: <linux-wireless+bounces-29624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB2CAFBF3
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DF1300AFCA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A07228CB8;
	Tue,  9 Dec 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL5ppFrI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D57221554
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279194; cv=none; b=DNtGdnmcPuvFxtYFtT4e4WdXtaZg+HWImrCqU9bpSIIkGXjxXeyMZedWbM85KDFCqfjWyIcGMnyRtO1Kha/kgzz4n9YEkpRqgpsdZZujitYG67nimnd+VXxJJKV+J84MzHpQCYEJEZ2P7WE5M/ICF51mnH2OxA2TpJekQ4tdNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279194; c=relaxed/simple;
	bh=amoMjqp7xLQSCw2ECKhW9piw6Bu0d9HEf10a6fZssxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3lVvQZ30kSEjK+nTAiNkqg14sFPrQ6CgGvRfKPKZwPRBAK+zUbsAHR+tZL0lcFvck8sy+76mgM7e5T6XCwxmV8KkmxTiEFaLsjVw6psOUbFC2YKP7pel19TCJO0WSz7+xtFWHmgc4BpZSrcvOemsUFGLiwTEMLW/8M8PBTiLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL5ppFrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E844C4CEF5;
	Tue,  9 Dec 2025 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765279194;
	bh=amoMjqp7xLQSCw2ECKhW9piw6Bu0d9HEf10a6fZssxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PL5ppFrIoOb5w+MHMn8casV8pH41KTZTbEGA+fm5Nk+nhtfQL67BesMtClxbPmipp
	 cXuHfAxM0X4hptc26el1gGu0L/zAQmBupdIpDxgqFrWqXmuiadp8Uf8fOBdBWIz2WM
	 gJVpZ0NWOQ0FlRgIXXiV3TmDAFCbkhFkjx1C9z3Hi1NirSx1kORFs3T5Wv0/9bcGpT
	 eWuoiCTBgNR3GrhySj54I4AUxplmrM8JM0cfG6OdDyfGnbdnbuOm4FcNEnZGhF0AF5
	 OeUU3sfTtVE+IHy5LZWS+yvxdO5ekCPSKUiXxHMpjhKn+/C19fQLV/gZx8DrcqxEkS
	 ENef2948twPEw==
Date: Tue, 9 Dec 2025 12:19:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH mt76 2/7] wifi: mt76: mt7996: fix the behavior of radar
 detection
Message-ID: <aTgF2MVHFo9fNxHQ@lore-desk>
References: <20251125034639.1416214-1-shayne.chen@mediatek.com>
 <20251125034639.1416214-2-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u/lKbPiqnu0RI2x"
Content-Disposition: inline
In-Reply-To: <20251125034639.1416214-2-shayne.chen@mediatek.com>


--7u/lKbPiqnu0RI2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 25, Shayne Chen wrote:
> From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>=20
> RDD_DET_MODE is a firmware command intended for testing and does not
> pause TX after radar detection, so remove it from the normal flow;
> instead, use the MAC_ENABLE_CTRL firmware command to resume TX after
> the radar-triggered channel switch completes.
>=20
> Fixes: 1529e335f93d ("wifi: mt76: mt7996: rework radar HWRDD idx")
> Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   |  8 +---
>  .../net/wireless/mediatek/mt76/mt7996/main.c  | 20 ++++++++
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 46 ++++++++++++++++---
>  .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  1 +
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +
>  5 files changed, 65 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 2560e2f46e89..ce85d8f1bde6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -2973,7 +2973,7 @@ static void mt7996_dfs_stop_radar_detector(struct m=
t7996_phy *phy)
> =20
>  static int mt7996_dfs_start_rdd(struct mt7996_dev *dev, int rdd_idx)
>  {
> -	int err, region;
> +	int region;
> =20
>  	switch (dev->mt76.region) {
>  	case NL80211_DFS_ETSI:
> @@ -2988,11 +2988,7 @@ static int mt7996_dfs_start_rdd(struct mt7996_dev =
*dev, int rdd_idx)
>  		break;
>  	}
> =20
> -	err =3D mt7996_mcu_rdd_cmd(dev, RDD_START, rdd_idx, region);
> -	if (err < 0)
> -		return err;
> -
> -	return mt7996_mcu_rdd_cmd(dev, RDD_DET_MODE, rdd_idx, 1);
> +	return mt7996_mcu_rdd_cmd(dev, RDD_START, rdd_idx, region);
>  }
> =20
>  static int mt7996_dfs_start_radar_detector(struct mt7996_phy *phy)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 9b4bfb071292..18c6cdaae20b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -79,6 +79,7 @@ static void mt7996_stop_phy(struct mt7996_phy *phy)
> =20
>  	mutex_lock(&dev->mt76.mutex);
> =20
> +	mt7996_mcu_rdd_resume_tx(phy);
>  	mt7996_mcu_set_radio_en(phy, false);
> =20
>  	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> @@ -954,6 +955,24 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
>  	mutex_unlock(&dev->mt76.mutex);
>  }
> =20
> +static int
> +mt7996_post_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif=
 *vif,
> +			   struct ieee80211_bss_conf *link_conf)
> +{
> +	struct cfg80211_chan_def *chandef =3D &link_conf->chanreq.oper;
> +	struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
> +	struct mt7996_phy *phy =3D mt7996_band_phy(dev, chandef->chan->band);
> +	int ret;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	ret =3D mt7996_mcu_rdd_resume_tx(phy);
> +
> +	mutex_unlock(&dev->mt76.mutex);
> +
> +	return ret;
> +}
> +
>  static int
>  mt7996_mac_sta_init_link(struct mt7996_dev *dev,
>  			 struct ieee80211_bss_conf *link_conf,
> @@ -2327,6 +2346,7 @@ const struct ieee80211_ops mt7996_ops =3D {
>  	.release_buffered_frames =3D mt76_release_buffered_frames,
>  	.get_txpower =3D mt7996_get_txpower,
>  	.channel_switch_beacon =3D mt7996_channel_switch_beacon,
> +	.post_channel_switch =3D mt7996_post_channel_switch,
>  	.get_stats =3D mt7996_get_stats,
>  	.get_et_sset_count =3D mt7996_get_et_sset_count,
>  	.get_et_stats =3D mt7996_get_et_stats,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 7be03bbf34d4..c18c809ac77a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -520,24 +520,32 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev=
, struct sk_buff *skb)
>  		break;
>  	case MT_RDD_IDX_BACKGROUND:
>  		if (!dev->rdd2_phy)
> -			return;
> +			goto err;
>  		mphy =3D dev->rdd2_phy->mt76;
>  		break;
>  	default:
> -		dev_err(dev->mt76.dev, "Unknown RDD idx %d\n", r->rdd_idx);
> -		return;
> +		goto err;
>  	}
> =20
>  	if (!mphy)
> -		return;
> +		goto err;
> =20
> -	if (r->rdd_idx =3D=3D MT_RDD_IDX_BACKGROUND)
> +	if (r->rdd_idx =3D=3D MT_RDD_IDX_BACKGROUND) {
>  		cfg80211_background_radar_event(mphy->hw->wiphy,
>  						&dev->rdd2_chandef,
>  						GFP_ATOMIC);
> -	else
> +	} else {
> +		struct mt7996_phy *phy =3D mphy->priv;
> +
> +		phy->rdd_tx_paused =3D true;
>  		ieee80211_radar_detected(mphy->hw, NULL);
> +	}
>  	dev->hw_pattern++;
> +
> +	return;
> +
> +err:
> +	dev_err(dev->mt76.dev, "Invalid RDD idx %d\n", r->rdd_idx);
>  }
> =20
>  static void
> @@ -4610,6 +4618,32 @@ int mt7996_mcu_set_radio_en(struct mt7996_phy *phy=
, bool enable)
>  				 &req, sizeof(req), true);
>  }
> =20
> +int mt7996_mcu_rdd_resume_tx(struct mt7996_phy *phy)
> +{
> +	struct {
> +		u8 band_idx;
> +		u8 _rsv[3];
> +
> +		__le16 tag;
> +		__le16 len;
> +		u8 mac_enable;
> +		u8 _rsv2[3];
> +	} __packed req =3D {
> +		.band_idx =3D phy->mt76->band_idx,
> +		.tag =3D cpu_to_le16(UNI_BAND_CONFIG_MAC_ENABLE_CTRL),
> +		.len =3D cpu_to_le16(sizeof(req) - 4),
> +		.mac_enable =3D 2,
> +	};
> +
> +	if (!phy->rdd_tx_paused)
> +		return 0;
> +
> +	phy->rdd_tx_paused =3D false;

should you check the return value of mt76_mcu_send_msg() before setting
rdd_tx_paused to false here?

Regards,
Lorenzo

> +
> +	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_WM_UNI_CMD(BAND_CONFIG),
> +				 &req, sizeof(req), true);
> +}
> +
>  int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 rdd_idx, u8 v=
al)
>  {
>  	struct {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.h
> index fc8b09e76f01..5b3597ca79be 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> @@ -835,6 +835,7 @@ enum {
>  enum {
>  	UNI_BAND_CONFIG_RADIO_ENABLE,
>  	UNI_BAND_CONFIG_RTS_THRESHOLD =3D 0x08,
> +	UNI_BAND_CONFIG_MAC_ENABLE_CTRL =3D 0x0c,
>  };
> =20
>  enum {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 7a884311800e..d31864f973cc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -377,6 +377,7 @@ struct mt7996_phy {
> =20
>  	bool has_aux_rx;
>  	bool counter_reset;
> +	bool rdd_tx_paused;
>  };
> =20
>  struct mt7996_dev {
> @@ -726,6 +727,7 @@ int mt7996_mcu_get_temperature(struct mt7996_phy *phy=
);
>  int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
>  int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
>  int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy);
> +int mt7996_mcu_rdd_resume_tx(struct mt7996_phy *phy);
>  int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 rdd_idx, u8 v=
al);
>  int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
>  				     struct cfg80211_chan_def *chandef);
> --=20
> 2.51.0
>=20

--7u/lKbPiqnu0RI2x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaTgF2AAKCRA6cBh0uS2t
rNbEAP47Y/VZCHtiOF21Rj5+0olveOrvHIVDgauXObmR0xjbjgEAslwKOdKp6nk5
iaKpCbLihG1Ntz/wQd8QXDqivxyf2wM=
=zrln
-----END PGP SIGNATURE-----

--7u/lKbPiqnu0RI2x--

