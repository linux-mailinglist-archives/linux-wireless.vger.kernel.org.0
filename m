Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8A473A2
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfFPHdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:33:15 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:35637 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfFPHdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:33:15 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499834"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:12 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 04/11] wil6210: Add support for setting RBUFCAP configuration
Date:   Sun, 16 Jun 2019 10:26:00 +0300
Message-Id: <1560669967-23706-5-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alexei Avshalom Lazar <ailizaro@codeaurora.org>

RBUFCAP support added in FW.
The RBUFCAP feature is amendment to the block ack mechanism to
prevent overloading of the recipient’s memory space, which may
happen in case the link speed is higher than STA’s capability
to process or consume incoming data.
The block ack policy (ba_policy) is now controlled by FW so driver
should ignore this field.
Add new debugfs "rbufcap" to configure RBUFCAP.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/debugfs.c    | 39 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/rx_reorder.c | 31 ++++++++-------------
 drivers/net/wireless/ath/wil6210/wil6210.h    |  1 +
 drivers/net/wireless/ath/wil6210/wmi.c        | 39 +++++++++++++++++++++++++--
 4 files changed, 88 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 7a2c3fd..14778a1c 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -777,6 +777,44 @@ static ssize_t wil_write_file_rxon(struct file *file, const char __user *buf,
 	.open  = simple_open,
 };
 
+static ssize_t wil_write_file_rbufcap(struct file *file,
+				      const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct wil6210_priv *wil = file->private_data;
+	int val;
+	int rc;
+
+	rc = kstrtoint_from_user(buf, count, 0, &val);
+	if (rc) {
+		wil_err(wil, "Invalid argument\n");
+		return rc;
+	}
+	/* input value: negative to disable, 0 to use system default,
+	 * 1..ring size to set descriptor threshold
+	 */
+	wil_info(wil, "%s RBUFCAP, descriptors threshold - %d\n",
+		 val < 0 ? "Disabling" : "Enabling", val);
+
+	if (!wil->ring_rx.va || val > wil->ring_rx.size) {
+		wil_err(wil, "Invalid descriptors threshold, %d\n", val);
+		return -EINVAL;
+	}
+
+	rc = wmi_rbufcap_cfg(wil, val < 0 ? 0 : 1, val < 0 ? 0 : val);
+	if (rc) {
+		wil_err(wil, "RBUFCAP config failed: %d\n", rc);
+		return rc;
+	}
+
+	return count;
+}
+
+static const struct file_operations fops_rbufcap = {
+	.write = wil_write_file_rbufcap,
+	.open  = simple_open,
+};
+
 /* block ack control, write:
  * - "add <ringid> <agg_size> <timeout>" to trigger ADDBA
  * - "del_tx <ringid> <reason>" to trigger DELBA for Tx side
@@ -2364,6 +2402,7 @@ static void wil6210_debugfs_init_blobs(struct wil6210_priv *wil,
 	{"tx_latency",	0644,		&fops_tx_latency},
 	{"link_stats",	0644,		&fops_link_stats},
 	{"link_stats_global",	0644,	&fops_link_stats_global},
+	{"rbufcap",	0244,		&fops_rbufcap},
 };
 
 static void wil6210_debugfs_init_files(struct wil6210_priv *wil,
diff --git a/drivers/net/wireless/ath/wil6210/rx_reorder.c b/drivers/net/wireless/ath/wil6210/rx_reorder.c
index 1c79664..784239b 100644
--- a/drivers/net/wireless/ath/wil6210/rx_reorder.c
+++ b/drivers/net/wireless/ath/wil6210/rx_reorder.c
@@ -316,7 +316,7 @@ int wil_addba_rx_request(struct wil6210_priv *wil, u8 mid, u8 cid, u8 tid,
 	u16 agg_timeout = le16_to_cpu(ba_timeout);
 	u16 seq_ctrl = le16_to_cpu(ba_seq_ctrl);
 	struct wil_sta_info *sta;
-	u16 agg_wsize = 0;
+	u16 agg_wsize;
 	/* bit 0: A-MSDU supported
 	 * bit 1: policy (should be 0 for us)
 	 * bits 2..5: TID
@@ -328,7 +328,6 @@ int wil_addba_rx_request(struct wil6210_priv *wil, u8 mid, u8 cid, u8 tid,
 		test_bit(WMI_FW_CAPABILITY_AMSDU, wil->fw_capabilities) &&
 		wil->amsdu_en && (param_set & BIT(0));
 	int ba_policy = param_set & BIT(1);
-	u16 status = WLAN_STATUS_SUCCESS;
 	u16 ssn = seq_ctrl >> 4;
 	struct wil_tid_ampdu_rx *r;
 	int rc = 0;
@@ -355,27 +354,19 @@ int wil_addba_rx_request(struct wil6210_priv *wil, u8 mid, u8 cid, u8 tid,
 		    agg_amsdu ? "+" : "-", !!ba_policy, dialog_token, ssn);
 
 	/* apply policies */
