Return-Path: <linux-wireless+bounces-31235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGsICjveeGnytgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:48:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F5970CF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3BE301014B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B82749FE;
	Tue, 27 Jan 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="i3ST9Cp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB6240611
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528632; cv=none; b=nfkFz1V4dfzi/T5ahmwvHTb6P/LiCNTvN6xqgCK+J3o5yjeNLh9VfHZK92ODh/ZkwLgHPVxwnogYvJjSL9PHoL/6V40Nl6LwiHoCKTMopX1s7/15aoqNiLMvWn0pubAGbMoOOeKUwYuVr+HLuzqv0f+q0i5YsHG/kp1xhI4i7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528632; c=relaxed/simple;
	bh=Pd6JojxAxOXxtPBl3it2gguI4Rf4c5BCJcIFHNZLS+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMjFo8jSwT9Uh4cseAEBbN5Y+lZL/Pc3fWZoXvNunRMIt1ztYaSzLhTQaYr3nqHZBYCP9miRkZnoP+islKOduKbcqYP+Be5/nqql6vQahd5HqppGa+jmpfyGuT8xyIcVTMcDrOvqdlsVzRyPshZtf+sU+g4QGYJATPCcNL/Mew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=i3ST9Cp8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so66176665e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769528629; x=1770133429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5ibw7LAsl4aZJeaOwxUHchf1Pjoej6ir99TcJIDmcM=;
        b=i3ST9Cp8b1QFlgwgrOJIA+rBwNvGAQuTu9eaTPBySH6pmrzBswxyZotMm09qEHOdGv
         Unm9ynaCwerilEBuLYks+5FE4e0jjFpemMG+utDhbdu5qgDpSwNGBstSbs83v6YOQJ0j
         GGISiAOyBQRN14wEP+jLhdwumRy9ltMKeT0RGF8PF5E8SM8sjN26HQG9IBJ9yIXwfCYd
         zmIVkjqG4bGyAulCs+4NzsIXJ33PmMuAFUNgGEVb92/0NfZyYDE18c1tL7Fkx/18Z77M
         GGTX4KX5YGy+deTLixKw7lhieT3vgr5PlJEH7RzvGzwOBSDBFPDMA70fYrK3RU5nstBS
         GsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528629; x=1770133429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5ibw7LAsl4aZJeaOwxUHchf1Pjoej6ir99TcJIDmcM=;
        b=AmnSv0wZbLpV544TVErKI5x6lGYQ/bKhYvsb+uPCFVMi1IetWot+a5bABzyVO+i/sA
         r5CGnka/apOBUdUJjP+m2+dJ25cbcrpWjxRz0mIDcaDFdFmO80gg1AvN8FT6MJLe2ZCE
         7db+MPEOSr7vmZu5eAHM6z5FTy36d3Rl1QwepSGeOaPfagzUHFHNqxL3wcXfH7YZ1x9K
         yhdV9iG3N0JnKjXK+UVZGnNfauyJVUJJGENhWMmbHkXe+wWaBN2+SF4tgtzr7cbpztVN
         8OO2HLMVdqLuPlbGynmqWwSbcmVrrsn4rSiOPswfGsVp7YVmdMq52lwO8JYRqU65lfH9
         EcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO43L33v74k4j4Vf5+D12nYBNkPzWEvVPv3DAGOBntdeNXapjhjrCH9jY2o1jQt62lqb+5VpY707Om6d1evg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPFiZtOQleCD34K/q19DjC23sQCpDBZwIAOBzSeYK/A9hBfL4
	2kkqWfuhiDFFElslhQGE6Ri4G9XMrMhrFMa4A0VMamO3ifhuT92vazv5fOiawo2Wdk9/bVXx3kK
	ghDqu
X-Gm-Gg: AZuq6aKuw22RGmJs6BdmE6VEsPvHfcEZz9ZdpUfZ6YnR+lqoqgcNOEs1Q/67QJsb5p9
	J+7fwG0xEmm4SiJC2LWu4lWUYZCusHI2V/tKxb8AqkIXoAycosy3fJegv4PBWFYpaw4mzrI6XPQ
	Cr1a/8qfK+7C2PTO0L4UaUtHax0B9vBVggrOTMeU15k6QytNQZi0/8ZXYLTYQA/PMNkPVKppU9d
	iesZ95OtqVGNu1qzH5oU0aNLtWCtfdJ/mfRbl0oCeF3cjbl67S8fPtuPk3bNVmL8mxwtzIBAP9I
	aWn58dxjkc0kRnMlg722uuyerZ5Bdmp/g88RxNfAPBVzPAbFeBNoMh3LXwN0y/ljDCS7/LChJP+
	7CkH2Ob2fXrST9EXI3KGa0vDNKYn54p3Vpde9LMEnSUGFRU6kO28s3v30S9EO0g4yZonhj4exiW
	x9HORIHZOtfGihEChwDQR8xx5f8SZmeGoME9y6b0svGQ==
