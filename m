Return-Path: <linux-wireless+bounces-6079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4889EE1E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1DB1F235D6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31513D8A6;
	Wed, 10 Apr 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgVp91lN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46338393
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739745; cv=none; b=OyFA+0P3Ow+eB8ecANXLYjtqwFnsOf0rzzI7sPHt7UI78isFz309mc4cXMzfpTdkAIWwWqtRKtHqj0r0V0zzKA1t77ffbmzFKCFRm4eDhCR02Cev5Ps2SnACqfgeySFsxCBqMiQz9Rt9AHKxqhpgtSsFED4y0APtGEPf4d4rHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739745; c=relaxed/simple;
	bh=BWIGtv/jtFuN/kcD1raMWNa1Vg9PxMfieRzFlD0RgUA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=E4CyYAV8iMGRjpORjDJRg5ovI7x3ZWDxBJ4UOVtZU1cXGY6K7lvRPle9GL+LJ38AQwoW1262VAPQ2mq162HhxsGAbSApudl5CRvIthn9zefz1rMm0bTzYW9ChRtx9VmaesZrarlfGlxZqVMkvmAT8sgGd1IEmcAGQfAZrx+lPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgVp91lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ABAC433F1;
	Wed, 10 Apr 2024 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712739745;
	bh=BWIGtv/jtFuN/kcD1raMWNa1Vg9PxMfieRzFlD0RgUA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OgVp91lNYOWiLWekLEVfZ/V9In9eR7l4BiUAWXZzPkx8gbKadvHzD4rdY8+DGQA27
	 6WxqDDpVjX5hWXd3yJU1ibAUAbHUh5dpuqQhHgyriatDhi5f+vSFXC9Dwb+DajjOsK
	 KHmbhcGZE3AcvDTiNYA16a/wE3nf/r2f8VnPgvhw7d3snZ+lZV9g9zg1+lN+L0+umb
	 OcgoqNTKVkoUd0QEfnR/SkYtSriNzjvU8Lhe7tElnDnBdJvEHu96YrlEPRyU7n+Cgk
	 i8nU04Gi7XOvJfJwv3sVcNSHcWfRLe7xvr9kb9PHbiyGp9XgeiBpHWbgySHkbxauK6
	 4HDa6A5PPmnqg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  Thiraviyam Mariyappan
 <quic_tmariyap@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: enable service flag for survey dump stats
References: <20240409175604.3299752-1-quic_kathirve@quicinc.com>
	<1e515bbc-0119-4114-b44e-d7a449b031f7@quicinc.com>
	<c47aa30f-cebb-4460-a78c-9a8df4f9e85e@quicinc.com>
Date: Wed, 10 Apr 2024 12:02:22 +0300
In-Reply-To: <c47aa30f-cebb-4460-a78c-9a8df4f9e85e@quicinc.com> (Karthikeyan
	Kathirvel's message of "Wed, 10 Apr 2024 14:20:05 +0530")
Message-ID: <87seztzj35.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> On 4/10/2024 5:37 AM, Jeff Johnson wrote:
>> On 4/9/2024 10:56 AM, Karthikeyan Kathirvel wrote:
>>> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
>>>
>>> The survey dump statistics does not display channel RX and TX time
>>> properly because the survey flag is not enabled in the firmware service
>>> flag.
>>>
>>> If firmware supports enable the service flag "bss_chan_info" in
>>> wmi_resource_config to fetch and print the stats for specific pdev.
>>>
>>> Enabling WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 does not have any impact
>>> on WCN7850 since this bit is not utilized by the WCN7850 firmware.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
>>> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
>>>   drivers/net/wireless/ath/ath12k/wmi.h | 1 +
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>>> index a5575ce9eed4..16504786735a 100644
>>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>>> @@ -3324,7 +3324,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
>>>   	wmi_cfg->bpf_instruction_size = cpu_to_le32(tg_cfg->bpf_instruction_size);
>>>   	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
>>>   	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
>>> -	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config);
>>> +	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config) |
>>> +				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
>> shouldn't that | operation be inside the ) ?
> Yes, will address in next version, thanks for the review Jeff

BTW ath12k-check should catch these kind of errors. Didn't it warn about
it or did you just skip running ath12k-check?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

