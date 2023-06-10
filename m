Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3843972AAC9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFJKE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJKE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 06:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA130D2
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 03:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD9E60F32
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 10:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB62AC433EF;
        Sat, 10 Jun 2023 10:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686391492;
        bh=UlJekUVniYTdC1hsxBRYSFyX/xS7x5QwHTv6iUEsUf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEIoA7I9zlRjyN7lHJd84bO+qGR8jaLPTI6w0yyQfJGW1HNLkpCk/9B4ZgHP662Cz
         q7NeYH9UvOoRGKG+NUDxbOnpDUsdsC7AphR41/33WvICpx2/IjuvIPabZKXiGjZtzw
         bPnhrWZBv1VjhAaoE+2dfoC9O7BRNtkhSlwn6aTbdaSw2c1fZSRzL+o06egPoORmHj
         7pAGcIEf3eZUDyJVCE1jILaukq1bfBWGGpQ3rlXBRMo/aGCG132++P//pCkf4nxlMK
         xKFG0CmAOr8cG3aaRa+7qxU27FnqqZmg5G6S+4SsxOdlKQv1RNyxLylkA78Pocz78w
         tfNYhYw5qWweA==
Date:   Sat, 10 Jun 2023 12:06:31 +0200
From:   "lorenzo@kernel.org" <lorenzo@kernel.org>
To:     shayne.chen@mediatek.com
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        Evelyn Tsai =?utf-8?B?KOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        Deren Wu =?utf-8?B?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Subject: Re: [PATCH v2 15/15] wifi: mt76: connac: add connac3 mac library
Message-ID: <ZIRLJ/8gt5l/2JAt@localhost.localdomain>
References: <cover.1686298162.git.lorenzo@kernel.org>
 <b7a029d6dfee8e58c58f483ea9e9e7b3bc8012b9.1686298162.git.lorenzo@kernel.org>
 <5010e5e508e89041451288659390fde5ded94db5.camel@mediatek.com>
 <ZINUnqkElqSOITxT@localhost.localdomain>
 <82971c76999ae90be44a524fb95141c5051a9ba0.camel@mediatek.com>
 <ZINXGP6TmDLaZ+lu@localhost.localdomain>
 <PH8PR12MB7230DC95457EF9C667E679AEAC51A@PH8PR12MB7230.namprd12.prod.outlook.com>
 <3cae89c45b0f17eaab20876eb50572ef202f92bc.camel@mediatek.com>
 <d58e857d79ee13752c4d770f80634b2f6c817aa8.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yyVozfcGuQO9tV6r"
Content-Disposition: inline
In-Reply-To: <d58e857d79ee13752c4d770f80634b2f6c817aa8.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--yyVozfcGuQO9tV6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2023-06-10 at 02:47 +0800, Shayne Chen wrote:
> > > > On Fri, 2023-06-09 at 18:34 +0200, lorenzo.bianconi@redhat.com
> > >=20
> > > wrote:
> > > > > On Jun 09, Ryder Lee wrote:
> > > > > > On Fri, 2023-06-09 at 10:15 +0200, Lorenzo Bianconi wrote:
> > > > > > >  =20
> > > > > > > External email : Please do not click links or open
> > >=20
> > > attachments=20
> > > > > > > until you have verified the sender or the content.
> > > > > > >  Introduce connac3_mac in mt76_connac library to reuse mac
> > >=20
> > > code=20
> > > > > > > shared between WiFi7 chipsets.
> > > > > > >=20
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > Hi Lorenzo,

Hi Shayne,

> >=20
> > I don't think it's a good idea to start sharing mac or mcu functions
> > for all WiFi7 chipsets at such early stage.
> >=20
> > The driver is still under many processes of bug fixing, performance
> > tuning, and new features development.
> > Chipsets that mainly used for AP or STA segment have different
> > designs
> > and should face different problems.
> >=20
> > Start sharing the code at early stage will break the independence,
> > make
> > it more hard to develop and do verifications, since many changes will
> > affect chipsets of both segments.

my goal is to share the code that hardly will be changed (or that will have
very few changes in the future, i.e. I have not changed mcu codebase).
If you consider for example the routines below:

- mt76_connac*_mac_write_txwi_8023()
- mt76_connac*_mac_write_txwi_80211()
- mt76_connac*_mac_add_txs_skb()
- mt76_connac*_txwi_free()
- ...

they are the same for mt7615/mt7663, mt7921/mt7915, mt7996/.. , what is
changing is just register map between versions (e.g. mt7615/mt7663 and
mt7915/mt7921). I think it is not a good idea to copy-paste the code
because it will just make the code much harder to maintain, and this will be
more difficult to address in the future.
If you consider the commit below:

commit ead449023d3acb1424886d7b8cc672ed69bdd27e
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sun May 28 12:28:49 2023 +0200

    wifi: mt76: mt7996: fix possible NULL pointer dereference in mt7996_mac=
_write_txwi()

    Fix possible NULL pointer dereference on mvif pointer in
    mt7996_mac_write_txwi routine.

Deren will needs to monitor the ML and apply the same fix for the other WiF=
i7
chipset too.

Moreover I kept mt7996/mac.{c,h} to put the per-chipset codebase.
If you think MT76_CONNAC3_BASIC_RATES_TBL11 and MT76_CONNAC3_BEACON_RATES_T=
BL25
are sensible, we can put them in mt7996/mac.h

Regards,
Lorenzo

