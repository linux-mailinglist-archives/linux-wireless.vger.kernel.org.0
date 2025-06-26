Return-Path: <linux-wireless+bounces-24537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0120AE9A7D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08119168185
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534562BDC37;
	Thu, 26 Jun 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ1bextS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD229C35F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931771; cv=none; b=H5Px+S/c7nDIBnHlluAtGKSehZs83oAJN7tLyf5s8esh5hR8tkGcON0uXMEJatwMA8cbEdw/nkwQLoBSc5IrmQO0NH5nqXjjSfS6YsDscw4igW0I5gcKlq6thM3k+r75wSkzQQkzNRjv/mKtOZCVHxjqtHeU9E6AZ1eb6GrEZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931771; c=relaxed/simple;
	bh=vrrVs3SZqrtBkif6E+GCUq0NVKUVvKIxlBQo/oxLmH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2xGgxs71uVBe9M4R/Bd0fHENkBGYrKkpAmlWD43VGAUriiLXg2zp+CYgcO9hG5dbAupBxXvpWnNfCUGGVYLQNNoOb1bLocccsNF9oBcwT1syl4qsZlohfFjJL6228S32wxynrZFFP0OKg2Y/MASbwkVYjmeMryj351wpgvFIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ1bextS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234f17910d8so8227455ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750931769; x=1751536569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37koSnKgU7hvKQYo2n96QVYEhjOgjKih/EBKKAgCbs4=;
        b=DZ1bextSob0iL+0oUGJyLqkTcW+qarMXM3wozz5gcwts3GRzcMiYlN5eejzUFLxraZ
         ZMCLaL5b88xh++roXCw/yU6OBlt8PasljYyb/VIMeIc0AdVLK2ETJtjHVg5HYZW5LCFo
         iuuiT/WA9QpWPv9PM2A15kuvVapZtrizIZUeNdoIMPm3KaQQ5ZSGlMXuI7ZUVTjekLnj
         57eiQL/46ogxUQk3qphptdC1Oo0+jkXtRoo5C24yVX4OriPTGqZLHiapqZFrnejQGiQ4
         l2RiJ8yC/9HB5CUMipiRIPatlqJqtG9qnk04qRMk3zacdO6+LYA/0x2R3DWFC+34rCiH
         wfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750931769; x=1751536569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37koSnKgU7hvKQYo2n96QVYEhjOgjKih/EBKKAgCbs4=;
        b=j7Rd2xb1Uo6TSn/5bDXskzQdgve6OjxPY4Eo13mAKGeTr57Ky1T8Pz7fWz44vcCVVm
         XXFp9RRN5gkgu2xH8ltIYatzY9bQiwh1b2aSMRslT55iHMt61QrkBnjOrIjZDyxcjM65
         Xywne6P/Y69hjRlKg0XK/JLwtvnPA1HHxY+8Y6SCItKnEN+O78eSct7Rr/kC7Eexppy0
         03rM8l9rPkAtQ7PlK8XOQOoJIBhhykBQZNx1hQXdSnozdEMMNr7ZSsXDq+Dxi3xHhaa7
         4kSOHq45ISIj7K7M1m8wZI5UAfMDCKaF1MahBmTH/yD2VStk5PK9e7dQTR77JsG6BJHO
         R2GA==
X-Gm-Message-State: AOJu0Yzq+kMoF0T+zIHfvwUlGh8ET4Ox6QWqm6JM2Z6UlTq4UMAuSGC8
	jPslsqvudTNoY4yzuEWq6vjScDGl4ShSExVEnf7yBxGEobQy7HmkymKw
X-Gm-Gg: ASbGncsZ5OBsFXj9pewqucD7moH9IeEKHkvhp9vl912cBAX6N2jFGDn19td8KydxJSe
	R7ir7Zx2tD6nGoy/ckRvFb3qRKdsYhRyej7o+flQMIW8Sky6Szgs4BtoilFs2amUV9bLUezCXjU
	NyPOEZ7fvkp1hA4ZjDfoX/udiq3beOnLNo4G34xyuFwkZV0SSsalMLE+HhcjiJHKO23smpzZjka
	ziaQvbE+/5eIlv1KRhzRY8Tb6uysUhtwa+niMMLB9cz/OEkJxZ2xnjqrVI5Ek5dfRKfiBp2LAri
	SfVln0TL3x7bbS16E8OC4I4pRFjKHzRJziOour1qg8pqqll6gkc46YUEM5PgcOjAoANk7T8kH3f
	FRdC7aZurS9ZrzUu+o5QwY+V0Z/Kr0oe2ukB10A==
X-Google-Smtp-Source: AGHT+IEMYT2m1/4OY42gRrv08XFk24ea9yFOUWIux+JsIeLqU2Vjysir8YigFi2HW8kVa7afDe4ijg==
X-Received: by 2002:a17:903:2bcb:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-238240f5674mr92109895ad.21.1750931769058;
        Thu, 26 Jun 2025 02:56:09 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a36dsm153819385ad.126.2025.06.26.02.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:56:08 -0700 (PDT)
Message-ID: <46ab2a6b-82ff-4330-819e-99a67280409a@gmail.com>
Date: Thu, 26 Jun 2025 06:56:05 -0300
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
> ChenYu

I created a v3 patch that updates the comments with the new normative 
you found, removes the NO-IR so a AP can work correctly, and changed the 
maximum power from 12 to 27, since for APs it seems to mention 30dBm, 
but I considered TPC like the other frequencies.

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


