Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111833EBB77
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhHMR2d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 13:28:33 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:55830 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhHMR2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 13:28:32 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.23])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C8706A006D;
        Fri, 13 Aug 2021 17:28:04 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7DCFF90007F;
        Fri, 13 Aug 2021 17:28:04 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B7CE913C2B1;
        Fri, 13 Aug 2021 10:28:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B7CE913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628875684;
        bh=HyebG9KsbrxwVct0UISZ/dOiKBqdcz3b1pujexCD1B8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MyLYItpRRUlyp9FLxNK09k1KEfQd0sT58P06mfCrDHnzO1dGDcBQmhJQHYhAKKELb
         V1sMsYQ9tyBHR8fjGOHaC+uT+ezYewHXuQk4NzS/RVvn7r7yIbASMw2Aged64fBTbs
         TzM8YA0fuAe7OOOpAZdFS3tx9eWBZhNdcjWrNlgU=
Subject: Re: [PATCH v5 01/11] mt76: add hash lookup for skb on TXS status_list
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <ec49f403-54d3-28e1-3ea8-811df0756b29@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0a7e7206-91c0-35a9-8935-20bc6283367f@candelatech.com>
Date:   Fri, 13 Aug 2021 10:28:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ec49f403-54d3-28e1-3ea8-811df0756b29@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1628875685-qV2OVBlp6rlz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/13/21 9:50 AM, Felix Fietkau wrote:
> 
> On 2021-08-04 15:44, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This improves performance when sending lots of frames that
>> are requesting being mapped to a TXS callback.
>>
>> Add comments to help next person understood the tx path
>> better.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> v5:  Rebased on top of previous series.
>>
>>   drivers/net/wireless/mediatek/mt76/mt76.h     | 48 +++++++---
>>   .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
>>   .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
>>   .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
>>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  8 +-
>>   .../net/wireless/mediatek/mt76/mt7921/mac.c   |  9 +-
>>   drivers/net/wireless/mediatek/mt76/tx.c       | 90 ++++++++++++++++---
>>   7 files changed, 132 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
>> index 436bf2b8e2cd..016f563fec39 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
>> @@ -235,6 +235,14 @@ DECLARE_EWMA(signal, 10, 8);
>>   #define MT_WCID_TX_INFO_TXPWR_ADJ	GENMASK(25, 18)
>>   #define MT_WCID_TX_INFO_SET		BIT(31)
>>   
>> +#define MT_PACKET_ID_MASK		GENMASK(6, 0)
>> +#define MT_PACKET_ID_NO_ACK		0
>> +/* Request TXS, but don't try to match with skb. */
>> +#define MT_PACKET_ID_NO_SKB		1
>> +#define MT_PACKET_ID_FIRST		2
>> +#define MT_PACKET_ID_HAS_RATE		BIT(7)
>> +#define MT_PACKET_ID_MAX		(GENMASK(7, 0) - 1)
>> +
>>   struct mt76_wcid {
>>   	struct mt76_rx_tid __rcu *aggr[IEEE80211_NUM_TIDS];
>>   
>> @@ -246,6 +254,8 @@ struct mt76_wcid {
>>   
>>   	struct rate_info rate;
>>   
>> +	struct sk_buff *skb_status_array[MT_PACKET_ID_MAX + 1];
> You could add this to reduce the struct size:
> #define MT_NUM_STATUS_PACKETS \
> 	(MT_PACKET_ID_MAX + 1 - MT_PACKET_ID_FIRST)
> 
> And then subtract MT_PACKET_ID_FIRST from cache entries.

That saves two void* bytes of memory, and complicates the code a bit?
I can do the change, just doesn't seem worthwhile to me.

>>   	u16 idx;
>>   	u8 hw_key_idx;
>>   	u8 hw_key_idx2;
>> @@ -302,13 +312,8 @@ struct mt76_rx_tid {
>>   #define MT_TX_CB_TXS_DONE		BIT(1)
>>   #define MT_TX_CB_TXS_FAILED		BIT(2)
>>   
>> -#define MT_PACKET_ID_MASK		GENMASK(6, 0)
>> -#define MT_PACKET_ID_NO_ACK		0
>> -#define MT_PACKET_ID_NO_SKB		1
>> -#define MT_PACKET_ID_FIRST		2
>> -#define MT_PACKET_ID_HAS_RATE		BIT(7)
>> -
>> -#define MT_TX_STATUS_SKB_TIMEOUT	HZ
>> +/* This is timer for when to give up when waiting for TXS callback. */
>> +#define MT_TX_STATUS_SKB_TIMEOUT	(HZ / 8)
> I think the way timeouts are checked now, HZ/8 is way too short.
> I would recommend checking timeout only for packets where
> MT_TX_CB_DMA_DONE is already set, and setting cb->jiffies from within
> __mt76_tx_status_skb_done on DMA completion. That should make it
> possible to keep the timeout short without running into it in cases
> where significant congestion adds huge completion latency.

Ok, I like that idea.  What is reasonable timeout from time of DMA done
before we give up on TXS callback?

> 
>> @@ -1297,13 +1303,33 @@ mt76_token_put(struct mt76_dev *dev, int token)
>>   }
>>   
>>   static inline int
>> -mt76_get_next_pkt_id(struct mt76_wcid *wcid)
>> +mt76_get_next_pkt_id(struct mt76_dev *dev, struct mt76_wcid *wcid,
>> +		     struct sk_buff *skb)
>>   {
>> +	struct sk_buff *qskb;
>> +
>> +	lockdep_assert_held(&dev->status_list.lock);
>> +
>>   	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
>> -	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
>> -	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
>> +	if (wcid->packet_id < MT_PACKET_ID_FIRST)
>>   		wcid->packet_id = MT_PACKET_ID_FIRST;
>>   
>> +	qskb = wcid->skb_status_array[wcid->packet_id];
>> +	if (qskb) {
>> +		/* bummer, already waiting on this pid.  See if it is stale. */
>> +		struct mt76_tx_cb *cb = mt76_tx_skb_cb(qskb);
>> +
>> +		if (!time_after(jiffies, cb->jiffies + MT_TX_STATUS_SKB_TIMEOUT)) {
>> +			/* ok, not stale.  Increment pid anyway, will try next
>> +			 * slot next time
>> +			 */
>> +			return MT_PACKET_ID_NO_SKB;
>> +		}
>> +	}
>> +
>> +	/* cache this skb for fast lookup by packet-id */
>> +	wcid->skb_status_array[wcid->packet_id] = skb;
>> +
> I think mt76_get_next_pkt_id is not a good place for caching the skb.
> Better cache it in the same place that also puts the skb in the status
> list: mt76_tx_status_skb_add
> 
> That way you can drop your (possibly broken) changes to mt7921, which
> calls mt76_get_next_pkt_id directly, but does not support tx status
> tracking for skbs.

Ok, I will try that.

> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index d9f52e2611a7..8f5702981900 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -1318,6 +1318,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
>>   
>>   	mt76_tx_status_lock(mdev, &list);
>>   	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
>> +
>> +	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
> Please drop this comment, since you're deleting in another patch in this
> series anyway.
> 
>> @@ -1417,10 +1419,14 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
>>   		stats->tx_bw[0]++;
>>   		break;
>>   	}
>> +
>> +	/* Cache rate for packets that don't get a TXS callback for some
>> +	 * reason.
>> +	 */
>>   	wcid->rate = rate;
> That comment is wrong, wcid->rate is cached because HE rates can't be
> reported via skb->cb due to lack of space.

We can update the rate from txs callback, and and from txfree path,
and also from querying the firmware rate-ctrl registers (I think?).
TXS is disabled for most frames by default.  txfree gives only some
info, not enough.  And polling rate-ctrl registers is slow.

So I think the comment is OK, but I end up modifying the code later anyway,
so I can remove this comment if you prefer.

> 
> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>> index 6f302acb6e69..4c8504d3c904 100644
>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>> @@ -130,15 +154,30 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
>>   			     IEEE80211_TX_CTL_RATE_CTRL_PROBE)))
>>   		return MT_PACKET_ID_NO_SKB;
>>   
>> +	/* due to limited range of the pktid (7 bits), we can only
>> +	 * have a limited number of outstanding frames.  I think it is OK to
>> +	 * check the length outside of a lock since it doesn't matter too much
>> +	 * if we read wrong data here.
>> +	 * The TX-status callbacks don't always return a callback for an SKB,
>> +	 * so the status_list may contain some stale skbs.  Those will be cleaned
>> +	 * out periodically, see MT_TX_STATUS_SKB_TIMEOUT.
>> +	 */
>> +
>> +	qlen = skb_queue_len(&dev->status_list);
>> +	if (qlen > 120)
>> +		return MT_PACKET_ID_NO_SKB;
> Checking the length of the per-device status list doesn't make sense,
> since pktid allocation is per-wcid.

Ok, so just remove this code, or should I set some other higher
limit to bound the list?

Thanks,
Ben

> 
> - Felix
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
