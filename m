Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1915FB71
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 01:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBOAZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 19:25:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43480 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgBOAZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 19:25:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581726337; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=fCfRjqnlT/ywkObKvv6BXlLOrfvL8vhUYOq0gX1ho0w=; b=PARnqRgjeBSUsJjCYzF7+57mCDyXaQOq997BEnXCUFhzTtLLLcmgDRWQegOfOr5LPbTXMAV/
 t7tRfRAru4B5nwGzIudNp54gRenyrjfiRkdAsPzseVb7RpsPz7D+YpfpV81th9OrcxRWGW3D
 auXYHmCUJRviSqpAp3pXAkXdVCs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e473a7a.7f8aa217f650-smtp-out-n02;
 Sat, 15 Feb 2020 00:25:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1964C4479D; Sat, 15 Feb 2020 00:25:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DD7DC433A2;
        Sat, 15 Feb 2020 00:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DD7DC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 2/2] ath11k: add thermal sensor device support
Date:   Sat, 15 Feb 2020 05:55:22 +0530
Message-Id: <1581726322-29658-2-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581726322-29658-1-git-send-email-pradeepc@codeaurora.org>
References: <1581726322-29658-1-git-send-email-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Temperature sensor generates electrical analog voltage from temperature
of each chain. The analog voltage is converted to digital value through
ADC. For reading temperature values fom user space, hw monitoring device
is used.

Whenever the user requests for current temperature, the driver sends WMI
command and wait for response. For reading temperature,

cat /sys/class/ieee80211/phy*/device/hwmon/hwmon2/temp1_input

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v2:
 - fix warnings and rebase

 drivers/net/wireless/ath/ath11k/core.c    |  1 +
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +
 drivers/net/wireless/ath/ath11k/thermal.c | 79 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/thermal.h | 13 +++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 80 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h     | 13 +++++
 6 files changed, 188 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index abfd451dead2..bf5657d2ae18 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -655,6 +655,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->install_key_done);
 		complete(&ar->vdev_setup_done);
 		complete(&ar->bss_survey_done);
+		complete(&ar->thermal.wmi_sync);
 
 		wake_up(&ar->dp.tx_empty_waitq);
 		idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f5e171c26bd5..e28f5a348be6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5905,6 +5905,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->bss_survey_done);
 		init_completion(&ar->scan.started);
 		init_completion(&ar->scan.completed);
+		init_completion(&ar->thermal.wmi_sync);
+
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
 
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index 6c2d96be34cb..259dddbda2c7 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -6,6 +6,8 @@
 #include <linux/device.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include "core.h"
 #include "debug.h"
 
@@ -57,6 +59,70 @@
 	.set_cur_state = ath11k_thermal_set_cur_throttle_state,
 };
 
