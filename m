Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F028748CA88
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 19:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348662AbiALSAn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 13:00:43 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:31551 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348654AbiALSAi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 13:00:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1642010436; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=N0y72wPSbIE2h/nO1Fqk7OoOuvrOPsjCTObbzaz878Y=; b=LYRzfvdLyk6olfCr2q7EJXqQxGLhC7ACvdi4Dhmmg+1HyVqzfu2yItReo4zwxE2mCiPZkRQO
 FEs3eurNNRLjQdNlFl5ZGI4jTUwVc4qMqlsG0mRsFYSDWH5S963dOr6ptPxtet260AQWgZmq
 ruXDpIwL4FdWiHLPp36wpt2B1so=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61df174469943108c5977215 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Jan 2022 18:00:36
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1911CC4338F; Wed, 12 Jan 2022 18:00:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0EC9C43619;
        Wed, 12 Jan 2022 18:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C0EC9C43619
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [V7 2/2] ath11k: add debugfs for TWT debug calls
Date:   Wed, 12 Jan 2022 10:00:26 -0800
Message-Id: <20220112180026.5554-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112180026.5554-1-alokad@codeaurora.org>
References: <20220112180026.5554-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

New debugfs files to manually add/delete/pause/resume TWT
dialogs for test/debug purposes.

The debugfs files expect the following parameters
(1) Add dialog
echo '<Peer_MAC> <Dialog_ID> <Wake_Interval_Usec> <Wake_Interval_Mantis>
 <Wake_Duration_Usec> <First_SP_Offset> <TWT_Command>
 <1:Broadcast /0:Individual> <1:Triggered / 0:Untriggered>
 <1:Unannounced /0:Announced> <1:Protected / 0:Unprotected>' >
 /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/add_dialog

Example (Non-triggered and un-announced):
echo '00:03:7F:20:13:52 1 102400 100 30720 20480 4 0 0 1 0' >
 /sys/kernel/debug/ieee80211/phy0/netdev:wlan0/twt/add_dialog

(2) Delete dialog
echo '<Peer_MAC> <Dialog_ID>' >
 /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/del_dialog

(3) Pause dialog
echo '<Peer_MAC> <Dialog_ID>' >
 /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/pause_dialog

(4) Resume dialog
echo '<Peer_MAC> <Dialog_ID> <SP_Offset_Usec> <Next_TWT_Size>' >
 /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/twt/resume_dialog

Example:
echo '00:03:7F:20:13:52 1 2000000 3' >
 /sys/kernel/debug/ieee80211/phy0/netdev:wlan0/twt/resume_dialog

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
Changes in V7
* Only rebased

Changes in V6
* Moved all functions from debug.c to debugfs.c
* ath11k_debugfs_add_interface() returns int instead of void

Changes in V5
* TWT directory created during ath11k_mac_op_add_interface() instead
  of during TWT enable command.
