Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD6484003
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jan 2022 11:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiADKjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jan 2022 05:39:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38474 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiADKjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jan 2022 05:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90ACF6131E
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 10:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFFBC36AE9;
        Tue,  4 Jan 2022 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641292764;
        bh=99fQGyW9tghJGlkNYmqgxJrzEIINVcXHnRm8CnH5HXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjA3TKqcmTJe8Eq3nNiGUqKpBVCT/My5e/xyp9T1vtMzkE6rrFPfoT4qmn9vi4xTN
         seLYQULadIdoB0cKvsRZpTkLU94JavWoFDs7VI1Ld+kSGda+gZC/BqosBJ18m9+V/d
         l8MFjjhsGtmC09XSumqRTewbWwBOVVyHVJ4FMCqOLFXbQkGYMoW3A69ieZdAaq7eX/
         NmO/MSTQ6h6bxVmbWE8v4yyPYgbNr12L4KES9c7PtF9JUzsmfKXQfT6OQxvA11mMZw
         BdXAPbd7HYnhW7iKCkafjAT/lMa0DLQCZLZTN9mqvxr+DbQOF0HedFtGIbVLQz0zPx
         KYzyGhCsEXLfg==
Date:   Tue, 4 Jan 2022 11:39:17 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 03/11] mt76: mt7915: support enabling rx group-5 status
Message-ID: <YdQj1Yq9wIIlYbJl@localhost.localdomain>
References: <20211118164056.2965-1-greearb@candelatech.com>
 <20211118164056.2965-3-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ImNV/7ZdXRMywKJL"
Content-Disposition: inline
In-Reply-To: <20211118164056.2965-3-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ImNV/7ZdXRMywKJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> When enabled, this allows per-skb rx rate reporting.
> Enabling this may degrade RX performance, so it remains
> disabled by default.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 33 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 +-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +++
>  5 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index e3f6cd18e30a..32e219a20721 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -435,6 +435,38 @@ mt7915_txs_for_no_skb_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_txs_for_no_skb, mt7915_txs_for_no_skb_get,
>  			 mt7915_txs_for_no_skb_set, "%lld\n");
> =20
> +static int
> +mt7915_rx_group_5_enable_set(void *data, u64 val)
> +{
> +	struct mt7915_dev *dev =3D data;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	dev->rx_group_5_enable =3D !!val;

I think this should be added in mt7915_phy instead of in mt7915_dev since
we have MT_DMA_DCR0() for each band.

> +
> +	/* Enabled if we requested enabled OR if monitor mode is enabled. */
> +	mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
> +		       dev->phy.is_monitor_mode || dev->rx_group_5_enable);

I think we do not need dev->phy.is_monitor_mode, we can check if monitor is
enabled looking at hw->conf.flag.

> +	mt76_testmode_reset(dev->phy.mt76, true);
> +
> +	mutex_unlock(&dev->mt76.mutex);
> +
> +	return 0;
> +}
> +
> +static int
> +mt7915_rx_group_5_enable_get(void *data, u64 *val)
> +{
> +	struct mt7915_dev *dev =3D data;
> +
> +	*val =3D dev->rx_group_5_enable;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_rx_group_5_enable, mt7915_rx_group_5_enabl=
e_get,
> +			 mt7915_rx_group_5_enable_set, "%lld\n");
> +
>  static void
>  mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
>  			   struct seq_file *file)
> @@ -786,6 +818,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
>  	debugfs_create_file("fw_util_wa", 0400, dir, dev,
>  			    &mt7915_fw_util_wa_fops);
>  	debugfs_create_file("force_txs", 0600, dir, dev, &fops_txs_for_no_skb);
> +	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group=
_5_enable);
>  	debugfs_create_file("implicit_txbf", 0600, dir, dev,
>  			    &fops_implicit_txbf);
>  	debugfs_create_file("txpower_sku", 0400, dir, phy,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/init.c
> index 90aa62c64f3e..58a0ce72b714 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -391,7 +391,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
> =20
>  	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
>  	/* disable rx rate report by default due to hw issues */
> -	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
> +	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
> +		       dev->phy.is_monitor_mode || dev->rx_group_5_enable);
>  }
> =20
>  static void mt7915_mac_init(struct mt7915_dev *dev)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 6fbd58ae9c88..a6bcc76dcb03 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -715,7 +715,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb)
>  		status->flag |=3D RX_FLAG_8023;
>  	}
> =20
> -	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
> +	if (phy->is_monitor_mode &&
> +	    rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
>  		mt7915_mac_decode_he_radiotap(skb, status, rxv, mode);
>  		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
>  			mt7915_mac_decode_he_mu_radiotap(skb, status, rxv);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 3d702dc899ba..e973b2527b34 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -458,13 +458,14 @@ static int mt7915_config(struct ieee80211_hw *hw, u=
32 changed)
>  	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
>  		bool enabled =3D !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
> =20
> +		phy->is_monitor_mode =3D enabled;
>  		if (!enabled)
>  			phy->rxfilter |=3D MT_WF_RFCR_DROP_OTHER_UC;
>  		else
>  			phy->rxfilter &=3D ~MT_WF_RFCR_DROP_OTHER_UC;
> =20
>  		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
> -			       enabled);
> +			       phy->is_monitor_mode || dev->rx_group_5_enable);
>  		mt76_testmode_reset(phy->mt76, true);
>  		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 86cd0fc8e9de..84fff60ada92 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -209,6 +209,7 @@ struct mt7915_phy {
>  	struct thermal_cooling_device *cdev;
>  	u8 throttle_state;
>  	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
> +	u8 is_monitor_mode; /* are we in monitor mode or not ? */

not needed

> =20
>  	u32 rxfilter;
>  	u64 omac_mask;
> @@ -261,6 +262,10 @@ struct mt7915_dev {
>  	 * creation by firmware, so may be a performance drag.
>  	 */
>  	bool txs_for_no_skb_enabled;
> +	/* Should we enable group-5 rx descriptor logic?  This may decrease RX
> +	 * throughput, but will give per skb rx rate information..
> +	 */
> +	bool rx_group_5_enable;

move it in mt7915_phy

> =20
>  	struct work_struct init_work;
>  	struct work_struct rc_work;
> --=20
> 2.20.1
>=20

Regards,
Lorenzo

--ImNV/7ZdXRMywKJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYdQj0QAKCRA6cBh0uS2t
rC9bAQC1J7UAXJsSk6ofyv+PXpbGKb5NX1lkmSsnyks2NDHmMQEAmn/agPvFJHdC
CN1r8P8GrDt4Yi6aqhkcWljTB5ojdA0=
=+k7A
-----END PGP SIGNATURE-----

--ImNV/7ZdXRMywKJL--
