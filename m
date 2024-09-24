Return-Path: <linux-wireless+bounces-13102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E47983FE8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4B71C2171C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10249149C54;
	Tue, 24 Sep 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNRhIx7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BF54FAD;
	Tue, 24 Sep 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165228; cv=none; b=o2KP4U5JkTjRIUXvhTEWqM9iB6xBiYM49TI5nBxz8fMWk/JPbUv5+WtgT2YYrOW0guQQNfVZ3KN6VmTI8W/bj+/H7fNzRovq4pTSuyutWX8dAcQ5c6Xz0nS6ELIVwOLgK1WlmoMAPTyIcX8TECXRGFKaTrizN+FCzPq0EGxJdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165228; c=relaxed/simple;
	bh=a2Dn3WT4VdIDoop+yzc4TcQvYYUfuBFPswfp8kYSdlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBfH+lhwn6jJYIjmB+K6NNR7NqgJeSvDfyPtKjxPZtpjiGOZKOhSguc2NpXO9rBAjUtamXc8pKIlwTH8xwSxLCMMdkAHMVPUbQiSo8RAAoV+bMjZbn9tD5BR3caJ/c2XPtasGHAdzi5Orz1dhve3Uoa5gIeX21CwMqiUWmSeDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNRhIx7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3692C4CEC4;
	Tue, 24 Sep 2024 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727165227;
	bh=a2Dn3WT4VdIDoop+yzc4TcQvYYUfuBFPswfp8kYSdlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tNRhIx7khdwOILljzAB+UM3PQR51e0nrat4kCTr+65whkR5G7kBGajI7YJGcF/MRL
	 kub2U8oNm5D3HToJhHR6GY1noDz7Uj1DIvO02N4MYbHLVV9DuLImufkyKRGl44yi45
	 dEBWJTQf/ROLveFllr6TyRWgyJrPjLEhl3wYrUB8/nmyEuv3jYIrIHuAkM2AOSoyPy
	 5bl2LwqKRVOXqEKH1S2fnNtapiP1GUX6VwC7lS/WMzF9BlTTJ8DGsYHu5HYBH4lYRI
	 i5kKPORLKnjp3MWLCnyIT9nWqWAQGx+qdH0qks8d0tuvPpob9z1SFhLOvMDhz2BUKO
	 KRO6K76Y85icQ==
Message-ID: <1e79d94e-2f83-4762-b126-ed865142f1ed@kernel.org>
Date: Tue, 24 Sep 2024 10:06:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <20240814082301.8091-1-brgl@bgdev.pl>
 <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org> <87msk49j8m.fsf@kernel.org>
 <ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org> <87a5g2bz6j.fsf@kernel.org>
 <CAMRc=MeLick_+Czy5MhkX=SxVvR4WCmUZ8CQ5hQBVTe2fscCPg@mail.gmail.com>
 <b7fdafd6-5029-4b80-b264-11943740b354@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <b7fdafd6-5029-4b80-b264-11943740b354@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2024 23:02, Jeff Johnson wrote:
