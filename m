Return-Path: <linux-wireless+bounces-33728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gICJEVR5wWkQTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:33:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6139E2FA014
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F04BA32E3A80
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B803B8920;
	Mon, 23 Mar 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="FSWbqW7m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1453B7B69
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281639; cv=none; b=QAhoB6NSD3tDfxMCCUGeiy2NOh2ZpBGSSPr7se07gQWFl3FCM9rbnIhnwS4sAhBaJO749IwIKl+01efrN8ert7tp2oQg5FUF9oOEbSFQ7LvMiRFdrnGanlNtfH9gD6mxterzhaJqxq0cCaYTdZJvjJSKEVDGjP8f8QyfMNMGQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281639; c=relaxed/simple;
	bh=a9svgDqpOKAKfWHC06rkAMvLWkHdLOz2j5VOVI05Auc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oX0mKqFd4zjZ1rfOKZsOoChz1DlKQQoO6dKZK2KGU3VPTYqO1myZfTm5eNFWAk7OBwVSa3NEDatXfw2aCu3HjNIjMtIN9fLWvA0/lt3Xu/4xllCfGvNWt2aCeaCf7CLE61qnGF7WS1KxWO2DiVMtkaIEk9GRhd7S4n2u+1KdD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=FSWbqW7m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439fe4985efso2676605f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774281635; x=1774886435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNydHhUU9QtGxRoTvYgPwsNtbRQ/EtAOPBAitB1plJ8=;
        b=FSWbqW7mjjRgcoYV1ZY3VmFK4C3PXU/lBdYjUJc7fqV7IyP49gqqa3Aihj7G8gMmQM
         xDOTrU8qFqujQW7xzyF9bsBv9VixQw52zLKta75Q/k+fQ295i2eWHqjGeC/vtqssAG9G
         DQgn6WM+6FmYSixylGqrWKaPwV3WABhXUcfNf1ZK46rlzA+eWh5NDY52fNpYncWWyR+k
         k3p0f54FQgzeAjTKH3fclJy+TH4ZyBq9BXIwS5DpHFYiqMaZJhn2VVl/k/4NoJudLLk6
         NA8fm6IpCGUGehWBX5p5xaM26RLhOuzs9zH+WF2Oin+RDUtHxLZ1JqfxdSCP5tMWI+qc
         JHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281635; x=1774886435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNydHhUU9QtGxRoTvYgPwsNtbRQ/EtAOPBAitB1plJ8=;
        b=PzsF2dXvs+I1KEPYwyMUlcForzHk3EfBVV+H3DYGDBLygo6AMJFGI4vTT2i1TPN10B
         21CZQ/eeSaGFtah5XTO5gKpf70FQxBMRpnBCb8k2QmyxPF2ul54qFFXdZ98gHNYQt4o8
         4Qzf73DHR1/j6zk3uIrvxtm3AWUew1lRwZCq7ioGcIjkOZpX2De8ESum+dkh/HcAs/eU
         B9Y+HZIROPSoYRlfMwBTvgiMjnnSAd/B4CNSh2f39cw7qeRFqN2t1gLZaZCrKWiE1wtr
         ENB4SFqgEssp9hrFNHQfnDdAf7LWfKW/2dwx0Yq81FHT+/Omd96DZh+M53uuug62aEBp
         xQZA==
X-Forwarded-Encrypted: i=1; AJvYcCVYY7BkJUJRUbzL+XqJ1IAaGP52jSW1jCwofrzl55n5aJUS80wPfRN1Gr+XkQhHu0vgbgRmf1ogrFggt3GjPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4MudaoNys16J/imc5z4r13AOSTYsNCiX0/Au0Vrs7WHR//pQ
	KVVoyv3lee49+RBduyy1rk7zY86hotNahI0ohU8agyqKlsz22lJ6k9YKuqg6/8LDXW66PqoZpKG
	EA+Kl
X-Gm-Gg: ATEYQzwDmFhjGdaBcd6hlp5F/gq9qptq3sOnPHZWHNc5kHKbEipMEhciODwUs1bXbvA
	8xpl1WfO6fR2TBYjsa+CUIo7nZDI+VRP+hwwzpenpfu7yrQlu5+6jRV4rGdFKUlNNvUMU+fAU6J
	NznxSjmQN0uQ78WmVZylbSv+aWl76KEM24gPFbAi4N1RIPSoNYA/jNg4O6IlMysy7ZcS2KSU1wF
	HO1P3+5kXQWjOVqlbWyCqsTe13P/ryKD9vJ+XsIKk9Z1Wbsz2jKRc3TH4ij2hMengfD2tVuFu2v
	54CLj0KiqR66wWBdJH3mN39HMc9qydYdEYA1nPCjQT1wrpzjq9yAeB6ztkRN5gtUv8sJT700KCr
	BsieQZ6ZVBBD/sqgqYXXQ4wALb+xDPaL2UR+SXGXqvksHmQAdI96ZyPYdayZ+nA6bqf1WwpCppo
	9jzX/jB21MeWEiCuLE53u++3m0zqBfFlDAh45DnL9Xa+j2aZifintANQ==
