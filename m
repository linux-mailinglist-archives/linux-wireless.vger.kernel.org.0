Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37E832202C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 20:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhBVTaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 14:30:19 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:46467 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhBVT1z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 14:27:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614022055; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SCEC6HOKrtZQRoSPRBfCYizjUcf7n1feZudj8KiArug=; b=i/Zn48+pFqmdaekniHcWYl7ZI+5uVR+hxufXYjUU6tzprjaSApGdjsJPa/tgkXv7cE0QO/hk
 t3N3AYepKZl53odek7DTnCTH0oY4Uqg7wGBqughdgrWCdpeg7YaV8C4/i2TDRpmYJIX7YgIC
 YqaC0iDvOBMDB76c/bWAkCZ8nO8=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60340587ba086638309f1e15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 19:27:03
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A972BC433ED; Mon, 22 Feb 2021 19:27:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDC59C433C6;
        Mon, 22 Feb 2021 19:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDC59C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V5 2/2] ath11k: add debugfs for TWT debug calls
Date:   Mon, 22 Feb 2021 11:26:51 -0800
Message-Id: <20210222192651.1782-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210222192651.1782-1-alokad@codeaurora.org>
References: <20210222192651.1782-1-alokad@codeaurora.org>
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
<Wake_Duration_Usec> <First_SP_Offset> <TWT_Command> <1:Broadcast /
0:Individual> <1:Triggered / 0:Untriggered> <1:Unannounced /
0:Announced> <1:Protected / 0:Unprotected>' >
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

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
Changes in V5
* TWT directory created during ath11k_mac_op_add_interface() instead
* of during TWT enable command.
* File write operation check for twt_enabled.
* Used CONFIG_ATH11K_DEBUGFS instead of CONFIG_MAC80211_DEBUGFS.
* Example commands in commit description.
---
 drivers/net/wireless/ath/ath11k/core.h  |   3 +
 drivers/net/wireless/ath/ath11k/debug.c | 224 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debug.h |  13 ++
 drivers/net/wireless/ath/ath11k/mac.c   |   3 +
 4 files changed, 243 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a7d5333485aa..944a9f88ed17 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -241,6 +241,9 @@ struct ath11k_vif {
 	bool rsnie_present;
 	bool wpaie_present;
 	struct ieee80211_chanctx_conf chanctx;
+#ifdef CONFIG_ATH11K_DEBUGFS
+	struct dentry *debugfs_twt;
+#endif /* CONFIG_ATH11K_DEBUGFS */
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index c86de95fbdc5..781b472ae987 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -104,3 +104,227 @@ void ath11k_dbg_dump(struct ath11k_base *ab,
 EXPORT_SYMBOL(ath11k_dbg_dump);
 
 #endif /* CONFIG_ATH11K_DEBUG */
+
+#ifdef CONFIG_ATH11K_DEBUGFS
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
+		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
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
+		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
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
+		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
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
+		ath11k_err(arvif->ar->ab, "TWT support is not enabled\n");
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
+void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+{
+	if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
+		arvif->debugfs_twt = debugfs_create_dir("twt",
+							arvif->vif->debugfs_dir);
+		if (IS_ERR_OR_NULL(arvif->debugfs_twt)) {
+			ath11k_warn(arvif->ar->ab,
+				    "failed to create twt debugfs: %p\n",
+				    arvif->debugfs_twt);
+			arvif->debugfs_twt = NULL;
+			return;
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
+}
+
+void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
+{
+	debugfs_remove_recursive(arvif->debugfs_twt);
+	arvif->debugfs_twt = NULL;
+}
+
+#endif /* CONFIG_ATH11K_DEBUGFS */
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 659a275e2eb3..2b41cefb68b5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -64,4 +64,17 @@ do {								\
 		__ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#ifdef CONFIG_ATH11K_DEBUGFS
+void ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
+void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
+#else /* CONFIG_ATH11K_DEBUGFS */
+static inline void ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
+{
+}
+
+static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
+{
+}
+#endif /* CONFIG_ATH11K_DEBUGFS */
+
 #endif /* _ATH11K_DEBUG_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 335d49af7dd5..aa0f2b65d10c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4766,6 +4766,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ath11k_dp_vdev_tx_attach(ar, arvif);
+	ath11k_debugfs_add_interface(arvif);
 
 	mutex_unlock(&ar->conf_mutex);
 
@@ -4885,6 +4886,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	/* TODO: recal traffic pause state based on the available vdevs */
 
+	ath11k_debugfs_remove_interface(arvif);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
-- 
2.25.0

