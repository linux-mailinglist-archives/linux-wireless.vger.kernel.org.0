Return-Path: <linux-wireless+bounces-24524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA6AE983A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4100E1885D67
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D887A262FE6;
	Thu, 26 Jun 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emb3sLuH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8E23B63A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926326; cv=none; b=eRGnjAZ3bI/NZ5Pz8dj5KMyFsGeXDSjGSQNjJrOnOHNx31QUciWVaGo91Aa0NuyEts2w0bS43rp2lOWkzhKaVVAOOozwC4lbSYBSQJEMRY/1aNIUXWQO+jBSIYgUUT61nHvEwx4lIm+/5MKAsZI6TTx3X+pwwbjq8bLtmSlM3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926326; c=relaxed/simple;
	bh=lQQFyxRdZY6dHhWZ2Xw7sItjD09SUwrIMb3h6p0d1dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsTN20SVFaUyWKMTZRFDqIVoRrmuwGd5/sCrW9bYKmITl4rMsYtZhiJXSJX35TkIOwEOKkv816ivBGoT8IM6sVFMmhHenBifO5zrf13DqMvUhgcnzb3cvPN1MjYfIi1xmv3p+mEks1VMZJVp//l4CEHwTi9FdkJcJ3AXZtuQzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emb3sLuH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso9660155ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750926325; x=1751531125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvGXJZ5mCQXLNNruf7I63Z9QnuEQfUAXtElT8QSqxJ0=;
        b=Emb3sLuHcBVmnEHBOSxtLlqpXUgE+5aZm5fsnFD1mEs+7Slu46rxwFCyMDR+1KOSxa
         9vEXExild4kTevm8qkJyc9SAXPXy49FxSLaOLq2h9NVhipvvkMm85VaCia83/j2mJ4tf
         dMPxPdq5b645l7P72ccAMQlpOSLLGTxQCfeeCiMWrxQyGykdf/SNQj8+NgpejyRKUSG2
         LQ8ZldPxdSTZ6v2zmpduDWmCiWJ11atJt/pIj3+jQ1M7I8nx7m1WRUVd3OvjjvQBMP7+
         rkMakVsJ3Wqeh4+6g5sC3mEQDCXXWrkcu9bxQkW7yWZFfTwFMYktg1+oFw6uxdtB0UFE
         iNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926325; x=1751531125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvGXJZ5mCQXLNNruf7I63Z9QnuEQfUAXtElT8QSqxJ0=;
        b=jZPM3KpvmuwDVfmGF893trpnc6A1ihvay5f8FnXtx6HOrdXurudL7FzEW8oyNM7E5A
         tyWLd4Xo6gTIkmFPItPudW8Dxf8Tj+S0wxrUs/5ar2TQ1T/NzE4XKxQL/xFjlyE3GHC3
         AypFsTK3fTzYMLvJOHCGnB7muQ8ujT90m0dU08sizAvDBxemGFH9Clxepii8HTj0ef7l
         p45yeMiGQq6sz3/ztFY4kwe50P4hWwHKAv1P2G0f/R29YfFsvXyrq/K18w4EaBcfvZ5q
         fySQQJclLvn4FUcnYtrIv5pJREisE0P241xuDGg98bQddxHLE9+OivKb3I3VR2zm+Bap
         t0iw==
X-Gm-Message-State: AOJu0Yx1n/KkjcfYrwESD58EqLZj9mCaay4hwYujhnrpTQ/CEHvZYpzJ
	Tuch403IoHo1/tjfkR5cdVBg10Ln0ExB1Y9ZQuIKrwhqbxqM/P+zKzAw
