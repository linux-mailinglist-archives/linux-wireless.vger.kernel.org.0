Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3F1F329F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 05:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFIDjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 23:39:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47478 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFIDjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 23:39:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591673971; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1Tj1BVZ3mVeQBdGhU597P5sNADdiXnynBRr+aRVRDNE=; b=EQQM4Dw0Wm0hMlnBrOPu86BiZEh9jjoBh3Qg39XTVDSfR7pDfeXSejJNeZS3Y9hoeIHTgRVF
 4mkZwP8WY0vZqnLEV5ttEcyZLi8ApuhliEjElsiy78PT6o2dhakoeCws5VhXorHy7LeVU1ab
 CdbZ/CELk/3yFYANQsXIL1i+md0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5edf046b60667f2e2fd09e90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 03:39:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29D89C433CB; Tue,  9 Jun 2020 03:39:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B288C433CA;
        Tue,  9 Jun 2020 03:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B288C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 2/2] ath11k: add support for spectral scan
Date:   Tue,  9 Jun 2020 09:09:05 +0530
Message-Id: <1591673945-25300-2-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591673945-25300-1-git-send-email-periyasa@codeaurora.org>
References: <1591673945-25300-1-git-send-email-periyasa@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

spectral scan control interface is exposed through debugfs eentry.
Relayfs is used to collect the spectral data. These interfaces are
similar to ath10k spectral.

spectral debugfs interfaces are below,

echo background > /sys/kernel/debug/ieee80211/phy0/ath11k/spectral_scan_ctl
echo trigger > /sys/kernel/debug/ieee80211/phy0/ath11k/spectral_scan_ctl
iw dev wlan0 scan
echo disable > /sys/kernel/debug/ieee80211/phy0/ath11k/spectral_scan_ctl
cat /sys/kernel/debug/ieee80211/phy0/ath11k/spectral_scan0 > fft_samples.dump

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig    |    9 +
 drivers/net/wireless/ath/ath11k/Makefile   |    1 +
 drivers/net/wireless/ath/ath11k/core.c     |   10 +
 drivers/net/wireless/ath/ath11k/core.h     |    5 +
 drivers/net/wireless/ath/ath11k/dbring.c   |    3 +
 drivers/net/wireless/ath/ath11k/mac.c      |    3 +
 drivers/net/wireless/ath/ath11k/spectral.c | 1023 ++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/spectral.h |   82 +++
 drivers/net/wireless/ath/ath11k/wmi.c      |  198 ++++++
 drivers/net/wireless/ath/ath11k/wmi.h      |   63 ++
 drivers/net/wireless/ath/spectral_common.h |   17 +
 11 files changed, 1414 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath11k/spectral.c
 create mode 100644 drivers/net/wireless/ath/ath11k/spectral.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 738f990..093a755 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -34,3 +34,12 @@ config ATH11K_TRACING
 	depends on ATH11K && EVENT_TRACING
 	---help---
 	  Select this to use ath11k tracing infrastructure.
+
+config ATH11K_SPECTRAL
+	bool "QCA ath11k spectral scan support"
+	depends on ATH11K_DEBUGFS
+	depends on RELAY
+	help
+	  Enable ath11k spectral scan support
+
+	  Say Y to enable access to the FFT/spectral data via debugfs.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index d17a3b4..1041863 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -22,6 +22,7 @@ ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
+ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 02501cc..905cd8b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -400,8 +400,16 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_dp_pdev_free;
 	}
 
+	ret = ath11k_spectral_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init spectral %d\n", ret);
+		goto err_thermal_unregister;
+	}
+
 	return 0;
 
+err_thermal_unregister:
+	ath11k_thermal_unregister(ab);
 err_dp_pdev_free:
 	ath11k_dp_pdev_free(ab);
 err_mac_unregister:
@@ -414,6 +422,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
+	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
 	ath11k_hif_irq_disable(ab);
