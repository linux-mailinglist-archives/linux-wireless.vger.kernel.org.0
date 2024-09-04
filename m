Return-Path: <linux-wireless+bounces-12478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6996BB1A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609F1287E10
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA071D0161;
	Wed,  4 Sep 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoAjEFMw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9F1D79AE
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450149; cv=none; b=a7lC4FXsH2liKdBAOsmEJ1J4nGRii0xW+PDB/n3cFqJh7m9lCnR5cfSvZ/ZI33IzEYzaas4BhIf4lzFDOJzjxRlJI78NUA9mBjyfIYLifts/PdAmwW84KJ7KLltME0s46xq9Ifzg8QjI04bqHw+sOvS/PUp9A0MAXFRKG8t/tIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450149; c=relaxed/simple;
	bh=w8kcqUEtN5JVUmVZ23b/Gt3v6OD3N0jhoFRdRc0foyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxhUw5hjOJCdulE8GypCPv1vhYux7b70GD19dJ6tjkYH0+bTGyIDgj49VWyK2pEqGQSuX/+9qNi8ZWbixyuTk8bz58Yd8ceKcUzjRNGrUeYfN9xbuNKt9qnjfjY0PPoKWjEyOqwQ0IfFuHrg2EpJnPZBZiTgHGuzVYYkN8uFaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoAjEFMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDB2C4CEC2;
	Wed,  4 Sep 2024 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725450148;
	bh=w8kcqUEtN5JVUmVZ23b/Gt3v6OD3N0jhoFRdRc0foyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NoAjEFMwY2D2qZ/K1GfTWS5ZCaLg8XSWj8uv3ba4k/iZPseAYG1Nv35A7a3iKIbPR
	 aa0JSDQgovsilp8piop4Y8O2XJLDdHBzef7yhFrxwNqJdbU8LOo2KLtkKZm+rBmiRb
	 KMna9X3X7uzanOpm2UbJLWXPbr6LP5S/7gdIA+Tu62N9m7Lj929PWFum7Od7ZiAT9u
	 xGBZN3CBhNVuD85Tqw900awq7AoSYsy66iz1MV80DT3u47D0TtjpmJQ9B87ByCVweV
	 3XaZbHzXkLVp8T5pHMp4/ufdz2nWMg+MtUtuzLwhT+jSIEPryTflR1bPhvlsYi8EZG
	 CmqGBZTjNWZzw==
Message-ID: <a782bd91-6d8a-4d3a-8df2-c8aebebc00f9@kernel.org>
Date: Wed, 4 Sep 2024 13:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
 <6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
 <cecf0e32-b84c-423e-89c3-61eab9f1928a@quicinc.com>
 <1e2a2974-b78b-483f-9190-34d5dae69f7d@kernel.org>
 <9e40f028-dc71-41cb-a5ac-772ef91129ac@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <9e40f028-dc71-41cb-a5ac-772ef91129ac@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2024 13:28, Raj Kumar Bhagat wrote:
> On 9/4/2024 1:08 PM, Krzysztof Kozlowski wrote:
>> On 04/09/2024 09:23, Raj Kumar Bhagat wrote:
>>>>> +  qcom,board_id:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Board id value, it identifies the variant of ath12k WiFi device.
>>>>
>>>> Please do not upstream whatever you have in your vendor tree... You even
>>>> copied its style! There is no such property in upstream.
>>>>
>>>> NAK, you are duplicating compatibles.
>>>>
>>>>
>>>
>>> qcom,board_id is a new parameter introduced to distinguish between different variants
>>> of ath12k devices that share the same compatible value. This differentiation is crucial
>>> as these variants have different qcom,board_id values (with the same compatible) based
>>
>> You must explain why compatible cannot be used for that.
>>
> 
> The compatible property is used to define the variant of the Ath12k device. However, the
> Ath12k device variant does not change with different capabilities or configurations
> (e.g., operating band). The qcom,board_id parameter is introduced to define these
> configurations, not the device variant itself.

operating aspects are run-time, so not suitable here. It's all still
vague for me.

> 
>>> on WiFi frequency bands capability. For example, 2 GHz, 5 GHz, 6 GHz, or multi-band
>>> variants of ath12k devices have different qcom,board_id values.
>>>
>>> In the next version, I will include the above information in the qcom,board_id
>>> description.
>>
>> Please follow DTS coding style. And style of existing properties like
>> this. Did you look for them? I claim you just sent whatever you had in
>> downstream.
>>
> 
> Checked "Devicetree Specification, Release v0.4", section 4.1.1,
> seems "_" to be avoided for property name and hyphen "-" to be used. Also, qcom,board-id
> is already taken in "Documentation/devicetree/bindings/arm/qcom.yaml". In the next
> version will change this property name.

Look at existing bindings and see how they are doing it. Sorry, you
still did not give any good rationale why compatibles cannot be used. If
this is board specific implementation, then the board compatible defines
differences.

You need to be specific, not so vague, about problem you are solving.
Don't answer with half-baked explanations just to get rid of reviewer.

Best regards,
Krzysztof


