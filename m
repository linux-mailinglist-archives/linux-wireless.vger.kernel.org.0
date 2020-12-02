Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F12CB701
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgLBIYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 03:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgLBIYv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 03:24:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165AC0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Dec 2020 00:24:11 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kkNQh-000zeZ-Qe; Wed, 02 Dec 2020 09:24:03 +0100
Message-ID: <9b1543d8798277bbfc891b794362451432d98884.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix rx byte values not updated on mesh link
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thiraviyam Mariyappan <tmariyap@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 02 Dec 2020 09:23:57 +0100
In-Reply-To: <1606884912-10987-1-git-send-email-tmariyap@codeaurora.org> (sfid-20201202_055729_704309_A90E5928)
References: <1606884912-10987-1-git-send-email-tmariyap@codeaurora.org>
         (sfid-20201202_055729_704309_A90E5928)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-02 at 10:25 +0530, Thiraviyam Mariyappan wrote:
> In mesh link, rx byte values were not updating though rx packets keep
> increasing in the station dump. This is because of rx_stats were updated
> regardless of USES_RSS flag is enabled/disabled. Solved the issue by
> updating the rx_stats from percpu pointers according to the USES_RSS flag

You should write commit logs in imperative voice, e.g. "Solve the
issue..."

> +++ b/net/mac80211/rx.c
> @@ -2212,6 +2212,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
>  	unsigned int frag, seq;
>  	struct ieee80211_fragment_entry *entry;
>  	struct sk_buff *skb;
> +	struct ieee80211_sta_rx_stats *stats;
>  
>  	hdr = (struct ieee80211_hdr *)rx->skb->data;
>  	fc = hdr->frame_control;
> @@ -2340,8 +2341,12 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
>   out:
>  	ieee80211_led_rx(rx->local);
>   out_no_led:
> -	if (rx->sta)
> -		rx->sta->rx_stats.packets++;
> +	if (rx->sta) {
> +		stats = &rx->sta->rx_stats;
> +		if (ieee80211_hw_check(&rx->sdata->local->hw, USES_RSS))
> +			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
> +		stats->packets++;
> +	}
>  	return RX_CONTINUE;
> 

This is certainly not only related to mesh, so the commit log is wrong.

Also, let's not copy/paste this code so much ...

johannes

