Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF84473A9
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFPHeT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:34:19 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36718 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfFPHeT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:34:19 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499839"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Tzahi Sabo <stzahi@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, Maya Erez <merez@codeaurora.org>
Subject: [PATCH 09/11] wil6210: add support for reading multiple RFs temperature via debugfs
Date:   Sun, 16 Jun 2019 10:26:05 +0300
Message-Id: <1560669967-23706-10-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzahi Sabo <stzahi@codeaurora.org>

Base-band chips support multi RFs chips. Add support for reading
multiple RFs temperature via debugfs.

Signed-off-by: Tzahi Sabo <stzahi@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 42 ++++++++++++++++++++------
 drivers/net/wireless/ath/wil6210/wil6210.h |  3 ++
 drivers/net/wireless/ath/wil6210/wmi.c     | 42 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/wmi.h     | 47 +++++++++++++++++++++++++-----
 4 files changed, 117 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 8eb6d49..bbe274c 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1372,7 +1372,7 @@ static void print_temp(struct seq_file *s, const char *prefix, s32 t)
 {
 	switch (t) {
 	case 0:
-	case ~(u32)0:
+	case WMI_INVALID_TEMPERATURE:
 		seq_printf(s, "%s N/A\n", prefix);
 	break;
 	default:
@@ -1385,17 +1385,41 @@ static void print_temp(struct seq_file *s, const char *prefix, s32 t)
 static int temp_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
-	s32 t_m, t_r;
-	int rc = wmi_get_temperature(wil, &t_m, &t_r);
+	int rc, i;
 
-	if (rc) {
-		seq_puts(s, "Failed\n");
-		return 0;
-	}
+	if (test_bit(WMI_FW_CAPABILITY_TEMPERATURE_ALL_RF,
+		     wil->fw_capabilities)) {
+		struct wmi_temp_sense_all_done_event sense_all_evt;
 
-	print_temp(s, "T_mac   =", t_m);
-	print_temp(s, "T_radio =", t_r);
+		wil_dbg_misc(wil,
+			     "WMI_FW_CAPABILITY_TEMPERATURE_ALL_RF is supported");
+		rc = wmi_get_all_temperatures(wil, &sense_all_evt);
+		if (rc) {
+			seq_puts(s, "Failed\n");
+			return 0;
+		}
+		print_temp(s, "T_mac   =",
+			   le32_to_cpu(sense_all_evt.baseband_t1000));
+		seq_printf(s, "Connected RFs [0x%08x]\n",
+			   sense_all_evt.rf_bitmap);
+		for (i = 0; i < WMI_MAX_XIF_PORTS_NUM; i++) {
+			seq_printf(s, "RF[%d]   = ", i);
+			print_temp(s, "",
+				   le32_to_cpu(sense_all_evt.rf_t1000[i]));
+		}
+	} else {
+		s32 t_m, t_r;
 
+		wil_dbg_misc(wil,
+			     "WMI_FW_CAPABILITY_TEMPERATURE_ALL_RF is not supported");
+		rc = wmi_get_temperature(wil, &t_m, &t_r);
+		if (rc) {
+			seq_puts(s, "Failed\n");
+			return 0;
+		}
+		print_temp(s, "T_mac   =", t_m);
+		print_temp(s, "T_radio =", t_r);
+	}
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(temp);
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index afbc524..038329b 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1252,6 +1252,9 @@ int wmi_add_cipher_key(struct wil6210_vif *vif, u8 key_index,
 int wmi_update_ft_ies(struct wil6210_vif *vif, u16 ie_len, const void *ie);
 int wmi_rxon(struct wil6210_priv *wil, bool on);
 int wmi_get_temperature(struct wil6210_priv *wil, u32 *t_m, u32 *t_r);
+int wmi_get_all_temperatures(struct wil6210_priv *wil,
+			     struct wmi_temp_sense_all_done_event
+			     *sense_all_evt);
 int wmi_disconnect_sta(struct wil6210_vif *vif, const u8 *mac, u16 reason,
 		       bool del_sta);
 int wmi_addba(struct wil6210_priv *wil, u8 mid,
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index cacafab..5d7eb52 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -486,6 +486,8 @@ static const char *cmdid2name(u16 cmdid)
 		return "WMI_UPDATE_FT_IES_CMD";
 	case WMI_RBUFCAP_CFG_CMDID:
 		return "WMI_RBUFCAP_CFG_CMD";
+	case WMI_TEMP_SENSE_ALL_CMDID:
+		return "WMI_TEMP_SENSE_ALL_CMDID";
 	default:
 		return "Untracked CMD";
 	}
@@ -632,6 +634,8 @@ static const char *eventid2name(u16 eventid)
 		return "WMI_FT_REASSOC_STATUS_EVENT";
 	case WMI_RBUFCAP_CFG_EVENTID:
 		return "WMI_RBUFCAP_CFG_EVENT";
+	case WMI_TEMP_SENSE_ALL_DONE_EVENTID:
+		return "WMI_TEMP_SENSE_ALL_DONE_EVENTID";
 	default:
 		return "Untracked EVENT";
 	}
@@ -2648,6 +2652,44 @@ int wmi_get_temperature(struct wil6210_priv *wil, u32 *t_bb, u32 *t_rf)
 	return 0;
 }
 
+int wmi_get_all_temperatures(struct wil6210_priv *wil,
+			     struct wmi_temp_sense_all_done_event
+			     *sense_all_evt)
+{
+	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
+	int rc;
+	struct wmi_temp_sense_all_cmd cmd = {
+		.measure_baseband_en = true,
+		.measure_rf_en = true,
+		.measure_mode = TEMPERATURE_MEASURE_NOW,
+	};
+	struct {
+		struct wmi_cmd_hdr wmi;
+		struct wmi_temp_sense_all_done_event evt;
+	} __packed reply;
+
+	if (!sense_all_evt) {
+		wil_err(wil, "Invalid sense_all_evt value\n");
+		return -EINVAL;
+	}
+
+	memset(&reply, 0, sizeof(reply));
+	reply.evt.status = WMI_FW_STATUS_FAILURE;
+	rc = wmi_call(wil, WMI_TEMP_SENSE_ALL_CMDID, vif->mid, &cmd,
+		      sizeof(cmd), WMI_TEMP_SENSE_ALL_DONE_EVENTID,
+		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
+	if (rc)
+		return rc;
+
+	if (reply.evt.status == WMI_FW_STATUS_FAILURE) {
+		wil_err(wil, "Failed geting TEMP_SENSE_ALL\n");
+		return -EINVAL;
+	}
+
+	memcpy(sense_all_evt, &reply.evt, sizeof(reply.evt));
+	return 0;
+}
+
 int wmi_disconnect_sta(struct wil6210_vif *vif, const u8 *mac, u16 reason,
 		       bool del_sta)
 {
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index da46fc8..3e37229 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -35,6 +35,7 @@
 #define WMI_PROX_RANGE_NUM		(3)
 #define WMI_MAX_LOSS_DMG_BEACONS	(20)
 #define MAX_NUM_OF_SECTORS		(128)
+#define WMI_INVALID_TEMPERATURE		(0xFFFFFFFF)
 #define WMI_SCHED_MAX_ALLOCS_PER_CMD	(4)
 #define WMI_RF_DTYPE_LENGTH		(3)
 #define WMI_RF_ETYPE_LENGTH		(3)
@@ -64,6 +65,7 @@
 #define WMI_QOS_MAX_WEIGHT		50
 #define WMI_QOS_SET_VIF_PRIORITY	(0xFF)
 #define WMI_QOS_DEFAULT_PRIORITY	(WMI_QOS_NUM_OF_PRIORITY)
+#define WMI_MAX_XIF_PORTS_NUM		(8)
 
 /* Mailbox interface
  * used for commands and events
@@ -105,6 +107,7 @@ enum wmi_fw_capability {
 	WMI_FW_CAPABILITY_TX_REQ_EXT			= 25,
 	WMI_FW_CAPABILITY_CHANNEL_4			= 26,
 	WMI_FW_CAPABILITY_IPA				= 27,
+	WMI_FW_CAPABILITY_TEMPERATURE_ALL_RF		= 30,
 	WMI_FW_CAPABILITY_MAX,
 };
 
@@ -296,6 +299,7 @@ enum wmi_command_id {
 	WMI_SET_VRING_PRIORITY_WEIGHT_CMDID		= 0xA10,
 	WMI_SET_VRING_PRIORITY_CMDID			= 0xA11,
 	WMI_RBUFCAP_CFG_CMDID				= 0xA12,
+	WMI_TEMP_SENSE_ALL_CMDID			= 0xA13,
 	WMI_SET_MAC_ADDRESS_CMDID			= 0xF003,
 	WMI_ABORT_SCAN_CMDID				= 0xF007,
 	WMI_SET_PROMISCUOUS_MODE_CMDID			= 0xF041,
@@ -1411,12 +1415,7 @@ struct wmi_rf_xpm_write_cmd {
 	u8 data_bytes[0];
 } __packed;
 
-/* WMI_TEMP_SENSE_CMDID
- *
- * Measure MAC and radio temperatures
- *
- * Possible modes for temperature measurement
- */
+/* Possible modes for temperature measurement */
 enum wmi_temperature_measure_mode {
 	TEMPERATURE_USE_OLD_VALUE	= 0x01,
 	TEMPERATURE_MEASURE_NOW		= 0x02,
@@ -1942,6 +1941,14 @@ struct wmi_set_ap_slot_size_cmd {
 	__le32 slot_size;
 } __packed;
 
+/* WMI_TEMP_SENSE_ALL_CMDID */
+struct wmi_temp_sense_all_cmd {
+	u8 measure_baseband_en;
+	u8 measure_rf_en;
+	u8 measure_mode;
+	u8 reserved;
+} __packed;
+
 /* WMI Events
  * List of Events (target to host)
  */
@@ -2101,6 +2108,7 @@ enum wmi_event_id {
 	WMI_SET_VRING_PRIORITY_WEIGHT_EVENTID		= 0x1A10,
 	WMI_SET_VRING_PRIORITY_EVENTID			= 0x1A11,
 	WMI_RBUFCAP_CFG_EVENTID				= 0x1A12,
+	WMI_TEMP_SENSE_ALL_DONE_EVENTID			= 0x1A13,
 	WMI_SET_CHANNEL_EVENTID				= 0x9000,
 	WMI_ASSOC_REQ_EVENTID				= 0x9001,
 	WMI_EAPOL_RX_EVENTID				= 0x9002,
@@ -2784,11 +2792,13 @@ struct wmi_fixed_scheduling_ul_config_event {
  */
 struct wmi_temp_sense_done_event {
 	/* Temperature times 1000 (actual temperature will be achieved by
-	 * dividing the value by 1000)
+	 * dividing the value by 1000). When temperature cannot be read from
+	 * device return WMI_INVALID_TEMPERATURE
 	 */
 	__le32 baseband_t1000;
 	/* Temperature times 1000 (actual temperature will be achieved by
-	 * dividing the value by 1000)
+	 * dividing the value by 1000). When temperature cannot be read from
+	 * device return WMI_INVALID_TEMPERATURE
 	 */
 	__le32 rf_t1000;
 } __packed;
@@ -4140,4 +4150,25 @@ struct wmi_rbufcap_cfg_event {
 	u8 reserved[3];
 } __packed;
 
+/* WMI_TEMP_SENSE_ALL_DONE_EVENTID
+ * Measure MAC and all radio temperatures
+ */
+struct wmi_temp_sense_all_done_event {
+	/* enum wmi_fw_status */
+	u8 status;
+	/* Bitmap of connected RFs */
+	u8 rf_bitmap;
+	u8 reserved[2];
+	/* Temperature times 1000 (actual temperature will be achieved by
+	 * dividing the value by 1000). When temperature cannot be read from
+	 * device return WMI_INVALID_TEMPERATURE
+	 */
+	__le32 rf_t1000[WMI_MAX_XIF_PORTS_NUM];
+	/* Temperature times 1000 (actual temperature will be achieved by
+	 * dividing the value by 1000). When temperature cannot be read from
+	 * device return WMI_INVALID_TEMPERATURE
+	 */
+	__le32 baseband_t1000;
+} __packed;
+
 #endif /* __WILOCITY_WMI_H__ */
-- 
1.9.1

