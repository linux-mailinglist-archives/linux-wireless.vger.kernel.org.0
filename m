Return-Path: <linux-wireless+bounces-11708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B5958BA1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3124128279F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F4194129;
	Tue, 20 Aug 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh1eZZ/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285220B20;
	Tue, 20 Aug 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169063; cv=none; b=DS2KzWwjMI4MY2wAzhvkJBLXk9RsZTohW0JtEhPcgLOSe4CvBy/r1cEOaVo9iSSjVOsp1w1togmY+Mq4vqE9czlA4QEwJ3yqb1twz4U/MwFU75SMusPdPvLtQ4cvW0LAfPSdGoPWJwaeUwnge/7/BdW5f34cGx0sBQZiaAy7AWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169063; c=relaxed/simple;
	bh=U97Atg5ExFy7awJcHSaR8f+5ze8gkcPb32aJBTS1m2Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P4gL+fk0BjYmMdxxmCL1Ppi2HVSNmx9uXSPiCrdD8xYLuMBAKww0uKCeMY7bjZBTVpBbVc2hb4aOzA2L7EBCQPG6iBHRtNs6XZMrH0y1ZVjr9zKbOE9QBTnzU8sRD4cHvFUpy64wMFfvF7YtyykORK+xdTAoESHf+JNZiLO3Xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh1eZZ/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F72C4AF0F;
	Tue, 20 Aug 2024 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724169062;
	bh=U97Atg5ExFy7awJcHSaR8f+5ze8gkcPb32aJBTS1m2Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Mh1eZZ/L9UMtj12BVjJEe0FpqIkd0K46CIMnvPWAc9P9WJ98v8ZUs/0iio2M7povq
	 W9hxkhVdGqsSGftGPfCMs3qfiNMfTfFwRwilN5Qg52lNyWp0MnXHogiCH0fIPqFUW1
	 hiL9xFRQaIT28r0LmVEUyCi+sQdMKuTY9BdUTN2otAR8SRCHq519t9fy20MQRipTR6
	 Uf4LIWD/ub5QuCN74WhM58zUnAPouDxKv9+KJH1PR4+uzR+/nXJKw8NPN+uO5rPIkE
	 7R76eSQrnLnzEUSLrIrtygQ5Xo54asBK4tKJfidEoZ0AsVq8AL30UDl9mRhB3a4Sao
	 vmL/q7KYRR6rw==
