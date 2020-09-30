Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12ED27E717
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgI3Kvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 06:51:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:50946 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgI3KvZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601463085; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7Xry2G8HRZ3BO33J96TS1x8PN7rLX3FG4mxDmcjil7g=; b=UXrBvfqylQG/uTE/5PM9+reAkN/HLv3+sUOqKVkcBmDSzVFsBL2o0ClB6NG/FPuuQf20bWqY
 uoJCOxpHQ01ohq+0/VKHY8Y67dZ7WD/xKXBs8/76t6cSI/culd3Fegs24UkPEWJz0ouTqFj9
 b4HLrPtHmkUCDoYZ7xIKWQPDYkA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f74632c70602555f56b21df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 10:51:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01059C43382; Wed, 30 Sep 2020 10:51:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD84DC433C8;
        Wed, 30 Sep 2020 10:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD84DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/5] ath11k: fix warning caused by lockdep_assert_held
Date:   Wed, 30 Sep 2020 13:51:12 +0300
Message-Id: <1601463073-12106-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
References: <1601463073-12106-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Fix warning caused by lockdep_assert_held when CONFIG_LOCKDEP is enabled.

[  271.940647] WARNING: CPU: 6 PID: 0 at drivers/net/wireless/ath/ath11k/hal.c:818 ath11k_hal_srng_access_begin+0x31/0x40 [ath11k]
[  271.940655] Modules linked in: qrtr_mhi qrtr ns ath11k_pci mhi ath11k qmi_helpers nvme nvme_core
[  271.940675] CPU: 6 PID: 0 Comm: swapper/6 Kdump: loaded Tainted: G        W         5.9.0-rc5-kalle-bringup-wt-ath+ #4
[  271.940682] Hardware name: Dell Inc. Inspiron 7590/08717F, BIOS 1.3.0 07/22/2019
[  271.940698] RIP: 0010:ath11k_hal_srng_access_begin+0x31/0x40 [ath11k]
[  271.940708] Code: 48 89 f3 85 c0 75 11 48 8b 83 a8 00 00 00 8b 00 89 83 b0 00 00 00 5b c3 48 8d 7e 58 be ff ff ff ff e8 53 24 ec fa 85 c0 75 dd <0f> 0b eb d9 90 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 f3 8b 35
[  271.940718] RSP: 0018:ffffbdf0c0230df8 EFLAGS: 00010246
[  271.940727] RAX: 0000000000000000 RBX: ffffa12b34e67680 RCX: ffffa12b57a0d800
[  271.940735] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffa12b34e676d8
[  271.940742] RBP: ffffa12b34e60000 R08: 0000000000000001 R09: 0000000000000001
[  271.940753] R10: 0000000000000001 R11: 0000000000000046 R12: 0000000000000000
[  271.940763] R13: ffffa12b34e60000 R14: ffffa12b34e60000 R15: 0000000000000000
[  271.940774] FS:  0000000000000000(0000) GS:ffffa12b5a400000(0000) knlGS:0000000000000000
[  271.940788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  271.940798] CR2: 00007f8bef282008 CR3: 00000001f4224004 CR4: 00000000003706e0
[  271.940805] Call Trace:
[  271.940813]  <IRQ>
[  271.940835]  ath11k_dp_tx_completion_handler+0x9e/0x950 [ath11k]
[  271.940847]  ? lock_acquire+0xba/0x3b0
[  271.940876]  ath11k_dp_service_srng+0x5a/0x2e0 [ath11k]
[  271.940893]  ath11k_pci_ext_grp_napi_poll+0x1e/0x80 [ath11k_pci]
[  271.940908]  net_rx_action+0x283/0x4f0
[  271.940931]  __do_softirq+0xcb/0x499
[  271.940950]  asm_call_on_stack+0x12/0x20
[  271.940963]  </IRQ>
[  271.940979]  do_softirq_own_stack+0x4d/0x60
[  271.940991]  irq_exit_rcu+0xb0/0xc0
[  271.941001]  common_interrupt+0xce/0x190
[  271.941014]  asm_common_interrupt+0x1e/0x40
[  271.941026] RIP: 0010:cpuidle_enter_state+0x115/0x500

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index e907a8555583..d329ff75221b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -536,6 +536,8 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 	u32 msdu_id;
 	u8 mac_id;
 
+	spin_lock_bh(&status_ring->lock);
+
 	ath11k_hal_srng_access_begin(ab, status_ring);
 
 	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) !=
@@ -555,6 +557,8 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 
 	ath11k_hal_srng_access_end(ab, status_ring);
 
+	spin_unlock_bh(&status_ring->lock);
+
 	while (ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_tail) != tx_ring->tx_status_head) {
 		struct hal_wbm_release_ring *tx_status;
 		u32 desc_id;
-- 
2.7.4

