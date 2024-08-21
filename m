Return-Path: <linux-wireless+bounces-11754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377495A382
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 19:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BE6284D59
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD01B1D52;
	Wed, 21 Aug 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZFTfG9o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18B1509A2
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259954; cv=none; b=faaTSiIJqNSLT4Lpl3ZfD3opuPqVIqB61dnDnR8hUQWRwroNAh+xjADtmHsOyNhJGbG097lMy3rhi/8MPRBk1UQ5qlSswnx130rhmztutKPgbFozBOr/0uprQ/1RBvy6ElHLRM7uoPUg2ia4+0XVdrcXjne4QvnvY4UzXvu5o5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259954; c=relaxed/simple;
	bh=w7DH4E2u2UxerHQ/AnM4C9fznTJsDWAhCGMMJS5PY7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJjA3xfSS+1TlHCP816YVFRNDHQY5LlfeH6gv6WaHnlbzEN8eIXM/RvXf5zavUiMn+Twuj6sVazVh+0PNlWBEryNPyWjCz1XdL/zQy+mFNpwjEGW6ktCtQ7dFc3lj0wxzQUNfJr1bQ/t7Da/+icEjigd7l8gzV/ius+YoNtcIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZFTfG9o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202146e9538so48193485ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724259950; x=1724864750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8DQru6UN8dJs60jykvyzxdgZb0RXRlNWrUteqGq0t4=;
        b=KZFTfG9oLERKq1M23AmFSLpASwMeh0LF0XHzcg8ELqNGIMVGekjAzUqWTvaI98mVQP
         MeBgEzjz2bVctM06mkjmEnjsKYFrVlImZWXiQ4GRf6XU40GsOFTMaL2Hh5sfvdYctIkX
         3r8Q8htHntTftwkuT9h5v7fryyx6pw5K4YJQdg6nAaJ9/qT1nU+Fy+3Bh5pMdxW23lNt
         wfu8tSW2iw9sJEUsDHudBIBOjGbtu8GJNaUhZ9RyhtvXCBCMbd6P0O/7PksukaVd/Yp7
         20wyjcn3qhIPhRLZvmPe34kzD8zncqraFC4kydn+BMfBCRwknDa+iPGGHuPejw86KMdq
         pWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259950; x=1724864750;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8DQru6UN8dJs60jykvyzxdgZb0RXRlNWrUteqGq0t4=;
        b=bxjWes2xGWjeG5PIvt1Eh7i7GYuOmuR/nboUrqmxCVJsQuxoMPaWqJNk1rbOf27UJf
         7Q9pfbq3wF+6XCr/WrXAgCS0ghf0wNqNqUlirK0pi3Z7/i89zFoAC0vws7zdIQEP8hS3
         Phai2BQzor/ah5QBdrXRHhUFdNBkw94zKYsVvSwLN+So6zz7espLWFe9sQQtiSuLTULX
         48ea1U0Xp5+TzkzbyrfMZKbNsBzjFgsubMJ4VgGHhIuXioKqT9nM6WhJyl8B1sDosy9u
         SSHGs1nmo49taEm30zp9xYNXzzEsYZn2W0LMX6Wo+CaY8zHoVcwnsiMGXmI9lIfx18ou
         uV8A==
X-Gm-Message-State: AOJu0Yw8tRYZl5AsFnzsRowvHcf2ngyhsrXxz5S1ArIp8YuJgYPG8alN
	9/yC787/UcP/er0+uYx26HZs04ybE/JM7c7nqpdRXJESO0ZMhUzAX9zCFw==
X-Google-Smtp-Source: AGHT+IEU75GWPV4RspaE673U+0qloLAUcZdlAdfIsvIszG9477jSA7GQmXkyDPRT3LwXfbtcmYgLzA==
X-Received: by 2002:a17:902:ecd0:b0:202:20bf:461c with SMTP id d9443c01a7336-20367d3b7ffmr34862695ad.31.1724259949927;
        Wed, 21 Aug 2024 10:05:49 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03756ebsm96099035ad.158.2024.08.21.10.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:05:49 -0700 (PDT)
Message-ID: <45445d1b-7e0c-4c6e-b8c7-17098586d861@gmail.com>
Date: Wed, 21 Aug 2024 10:05:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k WCN6855 seems to have incorrect regulatory info for US
 DFS-FCC (no 6ghz)
From: James Prestwood <prestwoj@gmail.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <3b8c7d73-3e2e-471a-8434-61322a5746fa@gmail.com>
Content-Language: en-US
In-Reply-To: <3b8c7d73-3e2e-471a-8434-61322a5746fa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/24 12:05 PM, James Prestwood wrote:
> Hi,
>
> I'm using the latest firmware for ath11k [1], WCN6855 hw2.1, and so 
> far I guess we've been lucky that the regdom has always been set to 
> 00, which apparently allows 6ghz. But recently we have seen the regdom 
> get set to US and it then has 6ghz disabled:
>
> phy#0 (self-managed)
> country US: DFS-FCC
>     (2402 - 2472 @ 40), (6, 30), (N/A)
>     (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
>     (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
>     (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
>     (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
>     (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW
>
> I have updated the regulatory.db from wireless-regdb.git as well, and 
> updated all the firmware (including regdb.bin) to the latest 
> available. According to the wireless-regdb tree, US: DFS-FCC _should_ 
> allow 6ghz [2]:
>
> Is there something I'm missing here?
>
> Thanks,
>
> James
>
> [1] 
> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/tree/main/WCN6855?ref_type=heads
>
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/wens/wireless-regdb.git/tree/db.txt#n1895
>
It appears the issue was actually at the driver level. Updating to 
kernel 6.8 seems to reflect the correct regulatory domain rules, at 
least with US: DFS-FCC. Might have something to do a commit [1], which 
was sent a few months after 6.2 was released, which is what I've been 
using prior.

I now see the expected frequency ranges for US: DFS-FCC:

phy#0 (self-managed)
country US: DFS-FCC
     (2402 - 2472 @ 40), (6, 30), (N/A)
     (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
     (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
     (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
     (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
     (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW
     (5925 - 7125 @ 160), (N/A, 24), (N/A), NO-OUTDOOR, AUTO-BW

[1] https://www.spinics.net/lists/linux-wireless/msg236203.html


