Return-Path: <linux-wireless+bounces-24534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0904AE9A35
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D0D7A3D16
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653E72D3ECE;
	Thu, 26 Jun 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B73sbJ6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77062D1F6B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930512; cv=none; b=aXJedM9uTmxzf9iNnYu1xGS04JJTVnIjWz1ESV5Lh9i8SWcAluLISVjZMHl1QB+pRU3V8sB+NK3q/wNuZumYeHylfx7wj3j772HE+d4+Tk1wPbXLgLvYftv52eBigxMHzoDdxtHZz7KwbRocv/S6KzAehsrGRPXn9RXGTRk4/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930512; c=relaxed/simple;
	bh=bZM0LWDpKlOcQZRGsZFPQF6vnbMV/QEE33W62YRBa0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+Lo2ueLJX23zrnfxxQHlL/KZgcy7AH7oVGzM/h/wXhPijC1Nl1pFPte57evvwUGMs4GSlqdtshz8tCC5thcACwG8RTtCsmDZcMw7w+L1YJhNKXKwp1SttntgXV2s9d2ideRA7cMEj7BZ9yCPtyswb68zgvVovaxwr9JgVqLZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B73sbJ6L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363497cc4dso7284355ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750930510; x=1751535310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YTccq4Lc7u3MiksKCLpSHjMBz8TibLa7GdmdTjd/yk=;
        b=B73sbJ6L/q226pX312XpLwHf9OhpF4i9ZC8DO735Bb2itVupWYMFLgYA2HR40ff99s
         8/RwhlJ9GegOf5+K+UqP/Gj4tz+q87G67IyfaQdWy3I5CejaxPR7LxXuHutqFm1uWU49
         sSGaCKJ1MEnagV8pEX5kNssGzxhFgCxMZRKvCpJNuWXZRVFFyGg6hdMQRFZsjQJkv9D+
         Zu81SPe6JJcJP7yJIXgx1SmIkHUnQpd1FhqoupvUXAI2nIGjQRrKfp+A4NVglePj5jud
         YRzDQv1VPKwO3SrMyjqvWQ9UdR0vslrhpfLXMLaQAKmNI7cmBGPjwq8rsChql0Pv42kX
         ydlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930510; x=1751535310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YTccq4Lc7u3MiksKCLpSHjMBz8TibLa7GdmdTjd/yk=;
        b=AnvPPcYBmKmgZIoQEw/imRVaY4UqoQCTV/JEMhwl39A0oa+yV1nsPQPg7UCL8B1fUF
         y20o/Fh4IPR4thcRrYsJuCVsNJcSXj+OpaoG5BevCCBxH54vWaJkFcoJbVNZkCpih6aa
         bwRFt39R/N3f1IcDAbp5Jnp4FsxW4wASluGDgg8OC1FBivaZzb7YOHHkFHZFTmV3HFe7
         uZBIGGes/OqzjQTciYV6Ov0CxJMcFr1Q27r4DfLUOYAOoTR4LMj90QQhPjBJGd/rrWSi
         Nso+6FYbJGWM2tWFvSZl/7tmOF3bXM6gxxQMmg9rJWUtpnVVBddVoNWl2hAMopRwFxpp
         F2jA==
X-Gm-Message-State: AOJu0Yx3f5Vg4Dt1Rnjw98yTbSW40KV/nROGFOiSq/2//+T9+MnhhANH
	XjSQm8kYSOatlfOXrk0pTlY+4M1AuYKLcT8ATnBfr+W/HsEp0JTmdu8sj/NXyOF5
X-Gm-Gg: ASbGncvQPmKYefZMdqRcz6gYI2agBodi5AD/vYms/IylfmBeXessPBC7K/wnBDop4ko
	94o6AccQ43w6VoqL7wgm18riEKiD8C+10HNtxkTnbwLYWc51a1ZVcsolaYNbJzcm4dqHl4SJL2j
	8q0ze8/1xqSEep3InvR1XvzQK1aUi7sTByYL6/dTw8UjGI3R+NZ1wFLOaXb4aQSwIYaHEeDNfSq
	JZrVRdP60p5tnPUcGiFwzoxsR8IzpMa+KOqKMvCcgYnmTrq8an/bYWlDpuj1GHJZzfc4LT37Td5
	2p0C5ZEMTNPxQVF55VgId6jyUcEI++zx0lKCH/2Y2UqbOYA+mbHQ9BRXgLu22mbHj4runP1OmPm
	/NYNHAb3GUlpjhAY18SmcYnsrG7uLnFf9FbW7Cg==
X-Google-Smtp-Source: AGHT+IF5YlfxD1w98JEd+twGu2u73yP5jiUJbiU11iK9yejZxpyWbiGfd1Ju2WGdUjMuMX1bg5LQ9Q==
X-Received: by 2002:a17:903:41c1:b0:233:d1e6:4d12 with SMTP id d9443c01a7336-238c8720354mr40121295ad.13.1750930510061;
        Thu, 26 Jun 2025 02:35:10 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fb15bsm153502275ad.81.2025.06.26.02.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:35:09 -0700 (PDT)
Message-ID: <fd31fb5a-5bed-4920-925c-e848f2dc4b13@gmail.com>
Date: Thu, 26 Jun 2025 06:35:06 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Content-Language: en-US
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
 <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com>
 <ee7a2587-3e4c-4bb2-8eeb-961dbbb9ca97@gmail.com>
 <CAGb2v640p2zfD9T6PnmfOwJY8nMeSyY5CJNhtdW9B-+ZPNSW4Q@mail.gmail.com>
From: Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <CAGb2v640p2zfD9T6PnmfOwJY8nMeSyY5CJNhtdW9B-+ZPNSW4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/06/2025 06:23, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Jun 26, 2025 at 4:37 PM Marcos Alano <marcoshalano@gmail.com> wrote:
>>
>> On 26/06/2025 05:15, Chen-Yu Tsai wrote:
>>> On Mon, Jun 2, 2025 at 9:23 AM Marcos Alano <marcoshalano@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> The rules for Brazil were based on this normative
>>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680,
>>>> as mentioned in the comments of the entry.
>>>>
>>>> This January came out a newer normative
>>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772,
>>>>
>>>> It allows 6GHz frequencies, so the line:
>>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
>>>> Should change for, at least:
>>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR
>>>> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't
>>>> work because of this outdated rule based on an outdated normative.
>>>
>>> Those are very large documents. Could you help point out which sections
>>> or comments apply to your argument?
>>
>> https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915:
>> in the items IX.4 and IX.5 mentions the 6GHz frequency.
> 
> This only covers point-to-point usage. You would need to modify the rules
> and add the PTP flag. Likely not what you actually want.
> 
>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772:
>> You can search for "5925-6700" to check how the allocation is done.
>> It mentions satellites, so that's why I set indoors, but maybe you
>> understand that is not necessary.
> 
> This only gives the band allocation, not the requirements for each use.
> Also, satellite communication is a different use category. We should look
> for WiFi or RLAN, or perhaps "comunicação multimídia".
> 
> The requirements I were able to find are:
> 
> https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2021/1510-ato-1306
> 
Based on that, what should be the maximum dBm? I saw it mentions 30dBm 
but also 24dBm.
> ChenYu
> 
>> Marcos.
>>
>>
>>>
>>> Thanks
>>> ChenYu
>>>
>>>> I'm no lawyer, so please if you see something different, like more
>>>> granular control in the allowed frequencies, please let us know.
>>>>
>>>> Thanks,
>>>> --
>>>> Marcos Alano
>>>>
>>>>
>>
>> --
>> Marcos Alano
>>

-- 
Marcos Alano


