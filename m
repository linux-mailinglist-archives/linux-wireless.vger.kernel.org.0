Return-Path: <linux-wireless+bounces-24533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2AAE99FC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21616A2BB5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267B18035;
	Thu, 26 Jun 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLNn4w23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C780294A1F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930246; cv=none; b=jTi36PPkB1dro5ZHi4S/LYQTjy83zf+WllPyBlGiq0UpxCX8XKIDpfpsFHAeTDBN8o7P31lCbwKwyVXRgp39Wcg2dtJQxFVhwKUO5I/U0LjyCYPySsoQm1KlaEeVmyVBdiZR5JH1oHL5i7mKkgzKdw+exQmdgT2JsXX8uP88Zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930246; c=relaxed/simple;
	bh=1wuoKdNwwcw7ruvdeRXgfZ7ZESt7cBay/P4YMJEQ50E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqjxoNqjCEBNC288zDx4GKVZOdneZ8ZYud/wppVMqGwEp6YavPSzEMvHscjCNHb4Xmoh5dpLqFBc9slkDdtMBesoVRdMtBORlpxkAfhU1sxuXebH0BJTsrAoDWbmSIPqObMAXY0/On1bwdVBTdB5X+m/tv5oNxh2E0OAq7MFPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLNn4w23; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237311f5a54so8018765ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750930245; x=1751535045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zETTt0UjxOK/zagtJhTyNnL4v0GhjgZOZo5txGCvY/U=;
        b=hLNn4w23easVf+RLGZ6L/JnHqzqnYEvBlih9/NiAtoIR3m6mlFu6xHJEQS6KUjIt6H
         SoY/iyi4SCfy79GDi/GN8U1h6LuWnVhPRLi7hMBEBJFeEv37T7C9b0bpkamaBv11QRiG
         x7lOPHaPRc/qwb+oVABFo6YZPhoQh3iZrqYJBLutTj7e+6NnuB/kuofUuJG51DrFkoUK
         zMdoKrF7vx8gZoGixl97yeSuaDcg6cXDYaxCC+/Q77cAt+hc+N6N85iPzbuWA9zTm6OL
         CzpHeOJlw3dotLFUkIIrsbiJSt0GWNvVQLHmkpaIFlfwU0aDoW6BplnZWlLZ3aGvtN+P
         6Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930245; x=1751535045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zETTt0UjxOK/zagtJhTyNnL4v0GhjgZOZo5txGCvY/U=;
        b=v/iwYCQbFsrdywr7DL42ZcvfDn2eEw86F/0tgMGZlYV4Y6q4N5I63n4zHd0B/txiDh
         8jv9FCmC/ADid7AaVYtRR7A1RlQLIayTgyjQGOyAkwjRTQu0aKW2r3nc7Xs1Xyjta2xF
         jVesvT9GdwGg46YAx0fGvEbpvuAEkWzL820Tb2csTcj1bBp4Pobgg63ZdSjObxbZ1K3a
         D0OrAcdJKSfbyLedZNRsY3trnH9kdxPQ9g1S1vsqrdIZF/uK4atti0dkW2oC8OD3BXBc
         qojUzKzHPeRkNef0qNBIufltmG8vcB+VvHG9q01fme51RXJ5Da9ijPLeRtJFjgmOF+5P
         F4AQ==
X-Gm-Message-State: AOJu0YzuvZ7rWE/6G4zz3j8o534edWD5Sebs74Hf/y7jcwbaRc0DcNlw
	tBZUIfwZr281rp8XqZnjDqHYRa8UOSjjSI4kGwkZ0UucQIrecccthqEA
X-Gm-Gg: ASbGncvTxte0Nc2nhWxPdeZItfAOWphP2nEgwqvQSlBZriN9J9u0dzuI+IOu2KKY0EJ
	SXaVUfBsdXHxyRBIhsWEkPBCTzF1innileX6OXjgOt+MOq0g+cp7RiUj43yQXX8epGlpoJGknvP
	81Ekjx7B0Dj7xxIMsH+/xgF7lgm+F0fzFkpYgGanmzmmPJ9cRwL1XgrK/GY9AsRrJRIlC2ogGNT
	4554czmjbjpWK/JHqwBsg+g8EW0M/8FEXu70TemFzCb37G+0ox8B1j371sGtHRQZ9FPlaHGCDhs
	jp1PzfjyuRWiVicoajwuxFOA+JzUNQvWUIXc8N4+0HJ5tNdUKKnv324MV8qAX3RPYt12a8S8HCz
	jUabrzCo5tXlhmW6ZUk3HoSBxty/klWdr/jGGKw==
X-Google-Smtp-Source: AGHT+IEFzpeIO52rdCSy6hT/2X+dCOtcMavVCiRsGNz3VRawhGkW2OXEWWFWi6TkMbC1Y8lRFYsoAA==
X-Received: by 2002:a17:903:1aac:b0:234:aa98:7d3e with SMTP id d9443c01a7336-2382403df49mr113894545ad.29.1750930244680;
        Thu, 26 Jun 2025 02:30:44 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8752146sm157903605ad.252.2025.06.26.02.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:30:43 -0700 (PDT)
Message-ID: <4a604550-aa8e-4d91-9daa-91e8089fe9c6@gmail.com>
Date: Thu, 26 Jun 2025 06:30:40 -0300
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
Hi,
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
I understand. The problem is: with NO-IR set, we can't configure an AP, 
since the AP is the initial radiator.

So we just could remove NO-IR so we can create and use APs in this range?

In this case, I will create a v3 of the patch that just removes NO-IR 
and keeps the documentation links as is.

Please let me know what you think.

Marcos.
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


