Return-Path: <linux-wireless+bounces-5820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC58971D1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE951F22ECA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8380148844;
	Wed,  3 Apr 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VItlUmjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4564148825
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152798; cv=none; b=KzgSnTwIXIv/vlCeNRiEcO8p+8lpoWR5PIj89VeFiMeUsmReX+9PYP8VaWfW8XMvXWz4KQdcVMuHgLn8vPnw3yMVNYK7mHlqi3820uqLOyD8K8p+z6ByS3KbHtPUpPAcrcNssrQs0pjKY0itBRbmNObuknEQBCb/jq4tED9vUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152798; c=relaxed/simple;
	bh=xWOoflujjPGS0Ej1CAyXYZlgQxQGJxVb6eX5fIZF1SY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HVJcKCCeLzSEXrQRExDMtQECn2L6k6Ca+333l2e2EcedaH4v2LEKgNnjOEXlGe2z1diOXXsBGSLFwODXqiq2eBE3Nx5I1H3gcU/Y8JpLsGeHrulkAFlIixYfSNsegpacW3f4TR0puCs42jW5UkGpHcxLY7Wd1FfkOYoKtZxGQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VItlUmjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB6C433F1;
	Wed,  3 Apr 2024 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712152798;
	bh=xWOoflujjPGS0Ej1CAyXYZlgQxQGJxVb6eX5fIZF1SY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VItlUmjoFbS3y/XeTK3D42AekqiqqY1poxrXawEqaA+jtI/pFcpy5qyZ7FoELKmMf
	 +4PJGBj+39OgalEVoJqZx0q2FcByEfg2ehib2Yd5T50i8ysiFU/+2a1a9W6KLb9AOh
	 hPAWZDY1L+i5z6bkAXd0byx+GgflmUszU9vnNQ5mJ9MBd95zxB1dhL5SQpOQBsORFm
	 kPFzolqHzOQVLsiRNJjxb4CoypsR6n6BQ4GW3DbeOc7F3NPiFo/Hsvuk/brXcYnT3x
	 2aJoqEktCAtGNxoMkt+e0hfoypGHuh34dhnSLZ2JrSBBEE8EsAvoNF7Xs9ukaufuzc
	 jBye5ze7Zd7TA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath12k: extend the link capable flag
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
	<20240329012358.2242354-2-quic_periyasa@quicinc.com>
	<f17ab010-5874-495a-8bd8-3e18e85cc327@quicinc.com>
	<ebeb7fa3-f0d1-230a-80bc-0877fdab7e62@quicinc.com>
	<6dac32c7-a2b2-4ac3-9c1f-b02f612ee3ef@quicinc.com>
Date: Wed, 03 Apr 2024 16:59:55 +0300
In-Reply-To: <6dac32c7-a2b2-4ac3-9c1f-b02f612ee3ef@quicinc.com> (Jeff
	Johnson's message of "Tue, 2 Apr 2024 10:41:53 -0700")
Message-ID: <877che5yxw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/2/2024 2:32 AM, Karthikeyan Periyasamy wrote:
>
>> 
>> 
>> On 4/1/2024 10:24 PM, Jeff Johnson wrote:
>>> On 3/28/2024 6:23 PM, Karthikeyan Periyasamy wrote:
>>>> Link capability categorized as Single Link Operation (SLO) and Multi Link
>>>> Operation (MLO).
>>>>
>>>> 	* Intra-chip SLO/MLO refers to links present within a chip
>>>> 	* Inter-chip SLO/MLO refers to links present across multiple chips
>>>
>>> Is "chip" the correct term?
>>>
>>> I'm thinking that this should be called "device" since that is the unit of
>>> hardware that is detected by a bus probe function and which is handled by a
>>> *device* driver.
>>>
>>> Doesn't this make more sense if the references to chip and SoC are changed to
>>> device?
>>>
>> 
>> In the QMI, SLO/MLO parameter exposed as chip only not device. So 
>> followed the same terminology to avoid confusion for code readability.
>> 
>> struct wlfw_host_mlo_chip_info_s_v01 {
>>          u8 chip_id;
>>          u8 num_local_links;
>>          u8 hw_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
>>          u8 valid_mlo_link_id[QMI_WLFW_MAX_NUM_MLO_LINKS_PER_CHIP_V01];
>> };
>> 
>> struct qmi_wlanfw_host_cap_req_msg_v01 {
>> 
>> ...
>> 
>> u8 mlo_num_chips;
>> 
>> u8 mlo_chip_info_valid;
>> 
>> struct wlfw_host_mlo_chip_info_s_v01 
>> mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
>> 
>> ...
>> 
>> }
>> 
>
> Please don't let firmware interface naming drive host driver code naming.
> And push back on the firmware team when they've introduced poor naming.
>
> As many Software Engineering experts stress, naming is probably the single
> most important thing we do. So we need to make sure we are using the correct
> names for all of the software objects that comprise the driver, especially
> with this multi-device MLO feature where we now have to represent a multitude
> of individual devices as a single logical wiphy.
>
> Lack of a single common term for each object in the architecture makes the
> code far less maintainable.

Amen to that. I think we should come up with a terminology list or
something, otherwise it's hard to keep up with all teams having their
own terminology.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

