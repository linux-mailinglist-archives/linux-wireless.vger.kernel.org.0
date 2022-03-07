Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0584F4CFD99
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiCGMB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 07:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiCGMBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 07:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D149E30F68
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 04:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646654459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATKSEMN6k0hxr9u8yZ6wR06a9NExmEjSFLWGpKs7N4E=;
        b=O1y8suaefxyTPyUli0YbKUaAWcH6iZDtBBfTBraSiWKvJsVYbskSL6Z4snD3Uqa8NTWkDH
        C1HVe5kjKuKy2RlrTLIOh/IeHkIK3lDg2FPW0Q4aEH0L8W0UmI5iDml0F+5Gr6xo+nP9r8
        WYPun2BEYjTBzAfUGCVA337BYHETGzs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-EiqI-xKnNLKtZV7iBUm63Q-1; Mon, 07 Mar 2022 07:00:58 -0500
X-MC-Unique: EiqI-xKnNLKtZV7iBUm63Q-1
Received: by mail-yb1-f197.google.com with SMTP id q76-20020a25d94f000000b00628bdf8d1a9so11336645ybg.17
        for <linux-wireless@vger.kernel.org>; Mon, 07 Mar 2022 04:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATKSEMN6k0hxr9u8yZ6wR06a9NExmEjSFLWGpKs7N4E=;
        b=uz4mn37UIntzpKZWnxmMJXgdKZd1XGys8Tlb1Z8wvF9NcekwWp9hgu4Zlnk1gpsuz5
         YetEU78ICJBb2FnwJGSjGNASgzo7VwNDqawdZ9ztpOw0EW0WWl3ygPOqH4rgDRHLfLlZ
         ZOdchzVv47QGdzpa86mUHMhxFzzZFj7+0izpX1fHLRvB/M7j7Hv71IMMInanEW2xhxqj
         3PP0AzpUXorA+QpbFAkyYF9JXO2/vW2HqSysCalE1CKBqwDPsLPr5x+0Gm6UW+VQ1cQi
         Oezk1530YWVhED01NdeYhl2T/c8GLOD48CpZbb9IReVAKu8MVahHXUTDfnE+5MD8RTTM
         y41A==
X-Gm-Message-State: AOAM533m96LEtFiE86wyJ5IqZpxJOu6WFOCudvb+0g2mJAoaMtKIDfAz
        AizDpekGKk6wpZ6j8y9s1/0wFxBhLADgAoW/YUssPdlV3J0P/m8eMR7f/rAkeyZuog7bl1NarQw
        kbsrcXAiAFQxBmhr5oDxI2f+VCoW0AL5ksOM0WZfKRC0=
X-Received: by 2002:a25:6910:0:b0:628:ddbb:4b98 with SMTP id e16-20020a256910000000b00628ddbb4b98mr7704353ybc.12.1646654458094;
        Mon, 07 Mar 2022 04:00:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIR0dvTVeHVqR/2AGxAo5Z0rKVkapX6UJG7NMIfC4+6GlLtH7nnRV2nKNVsQBJ7VQ7aDJ6DfOdI9iS5w0qefk=
X-Received: by 2002:a25:6910:0:b0:628:ddbb:4b98 with SMTP id
 e16-20020a256910000000b00628ddbb4b98mr7704282ybc.12.1646654457274; Mon, 07
 Mar 2022 04:00:57 -0800 (PST)
MIME-Version: 1.0
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
In-Reply-To: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 7 Mar 2022 13:00:46 +0100
Message-ID: <CAJ0CqmWQxORW8+++DVW3ujYccfCq_DB5hNOMn+gMs8kgoTk=5w@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
To:     Sean Wang <sean.wang@mediatek.com>,
        =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Firmware initialization can take a while. Move mt7921_init_hw routine in
> a dedicated work in order to not slow down bootstrap process.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Sean and Deren,

I tested this patch on mt7921e and mt7921u. Can you double check if it
works fine even on mt7921s? Thanks.

Regards,
Lorenzo

> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
>  2 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index fa6af85bba7b..332af886b95a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct mt7921_dev *dev)
>
>  static int mt7921_init_hardware(struct mt7921_dev *dev)
>  {
> -       int ret, idx, i;
> +       int ret, i;
>
>         set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
>
> @@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
>                 return ret;
>         }
>
> +       return 0;
> +}
> +
> +static int mt7921_init_wcid(struct mt7921_dev *dev)
> +{
> +       int idx;
> +
>         /* Beacon and mgmt frames should occupy wcid 0 */
>         idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
>         if (idx)
> @@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
>         return 0;
>  }
>
> +static void mt7921_init_work(struct work_struct *work)
> +{
> +       struct mt7921_dev *dev = container_of(work, struct mt7921_dev,
> +                                             init_work);
> +       int ret;
> +
> +       ret = mt7921_init_hardware(dev);
> +       if (ret)
> +               return;
> +
> +       mt76_set_stream_caps(&dev->mphy, true);
> +       mt7921_set_stream_he_caps(&dev->phy);
> +
> +       ret = mt76_register_device(&dev->mt76, true, mt76_rates,
> +                                  ARRAY_SIZE(mt76_rates));
> +       if (ret) {
> +               dev_err(dev->mt76.dev, "register device failed\n");
> +               return;
> +       }
> +
> +       ret = mt7921_init_debugfs(dev);
> +       if (ret) {
> +               dev_err(dev->mt76.dev, "debugfs register failed\n");
> +               goto error;
> +       }
> +
> +       ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> +       if (ret)
> +               goto error;
> +
> +       dev->hw_init_done = true;
> +       return;
> +error:
> +       mt76_unregister_device(&dev->mt76);
> +}
> +
>  int mt7921_register_device(struct mt7921_dev *dev)
>  {
>         struct ieee80211_hw *hw = mt76_hw(dev);
> @@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>         spin_lock_init(&dev->sta_poll_lock);
>
>         INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
> +       INIT_WORK(&dev->init_work, mt7921_init_work);
>
>         dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
>         dev->pm.stats.last_wake_event = jiffies;
> @@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>         if (mt76_is_sdio(&dev->mt76))
>                 hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
>
> -       ret = mt7921_init_hardware(dev);
> +       ret = mt7921_init_wcid(dev);
>         if (ret)
>                 return ret;
>
> @@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
>         dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
>         dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
>
> -       mt76_set_stream_caps(&dev->mphy, true);
> -       mt7921_set_stream_he_caps(&dev->phy);
> -
> -       ret = mt76_register_device(&dev->mt76, true, mt76_rates,
> -                                  ARRAY_SIZE(mt76_rates));
> -       if (ret)
> -               return ret;
> -
> -       ret = mt7921_init_debugfs(dev);
> -       if (ret)
> -               return ret;
> -
> -       ret = mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.ds_enable);
> -       if (ret)
> -               return ret;
> -
> -       dev->hw_init_done = true;
> +       queue_work(system_wq, &dev->init_work);
>
>         return 0;
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 394a677140da..b6c8f84acb64 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -204,6 +204,8 @@ struct mt7921_dev {
>         struct list_head sta_poll_list;
>         spinlock_t sta_poll_lock;
>
> +       struct work_struct init_work;
> +
>         u8 fw_debug;
>
>         struct mt76_connac_pm pm;
> --
> 2.35.1
>

