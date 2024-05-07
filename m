Return-Path: <linux-wireless+bounces-7295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B8B8BE9FC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458EB284799
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A436B672;
	Tue,  7 May 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp62IfUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B698F72;
	Tue,  7 May 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101397; cv=none; b=Fs+JO+13ldgryiHzWqr7Idz0K4tFl9nPllDBmsrlQVc3wu33SpuZrpAcZ/KhbpLbdiuSEHg5BGRMYOWb2fyB731/LPN+wJwS26hixagJbIj27AXa82cZyFtUjNg4hgv35OeYy0cQhv6amfWRmF52/66epUYA+9R5EA6bakmMxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101397; c=relaxed/simple;
	bh=JY4JlehBy4I/fksm3Z77C48WISuUolTNAQAzgcu5WVw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m7Jh16jwZl2io2E4TTxNfWoF6Wd2AMNHTsVJUfkG8EJ23soDcVTy1ZxV6rKUgmT0XeTCagzcL7uScDHDUdrvSCstUTS9AO+XIXmr+Sof/VEnXdZw9qrwe05LGJwFniPwM2heMBDsdCoGMcyI/aASXyj2CykKTAIvrhmvxfGdxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp62IfUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9CC4AF18;
	Tue,  7 May 2024 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715101396;
	bh=JY4JlehBy4I/fksm3Z77C48WISuUolTNAQAzgcu5WVw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Fp62IfUqShXQVdU1revI8fTwgbnsu4WNnpZmfjuXU8QFdOUdob8A4Pfh+h74pxmnw
	 vxlSzB3e8dJIBEdUcTdWZEFbofHH0FZ54LOcv5GV8mfBAppBrjYVzRLHVY1bqOyM0A
	 afAwTi9FZ++FiB2uIzZKj7xVHMj4S92gqYXsPr/R7Hfw/i4/cY3tFidnfFgtp5ZHGx
	 WJg7GgkmFZh17431vQAB9QX6DyHwOC3v07uyLGiXhX0bwXoX5giD23BLV4adigUwIb
	 +9YLuRDccxFzSyUXDM/nl/blj1RxMuiePMOxVakHcF1PAouVEp4VeclsoipJEE7Rgf
	 31juf237oj2Jw==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  Arnaud Vrac
 <avrac@freebox.fr>,  Bjorn Andersson <andersson@kernel.org>,  Konrad
 Dybcio <konrad.dybcio@linaro.org>,  Jami Kettunen
 <jamipkettunen@gmail.com>,  Jeffrey Hugo <quic_jhugo@quicinc.com>,  Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,  Alexey Minnekhanov
 <alexeymin@postmarketos.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
	<54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
	<ZjBV+th9DmnNLhnN@hu-bjorande-lv.qualcomm.com>
	<8734r3qysm.fsf@kernel.org>
	<b6a1eadf-477d-48a8-bf39-ac3c3191e929@freebox.fr>
Date: Tue, 07 May 2024 20:03:10 +0300
In-Reply-To: <b6a1eadf-477d-48a8-bf39-ac3c3191e929@freebox.fr> (Marc
	Gonzalez's message of "Tue, 30 Apr 2024 13:10:45 +0200")
Message-ID: <874jb9mu5t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 30/04/2024 06:06, Kalle Valo wrote:
>
>> Bjorn Andersson wrote:
>> 
>>> On Mon, Apr 29, 2024 at 04:04:51PM +0200, Marc Gonzalez wrote:
>>>
>>>> The ath10k driver waits for an "MSA_READY" indicator
>>>> to complete initialization. If the indicator is not
>>>> received, then the device remains unusable.
>>>>
>>>> cf. ath10k_qmi_driver_event_work()
>>>>
>>>> Several msm8998-based devices are affected by this issue.
>>>> Oddly, it seems safe to NOT wait for the indicator, and
>>>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>>>
>>>> Jeff Johnson wrote:
>>>>
>>>>   The feedback I received was "it might be ok to change all ath10k qmi
>>>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>>>   (and ath12k) do not wait for it.
>>>>
>>>>   However with so many deployed devices, "might be ok" isn't a strong
>>>>   argument for changing the default behavior.
>>>>
>>>> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
>>>> work-around in the driver. However, firmware-5.bin is parsed too late.
>>>> So we are stuck with a DT property.
>>>>
>>>> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
>>>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>>>
>>> This says "Pierre-Hugues certifies the origin of the patch" then "Marc
>>> certifies the origin of the patch". This would have to imply that
>>> Pierre-Hugues authored the patch, but you're listed as the author...
>>>
>>> Perhaps a suitable answer to this question would be to add
>>> "Co-developed-by: Pierre-Hugues ..." above his s-o-b, which implies that
>>> the two of you jointly came up with this and both certify the origin.
>> 
>> BTW I can add that in the pending branch, no need to resend because of
>> this. Just need guidance from Marc.
>
> I typed this patch all by myself with my grubby little paws.
> You can drop PH's S-o-b.

Thanks. Please check that my modifications in the pending branch are
correct:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=3aec20a8e797b28d32e75291cc070d5913bf6dab

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=df5b4bec31b0736a453d507762c5b3d098d5c733

I can freely edit commits in the pending branch, it's just a temporary
branch for testing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

