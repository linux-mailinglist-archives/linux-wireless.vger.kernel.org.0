Return-Path: <linux-wireless+bounces-33844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EsAI93nw2lvugQAu9opvQ
	(envelope-from <linux-wireless+bounces-33844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:49:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D793261BF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64883353BDC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BE3D7D91;
	Wed, 25 Mar 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="i5tlMX/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40193D8129
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443933; cv=none; b=Q43k4TCL680/J8u8sDxegT5q0U9/U7xEpsf2RD77z174KdXht1LiVqsH2rgMIXLXJhxdI1iLGKxnpVgf0hEWDk6H29BqhkY86M6HrtYDW7nvmKW00brX7AOTFu8kzvTJ2sErHLeeI0C2FEc63Ul3BuxKD2RsQ+fl3CttscGcDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443933; c=relaxed/simple;
	bh=iTIG7NPnEuQDU80mMdU98epfQnVRFwBUtpKgmjwRJJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKDqwRfO145Z9VtgVFa8Z4PNUAUrB41UXYuz5SX+5/Qp86v6SbFUIRfK51Ap73Nhu4klPBcFrM7wBjPltcvTVAib3zNz9WYQjyGxyIVCOIWp8lwBJ+j4QFc/Kghrq49sg+DV3D4gmpMEFhMRbJQwwclNteV7zvLAZeCz4Olf/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=i5tlMX/S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439d8df7620so4183158f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774443928; x=1775048728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScAMcYDjE0UgMLd0szxAP/1Ble8QNSQNQIuh3mlHCz4=;
        b=i5tlMX/Ssln9Hx7suuJ0m4wpiS1buL7mpaUrJvenaT1iglDOVwwdJmVxwzf5r1pgwu
         VB7S2mxv5C7X1fGjpVzHO0/k5S//g0wGBYvV1i8IK2PtVOpChVmlbvRJt6Mcf4u3uuCs
         vtXgkn1XscFOaJ17vIRF753oS5os8S1rU5c44vwwIuu8k1tZVSW7EKfczGdK26huerK/
         0FQsKrdAYZBAPE8sP2gMINjIEj6Fq5bLmhtBXH8YU+aNOV2prCldRKLK07bi84be518j
         PwsyC1TEJ8M2OPzySSlBqTsW7g9m8c2hWKdeuxjOnUbaJg0lzh/dAksXzQq1POQf3gsg
         jz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443928; x=1775048728;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScAMcYDjE0UgMLd0szxAP/1Ble8QNSQNQIuh3mlHCz4=;
        b=KzLiFmd/dxb7CHg1nmnFtxYd+gzxpkNPcINloKCjX09Qj4VauWMunb3/UjtTqCJnPw
         w3Zsh8BVC6EzWjE+GV3BvKOHD6xH6bom3pyOlVIkGXDcVDvNTROr/vnn7zyXjkEywW6w
         fnvnZiBj2S/WIrzRMJ8THeVzhNYgeTOEdjOP5ZEbvorGqkf5FXOdnkWuuldwtlJeZYdW
         Q0oe9XcxDqlA88Wi3OPT1/7DbLySGdUF+1JNwaRf/9iC9fdUoHBq10UyrmsQrtup9aiN
         5D0AOb7gwKqCPMtVR/8pj5+bdFyowXA+ZBbA2dHhLFOAsw5eyBfuawyOl7qDq9w9DEad
         w2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVPaugT0OOeeYdlgpfMmXXoe/Vy+tCTeCFk6+BmyLVtyXHUCzRT8PWCbP8w4OHWqXgE+tClkD55aJUeM1pQtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CufRO9Cqsk+MNHmHpv89Do5l7FGNvKmh3EJdtnIeXaKDFC4b
	1VW2tSTR4XUTnEfBFuhcvL7vIvZSwLHharhrf+sORcAvP/BOecdwOEVjJYKWqzXxiJY=
X-Gm-Gg: ATEYQzz3aSUCeuSJGROlbXs9fMO5ljxKVL4AZbaD/43FqbrrrQrf45in1i9h1OTk3Jg
	IhcaZKleVFuWITAU/lBXE/tLRtuz7TJZw8c6cepl14iONxXjFNJVOXhm9FzFwZ4UpUtqpzfnXmu
	MhdmBAjXJgQ4C/9yQaMx1k9T9Vh1QBvdBN+JaJYqAhL7viCgwNADKDYSdWn79EwWHJRWRHxLuf8
	Dljk20QqkX6cMbHVRtn/RsV2I9Amu6+01ogXYhNEWk5f4y1DhgtoBiYawOnYJWjtTe/bn2lVtn1
	PjcHMwb3u0t5m9qB9Ssult0Pq8NPEhjQjdIqrsXFUEEOwmk28PL6vwsq5sSLGcmKsh3abelt/3E
	j/bn7SA5+7RGrV3mL19XW3CXINxmDn3H/2liHC16mD+uum++wEAsNGgm4N+qthZuZi/2W8PWMOM
	5GNJQx6MF8Rw/kZCprlKQUtu6xj3gnBRkcwbO4myt63qDg/aCamu/Wxg==
X-Received: by 2002:a05:6000:4205:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43b88a25357mr4971725f8f.51.1774443927786;
        Wed, 25 Mar 2026 06:05:27 -0700 (PDT)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b8bb32a05sm6988186f8f.37.2026.03.25.06.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 06:05:27 -0700 (PDT)
Message-ID: <4a4aba13-7813-4a18-8faa-2d9a847f94ea@freebox.fr>
Date: Wed, 25 Mar 2026 14:05:27 +0100
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
 <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
 <0f56f76d-7820-4392-88f7-78f24b9ff421@nbd.name>
 <0bbe540f-6a48-4d70-b6ca-4498f715963b@freebox.fr>
 <9b4e633e-133e-4ec2-959f-1fb25e706ede@nbd.name>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <9b4e633e-133e-4ec2-959f-1fb25e706ede@nbd.name>
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
	TAGGED_FROM(0.00)[bounces-33844-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D793261BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 12:41, Felix Fietkau wrote:
> On 25.03.26 12:21, Pablo MARTIN-GOMEZ wrote:
>> On 25/03/2026 04:58, Felix Fietkau wrote:
>>> On 23.03.26 17:00, Pablo MARTIN-GOMEZ wrote:
>>>> Hello,
>>>>
[...]
>> My bad, I didn't understand that `len` was the byte size of a MPDU.
>>
>> So I was wrong on where I put the overhead, but (a priori) not on the
>> rest of the calculation *if* my understanding of the units is correct.
>> If 1f38b8c564b8 is correct and so `duration` is in ns and `overhead` is
>> in µs, then your code is correct, but the commit message is wrong
>> because `ieee80211_rate_expected_tx_airtime` is returning a value in ns.
>>
>> My snippet fixed if `duration` is in 1024 µs:
>> ```c
>>       duration = ieee80211_get_rate_duration(hw, &stat, &overhead);  /*
>> duration of an average MPDU in 1024 µs */
>>       duration *= 1024;  /* duration in µs */
>>       duration /= AVG_PKT_SIZE;  /* duration in µs for a byte */
>>       duration *= len;  /* duration in µs for the actual MPDU */
>>       duration += (overhead >> agg_shift);  /* duration in µs for an
>> approximate PPDU aka airtime */
>>       duration /= 1024;  /* airtime duration in 1024 µs*/
>>
>>       return duration;
>> ```
>> [`ieee80211_calc_expected_tx_airtime` has to be fixed too]
>>
>> The current patch:
>> ```c
>>     duration·=·ieee80211_get_rate_duration(hw,·&stat,·&overhead);  /*
>> duration of an average MPDU in ns */
>>     duration·*=·len;
>>     duration·/=·AVG_PKT_SIZE;  /* duration in ns for the actual MPDU */
>>     duration·+=·(overhead·*·1024·>>·agg_shift);  /* adding the
>> overhead in
>> µs to a duration in ns to get PPDU duration: overhead [µs] == overhead *
>> 1024 [ns] */
>>     return·duration;  /* airtime duration in ns */
>> ```
> 
> The formatting of your snippets is really weird. Are you using some kind
> of LLM?
That's handcrafted markdown, but then I have a MUA plugin that line
wraps everything, including code. I need to fix that, sorry about that.
> 
> There is definitely an issue in the commit message, which I will fix in
> v2. It says the unit is 1024 us, when in fact it should say that the
> unit is 1/1024 us (approximately ns). Maybe that's what got you
> confused. Either way, your 'fixed' snippet seems wrong to me and the
> code should be fine as-is.
Ok then, with 1/1024 µs, the code looks fine. Now, I need to re-analyze
`airtime.c` to understand why `ieee80211_get_rate_duration` returns 1 /
1024 µs instead of 1024 µs like I though it was returning.
> 
> - Felix
> 
> 

Pablo MG


