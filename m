Return-Path: <linux-wireless+bounces-4209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A626986B51C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F1528BFDC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE11E4AB;
	Wed, 28 Feb 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvQtUCy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE51DFE8;
	Wed, 28 Feb 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138233; cv=none; b=VHineQQzAMtmvZb0SCuXzuhin7bvVJ4rcsGXhqWVi77xS5HgW2s9OlTyFYXkVjbzoOWZIRWxX+zVgRR0gyqfNlezd0INjCt+j443cPw+w6+2chRIc+xd3UrVkAU9aVYvgzsX1Q3OJPvo1L+0vLkjEiqOvgUuFEhivV7JbPzGAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138233; c=relaxed/simple;
	bh=yTUJ/M+wPQ4gGvQ4fFiBLW29NKAcpRhcIEmVc20oTGU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rSZPSZxhforvjL4Wauwj8WMnYEG25j70P6skW+p/5WGmGWgT5Hfs6Hax5OKVf8Qzi1fzq9AtOVentSlTI5M3ckGLjX35XX2QEwsrMrLkFvLhFZjMbpSK9HFPUZtzgRcbgQByRhXNLA5HQTM+C+0VRJ061UXyYYDhlYyZqr3Dtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvQtUCy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AA9C433F1;
	Wed, 28 Feb 2024 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709138232;
	bh=yTUJ/M+wPQ4gGvQ4fFiBLW29NKAcpRhcIEmVc20oTGU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JvQtUCy5wIC4CYR7yEIggs//wBz5ppRanFCwof2wNmEuFGGgkcRQk4SPfFiBUr9kH
	 giYdCseTJJbm0gk+v9nBWkRFiSzf32fCJ0lXlWrN4Wxkjtk3MLMgHxvMYmmkdsALIR
	 qAaeYy2RjNw6ONwnV5+yoP8uWQ5MIjY9Zb9ytVW1YSUx+ZmjD2JhxSKIaWj64bJqf8
	 STcpseRiS+7hpOs1o2K5n5U2Mq/+bG1MwZtKtZT9S6vdEIUog/+Opxp1tOezaQJYQg
	 BSXKClCnEEYtlNYAROrVsHX4s3IyAi78EwMLMIL4Y1yv9VGZ3Fnn4GugqciLgD4EEM
	 iIJQ0Xd+mTzgA==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k
 <ath10k@lists.infradead.org>,  wireless <linux-wireless@vger.kernel.org>,
  DT <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Pierre-Hugues Husson <phhusson@freebox.fr>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
	<b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
	<871q8wk7o3.fsf@kernel.org>
	<3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
Date: Wed, 28 Feb 2024 18:37:08 +0200
In-Reply-To: <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> (Marc
	Gonzalez's message of "Wed, 28 Feb 2024 17:12:11 +0100")
Message-ID: <87wmqoilzf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 28/02/2024 15:03, Kalle Valo wrote:
>
>> Marc Gonzalez writes:
>> 
>>> +  qcom,no-msa-ready-indicator:
>>> +    type: boolean
>>> +    description:
>>> +      The driver waits for this indicator before proceeding,
>>> +      yet some WCNSS firmwares apparently do not send it.
>>> +      On those devices, it seems safe to ignore the indicator,
>>> +      and continue loading the firmware.
>> 
>> This sounds more like a firmware feature, not a hardware feature. What
>> about having a flag in enum ath10k_fw_features in firmware-2.bin?
>
> Are you using the word "feature" as in "it was done purposefully" ?

No, there's no bigger meaning like that. It's more like ath10k has to do
something differently when a certain bit is enabled in the firmware. I
just had to pick a word for the enum and from my limited vocabulary I
chose "feature" :)

> Is enum ath10k_fw_features also supposed to include work-arounds?

Yes, and we already use.

> Sorry, I've grepped over the entire Linux source code,
> and I cannot find where ath10k_fw_features is used,
> other than in ath10k_core_get_fw_feature_str().

Here's one example where in ath10k we use a feature bit as a workaround:

	/* Don't trust error code from otp.bin */
	ATH10K_FW_FEATURE_IGNORE_OTP_RESULT = 7,

        ....

	if (!(skip_otp || test_bit(ATH10K_FW_FEATURE_IGNORE_OTP_RESULT,
				   ar->running_fw->fw_file.fw_features)) &&
	    result != 0) {
		ath10k_err(ar, "otp calibration failed: %d", result);
		return -EINVAL;
	}

BTW for modifying firmware-N.bin files we have a script here:

https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-fwencoder

> As mentioned in my other reply, there are several msm8998-based
> devices affected by this issue. Is it not appropriate to consider
> a kernel-based work-around?

Sorry, not following you here. But I'll try to answer anyway:

I have understood that Device Tree is supposed to describe hardware, not
software. This is why having this property in DT does not look right
place for this. For example, if the ath10k firmware is fixed then DT
would have to be changed even though nothing changed in hardware. But of
course DT maintainers have the final say.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

