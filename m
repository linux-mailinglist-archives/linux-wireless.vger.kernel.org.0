Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30D83EBBA3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhHMRqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHMRqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 13:46:34 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8CCC061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8YrbaCWBN6o2dZTIsmftPtA1nwsbp5/jkn8U66mIBzU=; b=kKvGJj0nzH7svxAH/JHSmkGj80
        mcgRH/BKS17Ik3Vl85EOGWmUnIP/OMEZIggwS5Ug8PSMkvAO+NxxbZf8Ppded7Bs5tx2+Xs6aFszy
        UyTKo06gpRD4eu7wGOxjzgbgDjXj++Z/k7dBmREfxX7j7F3/7fIaRI9vDi1izhbfLT/Q=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEbFp-0003Lb-3w; Fri, 13 Aug 2021 19:46:01 +0200
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <ec49f403-54d3-28e1-3ea8-811df0756b29@nbd.name>
 <0a7e7206-91c0-35a9-8935-20bc6283367f@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v5 01/11] mt76: add hash lookup for skb on TXS status_list
Message-ID: <d479d24c-87b4-51c3-8f07-d71480913f8f@nbd.name>
Date:   Fri, 13 Aug 2021 19:46:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0a7e7206-91c0-35a9-8935-20bc6283367f@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 19:28, Ben Greear wrote:
> On 8/13/21 9:50 AM, Felix Fietkau wrote:
>> 
>> On 2021-08-04 15:44, greearb@candelatech.com wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> This improves performance when sending lots of frames that
>>> are requesting being mapped to a TXS callback.
>>>
>>> Add comments to help next person understood the tx path
>>> better.
>>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> ---
>>>
>>> v5:  Rebased on top of previous series.
>>>
>>>   drivers/net/wireless/mediatek/mt76/mt76.h     | 48 +++++++---
>>>   .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
>>>   .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
>>>   .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
>>>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  8 +-
>>>   .../net/wireless/mediatek/mt76/mt7921/mac.c   |  9 +-
>>>   drivers/net/wireless/mediatek/mt76/tx.c       | 90 ++++++++++++++++---
>>>   7 files changed, 132 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
>>> index 436bf2b8e2cd..016f563fec39 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
>>> @@ -235,6 +235,14 @@ DECLARE_EWMA(signal, 10, 8);
>>>   #define MT_WCID_TX_INFO_TXPWR_ADJ	GENMASK(25, 18)
>>>   #define MT_WCID_TX_INFO_SET		BIT(31)
>>>   
>>> +#define MT_PACKET_ID_MASK		GENMASK(6, 0)
>>> +#define MT_PACKET_ID_NO_ACK		0
>>> +/* Request TXS, but don't try to match with skb. */
>>> +#define MT_PACKET_ID_NO_SKB		1
>>> +#define MT_PACKET_ID_FIRST		2
>>> +#define MT_PACKET_ID_HAS_RATE		BIT(7)
>>> +#define MT_PACKET_ID_MAX		(GENMASK(7, 0) - 1)
>>> +
>>>   struct mt76_wcid {
>>>   	struct mt76_rx_tid __rcu *aggr[IEEE80211_NUM_TIDS];
>>>   
>>> @@ -246,6 +254,8 @@ struct mt76_wcid {
>>>   
>>>   	struct rate_info rate;
>>>   
>>> +	struct sk_buff *skb_status_array[MT_PACKET_ID_MAX + 1];
>> You could add this to reduce the struct size:
>> #define MT_NUM_STATUS_PACKETS \
>> 	(MT_PACKET_ID_MAX + 1 - MT_PACKET_ID_FIRST)
>> 
>> And then subtract MT_PACKET_ID_FIRST from cache entries.
> 
> That saves two void* bytes of memory, and complicates the code a bit?
> I can do the change, just doesn't seem worthwhile to me.
It's not much more complicated (simple subtraction in very few places),
and the memory saved is per station.

>>>   	u16 idx;
>>>   	u8 hw_key_idx;
>>>   	u8 hw_key_idx2;
>>> @@ -302,13 +312,8 @@ struct mt76_rx_tid {
>>>   #define MT_TX_CB_TXS_DONE		BIT(1)
>>>   #define MT_TX_CB_TXS_FAILED		BIT(2)
>>>   
>>> -#define MT_PACKET_ID_MASK		GENMASK(6, 0)
>>> -#define MT_PACKET_ID_NO_ACK		0
>>> -#define MT_PACKET_ID_NO_SKB		1
>>> -#define MT_PACKET_ID_FIRST		2
>>> -#define MT_PACKET_ID_HAS_RATE		BIT(7)
>>> -
>>> -#define MT_TX_STATUS_SKB_TIMEOUT	HZ
>>> +/* This is timer for when to give up when waiting for TXS callback. */
>>> +#define MT_TX_STATUS_SKB_TIMEOUT	(HZ / 8)
>> I think the way timeouts are checked now, HZ/8 is way too short.
>> I would recommend checking timeout only for packets where
>> MT_TX_CB_DMA_DONE is already set, and setting cb->jiffies from within
>> __mt76_tx_status_skb_done on DMA completion. That should make it
>> possible to keep the timeout short without running into it in cases
>> where significant congestion adds huge completion latency.
> 
> Ok, I like that idea.  What is reasonable timeout from time of DMA done
> before we give up on TXS callback?
Your value of HZ / 8 seems reasonable to me for that case.

>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>>> index d9f52e2611a7..8f5702981900 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>>> @@ -1318,6 +1318,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
>>>   
>>>   	mt76_tx_status_lock(mdev, &list);
>>>   	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
>>> +
>>> +	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
>> Please drop this comment, since you're deleting in another patch in this
>> series anyway.
>> 
>>> @@ -1417,10 +1419,14 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
>>>   		stats->tx_bw[0]++;
>>>   		break;
>>>   	}
>>> +
>>> +	/* Cache rate for packets that don't get a TXS callback for some
>>> +	 * reason.
>>> +	 */
>>>   	wcid->rate = rate;
>> That comment is wrong, wcid->rate is cached because HE rates can't be
>> reported via skb->cb due to lack of space.
> 
> We can update the rate from txs callback, and and from txfree path,
> and also from querying the firmware rate-ctrl registers (I think?).
> TXS is disabled for most frames by default.  txfree gives only some
> info, not enough.  And polling rate-ctrl registers is slow.
> 
> So I think the comment is OK, but I end up modifying the code later anyway,
> so I can remove this comment if you prefer.
Yes, please do that.

>>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>>> index 6f302acb6e69..4c8504d3c904 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>>> @@ -130,15 +154,30 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
>>>   			     IEEE80211_TX_CTL_RATE_CTRL_PROBE)))
>>>   		return MT_PACKET_ID_NO_SKB;
>>>   
>>> +	/* due to limited range of the pktid (7 bits), we can only
>>> +	 * have a limited number of outstanding frames.  I think it is OK to
>>> +	 * check the length outside of a lock since it doesn't matter too much
>>> +	 * if we read wrong data here.
>>> +	 * The TX-status callbacks don't always return a callback for an SKB,
>>> +	 * so the status_list may contain some stale skbs.  Those will be cleaned
>>> +	 * out periodically, see MT_TX_STATUS_SKB_TIMEOUT.
>>> +	 */
>>> +
>>> +	qlen = skb_queue_len(&dev->status_list);
>>> +	if (qlen > 120)
>>> +		return MT_PACKET_ID_NO_SKB;
>> Checking the length of the per-device status list doesn't make sense,
>> since pktid allocation is per-wcid.
> 
> Ok, so just remove this code, or should I set some other higher
> limit to bound the list?
You could just check for a duplicate skb_status_array entry.

- Felix
