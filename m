Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81891457346
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhKSQoz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 11:44:55 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:43846 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235422AbhKSQoy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 11:44:54 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.171])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B04432A0070;
        Fri, 19 Nov 2021 16:41:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5FF029C0076;
        Fri, 19 Nov 2021 16:41:51 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3033F13C2B0;
        Fri, 19 Nov 2021 08:41:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3033F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637340102;
        bh=N1ZFxU/kkNHhKhMayg8e/YxKyS5klPFwA2x8U6h1bU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ya8b1sOv50SgOrurCWyomeH3pw2zIdE9lP2ePRVUBq4f1RuVSUq2+sDG2hthZ/ubg
         dDFheg8sHAJSX3tSHw34BVzrLzMxp8ZI7InV81z6Yxi5aqDrdck53TokgoaZEN95cK
         28ZrOgrBO5HINh8nlnN149y+f4of261fEF3ODyDw=
Subject: Re: [PATCH 01/11] mt76: mt7915: add comments about rx descriptor
 parsing
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20211118164056.2965-1-greearb@candelatech.com>
 <YZfR1d2I6pqEzqT8@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9c758bbb-bb0c-94be-f10b-a78f6a220f92@candelatech.com>
Date:   Fri, 19 Nov 2021 08:41:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YZfR1d2I6pqEzqT8@lore-desk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1637340112-tUBySnv1etZu
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/19/21 8:33 AM, Lorenzo Bianconi wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This is a tricky beast to understand, so add some notes for
>> next time someone is looking at this code and trying to compare
>> against documents.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>
>> txs and related patches rebased on top of 5.16
>>
>>   .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index 8e5b87af2efb..6fbd58ae9c88 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -410,6 +410,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   	__le32 *rxd = (__le32 *)skb->data;
>>   	__le32 *rxv = NULL;
>>   	u32 mode = 0;
>> +	/* table "PP -> HOST / X-CPU"  RX Format */
>>   	u32 rxd0 = le32_to_cpu(rxd[0]);
>>   	u32 rxd1 = le32_to_cpu(rxd[1]);
>>   	u32 rxd2 = le32_to_cpu(rxd[2]);
>> @@ -489,7 +490,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   
>>   	rxd += 6;
>>   	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
>> -		u32 v0 = le32_to_cpu(rxd[0]);
>> +		u32 v0 = le32_to_cpu(rxd[0]); /* DW6 */
>>   		u32 v2 = le32_to_cpu(rxd[2]);
>>   
>>   		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
>> @@ -502,6 +503,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   	}
>>   
>>   	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
>> +		/* DW10, assuming Group-4 enabled */
>>   		u8 *data = (u8 *)rxd;
>>   
>>   		if (status->flag & RX_FLAG_DECRYPTED) {
>> @@ -533,6 +535,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   	}
>>   
>>   	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
>> +		/* DW14, assuming group-1,4 */
>>   		status->timestamp = le32_to_cpu(rxd[0]);
>>   		status->flag |= RX_FLAG_MACTIME_START;
>>   
>> @@ -558,18 +561,22 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
>>   		u32 v0, v1, v2;
>>   
>> -		rxv = rxd;
>> +		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
>>   		rxd += 2;
>>   		if ((u8 *)rxd - skb->data >= skb->len)
>>   			return -EINVAL;
>>   
>> -		v0 = le32_to_cpu(rxv[0]);
>> +		v0 = le32_to_cpu(rxv[0]);  /* DW16, P-VEC1 31:0 */
>> +		/* DW17, RX_RCPI copied over P-VEC 64:32 Per RX Format doc. */
> 
> This seems not so useful for everybody.

It was put in for folks doing dev work on this driver, so just a handful
of people in the whole world.  It doesn't need to be useful for lots
of people.

> 
>>   		v1 = le32_to_cpu(rxv[1]);
>> -		v2 = le32_to_cpu(rxv[2]);
>> +		v2 = le32_to_cpu(rxv[2]); /* first DW of group-5, C-RXV */
>>   
>>   		if (v0 & MT_PRXV_HT_AD_CODE)
>>   			status->enc_flags |= RX_ENC_FLAG_LDPC;
>>   
>> +		/* TODO:  When group-5 is enabled, use nss (and stbc) to
>> +		 * calculate chains properly for this particular skb.
>> +		 */
>>   		status->chains = mphy->antenna_mask;
>>   		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
>>   		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
>> @@ -581,12 +588,18 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
>>   			if (!(status->chains & BIT(i)))
>>   				continue;
>>   
>> +			/* TODO:  Use db sum logic instead of max. */
> 
> This seems just a not for you :)

Anyone wanting proper RSSI.  The current implementation is wrong
and could be off by as much as 6db on a 4x4 radio.

I will fix it eventually if no one beats me to it.

Anyway, please apply anything you think is helpful, leave out
the rest.

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

