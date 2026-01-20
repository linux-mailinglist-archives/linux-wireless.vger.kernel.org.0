Return-Path: <linux-wireless+bounces-31038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKkuLmLxb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:19:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3EF4C20D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D97CA24F32
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3C3A7F78;
	Tue, 20 Jan 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETNDAPF7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4C33F39C
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940721; cv=none; b=f04qLo86r/NiSaufGV9mVfzUC2J+xbIfHt027p1NJ6KijYXCQw5sqZIKxrjhjvwNCaZTrIRG55FyYhrBT/pcAVsWoyHLoYxkZtF+wXKWgkMPT/ssNhYhSYfOQpTPraNLiiqh1VJAeAfMBrnkFgaaTyXIQbUihE+7/re2iIFsniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940721; c=relaxed/simple;
	bh=T9nstNh5C/PMcxUcVmm/k+8q89ivN6duC8EN8FC+Dhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIuFwnhdxWgDK0PJDlFIl5fqkBPhckX5mfj6X6P1vOO+Ex8R3uOxKjxRw2GDBgTV4gpkFUxZUxTMjvvaBOVkBXeab6jW1p2tdurEIgBWS9ECpAKvgljeblK70awjdhJDeOJ+bBqQ9bFL0D04mFeFmPPEpn/Bw588HsS+XvLyenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETNDAPF7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65801ce918eso2088987a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768940717; x=1769545517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbvptpwtewhcN+InYiYZTWkrRmvBxAsjQT9HVhHSR5E=;
        b=ETNDAPF7h153ndeXoro1C0ZvcKSuXi6PHDX42uRhsgcIE2aLx1XJ2Eh5+QV9vsu3Rs
         Z6hXAardaV/lTUYmDlAm4/+yWulZ3wsnSsFGDvA7+QE5+x3vBASL16GsLOGa56orkmN5
         gl4w7C6/uqz1kFR91B+4hSe5/+ezdLsspHXlX/TtLGDzu0tJQUXuca0M9A7jm08eSoFz
         t4bqKggyowSkkY+M/gqSDcUhO4bac7N1dZa0vvED+QcjnHUUvUd+PnddDPd0llN1u+4J
         zggD5lWXteZMfiTEMcLDs0f0xwzcB142cNu4+rLrJ13ixWGCPpzmBAKFjZBormxkrsfs
         qQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768940717; x=1769545517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbvptpwtewhcN+InYiYZTWkrRmvBxAsjQT9HVhHSR5E=;
        b=oCQpdv6u3YnbPwGw/84yIWBT44R9rZkGtHuo5loNCh4TJTTuVkSAzaNsTzzhLBexR/
         ebuJtxT7ymMQ+sfGjL71uswTA0rn1sbIGJ3EsY8O8XOVU4Ae1iwCUeYFCld/Zjpk5EN6
         3k2G5I3G5gRpNIy2W6bcp3bheuSOKj24RQXb6o0QJggvyMGT6RGQyNi6l+Hu+96zYZW8
         L/juEySlqFzm0QVkiFXmj3+JKx3EVasG2vaaRiV044uqj5/Z0i+FfKv6OmRvhihIum6T
         2gqSNM+EuwunRKFs0/pYvyVm/+zIKSIQBJHnIgpm9QYJHhGny6g4MO65uSukVqxbQAoo
         36bw==
X-Forwarded-Encrypted: i=1; AJvYcCXgWCubjJfggl93s1rlon5AfnwvpQBrwcgSYud4WCMxsbLZqm3WmqqQhvVwmpkrZ05LlSkqWaTaY97kock4Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUicrmJAGnD77nUsgidl+Z2+kKMSsiQiSRqOgsTqyh2nSSyLGV
	IzSfz6hr/5dvc8qzzymbkrLfcJbzmP7uHCCtMLVmv+EGtjgqiqKOpl6T