@@ -582,6 +591,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
+	ath11k_spectral_deinit(ab);
 	ath11k_hif_stop(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0671c9b..ef745ef 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -22,6 +22,7 @@
 #include "reg.h"
 #include "thermal.h"
 #include "dbring.h"
+#include "spectral.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -216,6 +217,7 @@ struct ath11k_vif {
 
 	bool is_started;
 	bool is_up;
+	bool spectral_enabled;
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
@@ -538,6 +540,9 @@ struct ath11k {
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct ath11k_debug debug;
 #endif
+#ifdef CONFIG_ATH11K_SPECTRAL
+	struct ath11k_spectral spectral;
+#endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
 };
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index b962584..cf20db3 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -267,6 +267,9 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	}
 
 	switch (ev->fixed.module_id) {
+	case WMI_DIRECT_BUF_SPECTRAL:
+		ring = ath11k_spectral_get_dbring(ar);
+		break;
 	default:
 		ring = NULL;
 		ath11k_warn(ab, "Recv dma buffer release ev on unsupp module %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f..9375242 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2125,6 +2125,9 @@ static int ath11k_start_scan(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	if (ath11k_spectral_get_mode(ar) == ATH11K_SPECTRAL_BACKGROUND)
+		ath11k_spectral_reset_buffer(ar);
+
 	ret = ath11k_wmi_send_scan_start_cmd(ar, arg);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
new file mode 100644
index 0000000..1c5d65b
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -0,0 +1,1023 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/relay.h>
+#include "core.h"
+#include "debug.h"
+
+#define ATH11K_SPECTRAL_NUM_RESP_PER_EVENT	2
+#define ATH11K_SPECTRAL_EVENT_TIMEOUT_MS	1
+
+#define ATH11K_SPECTRAL_DWORD_SIZE		4
+/* HW bug, expected BIN size is 2 bytes but HW report as 4 bytes */
+#define ATH11K_SPECTRAL_BIN_SIZE		4
+#define ATH11K_SPECTRAL_ATH11K_MIN_BINS		64
+#define ATH11K_SPECTRAL_ATH11K_MIN_IB_BINS	32
+#define ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS	256
+
+#define ATH11K_SPECTRAL_SAMPLE_FFT_BIN_MASK	0xFF
+
+#define ATH11K_SPECTRAL_SCAN_COUNT_MAX		4095
+
+/* Max channel computed by sum of 2g and 5g band channels */
+#define ATH11K_SPECTRAL_TOTAL_CHANNEL		41
+#define ATH11K_SPECTRAL_SAMPLES_PER_CHANNEL	70
+#define ATH11K_SPECTRAL_PER_SAMPLE_SIZE		(sizeof(struct fft_sample_ath11k) + \
+						 ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS)
+#define ATH11K_SPECTRAL_TOTAL_SAMPLE		(ATH11K_SPECTRAL_TOTAL_CHANNEL * \
+						 ATH11K_SPECTRAL_SAMPLES_PER_CHANNEL)
+#define ATH11K_SPECTRAL_SUB_BUFF_SIZE		ATH11K_SPECTRAL_PER_SAMPLE_SIZE
+#define ATH11K_SPECTRAL_NUM_SUB_BUF		ATH11K_SPECTRAL_TOTAL_SAMPLE
+
+#define ATH11K_SPECTRAL_20MHZ			20
+#define ATH11K_SPECTRAL_40MHZ			40
+#define ATH11K_SPECTRAL_80MHZ			80
+
+#define ATH11K_SPECTRAL_SIGNATURE		0xFA
+
+#define ATH11K_SPECTRAL_TAG_RADAR_SUMMARY	0x0
+#define ATH11K_SPECTRAL_TAG_RADAR_FFT		0x1
+#define ATH11K_SPECTRAL_TAG_SCAN_SUMMARY	0x2
+#define ATH11K_SPECTRAL_TAG_SCAN_SEARCH		0x3
+
+#define SPECTRAL_TLV_HDR_LEN				GENMASK(15, 0)
+#define SPECTRAL_TLV_HDR_TAG				GENMASK(23, 16)
+#define SPECTRAL_TLV_HDR_SIGN				GENMASK(31, 24)
+
+#define SPECTRAL_SUMMARY_INFO0_AGC_TOTAL_GAIN		GENMASK(7, 0)
+#define SPECTRAL_SUMMARY_INFO0_OB_FLAG			BIT(8)
+#define SPECTRAL_SUMMARY_INFO0_GRP_IDX			GENMASK(16, 9)
+#define SPECTRAL_SUMMARY_INFO0_RECENT_RFSAT		BIT(17)
+#define SPECTRAL_SUMMARY_INFO0_INBAND_PWR_DB		GENMASK(27, 18)
+#define SPECTRAL_SUMMARY_INFO0_FALSE_SCAN		BIT(28)
+#define SPECTRAL_SUMMARY_INFO0_DETECTOR_ID		GENMASK(30, 29)
+#define SPECTRAL_SUMMARY_INFO0_PRI80			BIT(31)
+
+#define SPECTRAL_SUMMARY_INFO2_PEAK_SIGNED_IDX		GENMASK(11, 0)
+#define SPECTRAL_SUMMARY_INFO2_PEAK_MAGNITUDE		GENMASK(21, 12)
+#define SPECTRAL_SUMMARY_INFO2_NARROWBAND_MASK		GENMASK(29, 22)
+#define SPECTRAL_SUMMARY_INFO2_GAIN_CHANGE		BIT(30)
+
+struct spectral_tlv {
+	__le32 timestamp;
+	__le32 header;
+} __packed;
+
+struct spectral_summary_fft_report {
+	__le32 timestamp;
+	__le32 tlv_header;
+	__le32 info0;
+	__le32 reserve0;
+	__le32 info2;
+	__le32 reserve1;
+} __packed;
+
+struct ath11k_spectral_summary_report {
+	struct wmi_dma_buf_release_meta_data meta;
+	u32 timestamp;
+	u8 agc_total_gain;
+	u8 grp_idx;
+	u16 inb_pwr_db;
+	s16 peak_idx;
+	u16 peak_mag;
+	u8 detector_id;
+	bool out_of_band_flag;
+	bool rf_saturation;
+	bool primary80;
+	bool gain_change;
+	bool false_scan;
+};
+
+#define SPECTRAL_FFT_REPORT_INFO0_DETECTOR_ID		GENMASK(1, 0)
+#define SPECTRAL_FFT_REPORT_INFO0_FFT_NUM		GENMASK(4, 2)
+#define SPECTRAL_FFT_REPORT_INFO0_RADAR_CHECK		GENMASK(16, 5)
+#define SPECTRAL_FFT_REPORT_INFO0_PEAK_SIGNED_IDX	GENMASK(27, 17)
+#define SPECTRAL_FFT_REPORT_INFO0_CHAIN_IDX		GENMASK(30, 28)
+
+#define SPECTRAL_FFT_REPORT_INFO1_BASE_PWR_DB		GENMASK(8, 0)
+#define SPECTRAL_FFT_REPORT_INFO1_TOTAL_GAIN_DB		GENMASK(16, 9)
+
+#define SPECTRAL_FFT_REPORT_INFO2_NUM_STRONG_BINS	GENMASK(7, 0)
+#define SPECTRAL_FFT_REPORT_INFO2_PEAK_MAGNITUDE	GENMASK(17, 8)
+#define SPECTRAL_FFT_REPORT_INFO2_AVG_PWR_DB		GENMASK(24, 18)
+#define SPECTRAL_FFT_REPORT_INFO2_REL_PWR_DB		GENMASK(31, 25)
+
+struct spectral_search_fft_report {
+	__le32 timestamp;
+	__le32 tlv_header;
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 reserve0;
+	u8 bins[0];
+} __packed;
+
+struct ath11k_spectral_search_report {
+	u32 timestamp;
+	u8 detector_id;
+	u8 fft_count;
+	u16 radar_check;
+	s16 peak_idx;
+	u8 chain_idx;
+	u16 base_pwr_db;
+	u8 total_gain_db;
+	u8 strong_bin_count;
+	u16 peak_mag;
+	u8 avg_pwr_db;
+	u8 rel_pwr_db;
+};
+
+static struct dentry *create_buf_file_handler(const char *filename,
+					      struct dentry *parent,
+					      umode_t mode,
+					      struct rchan_buf *buf,
+					      int *is_global)
+{
+	struct dentry *buf_file;
+
+	buf_file = debugfs_create_file(filename, mode, parent, buf,
+				       &relay_file_operations);
+	*is_global = 1;
+	return buf_file;
+}
+
+static int remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+
+	return 0;
+}
+
+static struct rchan_callbacks rfs_scan_cb = {
+	.create_buf_file = create_buf_file_handler,
+	.remove_buf_file = remove_buf_file_handler,
+};
+
+static struct ath11k_vif *ath11k_spectral_get_vdev(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (list_empty(&ar->arvifs))
+		return NULL;
+
+	/* if there already is a vif doing spectral, return that. */
+	list_for_each_entry(arvif, &ar->arvifs, list)
+		if (arvif->spectral_enabled)
+			return arvif;
+
+	/* otherwise, return the first vif. */
+	return list_first_entry(&ar->arvifs, typeof(*arvif), list);
+}
+
+static int ath11k_spectral_scan_trigger(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	arvif = ath11k_spectral_get_vdev(ar);
+	if (!arvif)
+		return -ENODEV;
+
+	if (ar->spectral.mode == ATH11K_SPECTRAL_DISABLED)
+		return 0;
+
+	ret = ath11k_wmi_vdev_spectral_enable(ar, arvif->vdev_id,
+					      ATH11K_WMI_SPECTRAL_TRIGGER_CMD_CLEAR,
+					      ATH11K_WMI_SPECTRAL_ENABLE_CMD_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = ath11k_wmi_vdev_spectral_enable(ar, arvif->vdev_id,
+					      ATH11K_WMI_SPECTRAL_TRIGGER_CMD_TRIGGER,
+					      ATH11K_WMI_SPECTRAL_ENABLE_CMD_ENABLE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ath11k_spectral_scan_config(struct ath11k *ar,
+				       enum ath11k_spectral_mode mode)
+{
+	struct ath11k_wmi_vdev_spectral_conf_param param = { 0 };
+	struct ath11k_vif *arvif;
+	int ret, count;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	arvif = ath11k_spectral_get_vdev(ar);
+	if (!arvif)
+		return -ENODEV;
+
+	arvif->spectral_enabled = (mode != ATH11K_SPECTRAL_DISABLED);
+	ar->spectral.mode = mode;
+
+	ret = ath11k_wmi_vdev_spectral_enable(ar, arvif->vdev_id,
+					      ATH11K_WMI_SPECTRAL_TRIGGER_CMD_CLEAR,
+					      ATH11K_WMI_SPECTRAL_ENABLE_CMD_DISABLE);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to enable spectral scan: %d\n", ret);
+		return ret;
+	}
+
+	if (mode == ATH11K_SPECTRAL_DISABLED)
+		return 0;
+
+	if (mode == ATH11K_SPECTRAL_BACKGROUND)
+		count = ATH11K_WMI_SPECTRAL_COUNT_DEFAULT;
+	else
+		count = max_t(u16, 1, ar->spectral.count);
+
+	param.vdev_id = arvif->vdev_id;
+	param.scan_count = count;
+	param.scan_fft_size = ar->spectral.fft_size;
+	param.scan_period = ATH11K_WMI_SPECTRAL_PERIOD_DEFAULT;
+	param.scan_priority = ATH11K_WMI_SPECTRAL_PRIORITY_DEFAULT;
+	param.scan_gc_ena = ATH11K_WMI_SPECTRAL_GC_ENA_DEFAULT;
+	param.scan_restart_ena = ATH11K_WMI_SPECTRAL_RESTART_ENA_DEFAULT;
+	param.scan_noise_floor_ref = ATH11K_WMI_SPECTRAL_NOISE_FLOOR_REF_DEFAULT;
+	param.scan_init_delay = ATH11K_WMI_SPECTRAL_INIT_DELAY_DEFAULT;
+	param.scan_nb_tone_thr = ATH11K_WMI_SPECTRAL_NB_TONE_THR_DEFAULT;
+	param.scan_str_bin_thr = ATH11K_WMI_SPECTRAL_STR_BIN_THR_DEFAULT;
+	param.scan_wb_rpt_mode = ATH11K_WMI_SPECTRAL_WB_RPT_MODE_DEFAULT;
+	param.scan_rssi_rpt_mode = ATH11K_WMI_SPECTRAL_RSSI_RPT_MODE_DEFAULT;
+	param.scan_rssi_thr = ATH11K_WMI_SPECTRAL_RSSI_THR_DEFAULT;
+	param.scan_pwr_format = ATH11K_WMI_SPECTRAL_PWR_FORMAT_DEFAULT;
+	param.scan_rpt_mode = ATH11K_WMI_SPECTRAL_RPT_MODE_DEFAULT;
+	param.scan_bin_scale = ATH11K_WMI_SPECTRAL_BIN_SCALE_DEFAULT;
+	param.scan_dbm_adj = ATH11K_WMI_SPECTRAL_DBM_ADJ_DEFAULT;
+	param.scan_chn_mask = ATH11K_WMI_SPECTRAL_CHN_MASK_DEFAULT;
+
+	ret = ath11k_wmi_vdev_spectral_conf(ar, &param);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to configure spectral scan: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t ath11k_read_file_spec_scan_ctl(struct file *file,
+					      char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char *mode = "";
+	size_t len;
+	enum ath11k_spectral_mode spectral_mode;
+
+	mutex_lock(&ar->conf_mutex);
+	spectral_mode = ar->spectral.mode;
+	mutex_unlock(&ar->conf_mutex);
+
+	switch (spectral_mode) {
+	case ATH11K_SPECTRAL_DISABLED:
+		mode = "disable";
+		break;
+	case ATH11K_SPECTRAL_BACKGROUND:
+		mode = "background";
+		break;
+	case ATH11K_SPECTRAL_MANUAL:
+		mode = "manual";
+		break;
+	}
+
+	len = strlen(mode);
+	return simple_read_from_buffer(user_buf, count, ppos, mode, len);
+}
+
+static ssize_t ath11k_write_file_spec_scan_ctl(struct file *file,
+					       const char __user *user_buf,
+					       size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	ssize_t len;
+	int ret;
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (strncmp("trigger", buf, 7) == 0) {
+		if (ar->spectral.mode == ATH11K_SPECTRAL_MANUAL ||
+		    ar->spectral.mode == ATH11K_SPECTRAL_BACKGROUND) {
+			/* reset the configuration to adopt possibly changed
+			 * debugfs parameters
+			 */
+			ret = ath11k_spectral_scan_config(ar, ar->spectral.mode);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to reconfigure spectral scan: %d\n",
+					    ret);
+				goto unlock;
+			}
+
+			ret = ath11k_spectral_scan_trigger(ar);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to trigger spectral scan: %d\n",
+					    ret);
+			}
+		} else {
+			ret = -EINVAL;
+		}
+	} else if (strncmp("background", buf, 10) == 0) {
+		ret = ath11k_spectral_scan_config(ar, ATH11K_SPECTRAL_BACKGROUND);
+	} else if (strncmp("manual", buf, 6) == 0) {
+		ret = ath11k_spectral_scan_config(ar, ATH11K_SPECTRAL_MANUAL);
+	} else if (strncmp("disable", buf, 7) == 0) {
+		ret = ath11k_spectral_scan_config(ar, ATH11K_SPECTRAL_DISABLED);
+	} else {
+		ret = -EINVAL;
+	}
+
+unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations fops_scan_ctl = {
+	.read = ath11k_read_file_spec_scan_ctl,
+	.write = ath11k_write_file_spec_scan_ctl,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_read_file_spectral_count(struct file *file,
+					       char __user *user_buf,
+					       size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	size_t len;
+	u16 spectral_count;
+
+	mutex_lock(&ar->conf_mutex);
+	spectral_count = ar->spectral.count;
+	mutex_unlock(&ar->conf_mutex);
+
+	len = sprintf(buf, "%d\n", spectral_count);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_write_file_spectral_count(struct file *file,
+						const char __user *user_buf,
+						size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	unsigned long val;
+	char buf[32];
+	ssize_t len;
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val > ATH11K_SPECTRAL_SCAN_COUNT_MAX)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	ar->spectral.count = val;
+	mutex_unlock(&ar->conf_mutex);
+
+	return count;
+}
+
+static const struct file_operations fops_scan_count = {
+	.read = ath11k_read_file_spectral_count,
+	.write = ath11k_write_file_spectral_count,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_read_file_spectral_bins(struct file *file,
+					      char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	unsigned int bins, fft_size;
+	size_t len;
+
+	mutex_lock(&ar->conf_mutex);
+
+	fft_size = ar->spectral.fft_size;
+	bins = 1 << fft_size;
+
+	mutex_unlock(&ar->conf_mutex);
+
+	len = sprintf(buf, "%d\n", bins);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_write_file_spectral_bins(struct file *file,
+					       const char __user *user_buf,
+					       size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	unsigned long val;
+	char buf[32];
+	ssize_t len;
+
+	len = min(count, sizeof(buf) - 1);
+	if (copy_from_user(buf, user_buf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val < ATH11K_SPECTRAL_ATH11K_MIN_BINS ||
+	    val > SPECTRAL_ATH11K_MAX_NUM_BINS)
+		return -EINVAL;
+
+	if (!is_power_of_2(val))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	ar->spectral.fft_size = ilog2(val);
+	mutex_unlock(&ar->conf_mutex);
+
+	return count;
+}
+
+static const struct file_operations fops_scan_bins = {
+	.read = ath11k_read_file_spectral_bins,
+	.write = ath11k_write_file_spectral_bins,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int ath11k_spectral_pull_summary(struct ath11k *ar,
+					struct wmi_dma_buf_release_meta_data *meta,
+					struct spectral_summary_fft_report *summary,
+					struct ath11k_spectral_summary_report *report)
+{
+	report->timestamp = __le32_to_cpu(summary->timestamp);
+	report->agc_total_gain = FIELD_GET(SPECTRAL_SUMMARY_INFO0_AGC_TOTAL_GAIN,
+					   __le32_to_cpu(summary->info0));
+	report->out_of_band_flag = FIELD_GET(SPECTRAL_SUMMARY_INFO0_OB_FLAG,
+					     __le32_to_cpu(summary->info0));
+	report->grp_idx = FIELD_GET(SPECTRAL_SUMMARY_INFO0_GRP_IDX,
+				    __le32_to_cpu(summary->info0));
+	report->rf_saturation = FIELD_GET(SPECTRAL_SUMMARY_INFO0_RECENT_RFSAT,
+					  __le32_to_cpu(summary->info0));
+	report->inb_pwr_db = FIELD_GET(SPECTRAL_SUMMARY_INFO0_INBAND_PWR_DB,
+				       __le32_to_cpu(summary->info0));
+	report->false_scan = FIELD_GET(SPECTRAL_SUMMARY_INFO0_FALSE_SCAN,
+				       __le32_to_cpu(summary->info0));
+	report->detector_id = FIELD_GET(SPECTRAL_SUMMARY_INFO0_DETECTOR_ID,
+					__le32_to_cpu(summary->info0));
+	report->primary80 = FIELD_GET(SPECTRAL_SUMMARY_INFO0_PRI80,
+				      __le32_to_cpu(summary->info0));
+	report->peak_idx = FIELD_GET(SPECTRAL_SUMMARY_INFO2_PEAK_SIGNED_IDX,
+				     __le32_to_cpu(summary->info2));
+	report->peak_mag = FIELD_GET(SPECTRAL_SUMMARY_INFO2_PEAK_MAGNITUDE,
+				     __le32_to_cpu(summary->info2));
+	report->gain_change = FIELD_GET(SPECTRAL_SUMMARY_INFO2_GAIN_CHANGE,
+					__le32_to_cpu(summary->info2));
+
+	memcpy(&report->meta, meta, sizeof(*meta));
+
+	return 0;
+}
+
+static int ath11k_spectral_pull_search(struct ath11k *ar,
+				       struct spectral_search_fft_report *search,
+				       struct ath11k_spectral_search_report *report)
+{
+	report->timestamp = __le32_to_cpu(search->timestamp);
+	report->detector_id = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_DETECTOR_ID,
+					__le32_to_cpu(search->info0));
+	report->fft_count = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_FFT_NUM,
+				      __le32_to_cpu(search->info0));
+	report->radar_check = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_RADAR_CHECK,
+					__le32_to_cpu(search->info0));
+	report->peak_idx = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_PEAK_SIGNED_IDX,
+				     __le32_to_cpu(search->info0));
+	report->chain_idx = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_CHAIN_IDX,
+				      __le32_to_cpu(search->info0));
+	report->base_pwr_db = FIELD_GET(SPECTRAL_FFT_REPORT_INFO1_BASE_PWR_DB,
+					__le32_to_cpu(search->info1));
+	report->total_gain_db = FIELD_GET(SPECTRAL_FFT_REPORT_INFO1_TOTAL_GAIN_DB,
+					  __le32_to_cpu(search->info1));
+	report->strong_bin_count = FIELD_GET(SPECTRAL_FFT_REPORT_INFO2_NUM_STRONG_BINS,
+					     __le32_to_cpu(search->info2));
+	report->peak_mag = FIELD_GET(SPECTRAL_FFT_REPORT_INFO2_PEAK_MAGNITUDE,
+				     __le32_to_cpu(search->info2));
+	report->avg_pwr_db = FIELD_GET(SPECTRAL_FFT_REPORT_INFO2_AVG_PWR_DB,
+				       __le32_to_cpu(search->info2));
+	report->rel_pwr_db = FIELD_GET(SPECTRAL_FFT_REPORT_INFO2_REL_PWR_DB,
+				       __le32_to_cpu(search->info2));
+
+	return 0;
+}
+
+static u8 ath11k_spectral_get_max_exp(s8 max_index, u8 max_magnitude,
+				      int bin_len, u8 *bins)
+{
+	int dc_pos;
+	u8 max_exp;
+
+	dc_pos = bin_len / 2;
+
+	/* peak index outside of bins */
+	if (dc_pos <= max_index || -dc_pos >= max_index)
+		return 0;
+
+	for (max_exp = 0; max_exp < 8; max_exp++) {
+		if (bins[dc_pos + max_index] == (max_magnitude >> max_exp))
+			break;
+	}
+
+	/* max_exp not found */
+	if (bins[dc_pos + max_index] != (max_magnitude >> max_exp))
+		return 0;
+
+	return max_exp;
+}
+
+static void ath11k_spectral_parse_16bit_fft(u8 *outbins, u8 *inbins, int num_bins)
+{
+	int i;
+	__le16 *data = (__le16 *)inbins;
+
+	i = 0;
+	while (i < num_bins) {
+		outbins[i] = (__le16_to_cpu(data[i])) &
+			     ATH11K_SPECTRAL_SAMPLE_FFT_BIN_MASK;
+		i++;
+	}
+}
+
+static
+int ath11k_spectral_process_fft(struct ath11k *ar,
+				struct ath11k_spectral_summary_report *summary,
+				void *data,
+				struct fft_sample_ath11k *fft_sample,
+				u32 data_len)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct spectral_search_fft_report *fft_report = data;
+	struct ath11k_spectral_search_report search;
+	struct spectral_tlv *tlv;
+	int tlv_len, bin_len, num_bins;
+	u16 length, freq;
+	u8 chan_width_mhz;
+	int ret;
+
+	lockdep_assert_held(&ar->spectral.lock);
+
+	tlv = (struct spectral_tlv *)data;
+	tlv_len = FIELD_GET(SPECTRAL_TLV_HDR_LEN, __le32_to_cpu(tlv->header));
+	/* convert Dword into bytes */
+	tlv_len *= ATH11K_SPECTRAL_DWORD_SIZE;
+	bin_len = tlv_len - (sizeof(*fft_report) - sizeof(*tlv));
+
+	if (data_len < (bin_len + sizeof(*fft_report))) {
+		ath11k_warn(ab, "mismatch in expected bin len %d and data len %d\n",
+			    bin_len, data_len);
+		return -EINVAL;
+	}
+
+	num_bins = bin_len / ATH11K_SPECTRAL_BIN_SIZE;
+	/* Only In-band bins are useful to user for visualize */
+	num_bins >>= 1;
+
+	if (num_bins < ATH11K_SPECTRAL_ATH11K_MIN_IB_BINS ||
+	    num_bins > ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS ||
+	    !is_power_of_2(num_bins)) {
+		ath11k_warn(ab, "Invalid num of bins %d\n", num_bins);
+		return -EINVAL;
+	}
+
+	ret = ath11k_spectral_pull_search(ar, data, &search);
+	if (ret) {
+		ath11k_warn(ab, "failed to pull search report %d\n", ret);
+		return ret;
+	}
+
+	chan_width_mhz = summary->meta.ch_width;
+
+	switch (chan_width_mhz) {
+	case ATH11K_SPECTRAL_20MHZ:
+	case ATH11K_SPECTRAL_40MHZ:
+	case ATH11K_SPECTRAL_80MHZ:
+		fft_sample->chan_width_mhz = chan_width_mhz;
+		break;
+	default:
+		ath11k_warn(ab, "invalid channel width %d\n", chan_width_mhz);
+		return -EINVAL;
+	}
+
+	length = sizeof(*fft_sample) - sizeof(struct fft_sample_tlv) + num_bins;
+	fft_sample->tlv.type = ATH_FFT_SAMPLE_ATH11K;
+	fft_sample->tlv.length = __cpu_to_be16(length);
+
+	fft_sample->tsf = __cpu_to_be32(search.timestamp);
+	fft_sample->max_magnitude = __cpu_to_be16(search.peak_mag);
+	fft_sample->max_index = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_PEAK_SIGNED_IDX,
+					  __le32_to_cpu(fft_report->info0));
+
+	summary->inb_pwr_db >>= 1;
+	fft_sample->rssi = __cpu_to_be16(summary->inb_pwr_db);
+	fft_sample->noise = __cpu_to_be32(summary->meta.noise_floor[search.chain_idx]);
+
+	freq = summary->meta.freq1;
+	fft_sample->freq1 = __cpu_to_be16(freq);
+
+	freq = summary->meta.freq2;
+	fft_sample->freq2 = __cpu_to_be16(freq);
+
+	ath11k_spectral_parse_16bit_fft(fft_sample->data,
+					fft_report->bins,
+					num_bins);
+
+	fft_sample->max_exp = ath11k_spectral_get_max_exp(fft_sample->max_index,
+							  search.peak_mag,
+							  num_bins,
+							  fft_sample->data);
+
+	if (ar->spectral.rfs_scan)
+		relay_write(ar->spectral.rfs_scan, fft_sample,
+			    length + sizeof(struct fft_sample_tlv));
+
+	return 0;
+}
+
+static int ath11k_spectral_process_data(struct ath11k *ar,
+					struct ath11k_dbring_data *param)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct spectral_tlv *tlv;
+	struct spectral_summary_fft_report *summary = NULL;
+	struct ath11k_spectral_summary_report summ_rpt;
+	struct fft_sample_ath11k *fft_sample = NULL;
+	u8 *data;
+	u32 data_len, i;
+	u8 sign, tag;
+	int tlv_len, sample_sz;
+	int ret;
+	bool quit = false;
+
+	spin_lock_bh(&ar->spectral.lock);
+
+	if (!ar->spectral.enabled) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	sample_sz = sizeof(*fft_sample) + ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS;
+	fft_sample = kmalloc(sample_sz, GFP_ATOMIC);
+	if (!fft_sample) {
+		ret = -ENOBUFS;
+		goto unlock;
+	}
+
+	data = param->data;
+	data_len = param->data_sz;
+	i = 0;
+	while (!quit && (i < data_len)) {
+		if ((i + sizeof(*tlv)) > data_len) {
+			ath11k_warn(ab, "failed to parse spectral tlv hdr at bytes %d\n",
+				    i);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		tlv = (struct spectral_tlv *)&data[i];
+		sign = FIELD_GET(SPECTRAL_TLV_HDR_SIGN,
+				 __le32_to_cpu(tlv->header));
+		if (sign != ATH11K_SPECTRAL_SIGNATURE) {
+			ath11k_warn(ab, "Invalid sign 0x%x at bytes %d\n",
+				    sign, i);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		tlv_len = FIELD_GET(SPECTRAL_TLV_HDR_LEN,
+				    __le32_to_cpu(tlv->header));
+		/* convert Dword into bytes */
+		tlv_len *= ATH11K_SPECTRAL_DWORD_SIZE;
+		if ((i + sizeof(*tlv) + tlv_len) > data_len) {
+			ath11k_warn(ab, "failed to parse spectral tlv payload at bytes %d tlv_len:%d data_len:%d\n",
+				    i, tlv_len, data_len);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		tag = FIELD_GET(SPECTRAL_TLV_HDR_TAG,
+				__le32_to_cpu(tlv->header));
+		switch (tag) {
+		case ATH11K_SPECTRAL_TAG_SCAN_SUMMARY:
+			/* HW bug in tlv length of summary report,
+			 * HW report 3 DWORD size but the data payload
+			 * is 4 DWORD size (16 bytes).
+			 * Need to remove this workaround once HW bug fixed
+			 */
+			tlv_len = sizeof(*summary) - sizeof(*tlv);
+
+			if (tlv_len < (sizeof(*summary) - sizeof(*tlv))) {
+				ath11k_warn(ab, "failed to parse spectral summary at bytes %d tlv_len:%d\n",
+					    i, tlv_len);
+				ret = -EINVAL;
+				goto err;
+			}
+
+			summary = (struct spectral_summary_fft_report *)tlv;
+			ath11k_spectral_pull_summary(ar, &param->meta,
+						     summary, &summ_rpt);
+			break;
+		case ATH11K_SPECTRAL_TAG_SCAN_SEARCH:
+			if (tlv_len < (sizeof(struct spectral_search_fft_report) -
+				       sizeof(*tlv))) {
+				ath11k_warn(ab, "failed to parse spectral search fft at bytes %d\n",
+					    i);
+				ret = -EINVAL;
+				goto err;
+			}
+
+			memset(fft_sample, 0, sample_sz);
+			ret = ath11k_spectral_process_fft(ar, &summ_rpt, tlv,
+							  fft_sample,
+							  data_len - i);
+			if (ret) {
+				ath11k_warn(ab, "failed to process spectral fft at bytes %d\n",
+					    i);
+				goto err;
+			}
+			quit = true;
+			break;
+		}
+
+		i += sizeof(*tlv) + tlv_len;
+	}
+
+err:
+	kfree(fft_sample);
+unlock:
+	spin_unlock_bh(&ar->spectral.lock);
+	return ret;
+}
+
+static int ath11k_spectral_ring_alloc(struct ath11k *ar,
+				      struct ath11k_dbring_cap *db_cap)
+{
+	struct ath11k_spectral *sp = &ar->spectral;
+	int ret;
+
+	ret = ath11k_dbring_srng_setup(ar, &sp->rx_ring,
+				       0, db_cap->min_elem);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring\n");
+		return ret;
+	}
+
+	ath11k_dbring_set_cfg(ar, &sp->rx_ring,
+			      ATH11K_SPECTRAL_NUM_RESP_PER_EVENT,
+			      ATH11K_SPECTRAL_EVENT_TIMEOUT_MS,
+			      ath11k_spectral_process_data);
+
+	ret = ath11k_dbring_buf_setup(ar, &sp->rx_ring, db_cap);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring buffer\n");
+		goto srng_cleanup;
+	}
+
+	ret = ath11k_dbring_wmi_cfg_setup(ar, &sp->rx_ring,
+					  WMI_DIRECT_BUF_SPECTRAL);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+		goto buffer_cleanup;
+	}
+
+	return 0;
+
+buffer_cleanup:
+	ath11k_dbring_buf_cleanup(ar, &sp->rx_ring);
+srng_cleanup:
+	ath11k_dbring_srng_cleanup(ar, &sp->rx_ring);
+	return ret;
+}
+
+static inline void ath11k_spectral_ring_free(struct ath11k *ar)
+{
+	struct ath11k_spectral *sp = &ar->spectral;
+
+	if (!sp->enabled)
+		return;
+
+	ath11k_dbring_srng_cleanup(ar, &sp->rx_ring);
+	ath11k_dbring_buf_cleanup(ar, &sp->rx_ring);
+}
+
+static inline void ath11k_spectral_debug_unregister(struct ath11k *ar)
+{
+	debugfs_remove(ar->spectral.scan_bins);
+	ar->spectral.scan_bins = NULL;
+
+	debugfs_remove(ar->spectral.scan_count);
+	ar->spectral.scan_count = NULL;
+
+	debugfs_remove(ar->spectral.scan_ctl);
+	ar->spectral.scan_ctl = NULL;
+
+	if (ar->spectral.rfs_scan) {
+		relay_close(ar->spectral.rfs_scan);
+		ar->spectral.rfs_scan = NULL;
+	}
+}
+
+int ath11k_spectral_vif_stop(struct ath11k_vif *arvif)
+{
+	if (!arvif->spectral_enabled)
+		return 0;
+
+	return ath11k_spectral_scan_config(arvif->ar, ATH11K_SPECTRAL_DISABLED);
+}
+
+void ath11k_spectral_reset_buffer(struct ath11k *ar)
+{
+	if (!ar->spectral.enabled)
+		return;
+
+	if (ar->spectral.rfs_scan)
+		relay_reset(ar->spectral.rfs_scan);
+}
+
+void ath11k_spectral_deinit(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_spectral *sp;
+	int i;
+
+	for (i = 0; i <  ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		sp = &ar->spectral;
+
+		if (!sp->enabled)
+			continue;
+
+		ath11k_spectral_debug_unregister(ar);
+		ath11k_spectral_ring_free(ar);
+
+		spin_lock_bh(&sp->lock);
+
+		sp->mode = ATH11K_SPECTRAL_DISABLED;
+		sp->enabled = false;
+
+		spin_unlock_bh(&sp->lock);
+	}
+}
+
+static inline int ath11k_spectral_debug_register(struct ath11k *ar)
+{
+	int ret;
+
+	ar->spectral.rfs_scan = relay_open("spectral_scan",
+					   ar->debug.debugfs_pdev,
+					   ATH11K_SPECTRAL_SUB_BUFF_SIZE,
+					   ATH11K_SPECTRAL_NUM_SUB_BUF,
+					   &rfs_scan_cb, NULL);
+	if (!ar->spectral.rfs_scan) {
+		ath11k_warn(ar->ab, "failed to open relay in pdev %d\n",
+			    ar->pdev_idx);
+		return -EINVAL;
+	}
+
+	ar->spectral.scan_ctl = debugfs_create_file("spectral_scan_ctl",
+						    0600,
+						    ar->debug.debugfs_pdev, ar,
+						    &fops_scan_ctl);
+	if (!ar->spectral.scan_ctl) {
+		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
+			    ar->pdev_idx);
+		ret = -EINVAL;
+		goto debug_unregister;
+	}
+
+	ar->spectral.scan_count = debugfs_create_file("spectral_count",
+						      0600,
+						      ar->debug.debugfs_pdev, ar,
+						      &fops_scan_count);
+	if (!ar->spectral.scan_count) {
+		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
+			    ar->pdev_idx);
+		ret = -EINVAL;
+		goto debug_unregister;
+	}
+
+	ar->spectral.scan_bins = debugfs_create_file("spectral_bins",
+						     0600,
+						     ar->debug.debugfs_pdev, ar,
+						     &fops_scan_bins);
+	if (!ar->spectral.scan_bins) {
+		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
+			    ar->pdev_idx);
+		ret = -EINVAL;
+		goto debug_unregister;
+	}
+
+	return 0;
+
+debug_unregister:
+	ath11k_spectral_debug_unregister(ar);
+	return ret;
+}
+
+int ath11k_spectral_init(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_spectral *sp;
+	struct ath11k_dbring_cap db_cap;
+	int ret;
+	int i;
+
+	if (!test_bit(WMI_TLV_SERVICE_FREQINFO_IN_METADATA,
+		      ab->wmi_ab.svc_map)) {
+		ath11k_info(ab, "spectral not supported\n");
+		return 0;
+	}
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		sp = &ar->spectral;
+
+		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
+					    WMI_DIRECT_BUF_SPECTRAL,
+					    &db_cap);
+		if (ret) {
+			ath11k_info(ab, "spectral not enabled for pdev %d\n", i);
+			continue;
+		}
+
+		idr_init(&sp->rx_ring.bufs_idr);
+		spin_lock_init(&sp->rx_ring.idr_lock);
+		spin_lock_init(&sp->lock);
+
+		ret = ath11k_spectral_ring_alloc(ar, &db_cap);
+		if (ret) {
+			ath11k_warn(ab, "failed to init spectral ring for pdev %d\n",
+				    i);
+			goto deinit;
+		}
+
+		spin_lock_bh(&sp->lock);
+
+		sp->mode = ATH11K_SPECTRAL_DISABLED;
+		sp->count = ATH11K_WMI_SPECTRAL_COUNT_DEFAULT;
+		sp->fft_size = ATH11K_WMI_SPECTRAL_FFT_SIZE_DEFAULT;
+		sp->enabled = true;
+
+		spin_unlock_bh(&sp->lock);
+
+		ret = ath11k_spectral_debug_register(ar);
+		if (ret) {
+			ath11k_warn(ab, "failed to register spectral for pdev %d\n",
+				    i);
+			goto deinit;
+		}
+	}
+
+	return 0;
+
+deinit:
+	ath11k_spectral_deinit(ab);
+	return ret;
+}
+
+enum ath11k_spectral_mode ath11k_spectral_get_mode(struct ath11k *ar)
+{
+	if (ar->spectral.enabled)
+		return ar->spectral.mode;
+	else
+		return ATH11K_SPECTRAL_DISABLED;
+}
+
+struct ath11k_dbring *ath11k_spectral_get_dbring(struct ath11k *ar)
+{
+	if (ar->spectral.enabled)
+		return &ar->spectral.rx_ring;
+	else
+		return NULL;
+}
diff --git a/drivers/net/wireless/ath/ath11k/spectral.h b/drivers/net/wireless/ath/ath11k/spectral.h
new file mode 100644
index 0000000..b0a41ab
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/spectral.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_SPECTRAL_H
+#define ATH11K_SPECTRAL_H
+
+#include "../spectral_common.h"
+#include "dbring.h"
+
+/* enum ath11k_spectral_mode:
+ *
+ * @SPECTRAL_DISABLED: spectral mode is disabled
+ * @SPECTRAL_BACKGROUND: hardware sends samples when it is not busy with
+ *	something else.
+ * @SPECTRAL_MANUAL: spectral scan is enabled, triggering for samples
+ *	is performed manually.
+ */
+enum ath11k_spectral_mode {
+	ATH11K_SPECTRAL_DISABLED = 0,
+	ATH11K_SPECTRAL_BACKGROUND,
+	ATH11K_SPECTRAL_MANUAL,
+};
+
+struct ath11k_spectral {
+	struct ath11k_dbring rx_ring;
+	/* Protects enabled */
+	spinlock_t lock;
+	struct rchan *rfs_scan;	/* relay(fs) channel for spectral scan */
+	struct dentry *scan_ctl;
+	struct dentry *scan_count;
+	struct dentry *scan_bins;
+	enum ath11k_spectral_mode mode;
+	u16 count;
+	u8 fft_size;
+	bool enabled;
+};
+
+#ifdef CONFIG_ATH11K_SPECTRAL
+
+int ath11k_spectral_init(struct ath11k_base *ab);
+void ath11k_spectral_deinit(struct ath11k_base *ab);
+int ath11k_spectral_vif_stop(struct ath11k_vif *arvif);
+void ath11k_spectral_reset_buffer(struct ath11k *ar);
+enum ath11k_spectral_mode ath11k_spectral_get_mode(struct ath11k *ar);
+struct ath11k_dbring *ath11k_spectral_get_dbring(struct ath11k *ar);
+
+#else
+
+static inline int ath11k_spectral_init(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_spectral_deinit(struct ath11k_base *ab)
+{
+}
+
+static inline int ath11k_spectral_vif_stop(struct ath11k_vif *arvif)
+{
+	return 0;
+}
+
+static inline void ath11k_spectral_reset_buffer(struct ath11k *ar)
+{
+}
+
+static inline
+enum ath11k_spectral_mode ath11k_spectral_get_mode(struct ath11k *ar)
+{
+	return ATH11K_SPECTRAL_DISABLED;
+}
+
+static inline
+struct ath11k_db_ring *ath11k_spectral_get_dbring(struct ath11k *ar)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_ATH11K_SPECTRAL */
+#endif /* ATH11K_SPECTRAL_H */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index fe42d16..c66aa16 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -63,6 +63,16 @@ struct wmi_tlv_rdy_parse {
 	u32 num_extra_mac_addr;
 };
 
