Return-Path: <linux-wireless+bounces-9257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712E90F870
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 23:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8ED2844EA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564C7E57F;
	Wed, 19 Jun 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yoFLnhGZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703F15A49F
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832143; cv=none; b=jev6Ct+tArp2f8M6lpkdt1PXKmIGgEicL+Sbqrfa5vG99OP0e3QvIkoMMQgUUca52QZTeaqjiYcf8/MAZUh5x6vjv/yuW5Lu55M3JoLEw1n2EulfJxj1k5m9fsGAz71jePNJd2NKa4WFWugpaVmqgTEbfmpwwaSen+SNDft7AMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832143; c=relaxed/simple;
	bh=zzYVYQFfqXEOVkA+vD94aEUcOi1Fnmwc5iU9M72Z8ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h71VAI+tVwZ+/TGpIAEfwrSoHjCDs6iR3WGPsuHZfZhIvyrk11EEiPbWUWulAOcLF17l5dFwJ3lpwLQFlY1SweTgtVEIDmQBf0lFWGXMLOM6pCCV1xrLY4Xft8mism0FexUWthhocDgtGKT/2Bdu05ye8mMbAQNSO30wHqtmfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yoFLnhGZ; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id K0CHsSacfxs4FK2kvsRQpk; Wed, 19 Jun 2024 21:22:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id K2kusIbic69m4K2kvsyqpc; Wed, 19 Jun 2024 21:22:13 +0000
X-Authority-Analysis: v=2.4 cv=QONuRBLL c=1 sm=1 tr=0 ts=66734c05
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=JSiYjvY3ZUJVig6Ww4oA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eRQryqgx8VcSeVue6U01oDxjp865CzUjBYKaWQEEpV8=; b=yoFLnhGZqK9XzoBGcUoxz8P0mO
	Yb019bvjaqlgebFuBRnZECaPKMNIuvW7TNKkYzCptKoy4TUkrLRqipa+kPoK6Yqo2hWzJ2RJtfrbC
	0YkGaYhbHnKzFXsaBAuvH6wMB3aqoGc0azCudiewbjhWRfYFD/r0/TFnqDoFvCFIn9ZwPfwJ5E8cV
	HvCzwnELZQxpJcayzi/Z8KPSE94P9pYK2HJWU83VlQ36DGquYBhBpOMvApKcJr/ZXVZcEABL1fUXX
	b5dhU7pxzWQn6In2i3eU9Rvtuj07ZZEAuW/DXdZ9gyc0HF/eVJk8PbmysEccwHGXQYGFd0r4ZBawl
	ps7H1s9g==;
Received: from [201.172.173.139] (port=49804 helo=[192.168.99.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sK2kt-002K9z-2l;
	Wed, 19 Jun 2024 16:22:11 -0500
Message-ID: <202aeef9-ba5b-400b-8341-bc07fb394a19@embeddedor.com>
Date: Wed, 19 Jun 2024 15:22:09 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
To: Kees Cook <kees@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Luca Coelho <luciano.coelho@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
 Haim Dreyfuss <haim.dreyfuss@intel.com>, linux-wireless@vger.kernel.org,
 Shaul Triebitz <shaul.triebitz@intel.com>,
 Benjamin Berg <benjamin.berg@intel.com>, Dmitry Antipov
 <dmantipov@yandex.ru>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240619211233.work.355-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240619211233.work.355-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sK2kt-002K9z-2l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.99.44]) [201.172.173.139]:49804
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMCNyZhS8i/q9hbkYFUcRikgW4AXpyz8eig0CTZzeXo++Hecu8Kflkogv5O4DUiHAcrNnYxgUFsQkVlTjgUozMMeM6cz+Det0hO8eHiEc07SnpGOg3en
 x0v2HQiWR/0WJtWu5j95HSVyp6mydCLxuEor84s4g0a/uMHQx3oGaXkdPrpoYE508NNR6wVrCJrBbT3k/JE+pHVOUJsd8NtWkXmB3OGujshR5sQ1BsrSJXQw



On 19/06/24 23:12, Kees Cook wrote:
> Both struct cfg80211_wowlan_nd_match and struct cfg80211_wowlan_nd_info
> pre-allocate space for channels and matches, but then may end up using
> fewer that the full allocation. Shrink the associated counter
> (n_channels and n_matches) after counting the results. This avoids
> compile-time (and run-time) warnings from __counted_by. (The counter
> member needs to be updated _before_ accessing the array index.)
> 
> Seen with coming GCC 15:
> 
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_query_set_freqs':
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2877:66: warning: operation on 'match->n_channels' may be undefined [-Wsequence-point]
>   2877 |                                 match->channels[match->n_channels++] =
>        |                                                 ~~~~~~~~~~~~~~~~~^~
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2885:66: warning: operation on 'match->n_channels' may be undefined [-Wsequence-point]
>   2885 |                                 match->channels[match->n_channels++] =
>        |                                                 ~~~~~~~~~~~~~~~~~^~
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_query_netdetect_reasons':
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2982:58: warning: operation on 'net_detect->n_matches' may be undefined [-Wsequence-point]
>   2982 |                 net_detect->matches[net_detect->n_matches++] = match;
>        |                                     ~~~~~~~~~~~~~~~~~~~~~^~
> 

Nice catch! :)

> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
> Cc: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Cc: linux-wireless@vger.kernel.org
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 54f4acbbd05b..9cd03ea4680d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -2866,6 +2866,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
>   				    int idx)
>   {
>   	int i;
> +	int n_channels = 0;
>   
>   	if (fw_has_api(&mvm->fw->ucode_capa,
>   		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
> @@ -2874,7 +2875,7 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
>   
>   		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN * 8; i++)
>   			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
> -				match->channels[match->n_channels++] =
> +				match->channels[n_channels++] =
>   					mvm->nd_channels[i]->center_freq;
>   	} else {
>   		struct iwl_scan_offload_profile_match_v1 *matches =
> @@ -2882,9 +2883,11 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
>   
>   		for (i = 0; i < SCAN_OFFLOAD_MATCHING_CHANNELS_LEN_V1 * 8; i++)
>   			if (matches[idx].matching_channels[i / 8] & (BIT(i % 8)))
> -				match->channels[match->n_channels++] =
> +				match->channels[n_channels++] =
>   					mvm->nd_channels[i]->center_freq;
>   	}
> +	/* We may have ended up with fewer channels than we allocated. */
> +	match->n_channels = n_channels;
>   }
>   
>   /**
> @@ -2965,6 +2968,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>   			     GFP_KERNEL);
>   	if (!net_detect || !n_matches)
>   		goto out_report_nd;
> +	net_detect->n_matches = n_matches;
> +	n_matches = 0;
>   
>   	for_each_set_bit(i, &matched_profiles, mvm->n_nd_match_sets) {
>   		struct cfg80211_wowlan_nd_match *match;
> @@ -2978,8 +2983,9 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>   				GFP_KERNEL);
>   		if (!match)
>   			goto out_report_nd;
> +		match->n_channels = n_channels;
>   
> -		net_detect->matches[net_detect->n_matches++] = match;
> +		net_detect->matches[n_matches++] = match;
>   
>   		/* We inverted the order of the SSIDs in the scan
>   		 * request, so invert the index here.
> @@ -2994,6 +3000,8 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
>   
>   		iwl_mvm_query_set_freqs(mvm, d3_data->nd_results, match, i);
>   	}
> +	/* We may have fewer matches than we allocated. */
> +	net_detect->n_matches = n_matches;
>   
>   out_report_nd:
>   	wakeup.net_detect = net_detect;

