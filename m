Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664A715FB70
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 01:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBOAZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 19:25:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:44412 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbgBOAZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 19:25:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581726336; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GeNFRdE5zdEWx9/AUgBUgmN+KnBIl1K6y0VLuyCAg0E=; b=U37zZxf+mM209lMvEIIrKEfbtPJhWUAs056pjVRakTK8yS3WC3rx4iwzBbmE0w5RAE3Dd9VO
 1+omajk37/m3kZ/GjHOHrTV+TfRm9NMSnRmYcsIq+GLQKAC9rFccOqkpOeFEnV169yOgyU2S
 lyY4esRRL4BRIOSETvJ4bD3QeCg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e473a7a.7f0c0f1bce30-smtp-out-n01;
 Sat, 15 Feb 2020 00:25:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8D0EC4479F; Sat, 15 Feb 2020 00:25:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A1B9C43383;
        Sat, 15 Feb 2020 00:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A1B9C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 1/2] ath11k: add thermal cooling device support
Date:   Sat, 15 Feb 2020 05:55:21 +0530
Message-Id: <1581726322-29658-1-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thermal cooling device support is added to control the temperature by
throttling the data transmission for the given duration. Throttling is
done by suspending all data tx queues by given percentage of time. The
thermal device allows user to configure duty cycle.

Throttling can be disabled by setting the duty cycle to 0. The cooling
device can be found under /sys/class/thermal/cooling_deviceX/.
Corresponding soft link to this device can be found under phy folder.

/sys/class/ieee80211/phy*/device/cooling_device.

To set duty cycle as 40%,

echo 40 >/sys/class/ieee80211/phy*/device/cooling_device/cur_state

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v2:
 - fix warnings and rebase

 drivers/net/wireless/ath/ath11k/Makefile  |   1 +
 drivers/net/wireless/ath/ath11k/core.c    |  12 ++-
 drivers/net/wireless/ath/ath11k/core.h    |   2 +
 drivers/net/wireless/ath/ath11k/thermal.c | 145 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/thermal.h |  40 +++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     |  64 +++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h     |  40 +++++++++
 7 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath11k/thermal.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 2761d07d938e..fe7736e53583 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -20,6 +20,7 @@ ath11k-y += core.o \
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
+ath11k-$(CONFIG_THERMAL) += thermal.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 6a30601a12e8..abfd451dead2 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -392,11 +392,19 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_mac_unregister;
 	}
 
+	ret = ath11k_thermal_register(ab);
+	if (ret) {
+		ath11k_err(ab, "could not register thermal device: %d\n",
+			   ret);
+		goto err_dp_pdev_free;
+	}
+
 	return 0;
 
+err_dp_pdev_free:
+	ath11k_dp_pdev_free(ab);
 err_mac_unregister:
 	ath11k_mac_unregister(ab);
-
 err_pdev_debug:
 	ath11k_debug_pdev_destroy(ab);
 
@@ -405,6 +413,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
+	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
 	ath11k_ahb_ext_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
@@ -569,6 +578,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	int ret;
 
 	mutex_lock(&ab->core_lock);
