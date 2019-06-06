Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38837966
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFFQTt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 12:19:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34662 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfFFQTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 12:19:49 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so681606iot.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jun 2019 09:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AZryVPm9WEZf89lWXbEGTDn4y+TgVuIZXrDppDnWmE=;
        b=L2s4JJoeIencWIv2sGgrOiNQAIco3FHeQPJaP8Umkx3K8HhcCDfWVhgDQT9+h2+iu9
         Jt6559n5UHi/CXD0PdZxBR1vJFWoRyQRHnbFqWPjVVq5iymTaUOKEKuiGR/OdgJmh7iy
         2Jzub2aBEX95wtokAEvoUmwDxWY6La1Ycss1OvDzs+jjJVUCM8Oh+jAMPLvCh/axuIOY
         5yRxanDWIIlfwZsJcA8NnMO6aMsWTWJLMmiNfSZXllircAOfay7/SQHtcbwBjDVBTJ0C
         Fsut3T7Ut114Va+WjGKMcFOmoVNyME4Cni/jsKlNa/m5wltEFWKTV0QSRIKkbuk+GAgy
         9JRA==
X-Gm-Message-State: APjAAAVh75P0xMBdXNEGFRkjzC9cECfbGfhXADys3sciLN7B5woR2M4z
        1U5KrO2UeHcVLjtIf1SZBeNqbXFysr4IJLVuSK/7xg==
X-Google-Smtp-Source: APXvYqyyfL36sLDzC3fGZJuckRuKrOR5/eaCW6vfPOwmumzPutA8k5DseFsUoso4bYVBykjNSQSZmm46G3WbB60v7fA=
X-Received: by 2002:a05:6602:2006:: with SMTP id y6mr28202284iod.218.1559837988226;
 Thu, 06 Jun 2019 09:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <a1ff446dfc06e2443552e7ec2d754099aacce7df.1559541944.git.ryder.lee@mediatek.com>
 <ade7ef01-8b06-ec7d-4caf-e581f4033819@newmedia-net.de>
In-Reply-To: <ade7ef01-8b06-ec7d-4caf-e581f4033819@newmedia-net.de>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 6 Jun 2019 18:19:37 +0200
Message-ID: <CAJ0CqmVBogQrqf4Gckr5gQ6tCrdZG=p60ZiC+-WW-yxt93+40Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mt76: mt7615: enable support for mesh
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> i tested your patch against a qca 9984 chipset using SAE and without
> encryption. both did not work. the devices are connecting, but no data
> connection is possible

Hi Sebastian,

I tested Ryder's patch using mt76x2 as mesh peer and it works fine for me.
Could you please provide some more info?

Regards,
Lorenzo

>
>
> Sebastian
>
> Am 03.06.2019 um 08:08 schrieb Ryder Lee:
> > Enable NL80211_IFTYPE_MESH_POINT and update its path.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > Changes since v3 - fix a wrong expression
> > Changes since v2 - remove unused definitions
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
> >   drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
> >   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 4 +++-
> >   drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 6 ------
> >   4 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > index 59f604f3161f..f860af6a42da 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> > @@ -133,6 +133,9 @@ static const struct ieee80211_iface_limit if_limits[] = {
> >       {
> >               .max = MT7615_MAX_INTERFACES,
> >               .types = BIT(NL80211_IFTYPE_AP) |
> > +#ifdef CONFIG_MAC80211_MESH
> > +                      BIT(NL80211_IFTYPE_MESH_POINT) |
> > +#endif
> >                        BIT(NL80211_IFTYPE_STATION)
> >       }
> >   };
> > @@ -195,6 +198,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
> >       dev->mt76.antenna_mask = 0xf;
> >
> >       wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
> > +#ifdef CONFIG_MAC80211_MESH
> > +                              BIT(NL80211_IFTYPE_MESH_POINT) |
> > +#endif
> >                                BIT(NL80211_IFTYPE_AP);
> >
> >       ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > index b0bb7cc12385..585e67fa2728 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> > @@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
> >
> >       switch (type) {
> >       case NL80211_IFTYPE_AP:
> > +     case NL80211_IFTYPE_MESH_POINT:
> >               /* ap use hw bssid 0 and ext bssid */
> >               if (~mask & BIT(HW_BSSID_0))
> >                       return HW_BSSID_0;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > index 43f70195244c..e82297048449 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
> >
> >       switch (vif->type) {
> >       case NL80211_IFTYPE_AP:
> > +     case NL80211_IFTYPE_MESH_POINT:
> >               tx_wlan_idx = mvif->sta.wcid.idx;
> >               conn_type = CONNECTION_INFRA_AP;
> >               break;
> > @@ -968,7 +969,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
> >               .rx_wtbl = {
> >                       .tag = cpu_to_le16(WTBL_RX),
> >                       .len = cpu_to_le16(sizeof(struct wtbl_rx)),
> > -                     .rca1 = vif->type != NL80211_IFTYPE_AP,
> > +                     .rca1 = vif->type == NL80211_IFTYPE_STATION,
> >                       .rca2 = 1,
> >                       .rv = 1,
> >               },
> > @@ -1042,6 +1043,7 @@ static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
> >   {
> >       switch (type) {
> >       case NL80211_IFTYPE_AP:
> > +     case NL80211_IFTYPE_MESH_POINT:
> >               if (conn_type)
> >                       *conn_type = CONNECTION_INFRA_STA;
> >               break;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> > index e96efb13fa4d..0915cb735699 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
> > @@ -105,25 +105,19 @@ enum {
> >   #define STA_TYPE_STA                BIT(0)
> >   #define STA_TYPE_AP         BIT(1)
> >   #define STA_TYPE_ADHOC              BIT(2)
> > -#define STA_TYPE_TDLS                BIT(3)
> >   #define STA_TYPE_WDS                BIT(4)
> >   #define STA_TYPE_BC         BIT(5)
> >
> >   #define NETWORK_INFRA               BIT(16)
> >   #define NETWORK_P2P         BIT(17)
> >   #define NETWORK_IBSS                BIT(18)
> > -#define NETWORK_MESH         BIT(19)
> > -#define NETWORK_BOW          BIT(20)
> >   #define NETWORK_WDS         BIT(21)
> >
> >   #define CONNECTION_INFRA_STA        (STA_TYPE_STA | NETWORK_INFRA)
> >   #define CONNECTION_INFRA_AP (STA_TYPE_AP | NETWORK_INFRA)
> >   #define CONNECTION_P2P_GC   (STA_TYPE_STA | NETWORK_P2P)
> >   #define CONNECTION_P2P_GO   (STA_TYPE_AP | NETWORK_P2P)
> > -#define CONNECTION_MESH_STA  (STA_TYPE_STA | NETWORK_MESH)
> > -#define CONNECTION_MESH_AP   (STA_TYPE_AP | NETWORK_MESH)
> >   #define CONNECTION_IBSS_ADHOC       (STA_TYPE_ADHOC | NETWORK_IBSS)
> > -#define CONNECTION_TDLS              (STA_TYPE_STA | NETWORK_INFRA | STA_TYPE_TDLS)
> >   #define CONNECTION_WDS              (STA_TYPE_WDS | NETWORK_WDS)
> >   #define CONNECTION_INFRA_BC (STA_TYPE_BC | NETWORK_INFRA)
> >