-	if (ba_policy) {
-		wil_err(wil, "BACK requested unsupported ba_policy == 1\n");
-		status = WLAN_STATUS_INVALID_QOS_PARAM;
-	}
-	if (status == WLAN_STATUS_SUCCESS) {
-		if (req_agg_wsize == 0) {
-			wil_dbg_misc(wil, "Suggest BACK wsize %d\n",
-				     wil->max_agg_wsize);
-			agg_wsize = wil->max_agg_wsize;
-		} else {
-			agg_wsize = min_t(u16,
-					  wil->max_agg_wsize, req_agg_wsize);
-		}
+	if (req_agg_wsize == 0) {
+		wil_dbg_misc(wil, "Suggest BACK wsize %d\n",
+			     wil->max_agg_wsize);
+		agg_wsize = wil->max_agg_wsize;
+	} else {
+		agg_wsize = min_t(u16, wil->max_agg_wsize, req_agg_wsize);
 	}
 
 	rc = wil->txrx_ops.wmi_addba_rx_resp(wil, mid, cid, tid, dialog_token,
-					     status, agg_amsdu, agg_wsize,
-					     agg_timeout);
-	if (rc || (status != WLAN_STATUS_SUCCESS)) {
-		wil_err(wil, "do not apply ba, rc(%d), status(%d)\n", rc,
-			status);
+					     WLAN_STATUS_SUCCESS, agg_amsdu,
+					     agg_wsize, agg_timeout);
+	if (rc) {
+		wil_err(wil, "do not apply ba, rc(%d)\n", rc);
 		goto out;
 	}
 
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 4498403..75abec2 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1406,6 +1406,7 @@ int wmi_start_sched_scan(struct wil6210_priv *wil,
 int wmi_mgmt_tx(struct wil6210_vif *vif, const u8 *buf, size_t len);
 int wmi_mgmt_tx_ext(struct wil6210_vif *vif, const u8 *buf, size_t len,
 		    u8 channel, u16 duration_ms);
+int wmi_rbufcap_cfg(struct wil6210_priv *wil, bool enable, u16 threshold);
 
 int reverse_memcmp(const void *cs, const void *ct, size_t count);
 
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 0a0818f..298c918 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -484,6 +484,8 @@ static const char *cmdid2name(u16 cmdid)
 		return "WMI_FT_REASSOC_CMD";
 	case WMI_UPDATE_FT_IES_CMDID:
 		return "WMI_UPDATE_FT_IES_CMD";
+	case WMI_RBUFCAP_CFG_CMDID:
+		return "WMI_RBUFCAP_CFG_CMD";
 	default:
 		return "Untracked CMD";
 	}
@@ -628,6 +630,8 @@ static const char *eventid2name(u16 eventid)
 		return "WMI_FT_AUTH_STATUS_EVENT";
 	case WMI_FT_REASSOC_STATUS_EVENTID:
 		return "WMI_FT_REASSOC_STATUS_EVENT";
+	case WMI_RBUFCAP_CFG_EVENTID:
+		return "WMI_RBUFCAP_CFG_EVENT";
 	default:
 		return "Untracked EVENT";
 	}
@@ -2124,6 +2128,37 @@ int wmi_led_cfg(struct wil6210_priv *wil, bool enable)
 	return rc;
 }
 
+int wmi_rbufcap_cfg(struct wil6210_priv *wil, bool enable, u16 threshold)
+{
+	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
+	int rc;
+
+	struct wmi_rbufcap_cfg_cmd cmd = {
+		.enable = enable,
+		.rx_desc_threshold = cpu_to_le16(threshold),
+	};
+	struct {
+		struct wmi_cmd_hdr wmi;
+		struct wmi_rbufcap_cfg_event evt;
+	} __packed reply = {
+		.evt = {.status = WMI_FW_STATUS_FAILURE},
+	};
+
+	rc = wmi_call(wil, WMI_RBUFCAP_CFG_CMDID, vif->mid, &cmd, sizeof(cmd),
+		      WMI_RBUFCAP_CFG_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
+	if (rc)
+		return rc;
+
+	if (reply.evt.status != WMI_FW_STATUS_SUCCESS) {
+		wil_err(wil, "RBUFCAP_CFG failed. status %d\n",
+			reply.evt.status);
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
 int wmi_pcp_start(struct wil6210_vif *vif,
 		  int bi, u8 wmi_nettype, u8 chan, u8 hidden_ssid, u8 is_go)
 {
@@ -2715,7 +2750,7 @@ int wmi_addba_rx_resp(struct wil6210_priv *wil,
 		.dialog_token = token,
 		.status_code = cpu_to_le16(status),
 		/* bit 0: A-MSDU supported
-		 * bit 1: policy (should be 0 for us)
+		 * bit 1: policy (controlled by FW)
 		 * bits 2..5: TID
 		 * bits 6..15: buffer size
 		 */
@@ -2769,7 +2804,7 @@ int wmi_addba_rx_resp_edma(struct wil6210_priv *wil, u8 mid, u8 cid, u8 tid,
 		.dialog_token = token,
 		.status_code = cpu_to_le16(status),
 		/* bit 0: A-MSDU supported
-		 * bit 1: policy (should be 0 for us)
+		 * bit 1: policy (controlled by FW)
 		 * bits 2..5: TID
 		 * bits 6..15: buffer size
 		 */
-- 
1.9.1

