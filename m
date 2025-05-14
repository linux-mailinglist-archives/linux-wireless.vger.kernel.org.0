Return-Path: <linux-wireless+bounces-22941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA87AB6E32
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E3D7A1D8F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E46B1A0BDB;
	Wed, 14 May 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVDp1fmw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D004A23
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233222; cv=none; b=S/2SmVNo63p2bUGsqSpgn1e848tyq42+5sOGXEtxFW5v32DdjcIebqq/ZEek/BNDh1j3VgoyF6xHo9pQNlyKvoD0qXy7KkssO1gOQbHG/fSzvccqCf+tToN3J4Gev9z//ci17dR5tOiFUVrcj6c+byY6vkg8TPbHSPvZad9M0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233222; c=relaxed/simple;
	bh=0QNOi5L2b6Wa2pW0QAao2Q8QYjITnD2KoyJF4sxWD54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sadlauVPW4BOCWSSOuI+0HJ639wPq/QjNjsBoE26VIiJSUYYM3mH/tXMEsWyIRpTwovQ7je3vtWJHtuUfUOFIa1UT+o5AuGKZvtoyfaPpDR6e+fZMRmWgh3JNlq/aCg9RgozvtDLIlylDaSWBIlBID0h/8ALZ3GeNj5+fnKgtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVDp1fmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26498C4CEE3;
	Wed, 14 May 2025 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747233221;
	bh=0QNOi5L2b6Wa2pW0QAao2Q8QYjITnD2KoyJF4sxWD54=;
	h=Date:Subject:List-Id:To:Cc:References:From:In-Reply-To:From;
	b=ZVDp1fmwFAgjLPYgfBK8JEyim2lvuwSWNxpMRv48dTBxRZgf98A7Bp1FBHiYBS6x0
	 gPuGvNpbrqZOC/hIkT2C2cDqMJAuiilSjo3ys/JLZnv4DZhhRobbn+2gXjLlw0G0R0
	 9Quc1N74yM6vpTTimXFGEqiWfilwMteaqOa5hZxnLPEvlpem2LTYjZsBi5R8i9YBxH
	 jOR+4rWA5kYn2SjPCx8Pks+0k1wIsOP9XPtyqDCo9lIpjqzys8TrE46A7F20c+0O4c
	 ErDb7zAW/KPvX3T2KLSBtsHjjZmEz8e9jQaB4knFfIJyzp/0RamvRbzxSA3aNv3KC6
	 dIhz3sM2dcQZA==
Message-ID: <62cba955-0f4a-4b25-8ec9-065ccfa9e26e@kernel.org>
Date: Wed, 14 May 2025 09:33:40 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL linux-firmware] ath11k and ath12k firmware 20250424
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org,
 "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
 Christian Heusel <christian@heusel.eu>
References: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2025 3:38 PM, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath11k and ath12k.
> 
> For ath11k, update the firmware for IPQ5018 and update the board file
> for WCN6855. For ath12k, update the firmware for WCN7850 and update
> the board file for QCN9274.
> 
> Please let me know if there are any problems.
> 
> /jeff
> 
> The following changes since commit 490c0af1d6b9ffca0523edcfad27ba483b9d6da3:
> 
>    Merge branch 'robot/pr-0-1745490027' into 'main' (2025-04-24 13:46:05 +0000)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250424
> 
> for you to fetch changes up to ce13d29c3933f77674cf45855668485c48d3eba0:
> 
>    ath11k: WCN6855 hw2.0: update board-2.bin (2025-04-24 13:04:20 -0700)
> 
> ----------------------------------------------------------------
> Jeff Johnson (4):
>        ath12k: QCN9274 hw2.0: update board-2.bin
>        ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>        ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01300-QCAHKSWPL_SILICONZ-1
>        ath11k: WCN6855 hw2.0: update board-2.bin
> 
>   WHENCE                           |    4 +-
>   ath11k/IPQ5018/hw1.0/Notice.txt  | 3918 +++-----------------------------------
>   ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2334720 -> 2334720 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269220 -> 269252 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99456 -> 99456 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7072 -> 7080 bytes
>   ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
>   ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6429240 -> 6429240 bytes
>   ath12k/QCN9274/hw2.0/board-2.bin |  Bin 1308544 -> 2626240 bytes
>   ath12k/WCN7850/hw2.0/amss.bin    |  Bin 6000704 -> 6082624 bytes
>   ath12k/WCN7850/hw2.0/m3.bin      |  Bin 299660 -> 299660 bytes
>   15 files changed, 315 insertions(+), 3607 deletions(-)
> 

FWIW - this appears to have broken Wifi for a bunch of people.

https://discuss.cachyos.org/t/wifi-interface-fails-to-initialize-after-linux-firmware-upgrade-qualcomm-wcn7850-ath12k/8765

https://bugzilla.opensuse.org/show_bug.cgi?id=1241986

https://www.reddit.com/r/archlinux/comments/1kja6f9/ath12k_regression_on_latest_linuxfirmware_upgrade/



