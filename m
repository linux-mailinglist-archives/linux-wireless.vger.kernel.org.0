Return-Path: <linux-wireless+bounces-20404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F278A62F32
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F571188D34B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18732036E8;
	Sat, 15 Mar 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="etUPQ6q1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8019049B;
	Sat, 15 Mar 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742052579; cv=none; b=C6xZ0v8khAj1Ch8Ha8muqT0TUdkLBGGF3MA/wMYSgaOZiQgeYLTzIi16kNAhJoo3nWPjmAQW1rVahpZAmLuy9QYEG2MOseAAV6Qh4zLAS5SrfVxrioSNxubtYs5EjE14mnrD5OA8Lri9fyIh/u7ViMs16wuz1od1mPCB+vpewhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742052579; c=relaxed/simple;
	bh=t3Ud3bOuPundm90xIOsFE9Q5XrJOj0wTImWIRDm5/BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmMixTep6SoWyc4kSOSdv9+rMgga3qKrEA6ycp5JDrlS4FQFjCUFU5RE4jsvofi1MIUss8o8xl1KUz+Ptp61XI1kn+LWKLGd3A5ADfs2dWFsypxUFa+QqU44Cp2vxvEWjOLzczxKLFIyODwZi2rrJYbMKH0pymO7PKOJ6Ord6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=etUPQ6q1; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id tTJNtsJ0HtsZCtTJRtOle1; Sat, 15 Mar 2025 16:20:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742052035;
	bh=b3ARRYc1xIjRJmTM2Xw3fYywDOajj6cXs8QeBu+g8Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=etUPQ6q1HR8RFWvQI5hugo8wAhN5EBw82VRkpgLbJ9Iu+MQgVouU6jc7g+P0L4pIA
	 x4owaUciYxrf5ZzY9lfaqmSUXCGSPrt3JizEWlaTOp0nBwFJqeJtyTnRSL15BbE9St
	 lMsxqODATfmFdl+fSyoUx1j3t420Z2UeOC/aZb5LAvF+ZYHD4ID/vLL6yIfG+250Cw
	 7YYS+Shc/PnOHJOuKt2p2uyGWr1626LOJ4KIJnI07haWF6fA4WQv8mNih0CzOtwZlU
	 pav3DOm/pDD7NvO4cEZsQhk+ssWNPO8UdnJ8jt8eOcqKNL50+gHwnjYRVXrqt0g04C
	 8XEJGg/SldFqg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 15 Mar 2025 16:20:35 +0100
X-ME-IP: 90.11.132.44
Message-ID: <d1c6d869-d4ed-41d1-97e2-c73f87864bda@wanadoo.fr>
Date: Sat, 15 Mar 2025 16:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: check basic rates validity in
 sta_link_apply_parameters
To: m.lobanov@rosa.ru
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 shaul.triebitz@intel.com
References: <20250315130119.75937-1-m.lobanov@rosa.ru>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250315130119.75937-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/03/2025 à 14:01, Mikhail Lobanov a écrit :
> When userspace sets supported rates for a new station via
> NL80211_CMD_NEW_STATION, it might send a list that's empty
> or contains only invalid values. Currently, we process these
> values in sta_link_apply_parameters() without checking the result of
> ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.
> 
> A similar issue was addressed for NL80211_CMD_SET_BSS in commit
> ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
> This patch applies the same approach in sta_link_apply_parameters()
> for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
> rate by inspecting the result of ieee80211_parse_bitrates().
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
> Signed-off-by: Mikhail Lobanov <m.lobanov-kcSV9N6+iMo@public.gmane.org>
> ---
> v2: Fixed the patch subject to provide a complete description.
> 
>   net/mac80211/cfg.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 9351c64608a9..e7c429aef980 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1909,10 +1909,11 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
>   
>   	if (params->supported_rates &&
>   	    params->supported_rates_len) {
> -		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
> +		(!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,

'if" missing?

>   					 sband, params->supported_rates,
>   					 params->supported_rates_len,
> -					 &link_sta->pub->supp_rates[sband->band]);
> +					 &link_sta->pub->supp_rates[sband->band]))
> +		return -EINVAL;
>   	}
>   
>   	if (params->ht_capa)


