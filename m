Return-Path: <linux-wireless+bounces-38017-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0rBHMGVOmoyAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38017-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:18:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC96B7CDE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mlY+i5my;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38017-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38017-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D6FC3019477
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B33845C4;
	Tue, 23 Jun 2026 14:18:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE333DEFC
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224318; cv=none; b=FMkOvSb9nB0emAyZBo0hsGfKK/jHhTm9hKFaTWHinNo4JOzGPNXrrFrsdmAt+BelNudxCx5UtCRZfJrzYESTS34Vvgp+aW8C6iwi4+HHeHFvMs8DOZcg0Yh0c2AwpF4+tJ976WX1LOCRFPLJhEowuQNI2m7vVkIqTj069ECIvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224318; c=relaxed/simple;
	bh=IIGhDu1O+xxr65+AZvSVCh+JlSAMXGWm6gzIMXsiIhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXWdIH4UoaqwMHPviuWDO2LkVyV+rcSVup7pHO5pmw12m3AB4JIBRYwoE2gENChx9R0f0dfhfyVxzSrt17sOCRCdjC9FiYrZNujEEcdE6SFOYGbuyfs+jmFTMOB3My0vo3s50RPsTqiNL8/Kl+Gj04p0roEnxyrziwjudjBIn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlY+i5my; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso39472035e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224316; x=1782829116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zXrpA92cffM+/4XGxxJ1PBuhbTGx3x8Hhj/f9/Bj58=;
        b=mlY+i5mykCd5QICvyWEGkXVpNddud+6O0wLYzwuz4twdONJ1QkoDujDbY/l6EUUz3C
         AjfQtymj60du+wH8FpuGyeFsarICJp69FXb7H5qQMjxCrRNBVmjcvD62Ht08rbPmwhwT
         qcyChDk3XFRFvxs4OgnG5Nj+VgsrTumO+bks5V+sHx78B3FBLH4maQgiuROTqf6xnjU5
         pjB+LjAqeChSq+ivSbsaM4avlplFQ054Xsty7smKAaVfUjtQjw8M7DeHyNPygR58UiAQ
         ygRXjZgzEpN3LbKAtpffiC9fgCnheITS5UjfdfIYNZVTNQe8M2VTTaKGS9o9NELiCJ7y
         D4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224316; x=1782829116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zXrpA92cffM+/4XGxxJ1PBuhbTGx3x8Hhj/f9/Bj58=;
        b=qAQLjwMScdptE35xTXH01QVMfGqGXIiuPOMaLYnCApTU6G+ENByJGX4sGwjBhw7YrI
         lrTGAONehWSy1grG7DRZ7MKG1DWA7b4MHdY0Gx/iSt/UO/9WHZGbd/ad2OEvwV4X+eWP
         xKHFYc1V7TgjyQ/jNaeZxlXL+Pt6CN023uPnmdhXFqtlDc9TuQfoAodgtWIiT/pBdpXB
         bX9wMz3CAWazMb3zptPifmhkTrVHA8iwDaXGV47YlmJSSFHtrr8KD/3sy88jzwiYOP+H
         tGIkU1oWrabQCeet9w+NNLnZjkvZvrzNx4vYVOSlPqM6fDGH79Y93N6d6aFHYubXKTyC
         0Amg==
X-Forwarded-Encrypted: i=1; AFNElJ+Cfa9Ec4dIyp22PBjZcu0jab6wDAowv5ALJoyiWrHMuHPTHmZaEHYlFqGI76jF1+hOMrqzopEvpONyi8zmFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJnL10cb4xjd9l66/ZULpX6Hsaz9cBRTfPIiG4fvXo8+Nowol
	JD3B9te5sHv5izfk7qJMwTIFaIImu66mwnmuntBW4Yvhk0gQQWqRBtypCyOyqw==
X-Gm-Gg: AfdE7cnyWymVepGDctYqLpxSEbo0E0/jRVJ60h7DwxouMAYfr2utOWUGN3mDevaNqSl
	WTQV15x8GF6qqNhBMVAF5DtXHu1u5WSLtZSd47yZWkiO21aaPWBeFKHZOv5K5a4MKIRGX2ih0sB
	GkZh83c1WcHulYEPzzZvuMGAmJg9o/GwPWyilo7am9NLtOgw3cXu9nwaaISnNsGrjCkbXTzwJGD
	k8vKrzwmcWJsjLETit5PgN4pI1MLVC2hK9iFwCBiUz3bRazDfkDmSa/odeqTZF6lxwYqfJ43hHp
	126V+4pGZmGWXDpT+81IwITHkoLKWyyR+M7mWDsjHcs1XJEzbV0P8vkCXS5fj/VJUL8N/q/ufOs
	prqzewhnf6bg5KE39JbvynCqIhR0fEDJa2yb9Vr9AiyWrpeYC24Tds8vmXtxVwcVZYSZ2NZ7204
	GR00ubTBjYoXzi49YB9Gg=
X-Received: by 2002:a05:600c:c4b7:b0:490:b3e7:4614 with SMTP id 5b1f17b1804b1-49240e932camr300110115e9.25.1782224315311;
        Tue, 23 Jun 2026 07:18:35 -0700 (PDT)
Received: from [192.168.1.50] ([79.118.68.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm648699055e9.0.2026.06.23.07.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 07:18:34 -0700 (PDT)
Message-ID: <3445ca1b-2d5a-43ae-9df1-d3f6440fae78@gmail.com>
Date: Tue, 23 Jun 2026 17:18:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: Enable receiving control frames in
 monitor mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: =?UTF-8?Q?Georg_Bi=C3=9Feling?= <georg.bisseling@sea-gmbh.com>
References: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
 <7f12ff0969754a9fa4d78b0ae3d2409e@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7f12ff0969754a9fa4d78b0ae3d2409e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38017-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:georg.bisseling@sea-gmbh.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CDC96B7CDE

On 23/06/2026 04:15, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> From: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>
>>
>> By default RTL8723D, RTL8703B, RTL8812A, RTL8821A, and RTL8814A are
>> configured to filter out all control frames except PS-Poll, even in
>> monitor mode.
>>
>> Handle FIF_CONTROL in rtw_ops_configure_filter(). When it's set,
>> configure REG_RXFLTMAP1 to let all control frames through. When it's
>> unset, restore the original value. Because some drivers configure
>> REG_RXFLTMAP1 differently, keep track of its value in a new member of
>> struct rtw_hal.
> 
> All behaviors are unchanged for non-monitor mode, right?
> 

I think so.

>>
>> Signed-off-by: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>
> 
> Once you migrate to your company mail, maybe you can add an entry to .mailmap, 
> which only affects the output of git-shortlog though.
> 

Seeing the company name in parentheses with no explanation makes you
think I'm part of the company, doesn't it? But I'm not, they just
sponsored this patch:

https://lore.kernel.org/all/20250203174626.1131225-1-kuba@kernel.org/

It's confusing, I don't know why they didn't go with a simple
"Sponsored-by" tag.

> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 


