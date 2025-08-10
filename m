Return-Path: <linux-wireless+bounces-26238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E67B1FC91
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F9C18959D7
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43F195B1A;
	Sun, 10 Aug 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl8gwrD7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376014AD2D
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754863578; cv=none; b=cJpdx7WfGF2afLm97u5aL8S/kJ8oHqPFrpi7N3kNDQYkMylPB/Sdhu5AvZ3VBCHOq81X1HehMrcze/q8e19rqgonXJPdtq1aTw4w1Cp/D+EBiFDK/nW3uLDc0nNbPIvnFQ+ZK6Qap4E0f/3vXhkBnAcS+uggEL+WuSi6sVnW9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754863578; c=relaxed/simple;
	bh=ORpQMRd/SBrivAgZnOmWLxkH/cK9Ku7hrQG70D8s4ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RnP+8L3oWmW5HVZIBYUaiiTWrhuZ3mLMYDDR0LtkJInuHHO1Ui7zLbfJQFv+XBBQsBVK66HeFbgNUe2E70Xj9jDFdPy92zOMfpsF/w9P6Sqwsv7gT2c6vlmMpPrlQwyF1pOEiD1z9ItzoDQT/JOWCuHtmJHlgMXtXj2qNKXZZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl8gwrD7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7886bee77so2862745f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754863575; x=1755468375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWha2fh8KRgBXeWsgpB6nWV4uBd2rsE5HLBzUWxgB08=;
        b=Zl8gwrD79NcoUWBUGQiCCZXXzXXJgquXvvsH85tZX55ue7PI3SE8XfvquYZvOTXIhF
         wnarWm6FoRH5IyTjclpC/tq6IkGyYbf9XOk6qXgwG4YaHjR4J4fX51vis3IcY90aY0N9
         fXC/U/0hBm8WlYbXahd1GyLPbkSOxLtYrOGxIFyKebjXSN/9u6Qk6d2ksmT9DbvM5JEl
         2ZuKp5jNO2SJARdbYtHHZzYlKWIlVLva1JRzUmi1p6jWr9BPJ3uvF2eO55UXRMTu8jFM
         aZi0rst01AWPHofg3odjpEBltH6bZLMH9d0IbWFMUkbWb3X4xGl8ClLZXUgQ2tdYTWJU
         Ktuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754863575; x=1755468375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWha2fh8KRgBXeWsgpB6nWV4uBd2rsE5HLBzUWxgB08=;
        b=wTAe/rQLsMX7fmNiUbY+/O0IgvDG1/thRrCxPphOBu2Eyd0Mi9NtsCIDI32Q0RGe5J
         M6l5X4/hLnidqWElychTdE/9sl5WkQNWncYZz/gvzkwEhFXXL4LR4nryV8szxmBWPkVs
         P6BFjptP4bwKNh4JU7eSO3I10Q80QROAnsDfYQyXGAA/0PrMIDw63BpBGhEpglNIJo4k
         eRMD96uOypIa7vr0QPvybSIFoBPGSPrA59UBDQ20dRGxnqPuqjfY+mHYhZFkBaB/2d1Y
         jGP8b7HNOUPjGpLmzxphaaDg0M09JMcoI5tdVYMMfcEy3E7PbxqaeRNRozC+CKJMEewF
         BPsg==
X-Forwarded-Encrypted: i=1; AJvYcCUUSTY5iD5EVNsjl8A7sWeVl35f5NNwkmp0dEHVfV+Sx0kN1olAK/Tbd43dRNZ6kGifFMMngdY+6Oky8k8CSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74RA2m4O6Xh/Ha/MYgyHwm8qGsqm8Q4hpqLdXEiNOv8GImUmw
	V/4yPfEvr+M0/0ElPeTy0UzQ5BvinrFA6DmP/0oVa5K272XP20krZCDW
X-Gm-Gg: ASbGnct9kMWg+hRfydl9I4kxte19LAFg7gxGXAuaGucSuukyKYd71bEX0d54Umo/S5i
	UZHa06BBljRgji8uylR1ZWKpydV71l0YQyKz5XXIgUfugD390jhALly8jXxlF1daOQlbZgHtmW1
	kMGzkWHtckszGCJPoUm2t3eUrn08nf/8BDx/AOqSBT95aap/7DKXkCUcPZWP/ETv2XJkehStfLA
	OfMZaeDo0yTWY4t4TuxMoIYHcOPq5bOUnS7DI/Q3LqjIshPyl3fZV+31mC7E75ljSgK04bfjNDz
	Fu3OdRuTi2JOR0ypKLagTDfFHAOk/O1loVj/CUEj+68ajpv1ogrCt2ejA9KqDRMmkhstrRv06bB
	SSOg2EQmmdAI/ZBDmQvfqSZyjQhFZ3w==
X-Google-Smtp-Source: AGHT+IGR4MQGmaAoAIL2cWPTrj9HIaxQLlhe3AljYTi+cMlIwISRIvAHMmazx2CuH/B1VeCgZjYZhw==
X-Received: by 2002:a05:6000:1ac7:b0:3b7:8892:ed8d with SMTP id ffacd0b85a97d-3b900b4bcc1mr7545968f8f.6.1754863575075;
        Sun, 10 Aug 2025 15:06:15 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm245713855e9.22.2025.08.10.15.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 15:06:14 -0700 (PDT)
Message-ID: <6ccee1c7-612d-49c8-9002-934488a20337@gmail.com>
Date: Mon, 11 Aug 2025 01:06:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw89: RTL8832CU loses the connection
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <2bc07f15-c551-467e-b9e6-2cc65b874e8a@gmail.com>
 <ddeb37fb73b24e35b7f37494fa3c6bf0@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ddeb37fb73b24e35b7f37494fa3c6bf0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2025 09:21, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 01/08/2025 23:49, Bitterblue Smith wrote:
>>> Add support for RTL8852CU. It works well but sometimes it loses the
>>> connection:
>>>
>>> Jul 04 16:05:56 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>> Jul 14 13:45:26 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>> Jul 15 17:51:28 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>> Jul 18 14:43:30 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>> Jul 24 14:58:07 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>>
>>> When that happens it reconnects immediately.
>>>
>> It's easy to reproduce with "iperf3 -c 192.168.0.1 -t 3000". Usually it
>> takes 10-12 minutes transmitting at ~1 Gbps.
>>
> 
> I have contacted internal expert to see if they can help.
> 
> This is first problem that disconnected from AP happens 10-12 minutes. 
> Since second problem happens immediately, we would like to check the
> second one firstly.
> 
>>
>> This runs once per second. Now I get this instead of the connection loss:
>>
> 
> We are preparing a debug patch. I'll send you next week.
> 
> 
Thank you.

