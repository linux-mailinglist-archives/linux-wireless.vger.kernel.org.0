Return-Path: <linux-wireless+bounces-17238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172CA07629
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38496167ECB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482021764E;
	Thu,  9 Jan 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI+khn9d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F307215074
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427293; cv=none; b=qFvEaXMgmxwof6RqIbIPMf3gyCxubnQV/sr/DQSHST9236sBeSb3WodagxRQQY+6lUdKpLvfHNJRrSmseRbflEL1xfrMgP+u5AO1Dh6X5SvXvQ/pI3+f2TF2jb2zUOc+aF6tZKLknXWvL3W8yRG9dzBwSlXwz5ddQXtofWuSkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427293; c=relaxed/simple;
	bh=26DM3asp7g2ycXbnbmvs6ssdSgp7CdT28HMGdx8l0AY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FFi7wfyNYbcVg8EDHWTl3NqQlNxqoGUB6BtUsFxSGloZw6OalCROj6UWp3NJtauAx4cPYeojyZ8Z+n1zkJ5sUy88F6kfxKEsjVAffvaDdBG+t6i4Sl0aBqyw9JnmjUitJJU1HTQhCuH9hz28d/yGJHmAL4eZCnFiypMTdHpn86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI+khn9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2879EC4CED2;
	Thu,  9 Jan 2025 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736427293;
	bh=26DM3asp7g2ycXbnbmvs6ssdSgp7CdT28HMGdx8l0AY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cI+khn9dWVubDDxFNN7F27gzcX1E3aEZrt+2fAsAnu3juif7KyKyNcRTC2cYLJ08b
	 bNN8nz48qdx2FeaHF4M8v3xl+ncwJ5QitMb0G9PYLHimifIiou3kDypItt6sBAFJ+3
	 ctzmyT6FxGtnPdxEK+WW5QNcLFpmx9k+p5aq46tLGMtwixXbCY2aqELK0e+y4OM4mx
	 arW1Xa4n+HcHTU6dORqv/d373yoKCDHvC1FuDBybgXjMXNWdVnIIfn8SB0GWrSmI0r
	 w6pNWXpXOnLDx+/POrbiucH9Hx1oSlD2LqXNE4Csn9ZELUz8kUuvVOOJ93joV3Pylh
	 qs9usOwUzOPZQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>,  Aaradhana Sahu
 <quic_aarasahu@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Factory test mode support
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
	<d38ac7f6-3596-4336-bd9d-61e99f3b070c@quicinc.com>
	<b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
	<5f05898c-cc5c-4c31-891e-9d5cb9cf5bfa@oss.qualcomm.com>
Date: Thu, 09 Jan 2025 14:54:50 +0200
In-Reply-To: <5f05898c-cc5c-4c31-891e-9d5cb9cf5bfa@oss.qualcomm.com> (Jeff
	Johnson's message of "Wed, 8 Jan 2025 21:29:27 -0800")
Message-ID: <87tta8du5h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 1/8/2025 8:55 PM, Aditya Kumar Singh wrote:
>
>> On 1/9/25 10:13, Aaradhana Sahu wrote:
>>>
>>>
>>> On 6/24/2024 3:23 PM, Aaradhana Sahu wrote:
>>>> Device is booted in factory test mode for calibration.
>>>> The commands are sent from userspace application, which
>>>> is sent to firmware using wmi commands. Firmware sends
>>>> the response to driver as wmi events and driver sends
>>>> these events to the application via netlink message.
>>>>
>>>> Also added changes related to correct pdev id access for
>>>> fw test cmd.
>>>>
>>>> Aaradhana Sahu (3):
>>>>    wifi: ath: create common testmode_i.h file for ath drivers
>>>>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>>    wifi: ath12k: add factory test mode support
>>>>
>>>> Rajat Soni (1):
>>>>    wifi: ath12k: Fill pdev id for fw test cmd
>>>>
>>>> ---
>>>> v5:
>>>>    -Updated copyright
>>>>    -Fixed line length within 90 char
>>>> v4:
>>>>    -Rebased on latest ToT
>>>> v3:
>>>>    -Rebased on latest ToT
>>>>    -Updated Tested-on Tag
>>>>    -Removed second parameter of ath12k_core_start()
>>>>    -Updated copyright
>>>> v2:
>>>>    -Rebased on latest ath ToT
>>>> ---
>>>>
>>>>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>>>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>>>   drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>>>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>>>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>>>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>>>   drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>>>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>>>   drivers/net/wireless/ath/ath12k/testmode.c    | 423 ++++++++++++++++++
>>>>   drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>>>   drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>>>   drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>>>   .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>>>>   13 files changed, 636 insertions(+), 75 deletions(-)
>>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>>>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>>>
>>>>
>>>> base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
>>>
>>> Hi Kalle,
>>>
>>> Please let me know, if any thing is pending from the developer side, to merge this series into ath.git tree.
>> 
>> This series does not apply cleanly on latest tip. And base commit is 
>> around 6 months old. So may be you would want to rebase and send a new 
>> version?
>> 
>> Applying: wifi: ath: create common testmode_i.h file for ath drivers
>> Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>> Applying: wifi: ath12k: add factory test mode support
>> error: patch failed: drivers/net/wireless/ath/ath12k/Makefile:26
>> error: drivers/net/wireless/ath/ath12k/Makefile: patch does not apply
>> error: patch failed: drivers/net/wireless/ath/ath12k/core.c:42
>> error: drivers/net/wireless/ath/ath12k/core.c: patch does not apply
>> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:209
>> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
>> error: patch failed: drivers/net/wireless/ath/ath12k/debug.h:33
>> error: drivers/net/wireless/ath/ath12k/debug.h: patch does not apply
>> error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:13
>> error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply
>> error: patch failed: drivers/net/wireless/ath/ath12k/wmi.c:7150
>> error: drivers/net/wireless/ath/ath12k/wmi.c: patch does not apply
>> Patch failed at 0003 wifi: ath12k: add factory test mode support
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>> 
>> And since you'll be submitting in 2025, don't forget to update
>> copyrights.
>> 
>> 
>
> Make sure to review all the changes that Kalle made locally to the pending
> version and incorporate those.

BTW my changes are available in tag ath-pending-202407031443 and these
are the commit ids:

194fb8d58727 wifi: ath12k: Fill pdev id for fw test cmd
0ca2ecc31b40 wifi: ath12k: add factory test mode support
df17f461e7c3 wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
593b976359bf wifi: ath: create common testmode_i.h file for ath drivers

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