X-Received: by 2002:a05:6000:608:b0:43b:436d:781b with SMTP id ffacd0b85a97d-43b64270a9amr18644900f8f.40.1774281634723;
        Mon, 23 Mar 2026 09:00:34 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714e2esm32790000f8f.32.2026.03.23.09.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:00:34 -0700 (PDT)
Message-ID: <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
Date: Mon, 23 Mar 2026 17:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mac80211: factor out part of
 ieee80211_calc_expected_tx_airtime
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20260323101954.874299-1-nbd@nbd.name>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20260323101954.874299-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-33728-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 6139E2FA014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 23/03/2026 11:19, Felix Fietkau wrote:
> Create ieee80211_rate_expected_tx_airtime helper function, which returns
> the expected tx airtime for a given rate and packet length in units of
> 1024 usec, for more accuracy.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/mac80211/airtime.c     | 87 ++++++++++++++++++++++----------------
>  net/mac80211/ieee80211_i.h |  5 +++
>  2 files changed, 56 insertions(+), 36 deletions(-)
> 
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index c61df637232a..0c54cdbd753c 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c
> @@ -685,7 +685,7 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
>  	if (ieee80211_fill_rate_info(hw, stat, band, ri))
>  		return 0;
>  
> -	if (!ieee80211_rate_valid(rate))
> +	if (!rate || !ieee80211_rate_valid(rate))
>  		return -1;
>  
>  	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
> @@ -753,6 +753,53 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>  }
>  EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
>  
> +u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
> +				       struct ieee80211_tx_rate *tx_rate,
> +				       struct rate_info *ri,
> +				       enum nl80211_band band,
> +				       bool ampdu, int len)
> +{
> +	struct ieee80211_rx_status stat;
> +	u32 duration, overhead;
> +	u8 agg_shift;
> +
> +	if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
> +		return 0;
> +
> +	if (stat.encoding == RX_ENC_LEGACY || !ampdu)
> +		return ieee80211_calc_rx_airtime(hw, &stat, len) * 1024;
> +
> +	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
> +
> +	/*
> +	 * Assume that HT/VHT transmission on any AC except VO will
> +	 * use aggregation. Since we don't have reliable reporting
> +	 * of aggregation length, assume an average size based on the
> +	 * tx rate.
> +	 * This will not be very accurate, but much better than simply
> +	 * assuming un-aggregated tx in all cases.
> +	 */
> +	if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
> +		agg_shift = 1;
> +	else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
> +		agg_shift = 2;
> +	else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
> +		agg_shift = 3;
> +	else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
> +		agg_shift = 4;
> +	else if (stat.encoding != RX_ENC_HE ||
> +		 duration > 20 * 1024) /* <= HE40 MCS6 2S */
> +		agg_shift = 5;
> +	else
> +		agg_shift = 6;
> +
> +	duration *= len;
> +	duration /= AVG_PKT_SIZE;
> +	duration += (overhead * 1024 >> agg_shift);
I know this patch is just a refactoring, but I think this moved code is
bugged. If (and it's a big if) I understood correctly the chain of
macros and the comments, `ieee80211_get_rate_duration` return the
`duration` in 1024 µs of an average packet (which would imply
1f38b8c564b8 is wrong) and the (PHY) `overhead` in µs for a (average)
packet. So I believe the code should be:
```c
	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
	duration *= 1024;  /* now duration is in µs */
	/* the agg_shift calculation has to be fixed */
	duration += (overhead >> agg_shift);  /* for one packet, we "assign" a
fraction of the overhead */
	duration *= len/AVG_PKT_SIZE;  /* we multiply by the number of packets */
	duration /= 1024;  /* we go back to a duration in 1024 µs*/

	return duration;
```

If this is correct, then `ieee80211_calc_rx_airtime` is also bugged
likewise.
> +
> +	return duration;
> +}
> +
>  u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
>  				       struct ieee80211_vif *vif,
>  				       struct ieee80211_sta *pubsta,
Pablo MG

