Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9708949DD29
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 10:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiA0JB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 04:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiA0JBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 04:01:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4900C061714
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 01:01:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC89B82192
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jan 2022 09:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719C1C340E6;
        Thu, 27 Jan 2022 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643274083;
        bh=4YjLI8Xffej2SauOmlHVDCfYAMkpKJHzByVNO9Zq4Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMjtusyko2bl1dV5B9vJ3/uifWdeP+BVtG1DuiB3aDIEqwVT0XbyZPvcSVnX1AeKo
         P3eUiLXqogw0LVpO45qjuHeWYePpOGf/ksauazMAQ6HkeOy8bLdaB4B1NWzWf40xF6
         5tlsi6upYwzxSr4EQs0dJ4UMprbsd7FJDEMaDz0nJV873KAj3Vlkv/RmjeAXsDHxC8
         YY+aM4El37iB3B2+MECdUln1XCt1aYgUhMVP6iXKreJ+fBS12bEv300dca0cjshgzz
         6AAuBpwLbI45MytQihxSF5XhYlWe/mhtzGaCmq2WYS3gvFUFVBF+WQte9wg+fllHKD
         DdEKikFzD8mcQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath11k: mhi: use mhi_sync_power_up()
Date:   Thu, 27 Jan 2022 11:01:17 +0200
Message-Id: <20220127090117.2024-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127090117.2024-1-kvalo@kernel.org>
References: <20220127090117.2024-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

If amss.bin was missing ath11k would crash during 'rmmod ath11k_pci'. The
reason for that was that we were using mhi_async_power_up() which does not
check any errors. But mhi_sync_power_up() on the other hand does check for
errors so let's use that to fix the crash.

I was not able to find a reason why an async version was used. This call ends
is called from ath11k_hif_power_up() which can sleep, so sync version should be
safe to use.

[  145.569731] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[  145.569789] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  145.569843] CPU: 2 PID: 1628 Comm: rmmod Kdump: loaded Tainted: G        W         5.16.0-wt-ath+ #567
[  145.569898] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  145.569956] RIP: 0010:ath11k_hal_srng_access_begin+0xb5/0x2b0 [ath11k]
[  145.570028] Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ec 01 00 00 48 8b ab a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 <0f> b6 14 02 48 89 e8 83 e0 07 83 c0 03 45 85 ed 75 48 38 d0 7c 08
[  145.570089] RSP: 0018:ffffc900025d7ac0 EFLAGS: 00010246
[  145.570144] RAX: dffffc0000000000 RBX: ffff88814fca2dd8 RCX: 1ffffffff50cb455
[  145.570196] RDX: 0000000000000000 RSI: ffff88814fca2dd8 RDI: ffff88814fca2e80
[  145.570252] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffa8659497
[  145.570329] R10: fffffbfff50cb292 R11: 0000000000000001 R12: ffff88814fca0000
[  145.570410] R13: 0000000000000000 R14: ffff88814fca2798 R15: ffff88814fca2dd8
[  145.570465] FS:  00007fa399988540(0000) GS:ffff888233e00000(0000) knlGS:0000000000000000
[  145.570519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  145.570571] CR2: 00007fa399b51421 CR3: 0000000137898002 CR4: 00000000003706e0
[  145.570623] Call Trace:
[  145.570675]  <TASK>
[  145.570727]  ? ath11k_ce_tx_process_cb+0x34b/0x860 [ath11k]
[  145.570797]  ath11k_ce_tx_process_cb+0x356/0x860 [ath11k]
[  145.570864]  ? tasklet_init+0x150/0x150
[  145.570919]  ? ath11k_ce_alloc_pipes+0x280/0x280 [ath11k]
[  145.570986]  ? tasklet_clear_sched+0x42/0xe0
[  145.571042]  ? tasklet_kill+0xe9/0x1b0
[  145.571095]  ? tasklet_clear_sched+0xe0/0xe0
[  145.571148]  ? irq_has_action+0x120/0x120
[  145.571202]  ath11k_ce_cleanup_pipes+0x45a/0x580 [ath11k]
[  145.571270]  ? ath11k_pci_stop+0x10e/0x170 [ath11k_pci]
[  145.571345]  ath11k_core_stop+0x8a/0xc0 [ath11k]
[  145.571434]  ath11k_core_deinit+0x9e/0x150 [ath11k]
[  145.571499]  ath11k_pci_remove+0xd2/0x260 [ath11k_pci]
[  145.571553]  pci_device_remove+0x9a/0x1c0
[  145.571605]  __device_release_driver+0x332/0x660
[  145.571659]  driver_detach+0x1e7/0x2c0
[  145.571712]  bus_remove_driver+0xe2/0x2d0
[  145.571772]  pci_unregister_driver+0x21/0x250
[  145.571826]  __do_sys_delete_module+0x30a/0x4b0
[  145.571879]  ? free_module+0xac0/0xac0
[  145.571933]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
[  145.571986]  ? syscall_enter_from_user_mode+0x1d/0x50
[  145.572039]  ? lockdep_hardirqs_on+0x79/0x100
[  145.572097]  do_syscall_64+0x3b/0x90
[  145.572153]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index cccaa348cf21..8b2143802816 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -561,7 +561,7 @@ static int ath11k_mhi_set_state(struct ath11k_pci *ab_pci,
 		ret = 0;
 		break;
 	case ATH11K_MHI_POWER_ON:
-		ret = mhi_async_power_up(ab_pci->mhi_ctrl);
+		ret = mhi_sync_power_up(ab_pci->mhi_ctrl);
 		break;
 	case ATH11K_MHI_POWER_OFF:
 		mhi_power_down(ab_pci->mhi_ctrl, true);
-- 
2.20.1

