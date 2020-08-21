Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0624E235
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUUne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 16:43:34 -0400
Received: from mail.as201155.net ([185.84.6.188]:31463 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUnd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 16:43:33 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:34986 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k9Dsn-0000iD-1A; Fri, 21 Aug 2020 22:43:29 +0200
X-CTCH-RefID: str=0001.0A782F16.5F4031F1.0023,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=eLyrxKl+VSlNBqgNEVFw1bd5dkz4obs9aWffO9htvAc=;
        b=EzfVuh13G8CudmNKu/NxX3NvCtNaQnGqhMLyb7XQPF33tezZ2aRgbFdE0QSCvWd7cu4s3HfLQoHZnwaSJwND44lWw/63xfNQeaEFmDeWcvV9a4raaziN5KAHz2/QsiXytZTq7eBCOB/QeEz5M2kPdaGzA/CiGnhiLhw7hWIzYk8=;
Subject: Re: [PATCH 5.9 v2 2/3] mac80211: factor out code to look up the
 average packet length duration for a rate
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20200821163045.62140-1-nbd@nbd.name>
 <20200821163045.62140-2-nbd@nbd.name>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <add72d7d-40fc-dd42-64db-c016280453dd@dd-wrt.com>
Date:   Fri, 21 Aug 2020 22:43:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200821163045.62140-2-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2003:c9:3f1f:f100:710f:8705:e461:dfcb]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k9Dsn-000RO1-25; Fri, 21 Aug 2020 22:43:29 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 21.08.2020 um 18:30 schrieb Felix Fietkau:
> This will be used to enhance AQL estimated aggregation length
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v2: add missing return code check
>   net/mac80211/airtime.c | 121 +++++++++++++++++++++++++----------------
>   1 file changed, 74 insertions(+), 47 deletions(-)
>
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index 656c9a033714..ba95f4ee1f71 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c
> @@ -405,18 +405,14 @@ ieee80211_calc_legacy_rate_duration(u16 bitrate, bool short_pre,
>   	return duration;
>   }
>   
> -u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
> -			      struct ieee80211_rx_status *status,
> -			      int len)
> +static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
> +				       struct ieee80211_rx_status *status,
> +				       u32 *overhead)
>   {
> -	struct ieee80211_supported_band *sband;
> -	const struct ieee80211_rate *rate;
>   	bool sgi = status->enc_flags & RX_ENC_FLAG_SHORT_GI;
> -	bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
>   	int bw, streams;
>   	int group, idx;
>   	u32 duration;
> -	bool cck;
>   
>   	switch (status->bw) {
>   	case RATE_INFO_BW_20:
> @@ -437,20 +433,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>   	}
>   
>   	switch (status->encoding) {
> -	case RX_ENC_LEGACY:
> -		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
> -			return 0;
> -
> -		sband = hw->wiphy->bands[status->band];
> -		if (!sband || status->rate_idx >= sband->n_bitrates)
> -			return 0;
> -
> -		rate = &sband->bitrates[status->rate_idx];
> -		cck = rate->flags & IEEE80211_RATE_MANDATORY_B;
> -
> -		return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
> -							   cck, len);
> -
>   	case RX_ENC_VHT:
>   		streams = status->nss;
>   		idx = status->rate_idx;
> @@ -477,13 +459,47 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>   
>   	duration = airtime_mcs_groups[group].duration[idx];
>   	duration <<= airtime_mcs_groups[group].shift;
> +	*overhead = 36 + (streams << 2);
> +
> +	return duration;
> +}
> +
> +
> +u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
> +			      struct ieee80211_rx_status *status,
> +			      int len)
> +{
> +	struct ieee80211_supported_band *sband;
> +	u32 duration, overhead = 0;
> +
> +	if (status->encoding == RX_ENC_LEGACY) {
> +		const struct ieee80211_rate *rate;
> +		bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
> +		bool cck;
> +
> +		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
> +			return 0;
> +
> +		sband = hw->wiphy->bands[status->band];
> +		if (!sband || status->rate_idx >= sband->n_bitrates)
> +			return 0;
> +
> +		rate = &sband->bitrates[status->rate_idx];
> +		cck = rate->flags & IEEE80211_RATE_MANDATORY_B;
> +
> +		return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
> +							   cck, len);
> +	}
> +
> +	duration = ieee80211_get_rate_duration(hw, status, &overhead);
> +	if (!duration)
> +		return 0;
> +
>   	duration *= len;
>   	duration /= AVG_PKT_SIZE;
>   	duration /= 1024;
>   
> -	duration += 36 + (streams << 2);
> -
> -	return duration;
> +	return duration + overhead;
>   }
>   EXPORT_SYMBOL_GPL(ieee80211_calc_rx_airtime);
>   
> @@ -530,46 +546,57 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
>   	return false;
>   }
>   
> -static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
> -					  struct ieee80211_tx_rate *rate,
> -					  struct rate_info *ri,
> -					  u8 band, int len)
> +static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
> +				    struct ieee80211_hw *hw,
> +				    struct ieee80211_tx_rate *rate,
> +				    struct rate_info *ri, u8 band, int len)
>   {
> -	struct ieee80211_rx_status stat = {
> -		.band = band,
> -	};
> +	memset(stat, 0, sizeof(*stat));
> +	stat->band = band;
>   
> -	if (ieee80211_fill_rate_info(hw, &stat, band, ri))
> -		goto out;
> +	if (ieee80211_fill_rate_info(hw, stat, band, ri))
> +		return 0;
>   
>   	if (rate->idx < 0 || !rate->count)
> -		return 0;
> +		return -1;
>   
>   	if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
> -		stat.bw = RATE_INFO_BW_80;
> +		stat->bw = RATE_INFO_BW_80;
>   	else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
> -		stat.bw = RATE_INFO_BW_40;
> +		stat->bw = RATE_INFO_BW_40;
>   	else
> -		stat.bw = RATE_INFO_BW_20;
> +		stat->bw = RATE_INFO_BW_20;

hint:

--- airtime.c
+++ airtime.c
@@ -560,7 +560,9 @@
         if (rate->idx < 0 || !rate->count)
                 return -1;

-       if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+       if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+               stat->bw = RATE_INFO_BW_160;
+       else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
                 stat->bw = RATE_INFO_BW_80;
         else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
                 stat->bw = RATE_INFO_BW_40;

>   
> -	stat.enc_flags = 0;
> +	stat->enc_flags = 0;
>   	if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
> -		stat.enc_flags |= RX_ENC_FLAG_SHORTPRE;
> +		stat->enc_flags |= RX_ENC_FLAG_SHORTPRE;
>   	if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
> -		stat.enc_flags |= RX_ENC_FLAG_SHORT_GI;
> +		stat->enc_flags |= RX_ENC_FLAG_SHORT_GI;
>   
> -	stat.rate_idx = rate->idx;
> +	stat->rate_idx = rate->idx;
>   	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
> -		stat.encoding = RX_ENC_VHT;
> -		stat.rate_idx = ieee80211_rate_get_vht_mcs(rate);
> -		stat.nss = ieee80211_rate_get_vht_nss(rate);
> +		stat->encoding = RX_ENC_VHT;
> +		stat->rate_idx = ieee80211_rate_get_vht_mcs(rate);
> +		stat->nss = ieee80211_rate_get_vht_nss(rate);
>   	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
> -		stat.encoding = RX_ENC_HT;
> +		stat->encoding = RX_ENC_HT;
>   	} else {
> -		stat.encoding = RX_ENC_LEGACY;
> +		stat->encoding = RX_ENC_LEGACY;
>   	}
>   
> -out:
> +	return 0;
> +}
> +
> +static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
> +					  struct ieee80211_tx_rate *rate,
> +					  struct rate_info *ri,
> +					  u8 band, int len)
> +{
> +	struct ieee80211_rx_status stat;
> +
> +	if (ieee80211_fill_rx_status(&stat, hw, rate, ri, band, len))
> +		return 0;
> +
>   	return ieee80211_calc_rx_airtime(hw, &stat, len);
>   }
>   
