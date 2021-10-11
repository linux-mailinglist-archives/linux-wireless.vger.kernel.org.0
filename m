Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52C428887
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJKIWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:22:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10444 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhJKIWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:22:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633940431; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YVE6OBK8qSKvJ++VncsbYopep0mUdm9U+0mCwNxuISs=; b=bPacYyaaxrh4UtUBdXMq+zbvfxr6BKyvMPjtD3NSooQAQCMu1+W68Hj3PjFIs7p+Ep4U9rIb
 jW5fizKk+PvrY9PY70xR5sWGqrezFIQ96Z8HziCzG540CM0x+n/vRqn8j70JMmiJOS/qk7Cp
 aBDqUCnBj5Soz2oBWdNCVcsuf2g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6163f3c90605239689f4c8cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:20:25
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D24A9C43460; Mon, 11 Oct 2021 08:20:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03D4DC4338F;
        Mon, 11 Oct 2021 08:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 03D4DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 3/3] ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base
Date:   Mon, 11 Oct 2021 04:19:38 -0400
Message-Id: <20211011081938.30327-4-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011081938.30327-1-wgong@codeaurora.org>
References: <20211011081938.30327-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
because firmware has not been initilized at that moment, firmware
is only finished downloaded and loaded, it can not receive scan
command.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 52 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/core.h |  5 +++
 drivers/net/wireless/ath/ath11k/mac.c  | 23 ++++++++++++
 3 files changed, 72 insertions(+), 8 deletions(-)

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
index b0a2f257f328..97d685b6fd14 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4377,6 +4377,28 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 	return ret;
 }
 
+static void ath11k_mac_wait_reconfigure(struct ath11k_base *ab)
+{
+	long time_left;
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
+	time_left = wait_for_completion_timeout(&ab->reconfigure_complete,
+						ATH11K_RECONFIGURE_TIMEOUT_HZ);
+}
+
 static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath11k *ar = hw->priv;
@@ -4393,6 +4415,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		break;
 	case ATH11K_STATE_RESTARTING:
 		ar->state = ATH11K_STATE_RESTARTED;
+		ath11k_mac_wait_reconfigure(ab);
 		break;
 	case ATH11K_STATE_RESTARTED:
 	case ATH11K_STATE_WEDGED:
-- 
2.31.1

