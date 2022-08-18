Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0464597F6A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 09:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbiHRHnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbiHRHnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 03:43:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9794BD08
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A2B7CE2014
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 07:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215B0C433C1;
        Thu, 18 Aug 2022 07:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660808584;
        bh=zUBUTbL9EdI7rSM3rhdjmTup41sfS5ehS/yX6YaZc9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls7dzR03hoUyU7CJ+JoVhAln6IMiHk1DvJ/LIAt9uM1hgnj59cD34n/ZcDv8J1jkm
         1Trv3PK72rdkQw2W4SrmWOR0EBOJtVCszttLpi2/Zn1hENeV/BS7RA2P4mQgRFdZ3F
         e4UDvx+H9wuSuRhxryYmtO3qClvmIrTFKKo53cHXivbjQh0KFuVjBQ2JnKALgu2X36
         hn8xnEcTXGCboE00gSIm3iUHQlxzoI7WBJ0198j8SxThmN/qJNkb0A9eNm5lx15Rn2
         26AOZ65CRQWrnZToeaBtXbxJdb5DZLB0A8VXPjyGquaAQvF01qBMVXJuGEEFaDRn6Z
         ThHlQ0o6mJIew==
Date:   Thu, 18 Aug 2022 09:43:01 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang =?utf-8?B?KOeOi+W/l+S6mCk=?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren Wu <Deren.Wu@mediatek.com>, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 9/9] wifi: mt76: mt7921: introduce chanctx support
Message-ID: <Yv3thcH2phpCD+3N@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <3cf2e1a9658e971392b9b42f05f7b2a36815c7af.1660606893.git.objelf@gmail.com>
 <YvyXu4jejY7JOnhn@lore-desk>
 <CAGp9LzqecHa4DzAcugth4EOua8n-tPnS4TmgijETMxkT7fn8gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qNm2QppFA9tQQwk5"
Content-Disposition: inline
In-Reply-To: <CAGp9LzqecHa4DzAcugth4EOua8n-tPnS4TmgijETMxkT7fn8gQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qNm2QppFA9tQQwk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Aug 17, 2022 at 12:42 AM Lorenzo Bianconi <lorenzo@kernel.org> wr=
ote:
> >
> > > From: Sean Wang <sean.wang@mediatek.com>
> > >
> > > The firmware can have the capability to manage the channel context
> > > scheduling on multiple roles running on the device including Station,
> > > AP and P2P GC/GO mode (will be extended based on the patchset) to help
> > > users sharing the network with others on a single device.
> > >
> > > The firmware is able to support the channel chanctx up to 2 interface
> > > simultaneously running on the different channels.
> > >
> > > Another thing to be noted is that before the driver is going sent out=
 the
> > > management frames, the driver has to get the privilege from the firmw=
are
> > > to occupy the current channel context until the frame handshake is
> > > completed and then get the privilege back to the firmware.
> > >
> > > We temporarily disable the feature with a module parameter
> > > mt7921_disable_cnm for a while until we can ensure the patchset doesn=
't
> > > cause any regression.
> > >
> > > Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> > > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  .../net/wireless/mediatek/mt76/mt7921/init.c  |  40 ++++++-
> > >  .../net/wireless/mediatek/mt76/mt7921/main.c  | 111 ++++++++++++++++=
+-
> > >  .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
> > >  3 files changed, 145 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/init.c
> > > index 1b7a18d42f5b..208a6117cb69 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -7,6 +7,10 @@
> > >  #include "mcu.h"
> > >  #include "eeprom.h"
> > >
> > > +static bool mt7921_disable_cnm =3D true;
> > > +module_param_named(disable_cnm, mt7921_disable_cnm, bool, 0644);
> > > +MODULE_PARM_DESC(disable_cnm, "disable concurrent network support");
> >
> > do we need it? I guess we can just leave it enabled by default and disa=
ble it
> > through a debugfs node. What do you think?
>=20
> The kernel parameter would be checked before registering ops to
> mac80211, it seemed to me the way debugfs node doesn't work for that
> moment.

I am wondering if it is ok to just enable it by default, what do you t thin=
k?
It is not a good practise to add a lot of module parameters.

Regards,
Lorenzo

