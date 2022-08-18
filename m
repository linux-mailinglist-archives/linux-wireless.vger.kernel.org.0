Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C0597AD2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiHRBD2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiHRBDY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 21:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520D9FE0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 18:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA7A613FB
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 01:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5643AC433D7
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660784597;
        bh=rWdT6qEModoSI9xXRcIpm8iqNE6nUY/RnIJFj+s1hjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VFfn/5yHujdXlip5BPm0k4QrS9IltOL1xcC4sXAB/iuvQqe8vsUDdIF5L+2ZWhvca
         Oua+zDm7GLtrGpQIuh7UY16Y8/QQnuAQ6YVxmACK4ChnkS603lawcj8/mA03yn5Xoc
         z6d97vQnYNwxu1M71cE84b5QoU7kXrswS+WsggIral07Dg96eyjxPTngX4fDS6dsXg
         oRAW7i2z5GmOfpJ2fhnlyLg1Wo9hAxnDtlUG/Z6fDTzyDmpkpYH7G03+CWNYuSqy7T
         w6DG4vAeNpaLQaT3OEanHt/nst3s0hIYUKQqVDoUTRKPecKzQCa7nf6P3ZJnfqSOCi
         UOmMjr10x/UEg==
Received: by mail-wr1-f42.google.com with SMTP id bs25so50419wrb.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 18:03:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo2js5bFu4J+vxrkkg3I+EuSpXbB3K0kEmTFNplJC08FNWqzehfQ
        lNNms0NNWzBibtlrH9IwVGCcZIdnm8D1dDl2Hvw=
X-Google-Smtp-Source: AA6agR7WUGfHJEtABoe4O2C8JL/ornG85/f8F0i5r8wgfvRMtc3qaZGwP4FFZ+eF+QLqBzMbPKDJNMsCURF7LNfLLI8=
X-Received: by 2002:a5d:4601:0:b0:21d:8db4:37c with SMTP id
 t1-20020a5d4601000000b0021d8db4037cmr240113wrq.390.1660784595575; Wed, 17 Aug
 2022 18:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660606893.git.objelf@gmail.com> <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
 <YvyUwEdURYHiAduf@lore-desk>
In-Reply-To: <YvyUwEdURYHiAduf@lore-desk>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 17 Aug 2022 18:03:03 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrvVQOrUNPR8aguUTgWo1wZFMR2Y3kdTk8WqxmG=B8--w@mail.gmail.com>
Message-ID: <CAGp9LzrvVQOrUNPR8aguUTgWo1wZFMR2Y3kdTk8WqxmG=B8--w@mail.gmail.com>
Subject: Re: [PATCH 8/9] wifi: mt76: mt7921: introduce remain_on_channel support
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

On Wed, Aug 17, 2022 at 12:18 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Introduce remain_on_channel support. Additionally, we add
> > mt7921_check_offload_capability to disable .remain_on_channel and
> > .cancel_remain_on_channel and related configuration because those
> > operations would rely on the fundamental MCU commands that will be only
> > supported with newer firmware.
> >
> > Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../net/wireless/mediatek/mt76/mt7921/init.c  |  36 ++++++
> >  .../net/wireless/mediatek/mt76/mt7921/main.c  | 112 ++++++++++++++++++
> >  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++++
> >  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  34 ++++++
> >  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  13 +-
> >  .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  11 +-
> >  .../net/wireless/mediatek/mt76/mt7921/usb.c   |   1 +
> >  7 files changed, 225 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > index cd960e23770f..1b7a18d42f5b 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > @@ -44,6 +44,35 @@ mt7921_regd_notifier(struct wiphy *wiphy,
> >       mt7921_mutex_release(dev);
> >  }
> >
> > +static int mt7921_check_offload_capability(struct mt7921_dev *dev)
> > +{
> > +     struct ieee80211_hw *hw = mt76_hw(dev);
> > +     int year, mon, day, hour, min, sec;
> > +     struct wiphy *wiphy = hw->wiphy;
> > +     bool fw_can_roc = false;
> > +     int ret;
> > +
> > +     ret = sscanf(dev->mt76.hw->wiphy->fw_version + 11, "%4d%2d%2d%2d%2d%2d",
> > +                  &year, &mon, &day, &hour, &min, &sec);
>
> does the fw have a differnt base version with respect to the previous ones?
> checking the date is a bit ugly.

I admitted that way was a bit ugly, but I have investigated for a
while, and that is the only way we can use to distinguish the version
in current mt7921 firmware.

>
> > +     if (ret != 6)
> > +             goto out;
> > +
> > +     /* Old firmware cannot support remained on channel and channel
> > +      * context management.
> > +      */
> > +     fw_can_roc =  mktime64(year, mon, day, hour, min, sec) >=
> > +                   mktime64(2022, 7, 15, 12, 1, 1);
> > +out:
> > +     if (!fw_can_roc) {
> > +             dev->ops->remain_on_channel = NULL;
> > +             dev->ops->cancel_remain_on_channel = NULL;
> > +
> > +             wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +

<snip>

> > -     mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
> > -                              &drv_ops);
> > +     ops = devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops),
> > +                        GFP_KERNEL);
>
> why do we need to copy mt7921_ops?
>

As the old fw cannot support the roc and chanctx and considering
backward compatibility, I need to copy the mt7921_ops here and
disable related operations for old fw before registering the hw to mac80211.

     Sean

> Regards,
> Lorenzo
>
> > +     if (!ops) {
> > +             ret = -ENOMEM;
> > +             goto err_free_pci_vec;
> > +     }
> > +
> > +     mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
> >       if (!mdev) {
> >               ret = -ENOMEM;
> >               goto err_free_pci_vec;
> > @@ -286,7 +293,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> >
> >       dev = container_of(mdev, struct mt7921_dev, mt76);
> >       dev->hif_ops = &mt7921_pcie_ops;
> > -
> > +     dev->ops = ops;
> >       mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
> >       tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > index 487acd6e2be8..6d27875f41b8 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > @@ -120,18 +120,23 @@ static int mt7921s_probe(struct sdio_func *func,
> >               .fw_own = mt7921s_mcu_fw_pmctrl,
> >       };
> >
> > +     struct ieee80211_ops *ops;
> >       struct mt7921_dev *dev;
> >       struct mt76_dev *mdev;
> >       int ret;
> >
> > -     mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
> > -                              &drv_ops);
> > +     ops = devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops),
> > +                        GFP_KERNEL);
> > +     if (!ops)
> > +             return -ENOMEM;
> > +
> > +     mdev = mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
> >       if (!mdev)
> >               return -ENOMEM;
> >
> >       dev = container_of(mdev, struct mt7921_dev, mt76);
> >       dev->hif_ops = &mt7921_sdio_ops;
> > -
> > +     dev->ops = ops;
> >       sdio_set_drvdata(func, dev);
> >
> >       ret = mt76s_init(mdev, func, &mt7921s_ops);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> > index d06cee386acd..cf3ec59a4270 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> > @@ -217,6 +217,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
> >
> >       dev = container_of(mdev, struct mt7921_dev, mt76);
> >       dev->hif_ops = &hif_ops;
> > +     dev->ops = ops;
> >
> >       udev = usb_get_dev(udev);
> >       usb_reset_device(udev);
> > --
> > 2.25.1
> >