+struct wmi_tlv_dma_buf_release_parse {
+	struct ath11k_wmi_dma_buf_release_fixed_param fixed;
+	struct wmi_dma_buf_release_entry *buf_entry;
+	struct wmi_dma_buf_release_meta_data *meta_data;
+	u32 num_buf_entry;
+	u32 num_meta;
+	bool buf_entry_done;
+	bool meta_data_done;
+};
+
 static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 	[WMI_TAG_ARRAY_BYTE]
 		= { .min_len = 0 },
@@ -3280,6 +3290,80 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
 }
 
+int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
+				  struct ath11k_wmi_vdev_spectral_conf_param *param)
+{
+	struct ath11k_wmi_vdev_spectral_conf_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct ath11k_wmi_vdev_spectral_conf_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_VDEV_SPECTRAL_CONFIGURE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	memcpy(&cmd->param, param, sizeof(*param));
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb,
+				  WMI_VDEV_SPECTRAL_SCAN_CONFIGURE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send spectral scan config wmi cmd\n");
+		goto err;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI spectral scan config cmd vdev_id 0x%x\n",
+		   param->vdev_id);
+
+	return 0;
+err:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
+int ath11k_wmi_vdev_spectral_enable(struct ath11k *ar, u32 vdev_id,
+				    u32 trigger, u32 enable)
+{
+	struct ath11k_wmi_vdev_spectral_enable_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct ath11k_wmi_vdev_spectral_enable_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_VDEV_SPECTRAL_ENABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->trigger_cmd = trigger;
+	cmd->enable_cmd = enable;
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb,
+				  WMI_VDEV_SPECTRAL_SCAN_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send spectral enable wmi cmd\n");
+		goto err;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI spectral enable cmd vdev id 0x%x\n",
+		   vdev_id);
+
+	return 0;
+err:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
 int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
 				 struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *param)
 {
@@ -3326,6 +3410,116 @@ int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
 	return ret;
 }
 
