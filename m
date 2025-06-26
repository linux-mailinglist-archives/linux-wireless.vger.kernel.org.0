Return-Path: <linux-wireless+bounces-24539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C839CAE9AF4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570843AA0FD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDDA21A444;
	Thu, 26 Jun 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CODzvmAb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C6221F32
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932803; cv=none; b=eYe9P4s5oCmcDRCcJv0WrHcZLk6TfuBFN6dTmtRhlDx2SJkbNq2mshbdIEfAxdnGyQmSBIoj4O6wHUp+8tn8HHY/60xv+BysCfWtDdCmLuohYV3QbNSD/kjj76U/aL5BQl4vVGMKD4ZXfcgTAnieVmh5ZicnCHf6G0weD94FjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932803; c=relaxed/simple;
	bh=CjO2y1js2tJcZ77SNdOqjXhdxSKCZYw6AnZ091z02Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZqPFbSQAmG3eBa5BdQWE+y3wDjiYXMR972tR1BHYOQiAeH2InZc7+UU7GTBZQNTrldif3qIX7JumCdv1u9m6gF4+U7YWS7zJPiGwbJDKV1e24qSIq1jUz++DKmOlqKkjTzPtGSdHj3AxvIPnz0NEttCrdTYYiZLPeBt0E1kWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CODzvmAb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234f17910d8so8348875ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750932801; x=1751537601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4kNAGRJV8NTLdF9b/sI3XexTkYxZMN+OUBXRm12vFA=;
        b=CODzvmAb/XnUArAWW9pScRnha47WFw4peNDLUFxN6YNhpKMYyrtIoC9T5Nmgg+xs8f
         sXW4GQLfSvQf9czOcmhNnIwQAMGoXRFeSvDd9wFIoRzuS+fsVUpTGK3x5SglFYUv2cWg
         bL/icEbDRFFeLAQn91p++hzW4+g6U/rjnkNg8c7MHj09AMyTR8A3J0Z7G6zXml4KNv59
         chUuxgqK0bk39NYo1meaEDtljZN9xAXRPz04Ag4AdWkYA1HhSEhkZtOTOsQLE0z4vsaS
         CKxwdrE/ff2S28Q2mYns+GCteiLXv4hhYu+iGNWAShG0nxk7YblDPhgRssbb+RGzR+Lm
         CMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932801; x=1751537601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4kNAGRJV8NTLdF9b/sI3XexTkYxZMN+OUBXRm12vFA=;
        b=K3G+Ggmg23JCoveHC4/IRfE+VyfqLpm2D4LuyjzU0lUaJ14/JlqGCuGS17yf2NcJS0
         wbNe5V1GnGjxXilIyEycS89ShG67fi6vQ0aak3popMIQPwKgoDWKGzzcgHflOaaP9oHH
         z7tjv2jTeo1V2/1vq79WZiS4+HINkKNyZ+DRMYYXeuR9nMcNDJH2rjzAYiCLv6nUOIo8
         IlN1inSKZWomz7jaFT/OkdHCWDjbrwQcUJ7Iwrw7Q8V05HiFIuiEldIAFAADs4gMifHL
         GwR1eI1hulKyfn0A9fqH8eQiUnhNHkoKOcaZKjPTquppWMFil9wqZ1XGYSIAleZDWLXV
         FWGA==
X-Gm-Message-State: AOJu0YxQbaitdx9scGP3oKGiiZnQxGqMYESlrtPGc/fB+sRwxhnjXjoL
	r8IkKkIA1Ir5OuY7c7sBbgyWE3gKX2GkTJNv6lNmHT9qH5zFWdRKdpYr
X-Gm-Gg: ASbGncveouOabjc3BaZ8w4h1LxL4HDjwNzIyCav8xjcqRqnQa1CBs/32St4TaPQL6KH
	Sz+XC5NHUibKPfykTIrnwmXIWby8CGkMU68W3iF/mV4fz9tTipymaPTkuk06FxG+oS+BBO7IfpZ
	gXKm/nNuPHf4mrlQqLvStVpZeTZf7jh8HeL4MitXb5V0FahcrvJFXgl/kEwCoWrJZBeLC+mEhYy
	cvriEov5DYKasQctH3hT0oStdmxWFpFjdv+SkIyyFE+an8JpDlfJJSI7KzLVq7SArMbMNO8QJzZ
	uLonsKoibkIgJn9JpY5WsOtMDjyRlQXTCgFpKtMtXoxfGylWgOIL3vhrIr5kAugyp7HAIdTcXx9
	HOQoVcF9tMxuDLJDAx4lO04/62yLDglH4o/G+81TAyrWYYBrZ
