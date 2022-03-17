Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60E94DBFE2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 08:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiCQHDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 03:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCQHDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 03:03:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C813CA31
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 00:02:21 -0700 (PDT)
X-UUID: 599849c0ea5542b8af348f8611d94c12-20220317
X-UUID: 599849c0ea5542b8af348f8611d94c12-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 186581333; Thu, 17 Mar 2022 15:02:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 15:02:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 15:02:13 +0800
Message-ID: <ef6a0d876587e3efaa228f9d28f5a6f7b97e4aef.camel@mediatek.com>
Subject: Re: [PATCH] mt76: fix monitor rx FCS error in DFS channel
From:   Deren Wu <deren.wu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        "Soul Huang" <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Thu, 17 Mar 2022 15:02:13 +0800
In-Reply-To: <YjH/GCCfQoZ5OPPM@localhost.localdomain>
References: <7243650f3d51b1919bd4fd0017ff8b0186149e54.1647421054.git.deren.wu@mediatek.com>
         <YjH/GCCfQoZ5OPPM@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lore,

On Wed, 2022-03-16 at 16:15 +0100, Lorenzo Bianconi wrote:
> > From: Deren Wu <deren.wu@mediatek.com>
> > 
> > When setup monitor mode in DFS channel, mt76 send CH_SWITCH_DFS to
> > fw for channel config. This would cause rx performance bad while
> > monitoring frames. Settings CH_SWITCH_NORMAL in monitor mode would
> > get the same performance as normal channels.
> 
> Hi Deren,
> 
> > 
> > Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
> >  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 ++-
> >  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > index 390add3144c2..97e2a85cb728 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > @@ -2151,7 +2151,8 @@ int mt7615_mcu_set_chan_info(struct
> > mt7615_phy *phy, int cmd)
> >  		.center_chan2 = ieee80211_frequency_to_channel(freq2),
> >  	};
> >  
> > -	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
> > +	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
> > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> 
> is this patch compliant with 802.11h DFS standard?

Monitor mode would not tx packets and still follow standard. We will
keep tracking this point to avoid violations.


Regards,
Deren


> 
> Regards,
> Lorenzo
> 
> >  		req.switch_reason = CH_SWITCH_NORMAL;
> >  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> >  		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > index 10dc4bf5adec..c56d48342aaf 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > @@ -2833,7 +2833,8 @@ int mt7915_mcu_set_chan_info(struct
> > mt7915_phy *phy, int cmd)
> >  	}
> >  #endif
> >  
> > -	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
> > +	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
> > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> >  		req.switch_reason = CH_SWITCH_NORMAL;
> >  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> >  		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > index 5ef8b24f0ab3..da2be050ed7c 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > @@ -863,7 +863,8 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy
> > *phy, int cmd)
> >  	else
> >  		req.channel_band = chandef->chan->band;
> >  
> > -	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
> > +	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
> > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> >  		req.switch_reason = CH_SWITCH_NORMAL;
> >  	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> >  		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
> > -- 
> > 2.18.0
> > 

