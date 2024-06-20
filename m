Return-Path: <linux-wireless+bounces-9317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E70B910E3D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 19:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F21B259CE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460331B3F1B;
	Thu, 20 Jun 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EYy8taYz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372D1AB8F0;
	Thu, 20 Jun 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903742; cv=none; b=WqRylWPoej/J+bRvqabTlW3zPIyJL1w53cqpNHo+eze0vsYzUESw4bh4MiXixCI957HtWDfiVfFWabr53AIUKep7IZA20wViwycv2gwoEheELjH36hnhQfAdF42nnBLPsgtJ4ilKy7aatf9UfSImFbn4WeGAumpPCwWWosD4rBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903742; c=relaxed/simple;
	bh=MibYtPaStOyNmJ/MnE3IBHd0ESHqLBiFr2K5NuHSgVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3YdO2xDUpmtU6QXV5qs11BLYeBhIX9QcmyVVo1089/HTeM8mYeVNnQOuVXvjHhRwsbEo2FmZmyifOxrKAQvor0pXX3SJwdYtabVj3np7OpJbzIPFZqGyX44iCR22rkP8orRegu0AtXgxzrIsOZt9rNyYbUAcQ/TyHthf7s8E7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EYy8taYz; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KLF0sqSvNx6E7KLF0sBJHQ; Thu, 20 Jun 2024 19:06:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718903195;
	bh=C7PXgcuFIHuLhO89QKhX4IoMZb6JJQMXMgrBnFVa6K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EYy8taYzxscAZ/nfXzuE05IHjV1wE94kbgEBcZDGz5+FWe/YDPfhdc49k10obex64
	 X8VT60CZnkmXGOoRd9m5BB+/Hjb7GuUAgqwM9Ei9TXqB3nowye0SEmAGOjfJaxe8QM
	 3C5cxaIZ0d+dw6XS769GdxpIuajWQd0YRjLjfYsgbcGcsPz9iVfHSRZmSFAx7e/LN/
	 J/ccclUPyqWqaJpQ9dbIJfnuwIFB3uIzeZfncLwk9lEijU59qhRCK+9nBKPVLZasC7
	 oYddT+lM/YtEoXHdi1ZH10lfgZI944NwdNM32CRWMJL0+Cl30nNmROaxE7LBCgUT68
	 nuX6Q0ClPxyGw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jun 2024 19:06:35 +0200
X-ME-IP: 86.243.222.230
Message-ID: <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
Date: Thu, 20 Jun 2024 19:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
To: Kees Cook <kees@kernel.org>
Cc: benjamin.berg@intel.com, dmantipov@yandex.ru, gregory.greenman@intel.com,
 gustavoars@kernel.org, haim.dreyfuss@intel.com, johannes.berg@intel.com,
 kvalo@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
 shaul.triebitz@intel.com, yedidya.ben.shimol@intel.com
References: <20240619211233.work.355-kees@kernel.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240619211233.work.355-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/06/2024 à 23:12, Kees Cook a écrit :
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
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Signed-off-by: Kees Cook <kees-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Cc: Miri Korenblit <miriam.rachel.korenblit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Kalle Valo <kvalo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Gustavo A. R. Silva <gustavoars-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Gregory Greenman <gregory.greenman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Yedidya Benshimol <yedidya.ben.shimol-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Haim Dreyfuss <haim.dreyfuss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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


Hi,

I'm sorry but I don't understand the patch.

You state that "The counter member needs to be updated _before_ 
accessing the array index.". I agree with it.

But this patch seems to steel update it *after*.

My understanding is that 'match', is allocated by :
	match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);

So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.

So the __counted_by() mechanism should complain when doing
	match->channels[n_channels++] = mvm->nd_channels[i]->center_freq;
whatever n_channels value is.


I would expect the solution to be related to pre-increment instead of 
post-increment. Something like:
 > -				match->channels[match->n_channels++] =
 > +				match->channels[++match->n_channels] =
 >   					mvm->nd_channels[i]->center_freq;


Did I miss something obvious or I don't understand how __counted_by() works?

CJ


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


