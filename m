Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8197B4C6355
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 07:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiB1GrG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 01:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiB1GrF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 01:47:05 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604466C8F
        for <linux-wireless@vger.kernel.org>; Sun, 27 Feb 2022 22:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646030787; x=1677566787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phngvTnaxifJzlhzmmF1rO3OdpLOMsIIKjL0g+CQaAE=;
  b=UqdD//IAHJ3zLhuN0pR6sgE8GB3+Vw7kWOVv2CqNy0MnsC+k0TKMe3zO
   tkYsIJEXNVQKNF9F8Ujx80p6q68GavR9nmELgleaJ0k40RxOdRhAVlAwm
   8U/JiiBR5avG6idlSQX3PPd7xbW+rpgVXRJg+3GiuAI+17t8WibSAkx5G
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Feb 2022 22:46:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 22:46:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 22:46:27 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 22:46:25 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v8 4/4] ath11k: fix the warning of dev_wake in mhi_pm_disable_transition()
Date:   Mon, 28 Feb 2022 01:46:06 -0500
Message-ID: <20220228064606.8981-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220228064606.8981-1-quic_wgong@quicinc.com>
References: <20220228064606.8981-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When test device recovery with below command, it has warning in message
as below.
echo assert > /sys/kernel/debug/ath11k/wcn6855\ hw2.0/simulate_fw_crash
echo assert > /sys/kernel/debug/ath11k/qca6390\ hw2.0/simulate_fw_crash

warning message:
[ 1965.642121] ath11k_pci 0000:06:00.0: simulating firmware assert crash
[ 1968.471364] ieee80211 phy0: Hardware restart was requested
[ 1968.511305] ------------[ cut here ]------------
[ 1968.511368] WARNING: CPU: 3 PID: 1546 at drivers/bus/mhi/core/pm.c:505 mhi_pm_disable_transition+0xb37/0xda0 [mhi]
[ 1968.511443] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr nvme nvme_core
[ 1968.511563] CPU: 3 PID: 1546 Comm: kworker/u17:0 Kdump: loaded Tainted: G        W         5.17.0-rc3-wt-ath+ #579
[ 1968.511629] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[ 1968.511704] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
[ 1968.511787] RIP: 0010:mhi_pm_disable_transition+0xb37/0xda0 [mhi]
[ 1968.511870] Code: a9 fe ff ff 4c 89 ff 44 89 04 24 e8 03 46 f6 e5 44 8b 04 24 41 83 f8 01 0f 84 21 fe ff ff e9 4c fd ff ff 0f 0b e9 af f8 ff ff <0f> 0b e9 5c f8 ff ff 48 89 df e8 da 9e ee e3 e9 12 fd ff ff 4c 89
[ 1968.511923] RSP: 0018:ffffc900024efbf0 EFLAGS: 00010286
[ 1968.511969] RAX: 00000000ffffffff RBX: ffff88811d241250 RCX: ffffffffc0176922
[ 1968.512014] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888118a90a24
[ 1968.512059] RBP: ffff888118a90800 R08: 0000000000000000 R09: ffff888118a90a27
[ 1968.512102] R10: ffffed1023152144 R11: 0000000000000001 R12: ffff888118a908ac
[ 1968.512229] R13: ffff888118a90928 R14: dffffc0000000000 R15: ffff888118a90a24
[ 1968.512310] FS:  0000000000000000(0000) GS:ffff888234200000(0000) knlGS:0000000000000000
[ 1968.512405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1968.512493] CR2: 00007f5538f443a8 CR3: 000000016dc28001 CR4: 00000000003706e0
[ 1968.512587] Call Trace:
[ 1968.512672]  <TASK>
[ 1968.512751]  ? _raw_spin_unlock_irq+0x1f/0x40
[ 1968.512859]  mhi_pm_st_worker+0x3ac/0x790 [mhi]
[ 1968.512959]  ? mhi_pm_mission_mode_transition.isra.0+0x7d0/0x7d0 [mhi]
[ 1968.513063]  process_one_work+0x86a/0x1400
[ 1968.513184]  ? pwq_dec_nr_in_flight+0x230/0x230
[ 1968.513312]  ? move_linked_works+0x125/0x290
[ 1968.513416]  worker_thread+0x6db/0xf60
[ 1968.513536]  ? process_one_work+0x1400/0x1400
[ 1968.513627]  kthread+0x241/0x2d0
[ 1968.513733]  ? kthread_complete_and_exit+0x20/0x20
[ 1968.513821]  ret_from_fork+0x22/0x30
[ 1968.513924]  </TASK>

Reason is mhi_deassert_dev_wake() from mhi_device_put() is called
but mhi_assert_dev_wake() from __mhi_device_get_sync() is not called
in progress of recovery. Commit 8e0559921f9a ("bus: mhi: core:
Skip device wake in error or shutdown state") add check for the
pm_state of mhi in __mhi_device_get_sync(), and the pm_state is not
the normal state untill recovery is completed, so it leads the
dev_wake is not 0 and above warning print in mhi_pm_disable_transition()
while checking mhi_cntrl->dev_wake.

Add check in ath11k_pci_write32()/ath11k_pci_read32() to skip call
mhi_device_put() if mhi_device_get_sync() does not really do wake,
then the warning gone.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 903758751c99..8a3ff12057e8 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -191,6 +191,7 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 window_start;
+	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
@@ -198,7 +199,7 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
 	if (offset < WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
@@ -222,7 +223,8 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
+	    offset >= ACCESS_ALWAYS_OFF &&
+	    !ret)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
@@ -230,6 +232,7 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 val, window_start;
+	int ret = 0;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
@@ -237,7 +240,7 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
 	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
 
 	if (offset < WINDOW_START) {
 		val = ioread32(ab->mem + offset);
@@ -261,7 +264,8 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 
 	if (ab->hw_params.wakeup_mhi &&
 	    test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
+	    offset >= ACCESS_ALWAYS_OFF &&
+	    !ret)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 
 	return val;
-- 
2.31.1

