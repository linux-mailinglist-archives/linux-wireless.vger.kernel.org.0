Return-Path: <linux-wireless+bounces-3599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC68185533B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 20:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13981C22381
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3CA13A875;
	Wed, 14 Feb 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnSgICex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD213A86D
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939073; cv=none; b=fZN8OB37X8N1bFsQzU2f6ViiaVq97CEfANpdE6dWp/4UJwv8NF6ootT2nNsW5p/bsLcqOj2hiwXkNCeDiYQJUd1688R8REGWRVWKfNdF+CRX98EMuul3VYJh2753KdOD5v/hughACijDwJNM7rJLYwbYR8QflGF6aLRS+xEIQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939073; c=relaxed/simple;
	bh=j9LOf+7gEkfsUKj60LMRpz/7485ryZOmBx3rLv+z59g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sj5UJNlxbFhcTC1DJ+RxS6egDqCgHA40Tm9i9iDVSfMS9nLTTrWcRmRa4dq3WMcrKW0ysbdIsnPZe55ZM3LhVF+Y7+sZPOW35LQT/M4ztEzvR7E5Nl123xZeTSznr1t+LnRIHk69U15+ax2hm+mbjMSUFQl0W8HfTyXEbtT90HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnSgICex; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9b2400910so1175055ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939071; x=1708543871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37dRbdjhhta4Nsf+Vm376piXGGlZS7AFxFNDj6iKGNI=;
        b=KnSgICex7I4BfhHFvaw6vBVlI5Dt+eA4JwXgAiOJCTdUa95Ux6qn+a4E+RIq0VZDPL
         1ZN6BATmK3KzPRfOl/D/DKbdrtONfxNktSX8k/oOZpQgt9E5gYRxKNPpnb0YRw1B0bi8
         cvBS71g44yKzl4DedUS3zwCA2eWXWLyvEPJVIJrmGgRxO4rNqFKT9mxn3YLw927aauWX
         +tG2abUow+9emKmDlNU2W/vlucnz2EcgeJBdDJJSrS/bm1wRgQX7wcht5CEhVy7XpIfJ
         EO9SgC1NN/cvJBIutaulqybKx7xK11+SlpR1uc0uKtbQovnzgfOL+fu0b6iCa39YDJY0
         JI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939071; x=1708543871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37dRbdjhhta4Nsf+Vm376piXGGlZS7AFxFNDj6iKGNI=;
        b=tWuz+p97m3J3CpYeLQDXeU7vP16x/p/YWEWvR4JuIwYMr0f92/cPmAUtnsxcAldYrD
         qxrfA3OmmShnREdJncZ4tIuUHgeZOz6LnV/p2WLL/Tn3AoOfxh05LY4mSmy3RZg7yuyS
         huccUPK8NnRsRulutMY31heB6NVYPD9BVyrq+tkpeeUCVdKbGgQYvuQc7ExzioZ1WI6u
         RXAwF5u3xJHtp/JruWmxhy361SKlvsSSOVJsITJTG27ed74knRZq7n4DFMMY2qMz3q1g
         Zhb7pTCnKtRnl6xXRLZWQuwAn5km1lm1CFh/Bn6+KjlJbcFVd9bZgqxalzIUu4cx8LoQ
         +yhA==
X-Forwarded-Encrypted: i=1; AJvYcCWyg1yXw32eofMnzO1C05n2hL8AY6wshETrngaCzMWXnAtoGhiPY4BGLXPaKqyCE96LUhYNjVYjSOZzeeZRyA7NqDGDImfnGlrwUu2yb50=
X-Gm-Message-State: AOJu0Yxvp2A+uVPLffIyVf9WomamebHk4k/R5AO3p0m5NFOpBYzlFtra
	r4xqwIA3cFmjZbQlvAe70ZmKGvEFJCl6hccPiMopA8DhkXAHdVqI++3wkdV43Yc=
