Return-Path: <linux-wireless+bounces-28401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897EC1E74A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 06:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C7418941CF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB222AE45;
	Thu, 30 Oct 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCKsZOhs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDB37A3BB;
	Thu, 30 Oct 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803269; cv=none; b=gV6rJXeQpS+hFoAePeBKbJnvzZ5Io5c1K9SHXkDg/t9EwlnryXsFnPAtZ3hTHbj/45aSU9+MYZG6ihGp3QEl9StNqvhpyAdsSlbrAFH5p7Iia54BRVMyNYrQp4fNJMEdFF7h4jVxdD48oicbfajI+K9vSyoLmzKcyNgGL6jqa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803269; c=relaxed/simple;
	bh=M0L09TztyNjiCDc0Fb+g18Hn3UGbrQ0moZLvALPRArs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByeahxkhFaxAdbbJGZ6q5EtZuO3Np04e1uNjzih9AyZjnzbPCVdfBXIKCYxFdXuW9QkJvnApZp72iDVXTwQUpxqogZaaly6f7TrnZAoTHd6UDVuHNvFxrv2qq+29zCBJGCPNmWy2cV8q7nNhW4NQdKieHczxIk2Osnyf3SLJnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCKsZOhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4806DC4CEF1;
	Thu, 30 Oct 2025 05:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761803268;
	bh=M0L09TztyNjiCDc0Fb+g18Hn3UGbrQ0moZLvALPRArs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCKsZOhsyY1IhSirXHQDQstZCJkLbnus/ixxDFTWJBopPno78YIamfu11F2ZYTHeE
	 j4hKn0TbDWKCquth7Q9IRZbw3o+aK/WT+eQN+A1ceicjqKy8Tnx5Ios2HHNOlNYEh0
	 KgZTfhcE9RpjBMtrHogO363mF+I7l1HBS+ybg1GLjJZgskbYDJq+Foc13No4VcWFwm
	 o71IW93b2TIweD2yCLvb3uno2HIibJSKVRkckg4d2NOhy5m0q5DCzIvYZ8dB/sEnlw
	 Xcz3pnQE5U97HlPymLuaxeVMaQs6oL8VNkyb9p/nqUsSTrTjZqcXQaY0FKfRqQS5k9
	 urWdccmHQqy7g==
Message-ID: <da7ecb40-dbc2-4f6e-8026-d630e5b3bb52@kernel.org>
Date: Thu, 30 Oct 2025 06:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt: bindings: net: add bindings for QCN6122
To: George Moussalem <george.moussalem@outlook.com>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
 <20251029-ath11k-qcn6122-v1-1-58ed68eba333@outlook.com>
 <3dc712ae-b51f-4142-bbab-1eadbc27e60a@kernel.org>
 <DS7PR19MB88836505C4CC48D3E62FBC0A9DFAA@DS7PR19MB8883.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <DS7PR19MB88836505C4CC48D3E62FBC0A9DFAA@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 17:12, George Moussalem wrote:
> 
> 
> On 10/29/25 18:32, Krzysztof Kozlowski wrote:
>> On 29/10/2025 15:26, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> QCN6122 is a PCIe based solution that is attached to and enumerated
>>> by the WPSS (Wireless Processor SubSystem) Q6 processor.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>> The prefix is never "dt:".
>>
> Will do in next version, thanks.
> 
>>
>> A nit, subject: drop second/last, redundant "bindings for". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>>
> 
> Will change accordingly.
> 
>>>
>>> Though it is a PCIe device, since it is not attached to APSS processor
>>> (Application Processor SubSystem), APSS will be unaware of such a decice
>>> so it is registered to the APSS processor as a platform device(AHB).
>>> Because of this hybrid nature, it is called as a hybrid bus device as
>>> introduced by WCN6750. It has 5 CE and 8 DP rings.
>>>
>>> QCN6122 is similar to WCN6750 and follows the same codepath as for
>>> WCN6750.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>  .../bindings/net/wireless/qcom,ath11k.yaml         | 57 +++++++++++++++++++++-
>>>  1 file changed, 56 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>>> index c089677702cf17f3016b054d21494d2a7706ce5d..4b0b282bb9231c8bc496fed42e0917b9d7d106d2 100644
>>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>>> @@ -21,12 +21,13 @@ properties:
>>>        - qcom,ipq6018-wifi
>>>        - qcom,wcn6750-wifi
>>>        - qcom,ipq5018-wifi
>>> +      - qcom,qcn6122-wifi
>>
>> Why people keep adding to the end... previously ipq5018 added by
>> qualcom, did not even get any review.
>>
>> Place it before wcn and let ipq5018 be outlier since this was broken
>> already.
>>
> 
> it was exactly ipq5018 which got me thinking I should add it to the end.
> Will alphabetically insert qcn6122. I could reorder the entire list as
> well if you'd like (ipq6018 is also misplaced)
> 
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>>    interrupts:
>>> -    minItems: 32
>>> +    minItems: 13
>>>      maxItems: 52
>>>  
>>>    interrupt-names:
>>> @@ -87,6 +88,14 @@ properties:
>>>      items:
>>>        - const: wlan-smp2p-out
>>>  
>>> +  qcom,userpd:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [2, 3]
>>> +    description: instance ID of user PD (protection domain) in multi-PD
>>> +                 architectures to distinguish between multiple instances
>>> +                 of the same wifi chip used by QMI in its interface with
>>> +                 the firmware running on Q6.
>>
>> Broken indentation. It is supposed to be two spaces. Look at this file -
>> why are you doing this completely different?
>>
>> Anyway, please do not come with 2nd or 3rd property for this. We already
>> have such somewhere.
> 
> Would you mind pointing me to the property you're referring to? Do you
> mean the QRTR ID as proposed in this RFC:
> https://lore.kernel.org/linux-wireless/cover.1732506261.git.ionic@ionic.de/
> 
> if so, this wouldn't help this in this case. Although it's PCIe based,
> PCI is not even enabled as the Q6 firmware itself takes care of that.


I expect something covering all cases, so it must cover ipq5332 and
ipq9574 from the other patchset you mentioned:
https://lore.kernel.org/all/20231110091939.3025413-2-quic_mmanikan@quicinc.com/

Same thing cannot be represented in two different ways.

For APR and GPR we already have qcom,protection-domain as a service
name. Linux drivers use it a bit differently than your code here, but
unfortunately I focus on bindings and the binding sounds exactly the same.

Anyway instance ID is not acceptable. Check my slides for possible
workarounds, if you do not know the actual protection domain.

Best regards,
Krzysztof

