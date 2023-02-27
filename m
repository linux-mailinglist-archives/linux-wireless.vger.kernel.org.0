Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1206A4539
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjB0Oxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 09:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjB0Oxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 09:53:32 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B91700
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eB83paBqD06C1BScIlGydnS358iqjr8wNv2pDhUVZKI=; b=ET+GXY3IIDp+knBKHZCRRecx5m
        Uhc3G74eCegp8RrvSUfJoCAmkmcv0os+750/qg8tq0uf5d3HOaG6GmBM1Y6QJJaVtxOMvipYsoPkw
        nMCly8cBuu1iAPrBAv5GmccV/O0AMc5lcBn2kwZABODQk95M7kieCoom7sgxaCSa4Q48=;
Received: from [2a01:598:b1b4:3fa:18e7:7065:7b44:d8a2] (helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pWesU-00CXNS-4Z; Mon, 27 Feb 2023 15:53:22 +0100
Message-ID: <0dd4e459-613e-5ec2-1437-ae98683c4b26@nbd.name>
Date:   Mon, 27 Feb 2023 15:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Sriram R <quic_srirrama@quicinc.com>
References: <20230227110738.54241-1-nbd@nbd.name>
 <20230227110738.54241-4-nbd@nbd.name>
 <7cc08b19d3ac643ed21c5c4325a4a8a64c4233f6.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [RFC 4/5] wifi: mac80211: mesh fast xmit support
In-Reply-To: <7cc08b19d3ac643ed21c5c4325a4a8a64c4233f6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27.02.23 14:14, Johannes Berg wrote:
> On Mon, 2023-02-27 at 12:07 +0100, Felix Fietkau wrote:
>> 
>> +	/* If the skb is shared we need to obtain our own copy */
>> +	if (skb_shared(skb)) {
>> +		struct sk_buff *oskb = skb;
>> +
>> +		skb = skb_clone(skb, GFP_ATOMIC);
>> +		if (!skb)
>> +			return false;
>> +
>> +		kfree_skb(oskb);
>> +	}
> 
> Use skb_share_check()?
Will do.

>>  	next_hop = rcu_dereference(mpath->next_hop);
>>  	if (next_hop) {
>>  		memcpy(hdr->addr1, next_hop->sta.addr, ETH_ALEN);
>>  		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
>>  		ieee80211_mps_set_frame_flags(sdata, next_hop, hdr);
>> +		if (ieee80211_hw_check(&sdata->local->hw, SUPPORT_FAST_XMIT))
>> +			mesh_fast_tx_cache(sdata, skb, mpath);
> 
> 
> I wondered briefly if it's worth moving that check into the function,
> but not sure.
I put it there to avoid an extra function call for the non-fast-xmit case.

>> +	/* rate limit, in case fast xmit can't be enabled */
>> +	if (mppath->fast_tx_check == jiffies)
>> +		return;
>> +
>> +	mppath->fast_tx_check = jiffies;
> 
> once every jiffies seems pretty frequent though?
It should never happen under normal conditions anyway. It's just a bit 
of extra safety to avoid doing this per packet under high load if a 
corner case hits.

>> +	spin_lock_bh(&cache->walk_lock);
> 
> you could just spin_lock() the inner lock, _bh already taken care of by
> the outer?
Will do.

>> @@ -3686,7 +3690,7 @@ static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
>>  #endif
>>  
>>  	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
>> -		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
>> +		u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
>>  		*ieee80211_get_qos_ctl(hdr) = tid;
> 
> That's ... interesting, why wss there an argument in the first place?
I think last time I changed the code, I intended to use the tid value, 
but forgot to drop this line that assigns it.

> but maybe add a blank line now :)
Sure.

Thanks,

- Felix