+	ath11k_thermal_unregister(ab);
 	ath11k_ahb_ext_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_ahb_stop(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 01cb64cfe0d0..5c767d87c174 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -20,6 +20,7 @@
 #include "hw.h"
 #include "hal_rx.h"
 #include "reg.h"
+#include "thermal.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -526,6 +527,7 @@ struct ath11k {
 	struct ath11k_debug debug;
 #endif
 	bool dfs_block_radar_events;
+	struct ath11k_thermal thermal;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
new file mode 100644
index 000000000000..6c2d96be34cb
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+#include "core.h"
+#include "debug.h"
+
+static int
+ath11k_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	*state = ATH11K_THERMAL_THROTTLE_MAX;
+
+	return 0;
+}
+
+static int
+ath11k_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	struct ath11k *ar = cdev->devdata;
+
+	mutex_lock(&ar->conf_mutex);
+	*state = ar->thermal.throttle_state;
+	mutex_unlock(&ar->conf_mutex);
+
+	return 0;
+}
+
+static int
+ath11k_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long throttle_state)
+{
+	struct ath11k *ar = cdev->devdata;
+	int ret;
+
+	if (throttle_state > ATH11K_THERMAL_THROTTLE_MAX) {
+		ath11k_warn(ar->ab, "throttle state %ld is exceeding the limit %d\n",
+			    throttle_state, ATH11K_THERMAL_THROTTLE_MAX);
+		return -EINVAL;
+	}
+	mutex_lock(&ar->conf_mutex);
+	ret = ath11k_thermal_set_throttling(ar, throttle_state);
+	if (ret == 0)
+		ar->thermal.throttle_state = throttle_state;
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static struct thermal_cooling_device_ops ath11k_thermal_ops = {
+	.get_max_state = ath11k_thermal_get_max_throttle_state,
+	.get_cur_state = ath11k_thermal_get_cur_throttle_state,
+	.set_cur_state = ath11k_thermal_set_cur_throttle_state,
+};
+
+int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
+{
+	struct ath11k_base *sc = ar->ab;
+	struct thermal_mitigation_params param;
+	int ret = 0;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON)
+		return 0;
+
+	memset(&param, 0, sizeof(param));
+	param.pdev_id = ar->pdev->pdev_id;
+	param.enable = throttle_state ? 1 : 0;
+	param.dc = ATH11K_THERMAL_DEFAULT_DUTY_CYCLE;
+	param.dc_per_event = 0xFFFFFFFF;
+
+	param.levelconf[0].tmplwm = ATH11K_THERMAL_TEMP_LOW_MARK;
+	param.levelconf[0].tmphwm = ATH11K_THERMAL_TEMP_HIGH_MARK;
+	param.levelconf[0].dcoffpercent = throttle_state;
+	param.levelconf[0].priority = 0; /* disable all data tx queues */
+
+	ret = ath11k_wmi_send_thermal_mitigation_param_cmd(ar, &param);
+	if (ret) {
+		ath11k_warn(sc, "failed to send thermal mitigation duty cycle %u ret %d\n",
+			    throttle_state, ret);
+	}
+
+	return ret;
+}
+
+int ath11k_thermal_register(struct ath11k_base *sc)
+{
+	struct thermal_cooling_device *cdev;
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	int i, ret;
+
+	for (i = 0; i < sc->num_radios; i++) {
+		pdev = &sc->pdevs[i];
+		ar = pdev->ar;
+		if (!ar)
+			continue;
+
+		cdev = thermal_cooling_device_register("ath11k_thermal", ar,
+						       &ath11k_thermal_ops);
+
+		if (IS_ERR(cdev)) {
+			ath11k_err(sc, "failed to setup thermal device result: %ld\n",
+				   PTR_ERR(cdev));
+			return -EINVAL;
+		}
+
+		ret = sysfs_create_link(&ar->hw->wiphy->dev.kobj, &cdev->device.kobj,
+					"cooling_device");
+		if (ret) {
+			ath11k_err(sc, "failed to create cooling device symlink\n");
+			goto err_thermal_destroy;
+		}
+
+		ar->thermal.cdev = cdev;
+	}
+
+	return 0;
+
+err_thermal_destroy:
+	ath11k_thermal_unregister(sc);
+	return ret;
+}
+
+void ath11k_thermal_unregister(struct ath11k_base *sc)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	int i;
+
+	for (i = 0; i < sc->num_radios; i++) {
+		pdev = &sc->pdevs[i];
+		ar = pdev->ar;
+		if (!ar)
+			continue;
+
+		sysfs_remove_link(&ar->hw->wiphy->dev.kobj, "cooling_device");
+		thermal_cooling_device_unregister(ar->thermal.cdev);
+	}
+}
diff --git a/drivers/net/wireless/ath/ath11k/thermal.h b/drivers/net/wireless/ath/ath11k/thermal.h
new file mode 100644
index 000000000000..95a34803b60e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/thermal.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ATH11K_THERMAL_
+#define _ATH11K_THERMAL_
+
+#define ATH11K_THERMAL_TEMP_LOW_MARK -100
+#define ATH11K_THERMAL_TEMP_HIGH_MARK 150
+#define ATH11K_THERMAL_THROTTLE_MAX     100
+#define ATH11K_THERMAL_DEFAULT_DUTY_CYCLE 100
+
+struct ath11k_thermal {
+	struct thermal_cooling_device *cdev;
+
+	/* protected by conf_mutex */
+	u32 throttle_state;
+};
+
+#if IS_REACHABLE(CONFIG_THERMAL)
+int ath11k_thermal_register(struct ath11k_base *sc);
+void ath11k_thermal_unregister(struct ath11k_base *sc);
+int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state);
+#else
+static inline int ath11k_thermal_register(struct ath11k_base *sc)
+{
+	return 0;
+}
+
+static inline void ath11k_thermal_unregister(struct ath11k *ar)
+{
+}
+
+static inline int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
+{
+}
+
+#endif
+#endif /* _ATH11K_THERMAL_ */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9cbe038da1f6..31b625a4192f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2442,6 +2442,70 @@ int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable)
 	return ret;
 }
 
