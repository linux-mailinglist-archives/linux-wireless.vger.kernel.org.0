Return-Path: <linux-wireless+bounces-7217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E48BCD9B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837142857E2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6FE143897;
	Mon,  6 May 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIffkB5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FD14262C;
	Mon,  6 May 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997808; cv=none; b=rXmm806uSBG5hyRwjNrad/8+e1qL2klW7IUQrT7eAqfUGtkf8D2M3LrHLt7JAVA2nWuvQkdlaFR3swzFMgzQSZw+Ogrs30rO+0xus2K+KuD3C1P09qDQ5d9KGd6ygHOruWd4N1Xzqc3AhhzMQEFCz/LViU8HUQqSglYvjYntY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997808; c=relaxed/simple;
	bh=imW+tOmQLVq8kGToLptxFdeea7wI9xfeY1vCN4uPZuw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JpUSGapWTb3s34TGBgv/zMOyejZ2BR09gks+Val381wmcwGpn4yqi8V9vs6FtpeQhW0oVw1pxMVzee1ZkzUNIqwE7XquOyT3otDq3pG1jqGZQUEebfPbNKZ1vzm/N33RkUB9QoyGJYVnhrKX/aRYpBpQT7cl+ci7q9MvH8loCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIffkB5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB935C116B1;
	Mon,  6 May 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714997807;
	bh=imW+tOmQLVq8kGToLptxFdeea7wI9xfeY1vCN4uPZuw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qIffkB5CzbpmgYvIlqOZw40xo0i/2sgi+EIaWIL/LDuqWYhPeMgtVXR0uJQb77FCZ
	 Fc+luNUhSVsdItlyHjU+Y9ZOiouUgwpCUtdeggTEecnvjcMOzqrbMoyib3IzQp3yQV
	 nsTdrAak3IUZe5De9szGwODR59R3C1Y4u8IQaRhjTZw3OuPPILRQRT9EEkbJcUJHYu
	 iqwO7fGrg9puWWbUfX658Tqf0b/koh/V6yKK36CpjjFc0s+0skyEibCEFKliJFtGO4
	 woQf8dAkmVFx4NTsmz0CkBws16hddpjW6CQGpqPzXxBjGsPIfVVKbyJfx4ZekDlN1h
	 jWxiNdkZy83uQ==
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
Date: Mon, 06 May 2024 15:16:41 +0300
In-Reply-To: <b6a1eadf-477d-48a8-bf39-ac3c3191e929@freebox.fr> (Marc
	Gonzalez's message of "Tue, 30 Apr 2024 13:10:45 +0200")
Message-ID: <87fruvm8ye.fsf@kernel.org>
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
>
>>> Other than that, I think this looks good, so please upon addressing this
>>> problem feel free to add my:
>>>
>>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> 
>> Thanks, I'll then add this as well.
>
> Cool. Almost there :)

All I need is an ack from DT maintainers for this patch.

DT maintainers: I think this is the best option and I can't think of any
other solution so I would prefer to take this approach to our ath.git
tree if it's ok for you.

IIRC someone suggested testing for firmware version string but I suspect
that has the same problem as the firmware-N.bin approach: ath10k gets
the firmware version too late. And besides it's difficult to maintain
such a list in ath10k, it would always need kernel updates when there's
a new firmware etc.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

