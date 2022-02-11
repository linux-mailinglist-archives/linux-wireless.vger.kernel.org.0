Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825F4B28B7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbiBKPIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:08:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351216AbiBKPIP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:15 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC8304
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592093; x=1676128093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9kZqSV8Y75DtfCgNyO5J1yzspzNsTGZ/OFAfPqhpiSw=;
  b=GtE5ccDUY0Knmx+ynufKpKkp1ZmWTpE7n2z7w5qC/9MF93+7s2p21OUl
   uSC9EwOh38aEFPgcqiLLpV9x/CEpEMhcUg5XpYTqQ9lydGeUNfYGnkMOo
   tzQ5LZgxGUTl2fBY7MeIJHbfd810Yare5xcGyRq8cWoij7CzfnUhv2XUW
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 07:08:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:08:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:08:11 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 07:08:09 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 2/6] ath11k: CFR module initialization and deinitialization for IPQ8074
Date:   Fri, 11 Feb 2022 20:37:51 +0530
Message-ID: <1644592075-27082-3-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Add initialization and deinitialization sequence for CFR module.
CFR module will be initialized only when the following criteria passes,
 * enabled CFR support for the hardware through the
   hardware param 'cfr_support'
 * WMI service enabled for the CFR support
   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'

Also, provide a configuration option CONFIG_ATH11K_CFR to enable
CFR feature support during the compilation time.

CFR module initialization includes Direct Buffer(DB) ring initialization
where HW uses the DB ring buffers to copy CFR data to host.
Number of buffers and buffer size of the ring is based on the DB ring
capabilities advertised by the firmware through WMI service ready.
Also ring configurations are sent to firmware through
ath11k_dbring_wmi_cfg_setup().

Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig  |   9 ++
 drivers/net/wireless/ath/ath11k/Makefile |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c    | 161 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h    |  91 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.c   |  35 +++++++
 drivers/net/wireless/ath/ath11k/core.h   |   6 ++
 drivers/net/wireless/ath/ath11k/dbring.c |  23 +++--
 drivers/net/wireless/ath/ath11k/dbring.h |   5 +
 drivers/net/wireless/ath/ath11k/hal.c    |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h     |   5 +
 drivers/net/wireless/ath/ath11k/wmi.h    |   2 +
 11 files changed, 332 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index ad5cc6c..0466d58 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -57,3 +57,12 @@ config ATH11K_SPECTRAL
 	  Enable ath11k spectral scan support
 
 	  Say Y to enable access to the FFT/spectral data via debugfs.
+
+config ATH11K_CFR
+	bool "QCA ath11k CFR support"
+	depends on ATH11K_DEBUGFS
+	depends on RELAY
+	help
+	  Enable ath11k CFR support
+
+	  Say Y to enable CFR data dump collection via debugfs.
diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index c1fce41..36ffd2e 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -24,6 +24,7 @@ ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
 ath11k-$(CONFIG_ATH11K_SPECTRAL) += spectral.o
+ath11k-$(CONFIG_ATH11K_CFR) += cfr.o
 
 obj-$(CONFIG_ATH11K_AHB) += ath11k_ahb.o
 ath11k_ahb-y += ahb.o
diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
new file mode 100644
index 0000000..f5cc250
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
+ */
+
+#include <linux/relay.h>
+#include "core.h"
+#include "debug.h"
+
+static int ath11k_cfr_process_data(struct ath11k *ar,
+				   struct ath11k_dbring_data *param)
+{
+	return 0;
+}
+
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct ath11k_look_up_table *lut;
+
+	if (cfr->lut) {
+		lut = &cfr->lut[buf_id];
+		lut->dbr_address = paddr;
+	}
+}
+
+void ath11k_cfr_ring_free(struct ath11k *ar)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+}
+
+static int ath11k_cfr_ring_alloc(struct ath11k *ar,
+				 struct ath11k_dbring_cap *db_cap)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	int ret;
+
+	ret = ath11k_dbring_srng_setup(ar, &cfr->rx_ring,
+				       1, db_cap->min_elem);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring\n");
+		return ret;
+	}
+
+	ath11k_dbring_set_cfg(ar, &cfr->rx_ring,
+			      ATH11K_CFR_NUM_RESP_PER_EVENT,
+			      ATH11K_CFR_EVENT_TIMEOUT_MS,
+			      ath11k_cfr_process_data);
+
+	ret = ath11k_dbring_buf_setup(ar, &cfr->rx_ring, db_cap);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring buffer\n");
+		goto srng_cleanup;
+	}
+
+	ret = ath11k_dbring_wmi_cfg_setup(ar, &cfr->rx_ring, WMI_DIRECT_BUF_CFR);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+		goto buffer_cleanup;
+	}
+
+	return 0;
+
+buffer_cleanup:
+	ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
+srng_cleanup:
+	ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
+	return ret;
+}
+
+void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_cfr *cfr;
+	int i;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return;
+
+	for (i = 0; i <  ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		ath11k_cfr_ring_free(ar);
+
+		spin_lock_bh(&cfr->lut_lock);
+		kfree(cfr->lut);
+		cfr->lut = NULL;
+		spin_unlock_bh(&cfr->lut_lock);
+		ar->cfr_enabled = false;
+	}
+}
+
+int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_cfr *cfr;
+	struct ath11k_dbring_cap db_cap;
+	u32 num_lut_entries;
+	int ret = 0;
+	int i;
+
+	if (!test_bit(WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT, ab->wmi_ab.svc_map) ||
+	    !ab->hw_params.cfr_support)
+		return ret;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		cfr = &ar->cfr;
+
+		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
+					    WMI_DIRECT_BUF_CFR, &db_cap);
+		if (ret)
+			continue;
+
+		idr_init(&cfr->rx_ring.bufs_idr);
+		spin_lock_init(&cfr->rx_ring.idr_lock);
+		spin_lock_init(&cfr->lock);
+		spin_lock_init(&cfr->lut_lock);
+
+		num_lut_entries = min_t(u32, CFR_MAX_LUT_ENTRIES, db_cap.min_elem);
+
+		cfr->lut = kcalloc(num_lut_entries, sizeof(*cfr->lut),
+				   GFP_KERNEL);
+
+		if (!cfr->lut) {
+			ath11k_warn(ab, "failed to allocate lut for pdev %d\n", i);
+			return -ENOMEM;
+		}
+
+		ret = ath11k_cfr_ring_alloc(ar, &db_cap);
+		if (ret) {
+			ath11k_warn(ab, "failed to init cfr ring for pdev %d\n", i);
+			goto deinit;
+		}
+
+		cfr->lut_num = num_lut_entries;
+
+		ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_PER_PEER_CFR_ENABLE,
+						1, ar->pdev->pdev_id);
+		if (ret) {
+			ath11k_warn(ab, "failed to enable cfr capture on pdev %d ret %d\n",
+				    i, ret);
+			goto deinit;
+		}
+
+		ar->cfr_enabled = true;
+	}
+
+	return 0;
+
+deinit:
+	ath11k_cfr_deinit(ab);
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
new file mode 100644
index 0000000..c050f03
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
+ */
+
+#ifndef ATH11K_CFR_H
+#define ATH11K_CFR_H
+
+#include "dbring.h"
+#include "wmi.h"
+
+#define ATH11K_CFR_NUM_RESP_PER_EVENT   1
+#define ATH11K_CFR_EVENT_TIMEOUT_MS     1
+
+#define CFR_MAX_LUT_ENTRIES 136
+
+#define HOST_MAX_CHAINS 8
+
+struct ath11k_cfir_dma_hdr {
+	u16 info0;
+	u16 info1;
+	u16 sw_peer_id;
+	u16 phy_ppdu_id;
+};
+
+struct ath11k_look_up_table {
+	bool dbr_recv;
+	bool tx_recv;
+	u8 *data;
+	u32 data_len;
+	u16 dbr_ppdu_id;
+	u16 tx_ppdu_id;
+	dma_addr_t dbr_address;
+	u32 tx_address1;
+	u32 tx_address2;
+	struct ath11k_cfir_dma_hdr hdr;
+	u64 txrx_tstamp;
+	u64 dbr_tstamp;
+	u32 header_length;
+	u32 payload_length;
+	struct ath11k_dbring_element *buff;
+};
+
+struct ath11k_cfr {
+	struct ath11k_dbring rx_ring;
+	/* Protects cfr data */
+	spinlock_t lock;
+	struct ath11k_look_up_table *lut;
+	u32 lut_num;
+	u32 dbr_buf_size;
+	u32 dbr_num_bufs;
+	u32 max_mu_users;
+	/* Protect for lut entries */
+	spinlock_t lut_lock;
+	u64 tx_evt_cnt;
+	u64 dbr_evt_cnt;
+	u64 total_tx_evt_cnt;
+	u64 release_cnt;
+	u64 tx_peer_status_cfr_fail;
+	u64 tx_evt_status_cfr_fail;
+	u64 tx_dbr_lookup_fail;
+	u64 last_success_tstamp;
+	u64 flush_dbr_cnt;
+	u64 invalid_dma_length_cnt;
+	u64 clear_txrx_event;
+	u64 cfr_dma_aborts;
+	u64 flush_timeout_dbr_cnt;
+};
+
+#ifdef CONFIG_ATH11K_CFR
+int ath11k_cfr_init(struct ath11k_base *ab);
+void ath11k_cfr_deinit(struct ath11k_base *ab);
+void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
+				 u32 buf_id);
+#else
+static inline int ath11k_cfr_init(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_cfr_deinit(struct ath11k_base *ab)
+{
+}
+
+static inline void ath11k_cfr_lut_update_paddr(struct ath11k *ar,
+					       dma_addr_t paddr, u32 buf_id)
+{
+}
+#endif /* CONFIG_ATH11K_CFR */
+#endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7c508e9..0d75e88 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -99,6 +99,11 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.cfr_support = true,
+		.cfr_dma_hdr_size = sizeof(struct ath11k_cfir_dma_hdr),
+		.cfr_num_stream_bufs = 255,
+		/* csi_cfr_header + cfr header + max cfr payload */
+		.cfr_stream_buf_size = 8200,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -164,6 +169,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.cfr_support = false,
+		.cfr_dma_hdr_size = 0,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -228,6 +237,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.cfr_support = false,
+		.cfr_dma_hdr_size = 0,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -292,6 +305,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.cfr_support = false,
+		.cfr_dma_hdr_size = 0,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -356,6 +373,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.cfr_support = false,
+		.cfr_dma_hdr_size = 0,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -419,6 +440,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.cfr_support = false,
+		.cfr_dma_hdr_size = 0,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
 	},
 };
 
