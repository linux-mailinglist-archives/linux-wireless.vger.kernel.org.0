Return-Path: <linux-wireless+bounces-21804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C5A95A8D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02E47A2A93
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3452AD3E;
	Tue, 22 Apr 2025 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="FT9M9jGr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58E27702;
	Tue, 22 Apr 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.119.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285846; cv=none; b=VfxNeL4mKX3FXHj9DAaRLzwYTuva76e5VouOqd8KhiYy4gWAiNxst+MJOZrx5cIU5dYawdNmh96e+vhhCcW89Z2bOejU43NJHWzMXw9VLF7xT/hetyGX6QP5swf6QeRhbHfd6zIPjNMTHN87TF4DmwLRsBORQnQ8KUQodRPy8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285846; c=relaxed/simple;
	bh=9JbPWgTtaRUcud7VIMMQhF/8YKR2qN0SN4ekG60jgZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJhjjrW6+QqEK5zJHI2Qkr0VDFsG0ULoegjEiqoT3cMOmw0lW06HUy1UUErdOnIQMwsmLELp/NUQVLYFam4tTbNW+L/EDXPz6vDx+BWdRrFfDvr7p4ZRXY2nbfmYaUEBVoaAnstFn67q4AjyqkwnupqjuPJhOqqlbQAL4TjT1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=FT9M9jGr; arc=none smtp.client-ip=217.182.119.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 9408B3E928;
	Tue, 22 Apr 2025 01:37:16 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id A838B400AD;
	Tue, 22 Apr 2025 01:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1745285834; bh=9JbPWgTtaRUcud7VIMMQhF/8YKR2qN0SN4ekG60jgZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FT9M9jGrry8af/5uW3xSDINGCp9SyvfsncPX/7sjj3zWTpyP7ZZp+o/73M/dkgZGr
	 asbLS7uY9/sapBZjtlyR3MMQDgtIQGsdMj5i4qYGmSp64MWxkjnVj4FAG2N9B1TPKw
	 AmG6Ms6lDpe/ICm91YpycpaRx4xZIO7sy0Un2Ywc=
Received: from [198.18.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 58B31404EC;
	Tue, 22 Apr 2025 01:37:11 +0000 (UTC)
Message-ID: <0dc30d64-d520-4d54-ae84-43ee6f40b18e@aosc.io>
Date: Tue, 22 Apr 2025 09:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
 Liangliang Zou <rawdiamondmc@outlook.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250419081251.285987-1-jeffbai@aosc.io>
 <4a7284bd703743959e709b9465dabf1d@realtek.com>
 <985175be-de04-4d1d-a859-fa740d87c9c3@aosc.io>
 <6f0234bc99094b3d84959afd4eea55d7@realtek.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <6f0234bc99094b3d84959afd4eea55d7@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A838B400AD
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,outlook.com,tuxdriver.com,lwfinger.net,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Ping-Ke,

在 2025/4/22 09:21, Ping-Ke Shih 写道:
>>>> Please note, however, before the rtl8723be finishes probing, the AER
>>>> errors remained. After the module finishes probing, all AER errors would
>>>> indeed be eliminated, along with heavy lags, poor network throughput,
>>>> and/or occasional lock-ups.
>>>
>>> Let me clarify here means. Do you mean all work well after applying this
>>> patch? Or still lag, poor throughput or lock-ups?
>>>
>>> If all symptoms disappear, it would be worth to take this (quirk) patch.
>>
>> Indeed, everything works well after this patch, save for the remaining
>> AER errors during driver probing.
> 
> Good. Then make a formal patch.
> 
> By the way, currently wireless tree runs build testing with NIPA, so please
> specify rtw-next tree this patch is going to.
> i.e. "[PATCH rtw-next] wifi: rtlwifi: ..."
> 

Understood, sending one right away.

Best Regards,
Mingcong Bai

