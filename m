Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1196596A52
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 09:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiHQHYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHQHYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 03:24:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4F65252
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 00:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA62B81C55
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 07:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5203EC433C1;
        Wed, 17 Aug 2022 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660721086;
        bh=S297iZc0T5xCDuibxovyqMLMAneQ0dt0mTOQAQXvt0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMY9zXfI1U6tMlbgNA8yaCD7Vyf1FXcIMKwamugUryePN+iUWTMxdacmg47Qrjl+4
         zXxT1JVyRfEcvgNJBQ+ZaURqH16Va7Ma7kcxnF9iIIGd6hgePDdFwH/zQUG7MRPkCK
         bioYZ4t3vuytJdDbWFK4j7o+JRp9iYpHfx33B5qKhfJScS4dbqjuDxMNoCA1xiCV5T
         HUFDA0RCPMVHkUca7U6FaRQXQHA0nS1K4wVbm0+8vzS61edQ0sNVCEd4YIfPv40ZNJ
         fKYpBLR3C/bAdDuJtVAZCf8MxTSV6AI3D7xmVHdMCvDxHCNHHvRWY5uaRLCA5yVypX
         p8plEZrdJJc8Q==
Date:   Wed, 17 Aug 2022 09:24:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 9/9] wifi: mt76: mt7921: introduce chanctx support
Message-ID: <YvyXu4jejY7JOnhn@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <3cf2e1a9658e971392b9b42f05f7b2a36815c7af.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4rgfgLTPz5ahT0"
Content-Disposition: inline
In-Reply-To: <3cf2e1a9658e971392b9b42f05f7b2a36815c7af.1660606893.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--HB4rgfgLTPz5ahT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> The firmware can have the capability to manage the channel context
> scheduling on multiple roles running on the device including Station,
> AP and P2P GC/GO mode (will be extended based on the patchset) to help
> users sharing the network with others on a single device.
>=20
> The firmware is able to support the channel chanctx up to 2 interface
> simultaneously running on the different channels.
>=20
> Another thing to be noted is that before the driver is going sent out the
> management frames, the driver has to get the privilege from the firmware
> to occupy the current channel context until the frame handshake is
> completed and then get the privilege back to the firmware.
>=20
> We temporarily disable the feature with a module parameter
> mt7921_disable_cnm for a while until we can ensure the patchset doesn't
> cause any regression.
>=20
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  40 ++++++-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 111 +++++++++++++++++-
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
>  3 files changed, 145 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 1b7a18d42f5b..208a6117cb69 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -7,6 +7,10 @@
>  #include "mcu.h"
>  #include "eeprom.h"
> =20
> +static bool mt7921_disable_cnm =3D true;
> +module_param_named(disable_cnm, mt7921_disable_cnm, bool, 0644);
> +MODULE_PARM_DESC(disable_cnm, "disable concurrent network support");

do we need it? I guess we can just leave it enabled by default and disable =
it
through a debugfs node. What do you think?

