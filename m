Return-Path: <linux-wireless+bounces-24525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB8AE9848
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3203B61EE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48621206F23;
	Thu, 26 Jun 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRp1h5yj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4025A65C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926437; cv=none; b=opgrvLdW36hzEnmRuTg+jpid0ZmFkQdLzRJumGq2VYpENyErTUqznaVpcVwQJQrq9VlCY2jvUnuy76PkJHJZiVmTf46ra7kUkED+Y9xSux8pZU5z5JMCOqU9VYdRI4ixoE0miStH+0gFb2Y01LWtenbW2cUwpbvUaphjxeGCSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926437; c=relaxed/simple;
	bh=ckd0GlwWLs0d33EZzMA60VfoCwiHb7tAei/jeOLSky0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYMkijAA3kUnV73s6kgMSLy5qfGKCqeZmbVaaA8NyxsXUauFdrLiQm7GqQDiwIDcr8T33yFAjmSN91cHd4VF3eb6zTX3b9xLL7lNPofOkgwEESYTvt+LyrW52ntUdl3/R6iC0a3EC2UPCkWy9YimQbsnKdXnSuAF8tDjxLMtZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRp1h5yj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso1105176b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750926435; x=1751531235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r44Ps5HqcvcXd12Bv7YuHRDLW7HVn7gJJ8BWHLqEXCo=;
        b=NRp1h5yjU1xc80gpOqtKG0+gSkfehbBFTDczIP3t/D82ET6BBDe2vvdmUx2Nxcq1lk
         sf0ytDBN/R/D1kJ2aKmpLn3qnyBH8NFaYo43oV9gXkqFSpJHNj+7Zu6N3SG2ojZkvSb9
         nvrAZzI1xdyWvLYkhVAyEt0+1N8VoZIskZOfM6zMD88gn7c0nUz1W9VFkk0xRdo35QfC
         cXPxiwbYIMWmh/r19rdY2ALSNgFJ1aXt8G+utJOcVwOpg78yHZs2AgxNPh0jLz4QVYGg
         nLjYzZwgWqq3pt7+nczs/tCUGrxBtBnDnk+uHXX3B6Wq8SUH1lu59zaqXrmHcSOW5B/t
         KZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750926435; x=1751531235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r44Ps5HqcvcXd12Bv7YuHRDLW7HVn7gJJ8BWHLqEXCo=;
        b=JMUHOnjzsbzdtGZi2I6zNmKxtm/EXzc0hCQHXgrXUiBccSyjiVzs7/9E75Ej96lyap
         JYGnOn3auAK9X9ilbasyB1gF6WOR69kPF0P7D1KIvq4DKbTKOgbbcuDhsNtkIYdaLwuk
         M745/WLUeMhPXva+5ZXI70Ta+EPXKYPlR0tkgLBEXD/3F3mKBn/x/Gd++giNLymwOFqx
         w+AASG/nxYVngLTp0aZQXtVLC3k2Bp7GL5njAqTDjcnQ3d9xQ3rlmGkUjjvw1DOU88BL
         9xgstwm8UzP3j0lJl66l4buLPuq78iq8yEdJGHfm/mJJZbrgPkARlqxt8yliU3Npf+0h
         zxOQ==
X-Gm-Message-State: AOJu0Yyez9Pqi2t5Rir8jXV4C5g4pW42C7DMSZMWEYJX4y1vB6NI7N7w
	5kJVs7A/uUDjixiCrr7+wstyc+YBedrjGSCizDiJOwYe50zy9mGiCeAo
X-Gm-Gg: ASbGncslcIRZ+gzXAmvRJtiZ4mQ7azaLFhh7KnzhDJWBDKlFvii7z6765CFpf6Lst87
	3f6cfkucyrGO6SGv6gVv5rr8mVOWjHz3yiNyvpNmbziqKeXR9ueVrvM2vBfsvig2JozOeYxoI+0
	4JQFz/iK023rFTfg+7MYO5GHQAmzaosmM/gdN3o2OU7xHLOIubUGGH0z1XDARMxAetPuNtdmNTj
	L67ZHT08b8uxV5vk2pZpaLav2eMLqAVXY+kYMuevhBQJIV24s7HiSc9LCGNAA0BiPHhYZ0krWGs
	6b1VUR208V9P7lDJT1tiRGoJ2/72r4h4uoXWTpFwY2qL2C2Vkg9p8xTUfidu1YCYotyOGA+2tYh
	O4LC6FEns44EVwUwOnXPW1B0nWcdjtCaSkW5nig==
X-Google-Smtp-Source: AGHT+IEiHwZoRdxmeyDqqEk5iNn/sTySGGYhVTyXP+TA9IALmRWdoU/A9ILuHjZO/XP1IKMFQaIFXg==
X-Received: by 2002:a05:6a00:9a9:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-74ad445badamr8669777b3a.1.1750926434952;
        Thu, 26 Jun 2025 01:27:14 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88721b9sm6390260b3a.150.2025.06.26.01.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:27:14 -0700 (PDT)
Message-ID: <a5d676db-20e2-476a-aa75-53e2c99629e1@gmail.com>
Date: Thu, 26 Jun 2025 05:27:11 -0300
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
From: Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 05:12, Chen-Yu Tsai wrote:
> On Mon, Jun 2, 2025 at 8:15 PM Marcos Alano <marcoshalano@gmail.com> wrote:
>>
>> Change rules for 6GHz on Brazil removing `NO-IR` and adding
>> `AUTO-BW` so the 6GHz band can be used.
> 
> AUTO-BW is not needed since there are no adjacent bands that can be
> combined.
> 
Ok. I thought it was about the range selection, like if there is no 
320MHz available, it would choose 160MHz.

I will remove then.

Marcos.
>> Add the relevant normatives in comments.
>>
>> Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
>> ---
>>   db.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/db.txt b/db.txt
>> index e331d4f..3b0adbb 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -321,8 +321,8 @@ country BO: DFS-JP
>>
>>   # Source:
>>   # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
>> -# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
>> -# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
>> +# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
>> +# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
>>   country BR: DFS-FCC
>>          (2400 - 2483.5 @ 40), (30)
>>          # The next three ranges have been reduced by 3dB, could be increased
>> @@ -331,7 +331,7 @@ country BR: DFS-FCC
>>          (5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
>>          (5470 - 5725 @ 160), (27), DFS, AUTO-BW
>>          (5725 - 5850 @ 80), (30), AUTO-BW
>> -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
>> +       (5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
>>          # EIRP=40dBm (43dBm peak)
>>          (57000 - 71000 @ 2160), (40)
>>
>> --
>> 2.49.0
>>
>>

-- 
Marcos Alano


