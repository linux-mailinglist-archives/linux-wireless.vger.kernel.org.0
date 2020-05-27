Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1041E4604
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbgE0Ofg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 10:35:36 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58248 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389205AbgE0Ofg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 10:35:36 -0400
Received: from [192.168.178.45] (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 33CE3580063;
        Wed, 27 May 2020 16:35:34 +0200 (CEST)
Subject: Re: [PATCH 2/3] nl80211: add control port tx status method
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
 <20200508144202.7678-3-markus.theil@tu-ilmenau.de>
 <f3cf96426f9532904c9f256d963e7915aa399a90.camel@sipsolutions.net>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <5a3f01a8-45d2-47c6-3e1b-32ef33be4e95@tu-ilmenau.de>
Date:   Wed, 27 May 2020 16:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f3cf96426f9532904c9f256d963e7915aa399a90.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/26/20 3:37 PM, Johannes Berg wrote:
>>  	struct idr ack_status_frames;
>>  	spinlock_t ack_status_lock;
>>  
>> +	u64 ctrl_port_cookie_counter;
> We have a u64 for other things (remain-on-channel), perhaps should just
> share? It's not going to overflow even if shared ...
Sounds fair, I'll consolidate to use the roc cookie variable.
>>  	/* disable bottom halves when entering the Tx path */
>>  	local_bh_disable();
>> -	__ieee80211_subif_start_xmit(skb, dev, flags, 0);
>> +	__ieee80211_subif_start_xmit(skb, dev, flags, 0, NULL);
> This is a little awkward, any way to avoid that? Probably not ...
I first tried to read out the cookie from the skb, in order to avoid
adding this new argument.
Problematic with this approach was, that the skb can be deleted in some
failure cases.
Therefore I went with this additional argument.
>> +static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
>>  				   struct sk_buff *skb,
>> -				   u32 *info_flags)
>> +				   u32 *info_flags,
>> +				   bool use_socket,
>> +				   u64 *cookie)
>>  {
>> -	struct sk_buff *ack_skb = skb_clone_sk(skb);
>> +	struct sk_buff *ack_skb;
>>  	u16 info_id = 0;
>>  
>> +	if (use_socket)
> You can check skb->sk and not need the additional parameter.
Thanks for the hint!
>
>>  	if (unlikely(!multicast && skb->sk &&
>>  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
>> -		info_id = ieee80211_store_ack_skb(local, skb, &info_flags);
>> +		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
>> +						  true, NULL);
>> +
>> +	if (unlikely(!multicast && ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
>> +		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
>> +						  false, cookie);
> I think this should be rolled into one condition, since you no longer
> need the true/false if you check skb->sk. And 'cookie' is already NULL
> in those other cases so you can pass it unconditionally.
Ok
>> @@ -2765,8 +2795,9 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
>>  	if (skb_shared(skb)) {
>>  		struct sk_buff *tmp_skb = skb;
>>  
>> -		/* can't happen -- skb is a clone if info_id != 0 */
>> -		WARN_ON(info_id);
>> +		if (!(ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
>> +			/* can't happen -- skb is a clone if info_id != 0 */
>> +			WARN_ON(info_id);
> This I don't understand, but if it really is needed then you should
> adjust the comment and roll it into a single WARN_ON().
After adapting my patch with the changes lined out above, I have tested
again and the warning
did not occur. Therefore I've ommited changing the warning behavior from
the updated patch.
> Also, please put all the remaining mac80211 changes into one patch - I
> already put all the other changes in.
>
> johannes
>
Thanks for your feedback! I'll send an updated v2 with a single patch.

