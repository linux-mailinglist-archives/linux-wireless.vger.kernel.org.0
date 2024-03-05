Return-Path: <linux-wireless+bounces-4381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834287217B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0A1C21A30
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070E95466D;
	Tue,  5 Mar 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNnkJcVI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFF6127;
	Tue,  5 Mar 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649112; cv=none; b=UMwMrp5cUvkWZmAjT/ykRJDDnHRsBdnNL/syH/99WAdLkwTlkXHlLXjuYr2b8jPiGRos4ATfCtKSVbHNQKSlApsS5TL+iX7WfgzTz1A/Bt1WbvY1RFNC0CNv/WjEmCWyweOldJCi3xP/gTCgovGFyzZIQt8S6J/D1Vg+sDt+1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649112; c=relaxed/simple;
	bh=uOxgMc0UNvjtNX9ROLkNkPMff+sYOIbHJ/9I4Ez7edI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=S0SENSqBnqwjBlZPVa8CsfcXr+VqYThxdD+/hczZhs1DSpx5ANKO9JVf0D1cHWS59R0qQRssM57FfF4pbGvcHgKMzh7qtHaOfNP2CZqUfjPQYMskYOYwfIBOgx9VfFpb84KkGYjbKhLtMnN+M3Yd4F7F9hG2g/iYZswxSNzYcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNnkJcVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6ABC433C7;
	Tue,  5 Mar 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649112;
	bh=uOxgMc0UNvjtNX9ROLkNkPMff+sYOIbHJ/9I4Ez7edI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JNnkJcVI9mzU2udfx3sPMtgCMMnYFmPluM3YhTE1EhgQ8hEveJMT/P7/kN2WF1f9s
	 EACth0vLiBRE/2UtztynZhuECgr72fj3O1pTFP0s+1rClteUIaqcYGk2ojnBoPwNHd
	 whYBxWjo+wL4I3D5lcWdO2Ev1e2D8PcPVeIG5PfQo+7LZIxzF77IgUQP09qWx9plt0
	 XgUYSssRsdnibH28jDfIzVGaBni/jxYDzWBZC2iunsqyeom/qOhcNoB9da3C5NY2mg
	 p4N5yXXlFKTzvmCPns60RwSOHl/id+BbzeczU3fGk9CxMx2l9AYSM2NjcRY57sddrQ
	 VmAr5FoCrnJ+Q==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k
 <ath10k@lists.infradead.org>,  wireless <linux-wireless@vger.kernel.org>,
  DT <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Pierre-Hugues Husson <phhusson@freebox.fr>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo
 <quic_jhugo@quicinc.com>,  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
	<b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
	<871q8wk7o3.fsf@kernel.org>
	<3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
	<87wmqoilzf.fsf@kernel.org>
	<c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr>
	<87cyse8j9m.fsf@kernel.org>
	<6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr>
Date: Tue, 05 Mar 2024 16:31:47 +0200
In-Reply-To: <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> (Marc
	Gonzalez's message of "Mon, 4 Mar 2024 16:51:37 +0100")
Message-ID: <87plw87nsc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 01/03/2024 09:10, Kalle Valo wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> Kalle Valo wrote:
>>> 
>>>> Here's one example where in ath10k we use a feature bit as a workaround:
>>>>
>>>> 	/* Don't trust error code from otp.bin */
>>>> 	ATH10K_FW_FEATURE_IGNORE_OTP_RESULT = 7,
>>>>
>>>>         ....
>>>>
>>>> 	if (!(skip_otp || test_bit(ATH10K_FW_FEATURE_IGNORE_OTP_RESULT,
>>>> 				   ar->running_fw->fw_file.fw_features)) &&
>>>> 	    result != 0) {
>>>> 		ath10k_err(ar, "otp calibration failed: %d", result);
>>>> 		return -EINVAL;
>>>> 	}
>>>>
>>>> BTW for modifying firmware-N.bin files we have a script here:
>>>>
>>>> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-fwencoder
>>>
>>> If I understand correctly, you are saying that there is
>>> (maybe... probably) a bug in the FW, so it makes sense to
>>> tag that specific FW file with a special bit which the kernel
>>> will interpret as "this FW is broken in a specific way;
>>> and here's how to work around the issue."
>>>
>>> So this bit would serve the same purpose as my proposed
>>> "qcom,no-msa-ready-indicator" bit (that bit existed instead
>>> in my board's device tree).
>>>
>>> The problem I see is that the firmware files are signed.
>>> Thus, changing a single bit breaks the verification...
>>> UNLESS the FW format allows for a signed section ALONG-SIDE
>>> an unsigned section?
>> 
>> firmware-N.bin is ath10k specific container file format and we (the
>> Linux community) have full access to it using ath10k-fwencoder, there's
>> no signing or anything like that. One of the major reasons why it was
>> designed was to handle differences between firmware branches, just like
>> in this case.
>> 
>> Of course plan A should be to fix the firmware but if that doesn't work
>> out then plan B could be using the feature bit in firmware-N.bin.
>> 
>> BTW related to this Dmitry is extending firmware-N.bin handling for
>> WCN3990, you will most likely need to use that:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/cover/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org/
>
>
> If I understand correctly (happy to have anyone correct any
> misunderstandings), if the FW cannot be fixed (for any reason),
> then we would have to do something like this:

Thanks, this is exactly what I'm proposing.

> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 0032f8aa892ff..c8778ebe922af 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -769,6 +769,7 @@ static const char *const ath10k_core_fw_feature_str[] = {
>  	[ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL] = "single-chan-info-per-channel",
>  	[ATH10K_FW_FEATURE_PEER_FIXED_RATE] = "peer-fixed-rate",
>  	[ATH10K_FW_FEATURE_IRAM_RECOVERY] = "iram-recovery",
> +	[ATH10K_FW_FEATURE_NO_MSA_READY] = "no-msa-ready-indicator",

For consistency I would have just "no-msa-ready".

> @@ -1151,6 +1154,9 @@ struct ath10k {
>  	u8 cfg_tx_chainmask;
>  	u8 cfg_rx_chainmask;
>  
> +	/* FW does not send MSA_READY indicator. Fake it */
> +	bool fake_msa_ready; /* bool or u8? or s8? or bitfield? */

Hopefully not needed, see below.

>  	struct completion install_key_done;
>  
>  	int last_wmi_vdev_start_status;
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index 38e939f572a9e..0776e79b25f3a 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -1040,6 +1040,8 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
>  		switch (event->type) {
>  		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
>  			ath10k_qmi_event_server_arrive(qmi);
> +			if (ar->fake_msa_ready)
> +				ath10k_qmi_event_msa_ready(qmi);

Unless I'm missing something I would use here test_bit() directly:

if (test_bit(ATH10K_FW_FEATURE_NO_MSA_READY, ar->running_fw->fw_file.fw_features))
        ath10k_qmi_event_msa_ready(qmi);

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