> >=20
> > Thanks,
> > Shayne
> >=20
> (Resend for missing CC)
>=20
> > > > > > > ---
> > > > > > >  drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
> > > > > > >  .../net/wireless/mediatek/mt76/mt76_connac.h  |  19 + =20
> > > > > > > .../wireless/mediatek/mt76/mt76_connac3_mac.c | 742
> > > > > > > +++++++++++++++++
> > > > > > >  .../wireless/mediatek/mt76/mt76_connac3_mac.h |  18 +
> > > > > > >  .../net/wireless/mediatek/mt76/mt7996/init.c  |   4 +-
> > > > > > >  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 761 +-----
> > > > > > > --
> > >=20
> > > ----
> > > > > > > ----
> > > > > > > --
> > > > > > >  .../net/wireless/mediatek/mt76/mt7996/main.c  |   8 +-
> > > > > > >  .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   9 +-
> > > > > > >  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  28 +-
> > > > > > >  9 files changed, 807 insertions(+), 784 deletions(-
> > >=20
> > > )  create=20
> > > > > > > mode 100644=20
> > > > > > > drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > > > > > >=20
> > > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/Makefile
> > > > > > > b/drivers/net/wireless/mediatek/mt76/Makefile
> > > > > > > index 84c99b7e57f9..d8e8079c8b54 100644
> > > > > > > --- a/drivers/net/wireless/mediatek/mt76/Makefile
> > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/Makefile
> > > > > > > @@ -27,7 +27,7 @@ mt76x02-lib-y :=3D mt76x02_util.o
> > >=20
> > > mt76x02_mac.o=20
> > > > > > > mt76x02_mcu.o \
> > > > > > > =20
> > > > > > >  mt76x02-usb-y :=3D mt76x02_usb_mcu.o mt76x02_usb_core.o
> > > > > > > =20
> > > > > > > -mt76-connac-lib-y :=3D mt76_connac_mcu.o mt76_connac_mac.o
> > > > > > > +mt76-connac-lib-y :=3D mt76_connac_mcu.o mt76_connac_mac.o
> > > > > > > mt76_connac3_mac.o
> > > > > > > =20
> > > > > > >  obj-$(CONFIG_MT76x0_COMMON) +=3D mt76x0/
> > > > > > >  obj-$(CONFIG_MT76x2_COMMON) +=3D mt76x2/ diff --git=20
> > > > > > > a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > > > > > b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > > > > > index 68bdeada1421..20111678537b 100644
> > > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > > > > > @@ -415,4 +415,23 @@ void mt76_connac2_txwi_free(struct
> > >=20
> > > mt76_dev=20
> > > > > > > *dev, struct mt76_txwi_cache *t,
> > > > > > >      struct list_head *free_list);  void=20
> > > > > > > mt76_connac2_tx_token_put(struct mt76_dev *dev);
> > > > > > > =20
> > > > > > > +/* connac3 */
> > > > > > > +void mt76_connac3_tx_check_aggr(struct ieee80211_sta *sta,
> > > > > > > __le32
> > > > > > > *txwi);
> > > > > > > +void mt76_connac3_mac_decode_he_radiotap(struct sk_buff
> > >=20
> > > *skb,
> > > > > > > __le32
> > > > > > > *rxv,
> > > > > > > + u8 mode);
> > > > > > > +int mt76_connac3_mac_fill_rx_rate(struct mt76_dev *dev,
> > > > > > > +  struct mt76_rx_status *status,
> > > > > > > +  struct ieee80211_supported_band
> > > > > > > *sband,
> > > > > > > +  __le32 *rxv, u8 *mode);
> > > > > > > +void mt76_connac3_mac_write_txwi(struct mt76_dev *dev,
> > >=20
> > > __le32
> > > > > > > *txwi,
> > > > > > > + struct sk_buff *skb, struct mt76_wcid
> > > > > > > *wcid,
> > > > > > > + struct ieee80211_key_conf *key, int
> > > > > > > pid,
> > > > > > > + enum mt76_txq_id qid, u32 changed); void=20
> > > > > > > +mt76_connac3_txwi_free(struct mt76_dev *dev, struct
> > > > > > > mt76_txwi_cache *t,
> > > > > > > +    struct ieee80211_sta *sta,
> > > > > > > +    struct list_head *free_list); void=20
> > > > > > > +mt76_connac3_mac_add_txs(struct mt76_dev *dev, void *data,
> > > > > > > +      u32 max_wtbl_size);
> > > > > > > +void mt76_connac3_tx_token_put(struct mt76_dev *dev);
> > > > > > > +
> > > > > > >  #endif /* __MT76_CONNAC_H */
> > > > > > > diff --git
> > > > > > > a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > > > > > > b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..4b745bb74ca0
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> > > > > > > @@ -0,0 +1,742 @@
> > > > > > > +// SPDX-License-Identifier: ISC
> > > > > > > +/* Copyright (C) 2023 MediaTek Inc. */
> > > > > > > +
> > > > > > > +#include "mt76_connac.h"
> > > > > > > +#include "mt76_connac3_mac.h"
> > > > > > > +#include "dma.h"
> > > > > > > +
> > > > > > > +#define HE_BITS(f)cpu_to_le16(IEEE80211_RADIOTAP_
> > > > > > > HE_##f)
> > > > > > > +#define HE_PREP(f, m, v)le16_encode_bits(le32_get_bits(v,
> > > > > > > MT_CRXV_HE_##m),\
> > > > > > > + IEEE80211_RADIOTAP_HE_
> > > > > > > ##f)
> > > > > > > +
> > > > > > > +void mt76_connac3_tx_check_aggr(struct ieee80211_sta *sta,
> > > > > > > __le32
> > > > > > > *txwi)
> > > > > > > +{
> > > > > > > +struct mt76_wcid *wcid;
> > > > > > > +u16 fc, tid;
> > > > > > > +u32 val;
> > > > > > > +
> > > > > > > +if (!sta ||
> > > > > > > +    !(sta->deflink.ht_cap.ht_supported || sta-
> > > > > > > > deflink.he_cap.has_he))
> > > > > > >=20
> > > > > > > +return;
> > > > > > > +
> > > > > > > +tid =3D le32_get_bits(txwi[1], MT_TXD1_TID);
> > > > > > > +if (tid >=3D 6) /* skip VO queue */
> > > > > > > +return;
> > > > > > > +
> > > > > > > +val =3D le32_to_cpu(txwi[2]);
> > > > > > > +fc =3D FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
> > > > > > > +     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
> > > > > > > +if (unlikely(fc !=3D (IEEE80211_FTYPE_DATA |
> > > > > > > IEEE80211_STYPE_QOS_DATA)))
> > > > > > > +return;
> > > > > > > +
> > > > > > > +wcid =3D (struct mt76_wcid *)sta->drv_priv;
> > > > > > > +if (!test_and_set_bit(tid, &wcid->ampdu_state))
> > > > > > > +ieee80211_start_tx_ba_session(sta, tid, 0); }=20
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_tx_check_aggr);
> > > > > > > +
> > > > > > > +static void
> > > > > > > +mt76_connac3_mac_decode_he_radiotap_ru(struct
> > > > > > > mt76_rx_status
> > > > > > > *status,
> > > > > > > +       struct ieee80211_radiotap_he
> > > > > > > *he,
> > > > > > > +       __le32 *rxv)
> > > > > > > +{
> > > > > > > +u32 ru =3D le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC), offs
> > > > > > > =3D
> > >=20
> > > 0;
> > > > > > > +
> > > > > > > +status->bw =3D RATE_INFO_BW_HE_RU;
> > > > > > > +
> > > > > > > +switch (ru) {
> > > > > > > +case 0 ... 36:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_26;
> > > > > > > +offs =3D ru;
> > > > > > > +break;
> > > > > > > +case 37 ... 52:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_52;
> > > > > > > +offs =3D ru - 37;
> > > > > > > +break;
> > > > > > > +case 53 ... 60:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_106;
> > > > > > > +offs =3D ru - 53;
> > > > > > > +break;
> > > > > > > +case 61 ... 64:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_242;
> > > > > > > +offs =3D ru - 61;
> > > > > > > +break;
> > > > > > > +case 65 ... 66:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_484;
> > > > > > > +offs =3D ru - 65;
> > > > > > > +break;
> > > > > > > +case 67:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_996;
> > > > > > > +break;
> > > > > > > +case 68:
> > > > > > > +status->he_ru =3D NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
> > > > > > > +break;
> > > > > > > +}
> > > > > > > +
> > > > > > > +he->data1 |=3D HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
> > > > > > > +he->data2 |=3D HE_BITS(DATA2_RU_OFFSET_KNOWN) |
> > > > > > > +     le16_encode_bits(offs,
> > > > > > > +      IEEE80211_RADIOTAP_HE_DATA2_RU_OF
> > > > > > > FSET);
> > > > > > > +}
> > > > > > > +
> > > > > > > +#define MU_PREP(f, v)le16_encode_bits(v,
> > > > > > > IEEE80211_RADIOTAP_HE_MU_##f)
> > > > > > > +static void
> > > > > > > +mt76_connac3_mac_decode_he_mu_radiotap(struct sk_buff
> > > > > > > *skb,
> > > > > > > __le32
> > > > > > > *rxv)
> > > > > > > +{
> > > > > > > +struct mt76_rx_status *status =3D (struct mt76_rx_status
> > >=20
> > > *)skb-
> > > > > > > > cb;
> > > > > > >=20
> > > > > > > +static const struct ieee80211_radiotap_he_mu mu_known =3D {
> > > > > > > +.flags1 =3D HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
> > > > > > > +  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
> > > > > > > +  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
> > > > > > > +  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
> > > > > > > +.flags2 =3D HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
> > > > > > > +};
> > > > > > > +struct ieee80211_radiotap_he_mu *he_mu;
> > > > > > > +
> > > > > > > +status->flag |=3D RX_FLAG_RADIOTAP_HE_MU;
> > > > > > > +
> > > > > > > +he_mu =3D skb_push(skb, sizeof(mu_known));
> > > > > > > +memcpy(he_mu, &mu_known, sizeof(mu_known));
> > > > > > > +
> > > > > > > +he_mu->flags1 |=3D MU_PREP(FLAGS1_SIG_B_MCS, status-
> > > >=20
> > > > rate_idx);
> > > > > > > +if (status->he_dcm)
> > > > > > > +he_mu->flags1 |=3D MU_PREP(FLAGS1_SIG_B_DCM, status-
> > > > > > > > he_dcm);
> > > > > > >=20
> > > > > > > +
> > > > > > > +he_mu->flags2 |=3D MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status-
> > > >=20
> > > > bw) |
> > > > > > > + MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
> > > > > > > + le32_get_bits(rxv[4],
> > > > > > > MT_CRXV_HE_NUM_USER));
> > > > > > > +
> > > > > > > +he_mu->ru_ch1[0] =3D le32_get_bits(rxv[16], MT_CRXV_HE_RU0)
> > > > > > > &
> > > > > > > 0xff;
> > > > > > > +
> > > > > > > +if (status->bw >=3D RATE_INFO_BW_40) {
> > > > > > > +he_mu->flags1 |=3D HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
> > > > > > > +he_mu->ru_ch2[0] =3D le32_get_bits(rxv[16],
> > > > > > > MT_CRXV_HE_RU1) & 0xff;
> > > > > > > +}
> > > > > > > +
> > > > > > > +if (status->bw >=3D RATE_INFO_BW_80) {
> > > > > > > +u32 ru_h, ru_l;
> > > > > > > +
> > > > > > > +he_mu->ru_ch1[1] =3D le32_get_bits(rxv[16],
> > > > > > > MT_CRXV_HE_RU2) & 0xff;
> > > > > > > +
> > > > > > > +ru_l =3D le32_get_bits(rxv[16], MT_CRXV_HE_RU3_L);
> > > > > > > +ru_h =3D le32_get_bits(rxv[17], MT_CRXV_HE_RU3_H) & 0x7;
> > > > > > > +he_mu->ru_ch2[1] =3D (u8)(ru_l | ru_h << 4);
> > > > > > > +}
> > > > > > > +}
> > > > > > > +
> > > > > > > +void mt76_connac3_mac_decode_he_radiotap(struct sk_buff
> > >=20
> > > *skb,
> > > > > > > __le32
> > > > > > > *rxv,
> > > > > > > + u8 mode)
> > > > > > > +{
> > > > > > > +struct mt76_rx_status *status =3D (struct mt76_rx_status
> > >=20
> > > *)skb-
> > > > > > > > cb;
> > > > > > >=20
> > > > > > > +static const struct ieee80211_radiotap_he known =3D {
> > > > > > > +.data1 =3D HE_BITS(DATA1_DATA_MCS_KNOWN) |
> > > > > > > + HE_BITS(DATA1_DATA_DCM_KNOWN) |
> > > > > > > + HE_BITS(DATA1_STBC_KNOWN) |
> > > > > > > + HE_BITS(DATA1_CODING_KNOWN) |
> > > > > > > + HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
> > > > > > > + HE_BITS(DATA1_DOPPLER_KNOWN) |
> > > > > > > + HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
> > > > > > > + HE_BITS(DATA1_BSS_COLOR_KNOWN),
> > > > > > > +.data2 =3D HE_BITS(DATA2_GI_KNOWN) |
> > > > > > > + HE_BITS(DATA2_TXBF_KNOWN) |
> > > > > > > + HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
> > > > > > > + HE_BITS(DATA2_TXOP_KNOWN),
> > > > > > > +};
> > > > > > > +u32 ltf_size =3D le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE)
> > > > > > > +
> > >=20
> > > 1;
> > > > > > > +struct ieee80211_radiotap_he *he;
> > > > > > > +
> > > > > > > +status->flag |=3D RX_FLAG_RADIOTAP_HE;
> > > > > > > +
> > > > > > > +he =3D skb_push(skb, sizeof(known));
> > > > > > > +memcpy(he, &known, sizeof(known));
> > > > > > > +
> > > > > > > +he->data3 =3D HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[9]) |
> > > > > > > +    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[4]);
> > > > > > > +he->data4 =3D HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK,
> > >=20
> > > rxv[13]);
> > > > > > > +he->data5 =3D HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG,
> > > > > > > rxv[5])
> > > > > > > +    le16_encode_bits(ltf_size,
> > > > > > > +     IEEE80211_RADIOTAP_HE_DATA5_LTF_SI
> > > > > > > ZE);
> > > > > > > +if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
> > > > > > > +he->data5 |=3D HE_BITS(DATA5_TXBF);
> > > > > > > +he->data6 =3D HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[9]) |
> > > > > > > +    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[9]);
> > > > > > > +
> > > > > > > +switch (mode) {
> > > > > > > +case MT_PHY_TYPE_HE_SU:
> > > > > > > +he->data1 |=3D HE_BITS(DATA1_FORMAT_SU) |
> > > > > > > +     HE_BITS(DATA1_UL_DL_KNOWN) |
> > > > > > > +     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
> > > > > > > +     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
> > > > > > > +
> > > > > > > +he->data3 |=3D HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG,
> > > > > > > rxv[8]) |
> > > > > > > +     HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HE_EXT_SU:
> > > > > > > +he->data1 |=3D HE_BITS(DATA1_FORMAT_EXT_SU) |
> > > > > > > +     HE_BITS(DATA1_UL_DL_KNOWN) |
> > > > > > > +     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
> > > > > > > +
> > > > > > > +he->data3 |=3D HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HE_MU:
> > > > > > > +he->data1 |=3D HE_BITS(DATA1_FORMAT_MU) |
> > > > > > > +     HE_BITS(DATA1_UL_DL_KNOWN);
> > > > > > > +
> > > > > > > +he->data3 |=3D HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
> > > > > > > +he->data4 |=3D HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[8]);
> > > > > > > +
> > > > > > > +mt76_connac3_mac_decode_he_radiotap_ru(status, he,
> > > > > > > rxv);
> > > > > > > +mt76_connac3_mac_decode_he_mu_radiotap(skb, rxv);
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HE_TB:
> > > > > > > +he->data1 |=3D HE_BITS(DATA1_FORMAT_TRIG) |
> > > > > > > +     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
> > > > > > > +     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
> > > > > > > +     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
> > > > > > > +
> > > > > > > +he->data4 |=3D HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK,
> > > > > > > rxv[13]) |
> > > > > > > +     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK,
> > > > > > > rxv[13]) |
> > > > > > > +     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK,
> > > > > > > rxv[13]) |
> > > > > > > +     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK,
> > > > > > > rxv[13]);
> > > > > > > +
> > > > > > > +mt76_connac3_mac_decode_he_radiotap_ru(status, he,
> > > > > > > rxv);
> > > > > > > +break;
> > > > > > > +default:
> > > > > > > +break;
> > > > > > > +}
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_mac_decode_he_radiotap);
> > > > > > > +
> > > > > > > +int mt76_connac3_mac_fill_rx_rate(struct mt76_dev *dev,
> > > > > > > +  struct mt76_rx_status *status,
> > > > > > > +  struct ieee80211_supported_band
> > > > > > > *sband,
> > > > > > > +  __le32 *rxv, u8 *mode)
> > > > > > > +{
> > > > > > > +u8 stbc, gi, bw, dcm, nss;
> > > > > > > +bool cck =3D false;
> > > > > > > +u32 v0, v2;
> > > > > > > +int i, idx;
> > > > > > > +
> > > > > > > +v0 =3D le32_to_cpu(rxv[0]);
> > > > > > > +v2 =3D le32_to_cpu(rxv[2]);
> > > > > > > +
> > > > > > > +idx =3D FIELD_GET(MT_PRXV_TX_RATE, v0);
> > > > > > > +i =3D idx;
> > > > > > > +nss =3D FIELD_GET(MT_PRXV_NSTS, v0) + 1;
> > > > > > > +
> > > > > > > +stbc =3D FIELD_GET(MT_PRXV_HT_STBC, v2);
> > > > > > > +gi =3D FIELD_GET(MT_PRXV_HT_SHORT_GI, v2);
> > > > > > > +*mode =3D FIELD_GET(MT_PRXV_TX_MODE, v2);
> > > > > > > +dcm =3D FIELD_GET(MT_PRXV_DCM, v2);
> > > > > > > +bw =3D FIELD_GET(MT_PRXV_FRAME_MODE, v2);
> > > > > > > +
> > > > > > > +switch (*mode) {
> > > > > > > +case MT_PHY_TYPE_CCK:
> > > > > > > +cck =3D true;
> > > > > > > +fallthrough;
> > > > > > > +case MT_PHY_TYPE_OFDM:
> > > > > > > +i =3D mt76_get_rate(dev, sband, i, cck);
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HT_GF:
> > > > > > > +case MT_PHY_TYPE_HT:
> > > > > > > +status->encoding =3D RX_ENC_HT;
> > > > > > > +if (gi)
> > > > > > > +status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
> > > > > > > +if (i > 31)
> > > > > > > +return -EINVAL;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_VHT:
> > > > > > > +status->nss =3D nss;
> > > > > > > +status->encoding =3D RX_ENC_VHT;
> > > > > > > +if (gi)
> > > > > > > +status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
> > > > > > > +if (i > 11)
> > > > > > > +return -EINVAL;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HE_MU:
> > > > > > > +case MT_PHY_TYPE_HE_SU:
> > > > > > > +case MT_PHY_TYPE_HE_EXT_SU:
> > > > > > > +case MT_PHY_TYPE_HE_TB:
> > > > > > > +status->nss =3D nss;
> > > > > > > +status->encoding =3D RX_ENC_HE;
> > > > > > > +i &=3D GENMASK(3, 0);
> > > > > > > +
> > > > > > > +if (gi <=3D NL80211_RATE_INFO_HE_GI_3_2)
> > > > > > > +status->he_gi =3D gi;
> > > > > > > +
> > > > > > > +status->he_dcm =3D dcm;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_EHT_SU:
> > > > > > > +case MT_PHY_TYPE_EHT_TRIG:
> > > > > > > +case MT_PHY_TYPE_EHT_MU:
> > > > > > > +status->nss =3D nss;
> > > > > > > +status->encoding =3D RX_ENC_EHT;
> > > > > > > +i &=3D GENMASK(3, 0);
> > > > > > > +
> > > > > > > +if (gi <=3D NL80211_RATE_INFO_EHT_GI_3_2)
> > > > > > > +status->eht.gi =3D gi;
> > > > > > > +break;
> > > > > > > +default:
> > > > > > > +return -EINVAL;
> > > > > > > +}
> > > > > > > +status->rate_idx =3D i;
> > > > > > > +
> > > > > > > +switch (bw) {
> > > > > > > +case IEEE80211_STA_RX_BW_20:
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_40:
> > > > > > > +if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
> > > > > > > +    (idx & MT_PRXV_TX_ER_SU_106T)) {
> > > > > > > +status->bw =3D RATE_INFO_BW_HE_RU;
> > > > > > > +status->he_ru =3D
> > > > > > > +NL80211_RATE_INFO_HE_RU_ALLOC_106;
> > > > > > > +} else {
> > > > > > > +status->bw =3D RATE_INFO_BW_40;
> > > > > > > +}
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_80:
> > > > > > > +status->bw =3D RATE_INFO_BW_80;
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_160:
> > > > > > > +status->bw =3D RATE_INFO_BW_160;
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_320:
> > > > > > > +status->bw =3D RATE_INFO_BW_320;
> > > > > > > +break;
> > > > > > > +default:
> > > > > > > +return -EINVAL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +status->enc_flags |=3D RX_ENC_FLAG_STBC_MASK * stbc;
> > > > > > > +if (*mode < MT_PHY_TYPE_HE_SU && gi)
> > > > > > > +status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
> > > > > > > +
> > > > > > > +return 0;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_mac_fill_rx_rate);
> > > > > > > +
> > > > > > > +static void
> > > > > > > +mt76_connac3_mac_write_txwi_8023(__le32 *txwi, struct
> > >=20
> > > sk_buff
> > > > > > > *skb,
> > > > > > > + struct mt76_wcid *wcid)
> > > > > > > +{
> > > > > > > +u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TID_MASK;
> > > > > > > +u8 fc_type, fc_stype;
> > > > > > > +u16 ethertype;
> > > > > > > +bool wmm =3D false;
> > > > > > > +u32 val;
> > > > > > > +
> > > > > > > +if (wcid->sta) {
> > > > > > > +struct ieee80211_sta *sta;
> > > > > > > +
> > > > > > > +sta =3D container_of((void *)wcid, struct ieee80211_sta,
> > > > > > > drv_priv);
> > > > > > > +wmm =3D sta->wme;
> > > > > > > +}
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3)
> > > > > > > |
> > > > > > > +      FIELD_PREP(MT_TXD1_TID, tid);
> > > > > > > +
> > > > > > > +ethertype =3D get_unaligned_be16(&skb->data[12]);
> > > > > > > +if (ethertype >=3D ETH_P_802_3_MIN)
> > > > > > > +val |=3D MT_TXD1_ETH_802_3;
> > > > > > > +
> > > > > > > +txwi[1] |=3D cpu_to_le32(val);
> > > > > > > +
> > > > > > > +fc_type =3D IEEE80211_FTYPE_DATA >> 2;
> > > > > > > +fc_stype =3D wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
> > > > > > > +      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
> > > > > > > +
> > > > > > > +txwi[2] |=3D cpu_to_le32(val);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void
> > > > > > > +mt76_connac3_mac_write_txwi_80211(struct mt76_dev *dev,
> > >=20
> > > __le32
> > > > > > > *txwi,
> > > > > > > +  struct sk_buff *skb,
> > > > > > > +  struct ieee80211_key_conf *key) {
> > > > > > > +struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb-
> > > >=20
> > > > data;
> > > > > > > +struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt
> > > > > > > *)skb-
> > > > > > > > data;
> > > > > > >=20
> > > > > > > +struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> > > > > > > +bool multicast =3D is_multicast_ether_addr(hdr->addr1);
> > > > > > > +u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TID_MASK;
> > > > > > > +__le16 fc =3D hdr->frame_control;
> > > > > > > +u8 fc_type, fc_stype;
> > > > > > > +u32 val;
> > > > > > > +
> > > > > > > +if (ieee80211_is_action(fc) &&
> > > > > > > +    mgmt->u.action.category =3D=3D WLAN_CATEGORY_BACK &&
> > > > > > > +    mgmt->u.action.u.addba_req.action_code =3D=3D
> > > > > > > WLAN_ACTION_ADDBA_REQ)
> > > > > > > +tid =3D MT_TX_ADDBA;
> > > > > > > +else if (ieee80211_is_mgmt(hdr->frame_control))
> > > > > > > +tid =3D MT_TX_NORMAL;
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11)
> > > > > > > |
> > > > > > > +      FIELD_PREP(MT_TXD1_HDR_INFO,
> > > > > > > + ieee80211_get_hdrlen_from_skb(skb) / 2) |
> > > > > > > +      FIELD_PREP(MT_TXD1_TID, tid);
> > > > > > > +
> > > > > > > +if (!ieee80211_is_data(fc) || multicast ||
> > > > > > > +    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
> > > > > > > +val |=3D MT_TXD1_FIXED_RATE;
> > > > > > > +
> > > > > > > +if (key && multicast &&
> > > > > > > ieee80211_is_robust_mgmt_frame(skb)
> > >=20
> > > &&
> > > > > > > +    key->cipher =3D=3D WLAN_CIPHER_SUITE_AES_CMAC) {
> > > > > > > +val |=3D MT_TXD1_BIP;
> > > > > > > +txwi[3] &=3D ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
> > > > > > > +}
> > > > > > > +
> > > > > > > +txwi[1] |=3D cpu_to_le32(val);
> > > > > > > +
> > > > > > > +fc_type =3D (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
> > > > > > > +fc_stype =3D (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
> > > > > > > +      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
> > > > > > > +
> > > > > > > +txwi[2] |=3D cpu_to_le32(val);
> > > > > > > +
> > > > > > > +txwi[3] |=3D cpu_to_le32(FIELD_PREP(MT_TXD3_BCM,
> > > > > > > multicast));
> > > > > > > +if (ieee80211_is_beacon(fc)) {
> > > > > > > +txwi[3] &=3D ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
> > > > > > > +txwi[3] |=3D cpu_to_le32(MT_TXD3_REM_TX_COUNT);
> > > > > > > +}
> > > > > > > +
> > > > > > > +if (info->flags & IEEE80211_TX_CTL_INJECTED) {
> > > > > > > +u16 seqno =3D le16_to_cpu(hdr->seq_ctrl);
> > > > > > > +
> > > > > > > +if (ieee80211_is_back_req(hdr->frame_control)) {
> > > > > > > +struct ieee80211_bar *bar;
> > > > > > > +
> > > > > > > +bar =3D (struct ieee80211_bar *)skb->data;
> > > > > > > +seqno =3D le16_to_cpu(bar->start_seq_num);
> > > > > > > +}
> > > > > > > +
> > > > > > > +val =3D MT_TXD3_SN_VALID |
> > > > > > > +      FIELD_PREP(MT_TXD3_SEQ,
> > > > > > > IEEE80211_SEQ_TO_SN(seqno));
> > > > > > > +txwi[3] |=3D cpu_to_le32(val);
> > > > > > > +txwi[3] &=3D ~cpu_to_le32(MT_TXD3_HW_AMSDU);
> > > > > > > +}
> > > > > > > +}
> > > > > > > +
> > > > > > > +void mt76_connac3_mac_write_txwi(struct mt76_dev *dev,
> > >=20
> > > __le32
> > > > > > > *txwi,
> > > > > > > + struct sk_buff *skb, struct mt76_wcid
> > > > > > > *wcid,
> > > > > > > + struct ieee80211_key_conf *key, int
> > > > > > > pid,
> > > > > > > + enum mt76_txq_id qid, u32 changed)
> > > > > > > +{
> > > > > > > +u32 val, sz_txd =3D mt76_is_mmio(dev) ? MT_TXD_SIZE :
> > > > > > > MT_SDIO_TXD_SIZE;
> > > > > > > +struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
> > > > > > > +struct ieee80211_vif *vif =3D info->control.vif;
> > > > > > > +u8 band_idx =3D (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
> > > > > > > +u8 p_fmt, q_idx, omac_idx =3D 0, wmm_idx =3D 0;
> > > > > > > +bool is_8023 =3D info->flags &
> > >=20
> > > IEEE80211_TX_CTL_HW_80211_ENCAP;
> > > > > > > +struct mt76_vif *mvif;
> > > > > > > +u16 tx_count =3D 15;
> > > > > > > +bool beacon =3D !!(changed & (BSS_CHANGED_BEACON |
> > > > > > > +    BSS_CHANGED_BEACON_ENABLED));
> > > > > > > +bool inband_disc =3D !!(changed &
> > > > > > > (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
> > > > > > > + BSS_CHANGED_FILS_DISCOVERY));
> > > > > > > +
> > > > > > > +mvif =3D vif ? (struct mt76_vif *)vif->drv_priv : NULL;
> > > > > > > +if (mvif) {
> > > > > > > +omac_idx =3D mvif->omac_idx;
> > > > > > > +wmm_idx =3D mvif->wmm_idx;
> > > > > > > +band_idx =3D mvif->band_idx;
> > > > > > > +}
> > > > > > > +
> > > > > > > +if (inband_disc) {
> > > > > > > +p_fmt =3D MT_TX_TYPE_FW;
> > > > > > > +q_idx =3D MT_LMAC_ALTX0;
> > > > > > > +} else if (beacon) {
> > > > > > > +p_fmt =3D MT_TX_TYPE_FW;
> > > > > > > +q_idx =3D MT_LMAC_BCN0;
> > > > > > > +} else if (qid >=3D MT_TXQ_PSD) {
> > > > > > > +p_fmt =3D mt76_is_mmio(dev) ? MT_TX_TYPE_CT :
> > > > > > > MT_TX_TYPE_SF;
> > > > > > > +q_idx =3D MT_LMAC_ALTX0;
> > > > > > > +} else {
> > > > > > > +p_fmt =3D mt76_is_mmio(dev) ? MT_TX_TYPE_CT :
> > > > > > > MT_TX_TYPE_SF;
> > > > > > > +q_idx =3D wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
> > > > > > > +mt76_connac_lmac_mapping(skb_get_queue_mapping(
> > > > > > > skb));
> > > > > > > +}
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
> > > > > > > +      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
> > > > > > > +      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
> > > > > > > +txwi[0] =3D cpu_to_le32(val);
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
> > > > > > > +      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
> > > > > > > +
> > > > > > > +if (band_idx)
> > > > > > > +val |=3D FIELD_PREP(MT_TXD1_TGID, band_idx);
> > > > > > > +
> > > > > > > +txwi[1] =3D cpu_to_le32(val);
> > > > > > > +txwi[2] =3D 0;
> > > > > > > +
> > > > > > > +val =3D MT_TXD3_SW_POWER_MGMT |
> > > > > > > +      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
> > > > > > > +if (key)
> > > > > > > +val |=3D MT_TXD3_PROTECT_FRAME;
> > > > > > > +if (info->flags & IEEE80211_TX_CTL_NO_ACK)
> > > > > > > +val |=3D MT_TXD3_NO_ACK;
> > > > > > > +if (wcid->amsdu)
> > > > > > > +val |=3D MT_TXD3_HW_AMSDU;
> > > > > > > +
> > > > > > > +txwi[3] =3D cpu_to_le32(val);
> > > > > > > +txwi[4] =3D 0;
> > > > > > > +
> > > > > > > +val =3D FIELD_PREP(MT_TXD5_PID, pid);
> > > > > > > +if (pid >=3D MT_PACKET_ID_FIRST)
> > > > > > > +val |=3D MT_TXD5_TX_STATUS_HOST;
> > > > > > > +txwi[5] =3D cpu_to_le32(val);
> > > > > > > +
> > > > > > > +val =3D MT_TXD6_DIS_MAT | MT_TXD6_DAS |
> > > > > > > +      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
> > > > > > > +txwi[6] =3D cpu_to_le32(val);
> > > > > > > +txwi[7] =3D 0;
> > > > > > > +
> > > > > > > +if (is_8023)
> > > > > > > +mt76_connac3_mac_write_txwi_8023(txwi, skb, wcid);
> > > > > > > +else
> > > > > > > +mt76_connac3_mac_write_txwi_80211(dev, txwi, skb, key);
> > > > > > > +
> > > > > > > +if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
> > > > > > > +struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr
> > > > > > > *)skb->data;
> > > > > > > +bool mcast =3D ieee80211_is_data(hdr->frame_control) &&
> > > > > > > +     is_multicast_ether_addr(hdr->addr1);
> > > > > > > +u8 idx =3D MT76_CONNAC3_BASIC_RATES_TBL;
> > > > > > > +
> > > > > > > +if (mvif) {
> > > > > > > +if (mcast && mvif->mcast_rates_idx)
> > > > > > > +idx =3D mvif->mcast_rates_idx;
> > > > > > > +else if (beacon && mvif->beacon_rates_idx)
> > > > > > > +idx =3D mvif->beacon_rates_idx;
> > > > > > > +else
> > > > > > > +idx =3D mvif->basic_rates_idx;
> > > > > > > +}
> > > > > > > +
> > > > > > > +txwi[6] |=3D cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE,
> > > > > > > idx));
> > > > > > > +txwi[3] |=3D cpu_to_le32(MT_TXD3_BA_DISABLE);
> > > > > > > +}
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_mac_write_txwi);
> > > > > > > +
> > > > > > > +void mt76_connac3_txwi_free(struct mt76_dev *dev, struct
> > > > > > > mt76_txwi_cache *t,
> > > > > > > +    struct ieee80211_sta *sta,
> > > > > > > +    struct list_head *free_list)
> > > > > > > +{
> > > > > > > +__le32 *txwi;
> > > > > > > +u16 wcid_idx;
> > > > > > > +
> > > > > > > +mt76_connac_txp_skb_unmap(dev, t);
> > > > > > > +if (!t->skb)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +txwi =3D (__le32 *)mt76_get_txwi_ptr(dev, t);
> > > > > > > +if (sta) {
> > > > > > > +struct mt76_wcid *wcid =3D (struct mt76_wcid *)sta-
> > > > > > > > drv_priv;
> > > > > > >=20
> > > > > > > +
> > > > > > > +wcid_idx =3D wcid->idx;
> > > > > > > +if (likely(t->skb->protocol !=3D cpu_to_be16(ETH_P_PAE)))
> > > > > > > +mt76_connac3_tx_check_aggr(sta, txwi);
> > > > > > > +} else {
> > > > > > > +wcid_idx =3D le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
> > > > > > > +}
> > > > > > > +
> > > > > > > +__mt76_tx_complete_skb(dev, wcid_idx, t->skb, free_list);
> > > > > > > +out:
> > > > > > > +t->skb =3D NULL;
> > > > > > > +mt76_put_txwi(dev, t);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_txwi_free);
> > > > > > > +
> > > > > > > +static bool
> > > > > > > +mt76_connac3_mac_add_txs_skb(struct mt76_dev *dev, struct
> > > > > > > mt76_wcid
> > > > > > > *wcid,
> > > > > > > +     int pid, __le32 *txs_data)
> > > > > > > +{
> > > > > > > +struct mt76_sta_stats *stats =3D &wcid->stats;
> > > > > > > +struct ieee80211_supported_band *sband;
> > > > > > > +struct ieee80211_tx_info *info;
> > > > > > > +u32 txrate, txs, mode, stbc;
> > > > > > > +struct rate_info rate =3D {};
> > > > > > > +struct sk_buff_head list;
> > > > > > > +struct mt76_phy *mphy;
> > > > > > > +struct sk_buff *skb;
> > > > > > > +bool cck =3D false;
> > > > > > > +
> > > > > > > +mt76_tx_status_lock(dev, &list);
> > > > > > > +skb =3D mt76_tx_status_skb_get(dev, wcid, pid, &list);
> > > > > > > +if (!skb)
> > > > > > > +goto out_no_skb;
> > > > > > > +
> > > > > > > +txs =3D le32_to_cpu(txs_data[0]);
> > > > > > > +
> > > > > > > +info =3D IEEE80211_SKB_CB(skb);
> > > > > > > +if (!(txs & MT_TXS0_ACK_ERROR_MASK))
> > > > > > > +info->flags |=3D IEEE80211_TX_STAT_ACK;
> > > > > > > +
> > > > > > > +info->status.ampdu_len =3D 1;
> > > > > > > +info->status.ampdu_ack_len =3D !!(info->flags &
> > > > > > > +IEEE80211_TX_STAT_ACK);
> > > > > > > +info->status.rates[0].idx =3D -1;
> > > > > > > +
> > > > > > > +txrate =3D FIELD_GET(MT_TXS0_TX_RATE, txs);
> > > > > > > +
> > > > > > > +rate.mcs =3D FIELD_GET(MT_TX_RATE_IDX, txrate);
> > > > > > > +rate.nss =3D FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
> > > > > > > +stbc =3D le32_get_bits(txs_data[3], MT_TXS3_RATE_STBC);
> > > > > > > +
> > > > > > > +if (stbc && rate.nss > 1)
> > > > > > > +rate.nss >>=3D 1;
> > > > > > > +
> > > > > > > +if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
> > > > > > > +stats->tx_nss[rate.nss - 1]++;
> > > > > > > +if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
> > > > > > > +stats->tx_mcs[rate.mcs]++;
> > > > > > > +
> > > > > > > +mode =3D FIELD_GET(MT_TX_RATE_MODE, txrate);
> > > > > > > +switch (mode) {
> > > > > > > +case MT_PHY_TYPE_CCK:
> > > > > > > +cck =3D true;
> > > > > > > +fallthrough;
> > > > > > > +case MT_PHY_TYPE_OFDM:
> > > > > > > +mphy =3D mt76_dev_phy(dev, wcid->phy_idx);
> > > > > > > +
> > > > > > > +if (mphy->chandef.chan->band =3D=3D NL80211_BAND_5GHZ)
> > > > > > > +sband =3D &mphy->sband_5g.sband;
> > > > > > > +else if (mphy->chandef.chan->band =3D=3D NL80211_BAND_6GHZ)
> > > > > > > +sband =3D &mphy->sband_6g.sband;
> > > > > > > +else
> > > > > > > +sband =3D &mphy->sband_2g.sband;
> > > > > > > +
> > > > > > > +rate.mcs =3D mt76_get_rate(mphy->dev, sband, rate.mcs,
> > > > > > > cck);
> > > > > > > +rate.legacy =3D sband->bitrates[rate.mcs].bitrate;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HT:
> > > > > > > +case MT_PHY_TYPE_HT_GF:
> > > > > > > +if (rate.mcs > 31)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +rate.flags =3D RATE_INFO_FLAGS_MCS;
> > > > > > > +if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
> > > > > > > +rate.flags |=3D RATE_INFO_FLAGS_SHORT_GI;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_VHT:
> > > > > > > +if (rate.mcs > 9)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +rate.flags =3D RATE_INFO_FLAGS_VHT_MCS;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_HE_SU:
> > > > > > > +case MT_PHY_TYPE_HE_EXT_SU:
> > > > > > > +case MT_PHY_TYPE_HE_TB:
> > > > > > > +case MT_PHY_TYPE_HE_MU:
> > > > > > > +if (rate.mcs > 11)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +rate.he_gi =3D wcid->rate.he_gi;
> > > > > > > +rate.he_dcm =3D FIELD_GET(MT_TX_RATE_DCM, txrate);
> > > > > > > +rate.flags =3D RATE_INFO_FLAGS_HE_MCS;
> > > > > > > +break;
> > > > > > > +case MT_PHY_TYPE_EHT_SU:
> > > > > > > +case MT_PHY_TYPE_EHT_TRIG:
> > > > > > > +case MT_PHY_TYPE_EHT_MU:
> > > > > > > +if (rate.mcs > 13)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +rate.eht_gi =3D wcid->rate.eht_gi;
> > > > > > > +rate.flags =3D RATE_INFO_FLAGS_EHT_MCS;
> > > > > > > +break;
> > > > > > > +default:
> > > > > > > +goto out;
> > > > > > > +}
> > > > > > > +
> > > > > > > +stats->tx_mode[mode]++;
> > > > > > > +
> > > > > > > +switch (FIELD_GET(MT_TXS0_BW, txs)) {
> > > > > > > +case IEEE80211_STA_RX_BW_320:
> > > > > > > +rate.bw =3D RATE_INFO_BW_320;
> > > > > > > +stats->tx_bw[4]++;
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_160:
> > > > > > > +rate.bw =3D RATE_INFO_BW_160;
> > > > > > > +stats->tx_bw[3]++;
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_80:
> > > > > > > +rate.bw =3D RATE_INFO_BW_80;
> > > > > > > +stats->tx_bw[2]++;
> > > > > > > +break;
> > > > > > > +case IEEE80211_STA_RX_BW_40:
> > > > > > > +rate.bw =3D RATE_INFO_BW_40;
> > > > > > > +stats->tx_bw[1]++;
> > > > > > > +break;
> > > > > > > +default:
> > > > > > > +rate.bw =3D RATE_INFO_BW_20;
> > > > > > > +stats->tx_bw[0]++;
> > > > > > > +break;
> > > > > > > +}
> > > > > > > +wcid->rate =3D rate;
> > > > > > > +
> > > > > > > +out:
> > > > > > > +mt76_tx_status_skb_done(dev, skb, &list);
> > > > > > > +
> > > > > > > +out_no_skb:
> > > > > > > +mt76_tx_status_unlock(dev, &list);
> > > > > > > +
> > > > > > > +return !!skb;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void mt76_connac3_mac_add_txs(struct mt76_dev *dev, void
> > >=20
> > > *data,
> > > > > > > +      u32 max_wtbl_size)
> > > > > > > +{
> > > > > > > +struct mt76_wcid *wcid;
> > > > > > > +__le32 *txs_data =3D data;
> > > > > > > +u16 wcidx;
> > > > > > > +u8 pid;
> > > > > > > +
> > > > > > > +if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
> > > > > > > +return;
> > > > > > > +
> > > > > > > +wcidx =3D le32_get_bits(txs_data[2], MT_TXS2_WCID);
> > > > > > > +pid =3D le32_get_bits(txs_data[3], MT_TXS3_PID);
> > > > > > > +
> > > > > > > +if (pid < MT_PACKET_ID_FIRST)
> > > > > > > +return;
> > > > > > > +
> > > > > > > +if (wcidx >=3D max_wtbl_size)
> > > > > > > +return;
> > > > > > > +
> > > > > > > +rcu_read_lock();
> > > > > > > +
> > > > > > > +wcid =3D rcu_dereference(dev->wcid[wcidx]);
> > > > > > > +if (!wcid)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +mt76_connac3_mac_add_txs_skb(dev, wcid, pid, txs_data);
> > > > > > > +if (!wcid->sta)
> > > > > > > +goto out;
> > > > > > > +
> > > > > > > +spin_lock_bh(&dev->sta_poll_lock);
> > > > > > > +if (list_empty(&wcid->poll_list))
> > > > > > > +list_add_tail(&wcid->poll_list, &dev->sta_poll_list);
> > > > > > > +spin_unlock_bh(&dev->sta_poll_lock);
> > > > > > > +
> > > > > > > +out:
> > > > > > > +rcu_read_unlock();
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_mac_add_txs);
> > > > > > > +
> > > > > > > +void mt76_connac3_tx_token_put(struct mt76_dev *dev)
> > > > > > > +{
> > > > > > > +struct mt76_txwi_cache *txwi;
> > > > > > > +int id;
> > > > > > > +
> > > > > > > +spin_lock_bh(&dev->token_lock);
> > > > > > > +idr_for_each_entry(&dev->token, txwi, id) {
> > > > > > > +mt76_connac3_txwi_free(dev, txwi, NULL, NULL);
> > > > > > > +dev->token_count--;
> > > > > > > +}
> > > > > > > +spin_unlock_bh(&dev->token_lock);
> > > > > > > +idr_destroy(&dev->token);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(mt76_connac3_tx_token_put);
> > > > > > > diff --git
> > > > > > > a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
> > > > > > > b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
> > > > > > > index 6663a0b46541..bcc1d976b2b0 100644
> > > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
> > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
> > > > > > > @@ -4,6 +4,24 @@
> > > > > > >  #ifndef __MT76_CONNAC3_MAC_H
> > > > > > >  #define __MT76_CONNAC3_MAC_H
> > > > > > > =20
> > > > > > > +/* NOTE: used to map mt76_rates. idx may change if
> > > > > > > firmware
> > > > > > > expands
> > > > > > > table */
> > > > > > > +#define MT76_CONNAC3_BASIC_RATES_TBL11
> > > > > > > +#define MT76_CONNAC3_BEACON_RATES_TBL25
> > > > > > >=20
> > > > > >=20
> > > > > > Different devices may have different defined value.=20
> > > > >=20
> > > > > The other WiFi7 device I am working on relies on the values I
> > >=20
> > > moved
> > > > > in
> > > > > mt76_connac3_mac.h (in common with mt7996). Moreover you can
> > >=20
> > > still
> > > > > have per-device values in mt7996/mac.h (I have not removed it).
> > > > >=20
> > > >=20
> > > > Please double check with the mtk folk you work with. The 11 and
> > > > 25
> > >=20
> > > is
> > > > the value I discussed with firmware folks to avoid overlapping
> > > > the
> > >=20
> > > tbl
> > > > mt7996 use (MU/other algo in fw), or it causes something hardly
> > >=20
> > > solving
> > > > issue
> > >=20
> > > sure, thx for pointing this out.
> > > @Deren: can you please double check?
> > >=20
> > > Regards,
> > > Lorenzo
> > >=20
> > > > =20
> > > > > >=20
> > > > > > I'm thinking if it's too early to create this patch for just
> > >=20
> > > moving
> > > > > > mt7996 to connac3_lib?
> > > > >=20
> > > > > The code I moved is used by the other device as well. This
> > > > > series
> > >=20
> > > is
> > > > > a
> > > > > preliminary series to support it.
> > > > >=20
> > > > > Regards,
> > > > > Lorenzo
> > > > >=20
> > > > > >=20
> > > > > > Ryder
> > > > > >=20

--yyVozfcGuQO9tV6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZIRLJAAKCRA6cBh0uS2t
rFTnAQDWUszrBQdhj5FAWzEif60bG0GBBgj73nyMp6rMOqAVywD9F6vn01e1R1Hr
mFMEqAv1XqJlx8hDbn+YiGn/Q2tajAk=
=kApU
-----END PGP SIGNATURE-----

--yyVozfcGuQO9tV6r--
