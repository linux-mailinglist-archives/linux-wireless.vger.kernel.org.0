Return-Path: <linux-wireless+bounces-30205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BFCEB365
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E43300DA63
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87030F804;
	Wed, 31 Dec 2025 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QDEAe+mn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84538FA3
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153658; cv=none; b=LYrZ9ry4iWVowOey1d5jOTiNNDlbKNJPNjD6k4w4CVPwazb0lT0kDq/b+knrWXFy/vMIamFwG043Tqb6gFIS/ZJZ6/Rc+097BY5TRwzrMCEMHU82/g+VHzlAkYS7XWyA/VAp4ghiwdrbZMX5C15rgcOC7iQum2GxEipsut1lCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153658; c=relaxed/simple;
	bh=aVCmmmffctXfw9cmZQsxfxcu0pYDd14gTER5bJ+1/Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6xVLbjpHAfxO/Uy3aa5bOdWhuvvzLPDyzna39n/Sz2PZtQGeSPezAPB3BPBhrUhlNpQN4zT39YXdcae8YyE4lmYNhHMRVD/QCCxIxoIuHW7ejk2YSt5FbLkeoHg12BiixgZLpx2vfMLL04CDTMW6DXJ7jrgJXdCCRFu0elL7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QDEAe+mn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6e815310aso8614574a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767153655; x=1767758455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VNylGeHty3hhb1+O1+8twZmND0tnjr8y4TdbwY0GSg=;
        b=QDEAe+mnC/VsAfBqky7/IRbgRoTvJAl7BM7WcwiOTLIms2lXrO2720xXpfkHf61doS
         qXYhv75kdZzHbCeFh/4uiZLD/GGLoPsXgSgLYvVw+UtsQvAZH/1OpNG8Y+7y6LDOxzkk
         xppVNr7ai/8qj7xdxDkwe+VHefXGpkXF7KQEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767153655; x=1767758455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VNylGeHty3hhb1+O1+8twZmND0tnjr8y4TdbwY0GSg=;
        b=xTaAPpDZpy3Af/YvS06/au9hy+R4aTBadyRuoOZR6r3NAyiksZH3mz4iQxWhVnF8Ya
         bJnjUTyeGeQoX46AeTNscCUAzyQISCirj7+GV3h7aHAnS61jE++XikcJtkDC8JyF3iKi
         1jAjVgBK92HAhdvSums6lXKzopxc9JzNv09wJ8ToADneusdBBUION94JLXjkzRKSP9Tv
         0ncbHAPeBYL039Fp0SA7XibrrI9xlPWgy9W2fwEEOz9ac5Og1IOXoTzBBolN3Xisc8z4
         gtOTLdnlUZ5dhA6dtLkdBLdu/rzJugImPJd7sMQ+R+3Zhgzhkh64VV7+WSVnNWy5HxHj
         6MRg==
X-Forwarded-Encrypted: i=1; AJvYcCVesyIdvcHn0GMYobceFzrtfuyl7gzmF4CGx+elitRjSqQSdE5UhwpIVcidVhj3+s0wZOBwI1wuQbuThxvioA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/m+mCgqs6uq+Et0tX4dJ0WHqgGVaI6/vve4jOFi696W56bD3
	VFSYkSzT1XkOZ1+wvLjA6Y6V5aa6fRXuI9KJG46Eoym6U8qjZ8dMUG82sgftYgM4a9U=
X-Gm-Gg: AY/fxX7jmJv2Y/mjdztHf8BI3SfW0KyJAPelIZ7JT61nAnciR9UDChx8A8Hqtco5/v9
	of9Bx1FGhnsxP7de/x9e+8roVVkuCNf8tfgYrRei4ylOR/ilmFKlqQ5trHo0/fBtoJxZZEed2Nw
	giyNtvPkBNirtFR9aiXsHUCGlcSWO/dRv9YTdN5JDOOjGMKgFK3VW+bQi1tXKANDLRmHB8khGs5
	BnUI/cukiUfWdLVFLNQLqm5XmDNZ0CDQmjpzmW7q4YJ3zc0DxwbN2om+sotB5MUZYfWa6ny1tdg
	I0sOw6CHLZuBwu38Pj9eUIdUUookXiEecL7NWi4WN4/roWtD5wm1nV9qzb0IXkPSCdL8YkeJkXG
	a8r0yKQURqmzJd+VDS0rPcC2f1RHhyERe724QPpGTIa7euIoSEl25TsNCNYdCVfkxcmoXfCkB5y
	f7NM4+k2DGGgL6hiHu6T+3iHI=
X-Google-Smtp-Source: AGHT+IF9F/siqhgAslvMOnVu4nsfQJ2/g/8vSzR2SppngNQxxoARtodDwAouloJqhdkdH2KDxgw/hQ==
X-Received: by 2002:a05:6830:6688:b0:7c7:5974:3563 with SMTP id 46e09a7af769-7cc66a15846mr16285625a34.29.1767153655626;
        Tue, 30 Dec 2025 20:00:55 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66727e37sm24112013a34.1.2025.12.30.20.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 20:00:54 -0800 (PST)
Message-ID: <fdebed60-264d-4f05-9423-618bc3ec6d6d@linuxfoundation.org>
Date: Tue, 30 Dec 2025 21:00:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Eric Biggers <ebiggers@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com,
 Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
 <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
 <20251231015712.GA2299@sol>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251231015712.GA2299@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/25 18:57, Eric Biggers wrote:
> On Tue, Dec 30, 2025 at 05:27:13PM -0800, Linus Torvalds wrote:
>> On Tue, 30 Dec 2025 at 15:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> I would recommend reverting f804a5895eba instead of trying
>>> fix it. Then find a better way to eliminate extra newline that
>>> shows up in dmesg when firmware build date happens to have
>>> a newline.
>>
>> Yeah. Let's revert it.
>>
>> And the way to fix the extra newline is trivial: just remove it from
>> the "dev_info()" format string.
>>
>> Our kernel printing logic will add a newline for the next line anyway
>> if it is missing (unless somebody explicitly uses PR_CONT).
>>
>> Can whoever saw the problem confirm that just a revert and a "remove
>> \n from that dev_info()" fixes the output for them?
> 
> That works for me.  The revert by itself makes the FORTIFY_SOURCE crash
> go away and reintroduces a blank line in the log.  Removing the \n from
> the string passed to dev_info as well makes the blank line go away.
> 

I just sent the revert. I will try removing \n from dev_info()
later on tomorrow.

My quick trial still showed extra line which didn't make sense
to me. More trials have to wait for tomorrow.

thanks,
-- Shuah


