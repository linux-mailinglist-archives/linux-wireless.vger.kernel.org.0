Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3856F23A279
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgHCKGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHCKGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 06:06:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB8C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 03:06:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2XMb-00FcTn-HN; Mon, 03 Aug 2020 12:06:37 +0200
Message-ID: <3645e35d47acdf9b776ee2a0bedfb4075526d8cc.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: add receive path for ethernet frame format
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <srirrama@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Date:   Mon, 03 Aug 2020 12:06:27 +0200
In-Reply-To: <1591763456-23275-2-git-send-email-srirrama@codeaurora.org> (sfid-20200610_063219_943440_D0E4FDEE)
References: <1591763456-23275-1-git-send-email-srirrama@codeaurora.org>
         <1591763456-23275-2-git-send-email-srirrama@codeaurora.org>
         (sfid-20200610_063219_943440_D0E4FDEE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

sorry for the delay.

> +static const u8 pae_group_addr[ETH_ALEN] __aligned(2) = {0x01, 0x80, 0xC2, 0x00,
> +							 0x00, 0x03};

Why the strange line breaking, and not preserve like it was:

>  static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
>  {
> -	static const u8 pae_group_addr[ETH_ALEN] __aligned(2)
> -		= { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x03 };
>  	struct ethhdr *ehdr = (struct ethhdr *) rx->skb->data;


> @@ -2582,9 +2584,12 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
>  		 * for non-QoS-data frames. Here we know it's a data
>  		 * frame, so count MSDUs.
>  		 */
> -		u64_stats_update_begin(&rx->sta->rx_stats.syncp);
> -		rx->sta->rx_stats.msdu[rx->seqno_idx]++;
> -		u64_stats_update_end(&rx->sta->rx_stats.syncp);
> +		rx_stats = &rx->sta->rx_stats;
> +		if (ieee80211_hw_check(&rx->local->hw, USES_RSS))
> +			rx_stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
> +		u64_stats_update_begin(&rx_stats->syncp);
> +		rx_stats->msdu[rx->seqno_idx]++;
> +		u64_stats_update_end(&rx_stats->syncp);
>  	}

This seems like an unrelated fix?

> +	if (ieee80211_hw_check(&local->hw, USES_RSS))
> +		stats = this_cpu_ptr(sta->pcpu_rx_stats);
> +
> +	/* TODO: Extend ieee80211_rx_8023() with bssid so that Ethernet
> +	 * encap/decap can be supported in Adhoc interface type as well.
> +	 * Adhoc interface depends on bssid to update last_rx.

What would the plan for this be? And I guess by that I mostly mean
"where's the space for it"? In a function argument?

Any reason not to do this from the start, to avoid having to change the
API again later? Though I guess the bssid argument could then be allowed
to be NULL for the modes listed:

> +	if (vif->type != NL80211_IFTYPE_STATION &&
> +	    vif->type != NL80211_IFTYPE_AP_VLAN &&
> +	    vif->type != NL80211_IFTYPE_AP)
> +		goto drop;


> +
> +	if (unlikely(!test_sta_flag(sta, WLAN_STA_AUTHORIZED))) {
> +		if (ehdr->h_proto != sdata->control_port_protocol)
> +			goto drop;
> +		else if (!ether_addr_equal(ehdr->h_dest, vif->addr) &&
> +			 !ether_addr_equal(ehdr->h_dest, pae_group_addr))
> +			goto drop;
> +	}

Maybe refactor ieee80211_frame_allowed() a bit? This is basically the
same as the first condition in there, after all. Then you'd also not
have to pull pae_group_addr to the file scope.

> +	if (status->flag & RX_FLAG_80211_MCAST) {
> +		for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
> +			key = rcu_dereference(sta->gtk[i]);
> +			if (key)
> +				break;

What? This doesn't seem right at all.

Either you cannot support multiple GTKs (umm?) or you should probably
have the right one somehow? Or maybe you don't need to do anything per
key?

> +		}
> +	} else {
> +		key = rcu_dereference(sta->ptk[sta->ptk_idx]);
> +	}
> +
> +	if (key && unlikely(key->flags & KEY_FLAG_TAINTED))
> +		goto drop;
> +
> +	if (status->flag & RX_FLAG_MMIC_ERROR) {
> +		if (key)
> +			key->u.tkip.mic_failures++;
> +		goto mic_fail;
> +	}

But then you do per-key things.

> +	if (!(status->flag & RX_FLAG_DUP_VALIDATED))
> +		goto drop;
> +
> +	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
> +
> +	if (!(status->flag & RX_FLAG_80211_MCAST)) {
> +		stats->last_rx = jiffies;
> +		stats->last_rate = sta_stats_encode_rate(status);
> +	}
> +
> +	if (sdata->vif.type == NL80211_IFTYPE_STATION &&
> +	    !(status->flag & RX_FLAG_80211_MCAST))
> +		ieee80211_sta_reset_conn_monitor(sdata);
> +
> +	u64_stats_update_begin(&stats->syncp);
> +	stats->fragments++;
> +	stats->packets++;

fragments and packets don't need the begin/end, do they?

> +	stats->bytes += skb->len;
> +	u64_stats_update_end(&stats->syncp);
> +
> +	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
> +		stats->last_signal = status->signal;
> +		if (!ieee80211_hw_check(&local->hw, USES_RSS))
> +			ewma_signal_add(&sta->rx_stats_avg.signal,
> +					-status->signal);
> +	}
> +
> +	if (status->chains) {
> +		stats->chains = status->chains;
> +		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
> +			int signal = status->chain_signal[i];
> +
> +			if (!(status->chains & BIT(i)))
> +				continue;
> +
> +			stats->chain_signal_last[i] = signal;
> +			if (!ieee80211_hw_check(&local->hw, USES_RSS))
> +				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
> +						-signal);
> +		}
> +	}

This seems very duplicated - can you refactor it?

> +	if (unlikely(ehdr->h_proto == cpu_to_be16(ETH_P_TDLS))) {
> +		struct ieee80211_tdls_data *tf = (void *)skb->data;
> +
> +		if (pskb_may_pull(skb,
> +				  offsetof(struct ieee80211_tdls_data, u)) &&
> +		    tf->payload_type == WLAN_TDLS_SNAP_RFTYPE &&
> +		    tf->category == WLAN_CATEGORY_TDLS &&
> +		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
> +		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
> +			skb_queue_tail(&local->skb_queue_tdls_chsw, skb);
> +			schedule_work(&local->tdls_chsw_work);
> +			return;
> +		}
> +	}

same here.

Ultimately, it seems that the parts of the RX path _after_ conversion
really ought to be the same between the normal and offloaded conversion?
So why wouldn't those be (essentially) the same code?

> +	/* FIXME: Since rx.seqno_idx is not available for decap offloaded frames
> +	 * rx msdu stats update at the seqno_idx in ieee80211_deliver_skb()
> +	 * will always be updated at index 0 and will not be very useful.
> +	 */
> +	ieee80211_deliver_skb(&rx);

That's an issue. You should either fix that or prevent the bad counters
being shown to userspace - IMHO lack of stats is better than broken
stats.

johannes

