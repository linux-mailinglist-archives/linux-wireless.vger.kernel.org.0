Return-Path: <linux-wireless+bounces-13041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0097D154
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396722855D7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95D3CF6A;
	Fri, 20 Sep 2024 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txVSHtHW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393442D638;
	Fri, 20 Sep 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814762; cv=none; b=oUN1Y+6Q2cmRkdlDYL5a2iXC5gowGbvBgG2CvIQdGBrxBDcxC7j9CF5tAIqRKSLknfG8RZp72sr+rEU1gaadP8Z4ff0aCa2Oy3udK7OaB6Ecg7IA6KhwHC6D80d9fh71RT+M3gh/DrDAsfOdGKnLEyZ1CmWsANbPfLSDDqasykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814762; c=relaxed/simple;
	bh=apoiTdulUgf1Pl+6yC/F2xPSZOBOVYh4QJeaPl07Enw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ezju5U0cQJvXoVtpcYxsHdTUhWRXH10BvXPerxwdIlop0fVsrj+IBMNb+j8omCs99XbJfDUR7h0ubiUx4jS052OeLZEVk8mTrbtA9nG+mFunKbS54yAUvj7j3lPyhelEsDCj1ooyqlZOh7NxBd3MTZ0V5nrrFt9FteKridBM/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txVSHtHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22086C4CEC3;
	Fri, 20 Sep 2024 06:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726814761;
	bh=apoiTdulUgf1Pl+6yC/F2xPSZOBOVYh4QJeaPl07Enw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=txVSHtHWAOcsqSlJ41k9P8WYFLd56Z7Nyfv4Wo4jLHODXkLcZKMSFSQq60z6YuqnL
	 yLAYbsJBkz/rcIThUmchQr7C/xzmgTWA91csEKbrOovBWmBX0WV7tr9E6dM1B49zm3
	 Qojk8vJqpv5pEXTbYZZzcYgEdJMfo/QFfrB32/oofPBNTg4uuErfjZAiPYZGI9hVzG
	 qIZRnUfwKOQBmAisGoaBEiYwkInUNZardAmfsLZ5u+sX4YFH4Zh4AHJmeaZf/sIXPI
	 fgiAqfaz85hyK0lX5fo+YjoMGm1Sk/qxby17zdYrc1X0fdutV4Mp0GY37V1JjkKF0f
	 dZxnyHwDiXYOA==
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
 <bartosz.golaszewski@linaro.org>,
    Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl>
	<83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
	<87msk49j8m.fsf@kernel.org>
	<ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org>
Date: Fri, 20 Sep 2024 09:45:56 +0300
In-Reply-To: <ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 19 Sep 2024 12:00:53 +0200")
Message-ID: <87a5g2bz6j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 19/09/2024 09:48, Kalle Valo wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>> v1 -> v2:
>>>> - update the example
>>>
>>> I don't understand why this patch is no being picked up. The code
>>> correct represents the piece of hardware. The supplies should be
>>> required, because this one particular device - the one described in this
>>> binding - cannot work without them.
>> 
>> I have already explained the situation. With supplies changed to
>> optional I'm happy take the patch.
>
> You did not provide any relevant argument to this case. Your concerns
> described quite different case and are no applicable to DT based platforms.

Ok, I'll try to explain my concerns one more time. I'll try to be
thorough so will be a longer mail.

In ath11k we have board files, it's basically board/product specific
calibration data which is combined with the calibration data from chip's
OTP. Choosing the correct board file is essential as otherwise the
performance can be bad or the device doesn't work at all.

The board files are stored in board-2.bin file in /lib/firmware. ath11k
chooses the correct board file based on the information provided by the
ath11k firmware and then transfers the board file to firmware. From
board-2.bin the correct board file is search based on strings like this:

bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e0ca,qmi-chip-id=2,qmi-board-id=255,variant=HO_BNM

But the firmware does not always provide unique enough information for
choosing the correct board file and that's why we added the variant
property (the second example above). This variant property gives us the
means to name the board files uniquely and not have any conflicts. In
x86 systems we retrieve it from SMBIOS and in DT systems using
qcom,ath11k-calibration-variant property.

If WCN6855 supplies are marked as required, it means that we cannot use
qcom,ath11k-calibration-variant DT property anymore with WCN6855 M.2
boards. So if we have devices which don't provide unique information
then for those devices it's impossible to automatically to choose the
correct board file.

So based on this, to me the correct solution here is to make the
supplies optional so that qcom,ath11k-calibration-variant DT property
can continue to be used with WCN6855 M.2 boards.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

