Return-Path: <linux-wireless+bounces-9455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024091345B
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29C41F234FF
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3516F26C;
	Sat, 22 Jun 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go0XVUAA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65579FE;
	Sat, 22 Jun 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719065262; cv=none; b=ef7/WVcrBhoVinsHzTQxWnpUHO6vlkCm3102hoSmZLkfU3bRuSEW82AENkeLWiFo3yh5BycZjZzfwL8RYrk6E9FATjtqZUdXb0es47HSahI77vXJZ+u1sKRnBF8o+3vOb9f/68gOI+M4VHFgfa7rwyIZaVxQ1YvtOZRSW2GB6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719065262; c=relaxed/simple;
	bh=qZ69BoS6fsBopPZdevAkHDsYA/iI06IZOhkw39qW2Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a+AJg7OYay1q9RjNoWytfNU2M6UV4V6+P/SHoAXNvQzNfPyn6y9mtwKKEtF4mTRbf4+VYKaXBtE63A4YsjOzgCQSZZ/icqQDMLbEfXGWcVurq23C/a8p9O808rONKpIqAIRV2fOV2yi7bIOrL0abifkYPYvjHMvGwbsQnpq6lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go0XVUAA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaaa6so415772066b.2;
        Sat, 22 Jun 2024 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719065259; x=1719670059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thH1Pr6dX+Q8kkJ5omnlnmrOhD3hsrzwW3iGCChkDi4=;
        b=Go0XVUAA5I+b8xZKKpe1pPIST7gATs3iFdgPx/wja/05oIpJlBeUWxwuOQ16t+PVy9
         5uZ7P8rXlZHaqrE+DGh7n6jvwrQ6GqjXbSgXQPWKvN2rxAj+SD0TKq2MO9QDJS+mSupK
         Ea+JyjYQArkv/bwf1qadeVqhWHwhkvrK4Byo06xvMyOaROD0Wov9fKf3ZSv+EwhpTtce
         EtGaYbyTLijHXTN1bAebhEQFQronfpw21CUE4sBERPqXbZKv6sEF5bnCHWNSbDdTn0sP
         /0LnVyRNGUSMjG2AIx4KsQ4/h5X7mP/6rbtxD9FNxFMxQ+f4T20dCDt7jR/hWkgKalX3
         ZFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719065259; x=1719670059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thH1Pr6dX+Q8kkJ5omnlnmrOhD3hsrzwW3iGCChkDi4=;
        b=ilfHeHVUBHSdVjGrFxwm/ckZbCfJlwIK0J6IhwbFVrA3J/i+M0oWAfEqdaBZLz1d/u
         cdki7pajnpmJXrH6FDz+8ZM7tsAxHrjQqMpkKYhxgyYa3fpmdgqsn1d7I4cD+iCsQBSg
         /uEWwmxqjLh0mtTa6hwOPlVy/TKYyv5XYajsBZ98014N4k8R+K4JXM/QHvuHYYWaIJsm
         /9EMRityqDW8bCMdznQhovvMc1KK6aQ7WufoIfzxLMQC6KskmfnsLjUC5lji/KrzrOAG
         /4yEKqsj4mx6171EKJKItxYScDwUsug9EsTRVSv9xw6pienx+alfiMU6F0sZ5TdF6bzA
         wguw==
X-Forwarded-Encrypted: i=1; AJvYcCV/KMq8qp2BCSxD2tzFNYTsd5OTB586L6MDuH67Z7MJEIYsIc2wgnfw5mtAwwrqf3K2uHcQl6YYudlVj9N2WgNmdTY674DwDme4T3x4uQAUaxvSB2k0TPi9CjGWiHsLG/5pZBVKjZcCyhulJi4=
X-Gm-Message-State: AOJu0Yzq+YqoXMwzddvT5EM8SDW3vJ8WJ1XqsnKOdkzVG3Qaaxdchfj8
	USbEO6nBYPy7jldkbz43Z+6kOPQs4zS9WdNBangEdD2P4qSc4H8=
X-Google-Smtp-Source: AGHT+IGLW5AbuBjd06LIvqUm9HuLBn2tIrCrY5ppWmKqqYQchEPKqkeHDut98ekeie6/0WqiJR4AiA==
X-Received: by 2002:a17:907:d406:b0:a6f:68b6:4e75 with SMTP id a640c23a62f3a-a6fab60ba77mr680327266b.5.1719065258320;
        Sat, 22 Jun 2024 07:07:38 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:818f:ca1:d4f4:472d? ([2a02:810b:f40:4600:818f:ca1:d4f4:472d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe4eeb106sm80483366b.167.2024.06.22.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 07:07:38 -0700 (PDT)
Message-ID: <f81489b4-ed60-43df-826a-1f9593802be8@gmail.com>
Date: Sat, 22 Jun 2024 16:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: of: Support interrupts-extended
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20240621225558.280462-1-knaerzche@gmail.com>
 <190402b87a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <19040354ba8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <19040354ba8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 22.06.24 um 15:49 schrieb Arend Van Spriel:
> On June 22, 2024 3:38:32 PM Arend Van Spriel 
> <arend.vanspriel@broadcom.com> wrote:
>
>> On June 22, 2024 12:56:02 AM Alex Bee <knaerzche@gmail.com> wrote:
>>
>>> This "new" version of defining external interrupts is around for a very
>>> long time now and supported and preferred by irq_of_parse_and_map
>>> respectively of_irq_parse_one.
>>>
>>> Support it in brcmfmac as well by checking if either "interrupts" or
>>> "interrupts-extended" property exists as indication if 
>>> irq_of_parse_and_map
>>> should be called.
>>
>> All very interesting, but why should we add code for something that 
>> is not
>> specified in the bindings documentation?
>>
>> NAK (for now). Feel free to update the bindings document.
>
Sure, if you insist on it, I can update the bindings document. So far not
many (no) users did that, as it is clearly specified as an alternative in
devicetree/bindings/interrupt-controller/interrupts.txt (sure, it's not yet
converted to yaml yet).
> So looked up the interrupts-extended definition:
>
> The "interrupts-extended" property is a special form; useful when a 
> node needs
> to reference multiple interrupt parents or a different interrupt 
> parent than
> the inherited one. Each entry in this property contains both the 
> parent phandle
> and the interrupt specifier.
>
They point in this particular case is not how many interrupts exsist, but
"... or a different interrupt parent than
the inherited ..." which is almost always the case for brcmfmac, as it
usually specifies a gpio controller as interrupt parent. So:

...
         interrupt-parent = <&gpio0>;
         interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
...

gets to (a single line):
...
     interrupts-extended:  = <&gpio0 RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
...

Which is a much nicer form, imho.
And by the way for instance
arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts already uses it that way
and the interrupt will currently not picked up (at least not by this
driver).

Alex

> Given that brcmfmac device will only have one interrupt item defined 
> there is no need to use it. If someone can give a good argument to 
> support it please chime in.
>
> Regards,
> Arend
>
>
>