> +
>  static const struct ieee80211_iface_limit if_limits[] =3D {
>  	{
>  		.max =3D MT7921_MAX_INTERFACES,
> @@ -25,6 +29,27 @@ static const struct ieee80211_iface_combination if_com=
b[] =3D {
>  		.max_interfaces =3D MT7921_MAX_INTERFACES,
>  		.num_different_channels =3D 1,
>  		.beacon_int_infra_match =3D true,
> +	},
> +};
> +
> +static const struct ieee80211_iface_limit if_limits_chanctx[] =3D {
> +	{
> +		.max =3D 2,
> +		.types =3D BIT(NL80211_IFTYPE_STATION),
> +	},
> +	{
> +		.max =3D 1,
> +		.types =3D BIT(NL80211_IFTYPE_AP),
> +	}
> +};
> +
> +static const struct ieee80211_iface_combination if_comb_chanctx[] =3D {
> +	{
> +		.limits =3D if_limits_chanctx,
> +		.n_limits =3D ARRAY_SIZE(if_limits_chanctx),
> +		.max_interfaces =3D 2,
> +		.num_different_channels =3D 2,
> +		.beacon_int_infra_match =3D false,
>  	}
>  };
> =20
> @@ -63,11 +88,20 @@ static int mt7921_check_offload_capability(struct mt7=
921_dev *dev)
>  	fw_can_roc =3D  mktime64(year, mon, day, hour, min, sec) >=3D
>  		      mktime64(2022, 7, 15, 12, 1, 1);
>  out:
> -	if (!fw_can_roc) {
> +	if (!fw_can_roc || mt7921_disable_cnm) {
>  		dev->ops->remain_on_channel =3D NULL;
>  		dev->ops->cancel_remain_on_channel =3D NULL;
> +		dev->ops->add_chanctx =3D NULL;
> +		dev->ops->remove_chanctx =3D NULL;
> +		dev->ops->change_chanctx =3D NULL;
> +		dev->ops->assign_vif_chanctx =3D NULL;
> +		dev->ops->unassign_vif_chanctx =3D NULL;
> +		dev->ops->mgd_prepare_tx =3D NULL;
> +		dev->ops->mgd_complete_tx =3D NULL;
> =20
>  		wiphy->flags &=3D ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> +		wiphy->iface_combinations =3D if_comb;
> +		wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
>  	}
> =20
>  	return 0;
> @@ -93,12 +127,12 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
>  	hw->sta_data_size =3D sizeof(struct mt7921_sta);
>  	hw->vif_data_size =3D sizeof(struct mt7921_vif);
> =20
> -	wiphy->iface_combinations =3D if_comb;
> +	wiphy->iface_combinations =3D if_comb_chanctx;
>  	wiphy->flags &=3D ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
>  			  WIPHY_FLAG_4ADDR_STATION);
>  	wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
>  				 BIT(NL80211_IFTYPE_AP);
> -	wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
> +	wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb_chanctx);
>  	wiphy->max_remain_on_channel_duration =3D 5000;
>  	wiphy->max_scan_ie_len =3D MT76_CONNAC_SCAN_IE_LEN;
>  	wiphy->max_scan_ssids =3D 4;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index ae0aabe052e3..6386290ba71c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -858,7 +858,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, stru=
ct ieee80211_vif *vif,
> =20
>  	if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
>  		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
> -					    true, NULL);
> +					    true, mvif->ctx);
> =20
>  	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
>  			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> @@ -890,7 +890,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, str=
uct ieee80211_vif *vif,
>  		if (!sta->tdls)
>  			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
>  						    &mvif->sta.wcid, false,
> -						    NULL);
> +						    mvif->ctx);
>  	}
> =20
>  	spin_lock_bh(&dev->sta_poll_lock);
> @@ -1640,7 +1640,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct iee=
e80211_vif *vif,
>  	mt7921_mutex_acquire(dev);
> =20
>  	err =3D mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
> -					  true, NULL);
> +					  true, mvif->ctx);
>  	if (err)
>  		goto failed;
> =20
> @@ -1672,12 +1672,108 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif,
>  		goto failed;
> =20
>  	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
> -				    NULL);
> +				    mvif->ctx);
> =20
>  failed:
>  	mt7921_mutex_release(dev);
>  }
> =20
> +static int
> +mt7921_add_chanctx(struct ieee80211_hw *hw,
> +		   struct ieee80211_chanctx_conf *ctx)
> +{
> +	return 0;
> +}
> +
> +static void
> +mt7921_remove_chanctx(struct ieee80211_hw *hw,
> +		      struct ieee80211_chanctx_conf *ctx)
> +{
> +}
> +
> +static void mt7921_ctx_iter(void *priv, u8 *mac,
> +			    struct ieee80211_vif *vif)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct ieee80211_chanctx_conf *ctx =3D priv;
> +
> +	if (ctx !=3D mvif->ctx)
> +		return;
> +
> +	mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
> +}
> +
> +static void
> +mt7921_change_chanctx(struct ieee80211_hw *hw,
> +		      struct ieee80211_chanctx_conf *ctx,
> +		      u32 changed)
> +{
> +	struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> +
> +	mt7921_mutex_acquire(phy->dev);
> +	ieee80211_iterate_active_interfaces(phy->mt76->hw,
> +					    IEEE80211_IFACE_ITER_ACTIVE,
> +					    mt7921_ctx_iter, ctx);
> +	mt7921_mutex_release(phy->dev);
> +}
> +
> +static int
> +mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
> +			  struct ieee80211_vif *vif,
> +			  struct ieee80211_bss_conf *link_conf,
> +			  struct ieee80211_chanctx_conf *ctx)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> +
> +	mt7921_mutex_acquire(dev);

