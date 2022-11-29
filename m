Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7763C348
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiK2PFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 10:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PFB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 10:05:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B3421A6
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 07:05:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E110B660165C;
        Tue, 29 Nov 2022 15:04:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669734298;
        bh=Zt6+6zk5Sq08WO06c/3RsDKZoTGXt8kyWvLZNd9EsoQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P72O6Oz0aoPXxI5/vDQ1ww9E75aU9okDQfwZLn9dMTKbDjV8qBzY+8EhZ4J1FdXNR
         7E1sAMUr0NEICbbw0lJbyZEKhqMog10K3BFtUtxC4lrZPK7plzvglncOk1/449C1p3
         l+Jg92yQi6YqZ6uEmSchs6O4Taq3oSAUr2zr1vvm37uVOw8VlyLbMtqnFxwGXKRaew
         H4Wqw2VpUPtNvuc7tzRCMEOJQzDBHLX/0cApeozB/m/CFX8WWA34rVmFRkUTnppQHK
         NFokAGZVc5u0gBDebH4yYIQi4+gHd5YNatkPCDdvCxUjiiU2RPjOq8fl3uiO6rSL2J
         4TN58IZmyqPQw==
Message-ID: <fa5f8821-ec1d-1def-1f59-33ede6096629@collabora.com>
Date:   Tue, 29 Nov 2022 16:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] wifi: mt76: mt7921e: add reboot notifier support
Content-Language: en-US
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <d44631bcc74cce3f32a72f616a99d1bd2837690f.1669711916.git.deren.wu@mediatek.com>
 <dbde826071f59f03e52efc632a8b2f5bf11752d5.1669711916.git.deren.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dbde826071f59f03e52efc632a8b2f5bf11752d5.1669711916.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Il 29/11/22 10:16, Deren Wu ha scritto:
> From: Leon Yen <Leon.Yen@mediatek.com>
> 
> cleanup/reset chip fw before reboot to avoid unstable problems in next run.
> 
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>

Apart from the comment in patch [1/1] ....

I've noticed that this issue is present also on MT7915E: in my case, I have
two of these cards installed on a nVidia Xavier NX Developer Kit and one on
a Raspberry Pi 4 Compute Module mounted on an original CM4 IO Board.

The two on Xavier NX are not showing this issue, but the Pi CM4 cannot see
the card when rebooting the system... so that chip cleanup action should
actually be replicated on mt7915/pci.c as well, if possible.

Regards,
Angelo

> ---
>   .../net/wireless/mediatek/mt76/mt7921/pci.c   | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index 28342ec940f0..4e9021c349b9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -226,6 +226,25 @@ static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
>   	return dev->bus_ops->rmw(mdev, addr, mask, val);
>   }
>   
> +static int mt7921e_reboot_notifier(struct notifier_block *nb,
> +				   unsigned long code, void *unused)
> +{
> +	struct mt76_dev *mdev = container_of(nb, struct mt76_dev,
> +					     reboot_nb);
> +	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> +	struct mt76_connac_pm *pm = &dev->pm;
> +
> +	cancel_delayed_work_sync(&pm->ps_work);
> +	cancel_work_sync(&pm->wake_work);
> +
> +	/* chip cleanup before reboot */
> +	mt7921_mcu_drv_pmctrl(dev);
> +	mt7921_dma_cleanup(dev);
> +	mt7921_wfsys_reset(dev);
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int mt7921_pci_probe(struct pci_dev *pdev,
>   			    const struct pci_device_id *id)
>   {
> @@ -357,6 +376,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>   	if (ret)
>   		goto err_free_irq;
>   
> +	mdev->reboot_nb.notifier_call = mt7921e_reboot_notifier;
> +
>   	ret = mt7921_register_device(dev);
>   	if (ret)
>   		goto err_free_irq;
> 