@@ -922,8 +947,16 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 		goto err_thermal_unregister;
 	}
 
+	ret = ath11k_cfr_init(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init cfr %d\n", ret);
+		goto err_spectral_unregister;
+	}
+
 	return 0;
 
+err_spectral_unregister:
+	ath11k_spectral_deinit(ab);
 err_thermal_unregister:
 	ath11k_thermal_unregister(ab);
 err_dp_pdev_free:
@@ -938,6 +971,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
@@ -1161,6 +1195,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	ath11k_thermal_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
+	ath11k_cfr_deinit(ab);
 	ath11k_spectral_deinit(ab);
 	ath11k_hif_stop(ab);
 	ath11k_wmi_detach(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 10846e9..3cf026c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 
 #ifndef ATH11K_CORE_H
@@ -23,6 +24,7 @@
 #include "thermal.h"
 #include "dbring.h"
 #include "spectral.h"
+#include "cfr.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -612,6 +614,10 @@ struct ath11k {
 	bool regdom_set_by_user;
 	int hw_rate_code;
 	u8 twt_enabled;
+#ifdef CONFIG_ATH11K_CFR
+	struct ath11k_cfr cfr;
+#endif
+	bool cfr_enabled;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index eda67eb..1dea4a5 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 
 #include "core.h"
@@ -35,9 +36,10 @@ static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
 		*temp++ = ATH11K_DB_MAGIC_VALUE;
 }
 
-static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
-					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff)
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -77,6 +79,9 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 		goto err_idr_remove;
 	}
 
+	if (id == WMI_DIRECT_BUF_CFR)
+		ath11k_cfr_lut_update_paddr(ar, paddr, buf_id);
+
 	buff->paddr = paddr;
 
 	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, ar->pdev_idx) |
