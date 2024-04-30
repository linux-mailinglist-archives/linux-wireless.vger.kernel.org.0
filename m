Return-Path: <linux-wireless+bounces-7022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1218B6950
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 06:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB14D284B92
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DA11737;
	Tue, 30 Apr 2024 04:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtE4DjU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A511185;
	Tue, 30 Apr 2024 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450016; cv=none; b=CdJrj+1aiyyyXr5K0GBZGerxESludHLx5B2DjxeoJ+kY84XOluT/ekAVZ1oMm1LnOkwLNQcqTi94olqXaZKiryBHhMlscyl4/UZkIxmWGGIYuFacvF4XnQ46MFz3LSzKaIPZLPNEQKzPj6LW0H4C+vQN7J5k5aBEqZNEHPwBRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450016; c=relaxed/simple;
	bh=iBhXqbeiDrU6vv91AowziuD116kMDvclTlVrNyh/zr8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oKnZpKP8wYtRkDl5vy1X7Eo9AY+QT2VlUj5UyZuOvFh29aOw4mMj4FJzw0gBf+1GqKi/miOmXVrZW9CvTU0T7CH2YDrukBzX+/FdC6MYUyMuQDYbfYEI+DsQ9+S6reDKFgYqJSWP0UuZ2sgXw9bwatUbaev73y5QUfXkhqPh6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtE4DjU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EACC2BBFC;
	Tue, 30 Apr 2024 04:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714450015;
	bh=iBhXqbeiDrU6vv91AowziuD116kMDvclTlVrNyh/zr8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GtE4DjU8iLxl3H9D5LkIqL2GVzZMxFBhLgElWpKzFjUA+HP4I5n/m2Mqhs4sBRFn9
	 ZEc1QwHnrDz7HicN+VzY7aGfWyMOOAOb8sNTHN2MxU+gT+V3pOmchYFK9tDzeQa21I
	 TaAjfFWhGtpruZUeMHNCtMjuvOjZVlGdBXDU1Z+Iu0Q1yZswRm1XrM2EbMwoOouT7h
	 0a4mHArM756gqH5aiaiN379suahUH/hZurVx6W6dl3dTaZYn77qo3ORr4BjROJyuVO
	 24titcThvMTOsg7+N5TKcamLmNyjIoVcA5RoRm/YsCbS5oEPLLhCOPh6SAy04xvIhv
	 xf+urDRscN3pg==
From: Kalle Valo <kvalo@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  "Arnaud Vrac"
 <avrac@freebox.fr>,  Bjorn Andersson <andersson@kernel.org>,  "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,  Jami Kettunen
 <jamipkettunen@gmail.com>,  Jeffrey Hugo <quic_jhugo@quicinc.com>,  Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,  Alexey Minnekhanov
 <alexeymin@postmarketos.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
	<54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
	<ZjBV+th9DmnNLhnN@hu-bjorande-lv.qualcomm.com>
Date: Tue, 30 Apr 2024 07:06:49 +0300
In-Reply-To: <ZjBV+th9DmnNLhnN@hu-bjorande-lv.qualcomm.com> (Bjorn Andersson's
	message of "Mon, 29 Apr 2024 19:22:50 -0700")
Message-ID: <8734r3qysm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Andersson <quic_bjorande@quicinc.com> writes:

> On Mon, Apr 29, 2024 at 04:04:51PM +0200, Marc Gonzalez wrote:
>
>> The ath10k driver waits for an "MSA_READY" indicator
>> to complete initialization. If the indicator is not
>> received, then the device remains unusable.
>> 
>> cf. ath10k_qmi_driver_event_work()
>> 
>> Several msm8998-based devices are affected by this issue.
>> Oddly, it seems safe to NOT wait for the indicator, and
>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>> 
>> Jeff Johnson wrote:
>> 
>>   The feedback I received was "it might be ok to change all ath10k qmi
>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>   (and ath12k) do not wait for it.
>> 
>>   However with so many deployed devices, "might be ok" isn't a strong
>>   argument for changing the default behavior.
>> 
>> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
>> work-around in the driver. However, firmware-5.bin is parsed too late.
>> So we are stuck with a DT property.
>> 
>> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>
> This says "Pierre-Hugues certifies the origin of the patch" then "Marc
> certifies the origin of the patch". This would have to imply that
> Pierre-Hugues authored the patch, but you're listed as the author...
>
> Perhaps a suitable answer to this question would be to add
> "Co-developed-by: Pierre-Hugues ..." above his s-o-b, which implies that
> the two of you jointly came up with this and both certify the origin.

BTW I can add that in the pending branch, no need to resend because of
this. Just need guidance from Marc.

> Other than that, I think this looks good, so please upon addressing this
> problem feel free to add my:
>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Thanks, I'll then add this as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

