Return-Path: <linux-wireless+bounces-12553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2596E211
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71F7B25457
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDB16F831;
	Thu,  5 Sep 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp71xDyq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD9158D66
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561234; cv=none; b=NlnGdulcihcQiH+nCbz+SyZpJtcqw9YFr5nlQXLgF88a9dv+CpAEicbnUPyTdomH0j8VCfBSuklcDMhhO5nhFsklkrOY6HUDkekJmr07mUbfPzryFjZ/UYu56EDNS+ezGFsSKKfSNOaHou8MigTWUBMN1mn8H55P/vxAe+1N8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561234; c=relaxed/simple;
	bh=0IyRC2uxRfR0TLKCB/z3dbBdDVG91WjX5B0avIrfGsw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Zj8ueOv5fekbnTc2vf2sla91KhIFV4FPhaLds4yjBWO0jSu6A0OlguPVXKyjgALZ6UxePJ7/U+3au/acVSlPyaIW1DX+h9zLxVU06P6icRcgjng7nE895qg0AyyG9lus8PIFah49h7FZodXw6xNnVdQWz2Yfpud9/16n2ULo5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp71xDyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8525C4CEC7;
	Thu,  5 Sep 2024 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561233;
	bh=0IyRC2uxRfR0TLKCB/z3dbBdDVG91WjX5B0avIrfGsw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Zp71xDyqlTXRQt3Hgs9dX7maNS+Qv+SS0pnRsXfZPfMO3gWJK1JpPRINzTNz9vjK4
	 8Pn6c2eXC9wE5pvP+wiZHyeItr2+fOVuX+Trvf5oBKQZNjhwTBwF7PYjwnZJgMiLw2
	 U4+H5vv2jw4h8/+dnXe9yPIKYiEQ1N2qIaEaYumzRXg4XsjIXCS+y8CWTBMLJyQtLx
	 mxDfnJkctto3XkEF8pngirPzlFPCEAhsAiRKvMm6sJUi4ElBBokZtV6BrZrZQoOaas
	 AKWgb0NrA5nwpgvHhcIaqAI4XmOlQ2vvSbwGyvc3QPSqo/HYgW+3pRRQm8NxZhoXKe
	 qNHbOww5EfBKA==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
  ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the
 ath12k AHB module
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
	<20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
	<6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
	<cecf0e32-b84c-423e-89c3-61eab9f1928a@quicinc.com>
	<1e2a2974-b78b-483f-9190-34d5dae69f7d@kernel.org>
	<9e40f028-dc71-41cb-a5ac-772ef91129ac@quicinc.com>
	<a782bd91-6d8a-4d3a-8df2-c8aebebc00f9@kernel.org>
Date: Thu, 05 Sep 2024 21:33:51 +0300
In-Reply-To: <a782bd91-6d8a-4d3a-8df2-c8aebebc00f9@kernel.org> (Krzysztof
	Kozlowski's message of "Wed, 4 Sep 2024 13:42:25 +0200")
Message-ID: <874j6uhrw0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 04/09/2024 13:28, Raj Kumar Bhagat wrote:
>
>> On 9/4/2024 1:08 PM, Krzysztof Kozlowski wrote:
>>> On 04/09/2024 09:23, Raj Kumar Bhagat wrote:
>>>>>> +  qcom,board_id:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      Board id value, it identifies the variant of ath12k WiFi device.
>>>>>
>>>>> Please do not upstream whatever you have in your vendor tree... You even
>>>>> copied its style! There is no such property in upstream.
>>>>>
>>>>> NAK, you are duplicating compatibles.
>>>>>
>>>>>
>>>>
>>>> qcom,board_id is a new parameter introduced to distinguish between different variants
>>>> of ath12k devices that share the same compatible value. This differentiation is crucial
>>>> as these variants have different qcom,board_id values (with the same compatible) based
>>>
>>> You must explain why compatible cannot be used for that.
>>>
>> 
>> The compatible property is used to define the variant of the Ath12k device. However, the
>> Ath12k device variant does not change with different capabilities or configurations
>> (e.g., operating band). The qcom,board_id parameter is introduced to define these
>> configurations, not the device variant itself.
>
> operating aspects are run-time, so not suitable here. It's all still
> vague for me.

Yeah, this is weird and I would hope there is a better way to do it.
Unfortunately I'm not able to study this in detail right now but, like
you said, most likely this is just directly copied from QSDK (their
downstream).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

