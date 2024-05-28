Return-Path: <linux-wireless+bounces-8201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE58D1D2A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE6B248D1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A416F282;
	Tue, 28 May 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX5eCLNU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8616F0EE;
	Tue, 28 May 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903293; cv=none; b=CJ9UlO568gM2UxcXThPZL0HcneCWblg1Ia61AkfqLmqNAOB9+UPPz/B3drSodhevccCeYHxP/sjb1mW7xZ3ACV/6MOeh5is5o1b7oF7qhl6/GjRib1W4eVjnzZt5Hb65aY8pNpAdlvObd4EkQFCsX3OcvC9snztqwacvSCRfYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903293; c=relaxed/simple;
	bh=HYEUVFvQ0AFOAe6Mg1PVLA7v5KJlY+Zus+7fBlbTAXg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CcHmwJKTAlm3NqSgMtHmvooo0Yj8MbloMotFVu0asA5K3r4uRF60MgW66KAmEpCZF9BLoxRKTBDtusUhlnskhKkIGtiD6oTm/DMWeOlE3GpvtqXA+lSdzu6EqvuOwvBWL1KXfiBBNdJnhBJ9c+ArwTv+P6s4kZDeZIWZmVm0naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX5eCLNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB829C3277B;
	Tue, 28 May 2024 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903292;
	bh=HYEUVFvQ0AFOAe6Mg1PVLA7v5KJlY+Zus+7fBlbTAXg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rX5eCLNU6Fm9vqdBnA6842Fiou1S4TxlH/3hz033kiEMP6Ck48qW0PB8uogd1804n
	 +ut/G9g6eAxPzEhWPeQbbsB1fNzZvGEZamAuI/DzYe0p6OrPo1XZ+D9FiuYKGnMqSS
	 pNgzwTZV91ie+19z/8TSbfOQLu3JuXvOSctG8yRLBYeh9I3enQA3Q2hv8ryQrQmUXG
	 WlCTuGTKy7UrZgiBT1v8abVBYhuUh2j7C2qU9fSyYnv/CPO/xZoFqYFlbE4YBupq8u
	 9R2pnMp75/1jBZ3nPsmcvftQ9n3MfFIjnYAmMySSE3++EjC9Ee+g4BFweP3LMWVoDG
	 OeH9hvHsJvm9w==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Bjorn Andersson <andersson@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  Arnaud Vrac
 <avrac@freebox.fr>,  Konrad Dybcio <konrad.dybcio@linaro.org>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo
 <quic_jhugo@quicinc.com>,  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
  Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
	<171560975908.1690511.498631481702370762.kvalo@kernel.org>
	<3464a980-36a7-4ed2-b2dc-be8fd9091b06@freebox.fr>
	<87zfsa6ybl.fsf@kernel.org>
	<74ab64e2-9bb4-4e98-9f2f-f6402ba42c08@freebox.fr>
Date: Tue, 28 May 2024 16:34:46 +0300
In-Reply-To: <74ab64e2-9bb4-4e98-9f2f-f6402ba42c08@freebox.fr> (Marc
	Gonzalez's message of "Tue, 28 May 2024 14:36:02 +0200")
Message-ID: <87msoa6ow9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 28/05/2024 12:11, Kalle Valo wrote:
>
>> Marc Gonzalez writes:
>> 
>>> On 13/05/2024 16:16, Kalle Valo wrote:
>>>
>>>> Marc Gonzalez wrote:
>>>>
>>>>> The ath10k driver waits for an "MSA_READY" indicator
>>>>> to complete initialization. If the indicator is not
>>>>> received, then the device remains unusable.
>>>>>
>>>>> cf. ath10k_qmi_driver_event_work()
>>>>>
>>>>> Several msm8998-based devices are affected by this issue.
>>>>> Oddly, it seems safe to NOT wait for the indicator, and
>>>>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>>>>
>>>>> Jeff Johnson wrote:
>>>>>
>>>>>   The feedback I received was "it might be ok to change all ath10k qmi
>>>>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>>>>   (and ath12k) do not wait for it.
>>>>>
>>>>>   However with so many deployed devices, "might be ok" isn't a strong
>>>>>   argument for changing the default behavior.
>>>>>
>>>>> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
>>>>> work-around in the driver. However, firmware-5.bin is parsed too late.
>>>>> So we are stuck with a DT property.
>>>>>
>>>>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>>>>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>>
>>>> 2 patches applied to ath-next branch of ath.git, thanks.
>>>>
>>>> 71b6e321e302 dt-bindings: net: wireless: ath10k: add
>>>> qcom,no-msa-ready-indicator prop
>>>> 6d67d18014a8 wifi: ath10k: do not always wait for MSA_READY indicator
>>>
>>> Hello Kalle,
>>> What version of Linux will these be included in?
>>> (I don't see them in v6.10-rc1. Are they considered
>>> a new feature, rather than a fix, and thus 6.11?)
>> 
>> Yeah, these commits will go to v6.11. Because of the multiple trees
>> involved (ath-next -> wireless-next -> net-next -> linus) we need to
>> have ath.git pull request ready well before the merge window opens and
>> these commits missed the last pull request.
>> 
>> Yes, we are slow :)
>
> My understanding of the merging process was that
>
> - new features are queued for the next cycle,
> so vN+1-rc1, or vN+2-rc1 if the submission came too late (after ~rc6) in cycle N
>
> - fixes are queued for the fixes batch in the same cycle
>
> This patch series is handled like a feature rather than a fix?
> (To me, it fixed broken behavior in the FW, but I understand
> if the nature of the changes require a more prudent approach.
> Though they are disabled for everyone by default.)

So the path for ath10k/ath11k/ath12k fixes to current -rc release is:

ath-current -> wireless -> net -> linus

For new features going to the next release:

ath-next -> wireless-next -> net-next -> (in merge window) linus 

To reduce conflicts between trees most of the patches I apply go to
-next, I usually take only important regression fixes to -current. In
this case I didn't even consider taking the patches to -current as there
were changes in DT and I just assumed this is for -next. If you
considered otherwise I didn't realise it, sorry about that.

In future, if you think a patch should go to -current please mention it
somewhere, preferably something like tagging it with "[PATCH wireless]"
or "[PATCH ath-current]" etc. to document which tree it is for. Or just
as a simple reply.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

