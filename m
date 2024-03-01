Return-Path: <linux-wireless+bounces-4291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274986DCC0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 09:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DCA1F26B4D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB269D09;
	Fri,  1 Mar 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1dp3Nk5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3069D13;
	Fri,  1 Mar 2024 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280634; cv=none; b=tkUbImPALQJldaVh/uWqTBaPHptrQAd8VrxLTpeNBPlHl9Z5bQfi06iAExxlARZJZGGx+1H65QnLqaaMu0iQiRcA538PVYoHFR6HP7QNORpaXILDWrcVb/TL3euyyq6TLq27ZfUpIqSsNICiXY4w54q60lorr1UleN5Hp+U9FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280634; c=relaxed/simple;
	bh=X72NJCeGEpyO5TljCIfKuVss8NrQT972LEnQW9Au8jM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TwMP5baYS1YzsF80kAiLJaFaVM3n970+2OLVDJKNoMXUyDA8p5fnrMTRx131GWurtwW5186+k+ltkppG6cPhNYy+DLklKTI3moq7Ey3bZyIOyMqzykWHFyF78LfonXHTyVbxH4cKwrZj6Xc7E75KgG4pylGp64mtA6o2LNw2u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1dp3Nk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F44C433F1;
	Fri,  1 Mar 2024 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709280633;
	bh=X72NJCeGEpyO5TljCIfKuVss8NrQT972LEnQW9Au8jM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Q1dp3Nk59WBXj18jqNBXspTsq5n0O4AOx0Og1H93g0tbsS+tbBCzrVB+pjBRHSE4g
	 9IHoheYQ6qlctQ+vd9fsnFDXQyr6OHSi6J+zttT/c3C5oZ9+zG+HLFeHRzsAWAqyw/
	 RslBzZcW+LJmGH74iLKKYXK1ddG5eizTYw9jorCkKEiXBqrs2OwlziLQEggpSZWmwc
	 HFahnW+dpjO4+AQCBkVO70s9VDffgevfO1Q/X5AlYreZGjz7VZ5uObFt7hhR55F0gg
	 LUjpdfO4qkKlsjfwPh9YdqYFhrbzI9wuKofxuRzHU6AnJ7ZYRVCbDq+tj+NToO/MyF
	 hQFY+Cog5LBUg==
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
	<87wmqoilzf.fsf@kernel.org>
	<c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr>
Date: Fri, 01 Mar 2024 10:10:29 +0200
In-Reply-To: <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> (Marc
	Gonzalez's message of "Wed, 28 Feb 2024 18:19:03 +0100")
Message-ID: <87cyse8j9m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

>> Here's one example where in ath10k we use a feature bit as a workaround:
>> 
>> 	/* Don't trust error code from otp.bin */
>> 	ATH10K_FW_FEATURE_IGNORE_OTP_RESULT = 7,
>> 
>>         ....
>> 
>> 	if (!(skip_otp || test_bit(ATH10K_FW_FEATURE_IGNORE_OTP_RESULT,
>> 				   ar->running_fw->fw_file.fw_features)) &&
>> 	    result != 0) {
>> 		ath10k_err(ar, "otp calibration failed: %d", result);
>> 		return -EINVAL;
>> 	}
>> 
>> BTW for modifying firmware-N.bin files we have a script here:
>> 
>> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-fwencoder
>
> If I understand correctly, you are saying that there is
> (maybe... probably) a bug in the FW, so it makes sense to
> tag that specific FW file with a special bit which the kernel
> will interpret as "this FW is broken in a specific way;
> and here's how to work around the issue."
>
> So this bit would serve the same purpose as my proposed
> "qcom,no-msa-ready-indicator" bit (that bit existed instead
> in my board's device tree).
>
> The problem I see is that the firmware files are signed.
> Thus, changing a single bit breaks the verification...
> UNLESS the FW format allows for a signed section ALONG-SIDE
> an unsigned section?

firmware-N.bin is ath10k specific container file format and we (the
Linux community) have full access to it using ath10k-fwencoder, there's
no signing or anything like that. One of the major reasons why it was
designed was to handle differences between firmware branches, just like
in this case.

Of course plan A should be to fix the firmware but if that doesn't work
out then plan B could be using the feature bit in firmware-N.bin.

BTW related to this Dmitry is extending firmware-N.bin handling for
WCN3990, you will most likely need to use that:

https://patchwork.kernel.org/project/linux-wireless/cover/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