> On 9/20/2024 1:22 AM, Bartosz Golaszewski wrote:
>> On Fri, 20 Sep 2024 08:45:56 +0200, Kalle Valo <kvalo@kernel.org> said:
>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>
>>>> On 19/09/2024 09:48, Kalle Valo wrote:
>>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>>
>>>>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>>>>
>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>> ---
>>>>>>> v1 -> v2:
>>>>>>> - update the example
>>>>>>
>>>>>> I don't understand why this patch is no being picked up. The code
>>>>>> correct represents the piece of hardware. The supplies should be
>>>>>> required, because this one particular device - the one described in this
>>>>>> binding - cannot work without them.
>>>>>
>>>>> I have already explained the situation. With supplies changed to
>>>>> optional I'm happy take the patch.
>>>>
>>>> You did not provide any relevant argument to this case. Your concerns
>>>> described quite different case and are no applicable to DT based platforms.
>>>
>>> Ok, I'll try to explain my concerns one more time. I'll try to be
>>> thorough so will be a longer mail.
>>>
>>> In ath11k we have board files, it's basically board/product specific
>>> calibration data which is combined with the calibration data from chip's
>>> OTP. Choosing the correct board file is essential as otherwise the
>>> performance can be bad or the device doesn't work at all.
>>>
>>> The board files are stored in board-2.bin file in /lib/firmware. ath11k
>>> chooses the correct board file based on the information provided by the
>>> ath11k firmware and then transfers the board file to firmware. From
>>> board-2.bin the correct board file is search based on strings like this:
>>>
>>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255
>>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255,variant=HO_BNM
>>>
>>> But the firmware does not always provide unique enough information for
>>> choosing the correct board file and that's why we added the variant
>>> property (the second example above). This variant property gives us the
>>> means to name the board files uniquely and not have any conflicts. In
>>> x86 systems we retrieve it from SMBIOS and in DT systems using
>>> qcom,ath11k-calibration-variant property.
>>>
>>
>> No issues here.
>>
>>> If WCN6855 supplies are marked as required, it means that we cannot use
>>> qcom,ath11k-calibration-variant DT property anymore with WCN6855 M.2
>>> boards. So if we have devices which don't provide unique information
>>> then for those devices it's impossible to automatically to choose the
>>> correct board file.
>>>
>>
>> What you're really trying to say is: we cannot use the following snippet of
>> DTS anymore:
>>
>> 	&pcie4_port0 {
>> 		wifi@0 {
>> 			compatible = "pci17cb,1103";
>> 			reg = <0x10000 0x0 0x0 0x0 0x0>;
>>
>> 			qcom,ath11k-calibration-variant = "LE_X13S";
>> 		};
>> 	};
>>
>> First: it's not true. We are not allowed to break existing device-tree sources
>> and a change to the schema has no power to do so anyway. You will however no
>> longer be able to upstream just this as it will not pass make dtbs_check
>> anymore.
>>
>> Second: this bit is incomplete even if the WCN6855 package is on a detachable
>> M.2 card. When a DT property is defined as optional in schema, it doesn't
>> mean: "the driver will work fine without it". It means: "the *hardware* does
>> not actually need it to function". That's a huge difference. DTS is not a
>> configuration file for your convenience.
>>
>>> So based on this, to me the correct solution here is to make the
>>> supplies optional so that qcom,ath11k-calibration-variant DT property
>>> can continue to be used with WCN6855 M.2 boards.
>>>
>>
>> No, this is the convenient solution. The *correct* solution is to say how the
>> ath11k inside the WCN6855 package is really supplied. The dt-bindings should
>> define the correct representation, not the convenient one.
>>
>> Let me give you an analogy: we don't really need to have always-on, fixed
>> regulators in DTS. The drivers don't really need them. We do it for
>> completeness of the HW description.
> 
> Again, since I'm a DT n00b:
> Just to make sure I understand, you are saying that with this change any
> existing .dts/.dtb files will still work with an updated driver, so the new
> properties are not required to be populated on existing devices.

Did you folks rejected patches acked by DT maintainers on basis of not
understanding DT at all?

> 
> However a new driver with support for these properties will utilize them when
> they are present, and the current ath11k .dts files will need to be updated to

It is not related to drivers at all. Nothing in this thread is related
to drivers.

Can we entirely drop the drivers from the discussion?

> include these properties for pci17cb,1103, i.e. the following needs updating:
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> &pcie4_port0 {
> 	wifi@0 {
> 		compatible = "pci17cb,1103";
> 		reg = <0x10000 0x0 0x0 0x0 0x0>;
> 
> 		qcom,ath11k-calibration-variant = "LE_X13S";
> 	};
> };
> 
> 

Best regards,
Krzysztof


