Return-Path: <linux-wireless+bounces-11705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD2958A2E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B4D287C34
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945D8F48;
	Tue, 20 Aug 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JZhehBWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85619004D
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165612; cv=none; b=G+gxd3jCfeYvXRilUeQ0go6ZwKd59eBt2MWNoHQ1qfE8Ai9nS18Ox+kqWg+Q2XW1z3woHRY6aAMadENAmBoevn/m8ritaDpnXBSqCjHGY2BxV/x05cKFvICvoeuqogjaCNJZEyr8n+UrgSfV5tysTKu9+jpHqJB9t63Qh8GQCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165612; c=relaxed/simple;
	bh=owuVia3Ec8hS4Tzg0YSGZnP3tTpMNFwhZ9EjmnZfm+c=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dHn49NaKSu0woW8m18yzQT3K7I9H/Grr6wW+ceyc3eFPcXapEX4lXcxQLIeKHXrCTOuIpJIPeWYf+GVfe/Iksk12K/3fVmA1CviumyVpogtDNbXWK5eXrPiW6pyNFPhoxCqi1NJ7XGmazt1L8CoIDN7Yscbqi86/KlBckT7LjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JZhehBWe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8caef11fso658372866b.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724165609; x=1724770409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lean+ba5I8okfjRQmm7UZf9YwlE6ssXVcZQnVO7azw=;
        b=JZhehBWeUCBqPmNJwQ61jtiZ8IrFpOiW26V8D/WEpBuUFlsjEr9HNQXK27M+ytUSKd
         159XO7hGdrcLOHFWArbKgdLGxGk0Hg0RtczfZT13Gq2/rHfAAHR+Z9CTxfUDtPbps7Ti
         CZL7Hzz+fbY7qe+psDAesnp3bTCqVkZd2kyWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724165609; x=1724770409;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lean+ba5I8okfjRQmm7UZf9YwlE6ssXVcZQnVO7azw=;
        b=EQcCqOf5pdSRSUvomoRcGqxvh+7FLDzIgGskuv3ko/MTonEJDjdemmAd/B3wHrrosj
         RNkKzJ3em1gN2Ff1VufoDrAMU1vJEu3ZCMIeKZfZGcBRW+bXswWb454UYHLaGTbgZMim
         l4avOHw1HQau19Y6e2SDue41F6Db4mDn/p2DDFshSm0y8FYqKKHQaBUI43FEFFM8BSZp
         vHlfRgjKM54gexNi1EmmyoNGmN9Cive0S5aD+Nzm++ZLlxB8H7Ucq4JFL4qpY6KcxkF3
         vwbBc5HF7jg5nSs+XX144z9v90K9iJ/0sWH04xQ2eV6p7RtuPfH75YQ7E4OZfImmm9m4
         Lk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHJXCACzy863FEmLXXSF9EDrJVRnH3DOsES3NrPaY5x78OmWaEEKBjI3Ts+eH9q5T3k/JDsZrqHtijsTEqPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwMPwTYhkaaSzKUgj2rIlLFptboYnQhbI8iajk4zgs62z6MDk
	I7C0DvTNsIhCRVUyvmN6qKxneJ1HBKAIqS4r9/mGSvdcVR83bo+L3ntoxos/dg==
X-Google-Smtp-Source: AGHT+IFX/h/PLBfDZU8MSLKQU8nyhQrbufsrivLrvdyUAmZSegFOoBiDC+LSNAKDzv39f6JQD1gdSg==
X-Received: by 2002:a17:907:da0:b0:a77:db34:42ca with SMTP id a640c23a62f3a-a8392a03bb6mr1038816866b.49.1724165608691;
        Tue, 20 Aug 2024 07:53:28 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356e2sm767430566b.105.2024.08.20.07.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 07:53:28 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, Krzysztof Kozlowski <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <asahi@lists.linux.dev>
