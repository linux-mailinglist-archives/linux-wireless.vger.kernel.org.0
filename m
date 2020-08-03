Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F523A2DA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgHCKor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 06:44:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53197 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgHCKor (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 06:44:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596451486; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/Gk1Qi0aPnNMXh+iuoltPoL0r6LvD3QpQnyxkC3SRyM=;
 b=fOrtlZx/j6W+SzAkShLHbCQrUWkdqV8e7Cyr9Ox/fmMah+F0c0dhW41dtmDOZ6Fo1OZOOYmT
 AKe/5YuHUA6bcuLefHvn1ZVo2ytPck/IN3h65ymToG5sF87m4fmbpJz9WeN8gC7w8wztB4tJ
 /TjUAd/3lZa4/LCKsLh25RtIfko=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f27ea9521feae908b2fc2d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 10:44:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 496A7C433CA; Mon,  3 Aug 2020 10:44:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76D85C433C6;
        Mon,  3 Aug 2020 10:44:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Aug 2020 16:14:35 +0530
From:   Sriram R <srirrama@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: Re: [PATCH 1/2] mac80211: add receive path for ethernet frame format
In-Reply-To: <3645e35d47acdf9b776ee2a0bedfb4075526d8cc.camel@sipsolutions.net>
References: <1591763456-23275-1-git-send-email-srirrama@codeaurora.org>
 <1591763456-23275-2-git-send-email-srirrama@codeaurora.org>
 (sfid-20200610_063219_943440_D0E4FDEE)
 <3645e35d47acdf9b776ee2a0bedfb4075526d8cc.camel@sipsolutions.net>
Message-ID: <e2f3106b02fc418c9711c1c638a1bd5d@codeaurora.org>
X-Sender: srirrama@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
On 2020-08-03 15:36, Johannes Berg wrote:
> Hi,
> 
> sorry for the delay.
> 
>> +static const u8 pae_group_addr[ETH_ALEN] __aligned(2) = {0x01, 0x80, 
>> 0xC2, 0x00,
>> +							 0x00, 0x03};
> 
> Why the strange line breaking, and not preserve like it was:
I'll fix in next revision.
> 
>>  static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, 
>> __le16 fc)
>>  {
>> -	static const u8 pae_group_addr[ETH_ALEN] __aligned(2)
>> -		= { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x03 };
>>  	struct ethhdr *ehdr = (struct ethhdr *) rx->skb->data;
> 
> 
>> @@ -2582,9 +2584,12 @@ ieee80211_deliver_skb(struct ieee80211_rx_data 
>> *rx)
>>  		 * for non-QoS-data frames. Here we know it's a data
>>  		 * frame, so count MSDUs.
>>  		 */
>> -		u64_stats_update_begin(&rx->sta->rx_stats.syncp);
>> -		rx->sta->rx_stats.msdu[rx->seqno_idx]++;
>> -		u64_stats_update_end(&rx->sta->rx_stats.syncp);
>> +		rx_stats = &rx->sta->rx_stats;
>> +		if (ieee80211_hw_check(&rx->local->hw, USES_RSS))
>> +			rx_stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
>> +		u64_stats_update_begin(&rx_stats->syncp);
>> +		rx_stats->msdu[rx->seqno_idx]++;
>> +		u64_stats_update_end(&rx_stats->syncp);
>>  	}
> 
> This seems like an unrelated fix?
Yes, I'll move this separately.
> 
>> +	if (ieee80211_hw_check(&local->hw, USES_RSS))
>> +		stats = this_cpu_ptr(sta->pcpu_rx_stats);
>> +
>> +	/* TODO: Extend ieee80211_rx_8023() with bssid so that Ethernet
>> +	 * encap/decap can be supported in Adhoc interface type as well.
>> +	 * Adhoc interface depends on bssid to update last_rx.
> 
> What would the plan for this be? And I guess by that I mostly mean
> "where's the space for it"? In a function argument?
> 
> Any reason not to do this from the start, to avoid having to change the
> API again later? Though I guess the bssid argument could then be 
> allowed
> to be NULL for the modes listed:
Sure, i'll extend the api in next revision.
> 
>> +	if (vif->type != NL80211_IFTYPE_STATION &&
>> +	    vif->type != NL80211_IFTYPE_AP_VLAN &&
>> +	    vif->type != NL80211_IFTYPE_AP)
>> +		goto drop;
> 
> 
>> +
>> +	if (unlikely(!test_sta_flag(sta, WLAN_STA_AUTHORIZED))) {
>> +		if (ehdr->h_proto != sdata->control_port_protocol)
>> +			goto drop;
>> +		else if (!ether_addr_equal(ehdr->h_dest, vif->addr) &&
>> +			 !ether_addr_equal(ehdr->h_dest, pae_group_addr))
>> +			goto drop;
>> +	}
> 
> Maybe refactor ieee80211_frame_allowed() a bit? This is basically the
> same as the first condition in there, after all. Then you'd also not
> have to pull pae_group_addr to the file scope.
> 
Sure. I'll refactor this and similar duplicate code below in next 
revision.
>> +	if (status->flag & RX_FLAG_80211_MCAST) {
>> +		for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
>> +			key = rcu_dereference(sta->gtk[i]);
>> +			if (key)
>> +				break;
> 
> What? This doesn't seem right at all.
I'll update ieee80211_rx_8023() to get some meta data of the received 
packet
such as key id and tid from the driver, so that this key id selection 
and
  tid stats issue pointed below is also resolved.
> 
> Either you cannot support multiple GTKs (umm?) or you should probably
> have the right one somehow? Or maybe you don't need to do anything per
> key?
> 
>> +		}
>> +	} else {
>> +		key = rcu_dereference(sta->ptk[sta->ptk_idx]);
>> +	}
>> +
>> +	if (key && unlikely(key->flags & KEY_FLAG_TAINTED))
>> +		goto drop;
>> +
>> +	if (status->flag & RX_FLAG_MMIC_ERROR) {
>> +		if (key)
>> +			key->u.tkip.mic_failures++;
>> +		goto mic_fail;
>> +	}
> 
> But then you do per-key things.
> 
>> +	if (!(status->flag & RX_FLAG_DUP_VALIDATED))
>> +		goto drop;
>> +
>> +	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
>> +
>> +	if (!(status->flag & RX_FLAG_80211_MCAST)) {
>> +		stats->last_rx = jiffies;
>> +		stats->last_rate = sta_stats_encode_rate(status);
>> +	}
>> +
>> +	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
>> +	    !(status->flag & RX_FLAG_80211_MCAST))
>> +		ieee80211_sta_reset_conn_monitor(sdata);
>> +
>> +	u64_stats_update_begin(&stats->syncp);
>> +	stats->fragments++;
>> +	stats->packets++;
> 
> fragments and packets don't need the begin/end, do they?
I'll remove it.
> 
>> +	stats->bytes += skb->len;
>> +	u64_stats_update_end(&stats->syncp);
>> +
>> +	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
>> +		stats->last_signal = status->signal;
>> +		if (!ieee80211_hw_check(&local->hw, USES_RSS))
>> +			ewma_signal_add(&sta->rx_stats_avg.signal,
>> +					-status->signal);
>> +	}
>> +
>> +	if (status->chains) {
>> +		stats->chains = status->chains;
>> +		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
>> +			int signal = status->chain_signal[i];
>> +
>> +			if (!(status->chains & BIT(i)))
>> +				continue;
>> +
>> +			stats->chain_signal_last[i] = signal;
>> +			if (!ieee80211_hw_check(&local->hw, USES_RSS))
>> +				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
>> +						-signal);
>> +		}
>> +	}
> 
> This seems very duplicated - can you refactor it?
Sure.
> 
>> +	if (unlikely(ehdr->h_proto == cpu_to_be16(ETH_P_TDLS))) {
>> +		struct ieee80211_tdls_data *tf = (void *)skb->data;
>> +
>> +		if (pskb_may_pull(skb,
>> +				  offsetof(struct ieee80211_tdls_data, u)) &&
>> +		    tf->payload_type == WLAN_TDLS_SNAP_RFTYPE &&
>> +		    tf->category == WLAN_CATEGORY_TDLS &&
>> +		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
>> +		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
>> +			skb_queue_tail(&local->skb_queue_tdls_chsw, skb);
>> +			schedule_work(&local->tdls_chsw_work);
>> +			return;
>> +		}
>> +	}
> 
> same here.
> 
> Ultimately, it seems that the parts of the RX path _after_ conversion
> really ought to be the same between the normal and offloaded 
> conversion?
> So why wouldn't those be (essentially) the same code?
Yes, i'll remove these duplicate code in next revision.
> 
>> +	/* FIXME: Since rx.seqno_idx is not available for decap offloaded 
>> frames
>> +	 * rx msdu stats update at the seqno_idx in ieee80211_deliver_skb()
>> +	 * will always be updated at index 0 and will not be very useful.
>> +	 */
>> +	ieee80211_deliver_skb(&rx);
> 
> That's an issue. You should either fix that or prevent the bad counters
> being shown to userspace - IMHO lack of stats is better than broken
> stats.
As mentioned, we can extend the api to allow the driver to pass tid as 
part of rx metadata and have the
stats updated.

Thanks for review.

Regards,
Sriram.R
> 
> johannes
