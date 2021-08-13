Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3093EBBCB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhHMSCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 14:02:05 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:45944 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhHMSCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 14:02:04 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.164])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0DE4DA0074;
        Fri, 13 Aug 2021 18:01:36 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C7429B00078;
        Fri, 13 Aug 2021 18:01:35 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 504B713C2B1;
        Fri, 13 Aug 2021 11:01:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 504B713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628877695;
        bh=QvPsfM9+KiEouJA3to7Ayd5foMmgyB+dmM7sn1vMuwY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=U16g1U3A8HezMXskh83Lf86HBfLjtVduDv5V6Bkgt2fpkvOnLRiY6OrXC5sBrYDo7
         rB/qmN1gZeWzP42aBuRB77kTnMOOX+wfoEzm1roILKcJdq0VZ8vQav+qP0jFBsDK40
         HS3tf0Wjm+ENkYzLKfgFKSZlA4fgVbWXWaiF2uyc=
Subject: Re: [PATCH v5 01/11] mt76: add hash lookup for skb on TXS status_list
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <ec49f403-54d3-28e1-3ea8-811df0756b29@nbd.name>
 <0a7e7206-91c0-35a9-8935-20bc6283367f@candelatech.com>
 <d479d24c-87b4-51c3-8f07-d71480913f8f@nbd.name>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <97657c37-8920-c8ba-a05c-28552ab71967@candelatech.com>
Date:   Fri, 13 Aug 2021 11:01:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d479d24c-87b4-51c3-8f07-d71480913f8f@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1628877696-4WsnDSdffVt3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/13/21 10:46 AM, Felix Fietkau wrote:

>>>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>>>> index 6f302acb6e69..4c8504d3c904 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>>>> @@ -130,15 +154,30 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
>>>>    			     IEEE80211_TX_CTL_RATE_CTRL_PROBE)))
>>>>    		return MT_PACKET_ID_NO_SKB;
>>>>    
>>>> +	/* due to limited range of the pktid (7 bits), we can only
>>>> +	 * have a limited number of outstanding frames.  I think it is OK to
>>>> +	 * check the length outside of a lock since it doesn't matter too much
>>>> +	 * if we read wrong data here.
>>>> +	 * The TX-status callbacks don't always return a callback for an SKB,
>>>> +	 * so the status_list may contain some stale skbs.  Those will be cleaned
>>>> +	 * out periodically, see MT_TX_STATUS_SKB_TIMEOUT.
>>>> +	 */
>>>> +
>>>> +	qlen = skb_queue_len(&dev->status_list);
>>>> +	if (qlen > 120)
>>>> +		return MT_PACKET_ID_NO_SKB;
>>> Checking the length of the per-device status list doesn't make sense,
>>> since pktid allocation is per-wcid.
>>
>> Ok, so just remove this code, or should I set some other higher
>> limit to bound the list?
> You could just check for a duplicate skb_status_array entry.

Ok, that will happen anyway when searching for next wcid pkt-id.

The check above was a quick bail-out before locks were acquired.

I'll just remove that qlen check...

Thanks,
Ben

> 
> - Felix
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
