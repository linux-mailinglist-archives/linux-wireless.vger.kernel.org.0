Return-Path: <linux-wireless+bounces-5907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50416899DCC
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FD9B2554A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAA16D309;
	Fri,  5 Apr 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY7fqoR8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829216C874
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321950; cv=none; b=YQjTuu41L8xcVanRGjafIQBKCDJXB9nnDBfb7c4PRsm9kbXE3ibsWBVeWc3EvzVnsEbsNjwXniuclhRtRiO6CAGQOrZUgJ+MsdhnuxP/StS6NYolFzj0IVxB3Rgt5wvCOn00KGJtoGyoZPfyOWJ6fiUNt9LwqIASOSakG9rzPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321950; c=relaxed/simple;
	bh=610LeHdimWGR5+0JH7yoL0R4SYnx1ueRNOi62as6phQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=H5R1k/CeGXxsxDj5KToluDQgQfRIF1IlKNXO4HN1C/qVkht5mQLyazNRZM5S4jm7Y/5G/MMQaG8ynUgQ7aLOXY8GMUNe9EBz2FSYvLL09IQgjQnem1R6q0mHMUfFMlQJN90zSk/7EkedG13HJo8fQ5UE3ae2jqQLWzNxtDbyvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY7fqoR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50128C433C7;
	Fri,  5 Apr 2024 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321949;
	bh=610LeHdimWGR5+0JH7yoL0R4SYnx1ueRNOi62as6phQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KY7fqoR88m1gfoaG9qVqzCbjhwMaWjyB5mF7ksXNFSNUpST3aWO1slDZfkW9pddLp
	 rSd/Lr0RHnU2ArmvDiPyUaISxS3zkx7s20OLqBCqLzjEhg1bErrDhGBoUMZ6ITQD2R
	 8Zo/eFgQQGy05NNbz6fOXaIKac0V8iehSkwFjDTVoXu7MXY+iaPzNS3+NuAxxfPiPv
	 2lEcpcLMlc8W1qm8CVJEJFC9uX2iERQBBWoGBF+KcTgNqc/kFHWkvbdoNTgFwQPtNC
	 dj0qkwhxrINxxonMyFztvP7yjmoZGPoLJWkmZmG6KlLse2zyq/V3WhA2JxekaX2sky
	 5u01FuqP90i4g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  P
 Praneesh <quic_ppranees@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath12k: fix BSS chan info request WMI command
References: <20240331183232.2158756-1-quic_kathirve@quicinc.com>
	<20240331183232.2158756-2-quic_kathirve@quicinc.com>
	<c4924128-817a-4026-93f3-acedfe70c858@quicinc.com>
	<6b08a911-1ebd-4bcd-bc18-56764ac83729@quicinc.com>
Date: Fri, 05 Apr 2024 15:59:06 +0300
In-Reply-To: <6b08a911-1ebd-4bcd-bc18-56764ac83729@quicinc.com> (Jeff
	Johnson's message of "Mon, 1 Apr 2024 09:12:10 -0700")
Message-ID: <87bk6o2cf9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/1/2024 8:00 AM, Jeff Johnson wrote:
>
>> On 3/31/2024 11:32 AM, Karthikeyan Kathirvel wrote:
>>> From: P Praneesh <quic_ppranees@quicinc.com>
>>>
>>> Currently, the firmware returns incorrect pdev_id information in
>>> WMI_PDEV_BSS_CHAN_INFO_EVENTID, leading to incorrect filling of
>>> the pdev's survey information.
>>>
>>> To prevent this issue, when requesting BSS channel information
>>> through WMI_PDEV_BSS_CHAN_INFO_REQUEST_CMDID, firmware expects
>>> pdev_id as one of the arguments in this WMI command.
>>>
>>> Add pdev_id to the struct wmi_pdev_bss_chan_info_req_cmd and fill it
>>> during ath12k_wmi_pdev_bss_chan_info_request(). This resolves the
>>> issue of sending the correct pdev_id in WMI_PDEV_BSS_CHAN_INFO_EVENTID.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>>
>> 
>> remove this blank line. Fixes tag should be together with S-o-b
>> 
>>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>> 
>> 
> Kalle can fix this when he merges into pending

Did that now to both patches:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8b2506bb2baa28a0e6ee5d4d71d7fca32e6da9d1

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d24b046bfc8f7255f4bef964ea5d9fc976273301

I also fixed this:

ERROR: Commit id shorter than 12 digits: Fixes: d889913205 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Should be: Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

