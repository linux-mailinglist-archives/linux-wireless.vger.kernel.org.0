Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F64D0027
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiCGNgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 08:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCGNgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 08:36:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2F80904
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 05:35:21 -0800 (PST)
X-UUID: 0db1ad90fe2045a59a47330cf5d67d3d-20220307
X-UUID: 0db1ad90fe2045a59a47330cf5d67d3d-20220307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 924543887; Mon, 07 Mar 2022 21:35:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 21:35:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:15 +0800
Message-ID: <700fc094dbca7406326dde1b169c2d2fe6a1bb24.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
From:   Deren Wu <deren.wu@mediatek.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 7 Mar 2022 21:35:14 +0800
In-Reply-To: <CAJ0CqmWQxORW8+++DVW3ujYccfCq_DB5hNOMn+gMs8kgoTk=5w@mail.gmail.com>
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
         <CAJ0CqmWQxORW8+++DVW3ujYccfCq_DB5hNOMn+gMs8kgoTk=5w@mail.gmail.com>
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

On Mon, 2022-03-07 at 13:00 +0100, Lorenzo Bianconi wrote:
> > 
> > Firmware initialization can take a while. Move mt7921_init_hw
> > routine in
> > a dedicated work in order to not slow down bootstrap process.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Hi Sean and Deren,
> 
> I tested this patch on mt7921e and mt7921u. Can you double check if
> it
> works fine even on mt7921s? Thanks.
> 
> Regards,
> Lorenzo

Hi Lore,

The patch is good on normal initial flow with mt7921s. However, if I
run command "insmod mt7921s && rmmod mt7921s" quickly, there would be
some problems in the remove process. The problem can be avoided if
adding "cancel_work_sync(&dev->init_work)" in unregiser hook.

I think the patch is still good now and we may need another patch to
cover the stress problem.

Tested-by: Deren Wu <deren.wu@mediatek.com>


> 
> > ---
> >  .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++
> > ------
> >  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > index fa6af85bba7b..332af886b95a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > @@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct
> > mt7921_dev *dev)
> > 
> >  static int mt7921_init_hardware(struct mt7921_dev *dev)
> >  {
> > -       int ret, idx, i;
> > +       int ret, i;
> > 
> >         set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
> > 
> > @@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct
> > mt7921_dev *dev)
> >                 return ret;
> >         }
> > 
> > +       return 0;
> > +}
> > +
> > +static int mt7921_init_wcid(struct mt7921_dev *dev)
> > +{
> > +       int idx;
> > +
> >         /* Beacon and mgmt frames should occupy wcid 0 */
> >         idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA
> > - 1);
> >         if (idx)
> > @@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct
> > mt7921_dev *dev)
> >         return 0;
> >  }
> > 
> > +static void mt7921_init_work(struct work_struct *work)
> > +{
> > +       struct mt7921_dev *dev = container_of(work, struct
> > mt7921_dev,
> > +                                             init_work);
> > +       int ret;
> > +
> > +       ret = mt7921_init_hardware(dev);
> > +       if (ret)
> > +               return;
> > +
> > +       mt76_set_stream_caps(&dev->mphy, true);
> > +       mt7921_set_stream_he_caps(&dev->phy);
> > +
> > +       ret = mt76_register_device(&dev->mt76, true, mt76_rates,
> > +                                  ARRAY_SIZE(mt76_rates));
> > +       if (ret) {
> > +               dev_err(dev->mt76.dev, "register device failed\n");
> > +               return;
> > +       }
> > +
> > +       ret = mt7921_init_debugfs(dev);
> > +       if (ret) {
> > +               dev_err(dev->mt76.dev, "debugfs register
> > failed\n");
> > +               goto error;
> > +       }
> > +
> > +       ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev-
> > >pm.ds_enable);
> > +       if (ret)
> > +               goto error;
> > +
> > +       dev->hw_init_done = true;
> > +       return;
> > +error:
> > +       mt76_unregister_device(&dev->mt76);
> > +}
> > +
> >  int mt7921_register_device(struct mt7921_dev *dev)
> >  {
> >         struct ieee80211_hw *hw = mt76_hw(dev);
> > @@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev
> > *dev)
> >         spin_lock_init(&dev->sta_poll_lock);
> > 
> >         INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
> > +       INIT_WORK(&dev->init_work, mt7921_init_work);
> > 
> >         dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
> >         dev->pm.stats.last_wake_event = jiffies;
> > @@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev
> > *dev)
> >         if (mt76_is_sdio(&dev->mt76))
> >                 hw->extra_tx_headroom += MT_SDIO_TXD_SIZE +
> > MT_SDIO_HDR_SIZE;
> > 
> > -       ret = mt7921_init_hardware(dev);
> > +       ret = mt7921_init_wcid(dev);
> >         if (ret)
> >                 return ret;
> > 
> > @@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev
> > *dev)
> >         dev->mphy.hw->wiphy->available_antennas_rx = dev-
> > >mphy.chainmask;
> >         dev->mphy.hw->wiphy->available_antennas_tx = dev-
> > >mphy.chainmask;
> > 
> > -       mt76_set_stream_caps(&dev->mphy, true);
> > -       mt7921_set_stream_he_caps(&dev->phy);
> > -
> > -       ret = mt76_register_device(&dev->mt76, true, mt76_rates,
> > -                                  ARRAY_SIZE(mt76_rates));
> > -       if (ret)
> > -               return ret;
> > -
> > -       ret = mt7921_init_debugfs(dev);
> > -       if (ret)
> > -               return ret;
> > -
> > -       ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev-
> > >pm.ds_enable);
> > -       if (ret)
> > -               return ret;
> > -
> > -       dev->hw_init_done = true;
> > +       queue_work(system_wq, &dev->init_work);
> > 
> >         return 0;
> >  }
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > index 394a677140da..b6c8f84acb64 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > @@ -204,6 +204,8 @@ struct mt7921_dev {
> >         struct list_head sta_poll_list;
> >         spinlock_t sta_poll_lock;
> > 
> > +       struct work_struct init_work;
> > +
> >         u8 fw_debug;
> > 
> >         struct mt76_connac_pm pm;
> > --
> > 2.35.1
> > 
> 
> 

