Return-Path: <linux-wireless+bounces-30942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C763CD39F5F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 08:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7E7F30038FA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099192D6605;
	Mon, 19 Jan 2026 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsT18kyi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972D23D7C2;
	Mon, 19 Jan 2026 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806530; cv=none; b=AG4QpQLd9skY20fz7Vk3G1imqQuSecR1gOUAwnJbOMB8wiISJ22bnoyN11X7JiWFkcF6BoyTmhC9QKeArG2Li6GmYpebtxwQtdpPMvE9tyzc32j6QnApTREmAEfwlK2GWU9kO8+CM2+gfIwc6/Xh/ndpLVnjQZcCWvMaa7wI4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806530; c=relaxed/simple;
	bh=Sf9Qag5sQq/fRppPH89dGKFv69SIFR5u5qzbq0odql4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onn15Exbf4xObV+lHX3HfeIxxi4yDiRmRYLL5IV2tvJSgjwQiN6PUR2vf44ILX6NDQYWblItsTGf5eFeu+Pu2sbZXCUN+jT8PnHm9bJbWFLWF2qz9InMvp/GOs8xQFL0/XsAseeEvF7pmNGwu5YdL280rgoc2E0YqJQmN2cNt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsT18kyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D74EC16AAE;
	Mon, 19 Jan 2026 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806530;
	bh=Sf9Qag5sQq/fRppPH89dGKFv69SIFR5u5qzbq0odql4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CsT18kyiRQaGh8TEQRoIAYxAZN7skvafvgPvDvQ7QH/sbA8zLRTtfxMiakrWXjQQg
	 2XbYJFmYAW8CPdggAjHBdhXFJB8jxbKkbtDsYCJaTVys+aXzZU82k0D2G4/9SzyALb
	 BLf+l0WLMiHmwcoIqQobgXSKA/UlpUx6zUkCLsK7FlAiXdqdzeYxKkYxXo8EK34ezh
	 vJwYvGdjgWnMzhvvQWCUPKy9dZXBKvOtAJunO2J3HI+6SCSIjcGAAHlZnc5gx8rbxJ
	 Zv7txaM9TiszMp2+Ld4xQ/QdzofG8rMdDe2xJKLFJ+tqwYvQodNX1GfO1M1k0ZeGMQ
	 PKaa11uYjiqCA==
Message-ID: <a62401d4-0008-4a69-874a-1870fb690886@kernel.org>
Date: Mon, 19 Jan 2026 08:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-current 2/2] dt-bindings: net: wireless:
 ath11k-pci: remove obsolete firmware-name property
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
 johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
 <20251214025230.716387-3-miaoqing.pan@oss.qualcomm.com>
 <fa997674-402a-41cf-9334-f7fc89ae5ebc@kernel.org>
 <4562bdbc-9811-4f73-bc4b-f5a62ba1c965@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <4562bdbc-9811-4f73-bc4b-f5a62ba1c965@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/2026 02:34, Miaoqing Pan wrote:
> 
> 
> On 1/13/2026 3:28 PM, Krzysztof Kozlowski wrote:
>> On 14/12/2025 03:52, Miaoqing Pan wrote:
>>> The firmware-name property was introduced to allow end-users and
>>> integrators to select usecase specific firmware for the WCN6855.
>>> However, specifying firmware for an M.2 WLAN module in the Device
>>> Tree is not appropriate. Instead, this functionality will be handled
>>> within the ath11k driver.
>>>
>>> The driver has removed all support for firmware-name, and no upstream
>>> Device Tree files reference this property. Therefore, this patch
>>> removes the property from the binding and marks it as obsolete.
>>
>> No, it does not mark it obsolete. Point me to the place.
>>
>>>
>>> This is a DT ABI-breaking change, but safe since there are no in-tree
>>> users.
>>
>> It's not safe. What about my board using this WiFi? Or Mr. foo's board?
>>
>> Still NAK, you did not improve it.
>>
>>
> 
> I think it’s necessary to clarify the background here. As you can see 
> from the git log, all changes related to ath11k firmware-name were 
> submitted by me, and the intention was to allow the lemans-evk, 
> monaco-evk, and hamoa-iot-evk boards to specify dedicated firmware for 
> the WCN6855 Wi-Fi chip. However, the Wi-Fi‑related DTS nodes for these 
> boards have never been submitted upstream, because adding a 
> firmware-name property for an M.2 device is not appropriate and would be 
> difficult for the community to accept. Therefore, the original approach 
> was abandoned.

You added new ABI which can be used by anyone and your commit did not
help me to understand the impact on other users of this ABI.

> 
> The alternative solution is to propose a static lookup table that maps 
> device compatibles to firmware names. As a result, we have not submitted 
> any DTS patches adding firmware-name for those boards to date. This is 
> why I believe that removing firmware-name from the bindings is safe.
> 
> If this explanation is still not sufficient, please let me know what 
> additional steps are required for accepting these two patches. Thank you.

You need to deprecate the property and keep the ABI backwards compatible.

Best regards,
Krzysztof