X-Google-Smtp-Source: AGHT+IGKjEitZIKhw6knJii5Dxdp3cWfS/YAZDRrid2FuTClMjpwwICMJFaYBg1PXx4GSc0zDjS9hg==
X-Received: by 2002:a17:902:ce02:b0:235:f3df:bbff with SMTP id d9443c01a7336-2382409e385mr102562735ad.4.1750932800774;
        Thu, 26 Jun 2025 03:13:20 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d874fe39sm153753155ad.251.2025.06.26.03.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 03:13:19 -0700 (PDT)
Message-ID: <af36819b-74a3-4fb1-9b4a-69d77dcec863@gmail.com>
Date: Thu, 26 Jun 2025 07:13:17 -0300
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
 <46ab2a6b-82ff-4330-819e-99a67280409a@gmail.com>
 <CAGb2v65BO=EV+HxwOV7it94q2wNQA5_8AtjuHkLdV_2R33T_NA@mail.gmail.com>
From: Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <CAGb2v65BO=EV+HxwOV7it94q2wNQA5_8AtjuHkLdV_2R33T_NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 07:05, Chen-Yu Tsai wrote:
> On Thu, Jun 26, 2025 at 5:56 PM Marcos Alano <marcoshalano@gmail.com> wrote:
>>
>>
>>
>> On 26/06/2025 06:23, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Thu, Jun 26, 2025 at 4:37 PM Marcos Alano <marcoshalano@gmail.com> wrote:
>>>>
>>>> On 26/06/2025 05:15, Chen-Yu Tsai wrote:
>>>>> On Mon, Jun 2, 2025 at 9:23 AM Marcos Alano <marcoshalano@gmail.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> The rules for Brazil were based on this normative
>>>>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680,
>>>>>> as mentioned in the comments of the entry.
>>>>>>
>>>>>> This January came out a newer normative
>>>>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772,
>>>>>>
>>>>>> It allows 6GHz frequencies, so the line:
>>>>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
>>>>>> Should change for, at least:
>>>>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR
>>>>>> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't
>>>>>> work because of this outdated rule based on an outdated normative.
>>>>>
>>>>> Those are very large documents. Could you help point out which sections
>>>>> or comments apply to your argument?
>>>>
>>>> https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915:
>>>> in the items IX.4 and IX.5 mentions the 6GHz frequency.
>>>
>>> This only covers point-to-point usage. You would need to modify the rules
>>> and add the PTP flag. Likely not what you actually want.
>>>
>>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772:
>>>> You can search for "5925-6700" to check how the allocation is done.
>>>> It mentions satellites, so that's why I set indoors, but maybe you
>>>> understand that is not necessary.
>>>
>>> This only gives the band allocation, not the requirements for each use.
>>> Also, satellite communication is a different use category. We should look
>>> for WiFi or RLAN, or perhaps "comunicação multimídia".
>>>
>>> The requirements I were able to find are:
>>>
>>> https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2021/1510-ato-1306
>>>
>>> ChenYu
>>
>> I created a v3 patch that updates the comments with the new normative
>> you found, removes the NO-IR so a AP can work correctly, and changed the
>> maximum power from 12 to 27, since for APs it seems to mention 30dBm,
>> but I considered TPC like the other frequencies.
> 
> You failed to consider the power spectral density requirement. As I
> mentioned in a previous reply, the requirement for clients is -1 dBm/MHz,
> which at the smallest channel width, translates to a power limit of around
> 12 dBm. The original value is correct.
> 
> The database in its current form simply does not have the capability to
> model things like PSD or AP vs client device specificity.
> 
> If the regulations require NO-IR for clients, then we cannot remove it
> just so that APs can work. See [1] for the same discussion for US 6 GHz.
> 
Where can I check if the regulation requires NO-IR? I couldn't find any 
mention to this.

> Sorry.
> 
> ChenYu
> 
> [1] https://lore.kernel.org/wireless-regdb/14ab2a58e7603047354a17b2c980c143992a6782.camel@sipsolutions.net/
> 
>>>
>>>> Marcos.
>>>>
>>>>
>>>>>
>>>>> Thanks
>>>>> ChenYu
>>>>>
>>>>>> I'm no lawyer, so please if you see something different, like more
>>>>>> granular control in the allowed frequencies, please let us know.
>>>>>>
>>>>>> Thanks,
>>>>>> --
>>>>>> Marcos Alano
>>>>>>
>>>>>>
>>>>
>>>> --
>>>> Marcos Alano
>>>>
>>
>> --
>> Marcos Alano
>>

-- 
Marcos Alano