+static int ath11k_wmi_tlv_dma_buf_entry_parse(struct ath11k_base *soc,
+					      u16 tag, u16 len,
+					      const void *ptr, void *data)
+{
+	struct wmi_tlv_dma_buf_release_parse *parse = data;
+
+	if (tag != WMI_TAG_DMA_BUF_RELEASE_ENTRY)
+		return -EPROTO;
+
+	if (parse->num_buf_entry >= parse->fixed.num_buf_release_entry)
+		return -ENOBUFS;
+
+	parse->num_buf_entry++;
+	return 0;
+}
+
+static int ath11k_wmi_tlv_dma_buf_meta_parse(struct ath11k_base *soc,
+					     u16 tag, u16 len,
+					     const void *ptr, void *data)
+{
+	struct wmi_tlv_dma_buf_release_parse *parse = data;
+
+	if (tag != WMI_TAG_DMA_BUF_RELEASE_SPECTRAL_META_DATA)
+		return -EPROTO;
+
+	if (parse->num_meta >= parse->fixed.num_meta_data_entry)
+		return -ENOBUFS;
+
+	parse->num_meta++;
+	return 0;
+}
+
+static int ath11k_wmi_tlv_dma_buf_parse(struct ath11k_base *ab,
+					u16 tag, u16 len,
+					const void *ptr, void *data)
+{
+	struct wmi_tlv_dma_buf_release_parse *parse = data;
+	int ret;
+
+	switch (tag) {
+	case WMI_TAG_DMA_BUF_RELEASE:
+		memcpy(&parse->fixed, ptr,
+		       sizeof(struct ath11k_wmi_dma_buf_release_fixed_param));
+		parse->fixed.pdev_id = DP_HW2SW_MACID(parse->fixed.pdev_id);
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		if (!parse->buf_entry_done) {
+			parse->num_buf_entry = 0;
+			parse->buf_entry = (struct wmi_dma_buf_release_entry *)ptr;
+
+			ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+						  ath11k_wmi_tlv_dma_buf_entry_parse,
+						  parse);
+			if (ret) {
+				ath11k_warn(ab, "failed to parse dma buf entry tlv %d\n",
+					    ret);
+				return ret;
+			}
+
+			parse->buf_entry_done = true;
+		} else if (!parse->meta_data_done) {
+			parse->num_meta = 0;
+			parse->meta_data = (struct wmi_dma_buf_release_meta_data *)ptr;
+
+			ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+						  ath11k_wmi_tlv_dma_buf_meta_parse,
+						  parse);
+			if (ret) {
+				ath11k_warn(ab, "failed to parse dma buf meta tlv %d\n",
+					    ret);
+				return ret;
+			}
+
+			parse->meta_data_done = true;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static void ath11k_wmi_pdev_dma_ring_buf_release_event(struct ath11k_base *ab,
+						       struct sk_buff *skb)
+{
+	struct wmi_tlv_dma_buf_release_parse parse = { };
+	struct ath11k_dbring_buf_release_event param;
+	int ret;
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_dma_buf_parse,
+				  &parse);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse dma buf release tlv %d\n", ret);
+		return;
+	}
+
+	param.fixed		= parse.fixed;
+	param.buf_entry		= parse.buf_entry;
+	param.num_buf_entry	= parse.num_buf_entry;
+	param.meta_data		= parse.meta_data;
+	param.num_meta		= parse.num_meta;
+
+	ret = ath11k_dbring_buffer_release_event(ab, &param);
+	if (ret) {
+		ath11k_warn(ab, "failed to handle dma buf release event %d\n", ret);
+		return;
+	}
+}
+
 static int ath11k_wmi_tlv_hw_mode_caps_parse(struct ath11k_base *soc,
 					     u16 tag, u16 len,
 					     const void *ptr, void *data)