X-Google-Smtp-Source: AGHT+IEm94MMl/cemt4Hrj0PBlkvCxHkz2zIoy6SQSkyRYVkcs7BCL54WcK0CgkgB5oBlRRMkaLn1Q==
X-Received: by 2002:a17:902:ec8b:b0:1db:28c0:3ec4 with SMTP id x11-20020a170902ec8b00b001db28c03ec4mr4394701plg.7.1707939070426;
        Wed, 14 Feb 2024 11:31:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFpI31ibNdZ2i5ghZyc4oJIDzQpVpS1Kr+hfq3GeUI7+33xTQG2Ta6Y4wc5yjRVGw8wTqjhbHrd8N8BMaDjoeuCpZ/eDxPJP2dk5nAKxHvBwP233djLrvUQkkyXKctEqHkUA==
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902760a00b001db616fa11dsm1328588pll.238.2024.02.14.11.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 11:31:10 -0800 (PST)
Message-ID: <4eda39b4-3b16-4f01-a241-50409d34ce33@gmail.com>
Date: Wed, 14 Feb 2024 11:31:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac AP mode
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, KeithG <ys3al35l@gmail.com>,
 linux-wireless@vger.kernel.org
References: <CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
 <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com>
 <311c594bddde32bacd45acbfa6f40fa7670e51c6.camel@sipsolutions.net>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <311c594bddde32bacd45acbfa6f40fa7670e51c6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johannes,

On 2/14/24 6:34 AM, Johannes Berg wrote:
> I have no experience with brcmfmac, but ...
>
>> I was helping Keith out here and wanted to provide a bit more
>> information. I found there were a few differences between IWD and
>> wpa_supplicant related to scanning which may aid in figuring out why
>> brcmfmac is behaving this way:
>>
>>    - IWD scans using the wdev ID where wpa_supplicant uses ifindex. Not
>> sure if this has anything to do with the difference behavior.
> This is not even visible to the driver, it's entirely resolved in
> nl80211, so no impact here.
>
>>    - Passive scans (which IWD prefers) seem to exacerbate the behavior.
>> Simple testing using "wpa_cli scan" showed wpa_supplicant was only using
>> active scans. I also tested with iw and saw repeatable disconnects when
>> passive scanning. Disconnects while using active scans (using iw) were
>> much less frequent.
> This makes sense, especially if it's __ap rather than __p2p_go type,
> since it *has* to be off the channel for some time -- especially for
> passive scans it has to be off-channel for more than a typical interval
> to even do scanning correctly.
>
>>    - Scanning with IWD, wpa_supplicant, or iw, passive or active, always
>> resulted in beacon loss for clients connected to the AP. This was 100%
>> guaranteed. The clients just could recover when active scans were used
>> over passive. But either way this does not seem like normal behavior,
>> the AP interface should still be beaconing on its active channel during
>> a scan right?
> That's "normal" in the sense that you have to be off the channel for
> scanning, and if you're off the channel you can't transmit beacons on
> it?
>
> For P2P GO rather than AP it should publish NoA descriptors in the
> beacon to let clients know there won't be a beacon.
>
> Now it's perhaps possible to time - especially active - scanning so you
> can still beacon somewhat and inbetween, but I suppose the firmware
> doesn't do that here.
>
> In fact even outside of the beaconing, APs aren't expected to be off-
> channel, clients can send data to them after all. Again P2P GO solves
> that with NoA, but the spec itself has no good way to solve this and I'm
> not even sure it would even want to.
>
> In any case, you could argue that starting AP and client and then
> scanning is pretty much _asking_ for trouble.

Yes I suspected as much. It seems some firmware is just better at this 
than others. There is one use case there that I believe Kieth is 
targeting and that is new device onboarding which I'm sure your familiar 
with as just about every "smart" device uses it. Where the new devices 
starts an AP and your phone/App connects and provides credentials to the 
"real" network. The tricky part is having the new device scan for 
available networks while it has a client connected. Some drivers support 
AP scanning which maybe is really what should be used for this? Maybe 
that is optimized to actually work.

I guess I'll also ask, what _is_ the target use case for STA + AP 
interfaces running concurrently? If scanning is unreliable then 
connecting would also be most likely? so what can you actually do here?

>> If this isn't possible or can't be done reliably then
>> should the interface combinations be changed to disallow concurrent sta
>> + AP mode interfaces?
> Maybe it could restrict it to P2P GO instead of AP? But then people will
> anyway just notice that they can use P2P GO and connect arbitrary
> clients to it (not just P2P client), then those clients won't honour the
> NoA because they're not P2P, and then you're back to the exact same
> situation...
> johannes