+int
+ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
+					     struct thermal_mitigation_params *param)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_therm_throt_config_request_cmd *cmd;
+	struct wmi_therm_throt_level_config_info *lvl_conf;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int i, ret, len;
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE +
+	      THERMAL_LEVELS * sizeof(struct wmi_therm_throt_level_config_info);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_therm_throt_config_request_cmd *)skb->data;
+
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_THERM_THROT_CONFIG_REQUEST) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->enable = param->enable;
+	cmd->dc = param->dc;
+	cmd->dc_per_event = param->dc_per_event;
+	cmd->therm_throt_levels = THERMAL_LEVELS;
+
+	tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN,
+				 (THERMAL_LEVELS *
+				  sizeof(struct wmi_therm_throt_level_config_info)));
+
+	lvl_conf = (struct wmi_therm_throt_level_config_info *)(skb->data +
+								sizeof(*cmd) +
+								TLV_HDR_SIZE);
+	for (i = 0; i < THERMAL_LEVELS; i++) {
+		lvl_conf->tlv_header =
+			FIELD_PREP(WMI_TLV_TAG, WMI_TAG_THERM_THROT_LEVEL_CONFIG_INFO) |
+			FIELD_PREP(WMI_TLV_LEN, sizeof(*lvl_conf) - TLV_HDR_SIZE);
+
+		lvl_conf->temp_lwm = param->levelconf[i].tmplwm;
+		lvl_conf->temp_hwm = param->levelconf[i].tmphwm;
+		lvl_conf->dc_off_percent = param->levelconf[i].dcoffpercent;
+		lvl_conf->prio = param->levelconf[i].priority;
+		lvl_conf++;
+	}
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_THERM_THROT_SET_CONF_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send THERM_THROT_SET_CONF cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI vdev set thermal throt pdev_id %d enable %d dc %d dc_per_event %x levels %d\n",
+		   ar->pdev->pdev_id, param->enable, param->dc,
+		   param->dc_per_event, THERMAL_LEVELS);
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_pktlog_enable(struct ath11k *ar, u32 pktlog_filter)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 1fde15c762ad..c8aa4cbb9a49 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -442,6 +442,10 @@ enum wmi_tlv_cmd_id {
 	WMI_DBGLOG_TIME_STAMP_SYNC_CMDID,
 	WMI_SET_MULTIPLE_MCAST_FILTER_CMDID,
 	WMI_READ_DATA_FROM_FLASH_CMDID,
+	WMI_THERM_THROT_SET_CONF_CMDID,
+	WMI_RUNTIME_DPD_RECAL_CMDID,
+	WMI_GET_TPC_POWER_CMDID,
+	WMI_IDLE_TRIGGER_MONITOR_CMDID,
 	WMI_GPIO_CONFIG_CMDID = WMI_TLV_CMD(WMI_GRP_GPIO),
 	WMI_GPIO_OUTPUT_CMDID,
 	WMI_TXBF_CMDID,
@@ -3605,6 +3609,39 @@ struct wmi_init_country_cmd {
 	} cc_info;
 } __packed;
 
+#define THERMAL_LEVELS  1
+struct tt_level_config {
+	u32 tmplwm;
+	u32 tmphwm;
+	u32 dcoffpercent;
+	u32 priority;
+};
+
+struct thermal_mitigation_params {
+	u32 pdev_id;
+	u32 enable;
+	u32 dc;
+	u32 dc_per_event;
+	struct tt_level_config levelconf[THERMAL_LEVELS];
+};
+
+struct wmi_therm_throt_config_request_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 enable;
+	u32 dc;
+	u32 dc_per_event;
+	u32 therm_throt_levels;
+} __packed;
+
+struct wmi_therm_throt_level_config_info {
+	u32 tlv_header;
+	u32 temp_lwm;
+	u32 temp_hwm;
+	u32 dc_off_percent;
+	u32 prio;
+} __packed;
+
 struct wmi_pdev_pktlog_filter_info {
 	u32 tlv_header;
 	struct wmi_mac_addr peer_macaddr;
@@ -4740,6 +4777,9 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 int
 ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 				 struct wmi_init_country_params init_cc_param);
+int
+ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
+					     struct thermal_mitigation_params *param);
 int ath11k_wmi_pdev_pktlog_enable(struct ath11k *ar, u32 pktlog_filter);
 int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar);
 int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable);
-- 
1.9.1