@@ -6214,12 +6408,16 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_TEMPERATURE_EVENTID:
 		ath11k_wmi_pdev_temperature_event(ab, skb);
 		break;
+	case WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID:
+		ath11k_wmi_pdev_dma_ring_buf_release_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
+	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5c94135..be67803 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2020,6 +2020,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_DSM_ROAM_FILTER = 211,
 	WMI_TLV_SERVICE_PACKET_CAPTURE_SUPPORT = 212,
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
+	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 
 	WMI_MAX_EXT_SERVICE
@@ -4758,6 +4759,64 @@ struct ath11k_wmi_pdev_lro_config_cmd {
 	u32 pdev_id;
 } __packed;
 
+#define ATH11K_WMI_SPECTRAL_COUNT_DEFAULT                 0
+#define ATH11K_WMI_SPECTRAL_PERIOD_DEFAULT              224
+#define ATH11K_WMI_SPECTRAL_PRIORITY_DEFAULT              1
+#define ATH11K_WMI_SPECTRAL_FFT_SIZE_DEFAULT              7
+#define ATH11K_WMI_SPECTRAL_GC_ENA_DEFAULT                1
+#define ATH11K_WMI_SPECTRAL_RESTART_ENA_DEFAULT           0
+#define ATH11K_WMI_SPECTRAL_NOISE_FLOOR_REF_DEFAULT     -96
+#define ATH11K_WMI_SPECTRAL_INIT_DELAY_DEFAULT           80
+#define ATH11K_WMI_SPECTRAL_NB_TONE_THR_DEFAULT          12
+#define ATH11K_WMI_SPECTRAL_STR_BIN_THR_DEFAULT           8
+#define ATH11K_WMI_SPECTRAL_WB_RPT_MODE_DEFAULT           0
+#define ATH11K_WMI_SPECTRAL_RSSI_RPT_MODE_DEFAULT         0
+#define ATH11K_WMI_SPECTRAL_RSSI_THR_DEFAULT           0xf0
+#define ATH11K_WMI_SPECTRAL_PWR_FORMAT_DEFAULT            0
+#define ATH11K_WMI_SPECTRAL_RPT_MODE_DEFAULT              2
+#define ATH11K_WMI_SPECTRAL_BIN_SCALE_DEFAULT             1
+#define ATH11K_WMI_SPECTRAL_DBM_ADJ_DEFAULT               1
+#define ATH11K_WMI_SPECTRAL_CHN_MASK_DEFAULT              1
+
+struct ath11k_wmi_vdev_spectral_conf_param {
+	u32 vdev_id;
+	u32 scan_count;
+	u32 scan_period;
+	u32 scan_priority;
+	u32 scan_fft_size;
+	u32 scan_gc_ena;
+	u32 scan_restart_ena;
+	u32 scan_noise_floor_ref;
+	u32 scan_init_delay;
+	u32 scan_nb_tone_thr;
+	u32 scan_str_bin_thr;
+	u32 scan_wb_rpt_mode;
+	u32 scan_rssi_rpt_mode;
+	u32 scan_rssi_thr;
+	u32 scan_pwr_format;
+	u32 scan_rpt_mode;
+	u32 scan_bin_scale;
+	u32 scan_dbm_adj;
+	u32 scan_chn_mask;
+} __packed;
+
+struct ath11k_wmi_vdev_spectral_conf_cmd {
+	u32 tlv_header;
+	struct ath11k_wmi_vdev_spectral_conf_param param;
+} __packed;
+
+#define ATH11K_WMI_SPECTRAL_TRIGGER_CMD_TRIGGER  1
+#define ATH11K_WMI_SPECTRAL_TRIGGER_CMD_CLEAR    2
+#define ATH11K_WMI_SPECTRAL_ENABLE_CMD_ENABLE    1
+#define ATH11K_WMI_SPECTRAL_ENABLE_CMD_DISABLE   2
+
+struct ath11k_wmi_vdev_spectral_enable_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 trigger_cmd;
+	u32 enable_cmd;
+} __packed;
+
 struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -5020,4 +5079,8 @@ int ath11k_wmi_send_bss_color_change_enable_cmd(struct ath11k *ar, u32 vdev_id,
 int ath11k_wmi_pdev_lro_cfg(struct ath11k *ar, int pdev_id);
 int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
 				 struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *param);
