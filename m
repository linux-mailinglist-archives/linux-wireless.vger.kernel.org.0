Return-Path: <linux-wireless+bounces-13142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DA98536F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD25E1F24C88
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FB156220;
	Wed, 25 Sep 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs8FW5Ys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA04132103;
	Wed, 25 Sep 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248221; cv=none; b=GXfeKZtMmxn7QzyUHA1gvVTgqar7BVWRxmqvR6+TbxKtoMX90965jwW8Qh/0MSutveZQbkD+qUwJdHrtMwwZcL3mtmGsQFKS66w2qkOaEFVPSzyB5Wpt8O1+NfNhA/v6deka54TxJcIdXEdhF47YCZexm6FHww0Xf+07pG67HoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248221; c=relaxed/simple;
	bh=wykQV2o1lX+mZwLiNc+DAJYf+A3aFAUYe3LRR6OMPsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpYqh1Buw1rGW4zefyZJuxI1G5LIRcE+mIyyICMeuVg/ciYpSkelJXKqlOeNB7mEegO80TKNZp7IE4t6bYBnLJ9ih5VsgdDYu80mD9i7fGTp8fItPS13aMsVuAYVqnpfoYDTkceqGti7NCUsovun0/0CdkEU32ga/tL9cRRVvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs8FW5Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF976C4CEC3;
	Wed, 25 Sep 2024 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727248221;
	bh=wykQV2o1lX+mZwLiNc+DAJYf+A3aFAUYe3LRR6OMPsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vs8FW5YsSY5YXTYivLUIxGiuR9d78FN6XL1p4gP/jP/T8Xdli8m4ZsifEJ/rpP+km
	 DaZRGbVcY3D8Ay2KKM7Of+LzxTr2JNFwgPxYdQWpcMdqxy+gndEgqTtjRvljP0ff2q
	 V2Ycf3VuUg8eynn8Du+t3KSqcx+nVP+KKmYZGQ0BKxZgRMi1jdj2ZlvBtmHMardtBx
	 b5YcbIugEPGSEY6O6ThPHycDjQRRlBRqh1VdQJaMEwZEszMtOoDWu/jIYX+c4JPB3y
	 tBSNhWe5GxrQI6VIIBlJcRZsceP5lIJK3FS6RpQZHRtIizDMLwBRzCq3T8c0RJ/b6T
	 CGZ8hOhqJRdnQ==
Message-ID: <04fc202a-ac1c-44c9-ba67-8809e45ef940@kernel.org>
Date: Wed, 25 Sep 2024 09:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 <3ba2ce52-4da3-4066-baf0-5bab1a9f872a@kernel.org> <87zfnw8eb2.fsf@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <87zfnw8eb2.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 07:58, Kalle Valo wrote:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
> 
>> On 20/09/2024 08:45, Kalle Valo wrote:
>>
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
>>> If WCN6855 supplies are marked as required, it means that we cannot use
>>> qcom,ath11k-calibration-variant DT property anymore with WCN6855 M.2
>>> boards. So if we have devices which don't provide unique information
>>
>> No, it does not mean that.
>>
>>> then for those devices it's impossible to automatically to choose the
>>> correct board file.
>>
>> Anyway, only this device must be fully described, because you cannot
>> have pci17cb,1103 without these supplies. It's just electrically not
>> possible, according to our investigation.
> 
> Yeah, you have been telling that all along. But on the contrary I have
> WCN6855 (pci17cb,1103) M.2 board which I installed to my NUC and they
> haven't needed any supplies (unless BIOS does something automatically).

That's a ACPI system, so ACPI and complex drivers handle this.

> Also I have QCA6390 and WCN7850 M.2 boards, both which you claim needs
> the supplies, and they just work out-of-box as well. So I have a hard

On DT platform they work by coincidence or "work mostly". Ppwer
sequencing work fixes it.

> time trusting your spec and believing it's the ultimate authority. To me
> if reality and spec doesn't match, reality wins.

You miss concepts of DT. Really.

You can skip in DT many regulator supplies, which are enabled by default
(e.g. by bootloader). And what? Everything will work fine even if Linux
kernel requires them. Driver will probe fine, hardware "will work".

Still the regulators *are required* by DT rules and we have been telling
you this so many times already.

That's not a difference case here.

> 
>>> So based on this, to me the correct solution here is to make the
>>> supplies optional so that qcom,ath11k-calibration-variant DT property
>>> can continue to be used with WCN6855 M.2 boards.
>>
>> WCN6855 can still do whatever they want. They are not restricted, not
>> limited. pci17cb,1103 must provide suppplies, because pci17cb,1103
>> cannot work without them.
> 
> Claiming that WCN6885 can still do whatever they want is confusing to me
> because WCN6855 is pci17cb,1103, there are no other ids. See
> ath11k/pci.c:
> 
> #define WCN6855_DEVICE_ID		0x1103
> 
> { PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
> 
> But this discussion is going circles and honestly is waste of time. I
> don't think the patch is right but I'll apply it anyway, let's deal with
> the problems if/when they come up.

For me, there could be different WCN6885 chips, flavors or PCI cards.
The binding speaks only about given PCI device.

Best regards,
Krzysztof