Message-ID: <3ed394a3-2b5e-4096-b090-c805657585a3@kernel.org>
Date: Tue, 20 Aug 2024 17:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
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
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <0b639d04-af33-44b0-a556-40decff683c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 17:36, Krzysztof Kozlowski wrote:
> On 20/08/2024 14:50, Arend van Spriel wrote:
>> On 8/20/2024 1:39 PM, Krzysztof Kozlowski wrote:
>>> On 20/08/2024 13:27, Krzysztof Kozlowski wrote:
>>>> On Tue, Aug 20, 2024 at 12:12:15PM +0200, Arend van Spriel wrote:
>>>>> When extending the bindings for Apple PCIe devices the compatible property
>>>>> specification was changed. However, it was changed such that for these
>>>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
>>>>> string in the compatible list property as it was before that extension.
>>>>
>>>> Apart that this was never tested... That statement is not true. Look at
>>>> "fixed" commit - it is not doing like that at all.
>>>>
>>>> I don't understand the reasoning.
>>>>
>>>>> This patch restores that constraint.
>>>>>
>>>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>> ---
>>>>>   .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>>>>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> index e564f20d8f41..47f90446322f 100644
>>>>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>>>>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>   title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
>>>>>   
>>>>>   maintainers:
>>>>> -  - Arend van Spriel <arend@broadcom.com>
>>>>> +  - Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>   
>>>>>   description:
>>>>>     The Broadcom Single chip MAC part for the BCM4329 family and
>>>>> @@ -27,7 +27,6 @@ properties:
>>>>>                 - brcm,bcm4341b0-fmac
>>>>>                 - brcm,bcm4341b4-fmac
>>>>>                 - brcm,bcm4341b5-fmac
>>>>> -              - brcm,bcm4329-fmac
>>>>>                 - brcm,bcm4330-fmac
>>>>>                 - brcm,bcm4334-fmac
>>>>>                 - brcm,bcm43340-fmac
>>>>> @@ -46,13 +45,15 @@ properties:
>>>>>                 - cypress,cyw43012-fmac
>>>>>                 - infineon,cyw43439-fmac
>>>>>             - const: brcm,bcm4329-fmac
>>>>> -      - enum:
>>>>> -          - brcm,bcm4329-fmac
>>>>> -          - pci14e4,43dc  # BCM4355
>>>>> -          - pci14e4,4464  # BCM4364
>>>>> -          - pci14e4,4488  # BCM4377
>>>>> -          - pci14e4,4425  # BCM4378
>>>>> -          - pci14e4,4433  # BCM4387
>>>>> +    - items:
>>>>> +          - enum:
>>>>> +              - pci14e4,43dc  # BCM4355
>>>>> +              - pci14e4,4464  # BCM4364
>>>>> +              - pci14e4,4488  # BCM4377
>>>>> +              - pci14e4,4425  # BCM4378
>>>>> +              - pci14e4,4433  # BCM4387
>>>>> +          - const: brcm,bcm4329-fmac
>>>>> +    - const: brcm,bcm4329-fmac
>>>>
>>>> And this does not make sense... You claim that some constrained was
>>>> droppped and you re-add it, but in fact you still add the same code as
>>>> it was before.
>>>>
>>>> NAK.
>>>
>>> Ah, the last "const" actually makes sense, I missed that.
>>>
>>> Commit still however lacks rationale why these devices are compatible.
>>> Plus existing rationale that e2e37224e8b3 changed something is entirely
>>> WRONG. It changed nothing. ZERO. It only added new devices, which was
>>> claimed are not compatible with brcm,bcm4329-fmac.
>>
>> So is that claim true? What does it mean that these new devices are not 
>> compatible. If they are they should be in a separate binding or the 
> 
> Whether binding is separate or not, is just way of organizing things.
> 
>> applicable properties for these devices should be made conditional.
> 
> Could be if they are not applicable.
> 
>>
>>> Now if you claim that original commit which said "these devices are not
>>> compatible with brcm,bcm4329-fmac", then please provide arguments, not
>>> just say "other commit did something". It did nothing...
>>
>> Not entirely true. Indeed new devices were added for which no 
>> "brcm,bcm4329-fmac" string is required in the compatible property. Also 
>> the commit added new properties for these new devices. Now in my opinion 
>> a driver should not use these properties without a "compatible" check. 
>> Hope we can agree to that. However, the driver patch for supporting the 
> 
> Sorry, I don't follow. Why the driver would need to check for compatible?
> 
>> binding change does no such thing. So if we leave the binding as it 
>> currently is the driver will have to check if compatible has any of the 
>> listed PCI IDs before processing the properties. As all properties old
> 
> Why driver needs to check it? Are these properties not valid?
> 
>> and new are marked as optional I can not come up with an argument that 
>> these new devices are *not* compatible with brcm,bcm4329-fmac.
> 
> Compatibility is expressed by implementing same programming interfasce
> (or its subset) thus being able to bind via fallback and correctly
> operate in given SW.
> 
> I don't know whether that's the case here, so rephrasing my earlier
> comments - the commit msg should focus on this aspect and tell that
> devices are fully compatible, thus they should use fallback.
> 
> Quick look at drivers told me that not - they are not compatible...

Another thing is that calling SDIO and PCI devices compatible is quite a
stretch... Clearly hardware-wise they are very different and Linux does
not use the same interfaces to match/bind them.

Best regards,
Krzysztof


