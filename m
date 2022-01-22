Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873B4496910
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiAVBHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 20:07:03 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:58268 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230371AbiAVBHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 20:07:03 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.28])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D0AC91A006F
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 01:07:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9624338007D
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 01:07:01 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0A73E13C2B0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jan 2022 17:07:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0A73E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642813621;
        bh=vH+o4n4PJp6tjgn9O5Ucf8ACLJNSnbEti0nvRBD7Y50=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dkqQptJXljC8LupiP/sj5eXyZdWoSqfeyJ8o9+XUrd9/WAcSkanKmI3wq+E59nYMo
         wBcWoUTYv4YrjlIOFMaLr8qyH4HP5qdXrrkwvNWM4bAMSR0FOdlexVIL1CWUz7eaC9
         zjNkeKgVEkWt4o5k+7cJViPLUG7vS/wn3u8JFFhY=
Subject: Re: [PATCH] mt76: Ensure sale skb status list is processed.
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20220121195548.17476-1-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <256db504-e4f5-21e0-b621-c086f73f88c5@candelatech.com>
Date:   Fri, 21 Jan 2022 17:07:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220121195548.17476-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1642813622-F_u6o3HoWMAa
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/21/22 11:55 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> The old code might not ever run the stale skb status processing
> list, so change it to ensure the stale entries are cleaned up
> regularly.

Please ignore this, I did not understand how the mac_work logic could
call the tx_status_skb_get such that pktid was purposefully invalid
and thus cause the cleanup logic to happen.

Perhaps my original issue this attempted to fix was related to
some other problem.

Thanks,
Bne

> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
>   drivers/net/wireless/mediatek/mt76/tx.c   | 24 +++++++++++++++++------
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index 37d82d806c09..bfb68788251f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -271,6 +271,7 @@ struct mt76_wcid {
>   
>   	struct list_head list;
>   	struct idr pktid;
> +	unsigned long last_idr_check_at; /* in jiffies */
>   };
>   
>   struct mt76_txq {
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> index 938353ac272f..b6f0d74fd563 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -157,24 +157,35 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
>   		       struct sk_buff_head *list)
>   {
>   	struct sk_buff *skb;
> +	struct sk_buff *skb2;
>   	int id;
> +	/* Check twice as often as the timeout value so that we mitigate
> +	 * worse-case timeout detection (where we do the check right before
> +	 * the per skb timer would have expired and so have to wait another interval
> +	 * to detect the skb status timeout.)
> +	 */
> +	static const int check_interval = MT_TX_STATUS_SKB_TIMEOUT / 2;
>   
>   	lockdep_assert_held(&dev->status_lock);
>   
>   	skb = idr_remove(&wcid->pktid, pktid);
> -	if (skb)
> +
> +	/* If we have not checked for stale entries recently,
> +	 * then do that check now.
> +	 */
> +	if (time_is_after_jiffies(wcid->last_idr_check_at + check_interval))
>   		goto out;
>   
>   	/* look for stale entries in the wcid idr queue */
> -	idr_for_each_entry(&wcid->pktid, skb, id) {
> -		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
> +	idr_for_each_entry(&wcid->pktid, skb2, id) {
> +		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb2);
>   
>   		if (pktid >= 0) {
>   			if (!(cb->flags & MT_TX_CB_DMA_DONE))
>   				continue;
>   
>   			if (time_is_after_jiffies(cb->jiffies +
> -						   MT_TX_STATUS_SKB_TIMEOUT))
> +						  MT_TX_STATUS_SKB_TIMEOUT))
>   				continue;
>   		}
>   
> @@ -182,9 +193,10 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
>   		 * and stop waiting for TXS callback.
>   		 */
>   		idr_remove(&wcid->pktid, cb->pktid);
> -		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
> -						    MT_TX_CB_TXS_DONE, list);
> +		__mt76_tx_status_skb_done(dev, skb2, MT_TX_CB_TXS_FAILED |
> +					  MT_TX_CB_TXS_DONE, list);
>   	}
> +	wcid->last_idr_check_at = jiffies;
>   
>   out:
>   	if (idr_is_empty(&wcid->pktid))
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

