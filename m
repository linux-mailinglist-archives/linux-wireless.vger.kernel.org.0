Return-Path: <linux-wireless+bounces-4383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA1872256
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D8287AFF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA68126F22;
	Tue,  5 Mar 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe4RaEmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E6126F07;
	Tue,  5 Mar 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650945; cv=none; b=gbbP+jY8LilfNPTDHmX3XuAb1XmUQ4KuCDxj8zDOMjdbHwOOud0WEKp4upVBEu/Yjf3Kw4NmKm/LiG2tDg8CullcGsITewpSptbfqZKxG4ohJKr9VXTQcJ95wPxRqPg1m2Ud1hk0LLEKDp3GR7cHa0eN5AHdV3gCL+gOeVkuu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650945; c=relaxed/simple;
	bh=0rbnt5WowyAgoXkHNQgR9IcAjCdySQfxwlKA/O2YA8E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V0JBpvmEtEwf9FSPf7SCWrt077DqmUmpx7RYOwjxCGff6MN1+m7aA8tVdJcbBl0BvTg9hCTdRzJaGpCUU93IpsubJ8Q5N7cXGdEFK6/440oJgM10BpNVIeweQSBDU9diIdPu1XBki3yU0Ifr7Aw6nWFRFnyXJMxQ8Viygi6GjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe4RaEmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C3C43390;
	Tue,  5 Mar 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650944;
	bh=0rbnt5WowyAgoXkHNQgR9IcAjCdySQfxwlKA/O2YA8E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oe4RaEmwb56V9aJZVSGYFBa8921haPfL81eYTBT0JngbFSd2vVVXet1O19s1DAOTQ
	 cExOm4VRyJF2m26HLsUd7VjTWYJ5PFuruxatgrsz7KvO+BzWzodyhhVwuoISUD4m8U
	 w3ucNaXYkiISv5BLTs4IHlLg3sK/kdOvxN1uytHidirFBzyYg7p5Blt7fdyKt2s67B
	 EwElCO9iukHboXHf3Wk0d+hcjOpM0LBSshIRG17vjehk6lD64IKxM1UogK1NlIpguB
	 6C6NF/sSwQhtFCvGcV1BcXCdoLT1Oq5/yq0csLC8xrMuIc20pqPDr4kwDAVkY1Y0tX
	 Hd/chwUWiyVqw==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Conor Dooley <conor@kernel.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  Rob Herring <robh+dt@kernel.org>,
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
	<20240229-ageless-primal-7a0544420949@spud>
	<68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
Date: Tue, 05 Mar 2024 17:02:19 +0200
In-Reply-To: <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr> (Marc
	Gonzalez's message of "Mon, 4 Mar 2024 17:21:37 +0100")
Message-ID: <877cigiux0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 29/02/2024 19:40, Conor Dooley wrote:
>
>> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>>
>>> Marc Gonzalez wrote:
>>> 
>>>> As mentioned in my other reply, there are several msm8998-based
>>>> devices affected by this issue. Is it not appropriate to consider
>>>> a kernel-based work-around?
>>>
>>> Sorry, not following you here. But I'll try to answer anyway:
>>>
>>> I have understood that Device Tree is supposed to describe hardware, not
>>> software. This is why having this property in DT does not look right
>>> place for this. For example, if the ath10k firmware is fixed then DT
>>> would have to be changed even though nothing changed in hardware. But of
>>> course DT maintainers have the final say.
>> 
>> I dunno, if the firmware affects the functionality of the hardware in a
>> way that cannot be detected from the operating system at runtime how
>> else is it supposed to deal with that?
>> The devicetree is supposed to describe hardware, yes, but at a certain
>> point the line between firmware and hardware is invisible :)
>> Not describing software is mostly about not using it to determine
>> software policy in the operating system.
>
> Recording here what was discussed a few days ago on IRC:
>
> If all msm8998 boards are affected, then it /might/ make sense
> to work around the issue for ALL msm8998 boards:
>
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index 0776e79b25f3a..9da06da518fb6 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -1076,6 +1076,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
>  	qmi->ar = ar;
>  	ar_snoc->qmi = qmi;
>  
> +	if (of_device_is_compatible(of_root, "qcom,msm8998")
> +		qmi->no_point_in_waiting_for_msa_ready_indicator = true;
> +
>  	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
>  		qmi->msa_fixed_perm = true;
>  
>
> Thus, anyone porting an msm8998 board to mainline would automatically
> get the work-around, without having to hunt down the feature bit,
> and tweak the FW files.

The point with firmware-N.bin file is that NO tweaking or hunting down
firmware files is necessary. All the files would be in
linux-firmware.git and ath10k would automatically choose the correct
firmware-N file. From ath10k side all is needed is Dmitry's patchset[1]
and your (Marc) patch adding the feature bit check to ath10k.

And if later the firmware is fixed, we will update the firmware-N.bin
file at the same time in linux-firmware.git and the user doesn't notice
anything.

[1] https://patchwork.kernel.org/project/linux-wireless/cover/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