+static ssize_t ath11k_thermal_show_temp(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct ath11k *ar = dev_get_drvdata(dev);
+	int ret, temperature;
+	unsigned long time_left;
+
+	mutex_lock(&ar->conf_mutex);
+
+	/* Can't get temperature when the card is off */
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	reinit_completion(&ar->thermal.wmi_sync);
+	ret = ath11k_wmi_send_pdev_temperature_cmd(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to read temperature %d\n", ret);
+		goto out;
+	}
+
+	if (test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->thermal.wmi_sync,
+						ATH11K_THERMAL_SYNC_TIMEOUT_HZ);
+	if (!time_left) {
+		ath11k_warn(ar->ab, "failed to synchronize thermal read\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	temperature = ar->thermal.temperature;
+	spin_unlock_bh(&ar->data_lock);
+
+	/* display in millidegree celcius */
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", temperature * 1000);
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+void ath11k_thermal_event_temperature(struct ath11k *ar, int temperature)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->thermal.temperature = temperature;
+	spin_unlock_bh(&ar->data_lock);
+	complete(&ar->thermal.wmi_sync);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, ath11k_thermal_show_temp,
+			  NULL, 0);
+
+static struct attribute *ath11k_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ath11k_hwmon);
+
 int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
 {
 	struct ath11k_base *sc = ar->ab;
@@ -91,6 +157,7 @@ int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
 int ath11k_thermal_register(struct ath11k_base *sc)
 {
 	struct thermal_cooling_device *cdev;
+	struct device *hwmon_dev;
 	struct ath11k *ar;
 	struct ath11k_pdev *pdev;
 	int i, ret;
@@ -118,6 +185,18 @@ int ath11k_thermal_register(struct ath11k_base *sc)
 		}
 
 		ar->thermal.cdev = cdev;
+		if (!IS_REACHABLE(CONFIG_HWMON))
+			return 0;
+
+		hwmon_dev = devm_hwmon_device_register_with_groups(&ar->hw->wiphy->dev,
+								   "ath11k_hwmon", ar,
+								   ath11k_hwmon_groups);
+		if (IS_ERR(hwmon_dev)) {
+			ath11k_err(ar->ab, "failed to register hwmon device: %ld\n",
+				   PTR_ERR(hwmon_dev));
+			ret = -EINVAL;
+			goto err_thermal_destroy;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/thermal.h b/drivers/net/wireless/ath/ath11k/thermal.h
index 95a34803b60e..459b8d49c184 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.h
+++ b/drivers/net/wireless/ath/ath11k/thermal.h
@@ -10,18 +10,26 @@
 #define ATH11K_THERMAL_TEMP_HIGH_MARK 150
 #define ATH11K_THERMAL_THROTTLE_MAX     100
 #define ATH11K_THERMAL_DEFAULT_DUTY_CYCLE 100
+#define ATH11K_HWMON_NAME_LEN           15
+#define ATH11K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
 
 struct ath11k_thermal {
 	struct thermal_cooling_device *cdev;
+	struct completion wmi_sync;
 
 	/* protected by conf_mutex */
 	u32 throttle_state;
+	/* temperature value in Celcius degree
+	 * protected by data_lock
+	 */
+	int temperature;
 };
 
 #if IS_REACHABLE(CONFIG_THERMAL)
 int ath11k_thermal_register(struct ath11k_base *sc);
 void ath11k_thermal_unregister(struct ath11k_base *sc);
 int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state);
+void ath11k_thermal_event_temperature(struct ath11k *ar, int temperature);
 #else
 static inline int ath11k_thermal_register(struct ath11k_base *sc)
 {
@@ -36,5 +44,10 @@ static inline int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_
 {
 }
 
+static inline void ath11k_thermal_event_temperature(struct ath11k *ar,
+						    int temperature)
+{
+}
+
 #endif
 #endif /* _ATH11K_THERMAL_ */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 31b625a4192f..5b35d06a0d81 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1471,6 +1471,34 @@ int ath11k_wmi_send_stats_request_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_send_pdev_temperature_cmd(struct ath11k *ar)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_get_pdev_temperature_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_get_pdev_temperature_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_GET_TEMPERATURE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->pdev_id = ar->pdev->pdev_id;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_GET_TEMPERATURE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_PDEV_GET_TEMPERATURE cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI pdev get temperature for pdev_id %d\n", ar->pdev->pdev_id);
+
+	return ret;
+}
+
 int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op)
 {
@@ -4232,6 +4260,31 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 	return 0;
 }
 
+static int
+ath11k_pull_pdev_temp_ev(struct ath11k_base *ab, u8 *evt_buf,
+			 u32 len, const struct wmi_pdev_temperature_event *ev)
+{
+	const void **tb;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, evt_buf, len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch pdev temp ev");
+		kfree(tb);
+		return -EPROTO;
+	}
+
+	kfree(tb);
+	return 0;
+}
+
 size_t ath11k_wmi_fw_stats_num_vdevs(struct list_head *head)
 {
 	struct ath11k_fw_stats_vdev *i;
@@ -5578,6 +5631,30 @@ static void ath11k_pdev_ctl_failsafe_check_event(struct ath11k_base *ab,
 	kfree(tb);
 }
 
+static void
+ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
+				  struct sk_buff *skb)
+{
+	struct ath11k *ar;
+	struct wmi_pdev_temperature_event ev = {0};
+
+	if (ath11k_pull_pdev_temp_ev(ab, skb->data, skb->len, &ev) != 0) {
+		ath11k_warn(ab, "failed to extract pdev temperature event");
+		return;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "pdev temperature ev temp %d pdev_id %d\n", ev.temp, ev.pdev_id);
+
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev.pdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev.pdev_id);
+		return;
+	}
+
+	ath11k_thermal_event_temperature(ar, ev.temp);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -5655,6 +5732,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_CSA_SWITCH_COUNT_STATUS_EVENTID:
 		ath11k_wmi_pdev_csa_switch_count_status_event(ab, skb);
 		break;
+	case WMI_PDEV_TEMPERATURE_EVENTID:
+		ath11k_wmi_pdev_temperature_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index c8aa4cbb9a49..742fcd6e37a3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3304,6 +3304,12 @@ struct wmi_request_stats_cmd {
 	u32 pdev_id;
 } __packed;
 
+struct wmi_get_pdev_temperature_cmd {
+	u32 tlv_header;
+	u32 param;
+	u32 pdev_id;
+} __packed;
+
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
 struct wmi_bcn_tmpl_cmd {
@@ -4132,6 +4138,12 @@ struct wmi_pdev_radar_ev {
 	s32 sidx;
 } __packed;
 
+struct wmi_pdev_temperature_event {
+	/* temperature value in Celcius degree */
+	s32 temp;
+	u32 pdev_id;
+} __packed;
+
 #define WMI_RX_STATUS_OK			0x00
 #define WMI_RX_STATUS_ERR_CRC			0x01
 #define WMI_RX_STATUS_ERR_DECRYPT		0x08
@@ -4763,6 +4775,7 @@ int ath11k_wmi_pdev_bss_chan_info_request(struct ath11k *ar,
 					  enum wmi_bss_chan_info_req_type type);
 int ath11k_wmi_send_stats_request_cmd(struct ath11k *ar,
 				      struct stats_request_params *param);
+int ath11k_wmi_send_pdev_temperature_cmd(struct ath11k *ar);
 int ath11k_wmi_send_peer_flush_tids_cmd(struct ath11k *ar,
 					u8 peer_addr[ETH_ALEN],
 					struct peer_flush_params *param);
-- 
1.9.1
