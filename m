Return-Path: <linux-wireless+bounces-9119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBD90B534
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC7DB3ADD5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063D15F316;
	Mon, 17 Jun 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPBUL7qk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE71E53A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635535; cv=none; b=h7V/kkjUbG5kcXoBba4aaK+Zkekq1IIlMbCRjQFsFQrPoSc1qccLSeSKtEnCuMo/VQOmYdRJxQX5VBh7vWIhDgzjd9T5PMqJaZTgYHWdzGIKKsM5CExoWmiu7G7sG4VoC+sF/zz244jSaYb1gSPTNcT9Tib+I8vikbbwWyYmeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635535; c=relaxed/simple;
	bh=WljONcMYBQiy9twhsd+WU7VgbMMFjDDo3+ZIVzd90/A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Dc5hFyaJR1roT4aZ/dfVKA1okp7NwsE3bfYy5VaQHA9M36EJdkHE2wjxxdgAbgP66pDTnric+lZ71PRN4HaXv/KJZekePz8D7L0bsRNfRxZ9x6maQE/VP9R2ShjQhyUR7IBn2P6pZ8mYPh7U0OC9zoGXsGmDhwgoWqptGAM1Cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPBUL7qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63817C4AF1D;
	Mon, 17 Jun 2024 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718635535;
	bh=WljONcMYBQiy9twhsd+WU7VgbMMFjDDo3+ZIVzd90/A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YPBUL7qkUvSyAYCq7H8QjyoOuk9RQbKKLnCxPBc63kBP8F8IuqHvDAPNIBNzRB3Dj
	 RePn3NaHOvOZoT8UuArXkrxXHVazRtzACm1uhZ4+XD69EmnJBC6OHFMbLhgGDpOBV3
	 72+HAmqBZ97rDfvqkjYLQ7Or9/uBQFx2WzqfCRYY7F7Hcy+ALUt3dkORRhiurwA2BK
	 Inf3Cg0ia7G1x8Y/fW/fMhMusvZ1FWcvgR/2HpiRoWNe/HMd13wtEoRfHNxqDkOpgx
	 eBPgfrGdPaYeziNjbrsszimWKGka3pTi4b7VSMPUjMFrhJ6DG/c6wvJeVw93brKHGo
	 NYt9V2nBqL5Cg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in
 split-phy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
References: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171863553279.53335.12406687244110796571.kvalo@kernel.org>
Date: Mon, 17 Jun 2024 14:45:34 +0000 (UTC)

Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:

> Whenever firmware is crashed in split-phy below WARN_ON() triggered:
> 
> WARNING: CPU: 3 PID: 82 at net/mac80211/driver-ops.c:41 drv_stop+0xac/0xbc
> Modules linked in: ath12k qmi_helpers
> CPU: 3 PID: 82 Comm: kworker/3:2 Tainted: G      D W          6.9.0-next-20240520-00113-gd981a3784e15 #39
> Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9 (DT)
> Workqueue: events_freezable ieee80211_restart_work
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : drv_stop+0xac/0xbc
> lr : ieee80211_stop_device+0x54/0x64
> sp : ffff8000848dbb20
> x29: ffff8000848dbb20 x28: 0000000000000790 x27: ffff000014d78900
> x26: ffff000014d791f8 x25: ffff000007f0d9b0 x24: 0000000000000018
> x23: 0000000000000001 x22: 0000000000000000 x21: ffff000014d78e10
> x20: ffff800081dc0000 x19: ffff000014d78900 x18: ffffffffffffffff
> x17: ffff7fffbca84000 x16: ffff800083fe0000 x15: ffff800081dc0b48
> x14: 0000000000000076 x13: 0000000000000076 x12: 0000000000000001
> x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff8000848db980
> x8 : ffff000000dddfc0 x7 : 0000000000000400 x6 : ffff800083b012d8
> x5 : ffff800083b012d8 x4 : 0000000000000000 x3 : ffff000014d78398
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000014d78900
> Call trace:
>  drv_stop+0xac/0xbc
>  ieee80211_stop_device+0x54/0x64
>  ieee80211_do_stop+0x5a0/0x790
>  ieee80211_stop+0x4c/0x178
>  __dev_close_many+0xb0/0x150
>  dev_close_many+0x88/0x130
>  dev_close.part.171+0x44/0x74
>  dev_close+0x1c/0x28
>  cfg80211_shutdown_all_interfaces+0x44/0xfc
>  ieee80211_restart_work+0xfc/0x14c
>  process_scheduled_works+0x18c/0x2dc
>  worker_thread+0x13c/0x314
>  kthread+0x118/0x124
>  ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> 
> The warning in question is from drv_stop():
> 
>         if (WARN_ON(!local->started))
>                 return;
> 
> The sequence of WARN_ON() is:
> Thread 1:
> -Firmware crash calls ath12k_core_reset().
> -Call ieee80211_restart_hw() inside
>  ath12k_core_post_reconfigure_recovery() which schedules worker
>  for both hardware.
> -Wait for completion of ab->recovery_start.
> 
> Thread 2 (worker thread):
> -One hardware acquires rtnl_lock() inside ieee80211_restart_hw() and
>  calls ath12k_mac_wait_reconfigure() into ath12k_mac_op_start().
> -Hardware is waiting for ab->reconfigure_complete but at this time
>  recovery_start_count value is 1 because another worker thread
>  (local->restart_work) is still waiting for rtnl_lock().
>  recovery_start_count is not equal to number of radios
>  (2 in split-phy). So ab->recovery_start complete does not set
>  due to this, thread 1 is still waiting and not able to perform
>  hif power down up and firmware reload.
> -Wait timeout happens for ab->reconfigure_complete and comeback
>  to caller (ath12k_mac_op_start()) and sends WMI command to
>  crashed firmware and gets error.
> -This returns error to drv_start() and local->started is set to false.
> -Hardware calls cfg80211_shutdown_all_interfaces() after receiving error
>  inside ieee80211_restart_work() and goes to drv_stop(), here we trigger
>  WARN_ON as local->started is false.
> 
> To fix this issue call ieee80211_restart_hw() after firmware has been
> reloaded. Now, each hardware can send WMI command to firmware
> successfully. With this fix we don't need to wait for
> ab->recovery_start completion so remove
> ath12k_mac_wait_reconfigure().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

670d4949bc8e wifi: ath12k: Fix WARN_ON during firmware crash in split-phy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529034405.2863150-1-quic_aarasahu@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