X-Received: by 2002:a05:600c:4f82:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48069c16213mr29315445e9.2.1769528628897;
        Tue, 27 Jan 2026 07:43:48 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806bdf419fsm7584805e9.15.2026.01.27.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 07:43:48 -0800 (PST)
Message-ID: <745c6e68-5e2d-4d72-a9a6-74703c4af276@freebox.fr>
Date: Tue, 27 Jan 2026 16:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260127141005.583581-5-johannes@sipsolutions.net>
 <20260127151005.dea4882ccc8e.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260127151005.dea4882ccc8e.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31235-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:mid]
X-Rspamd-Queue-Id: 768F5970CF
X-Rspamd-Action: no action

Hello,

One comment below:

On 27/01/2026 15:09, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Add initial support for making UHR connections (or suppressing
> that), adding UHR capable stations on the AP side, encoding
> and decoding UHR MCSes (except rate calculation for the new
> MCSes 17, 19, 20 and 23) as well as regulatory support.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v3:
>   - remove UHR capa pointer from AP settings, it's not in
>     the beacon anyway
>   - fix kernel-doc (Jeff Johnson)
> ---
>   include/net/cfg80211.h       |  56 ++++++++++++++++++-
>   include/uapi/linux/nl80211.h |  30 +++++++++++
>   net/wireless/nl80211.c       | 102 +++++++++++++++++++++++++++++++++--
>   net/wireless/reg.c           |   2 +
>   net/wireless/util.c          |  96 +++++++++++++++++++++++++--------
>   5 files changed, 259 insertions(+), 27 deletions(-)
[...]
>   
> -static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
> +static u32 _cfg80211_calculate_bitrate_eht_uhr(struct rate_info *rate)
>   {
>   #define SCALE 6144
> -	static const u32 mcs_divisors[16] = {
> -		102399, /* 16.666666... */
> -		 51201, /*  8.333333... */
> -		 34134, /*  5.555555... */
> -		 25599, /*  4.166666... */
> -		 17067, /*  2.777777... */
> -		 12801, /*  2.083333... */
> -		 11377, /*  1.851725... */
> -		 10239, /*  1.666666... */
> -		  8532, /*  1.388888... */
> -		  7680, /*  1.250000... */
> -		  6828, /*  1.111111... */
> -		  6144, /*  1.000000... */
> -		  5690, /*  0.926106... */
> -		  5120, /*  0.833333... */
> -		409600, /* 66.666666... */
> -		204800, /* 33.333333... */
> +	static const u32 mcs_divisors[] = {
> +		[ 0] = 102399, /* 16.666666... */
> +		[ 1] =  51201, /*  8.333333... */
> +		[ 2] =  34134, /*  5.555555... */
> +		[ 3] =  25599, /*  4.166666... */
> +		[ 4] =  17067, /*  2.777777... */
> +		[ 5] =  12801, /*  2.083333... */
> +		[ 6] =  11377, /*  1.851725... */
> +		[ 7] =  10239, /*  1.666666... */
> +		[ 8] =   8532, /*  1.388888... */
> +		[ 9] =   7680, /*  1.250000... */
> +		[10] =   6828, /*  1.111111... */
> +		[11] =   6144, /*  1.000000... */
> +		[12] =   5690, /*  0.926106... */
> +		[13] =   5120, /*  0.833333... */
> +		[14] = 409600, /* 66.666666... */
> +		[15] = 204800, /* 33.333333... */
> +		[17] =  38400, /*  6.250180... */
> +		[19] =  19200, /*  3.125090... */
> +		[20] =  15360, /*  2.500000... */
> +		[23] =   9600, /*  1.562545... */
>   	};
>   	static const u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
>   	static const u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
> @@ -1602,8 +1606,6 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
>   	u64 tmp;
>   	u32 result;
>   
> -	if (WARN_ON_ONCE(rate->mcs > 15))
> -		return 0;
>   	if (WARN_ON_ONCE(rate->eht_gi > NL80211_RATE_INFO_EHT_GI_3_2))
>   		return 0;
>   	if (WARN_ON_ONCE(rate->eht_ru_alloc >
> @@ -1684,7 +1686,7 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
>   		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_26)
>   		result = rates_26[rate->eht_gi];
>   	else {
> -		WARN(1, "invalid EHT MCS: bw:%d, ru:%d\n",
> +		WARN(1, "invalid EHT or UHR MCS: bw:%d, ru:%d\n",
>   		     rate->bw, rate->eht_ru_alloc);
>   		return 0;
>   	}
> @@ -1698,11 +1700,61 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
>   	tmp *= rate->nss;
>   	do_div(tmp, 8);
>   
> +	/* and handle interference mitigation - 0.9x */
> +	if (rate->flags & RATE_INFO_FLAGS_UHR_IM) {
The function cfg80211_calculate_bitrate_eht has already a bunch of 
sanity check, shouldn't we add nss == 1 and MCS != 15 for IM?
> +		tmp *= 9000;
> +		do_div(tmp, 10000);
> +	}
> +
>   	result = tmp;
>   
>   	return result / 10000;
>   }
>   
>
>   

Best regards,

Pablo MG


