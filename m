Return-Path: <linux-wireless+bounces-4459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471E4875437
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 17:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32951F223E9
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD553366;
	Thu,  7 Mar 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WRAaaX7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC012EBEB
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829287; cv=none; b=QybCDOIkTPLiyH0RchlQHYsJGVAXDpza3ChOOd4a0J1udL80AHiayKaiz6Kx21CtZaZUcksgYID4FA6cqK++qkGiJz14jSsWh1jQF7dlVXLwtFCKQyMLzHTnSi8L+NGiBFBUm1OUDxUf4O8XREcuxQSLeYhX2G5ykaws2qMbyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829287; c=relaxed/simple;
	bh=HEl67rgBltv239sfOcJC9NNvrvRy/R4jqdWdd3+mDrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHX3Ecmjwpu3CofYKATFwOxeVizhNSSTsIlD9cJZfakGgx5E5SmnXc+O8fUtgZ3tcMxLzLwz4bBr1eDEPcGeNlsfwz7m6TMe7CwQBhPPsNPIsV9isVSRAsqCX7trGdMrQYu6UbPwNEwtGgSrZyVGnvi4CdkQ34w7teqmVOa8tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WRAaaX7C; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C94258C0090;
	Thu,  7 Mar 2024 16:34:35 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5FD8713C2B0;
	Thu,  7 Mar 2024 08:34:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5FD8713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709829275;
	bh=HEl67rgBltv239sfOcJC9NNvrvRy/R4jqdWdd3+mDrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WRAaaX7C1watv5wxRHh6ihR0fiEJsvelFnc8C7O5PuaDtBk+9BLOpGxFM3RS/fdrb
	 bfs3taFseSoIBQN6iRCSvvd9fHOM2y65HQB4AEDYCxZbW+liEnFFpAKdkjag3ghikT
	 DGaq+LJYjO/jUpGaASSLE74l1fP0Gp9H+Uz3HZn8=
Message-ID: <fcaf3039-e1ea-cd82-07d8-2aa33544edfa@candelatech.com>
Date: Thu, 7 Mar 2024 08:34:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mt76: mt7921s: fix potential hung tasks during chip
 recovery
Content-Language: en-US
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, nbd@nbd.name,
 lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com,
 Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
 robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com,
 Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240307094632.21638-1-mingyen.hsieh@mediatek.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240307094632.21638-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709829278-ek1p80uEYpVq
X-MDID-O:
 us5;at1;1709829278;ek1p80uEYpVq;<greearb@candelatech.com>;4565bb147eaa37fbc7c729da17b34891

On 3/7/24 01:46, Mingyen Hsieh wrote:
> From: Leon Yen <leon.yen@mediatek.com>
> 
> During chip recovery (e.g. chip reset), there is a possible situation that
> kernel worker reset_work is holding the lock and waiting for kernel thread
> stat_worker to be parked, while stat_worker is waiting for the release of
> the same lock.
> It causes a deadlock resulting in the dumping of hung tasks messages and
> possible rebooting of the device.
> 
> This patch prevents the execution of stat_worker during the chip recovery.

Hello,

I was able to hang my 7996 system doing a radio reset yesterday.  Is this same
or similar fix needed for 7996?

Thanks
Ben

> 
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  | 2 --
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 2 --
>   drivers/net/wireless/mediatek/mt76/sdio.c            | 3 ++-
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> index 867e14f6b93a..73e42ef42983 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -663,6 +663,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>   	int i, ret;
>   
>   	dev_dbg(dev->mt76.dev, "chip reset\n");
> +	set_bit(MT76_RESET, &dev->mphy.state);
>   	dev->hw_full_reset = true;
>   	ieee80211_stop_queues(hw);
>   
> @@ -691,6 +692,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
>   	}
>   
>   	dev->hw_full_reset = false;
> +	clear_bit(MT76_RESET, &dev->mphy.state);
>   	pm->suspended = false;
>   	ieee80211_wake_queues(hw);
>   	ieee80211_iterate_active_interfaces(hw,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index c866144ff061..031ba9aaa4e2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -64,7 +64,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
>   	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
>   	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
>   
> -	set_bit(MT76_RESET, &dev->mphy.state);
>   	set_bit(MT76_MCU_RESET, &dev->mphy.state);
>   	wake_up(&dev->mt76.mcu.wait);
>   	skb_queue_purge(&dev->mt76.mcu.res_q);
> @@ -115,7 +114,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
>   
>   	err = __mt7921_start(&dev->phy);
>   out:
> -	clear_bit(MT76_RESET, &dev->mphy.state);
>   
>   	local_bh_disable();
>   	napi_enable(&dev->mt76.tx_napi);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
> index 389eb0903807..1f77cf71ca70 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
> @@ -98,7 +98,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
>   	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
>   	mt76_txq_schedule_all(&dev->mphy);
>   	mt76_worker_disable(&dev->mt76.tx_worker);
> -	set_bit(MT76_RESET, &dev->mphy.state);
>   	set_bit(MT76_MCU_RESET, &dev->mphy.state);
>   	wake_up(&dev->mt76.mcu.wait);
>   	skb_queue_purge(&dev->mt76.mcu.res_q);
> @@ -135,7 +134,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
>   
>   	err = __mt7921_start(&dev->phy);
>   out:
> -	clear_bit(MT76_RESET, &dev->mphy.state);
>   
>   	mt76_worker_enable(&dev->mt76.tx_worker);
>   
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
> index 3e88798df017..a4ed00eebc48 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> @@ -499,7 +499,8 @@ static void mt76s_tx_status_data(struct mt76_worker *worker)
>   	dev = container_of(sdio, struct mt76_dev, sdio);
>   
>   	while (true) {
> -		if (test_bit(MT76_REMOVED, &dev->phy.state))
> +		if (test_bit(MT76_RESET, &dev->phy.state) ||
> +		    test_bit(MT76_REMOVED, &dev->phy.state))
>   			break;
>   
>   		if (!dev->drv->tx_status_data(dev, &update))

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



