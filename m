Return-Path: <linux-wireless+bounces-18296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E94A256B2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC783A806A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADB200BB7;
	Mon,  3 Feb 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzH1nJZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65742200118;
	Mon,  3 Feb 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577583; cv=none; b=NjBTOkK4GB3K0KeLVCeJyAMgjREPiQwkWMgrjftzPFw7ePjblZPrP5DLpI+HYQ/+Z2l+qgnMG/aqAOjuLM7xHu39b30N4RHrLEqOOcOvJab+dRUqy7ZuYfjsC7t8PvHWF1oYc8Cpvqok6SWCRZ4nAdPm8CY5mngW4vrQ3MxBDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577583; c=relaxed/simple;
	bh=tLbJXYxUhEFv6Iig2E6u0QBVqqlEhSREn7pQ0ziuXhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVRkg3X3Ovo8dzAUOKPae0aWNaGJAe8KgoMPaBJPnOxhOJphy4FPjuuxeaJNDD2GGVwMw1YNcPqNTDHGLbu0KRxqbQ1iLAseoNTt+fh/tTmiwJ7knPK7jcX+rVlYVfYUHGwWca4EYioH/ervTPXmSwmlOYidef+2Lxtea5dVzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzH1nJZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62418C4CED2;
	Mon,  3 Feb 2025 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738577582;
	bh=tLbJXYxUhEFv6Iig2E6u0QBVqqlEhSREn7pQ0ziuXhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lzH1nJZD5hYM7CgSXHm+jqaHlrZ2MH6H0A8I3r3845qkTemqr/VKNdNx0vXQoIn8v
	 Uza7VjpdGqRgPRZoCt+ZaQ4vCKhTAyOJT3Vn7HoB1adc1LcVB0TYwyVdBwuBNBSxKv
	 cyBqJb2Vdh+rCkk6RZjm/D0TXw9ffTggfe6elQd2yGBBaWeqdWghw8DpS0UqX18t1s
	 5St+U78NyK+r08VF4QOt6GuOTY2RVlNC5u6t2/AKv7YVk8WWjbku595mjZcy5TQ55k
	 ourGReDlXWns09z7NvBwMkh4H1m7CiTizrXyzdmzzE1kThZdEJOEG1Erp8+Ad+4LXj
	 Asf67Hg4xlVmw==
Message-ID: <962dc257-f7a6-49c7-b760-a31fd84e7a56@kernel.org>
Date: Mon, 3 Feb 2025 11:12:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-8-quic_rajkbhag@quicinc.com>
 <4c9b512f-59d2-4d96-a899-5af4de2c823e@kernel.org>
 <7d5f7b4c-2a55-41c7-b85c-cb4cd76d553f@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7d5f7b4c-2a55-41c7-b85c-cb4cd76d553f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2025 10:44, Raj Kumar Bhagat wrote:
> On 1/30/2025 1:16 PM, Krzysztof Kozlowski wrote:
>> On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
>>> @@ -2646,6 +2663,136 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>>>  	return ret;
>>>  }
>>>  
>>> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>>> +{
>>> +	struct device_node *mem_node;
>>> +	struct resource res, m3_res;
>>> +	u32 bdf_start_addr;
>>> +	int i, idx, ret;
>>> +
>>> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
>>> +		switch (ab->qmi.target_mem[i].type) {
>>> +		case HOST_DDR_REGION_TYPE:
>>> +			mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
>>
>>
>> Why cannot you use existing API for reserved memory -
>> of_reserved_mem_lookup()?
>>
> 
> The of_reserved_mem_lookup() requires reserved memory node to read the memory and
> return in the structure "struct reserved_mem".
> 
> The of_reserved_mem_lookup() would be used after we get the reserved memory node
> using the API - ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
> 
> In next version we would use of_reserved_mem_lookup(), Something like below:
>     mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");

Then why do you need ath12k_core_get_reserved_mem_by_name() in the first
place? Just use of_reserved_mem_lookup() directly. Why do you need to
parse phandle before of_reserved_mem_lookup()?


>     struct reserved_mem res = of_reserved_mem_lookup(mem_node)


Best regards,
Krzysztof

