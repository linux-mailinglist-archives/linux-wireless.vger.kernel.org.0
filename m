Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624A824D7A5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHUOrG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 10:47:06 -0400
Received: from mail.as201155.net ([185.84.6.188]:28581 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgHUOrC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 10:47:02 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:59114 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k98Jl-0007b3-1L; Fri, 21 Aug 2020 16:46:57 +0200
X-CTCH-RefID: str=0001.0A782F28.5F3FDE61.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1wQye5C2A6TTBS6ChvTf7jyFah0oalMD91UGuI9htBU=;
        b=E6jnlSV+eEKgIwHfWa92bRECPW2NWkjuaQm0cTnQiPrO2OK5wLj5WS3MQ0lQ4yCKgwxXQViilYjltiO+vLt6aGKkaP+mrTx/V4Ah4mOEhOXOdetxOV29KMEnZ6XhU2m6aJ4soB18uIR58rpz0Tfh7sfJG3ow0SgWagYgnYV9UYM=;
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation for
 low data rates
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com>
Date:   Fri, 21 Aug 2020 16:46:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813155212.97884-3-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:300:7990:37c7:3117:b833]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k98Jl-000Jyo-36; Fri, 21 Aug 2020 16:46:57 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

in my tests the patch series decreases the performance of ath10k 
chipsets by 50%, even if feature is not enabled.
so sorry. no ack from me.
so far i was able to reproduce it on linksys ea8500 and asrock-G10 both 
with qca99xx chipset

Am 13.08.2020 um 17:52 schrieb Felix Fietkau:
> Links with low data rates use much smaller aggregates and are much more
> sensitive to latency added by bufferbloat.
> Tune the assumed aggregation length based on the tx rate duration.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/airtime.c | 37 +++++++++++++++++++++++++------------
>   1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index 2d959b22b141..6a46771f9d54 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c
> @@ -646,27 +646,40 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
>   	if (pubsta) {
>   		struct sta_info *sta = container_of(pubsta, struct sta_info,
>   						    sta);
> +		struct ieee80211_rx_status stat;
>   		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
>   		struct rate_info *ri = &sta->tx_stats.last_rate_info;
> -		u32 airtime;
> +		u32 duration, overhead;
> +		u8 agg_shift;
>   
> -		if (!(rate->flags & (IEEE80211_TX_RC_VHT_MCS |
> -				     IEEE80211_TX_RC_MCS)))
> -			ampdu = false;
> +		ieee80211_fill_rx_status(&stat, hw, rate, ri, band, len);
>   
> +		if (stat.encoding == RX_ENC_LEGACY || !ampdu)
> +			return ieee80211_calc_rx_airtime(hw, &stat, len);
> +
> +		duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
>   		/*
>   		 * Assume that HT/VHT transmission on any AC except VO will
>   		 * use aggregation. Since we don't have reliable reporting
> -		 * of aggregation length, assume an average of 16.
> +		 * of aggregation length, assume an average size based on the
> +		 * tx rate.
>   		 * This will not be very accurate, but much better than simply
> -		 * assuming un-aggregated tx.
> +		 * assuming un-aggregated tx in all cases.
>   		 */
> -		airtime = ieee80211_calc_tx_airtime_rate(hw, rate, ri, band,
> -							 ampdu ? len * 16 : len);
> -		if (ampdu)
> -			airtime /= 16;
> -
> -		return airtime;
> +		if (duration > 400) /* <= VHT20 MCS2 1S */
> +			agg_shift = 1;
> +		else if (duration > 250) /* <= VHT20 MCS3 1S or MCS1 2S */
> +			agg_shift = 2;
> +		else if (duration > 150) /* <= VHT20 MCS5 1S or MCS3 2S */
> +			agg_shift = 3;
> +		else
> +			agg_shift = 4;
> +
> +		duration *= len;
> +		duration /= AVG_PKT_SIZE;
> +		duration /= 1024;
> +
> +		return duration + (overhead >> agg_shift);
>   	}
>   
>   	if (!conf)
