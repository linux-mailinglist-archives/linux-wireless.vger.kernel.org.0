Return-Path: <linux-wireless+bounces-13139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C79852B5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 07:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3606A284483
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735E155300;
	Wed, 25 Sep 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A80vH/kQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB8647;
	Wed, 25 Sep 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243927; cv=none; b=SKcHVrO+D3CzygkEXMUWDko3gF8JeR08EW1x3J9QwudRplHwpyDw8n21SwrsElMm8GXYbEjYoQu7tlZV2qHeYcEg5YWocYg/UWiCkou2+RAAQmfeN2EApc7f8+6r5qiS0XdfAfQCnzq8HyaWZqkXnFpEs/XkIsm48Hyv88oWsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243927; c=relaxed/simple;
	bh=R5iO86c9PhBZIXFBuzoB9GO9RtZOAFqW+RKHK3yqFEo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I5aYQQADwfPxkZnEwXW5lrMn7XORmZ2NyBxWpCljlNANSP0zylsLXf6mcOAVgKJvu0HwlDflqaEEZJfeBK443zoGWErlBdv+cX09tVPrzPhF0CdRd77/FWI8FunxX4ugTKnamMjjkOuEjZY4FZLVsgCvatp5EGc9+1yLW58uB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A80vH/kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE1C4CEC3;
	Wed, 25 Sep 2024 05:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727243927;
	bh=R5iO86c9PhBZIXFBuzoB9GO9RtZOAFqW+RKHK3yqFEo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=A80vH/kQJWCU74aJSDRYFOgMTTr0Tb2L6qd6VlJYJBMVXVKTJSX0NPs9v+ea7Co3N
	 ROIFLvbErHcLPFiZbJWtXsVLAtXddNffbHXIW09pixr/Rz9MBm3YvZlwlIp5meNny4
	 x8R0OYaCGkfh+X7BeacihYg7vH+0phu+Ee2RKC21brT0AUYc9bHVFcak2KgWs1hcxh
	 KNKPWgJmT7SUafBDF8Op5n9ysqiWsTK31SfFmSI7e/xmfe/FY9i83/X1LL4j/cKidG
	 YqxbA98sGTKr1A87g8/gTw+oRP8bLKyT6fHRsAgvZgoiVr/S5GHZ5ACKnueveP6iwL
	 BuE/THconEoig==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl>
	<83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
	<87msk49j8m.fsf@kernel.org>
	<ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org>
	<87a5g2bz6j.fsf@kernel.org>
	<3ba2ce52-4da3-4066-baf0-5bab1a9f872a@kernel.org>
Date: Wed, 25 Sep 2024 08:58:41 +0300
In-Reply-To: <3ba2ce52-4da3-4066-baf0-5bab1a9f872a@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 24 Sep 2024 10:04:59 +0200")
Message-ID: <87zfnw8eb2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 20/09/2024 08:45, Kalle Valo wrote:
>
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 19/09/2024 09:48, Kalle Valo wrote:
>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>
>>>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>> ---
>>>>>> v1 -> v2:
>>>>>> - update the example
>>>>>
>>>>> I don't understand why this patch is no being picked up. The code
>>>>> correct represents the piece of hardware. The supplies should be
>>>>> required, because this one particular device - the one described in this
>>>>> binding - cannot work without them.
>>>>
>>>> I have already explained the situation. With supplies changed to
>>>> optional I'm happy take the patch.
>>>
>>> You did not provide any relevant argument to this case. Your concerns
>>> described quite different case and are no applicable to DT based platforms.
>> 
>> Ok, I'll try to explain my concerns one more time. I'll try to be
>> thorough so will be a longer mail.
>> 
>> In ath11k we have board files, it's basically board/product specific
>> calibration data which is combined with the calibration data from chip's
>> OTP. Choosing the correct board file is essential as otherwise the
>> performance can be bad or the device doesn't work at all.
>> 
>> The board files are stored in board-2.bin file in /lib/firmware. ath11k
>> chooses the correct board file based on the information provided by the
>> ath11k firmware and then transfers the board file to firmware. From
>> board-2.bin the correct board file is search based on strings like this:
>> 
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255
>> bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255,variant=HO_BNM
>> 
>> But the firmware does not always provide unique enough information for
>> choosing the correct board file and that's why we added the variant
>> property (the second example above). This variant property gives us the
>> means to name the board files uniquely and not have any conflicts. In
>> x86 systems we retrieve it from SMBIOS and in DT systems using
>> qcom,ath11k-calibration-variant property.
>> 
>> If WCN6855 supplies are marked as required, it means that we cannot use
>> qcom,ath11k-calibration-variant DT property anymore with WCN6855 M.2
>> boards. So if we have devices which don't provide unique information
>
> No, it does not mean that.
>
>> then for those devices it's impossible to automatically to choose the
>> correct board file.
>
> Anyway, only this device must be fully described, because you cannot
> have pci17cb,1103 without these supplies. It's just electrically not
> possible, according to our investigation.

Yeah, you have been telling that all along. But on the contrary I have
WCN6855 (pci17cb,1103) M.2 board which I installed to my NUC and they
haven't needed any supplies (unless BIOS does something automatically).
Also I have QCA6390 and WCN7850 M.2 boards, both which you claim needs
the supplies, and they just work out-of-box as well. So I have a hard
time trusting your spec and believing it's the ultimate authority. To me
if reality and spec doesn't match, reality wins.

>> So based on this, to me the correct solution here is to make the
>> supplies optional so that qcom,ath11k-calibration-variant DT property
>> can continue to be used with WCN6855 M.2 boards.
>
> WCN6855 can still do whatever they want. They are not restricted, not
> limited. pci17cb,1103 must provide suppplies, because pci17cb,1103
> cannot work without them.

Claiming that WCN6885 can still do whatever they want is confusing to me
because WCN6855 is pci17cb,1103, there are no other ids. See
ath11k/pci.c:

#define WCN6855_DEVICE_ID		0x1103

{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },

But this discussion is going circles and honestly is waste of time. I
don't think the patch is right but I'll apply it anyway, let's deal with
the problems if/when they come up.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

