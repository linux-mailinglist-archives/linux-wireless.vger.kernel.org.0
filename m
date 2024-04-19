Return-Path: <linux-wireless+bounces-6566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE28AADEF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650F01F21C85
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC37FBDF;
	Fri, 19 Apr 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irTPkShw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABE7C0AA
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527738; cv=none; b=dBrNNDENEuGb7x/yepTdrKVY6UMwV8eU+l3a2K//nhO3xe8+BqZsgW20Bzao2FVs/PnXcBHiyxzhkVSGFH+T9wD4Xva5W+W/zTJ9PGdNu1jw2QMWnoZ2V7L5bl9UNt34khOZihvtDa2BQPYNOHI76MuGezF0Io+NazQ80zHBDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527738; c=relaxed/simple;
	bh=gSk03/47gpurB1tEuVFbr4WxWzN2CMe+pZDUUF2jNEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZxLpMg/epdkGLpw1OIXDM3S8GBmHM3hmJz0cLl02HZVySoWE0D/41u/2WvOg1U9j1XdXAPD86LchDg2KQ+OXP+etp8BWQqlNn3ULagUWNoMDF+Idmu30vmlwxMNQ+VtGy5n0JQB2TmCGhxvMOuGKVmMqnxUgV+N3QyuKdmi1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irTPkShw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db13ca0363so31706921fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713527735; x=1714132535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxgAgUshsPV0hAKrk6LLHPMJ0hjXvtsTIwxjKylfosU=;
        b=irTPkShw8f66yOQfigevOQ66TjZFbGVYA92aNkW3W9cr9FwV0QmycraKnG0XBl9gg0
         YOAah7iZJdESZ/jq/5v1k7etsVwZQSfx425DxglRxiJBo09PU5OwiJpozXSsg+dL75Wl
         1BOTwJSkZd3x94MpTd4EMs0Oah/aE8G6I+CBfvUPNA0ygcqeGbBiehv8I4PMXl81XoQH
         3ElfKfp6R6x02MhgQ79QoG2q0uittSoEyp0R92c6Th8uHHj8CtxMvb8dAJXTTFyLNAuI
         oxGyt3QJkvp39z79SXIVjiXPU9KduCG8aubOi4sJ2oZZZES/jOBVowiMsXSbRK4NroXC
         FfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527735; x=1714132535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxgAgUshsPV0hAKrk6LLHPMJ0hjXvtsTIwxjKylfosU=;
        b=dEaY5b+0wPr6pfr/MAlM3T0De87RAmEuOa/sOA02YYNjBJBx7+/0d4tonKe63oBvNV
         t4EsLj3eJl1SCnI6zkOqoBhZjIVIkEvXb4WEChYzkE2s6P2f6Z705wx2SqyIiswIqWJV
         d5w+qJO5KxsmG4Dqo4PSOycJY80N9OnxhsN1gNXduemW+gtXi4ASdrPPJp1c+75x83xI
         SRBBZWdY0bPcRHeFjRz8sEa9kJ7E0IULLfXi5RsDZYocwU7AAHI0FHND9z1S8itMcfRE
         DxXD4bGlVFjLqqk1erpoJh/nOWtdMy5eqLWzNhpBWOsjBg+HIZyCwVhyzwr8yGnGgiXi
         MALA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Q66dT2a4J0EXuRhnTLi4RPPhgrvE4g61/Z02j6kgPqGjnVLSUQX0s9gPPAxUSiDp0uTTn32Gf3p9rNWma7NUBM98tU5R5N5nIA0+Cs8=
X-Gm-Message-State: AOJu0YwThBLntwl6gQfILuxG15kmieaNfB+nroSR34Z1G8kTox45ssxx
	L+C/THicN57Wi0+wAMB4c2Nc4YaxaEBGNTUHijqnvuIVJJXMrMNt
X-Google-Smtp-Source: AGHT+IFJkWWN/UXndCJLw7eDN5RZdOqn3lJAaiZMPAghqb8nH0jQ5kqw9EPDQE4z6xB0dewnPYAAFg==
X-Received: by 2002:a2e:a26a:0:b0:2d6:f5c6:e5a1 with SMTP id k10-20020a2ea26a000000b002d6f5c6e5a1mr1337745ljm.12.1713527734671;
        Fri, 19 Apr 2024 04:55:34 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b00a5546604a5asm2105922ejc.104.2024.04.19.04.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:55:34 -0700 (PDT)
Message-ID: <d809f1c2-f27a-4bea-aa11-3cd598222047@gmail.com>
Date: Fri, 19 Apr 2024 14:55:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Add separate MAC init table for
 RTL8192CU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
References: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
 <a9ede460e23e476b97da9f71c026b88c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <a9ede460e23e476b97da9f71c026b88c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 05:44, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Until now RTL8192CU family was using the MAC init table from RTL8723AU,
>> but these tables are not identical in the two vendor drivers. Import
>> the correct table for RTL8192CU.
> 
> I believe you have tested on real hardware. Can you list the hardware you
> tested in commit message? I can add them during committing, or sending v2
> is also fine.
> 

I tested with the Netcore NW362 (RTL8192CU).

> 
>>
>> Also move the existing MAC init table to rtl8xxxu_8723a.c, which is
>> the only remaining user.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 