I think in this case we can just grub the mutex without waking up the devic=
e.
what do you think?

> +	mvif->ctx =3D ctx;
> +	mt7921_mutex_release(dev);
> +
> +	return 0;
> +}
> +
> +static void
> +mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
> +			    struct ieee80211_vif *vif,
> +			    struct ieee80211_bss_conf *link_conf,
> +			    struct ieee80211_chanctx_conf *ctx)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> +
> +	mt7921_mutex_acquire(dev);

same here.

Regards,
Lorenzo

> +	mvif->ctx =3D NULL;
> +	mt7921_mutex_release(dev);
> +}
> +
> +static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
> +				  struct ieee80211_vif *vif,
> +				  struct ieee80211_prep_tx_info *info)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> +	u16 duration =3D info->duration ? info->duration :
> +		       jiffies_to_msecs(HZ);
> +
> +	mt7921_mutex_acquire(dev);
> +	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
> +		       MT7921_ROC_REQ_JOIN);
> +	mt7921_mutex_release(dev);
> +}
> +
> +static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_prep_tx_info *info)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> +
> +	mt7921_mutex_acquire(dev);
> +	mt7921_abort_roc(mvif->phy, mvif);
> +	mt7921_mutex_release(dev);
> +}
> +
>  const struct ieee80211_ops mt7921_ops =3D {
>  	.tx =3D mt7921_tx,
>  	.start =3D mt7921_start,
> @@ -1730,6 +1826,13 @@ const struct ieee80211_ops mt7921_ops =3D {
>  	.set_sar_specs =3D mt7921_set_sar_specs,
>  	.remain_on_channel =3D mt7921_remain_on_channel,
>  	.cancel_remain_on_channel =3D mt7921_cancel_remain_on_channel,
> +	.add_chanctx =3D mt7921_add_chanctx,
> +	.remove_chanctx =3D mt7921_remove_chanctx,
> +	.change_chanctx =3D mt7921_change_chanctx,
> +	.assign_vif_chanctx =3D mt7921_assign_vif_chanctx,
> +	.unassign_vif_chanctx =3D mt7921_unassign_vif_chanctx,
> +	.mgd_prepare_tx =3D mt7921_mgd_prepare_tx,
> +	.mgd_complete_tx =3D mt7921_mgd_complete_tx,
>  };
>  EXPORT_SYMBOL_GPL(mt7921_ops);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 280605ffc4da..fda85252325c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -156,6 +156,7 @@ struct mt7921_vif {
>  	struct ewma_rssi rssi;
> =20
>  	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
> +	struct ieee80211_chanctx_conf *ctx;
>  };
> =20
>  struct mib_stats {
> --=20
> 2.25.1
>=20

--HB4rgfgLTPz5ahT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvyXuwAKCRA6cBh0uS2t
rI0lAQDwAd2tlHlrT3SA6lvijvcak4+Tp1xyEi8FLdw1LTR1eQD/RoqzHsFrcibW
rcZ9RX8gzLXDROlCkL1HpPO7BHkb5gQ=
=p/0x
-----END PGP SIGNATURE-----

--HB4rgfgLTPz5ahT0--
