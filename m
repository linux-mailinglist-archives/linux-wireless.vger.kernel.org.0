Return-Path: <linux-wireless+bounces-30735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E14EDD1703D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4411302EA3B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5A36A018;
	Tue, 13 Jan 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyV1HwVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC51269CE7;
	Tue, 13 Jan 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289355; cv=none; b=QdYO0J/eplo2NqSheT3Vkwhyen3K1uyhcj2q2PeDJ8ZBWrHuBhbFLB1ZrlBPV/XZExEA6sI5jt4AGWsVtjtjhImOebtQWPJly979m3upGQ/T4kXcn3Hod6f6uFGRHFLfrVb9AWAhtGFCDr/oclT2Qm+wn75mmyW6vtAx5tHOCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289355; c=relaxed/simple;
	bh=+1g63FBZYAnjoJfvzsiNwUHQkuO5dOwtUQFXga6ktcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXy1Vjb9Mk5/HBoim3kooOI6aNCL+FP9NwysnxNL7jsZDCdUFrfEajnT02HI5QMGnTYeCGE2JDE+2efrVSSVDiRTiXyjHhxLoECrvw422Z4DEaeA8xB0JKbipPYB9YZhnGRlP+j3vrPILeC+fUGlNAhqu6QUul8qr0GpFFlnLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyV1HwVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EE3C116C6;
	Tue, 13 Jan 2026 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768289354;
	bh=+1g63FBZYAnjoJfvzsiNwUHQkuO5dOwtUQFXga6ktcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qyV1HwVpVW6fy/NWPVNzSp6vrlrq1Hq0n2gpNvHTqhWZSUdSv96xvSKJsVxBGP5YQ
	 hPQ6N0pBEbZ1tEMNBwKkcxz6zsgElS/izbeVcj7S4XBTaX4eGjIDzl2G6CCC20zhZ5
	 laLlW9ir0vfk0hqCHx3Fbw0ly5zQBBPMAjq8r8gbRizBdncDBFcUq0wq1P8LPHQ3/F
	 MsT1BpBxl/E43pGOflZfQGOG9EmrEy0FHn58jHV5i2v0Epayk121/XYalC/ipD+xGo
	 5SnQKHktdJhmH8CKDDfE32FjIAu9Xkihu3rXoWuEEXpqC6AiLxc+ZdQz5ldtSadbB9
	 9gJWcjc0H4d/Q==
Message-ID: <6777df67-e6db-4f11-a971-9627fe86765e@kernel.org>
Date: Tue, 13 Jan 2026 08:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci:
 deprecate 'firmware-name' property
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
 johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
 <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
 <76d1c3ad-d648-4719-b016-1f16b195e64c@kernel.org>
 <0ad4722d-1557-4d8d-ae45-c0fdf893067f@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <0ad4722d-1557-4d8d-ae45-c0fdf893067f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2026 20:51, Jeff Johnson wrote:
> On 12/11/2025 7:23 PM, Krzysztof Kozlowski wrote:
>> On 11/12/2025 17:44, Jeff Johnson wrote:
>>> On 12/3/2025 11:11 PM, Miaoqing Pan wrote:
>>>> The firmware-name property was introduced to allow end-users and
>>>> integrators to select usecase specific firmware for the WCN6855.
>>>> However, specifying firmware for an M.2 WLAN module in the Device
>>>> Tree is not appropriate. Instead, this functionality will be handled
>>>> within the ath11k driver.
>>>>
>>>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>>>> ---
>>>>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>>> index e34d42a30192..0162e365798b 100644
>>>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>>> @@ -37,6 +37,7 @@ properties:
>>>>  
>>>>    firmware-name:
>>>>      maxItems: 1
>>>> +    deprecated: true
>>>>      description:
>>>>        If present, a board or platform specific string used to lookup
>>>>        usecase-specific firmware files for the device.
>>>
>>> The driver patch completely removes support for this, so is this really
>>> considered deprecated? Or should this actually be considered obsolete and
>>
>> That's silent ABI break. I will formally NAK the patch.
>>
>>
>>> completely removed?
>>>
>>> Do any DTS files actually reference this?
>>>
>>> /jeff
>>
>>
>> Best regards,
>> Krzysztof
> 
> Krzysztof,
> Can you check the v2 to see if you still want to NAK?
> 
> https://msgid.link/20251214025230.716387-3-miaoqing.pan@oss.qualcomm.com
> 

First, yes, still NAK.

Second, that patch faked Rob's tag, so it is unacceptable!

Best regards,
Krzysztof