X-Gm-Gg: ASbGncsYIvKIpCW5zDI+cAheYT2AYKHX38YUv0+Y0mHvFW/JgJmu8RKiUQuvrLHU3dS
	3C9K/NQ3Fn2GL+829G8qKL9282nGIxtM5hLpaCW3Ad/E7CFep8hI+H9XaVfgUjYfR2Zvy5y4aIV
	MCFmGb6JSx4siBYn9kY2kSYUe4wtrhtqaRuBlNzQbfUehB/csvBbNV9ehg7yVfgoZjkicQ8HE/3
	B9Agcm1UgAOobEapjzJy13Skk707cJJXrFgoI00xW7qANJBmJ+jxZYoxLt/b4hWOVbQXcF8oyMj
	QbWHu8IOSBQ7dIer7WXZnW7I+cUzS+f5ghnsvMmj/2CR2GBkTI0YnaLaDnwEIs9wIuEyWDGFy2q
	WV4sfVpjGFmMjZBvE2NCYxh7qPPoILdJqSRPaVg==
X-Google-Smtp-Source: AGHT+IE7csJp1OjepPT/fKyPevx3HFtsn7+CJhPoZvjV5WQvpgR0r692NTPW9rpMbrhAk7rs86Ix+Q==
X-Received: by 2002:a17:902:ef03:b0:237:cc75:77a4 with SMTP id d9443c01a7336-23824362a9fmr91006855ad.42.1750926324557;
        Thu, 26 Jun 2025 01:25:24 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83cddb0sm154224535ad.58.2025.06.26.01.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:25:23 -0700 (PDT)
Message-ID: <d73a8c5f-15ec-4ae1-b4e1-b2113bd82cfc@gmail.com>
Date: Thu, 26 Jun 2025 05:25:21 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
 on 6GHz
Content-Language: en-US
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <20250602121434.3011282-1-marcoshalano@gmail.com>
 <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
 <CAGb2v67zJ5RSyc-tEw2bXYzeJ2q+rkqbgCNZO3Gm+krRbap-RQ@mail.gmail.com>
From: Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <CAGb2v67zJ5RSyc-tEw2bXYzeJ2q+rkqbgCNZO3Gm+krRbap-RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 05:16, Chen-Yu Tsai wrote:
> On Thu, Jun 26, 2025 at 4:12 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>>
>> On Mon, Jun 2, 2025 at 8:15 PM Marcos Alano <marcoshalano@gmail.com> wrote:
>>>
>>> Change rules for 6GHz on Brazil removing `NO-IR` and adding
>>> `AUTO-BW` so the 6GHz band can be used.
>>
>> AUTO-BW is not needed since there are no adjacent bands that can be
>> combined.
>>
>>> Add the relevant normatives in comments.
>>>
>>> Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
>>> ---
>>>   db.txt | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/db.txt b/db.txt
>>> index e331d4f..3b0adbb 100644
>>> --- a/db.txt
>>> +++ b/db.txt
>>> @@ -321,8 +321,8 @@ country BO: DFS-JP
>>>
>>>   # Source:
>>>   # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
>>> -# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
>>> -# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
>>> +# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
>>> +# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
>>>   country BR: DFS-FCC
>>>          (2400 - 2483.5 @ 40), (30)
>>>          # The next three ranges have been reduced by 3dB, could be increased
>>> @@ -331,7 +331,7 @@ country BR: DFS-FCC
>>>          (5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
>>>          (5470 - 5725 @ 160), (27), DFS, AUTO-BW
>>>          (5725 - 5850 @ 80), (30), AUTO-BW
>>> -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
>>> +       (5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
> 
> Also, the 12 dBm power limit is warranted by the PSD limit of -1 dBm / MHz.
> At the smallest 20 MHz channel width, that converts to around 12 dBm.
You can see here: 
https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915, 
in the items IX.4 IX.5 from table IX, that the maximum allowed dBm is 38dBm.

That seems to align with the 40GHz range, where the maximum dBm is 40, 
but it's up to you.

Marcos.
> 
> ChenYu
> 
>>>          # EIRP=40dBm (43dBm peak)
>>>          (57000 - 71000 @ 2160), (40)
>>>
>>> --
>>> 2.49.0
>>>
>>>

-- 
Marcos Alano


