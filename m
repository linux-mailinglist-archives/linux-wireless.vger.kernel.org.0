Return-Path: <linux-wireless+bounces-22127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC60A9ED54
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA99C1793D8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962B2036E2;
	Mon, 28 Apr 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFfNwySD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB954206B;
	Mon, 28 Apr 2025 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834127; cv=none; b=MzrplM+lkYDOFHR6nXZiohrnUlHis7guq5OX22F73eQIQgndbd1749J9VEOuBxjN97Drjz3J8XW2SZb4tYWE/Ow1F717LZkErH8B6jynjFZscewEoDSiOqnw9pIak2bvscOieyOIsv1yBBXuLGAl4bn5EuafbV7JtViVd/jCrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834127; c=relaxed/simple;
	bh=5gJA+Muqll+Py6HxdXCmp70DGvso8EIkCA2rMU7/Xzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAfwn+P3tvXqG9SCpff6FvQXBzOmOfen8JWHbv+dwjvvUYnjzi2AM8QTRxNdnHwozo81pXpLpdDSwjbfurjUU/4Fv4F9DEDq4/hnK6UHgs37wAwf4wUSglkbyZcqoMZsI9yEWvCClKGZl+eC9EcpV+0cA7xoHEe56yJb8Xkyq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFfNwySD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F40FC4CEE4;
	Mon, 28 Apr 2025 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745834126;
	bh=5gJA+Muqll+Py6HxdXCmp70DGvso8EIkCA2rMU7/Xzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rFfNwySDl4TQQ0LCzt1/Po19Kl+L3qYQdIcPV/Ug8CF36BZlj9bIWugG7SsPfEQOO
	 n9aLOUws1fn4ibSUxfUNNHHM/dGtWkZuNqgN8tT7qQgAgnsSOmLFxNnWecSnOVCYA9
	 89oEEHwFyOvNsA4UoUjHu4Zcz/jHXWnhQ+nobQG4s5wf75Do5SqBcoFILkMxfBQTLg
	 RtBK/gIS36pNQgjwcJ0EeVZpRUXa5h2UnvKwg47ysLPz8bUyRrDlaWYnRQ92zTGVIF
	 2+nNe8AMC6kpNmt0um6rCYGQvUVF1F3b3Angf8/7TKOJS1yTtGK1DUzBxSBHnEFui/
	 uWfJE4towXILA==
Message-ID: <26981b75-16d6-4b1f-83de-c642ac0e342f@kernel.org>
Date: Mon, 28 Apr 2025 11:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND ath-next 1/2] dt-bindings: net: wireless: ath12k:
 describe firmware-name property
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
 <20250424005703.2479907-2-quic_miaoqing@quicinc.com>
 <20250428-ruddy-bold-macaw-9ffd28@kuoka>
 <bfd1be89-cb03-4426-ad7e-93b6774a68a7@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <bfd1be89-cb03-4426-ad7e-93b6774a68a7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/04/2025 11:48, Miaoqing Pan wrote:
> 
> 
> On 4/28/2025 4:25 PM, Krzysztof Kozlowski wrote:
>> On Thu, Apr 24, 2025 at 08:57:02AM GMT, Miaoqing Pan wrote:
>>> Introduce 'firmware-name' property to allow end-users and/or integrators
>>> to decide which usecase-specific firmware to run on the WCN7850 platform.
>>> This is necessary due to resource limitations such as memory capacity and
>>> CPU capability, or performance and power optimization for different
>>> application scenarios.
>>>
>>> Two firmwares are supported: 'WCN7850/hw2.0' and 'WCN7850/hw2.0/ncm825'.
>>> The former is the default firmware, suitable for most WiFi 7 STA
>>> functions. The latter adds support for commercial-quality SAP and
>>> optimizes power consumption for IoT applications.
>>>
>>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/net/wireless/qcom,ath12k.yaml       | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
> 
> I don't find any tags on previous version: 
> https://patchwork.kernel.org/project/linux-wireless/patch/20250423054152.2471568-2-quic_miaoqing@quicinc.com/.
> 
> Do you mean I should add 'Reviewed-by: Krzysztof Kozlowski 
> <krzk@kernel.org>' ?

No, probably I mixed up the patches.

Best regards,
Krzysztof

