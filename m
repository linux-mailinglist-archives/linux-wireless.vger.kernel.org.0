Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414DE519D7C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348438AbiEDLBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348423AbiEDLBg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:01:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87971EEF1
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hwq1xmYhKVHQT08f+0HO3TWklmolU3gZ7Rx8anC3GSs=;
        t=1651661880; x=1652871480; b=N17VSDqHTyeeqKqQ4dFeXUrurHgr0RmLx3l7zjXCS3ANx2E
        X08AcB3XV4cL0hHAVt8anYHnSYoLAfJ4wQ+/vhk74CXsXKnJt6KpsPI+QS8yWJpNw7ZgdKJjJirKO
        gyvPngUufwHoEl5PAebsFKj0f5HwYjI+oVYSICf7LOfJa7lLQMzfITGPhIbmyyZg+vUnX+ZDGLiXo
        ijNjdipfCXVMGiJ/ZbcZy1GcGOLOE7wECML4BZYxz3vFTXDEfE7Nh4rXNMdY3bNjmESJhlIPo5AbX
        3IuXZRe9jUrTcO0oy5WvKns0NUp1ZxhUTpZYtOE4AWZqzG0mSse8mZua5rx16IJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmChj-0020ia-7E;
        Wed, 04 May 2022 12:57:59 +0200
Message-ID: <175612fa5385cf2c30207df9012074df2c65f551.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] iwlwifi:  RX signal improvements.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 12:57:58 +0200
In-Reply-To: <20220225232842.32028-2-greearb@candelatech.com>
References: <20220225232842.32028-1-greearb@candelatech.com>
         <20220225232842.32028-2-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-25 at 15:28 -0800, greearb@candelatech.com wrote:
> 
> -	if (mvmsta->avg_energy) {
> -		sinfo->signal_avg = -(s8)mvmsta->avg_energy;
> +	if (iwl_mvm_has_new_rx_api(mvm)) { /* rxmq logic */
> +		/* Grab chain signal avg, mac80211 cannot do it because
> +		 * this driver uses RSS.  Grab signal_avg here too because firmware
> +		 * appears go not do DB summing and/or has other bugs. --Ben
> +		 */

That "--Ben" really seems inappropriate ... please take more care when
sending patches to the list.

>  		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
> +		sinfo->signal_avg = -ewma_signal_read(&mvmsta->rx_avg_signal);
> +
> +		if (!mvmvif->bf_data.bf_enabled) {
> +			/* The firmware reliably reports different signal (2db weaker in my case)


dB, but I guess we'll want to fix that instead or so ...

> +static inline int iwl_mvm_sum_sigs_2(int a, int b)
> +{

Feels like that calls for a helper function somewhere else, and a
comment explaining it :)

> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
> @@ -278,14 +278,26 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
>  static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
>  					struct ieee80211_rx_status *rx_status,
>  					u32 rate_n_flags, int energy_a,
> -					int energy_b)
> +					int energy_b, struct ieee80211_sta *sta,
> +					bool is_beacon, bool my_beacon)
>  {
>  	int max_energy;
>  	u32 rate_flags = rate_n_flags;
> +	struct iwl_mvm_sta *mvmsta = NULL;
> +
> +	if (sta && !(is_beacon && !my_beacon)) {
> +		mvmsta = iwl_mvm_sta_from_mac80211(sta);
> +		if (energy_a)
> +			ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
> +		if (energy_b)
> +			ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
> +	}

This is obviously racy for the exact same reason that mac80211 doesn't
give you averages ... you cannot do that.

Without locking, you have to rely on the firmware, and I don't think we
want any locking here.

> @@ -295,6 +307,15 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
>  		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
>  	rx_status->chain_signal[0] = energy_a;
>  	rx_status->chain_signal[1] = energy_b;
> +
> +	if (mvmsta) {
> +		if (is_beacon) {
> +			if (my_beacon)
> +				ewma_signal_add(&mvmsta->rx_avg_beacon_signal, -max_energy);
> +		} else {
> +			ewma_signal_add(&mvmsta->rx_avg_signal, -max_energy);
> +		}
> +	}

Why would you ignore "is_beacon && !my_beacon" cases, but handle all
other management frames from everyone?

> @@ -1878,6 +1899,16 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
>  		goto out;
>  	}
>  
> +	is_beacon = ieee80211_is_beacon(hdr->frame_control);
> +	if (is_beacon && sta) {
> +		/* see if it is beacon destined for us */
> +		if (memcmp(sta->addr, hdr->addr2, ETH_ALEN) == 0)
> +			my_beacon = true;

don't use memcmp() for that.


Anyway this really needs a lot of work, it cannot work as is.

johannes
