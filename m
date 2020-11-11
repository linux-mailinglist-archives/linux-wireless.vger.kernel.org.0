Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546032AEB1B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKKIYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 03:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKKIYX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 03:24:23 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709EC0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 00:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v0Ig0r23/GQ1nGeJGXh3ql0JPj6pwiY2+ZUj/gSuOPg=; b=by5ZEzhfrLD/tOUIiTaGvH5j8f
        +tSGMB75VZ1dZT3WMpI50wsKj3o3h+rP0IV3JEu2wwHDxze6DFAkOiWV/sqVjNfhx1uH+q8NuBNWj
        /y2LhgQJiumrF9OVwH9k0eJbBpHb3tzpFSaDlydQ55nhPfwBHWTxr3sFtaRCPRdyeXQc=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kclQR-0000RK-C7; Wed, 11 Nov 2020 09:24:19 +0100
Subject: Re: [PATCH 06/10] mt76: rely on mt76_phy in tx_queue_skb signature
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
References: <cover.1605048763.git.lorenzo@kernel.org>
 <2d64149efd52e67ab0865fc8d12a66d6f80e948a.1605048763.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <ba325bef-3ff2-a8e1-67cb-b0e6f949d6b9@nbd.name>
Date:   Wed, 11 Nov 2020 09:24:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <2d64149efd52e67ab0865fc8d12a66d6f80e948a.1605048763.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-11-11 00:02, Lorenzo Bianconi wrote:
> Rely on mt76_phy instead of mt76_dev in tx_queue_skb signature.
> This is a preliminary patch to move data queues in mt76_phy and add
> dbdc support to mt7915 driver
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c      |  3 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +--
>  .../wireless/mediatek/mt76/mt7603/beacon.c    | 28 ++++++++++---------
>  .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 ++++----
>  drivers/net/wireless/mediatek/mt76/sdio.c     |  3 +-
>  drivers/net/wireless/mediatek/mt76/testmode.c |  3 +-
>  drivers/net/wireless/mediatek/mt76/tx.c       | 19 +++++++------
>  drivers/net/wireless/mediatek/mt76/usb.c      |  3 +-
>  8 files changed, 41 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index d2e36f5f92b6..8a9c87301fea 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -167,7 +167,7 @@ struct mt76_queue_ops {
>  		     int idx, int n_desc, int bufsize,
>  		     u32 ring_base);
>  
> -	int (*tx_queue_skb)(struct mt76_dev *dev, enum mt76_txq_id qid,
> +	int (*tx_queue_skb)(struct mt76_phy *phy, enum mt76_txq_id qid,
>  			    struct sk_buff *skb, struct mt76_wcid *wcid,
>  			    struct ieee80211_sta *sta);
>  
> @@ -749,7 +749,7 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
>  #define mt76_init_queues(dev)		(dev)->mt76.queue_ops->init(&((dev)->mt76))
>  #define mt76_queue_alloc(dev, ...)	(dev)->mt76.queue_ops->alloc(&((dev)->mt76), __VA_ARGS__)
>  #define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
> -#define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
> +#define mt76_tx_queue_skb(phy, ...)	(phy)->mt76->dev->queue_ops->tx_queue_skb((phy)->mt76, __VA_ARGS__)
I'd prefer having a second macro here for the case where we pass a dev
instead of a phy, so we don't have to change all the older drivers to
use mdev->queue_ops->... directly.

- Felix
