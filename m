Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416CD3D902D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhG1OOW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 10:14:22 -0400
Received: from relay.yourmailgateway.de ([188.68.63.101]:35295 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhG1OOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 10:14:22 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 10:14:21 EDT
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
        by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4GZb4t40gVz51lh;
        Wed, 28 Jul 2021 16:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thomas-graf.de;
        s=key2; t=1627481070;
        bh=h9gsaY/kIyc7WBvTvGFDf2NwSqd6N5aPFn/Sm53dDOo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=c+9LgkXSzlQsMDhZiwoASf6VtECz5zvPLpU6RPhXW2OxUzwvujg6HggfUyHSEt9hX
         TFLl/V3zHREnCbjjIlqvpf+NEiwFeMfkTm7uSE9rILPi0aE3jz+gfjcH53gysrdNH8
         RWJbGKE7eeWduXSEz+HxqSKXjS0cz6nOxVpi/qEDFABrvWIspwPgJEnqd1G9CIz8Gh
         OpIWWv4N/VAabfAFsmHQroeVyZWSMfl2edXs2oqt1lbPlXoWFuruVLapNo7n4S17Nc
         A2MmSErBfQJ6IXnZ4IV39qUjefIeu+Y8/vZGLSSv/njZaG3c3w4UosQcHOjrzdUk6p
         5ZSkh+OnNNwng==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4GZb4t3c29z50sG;
        Wed, 28 Jul 2021 16:04:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx2e9c.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4GZb4s4qgzz8sXK;
        Wed, 28 Jul 2021 16:04:29 +0200 (CEST)
Received: from [IPv6:2a01:c22:a4d3:3700:61df:a7bc:7a08:5e8a] (dynamic-2a01-0c22-a4d3-3700-61df-a7bc-7a08-5e8a.c22.pool.telefonica.de [IPv6:2a01:c22:a4d3:3700:61df:a7bc:7a08:5e8a])
        by mx2e9c.netcup.net (Postfix) with ESMTPSA id 2A3761800B3;
        Wed, 28 Jul 2021 16:04:29 +0200 (CEST)
Authentication-Results: mx2e9c;
        spf=pass (sender IP is 2a01:c22:a4d3:3700:61df:a7bc:7a08:5e8a) smtp.mailfrom=post@thomas-graf.de smtp.helo=[IPv6:2a01:c22:a4d3:3700:61df:a7bc:7a08:5e8a]
Received-SPF: pass (mx2e9c: connection is authenticated)
Subject: Re: [PATCH 5.10 2/3] mac80211: minstrel: remove deferred sampling code
To:     linux-wireless@vger.kernel.org, nbd@nbd.name
References: <20201111183359.43528-1-nbd@nbd.name>
 <20201111183359.43528-2-nbd@nbd.name>
From:   Thomas Graf <post@thomas-graf.de>
Message-ID: <5a3c06de-0970-643f-e895-869dfb376fb9@thomas-graf.de>
Date:   Wed, 28 Jul 2021 16:04:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20201111183359.43528-2-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <162748106940.26985.16265962595563998331@mx2e9c.netcup.net>
X-PPP-Vhost: thomas-graf.de
X-NC-CID: MwH1wp7aksGfWsaYsTYNsgPsgVAvA3q4eazBMrm4H2/0+Rw=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I tracked down an issue with using the Kernel 4.9.277 and 5.4.131 back 
to this patch.

In 802.11bg mode the effective transmit rate drops to 3MBit/s.
With that patch and perfect SNR (> 45dB) I get and rc_stats:

*********************
best   __________rate_________    ________statistics________ 
________last_______    ______sum-of________
rate  [name idx airtime max_tp]  [avg(tp) avg(prob) sd(prob)] 
[prob.|retry|suc|att]  [#success | #attempts]
         1     0    9738    0.9       0.9      93.7      0.5      75.0 
  1     3 4           562   572
         2     1    4922    1.6       1.6      97.0      1.5     100.0 
  1     2 2           559   576
         5.5   2    1858    4.7       4.7      99.9      0.0     100.0 
  2     2 2           542   565
        11     3     982    9.1       9.1      94.9      1.2     100.0 
  4     3 3           560   578
         6     4    1648    5.3       5.3      95.3      1.3     100.0 
  3     3 3           538   595
         9     5    1112    8.0       8.0      97.5      1.8     100.0 
  4     2 2           560   596
        12     6     844   10.5      10.5      92.4      2.0      75.0 
  5     3 4           572   615
        18     7     576   15.5      15.4      89.0      1.4      66.6 
  5     2 3           559   609
    D   24     8     440   20.4      20.4      99.4      1.1     100.0 
  6     2 2           560   604
   C    36     9     308   29.1      29.1      98.7      1.6     100.0 
  6     2 2           565   600
  B     48    10     240   37.3      36.3      87.3      1.4      66.6 
  6     2 3           608   671
A   P  54    11     216   41.6      41.6      97.3      1.7     100.0 
6     3 3           565   620

Total packet count::    ideal 6111      lookaround 652
*********************

After reverting that patch the transmit rate is back to 20MBit/s:
*********************
best   __________rate_________    ________statistics________ 
________last_______    ______sum-of________
rate  [name idx airtime max_tp]  [avg(tp) avg(prob) sd(prob)] 
[prob.|retry|suc|att]  [#success | #attempts]
         1     0    9738    0.9       0.9      99.8      0.6     100.0 
  1     0 0            41   44
         2     1    4922    1.6       1.6     100.0      0.0     100.0 
  1     0 0            45   45
         5.5   2    1858    4.7       4.7      99.9      0.0     100.0 
  2     0 0            43   44
        11     3     982    9.1       9.1      97.0      1.4     100.0 
  4     0 0            44   45
         6     4    1648    5.3       5.3      99.9      0.0     100.0 
  3     0 0            43   44
         9     5    1112    8.0       8.0      99.9      0.0     100.0 
  4     0 0            45   47
        12     6     844   10.5       8.8      74.9      0.7       0.0 
  5     0 0            43   47
        18     7     576   15.5      15.5     100.0      0.0     100.0 
  5     0 0            42   42
    D   24     8     440   20.4      20.4      99.9      0.0     100.0 
  6     0 0            60   62
   C P  36     9     308   29.1      29.1      99.9      0.0     100.0 
  6     0 0            44   46
A      48    10     240   37.3      37.3      93.8      1.2     100.0 
6     1 1           587   618
  B     54    11     216   41.6      32.3      69.8      2.1      33.3 
  6     0 0         24506   25849

Total packet count::    ideal 4962      lookaround 552
*********************

I'm using the ath9k driver with a sparklan WPEA-121N card.

For my case reverting that patch is enough.
What I see is that IEEE80211_TX_CTL_RATE_CTRL_PROBE is set but not used 
anywhere in the code. Maybe there is an easy and better fix than just 
reverting.

Regards,

Thomas

Am 11.11.2020 um 19:33 schrieb Felix Fietkau:
> Deferring sampling attempts to the second stage has some bad interactions
> with drivers that process the rate table in hardware and use the probe flag
> to indicate probing packets (e.g. most mt76 drivers). On affected drivers
> it can lead to probing not working at all.
> 
> If the link conditions turn worse, it might not be such a good idea to
> do a lot of sampling for lower rates in this case.
> 
> Fix this by simply skipping the sample attempt instead of deferring it,
> but keep the checks that would allow it to be sampled if it was skipped
> too often, but only if it has less than 95% success probability.
> 
> Also ensure that IEEE80211_TX_CTL_RATE_CTRL_PROBE is set for all probing
> packets.
> 
> Cc: stable@vger.kernel.org
> Fixes: cccf129f820e ("mac80211: add the 'minstrel' rate control algorithm")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/rc80211_minstrel.c | 25 ++++---------------------
>   net/mac80211/rc80211_minstrel.h |  1 -
>   2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
> index 86bc469a28bc..a8a940e97a9a 100644
> --- a/net/mac80211/rc80211_minstrel.c
> +++ b/net/mac80211/rc80211_minstrel.c
> @@ -287,12 +287,6 @@ minstrel_tx_status(void *priv, struct ieee80211_supported_band *sband,
>   			mi->r[ndx].stats.success += success;
>   	}
>   
> -	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) && (i >= 0))
> -		mi->sample_packets++;
> -
> -	if (mi->sample_deferred > 0)
> -		mi->sample_deferred--;
> -
>   	if (time_after(jiffies, mi->last_stats_update +
>   				mp->update_interval / (mp->new_avg ? 2 : 1)))
>   		minstrel_update_stats(mp, mi);
> @@ -367,7 +361,7 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
>   		return;
>   
>   	delta = (mi->total_packets * sampling_ratio / 100) -
> -			(mi->sample_packets + mi->sample_deferred / 2);
> +			mi->sample_packets;
>   
>   	/* delta < 0: no sampling required */
>   	prev_sample = mi->prev_sample;
> @@ -376,7 +370,6 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
>   		return;
>   
>   	if (mi->total_packets >= 10000) {
> -		mi->sample_deferred = 0;
>   		mi->sample_packets = 0;
>   		mi->total_packets = 0;
>   	} else if (delta > mi->n_rates * 2) {
> @@ -401,19 +394,8 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
>   	 * rate sampling method should be used.
>   	 * Respect such rates that are not sampled for 20 interations.
>   	 */
> -	if (mrr_capable &&
> -	    msr->perfect_tx_time > mr->perfect_tx_time &&
> -	    msr->stats.sample_skipped < 20) {
> -		/* Only use IEEE80211_TX_CTL_RATE_CTRL_PROBE to mark
> -		 * packets that have the sampling rate deferred to the
> -		 * second MRR stage. Increase the sample counter only
> -		 * if the deferred sample rate was actually used.
> -		 * Use the sample_deferred counter to make sure that
> -		 * the sampling is not done in large bursts */
> -		info->flags |= IEEE80211_TX_CTL_RATE_CTRL_PROBE;
> -		rate++;
> -		mi->sample_deferred++;
> -	} else {
> +	if (msr->perfect_tx_time < mr->perfect_tx_time ||
> +	    msr->stats.sample_skipped >= 20) {
>   		if (!msr->sample_limit)
>   			return;
>   
> @@ -433,6 +415,7 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
>   
>   	rate->idx = mi->r[ndx].rix;
>   	rate->count = minstrel_get_retry_count(&mi->r[ndx], info);
> +	info->flags |= IEEE80211_TX_CTL_RATE_CTRL_PROBE;
>   }
>   
>   
> diff --git a/net/mac80211/rc80211_minstrel.h b/net/mac80211/rc80211_minstrel.h
> index dbb43bcd3c45..86cd80b3ffde 100644
> --- a/net/mac80211/rc80211_minstrel.h
> +++ b/net/mac80211/rc80211_minstrel.h
> @@ -126,7 +126,6 @@ struct minstrel_sta_info {
>   	u8 max_prob_rate;
>   	unsigned int total_packets;
>   	unsigned int sample_packets;
> -	int sample_deferred;
>   
>   	unsigned int sample_row;
>   	unsigned int sample_column;
> 

