Return-Path: <linux-wireless+bounces-6827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668158B1E43
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5BD281678
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161884FCD;
	Thu, 25 Apr 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC5k7vw8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9584FA5;
	Thu, 25 Apr 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038147; cv=none; b=X4hQOJySgxzyoxd/Jpgkf+aidx/U+AKC+D/QovpDogYuDh/yr+ry+Wcf3DJKVTJLtOFGPzaFqx6Pft5UQ5b7SbBMxkkU6fkyO9jNP07dMs7XR9st8txoSBNT1NxrcMjauOMM8MzOyPO65hGccBQtGIiEoxCNbi24ouZlrXNZbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038147; c=relaxed/simple;
	bh=3T9FjsUymGNFdluw54Z0v54M1QVaVyL3oEp/dxeaIlg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ogMNLaK0O+bmhAFXV6P2lQhEN+5M3V0VY7juCrt93o+9uNZt24CKOP3OQSSVfDff7BW58svp59H79PnzxA3xxJ8WRLDJoH1VpI67I5Ro1TRsjGSmgiRP2LYYdENACsEPPOk1NSmwsPH+cZ2qLh+VGchC34ITkm5sqQcNbr2ivy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC5k7vw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD23C113CC;
	Thu, 25 Apr 2024 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714038146;
	bh=3T9FjsUymGNFdluw54Z0v54M1QVaVyL3oEp/dxeaIlg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cC5k7vw8ltoalYvDhw0Jk6rN6jkchple0+rnrvgR+80LMeiwhC7qraCbaq5wl53v5
	 Xhw49PZ7Ulsh0qB7iFzNSR2Y7ziceOxydyqP7+hniRpox875fDZUJwqH1BMJHHPb/E
	 nUNiAR+NkWWY/MJuG/eLOTrdjCt/FHTRwLA7ZQZMawUjeA4GnPv0gaPBjal3nFaUm4
	 b8w1o8GCivxXCXnzE7l+qeVrErJH6vHFnwJIV9hsdhclc2+Lnkt/guc/I9hx8RfhTo
	 r1IYqbCKAZ7MtT40/G4seDFTQPsnLmED+pvHyzloW76OZrQGPReFfKsgCS+VgKTSSV
	 9LBhzNUN/C67A==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  Arnaud Vrac
 <avrac@freebox.fr>,  Bjorn Andersson <andersson@kernel.org>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Marijn Suijten
 <marijn.suijten@somainline.org>,  Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
	<5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
	<252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
	<502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
	<0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
	<CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
	<87ttkh49xi.fsf@kernel.org>
	<e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
	<87h6gh406w.fsf@kernel.org>
	<ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
Date: Thu, 25 Apr 2024 12:42:20 +0300
In-Reply-To: <ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr> (Marc
	Gonzalez's message of "Mon, 8 Apr 2024 17:53:01 +0200")
Message-ID: <871q6tu6bn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 04/04/2024 17:28, Kalle Valo wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> On 04/04/2024 13:57, Kalle Valo wrote:
>>>
>>>> Dmitry Baryshkov wrote:
>>>>
>>>>> I'd say, we should take a step back and actually verify how this was
>>>>> handled in the vendor kernel.
>>>>
>>>> One comment related to this: usually vendor driver and firmware branches
>>>> go "hand in hand", meaning that a version of driver supports only one
>>>> specific firmware branch. And there can be a lot of branches. So even if
>>>> one branch might have a check for something specific, there are no
>>>> guarantees what the other N+1 branches do :/
>>>
>>> The consequences and ramifications of the above comment are not clear to me.
>>>
>>> Does this mean:
>>> "It is pointless to analyze a given version (or even several versions)
>>> of the vendor driver downstream, because there are exist a large number
>>> of variations of the code." ?
>> 
>> I was trying to say that because the design philosophy between vendor
>> drivers and upstream drivers is very different, we can't 100% trust
>> vendor drivers. It's a very good idea to check what vendor drivers do
>> but we just need to be careful before making any conclusions. Testing
>> real hardware (and corresponding firmware) is the most reliable way to
>> know how different products/firmware work, unfortunately.
>> 
>>> And thus, "it is nonsensical to try to "align" the mainline driver to
>>> "the" vendor driver, as there is no single "vendor driver"" ?
>> 
>> No no, I'm not saying that. I have suffered this "N+1 different firmware
>> branches behaving slighly differently" problem since ath6kl days so for
>> me this is business as usual, sadly. I'm sure we can find a solution for
>> ath10k.
>
> Hello Kalle,
>
> I can spin a v3, no problem.
>
> Do you prefer:
>
> Option A = never waiting for the MSA_READY indicator for ANYONE
> Option B = not waiting for the MSA_READY indicator when
> qcom,no-msa-ready-indicator is defined
> Option C = not waiting for the MSA_READY indicator for certain
> platforms (based on root compatible)
> Option D = some other solution not yet discussed

After firmware-N.bin solution didn't work (sorry about that!) my
prerence is option B.

> Dmitry has tested Option A on 5 platforms, where it does not induce regressions.
> I worked on msm8998, where Option A (or any equivalent) unbreaks WiFi.

What do you mean here? Are you saying that option A works on all
devices? I'm guessing I'm misunderstanding something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

