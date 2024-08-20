Return-Path: <linux-wireless+bounces-11713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC796958E9A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6DBB22018
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12D159565;
	Tue, 20 Aug 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S4DlVi2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACC1586D0
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182150; cv=none; b=sm5AJGQc1Wlit9uwuO0j0fH7UsqyAYBa/arXnwhtJWB+6eVAuiQq0Iop/ISK9r9k/a9G3Vr3XUAYDeXAMHaHpmBWTRScPJ/7p1GKudQkaN1KHUbUiPlaSTu0dmOVseAk2QWrE/7kn3jCJPbKiC0fo1R5boROdaUUGOW4BhB/z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182150; c=relaxed/simple;
	bh=nkztriO5ncOopO1bCqSXWB1dmOlVcsUrq3rLjG3Z/Ac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S02qdov1mUSvmFpoeRBjtWBl1TdshskMsWd6DOOQ7fk/3s3ZpnQGSPEVE+hkYq2/Lg4E3WZPMFtyofYZFCnQpAuQD15N/g3P/z+Vdn+pY9+MHwmS3ZdPTc7KNM/tWEv5VVZ5gFOzQFrvNDByYB+PNy3G5xfGn9UIvxAW9NUagUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S4DlVi2y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-713dc00ce9dso2998907b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724182148; x=1724786948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l81pAQjBHLXNFpoEW8MtyifMexRTjZ/ULjZ+A797XtA=;
        b=S4DlVi2yKXOQ4K0z07jJ973cKi/NLJEPZb//Y3t3uO/F77brCq6Ve/XZR0PpT33Ju9
         Fbxw+R19LZxImPUe1ZGfvoo7I6XZQORsLZNkTPGlO5uQo3km9aC2lYQZNVkbidgqiItk
         CmEW7gzZ2F7GMXAI8I5UjJDOx/An+Eu2Uqe9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724182148; x=1724786948;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l81pAQjBHLXNFpoEW8MtyifMexRTjZ/ULjZ+A797XtA=;
        b=HDvbHCR/MHNTFmWPW6ojPXEwm1vm1BeM7trQGoZOisfijDrZBx+c+xMp+/vd7XLhSw
         +EsxodPYmT5G+UY9E/FAGdCTTx7K+awOBuoksO01HTY34XeXWfRccUqBiToA4m/mYFpC
         6/WH7LQPivid93IQv50Mk7knlEhKqbWThq/jHQw3GIrR9iNhn22RQ0GQGBGmwoxunUc2
         U9eXEu/GyOUmZaMsd2iqNstHlQgS1M8loT34vjWNPmYAtELQe1szyy9jCiKN/l04xc70
         GNqy3jDUhiFZ2ZN13J1ol/684S+jN+puAO+sOtjvM5FCOw13Xq51JypyJvVdkNa4Z2i8
         n67Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaRzjv9FFP2YZeeisukb5j4bM+M02JLCOm9me8ImvMx0EMFNlAXo3S86Sd1y8kQ0A4UY62dHK5H3mvbV/lWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRIsKu/jz/57ew5UbCBDeFdPM3bD7tg/L5GFhbJDQrPByQi3H
	aKxdVVvnRSqE87nqudaZNLID7XU0QTm9GeckTRAgvOnZ3Uffo0X3ZQO1a9TbaA==
X-Google-Smtp-Source: AGHT+IHS+gA0HocLOXtpTfDU/Qw188AgrdLJnRT82VxAq5j6Gjf8jCn+lYyCmvwYFA+5CKEhrt0/yw==
X-Received: by 2002:aa7:88c3:0:b0:714:1311:cd24 with SMTP id d2e1a72fcca58-7142374a56bmr91831b3a.5.1724182147435;
        Tue, 20 Aug 2024 12:29:07 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-713f376821csm3682083b3a.152.2024.08.20.12.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:29:06 -0700 (PDT)
