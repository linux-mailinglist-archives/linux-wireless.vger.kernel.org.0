Return-Path: <linux-wireless+bounces-14736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3099B650F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0071C21DFD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C61EE021;
	Wed, 30 Oct 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkOfSo/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC301EBFF2;
	Wed, 30 Oct 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296874; cv=none; b=POZIUZ4/TgVEAT3BorshzxRqekn9cx6aUMxwN55j1duPNJOUk38wEZwOOu/k9kegm6fovonoC5JOrdLTMRuxNg9ixRC0DWlcyn/CXcEfWLs39OuV371jnCIFU8SsndNbFSXk/71S9bfvrjee0IEtwNZw7KYS6ml5lZUjc2ssCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296874; c=relaxed/simple;
	bh=cZyl/pNcW3otfN/m79DGyMQG/9YXXsayTz/r9b6yIhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkEFHpSOmwYnjjI3G3sagJngDTVdHKItvNpS6F/PNk5TnFzT2tVGFzuZqhINLbJNHojxBJifFiS6POHq4e586RnraNdHl4LL33sFh8+AoWaGhYO8z/DPNbfnym6tmSaBboMzSZAzo7olprU0oiYMMfQTH03JnPzx4U3jfurZAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkOfSo/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31C0C4CECE;
	Wed, 30 Oct 2024 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296874;
	bh=cZyl/pNcW3otfN/m79DGyMQG/9YXXsayTz/r9b6yIhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LkOfSo/yWKilkg1Ba1/mfdCdNpDj5hmbfa2HUyCQMWR5oHPsxysWFNMSinsKPGwkm
	 b959PYpfFQkCzX+y5ocQQS9/I/6fAPJW5Wgko9ltT79MGM+LfJ/RCigiJfjEY1mQQE
	 NHvFU8DuaW0/JbIodVcvk92BhyWZ8Lr7Gd6HSSnQwZYGL79jMJPnfohMfNXm3EiTEY
	 6W6LWd/xmw6Xy0+/68K4suxUxj6nIkiwvzLYEbSmO/y6RLeKiHmi0N7fisC7jE2N71
	 z6Tb8SAJm02w3c3wTNhKC9ZgTh6lz7YsOEYNX91E3xarEdE6aHZCxBVCYQlyXEKutR
	 bEqXNo+r8dqnw==
Message-ID: <ae0faee0-d695-4b48-8be8-dfd2e7e08f54@kernel.org>
Date: Wed, 30 Oct 2024 15:01:08 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: "Nemanov, Michael" <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-2-michael.nemanov@ti.com>
 <936b19eb-cde7-4be8-98cf-e60e32b335cd@kernel.org>
 <8024aa1c-5bd1-40d8-b0c3-14b5fcd992e2@ti.com>
 <bda36285-dc70-4dff-85ed-9c04c0f7ba44@kernel.org>
 <3fc3c670-ce63-4a27-9d12-1c6c996cf914@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <3fc3c670-ce63-4a27-9d12-1c6c996cf914@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 13:14, Nemanov, Michael wrote:
> On 10/30/2024 1:09 PM, Krzysztof Kozlowski wrote:
>> On 30/10/2024 11:59, Nemanov, Michael wrote:
>>>>
>>>> Your changelog does not explain these three. "Fixed compatibility" is
>>>> way too vague, especially that you do not fix anything here.
>>>>
>>>
>>> I was trying to address the feedback from previous patch. You said:
>>>
>>>>>>> +static const struct of_device_id cc33xx_sdio_of_match_table[] = {
>>>>>>> +	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
>>>>>>> +	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
>>>>>>> +	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
>>>>>>> +	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
>>>>>>> +	{ }
>>>>>>> +};
>>>>>>
>>>>>>
>>>>>> Eh? What happened here? So devices are compatibles thus make them
>>>>>> compatible in the bindings.
>>>>>>
>>>>>
>>>>> I thought this is the right way to do it (originally taken from [1]).
>>>>> How can I solve it via DT bindings?
>>>>
>>>> It's all over the bindings (also example-schema). Use fallback and oneOf.
>>>>
>>>
>>> Looking at [2] and [3] as an example I tried to do the same (make cc33xx
>>> driver compatible with all chip variants).
>>> How should have I done it?
>>
>> qcom-wdt is quite a different device. It's true you should have here
>> oneOf, but for a purpose. oneOf without purpose does not make sense, right?
>>
>> I think other TI bindings would serve you as an example. Or this one:
>>
>> https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> OK.
> So I should make one of the variants the base and declare others as 
> compatible? i.e:
> 

Yes

Best regards,
Krzysztof


