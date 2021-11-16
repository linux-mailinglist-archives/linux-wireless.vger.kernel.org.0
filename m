Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57693452910
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 05:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbhKPEUr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 23:20:47 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11517 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbhKPESo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 23:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637036148; x=1668572148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eY+kQk2EJ3Ep3pHgVBobULW5FaN8/8feHDrIDqeVVC8=;
  b=tg27z3/FsE9VB3kEU9ANYcxjhAIHHlEzvYerIkhYukXrI5TX0SX4+n6e
   7za+9gjGcw2bsIwBkz5MzDRK6j2uf2cGLGTsgeiW6MnYTaTrn/d2126C4
   +0GNUsyU4MJ1JuByiYbJBB8/5lu/N5BCygdF0PbtrewV85CafVr27ZeRv
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Nov 2021 20:15:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 20:15:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:44 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 20:15:42 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4 4/4] ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base
Date:   Mon, 15 Nov 2021 23:15:22 -0500
Message-ID: <20211116041522.23529-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116041522.23529-1-quic_wgong@quicinc.com>
References: <20211116041522.23529-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_reconfig() of mac80211 is the main function for recovery of
each ieee80211_hw and ath11k, and ath11k_core_reconfigure_on_crash()
is the main function for recovery of ath11k_base, it has more than
one ieee80211_hw and ath11k for each ath11k_base, so it need to add
synchronization between them, otherwise it has many issue.

For example, when ath11k_core_reconfigure_on_crash() is not complete,
mac80211 send a hw scan request to ath11k, it leads firmware crash,
because firmware has not been initialized at that moment, firmware
is only finished downloaded and loaded, it can not receive scan
command.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 52 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/core.h |  5 +++
 drivers/net/wireless/ath/ath11k/mac.c  | 22 +++++++++++
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be788ec08200..0dc489d5c259 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -965,12 +965,11 @@ void ath11k_core_halt(struct ath11k *ar)
 	idr_init(&ar->txmgmt_idr);
 }
 
-static void ath11k_core_restart(struct work_struct *work)
+static void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
 {
-	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
 	struct ath11k *ar;
 	struct ath11k_pdev *pdev;
-	int i, ret = 0;
+	int i;
 
 	spin_lock_bh(&ab->base_lock);
 	ab->stats.fw_crash_counter++;
@@ -1002,12 +1001,13 @@ static void ath11k_core_restart(struct work_struct *work)
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
 	wake_up(&ab->peer_mapping_wq);
+}
 
-	ret = ath11k_core_reconfigure_on_crash(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
-		return;
-	}
+static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	int i;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
@@ -1043,6 +1043,27 @@ static void ath11k_core_restart(struct work_struct *work)
 	complete(&ab->driver_recovery);
 }
 
+static void ath11k_core_restart(struct work_struct *work)
+{
+	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
+	int ret;
+
+	if (!ab->is_reset)
+		ath11k_core_pre_reconfigure_recovery(ab);
+
+	ret = ath11k_core_reconfigure_on_crash(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
+		return;
+	}
+
+	if (ab->is_reset)
+		complete_all(&ab->reconfigure_complete);
+
+	if (!ab->is_reset)
+		ath11k_core_post_reconfigure_recovery(ab);
+}
+
 static void ath11k_core_reset(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, reset_work);
@@ -1095,6 +1116,19 @@ static void ath11k_core_reset(struct work_struct *work)
 	ab->is_reset = true;
 	atomic_set(&ab->recovery_count, 0);
 
+	ath11k_core_pre_reconfigure_recovery(ab);
+
+	reinit_completion(&ab->reconfigure_complete);
+	ath11k_core_post_reconfigure_recovery(ab);
+
+	reinit_completion(&ab->recovery_start);
+	atomic_set(&ab->recovery_start_count, 0);
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "waiting recovery start...\n");
+
+	time_left = wait_for_completion_timeout(&ab->recovery_start,
+						ATH11K_RECOVER_START_TIMEOUT_HZ);
+
 	ath11k_hif_power_down(ab);
 	ath11k_qmi_free_resource(ab);
 	ath11k_hif_power_up(ab);
@@ -1198,6 +1232,8 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
 	init_completion(&ab->reset_complete);
+	init_completion(&ab->reconfigure_complete);
+	init_completion(&ab->recovery_start);
 
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9a9f8f24d407..95b9ebcd0e35 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -43,6 +43,8 @@ extern unsigned int ath11k_frame_mode;
 #define ATH11K_RESET_MAX_FAIL_COUNT_FIRST 3
 #define ATH11K_RESET_MAX_FAIL_COUNT_FINAL 5
 #define ATH11K_RESET_FAIL_TIMEOUT_HZ (20 * HZ)
+#define ATH11K_RECONFIGURE_TIMEOUT_HZ (10 * HZ)
+#define ATH11K_RECOVER_START_TIMEOUT_HZ (20 * HZ)
 
 enum ath11k_supported_bw {
 	ATH11K_BW_20	= 0,
@@ -742,8 +744,11 @@ struct ath11k_base {
 	struct work_struct reset_work;
 	atomic_t reset_count;
 	atomic_t recovery_count;
+	atomic_t recovery_start_count;
 	bool is_reset;
 	struct completion reset_complete;
+	struct completion reconfigure_complete;
+	struct completion recovery_start;
 	/* continuous recovery fail count */
 	atomic_t fail_cont_count;
 	unsigned long reset_fail_timeout;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b0a2f257f328..a680def29bb9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4377,6 +4377,27 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 	return ret;
 }
 
+static void ath11k_mac_wait_reconfigure(struct ath11k_base *ab)
+{
+	int recovery_start_count;
+
+	if (!ab->is_reset)
+		return;
+
+	recovery_start_count = atomic_inc_return(&ab->recovery_start_count);
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "recovery start count %d\n", recovery_start_count);
+
+	if (recovery_start_count == ab->num_radios) {
+		complete(&ab->recovery_start);
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "recovery started success\n");
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "waiting reconfigure...\n");
+
+	wait_for_completion_timeout(&ab->reconfigure_complete,
+				    ATH11K_RECONFIGURE_TIMEOUT_HZ);
+}
+
 static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath11k *ar = hw->priv;
@@ -4393,6 +4414,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		break;
 	case ATH11K_STATE_RESTARTING:
 		ar->state = ATH11K_STATE_RESTARTED;
+		ath11k_mac_wait_reconfigure(ab);
 		break;
 	case ATH11K_STATE_RESTARTED:
 	case ATH11K_STATE_WEDGED:
-- 
2.31.1

