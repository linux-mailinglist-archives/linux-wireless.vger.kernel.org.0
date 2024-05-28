Return-Path: <linux-wireless+bounces-8186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4E8D182B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC668B26D34
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02B157E61;
	Tue, 28 May 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcNq45Mm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA7F9DA;
	Tue, 28 May 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891076; cv=none; b=nxkKr2ft9uJSnKcngU7PGNUZPVUreEWiIXvWEtHTEhRavZwzoZMG6A2BZJkWUvX4cGE/VWykMsvL9EuMnZM2OdcE97taNd986PHLmG+H9lkia8RHOLySuIrsSu7XvXnFGlXxj24TVnc882yY39m2VyizQ0qbo3oO6TcdRR1SMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891076; c=relaxed/simple;
	bh=3ri47Jw8bG0xrz0cHD1t6SSVNIySHKS61lpPF53h+3s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iX/URjNCb+bvi/1QSAtRArNHauieVzybVd7fuJgW3Lq+9sAdO9/fmVXLaDN1vMJWfvPCNiWoNvfXt1UyH40jv//QBNs+LIVQbh3AQtqpwyJaZHjnjQbl5QsUf6rgS2+ePE2qbnLVWlSFhZXHylyiLLEzPXWmfjy0sgdRthd9GlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcNq45Mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3848C3277B;
	Tue, 28 May 2024 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716891076;
	bh=3ri47Jw8bG0xrz0cHD1t6SSVNIySHKS61lpPF53h+3s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UcNq45MmR80f7cpnqo6wlB59u/UPMXeA2qZWe17HnnDwofjLwb/jyu2ucUmG7HrwR
	 TVdIYyKpguUruLYx1B5gLFLhlivJLKRFJxq9x9BaX3I+nqDvSS6eePT3x6sdVpys2U
	 61tAs6AUmhpT8QdvpUpyiZVk3DGgeF/MnqpsUHDEcnN6pIN2mvUGyNfPK9XN8+N/w0
	 5SstgHQlBn6qvkiI037eeAf3eqgMtJY0bHE+7X8zlpYXIn/lQwkFHrqVnCbk8Vkqud
	 TPhhPW0qrnj6esSfQRQzzfJlP+BN+uoyS7w++RpTtPK2QGto3g1mRAAmVABGNBtVnu
	 7kzjDGhmLq8Fg==
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
Date: Tue, 28 May 2024 13:11:10 +0300
In-Reply-To: <3464a980-36a7-4ed2-b2dc-be8fd9091b06@freebox.fr> (Marc
	Gonzalez's message of "Tue, 28 May 2024 11:54:37 +0200")
Message-ID: <87zfsa6ybl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 13/05/2024 16:16, Kalle Valo wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> The ath10k driver waits for an "MSA_READY" indicator
>>> to complete initialization. If the indicator is not
>>> received, then the device remains unusable.
>>>
>>> cf. ath10k_qmi_driver_event_work()
>>>
>>> Several msm8998-based devices are affected by this issue.
>>> Oddly, it seems safe to NOT wait for the indicator, and
>>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>>
>>> Jeff Johnson wrote:
>>>
>>>   The feedback I received was "it might be ok to change all ath10k qmi
>>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>>   (and ath12k) do not wait for it.
>>>
>>>   However with so many deployed devices, "might be ok" isn't a strong
>>>   argument for changing the default behavior.
>>>
>>> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
>>> work-around in the driver. However, firmware-5.bin is parsed too late.
>>> So we are stuck with a DT property.
>>>
>>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> 2 patches applied to ath-next branch of ath.git, thanks.
>> 
>> 71b6e321e302 dt-bindings: net: wireless: ath10k: add
>> qcom,no-msa-ready-indicator prop
>> 6d67d18014a8 wifi: ath10k: do not always wait for MSA_READY indicator
>
> Hello Kalle,
> What version of Linux will these be included in?
> (I don't see them in v6.10-rc1. Are they considered
> a new feature, rather than a fix, and thus 6.11?)

Yeah, these commits will go to v6.11. Because of the multiple trees
involved (ath-next -> wireless-next -> net-next -> linus) we need to
have ath.git pull request ready well before the merge window opens and
these commits missed the last pull request.

Yes, we are slow :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