Date: Tue, 20 Aug 2024 16:53:28 +0200
Message-ID: <19170474e58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <6777d425-b27f-43d0-ba81-b36ac0b8f929@broadcom.com>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
 <mbvhz3wosnykejgs65es2sfedxoevysbqu3jxmpgdze2b2tl6o@grx4mxas2bmf>
 <7881c303-bef1-403a-aa70-30d33558f57f@kernel.org>
 <6777d425-b27f-43d0-ba81-b36ac0b8f929@broadcom.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for brcm,bcm4329-fmac compatible property
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 20, 2024 2:50:24 PM Arend van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On 8/20/2024 1:39 PM, Krzysztof Kozlowski wrote:
>> On 20/08/2024 13:27, Krzysztof Kozlowski wrote:
>>> On Tue, Aug 20, 2024 at 12:12:15PM +0200, Arend van Spriel wrote:
>>>> When extending the bindings for Apple PCIe devices the compatible property
>>>> specification was changed. However, it was changed such that for these
>>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
>>>> string in the compatible list property as it was before that extension.
>>>
>>> Apart that this was never tested... That statement is not true. Look at
>>> "fixed" commit - it is not doing like that at all.
>>>
>>> I don't understand the reasoning.
>>>
>>>> This patch restores that constraint.
>>>>
>>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties 
>>>> & chips")
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>> .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>>>> 1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml 
>>>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>> index e564f20d8f41..47f90446322f 100644
>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
>>>>
>>>> maintainers:
>>>> -  - Arend van Spriel <arend@broadcom.com>
>>>> +  - Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>
>>>> description:
>>>> The Broadcom Single chip MAC part for the BCM4329 family and
>>>> @@ -27,7 +27,6 @@ properties:
>>>>          - brcm,bcm4341b0-fmac
>>>>          - brcm,bcm4341b4-fmac
>>>>          - brcm,bcm4341b5-fmac
>>>> -              - brcm,bcm4329-fmac
>>>>          - brcm,bcm4330-fmac
>>>>          - brcm,bcm4334-fmac
>>>>          - brcm,bcm43340-fmac
>>>> @@ -46,13 +45,15 @@ properties:
>>>>          - cypress,cyw43012-fmac
>>>>          - infineon,cyw43439-fmac
>>>>      - const: brcm,bcm4329-fmac
>>>> -      - enum:
>>>> -          - brcm,bcm4329-fmac
>>>> -          - pci14e4,43dc  # BCM4355
>>>> -          - pci14e4,4464  # BCM4364
>>>> -          - pci14e4,4488  # BCM4377
>>>> -          - pci14e4,4425  # BCM4378
>>>> -          - pci14e4,4433  # BCM4387
>>>> +    - items:
>>>> +          - enum:
>>>> +              - pci14e4,43dc  # BCM4355
>>>> +              - pci14e4,4464  # BCM4364
>>>> +              - pci14e4,4488  # BCM4377
>>>> +              - pci14e4,4425  # BCM4378
>>>> +              - pci14e4,4433  # BCM4387
>>>> +          - const: brcm,bcm4329-fmac
>>>> +    - const: brcm,bcm4329-fmac
>>>
>>> And this does not make sense... You claim that some constrained was
>>> droppped and you re-add it, but in fact you still add the same code as
>>> it was before.
>>>
>>> NAK.
>>
>> Ah, the last "const" actually makes sense, I missed that.
>>
>> Commit still however lacks rationale why these devices are compatible.
>> Plus existing rationale that e2e37224e8b3 changed something is entirely
>> WRONG. It changed nothing. ZERO. It only added new devices, which was
>> claimed are not compatible with brcm,bcm4329-fmac.
>
> So is that claim true? What does it mean that these new devices are not
> compatible. If they are they should be in a separate binding or the
> applicable properties for these devices should be made conditional.
>
>> Now if you claim that original commit which said "these devices are not
>> compatible with brcm,bcm4329-fmac", then please provide arguments, not
>> just say "other commit did something". It did nothing...
>
> Not entirely true. Indeed new devices were added for which no
> "brcm,bcm4329-fmac" string is required in the compatible property. Also
> the commit added new properties for these new devices. Now in my opinion
> a driver should not use these properties without a "compatible" check.
> Hope we can agree to that. However, the driver patch for supporting the
> binding change does no such thing. So if we leave the binding as it
> currently is the driver will have to check if compatible has any of the
> listed PCI IDs before processing the properties. As all properties old
> and new are marked as optional I can not come up with an argument that
> these new devices are *not* compatible with brcm,bcm4329-fmac.

Looking at the commit in patchwork I see no claim in the commit message 
that the new devices are not compatible. The patch even adds enum with the 
PCI IDs *and* brcm,bcm4329-fmac. It is anyone's guess what the intent was 
for doing that. My take is that this was a mistake worth fixing.

Regards,
Arend

>
> Regards,
> Arend
>
>> Best regards,
>> Krzysztof