* File write operation check for twt_enabled.
* Used CONFIG_ATH11K_DEBUGFS instead of CONFIG_MAC80211_DEBUGFS.
* Example commands in commit description.

 drivers/net/wireless/ath/ath11k/core.h    |   3 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 222 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  14 +-
 drivers/net/wireless/ath/ath11k/mac.c     |   7 +
 4 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9bea019605d5..501c88c99c2b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -263,6 +263,9 @@ struct ath11k_vif {
 	bool bcca_zero_sent;
 	bool do_not_send_tmpl;
 	struct ieee80211_chanctx_conf chanctx;
+#ifdef CONFIG_ATH11K_DEBUGFS
+	struct dentry *debugfs_twt;
+#endif /* CONFIG_ATH11K_DEBUGFS */
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 198ade90b725..6cfa5c6093aa 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1152,3 +1152,225 @@ int ath11k_debugfs_register(struct ath11k *ar)
 void ath11k_debugfs_unregister(struct ath11k *ar)
 {
 }
+
+static ssize_t ath11k_write_twt_add_dialog(struct file *file,
+					   const char __user *ubuf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	struct wmi_twt_add_dialog_params params = { 0 };
+	u8 buf[128] = {0};
+	int ret;
+
+	if (arvif->ar->twt_enabled == 0) {
+		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+	ret = sscanf(buf,
+		     "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u %u %u %u %u %hhu %hhu %hhu %hhu %hhu",
+		     &params.peer_macaddr[0],
+		     &params.peer_macaddr[1],
+		     &params.peer_macaddr[2],
+		     &params.peer_macaddr[3],
+		     &params.peer_macaddr[4],
+		     &params.peer_macaddr[5],
+		     &params.dialog_id,
+		     &params.wake_intvl_us,
+		     &params.wake_intvl_mantis,
+		     &params.wake_dura_us,
+		     &params.sp_offset_us,
+		     &params.twt_cmd,
+		     &params.flag_bcast,
+		     &params.flag_trigger,
+		     &params.flag_flow_type,
+		     &params.flag_protection);
+	if (ret != 16)
+		return -EINVAL;
+
+	params.vdev_id = arvif->vdev_id;
+
+	ret = ath11k_wmi_send_twt_add_dialog_cmd(arvif->ar, &params);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t ath11k_write_twt_del_dialog(struct file *file,
+					   const char __user *ubuf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	struct wmi_twt_del_dialog_params params = { 0 };
+	u8 buf[64] = {0};
+	int ret;
+
+	if (arvif->ar->twt_enabled == 0) {
+		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u",
+		     &params.peer_macaddr[0],
+		     &params.peer_macaddr[1],
+		     &params.peer_macaddr[2],
+		     &params.peer_macaddr[3],
+		     &params.peer_macaddr[4],
+		     &params.peer_macaddr[5],
+		     &params.dialog_id);
+	if (ret != 7)
+		return -EINVAL;
+
+	params.vdev_id = arvif->vdev_id;
+
+	ret = ath11k_wmi_send_twt_del_dialog_cmd(arvif->ar, &params);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t ath11k_write_twt_pause_dialog(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	struct wmi_twt_pause_dialog_params params = { 0 };
+	u8 buf[64] = {0};
+	int ret;
+
+	if (arvif->ar->twt_enabled == 0) {
+		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u",
+		     &params.peer_macaddr[0],
+		     &params.peer_macaddr[1],
+		     &params.peer_macaddr[2],
+		     &params.peer_macaddr[3],
+		     &params.peer_macaddr[4],
+		     &params.peer_macaddr[5],
+		     &params.dialog_id);
+	if (ret != 7)
+		return -EINVAL;
+
+	params.vdev_id = arvif->vdev_id;
+
+	ret = ath11k_wmi_send_twt_pause_dialog_cmd(arvif->ar, &params);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t ath11k_write_twt_resume_dialog(struct file *file,
+					      const char __user *ubuf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	struct wmi_twt_resume_dialog_params params = { 0 };
+	u8 buf[64] = {0};
+	int ret;
+
+	if (arvif->ar->twt_enabled == 0) {
+		ath11k_err(arvif->ar->ab, "twt support is not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx %u %u %u",
+		     &params.peer_macaddr[0],
+		     &params.peer_macaddr[1],
+		     &params.peer_macaddr[2],
+		     &params.peer_macaddr[3],
+		     &params.peer_macaddr[4],
+		     &params.peer_macaddr[5],
+		     &params.dialog_id,
+		     &params.sp_offset_us,
+		     &params.next_twt_size);
+	if (ret != 9)
+		return -EINVAL;
+
+	params.vdev_id = arvif->vdev_id;
+
+	ret = ath11k_wmi_send_twt_resume_dialog_cmd(arvif->ar, &params);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations ath11k_fops_twt_add_dialog = {
+	.write = ath11k_write_twt_add_dialog,
+	.open = simple_open
+};
+
+static const struct file_operations ath11k_fops_twt_del_dialog = {
+	.write = ath11k_write_twt_del_dialog,
+	.open = simple_open
+};
+
+static const struct file_operations ath11k_fops_twt_pause_dialog = {
+	.write = ath11k_write_twt_pause_dialog,
+	.open = simple_open
+};
+
+static const struct file_operations ath11k_fops_twt_resume_dialog = {
+	.write = ath11k_write_twt_resume_dialog,
+	.open = simple_open
+};
+
+int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+{
+	if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
+		arvif->debugfs_twt = debugfs_create_dir("twt",
+							arvif->vif->debugfs_dir);
+		if (!arvif->debugfs_twt || IS_ERR(arvif->debugfs_twt)) {
+			ath11k_warn(arvif->ar->ab,
+				    "failed to create directory %p\n",
+				    arvif->debugfs_twt);
+			arvif->debugfs_twt = NULL;
+			return -1;
+		}
+
+		debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
+				    arvif, &ath11k_fops_twt_add_dialog);
+
+		debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
+				    arvif, &ath11k_fops_twt_del_dialog);
+
+		debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
+				    arvif, &ath11k_fops_twt_pause_dialog);
+
+		debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
+				    arvif, &ath11k_fops_twt_resume_dialog);
+	}
+	return 0;
+}
+
+void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
+{
+	debugfs_remove_recursive(arvif->debugfs_twt);
+	arvif->debugfs_twt = NULL;
+}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 4c0740394c95..8ee5759fadf8 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -151,6 +151,9 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
+int ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
+void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
+
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
@@ -224,6 +227,15 @@ static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
 	return 0;
 }
 
-#endif /* CONFIG_MAC80211_DEBUGFS*/
+static inline int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+{
+	return 0;
+}
+
+static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
+{
+}
+
+#endif /* CONFIG_ATH11K_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d5ec92..52fc661a5606 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6341,6 +6341,10 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		}
 	}
 
+	ret = ath11k_debugfs_add_interface(arvif);
+	if (ret)
+		goto err_peer_del;
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
@@ -6375,6 +6379,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 err:
+	ath11k_debugfs_remove_interface(arvif);
 	mutex_unlock(&ar->conf_mutex);
 
 	return ret;
@@ -6473,6 +6478,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
 
+	ath11k_debugfs_remove_interface(arvif);
+
 	/* TODO: recal traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
-- 
2.31.1