+int ath11k_wmi_vdev_spectral_enable(struct ath11k *ar, u32 vdev_id,
+				    u32 trigger, u32 enable);
+int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
+				  struct ath11k_wmi_vdev_spectral_conf_param *param);
 #endif
diff --git a/drivers/net/wireless/ath/spectral_common.h b/drivers/net/wireless/ath/spectral_common.h
index 0d742ac..9c2e545 100644
--- a/drivers/net/wireless/ath/spectral_common.h
+++ b/drivers/net/wireless/ath/spectral_common.h
@@ -24,6 +24,7 @@
  * could be acquired so far.
  */
 #define SPECTRAL_ATH10K_MAX_NUM_BINS		256
+#define SPECTRAL_ATH11K_MAX_NUM_BINS		512
 
 /* FFT sample format given to userspace via debugfs.
  *
@@ -37,6 +38,7 @@ enum ath_fft_sample_type {
 	ATH_FFT_SAMPLE_HT20 = 1,
 	ATH_FFT_SAMPLE_HT20_40,
 	ATH_FFT_SAMPLE_ATH10K,
+	ATH_FFT_SAMPLE_ATH11K
 };
 
 struct fft_sample_tlv {
@@ -110,4 +112,19 @@ struct fft_sample_ath10k {
 	u8 data[0];
 } __packed;
 
+struct fft_sample_ath11k {
+	struct fft_sample_tlv tlv;
+	u8 chan_width_mhz;
+	s8 max_index;
+	u8 max_exp;
+	__be16 freq1;
+	__be16 freq2;
+	__be16 max_magnitude;
+	__be16 rssi;
+	__be32 tsf;
+	__be32 noise;
+
+	u8 data[0];
+} __packed;
+
 #endif /* SPECTRAL_COMMON_H */
-- 
1.9.1