Message-ID: <f7c17dff-fd64-4769-9fc4-7ff929a2c5d8@broadcom.com>
Date: Tue, 20 Aug 2024 21:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 asahi@lists.linux.dev
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
 <mbvhz3wosnykejgs65es2sfedxoevysbqu3jxmpgdze2b2tl6o@grx4mxas2bmf>
 <7881c303-bef1-403a-aa70-30d33558f57f@kernel.org>
 <6777d425-b27f-43d0-ba81-b36ac0b8f929@broadcom.com>
 <0b639d04-af33-44b0-a556-40decff683c5@kernel.org>
 <3ed394a3-2b5e-4096-b090-c805657585a3@kernel.org>
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <3ed394a3-2b5e-4096-b090-c805657585a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On August 20, 2024 5:51:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 20/08/2024 17:36, Krzysztof Kozlowski wrote:
>> On 20/08/2024 14:50, Arend van Spriel wrote:
>>> On 8/20/2024 1:39 PM, Krzysztof Kozlowski wrote:
>>>> On 20/08/2024 13:27, Krzysztof Kozlowski wrote:
>>>>> On Tue, Aug 20, 2024 at 12:12:15PM +0200, Arend van Spriel wrote:
>>>>>> When extending the bindings for Apple PCIe devices the compatible property
>>>>>> specification was changed. However, it was changed such that for these
>>>>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
>>>>>> string in the compatible list property as it was before that extension.
>>>>>
>>>>> Apart that this was never tested... That statement is not true. Look at
>>>>> "fixed" commit - it is not doing like that at all.
>>>>>
>>>>> I don't understand the reasoning.
>>>>>
>>>>>> This patch restores that constraint.
>>>>>>
>>>>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties 
>>>>>> & chips")
>>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>> ---
>>>>>> .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>>>>>> 1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git 
>>>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml 
>>>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>> index e564f20d8f41..47f90446322f 100644
>>>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
>>>>>>
>>>>>> maintainers:
>>>>>> -  - Arend van Spriel <arend@broadcom.com>
>>>>>> +  - Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>>
>>>>>> description:
>>>>>> The Broadcom Single chip MAC part for the BCM4329 family and
>>>>>> @@ -27,7 +27,6 @@ properties:
>>>>>>            - brcm,bcm4341b0-fmac
>>>>>>            - brcm,bcm4341b4-fmac
>>>>>>            - brcm,bcm4341b5-fmac
>>>>>> -              - brcm,bcm4329-fmac
>>>>>>            - brcm,bcm4330-fmac
>>>>>>            - brcm,bcm4334-fmac
>>>>>>            - brcm,bcm43340-fmac
>>>>>> @@ -46,13 +45,15 @@ properties:
>>>>>>            - cypress,cyw43012-fmac
>>>>>>            - infineon,cyw43439-fmac
>>>>>>        - const: brcm,bcm4329-fmac
>>>>>> -      - enum:
>>>>>> -          - brcm,bcm4329-fmac
>>>>>> -          - pci14e4,43dc  # BCM4355
>>>>>> -          - pci14e4,4464  # BCM4364
>>>>>> -          - pci14e4,4488  # BCM4377
>>>>>> -          - pci14e4,4425  # BCM4378
>>>>>> -          - pci14e4,4433  # BCM4387
>>>>>> +    - items:
>>>>>> +          - enum:
>>>>>> +              - pci14e4,43dc  # BCM4355
>>>>>> +              - pci14e4,4464  # BCM4364
>>>>>> +              - pci14e4,4488  # BCM4377
>>>>>> +              - pci14e4,4425  # BCM4378
>>>>>> +              - pci14e4,4433  # BCM4387
>>>>>> +          - const: brcm,bcm4329-fmac
>>>>>> +    - const: brcm,bcm4329-fmac
>>>>>
>>>>> And this does not make sense... You claim that some constrained was
>>>>> droppped and you re-add it, but in fact you still add the same code as
>>>>> it was before.
>>>>>
>>>>> NAK.
>>>>
>>>> Ah, the last "const" actually makes sense, I missed that.
>>>>
>>>> Commit still however lacks rationale why these devices are compatible.
>>>> Plus existing rationale that e2e37224e8b3 changed something is entirely
>>>> WRONG. It changed nothing. ZERO. It only added new devices, which was
>>>> claimed are not compatible with brcm,bcm4329-fmac.
>>>
>>> So is that claim true? What does it mean that these new devices are not
>>> compatible. If they are they should be in a separate binding or the
>>
>> Whether binding is separate or not, is just way of organizing things.
>>
>>> applicable properties for these devices should be made conditional.
>>
>> Could be if they are not applicable.
>>
>>>
>>>> Now if you claim that original commit which said "these devices are not
>>>> compatible with brcm,bcm4329-fmac", then please provide arguments, not
>>>> just say "other commit did something". It did nothing...
>>>
>>> Not entirely true. Indeed new devices were added for which no
>>> "brcm,bcm4329-fmac" string is required in the compatible property. Also
>>> the commit added new properties for these new devices. Now in my opinion
>>> a driver should not use these properties without a "compatible" check.
>>> Hope we can agree to that. However, the driver patch for supporting the
>>
>> Sorry, I don't follow. Why the driver would need to check for compatible?
>>
>>> binding change does no such thing. So if we leave the binding as it
>>> currently is the driver will have to check if compatible has any of the
>>> listed PCI IDs before processing the properties. As all properties old
>>
>> Why driver needs to check it? Are these properties not valid?

How would the driver know other than the compatible property? The node 
with properties is delivered by the bus driver. If that comes with 
guarantees about validity than that's great.

>>
>>
>>> and new are marked as optional I can not come up with an argument that
>>> these new devices are *not* compatible with brcm,bcm4329-fmac.
>>
>> Compatibility is expressed by implementing same programming interfasce
>> (or its subset) thus being able to bind via fallback and correctly
>> operate in given SW.

This exactly what I mean to say (and apparently fail to do so ;-s ).

>> I don't know whether that's the case here, so rephrasing my earlier
>> comments - the commit msg should focus on this aspect and tell that
>> devices are fully compatible, thus they should use fallback.
>>
>> Quick look at drivers told me that not - they are not compatible...

Okay. That puts use in different corner of the arena. Can you elaborate 
how you come to that assessment? Is that based on the fact that some of 
the properties are SDIO-only?

>>
> Another thing is that calling SDIO and PCI devices compatible is quite a
> stretch... Clearly hardware-wise they are very different and Linux does
> not use the same interfaces to match/bind them.

These are wifi devices which hardware-wise are 95% the same. If you find 
the block diagram with IP cores for these devices (enough google results 
to find some) you can see they sometimes even have both PCI and SDIO 
block on-chip although only one is used so they can be considered 100% 
the same. In both cases the bus driver will attach the DT node to the 
binding device.

Regards,
Arend



