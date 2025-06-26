Return-Path: <linux-wireless+bounces-24527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC5AE989D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8FC6A101F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E443291C07;
	Thu, 26 Jun 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1/5wnsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B3219E0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927059; cv=none; b=PzBT+ZUPdqVEBhoEjCDViw3l8VbMpVChyS1Cz8vSdGsDptcWWtHbrvHJ327i4YXq1vipFi/TzBuTxd74jV75BgkIbDamIMxk8fgZhN9jR7O4qlc7+YVSYWclPTZiQScMbCUoGFEHO7kRFaP23U5glpUxVy+nFsZFOEjvsK5INqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927059; c=relaxed/simple;
	bh=EAPC0aKmwEMvCcax/Y7pN4mvHg03YJLT1ijfvSz3Ueo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caD5oTitgg8Jb8+enGVj1AkW7LBbbgskLeHDOtxCL3YOeCKsKt6npFZACeYLAt4xciZxPs7+tBCclycBUsg6EO3UPWeFra3b5biH1KRVJSUDsZZn2zJ6qA0D4ANU3ms84VyK3CNktQLrtw9b7E2NQjPZS2TdtAlzzRNjWSFRz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1/5wnsG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af51596da56so579126a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927057; x=1751531857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDl+HjQKNblyTENuKkC8aXRjpJuMBJaBTg0TQtM+X6g=;
        b=A1/5wnsGzBwvqpteCJuoVJyWiij31XlCgEM/FiQcKpPJ076IZrS/XSbKsOzNh6Nsp6
         LFrSdr3LRi7/okSxNNeKpMWKZeC5MXzbMWzxU600sUuu5Y0SBjpTpGLOEofEJpK/pvdJ
         Orl7rLOwcFdx+2PPg0Q5VvBwpx1+EkTtU3PLLE1j6hTR5IW+PLcop114odG810H1b/pU
         qYG5Di3pfmc3/69f+GAahEziZGPsEDzQBYqZzZ2xKiUApij4SoaAOeKCe+TWjflqc5sq
         Fk4Stok6H4JoSQEZ6wCcGX2xCAi8Dar/lgRgvg1GgnCLZs5PT4YzDM4fTIYjIJ1sl4nV
         ZJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927057; x=1751531857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDl+HjQKNblyTENuKkC8aXRjpJuMBJaBTg0TQtM+X6g=;
        b=EwAWAfwx+u8Sp3nuxUR0OEofHjc89rIWM2wuGb3hzP05+GcsqMSu7TfwuhFJHcsmqZ
         l4sOAghf1q8bO8ySeJpu1FdvVUy2uH/RjUOrNew14ORyTs3sOI6U/amZUnYsN5FfOXUB
         pQ4soRQGEpk4MCPYtWctRenQGDKegFJrTdhyiQzexTz2Na8HOUUR5gz+6PnfKL5R/Rj/
         tlBfOCKaHRoYRSEsqXqOkYcDJq/dp2nJjWXNyKOEUWt15TLS8U8TjFInuCwCaO1R3owJ
         +gbz4MU5hRQuXEazUsiYKAQ/a+sQHjkIgmnA3b+P7nb531ACEj7sUSo898q9NoP35cHV
         Cgrg==
X-Gm-Message-State: AOJu0Yzrce9dAZmZ1+Dmat0+s9BmsuUfTqXWuaklOx94TOkKxbX6c2vR
	GAi4UVEbTPT/m8CXI5K6V144XLv++PoIe0C3DU3C/PArSoS0IKei4N73IQKABzf2
X-Gm-Gg: ASbGncteaHTH1l5Vc/ICjlEUfxpIPNqODpGy8L9ZLxVHqHAefjLuDx8WaeSDY7y2+Gz
	+nUAqy57FdfCmt/dgsOO4Ap1SAeWXvBrpjx+svtiekJ4xnM82dANIv0WedvqHbQc/1wfjw52UOA
	NL1aw1gIzg7QBdXYDGdUl6jZfg/ZNtzxUP7uXyWh3WAVIzjmyTuWGw3KuXno+cskqkgkCOaKgLf
	wuLJSMUqqwfZE+CIfLTCqaoS1FRagErOzANOp/OUw+ZSXZr44s6LHGAmDNKRvSkn+8Xc84nHmlQ
	nrOB+a7h2aRcU241XFDR0HrQHQnRLJ8z2k4+m3jvylo5aNqt9trmwzXXTaLaYLhBHVQFLbTWM1d
	dmcDICkSVyk3U0zpxrXe5tXE1hHU2nsd+Tvlnrw==
X-Google-Smtp-Source: AGHT+IGGI6j+XWoUEwc2yyqWgS4iONzHoahjfEhD/mKHPQcivQf6GhaO+Paty0zfnbLFeWS5rNokSg==
X-Received: by 2002:a17:90b:5548:b0:313:28f1:fc1b with SMTP id 98e67ed59e1d1-315f25e0325mr9102336a91.9.1750927056855;
        Thu, 26 Jun 2025 01:37:36 -0700 (PDT)
Received: from ?IPV6:2804:d51:4975:7202:7e03:331b:6be0:eea6? ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53a6f47sm3762243a91.14.2025.06.26.01.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:37:36 -0700 (PDT)
Message-ID: <ee7a2587-3e4c-4bb2-8eeb-961dbbb9ca97@gmail.com>
Date: Thu, 26 Jun 2025 05:37:33 -0300
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
From: Marcos Alano <marcoshalano@gmail.com>
In-Reply-To: <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 05:15, Chen-Yu Tsai wrote:
> On Mon, Jun 2, 2025 at 9:23 AM Marcos Alano <marcoshalano@gmail.com> wrote:
>>
>> Hi,
>>
>> The rules for Brazil were based on this normative
>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680,
>> as mentioned in the comments of the entry.
>>
>> This January came out a newer normative
>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772,
>>
>> It allows 6GHz frequencies, so the line:
>> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
>> Should change for, at least:
>> (5925 - 7125 @ 320), (12), NO-OUTDOOR
>> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't
>> work because of this outdated rule based on an outdated normative.
> 
> Those are very large documents. Could you help point out which sections
> or comments apply to your argument?

https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915: 
in the items IX.4 and IX.5 mentions the 6GHz frequency.
https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772: 
You can search for "5925-6700" to check how the allocation is done.
It mentions satellites, so that's why I set indoors, but maybe you 
understand that is not necessary.

Marcos.


> 
> Thanks
> ChenYu
> 
>> I'm no lawyer, so please if you see something different, like more
>> granular control in the allowed frequencies, please let us know.
>>
>> Thanks,
>> --
>> Marcos Alano
>>
>>

-- 
Marcos Alano