>=20
> >
> > > +
> > >  static const struct ieee80211_iface_limit if_limits[] =3D {
> > >       {
> > >               .max =3D MT7921_MAX_INTERFACES,
> > > @@ -25,6 +29,27 @@ static const struct ieee80211_iface_combination if=
_comb[] =3D {
> > >               .max_interfaces =3D MT7921_MAX_INTERFACES,
> > >               .num_different_channels =3D 1,
> > >               .beacon_int_infra_match =3D true,
> > > +     },
> > > +};
> > > +
> > > +static const struct ieee80211_iface_limit if_limits_chanctx[] =3D {
> > > +     {
> > > +             .max =3D 2,
> > > +             .types =3D BIT(NL80211_IFTYPE_STATION),
> > > +     },
> > > +     {
> > > +             .max =3D 1,
> > > +             .types =3D BIT(NL80211_IFTYPE_AP),
> > > +     }
> > > +};
> > > +
> > > +static const struct ieee80211_iface_combination if_comb_chanctx[] =
=3D {
> > > +     {
> > > +             .limits =3D if_limits_chanctx,
> > > +             .n_limits =3D ARRAY_SIZE(if_limits_chanctx),
> > > +             .max_interfaces =3D 2,
> > > +             .num_different_channels =3D 2,
> > > +             .beacon_int_infra_match =3D false,
> > >       }
> > >  };
> > >
> > > @@ -63,11 +88,20 @@ static int mt7921_check_offload_capability(struct=
 mt7921_dev *dev)
> > >       fw_can_roc =3D  mktime64(year, mon, day, hour, min, sec) >=3D
> > >                     mktime64(2022, 7, 15, 12, 1, 1);
> > >  out:
> > > -     if (!fw_can_roc) {
> > > +     if (!fw_can_roc || mt7921_disable_cnm) {
> > >               dev->ops->remain_on_channel =3D NULL;
> > >               dev->ops->cancel_remain_on_channel =3D NULL;
> > > +             dev->ops->add_chanctx =3D NULL;
> > > +             dev->ops->remove_chanctx =3D NULL;
> > > +             dev->ops->change_chanctx =3D NULL;
> > > +             dev->ops->assign_vif_chanctx =3D NULL;
> > > +             dev->ops->unassign_vif_chanctx =3D NULL;
> > > +             dev->ops->mgd_prepare_tx =3D NULL;
> > > +             dev->ops->mgd_complete_tx =3D NULL;
> > >
> > >               wiphy->flags &=3D ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> > > +             wiphy->iface_combinations =3D if_comb;
> > > +             wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
> > >       }
> > >
> > >       return 0;
> > > @@ -93,12 +127,12 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
> > >       hw->sta_data_size =3D sizeof(struct mt7921_sta);
> > >       hw->vif_data_size =3D sizeof(struct mt7921_vif);
> > >
> > > -     wiphy->iface_combinations =3D if_comb;
> > > +     wiphy->iface_combinations =3D if_comb_chanctx;
> > >       wiphy->flags &=3D ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
> > >                         WIPHY_FLAG_4ADDR_STATION);
> > >       wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
> > >                                BIT(NL80211_IFTYPE_AP);
> > > -     wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
> > > +     wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb_chanctx);
> > >       wiphy->max_remain_on_channel_duration =3D 5000;
> > >       wiphy->max_scan_ie_len =3D MT76_CONNAC_SCAN_IE_LEN;
> > >       wiphy->max_scan_ssids =3D 4;
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/main.c
> > > index ae0aabe052e3..6386290ba71c 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > @@ -858,7 +858,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, =
struct ieee80211_vif *vif,
> > >
> > >       if (vif->type =3D=3D NL80211_IFTYPE_STATION && !sta->tdls)
> > >               mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta=
=2Ewcid,
> > > -                                         true, NULL);
> > > +                                         true, mvif->ctx);
> > >
> > >       mt7921_mac_wtbl_update(dev, msta->wcid.idx,
> > >                              MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> > > @@ -890,7 +890,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev,=
 struct ieee80211_vif *vif,
> > >               if (!sta->tdls)
> > >                       mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
> > >                                                   &mvif->sta.wcid, fa=
lse,
> > > -                                                 NULL);
> > > +                                                 mvif->ctx);
> > >       }
> > >
> > >       spin_lock_bh(&dev->sta_poll_lock);
> > > @@ -1640,7 +1640,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif,
> > >       mt7921_mutex_acquire(dev);
> > >
> > >       err =3D mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.=
wcid,
> > > -                                       true, NULL);
> > > +                                       true, mvif->ctx);
> > >       if (err)
> > >               goto failed;
> > >
> > > @@ -1672,12 +1672,108 @@ mt7921_stop_ap(struct ieee80211_hw *hw, stru=
ct ieee80211_vif *vif,
> > >               goto failed;
> > >
> > >       mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, fa=
lse,
> > > -                                 NULL);
> > > +                                 mvif->ctx);
> > >
> > >  failed:
> > >       mt7921_mutex_release(dev);
> > >  }
> > >
> > > +static int
> > > +mt7921_add_chanctx(struct ieee80211_hw *hw,
> > > +                struct ieee80211_chanctx_conf *ctx)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static void
> > > +mt7921_remove_chanctx(struct ieee80211_hw *hw,
> > > +                   struct ieee80211_chanctx_conf *ctx)
> > > +{
> > > +}
> > > +
> > > +static void mt7921_ctx_iter(void *priv, u8 *mac,
> > > +                         struct ieee80211_vif *vif)
> > > +{
> > > +     struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> > > +     struct ieee80211_chanctx_conf *ctx =3D priv;
> > > +
> > > +     if (ctx !=3D mvif->ctx)
> > > +             return;
> > > +
> > > +     mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx=
);
> > > +}
> > > +
> > > +static void
> > > +mt7921_change_chanctx(struct ieee80211_hw *hw,
> > > +                   struct ieee80211_chanctx_conf *ctx,
> > > +                   u32 changed)
> > > +{
> > > +     struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> > > +
> > > +     mt7921_mutex_acquire(phy->dev);
> > > +     ieee80211_iterate_active_interfaces(phy->mt76->hw,
> > > +                                         IEEE80211_IFACE_ITER_ACTIVE,
> > > +                                         mt7921_ctx_iter, ctx);
> > > +     mt7921_mutex_release(phy->dev);
> > > +}
> > > +
> > > +static int
> > > +mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
> > > +                       struct ieee80211_vif *vif,
> > > +                       struct ieee80211_bss_conf *link_conf,
> > > +                       struct ieee80211_chanctx_conf *ctx)
> > > +{
> > > +     struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> > > +     struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> > > +
> > > +     mt7921_mutex_acquire(dev);
> >
> > I think in this case we can just grub the mutex without waking up the d=
evice.
> > what do you think?
>=20
> ack
>=20
> >
> > > +     mvif->ctx =3D ctx;
> > > +     mt7921_mutex_release(dev);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void
> > > +mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
> > > +                         struct ieee80211_vif *vif,
> > > +                         struct ieee80211_bss_conf *link_conf,
> > > +                         struct ieee80211_chanctx_conf *ctx)
> > > +{
> > > +     struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> > > +     struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> > > +
> > > +     mt7921_mutex_acquire(dev);
> >
> > same here.
>=20
> ack
>=20
> >
> > Regards,
> > Lorenzo
> >
> > > +     mvif->ctx =3D NULL;
> > > +     mt7921_mutex_release(dev);
> > > +}
> > > +
> > > +static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
> > > +                               struct ieee80211_vif *vif,
> > > +                               struct ieee80211_prep_tx_info *info)
> > > +{
> > > +     struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> > > +     struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> > > +     u16 duration =3D info->duration ? info->duration :
> > > +                    jiffies_to_msecs(HZ);
> > > +
> > > +     mt7921_mutex_acquire(dev);
> > > +     mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
> > > +                    MT7921_ROC_REQ_JOIN);
> > > +     mt7921_mutex_release(dev);
> > > +}
> > > +
> > > +static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
> > > +                                struct ieee80211_vif *vif,
> > > +                                struct ieee80211_prep_tx_info *info)
> > > +{
> > > +     struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> > > +     struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> > > +
> > > +     mt7921_mutex_acquire(dev);
> > > +     mt7921_abort_roc(mvif->phy, mvif);
> > > +     mt7921_mutex_release(dev);
> > > +}
> > > +
> > >  const struct ieee80211_ops mt7921_ops =3D {
> > >       .tx =3D mt7921_tx,
> > >       .start =3D mt7921_start,
> > > @@ -1730,6 +1826,13 @@ const struct ieee80211_ops mt7921_ops =3D {
> > >       .set_sar_specs =3D mt7921_set_sar_specs,
> > >       .remain_on_channel =3D mt7921_remain_on_channel,
> > >       .cancel_remain_on_channel =3D mt7921_cancel_remain_on_channel,
> > > +     .add_chanctx =3D mt7921_add_chanctx,
> > > +     .remove_chanctx =3D mt7921_remove_chanctx,
> > > +     .change_chanctx =3D mt7921_change_chanctx,
> > > +     .assign_vif_chanctx =3D mt7921_assign_vif_chanctx,
> > > +     .unassign_vif_chanctx =3D mt7921_unassign_vif_chanctx,
> > > +     .mgd_prepare_tx =3D mt7921_mgd_prepare_tx,
> > > +     .mgd_complete_tx =3D mt7921_mgd_complete_tx,
> > >  };
> > >  EXPORT_SYMBOL_GPL(mt7921_ops);
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/dri=
vers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > index 280605ffc4da..fda85252325c 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > @@ -156,6 +156,7 @@ struct mt7921_vif {
> > >       struct ewma_rssi rssi;
> > >
> > >       struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS=
];
> > > +     struct ieee80211_chanctx_conf *ctx;
> > >  };
> > >
> > >  struct mib_stats {
> > > --
> > > 2.25.1
> > >

--qNm2QppFA9tQQwk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYv3thAAKCRA6cBh0uS2t
rEK6AQCY9jizHJbwnngtPuQi/rPH7++ieKgu+G3ZpozvnUgV4QD9HlPC754W4+PH
kps3TOxNvbous6GcMQ5cBmIe75qvVw0=
=POu2
-----END PGP SIGNATURE-----

--qNm2QppFA9tQQwk5--
