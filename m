Return-Path: <linux-wireless+bounces-10619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A593F708
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C241F22516
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B614A0B7;
	Mon, 29 Jul 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsKoto9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B8146D54;
	Mon, 29 Jul 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261100; cv=none; b=clst8a6eWIJsC4veGOR81q51iZnTPm6psld4hswrEBbuOIAQnPOOXdbH+lJW796FoTPMsnbs/DzJYc+VVKEQbRjkkqegkXHtm71x4jjjs8fJsev1HzIQW2+4LMoi7hNHu6C4Z63U1VUQrKLm80c+kfPSFecWSp43ctUFrzaaBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261100; c=relaxed/simple;
	bh=dGgxHdxK9Nz8ttP6xXbqgVN4uZntUdYOZV5Esl1EkGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWBmeZE3dT7hdq1bpL2jAkiPJZGc+7Ro7XDpoV14apnWmx0AsOdzfIzpIR+gfvqPMMpAn0ChBJTCtRs5+xx3dkKe2B0sG7AYm02si0ArAlYSGhM/devzcyXRxr5Wz774aeY0EaTdJmgnEW+NHrLlLwDemhid56iOLdevWXcZ3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsKoto9t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so10403905e9.0;
        Mon, 29 Jul 2024 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722261097; x=1722865897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CO8WnhTC1H7YGD6SVa9aO98KuKo2+EKb84xRYCvBOI=;
        b=YsKoto9tD9dxb+lVVjCczccLrcDL3aS7knrzcegbzJpKkDGN2+vx48ayRQnEfugV8E
         KYJzX/cBT6iI8gJ0285DOilg+U+/TyuEsrhPUj3po5kY0e0rpNGNalFvLRZqAWRR5b6G
         ZdkplMMzu0BqfcTlFhaCsMeWPVTFPLcJaqlslQHJdESS5yGVQNdcsABVSlvINmU1xj78
         ur5BoycACIC+8VdlHuJdMENaCQUaoLok0Q9gmkf5GSMSJNwHaeQECwwoBmqmWBBECqji
         Sk3zkOh/NAIGBS5f0/P0TxBRLAGilD5wAK87KyvSstWFwlT32YANh0Arhi9tCtcCtgiT
         x8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261097; x=1722865897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CO8WnhTC1H7YGD6SVa9aO98KuKo2+EKb84xRYCvBOI=;
        b=Kx1gWIc0AajA4jHLvYLGWIP242NeaBbwDS73+VBs2jj+pMG2Vky1UPzAHrvjkRAPRI
         RgOwQrSnIbPAnmY1TT+ASuX83wC6d8R9wy2KGfp5qOta5wN00WjMYTuZNoCAS4cZNvun
         sKTe6SG1uAmYgHULiSdYK2mvu4V4KmLU8INDmFW5og/Uw7XzrkRUDtKyXPko4iu68zro
         lboZena8hlrUdkA5uev4cdSdodVl2S22WGH1QTn6sa9q54ZT8an+0phWSAuXYT3lBZsg
         lgG+SRE3tuUu1DNQYEgvfQa4V1bKck0ibR7z/5fEhZqbPxAqpBg65y1OCXW39KGHob0O
         UYVA==
X-Forwarded-Encrypted: i=1; AJvYcCWg0s92WR8zVNREwBn99IpC36eAp6oe/aheYAcpiqSnRdwteq5C1RqOBdZR8MsXDKJ00yB32WIJm7okiXA69thSlKvpSJuzFQcjjzmJgyjOw+B0quQGS7Jhx+SvLQBL
X-Gm-Message-State: AOJu0YyDYEExV0PqH3hnPURZkT7gDD8sDbtBHzsiGm5gHAnA2ghGGOR7
	YRilOe7NzQ+rKy7q23F9NUmgKK58kI7li8cmVBz+pp0EoGrS+czI
X-Google-Smtp-Source: AGHT+IGARp64ICzA9Z1l8URj5gd4y0wI+dWEaat1soYHb86f054IGloD632JjaWFp/QBUafZCtRPTQ==
X-Received: by 2002:a05:600c:3585:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-42811fde0bbmr47663175e9.16.1722261097007;
        Mon, 29 Jul 2024 06:51:37 -0700 (PDT)
Received: from [192.168.1.17] (net-2-44-141-41.cust.vodafonedsl.it. [2.44.141.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281ef5a416sm22616965e9.33.2024.07.29.06.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 06:51:36 -0700 (PDT)
Message-ID: <32760fe6-160d-410a-b85d-6f26687f405a@gmail.com>
Date: Mon, 29 Jul 2024 15:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: check basic rates validity
To: johannes@sipsolutions.net, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
 stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
References: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>
Content-Language: en-US
From: vincenzo mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <20240729134318.291424-1-vincenzo.mezzela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 15:43, Vincenzo Mezzela wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.
>
> When userspace sets basic rates, it might send us some rates
> list that's empty or consists of invalid values only. We're
> currently ignoring invalid values and then may end up with a
> rates bitmap that's empty, which later results in a warning.
>
> Reject the call if there were no valid rates.
>
> [ Conflict resolution involved adjusting the patch to accommodate
> changes in the function signature of ieee80211_parse_bitrates and
> ieee80211_check_rate_mask ]
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reported-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
> Tested-by: syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
> Hi,
> please note that a backport of the same patch for v5.15 is available at
> [1].
>
> Thanks,
> Vincenzo
>
> - [1] https://lore.kernel.org/all/20240727125033.1774143-1-vincenzo.mezzela@gmail.com/
>   net/mac80211/cfg.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 2c60fc165801..d121a3b460f4 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -2577,6 +2577,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
>   	if (!sband)
>   		return -EINVAL;
>   
> +	if (params->basic_rates) {
> +		if (!ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
> +					      wiphy->bands[sband->band],
> +					      params->basic_rates,
> +					      params->basic_rates_len,
> +					      &sdata->vif.bss_conf.basic_rates))
> +			return -EINVAL;
> +		changed |= BSS_CHANGED_BASIC_RATES;
> +		ieee80211_check_rate_mask(&sdata->deflink);
> +	}
> +
>   	if (params->use_cts_prot >= 0) {
>   		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
>   		changed |= BSS_CHANGED_ERP_CTS_PROT;
> @@ -2600,16 +2611,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
>   		changed |= BSS_CHANGED_ERP_SLOT;
>   	}
>   
> -	if (params->basic_rates) {
> -		ieee80211_parse_bitrates(sdata->vif.bss_conf.chandef.width,
> -					 wiphy->bands[sband->band],
> -					 params->basic_rates,
> -					 params->basic_rates_len,
> -					 &sdata->vif.bss_conf.basic_rates);
> -		changed |= BSS_CHANGED_BASIC_RATES;
> -		ieee80211_check_rate_mask(&sdata->deflink);
> -	}
> -
>   	if (params->ap_isolate >= 0) {
>   		if (params->ap_isolate)
>   			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
Hi,
this is a backport for v6.1, I forgot to add the TAG in the subject of 
the email.
Should I resend a new patch with the correct version TAG?

Thanks,
Vincenzo