@@ -101,7 +106,8 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 }
 
 static int ath11k_dbring_fill_bufs(struct ath11k *ar,
-				   struct ath11k_dbring *ring)
+				   struct ath11k_dbring *ring,
+				   enum wmi_direct_buffer_module id)
 {
 	struct ath11k_dbring_element *buff;
 	struct hal_srng *srng;
@@ -129,7 +135,7 @@ static int ath11k_dbring_fill_bufs(struct ath11k *ar,
 			kfree(buff);
 			break;
 		}
-		ret = ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ret = ath11k_dbring_bufs_replenish(ar, ring, buff, id);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
 				    num_remain, req_entries);
@@ -210,7 +216,7 @@ int ath11k_dbring_buf_setup(struct ath11k *ar,
 	ring->hp_addr = ath11k_hal_srng_get_hp_addr(ar->ab, srng);
 	ring->tp_addr = ath11k_hal_srng_get_tp_addr(ar->ab, srng);
 
-	ret = ath11k_dbring_fill_bufs(ar, ring);
+	ret = ath11k_dbring_fill_bufs(ar, ring, db_cap->id);
 
 	return ret;
 }
@@ -270,7 +276,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	struct ath11k_buffer_addr desc;
 	u8 *vaddr_unalign;
 	u32 num_entry, num_buff_reaped;
-	u8 pdev_idx, rbm;
+	u8 pdev_idx, rbm, module_id;
 	u32 cookie;
 	int buf_id;
 	int size;
@@ -278,6 +284,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	int ret = 0;
 
 	pdev_idx = ev->fixed.pdev_id;
+	module_id = ev->fixed.module_id;
 
 	if (pdev_idx >= ab->num_radios) {
 		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
@@ -357,7 +364,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 
 		buff->paddr = 0;
 		memset(buff->payload, 0, size);
-		ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ath11k_dbring_bufs_replenish(ar, ring, buff, module_id);
 	}
 
 	spin_unlock_bh(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
index ef906c6..0c3683a 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.h
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 
 #ifndef ATH11K_DBRING_H
@@ -60,6 +61,10 @@ int ath11k_dbring_set_cfg(struct ath11k *ar,
 			  u32 event_timeout_ms,
 			  int (*handler)(struct ath11k *,
 					 struct ath11k_dbring_data *));
+int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+				 struct ath11k_dbring *ring,
+				 struct ath11k_dbring_element *buff,
+				 enum wmi_direct_buffer_module id);
 int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				struct ath11k_dbring *ring,
 				enum wmi_direct_buffer_module id);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 2ec09ae..d2f0472 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -181,7 +182,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	},
 	{ /* RXDMA DIR BUF */
 		.start_ring_id = HAL_SRNG_RING_ID_RXDMA_DIR_BUF,
-		.max_rings = 1,
+		.max_rings = 2,
 		.entry_size = 8 >> 2, /* TODO: Define the struct */
 		.lmac_ring = true,
 		.ring_dir = HAL_SRNG_DIR_SRC,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c10e1a0..610c868 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 
 #ifndef ATH11K_HW_H
@@ -193,6 +194,10 @@ struct ath11k_hw_params {
 	bool supports_rssi_stats;
 	bool fw_wmi_diag_event;
 	bool current_cc_support;
+	bool cfr_support;
+	u32 cfr_dma_hdr_size;
+	u32 cfr_num_stream_bufs;
+	u32 cfr_stream_buf_size;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 587f423..72e2e20 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 
 #ifndef ATH11K_WMI_H
@@ -951,6 +952,7 @@ enum wmi_tlv_pdev_param {
 	WMI_PDEV_PARAM_RADIO_CHAN_STATS_ENABLE,
 	WMI_PDEV_PARAM_RADIO_DIAGNOSIS_ENABLE,
 	WMI_PDEV_PARAM_MESH_MCAST_ENABLE,
+	WMI_PDEV_PARAM_PER_PEER_CFR_ENABLE = 0xa8,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD = 0xbc,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC = 0xbe,
 	WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT = 0xc6,
-- 
2.7.4

