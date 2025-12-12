Return-Path: <linux-wireless+bounces-29700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98DCB7C02
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82EFB303E3DB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A02D46DD;
	Fri, 12 Dec 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2x4n1pF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605B2C0290;
	Fri, 12 Dec 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509833; cv=none; b=ZOZDOg7u+8EvTNHB+PS7mJ7Tr1jHqI27mIdmBsdvUd3tQ/8HdtoZRQvcRI6nlq25av6jPV3LJvmoBZuFPWQreFD4f9Q+zQzePV3iiICks0HE0EbZ2lT8US0yWQ6XnSvYNeUaohc/xM55no4Tz9tvblxL1IxnubxKi+boNowzJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509833; c=relaxed/simple;
	bh=K8jcmDfwawGDO1MmNxAbMFp3nfxo1X3GQ2tU2FUVSHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss5/fu8VO8kvPKhubF2vXXWeMSEiu7KHiNA9eg8aEsY/MMlxc4B9Q2p0z0icSWDQFBRQIO9Q9p0w3YROSeKknDt31UzjiyqIlTWacUSd4g8F6KerlvUMCz54v8chHKLqANomrnL3b7lXjkfhwZchOV0WrbnBYue17pWcwNKm/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2x4n1pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6DDC4CEF1;
	Fri, 12 Dec 2025 03:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765509831;
	bh=K8jcmDfwawGDO1MmNxAbMFp3nfxo1X3GQ2tU2FUVSHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k2x4n1pFApHVeRJGUl6UCS+KP4iRRxoC6wpsdzoD+/L0NsdyeMaIRSmN+scRE+w+V
	 RE2bdmy1Eb2iGH/GQc65hc3LWHSWy+f7JoVuVVjF/0+4W5ZkvV1poaoq2lI7liqykJ
	 70D1czMNqG+zVM77tDUv5QtXRB3+1cYAfFXVPnP0l9C4j3CPmCGhLfmMJsuoqY8+RQ
	 Y++h6Q4RQflF3a/BQyk1uhMQKEcJ8GAUITq4Go5pgnXNou9lWO7N4kiog972mC8pHf
	 EWZcn6Si2mlUudrXf+n2uR28MUC31vlUaCQDtbvj47Cglk2VBtacxpmUNDszEyqvp9
	 zpmRspQmXtTew==
Message-ID: <76d1c3ad-d648-4719-b016-1f16b195e64c@kernel.org>
Date: Fri, 12 Dec 2025 04:23:45 +0100
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2025 17:44, Jeff Johnson wrote:
> On 12/3/2025 11:11 PM, Miaoqing Pan wrote:
>> The firmware-name property was introduced to allow end-users and
>> integrators to select usecase specific firmware for the WCN6855.
>> However, specifying firmware for an M.2 WLAN module in the Device
>> Tree is not appropriate. Instead, this functionality will be handled
>> within the ath11k driver.
>>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> index e34d42a30192..0162e365798b 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> @@ -37,6 +37,7 @@ properties:
>>  
>>    firmware-name:
>>      maxItems: 1
>> +    deprecated: true
>>      description:
>>        If present, a board or platform specific string used to lookup
>>        usecase-specific firmware files for the device.
> 
> The driver patch completely removes support for this, so is this really
> considered deprecated? Or should this actually be considered obsolete and

That's silent ABI break. I will formally NAK the patch.


> completely removed?
> 
> Do any DTS files actually reference this?
> 
> /jeff


Best regards,
Krzysztof