X-Gm-Gg: AY/fxX6OpGELSYhw2oTAncB1RLl0oj+AtQi6eVnUYdptfAUnqx7eZFocp58GrQ2TWBf
	3UpXeesssr9P8JSrDcPfv2lp6Jt66IGseg8qGryixbZbPKIRd5shOAd4XckD6ivXbcY0l2F3yO+
	M9IUmFdatmpSkiIzcaDWcdT4qraSKRbclWgy1Z4bnriDOSIx0UGDEkZCOIA5bwgI4RLY0Y2R6+B
	r6xrHcoHOoKR2tV32/2Z7Aqql/l6fqsH/gMspe9cRztzW59jAzxTDxMk9TK83W8XtGKfagoueh1
	iAWmM47Bu87D3YCMOU4UdEE3S2Dsf02d/+STuAU9oDkq/LC6Tt/1h9SH2oAkUKAmnoBxs+C3wAo
	AXTIvKDDzg5JwNV6A/nxPX+EaJ7CBDsrGRJ7pkd9XX3FZe17kF9O3jgHcfD4C2KC+DvIz5ZcsNk
	2KpDZchQGeRFUrkMJh3ZvEZNcWfbWB3nebBBdye77xpdU/Tcyd6t8bMpdpS7JFCzegsR8jRluTC
	0QuYzkngg==
X-Received: by 2002:a17:907:3e04:b0:b83:a6b6:ed74 with SMTP id a640c23a62f3a-b8792d59928mr1205701166b.19.1768940717146;
        Tue, 20 Jan 2026 12:25:17 -0800 (PST)
Received: from shift (p200300d5ff09750050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff09:7500:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbd23sm1477805966b.51.2026.01.20.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:25:16 -0800 (PST)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1viIHr-00000000j5e-44cl;
	Tue, 20 Jan 2026 21:25:15 +0100
Message-ID: <71ec168e-423b-4269-88b9-56e08c1d8110@gmail.com>
Date: Tue, 20 Jan 2026 21:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: p54: Fix memory leak in p54_beacon_update()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: quic_rdevanat@quicinc.com, johannes.berg@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 johannes@sipsolutions.net, jianhao.xu@seu.edu.cn
References: <20260120130144.2662132-1-zilin@seu.edu.cn>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260120130144.2662132-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31038-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2E3EF4C20D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm sorry for not seeing this sooner. Yes, 24hrs are passed.

On 1/20/26 2:01 PM, Zilin Guan wrote:
> In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
> If p54_beacon_format_ie_tim() fails, the function returns immediately
> without freeing the allocated beacon skb, leading to a memory leak.
> 
> Since no other references to this memory exist, it must be freed locally
> before returning the error. Fix this by freeing the buffer using
> dev_kfree_skb_any() in the error path.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.

Ok, from what I remember, this return basically is/was and likely will be a dead-code path.
So adding something there is only there to "look" good for the static analysis tools.
But many commits like these have been merged before. As long as it is mentioned that
static analysis was the reason for this. Yeah sure why not.


Reason being why this is dead-code is that in order for the path to trigger, mac80211's
ieee80211_beacon_get must have prepared an invalid beacon (with an invalid TIM Element)
to start with... And looking at ieee80211_beacon_add_tim_pvb, it still looks to me like
the IE length can't be less than 3 ever. But, I've been wrong before, if you do see please
correct me. (If not, you don't neet to really bother with the Fixes-Tag)


Cheers,
Christian

> 
> Fixes: e5ea92a7528d ("p54: AP & Ad-hoc testing")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> Changes in v2:
> - Correct the Fixes tag to point to the commit that introduced this issue.
> 
>   drivers/net/wireless/intersil/p54/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
> index 2ec3655f1a9c..57a62108cbc3 100644
> --- a/drivers/net/wireless/intersil/p54/main.c
> +++ b/drivers/net/wireless/intersil/p54/main.c
> @@ -143,8 +143,10 @@ static int p54_beacon_update(struct p54_common *priv,
>   	if (!beacon)
>   		return -ENOMEM;
>   	ret = p54_beacon_format_ie_tim(beacon);
> -	if (ret)
> +	if (ret) {
> +		dev_kfree_skb_any(beacon);
>   		return ret;
> +	}

Hmm

>   
>   	/*
>   	 * During operation, the firmware takes care of beaconing.


