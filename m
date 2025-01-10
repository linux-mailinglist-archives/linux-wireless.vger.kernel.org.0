Return-Path: <linux-wireless+bounces-17291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B788A08818
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD82D1884101
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C553207A20;
	Fri, 10 Jan 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Le059sKt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8E207A1C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489576; cv=none; b=M2NDiqI2Ir9FVlSO0vXPqzjEiYYtWqnbsCv74/vcjfQ+nOua7vpNEaYs4NBWoFaMwAEFO8mHU6CJqoe0tUksZdAH0ktH0cuq6N5v5NIM9I/Mz0OLEkFrYRa2AuI9QcD1zbdEcBXxJ33KFJlIqTROlM6wICUrLYrHu9Pql6s3xS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489576; c=relaxed/simple;
	bh=qhpuPn/mgL/Gm+JFNN+n74ph3dYOA3+AITaBVt+U2No=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCINR/1A0F2NhpKAXxnfjrvPC9gbxWCrHize+IYP2e0pKzONLMwqVpManNjgpWX4pZJyB7+PxX2AHFgxyMPSE8PhJAnq70EDiAMeGLX/paVHmPF8Z8TDCnKJy4/T7GVVwp60OFxTY/wGV5TIpVJb0ffhjY2oVsFca/6G1GYGdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Le059sKt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A2hXtG016209;
	Fri, 10 Jan 2025 06:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TyDCANmGpZFVnx2SEC5M2Rs6uuP2OBNp73K1NX9LMnc=; b=Le059sKtPEuFO01v
	LO/POZSjhLBJKCz21l71QGZGlaGrAi0Kl5H1FqJHBxnaWRzRatvKbzI+4jer7sIp
	gp4FWN9410uj6/O72yd5xPNS0a163BozKoVcURJazvgfbDyuFwNFUjl7/jZa3ONY
	hwY5LVzJ+jk32/UCMpKlaDf51pkFf01MvpJa6cgy7shJm6X7XoXbRqteybfAjI+l
	w+1as/NPWFwgHvI6HAO5Iq8L8lY9MQT8p4an/qjsyMvlFYQq5tK0K4BpTmk4nRlF
	KLdRMRmFDZmZ4brR+BHTnvF7AFGhj1kND14DjYngPtmdiQ47bNOToQsMuXzlUmjT
	gGlQ3g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442u14gdch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A6CmBg012794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:49 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 22:12:47 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v7 3/5] wifi: ath12k: add factory test mode support
Date: Fri, 10 Jan 2025 11:42:22 +0530
Message-ID: <20250110061224.1839547-4-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
References: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LyN8AE9c7bxGFOwA2pjTUZvrSACiQqhj
X-Proofpoint-GUID: LyN8AE9c7bxGFOwA2pjTUZvrSACiQqhj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100049

Add support to process factory test mode commands(FTM) for calibration.
By default firmware start with MISSION mode and to process the FTM commands
firmware needs to be restarted in FTM mode using module parameter ftm_mode.
The pre-request is all the radios should be down before starting the test.

All ath12k test mode interface related commands specified in enum
ath_tm_cmd.

When start command ATH_TM_CMD_TESTMODE_START is received, ar state
is set to test Mode and FTM daemon sends test mode command to wifi
driver via cfg80211. Wifi driver sends these command to firmware as
wmi events. If it is segmented commands it will be broken down into
multiple segments and encoded with TLV header else it is sent to
firmware as it is.

Firmware response via UTF events, wifi driver creates skb and send
to cfg80211, cfg80211 sends firmware response to FTM daemon via
netlink message.

Command to boot in ftm mode
insmod ath12k ftm_mode=1

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile   |   1 +
 drivers/net/wireless/ath/ath12k/core.c     |  24 +-
 drivers/net/wireless/ath/ath12k/core.h     |  13 +-
 drivers/net/wireless/ath/ath12k/debug.h    |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c       |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c      |  17 +-
 drivers/net/wireless/ath/ath12k/pci.c      |   3 +-
 drivers/net/wireless/ath/ath12k/testmode.c | 387 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/testmode.h |  40 +++
 drivers/net/wireless/ath/ath12k/wmi.c      |  37 +-
 drivers/net/wireless/ath/ath12k/wmi.h      |  20 ++
 drivers/net/wireless/ath/ath12k/wow.c      |   3 +-
 12 files changed, 538 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index b5bb3e2599cd..4a7f5e87384c 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -28,6 +28,7 @@ ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 ath12k-$(CONFIG_PM) += wow.o
 ath12k-$(CONFIG_ATH12K_COREDUMP) += coredump.o
+ath12k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0c6b35aac96e..d0cf82ca6dae 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -23,6 +23,10 @@ unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
+bool ath12k_ftm_mode;
+module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
+MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
+
 /* protected with ath12k_hw_group_mutex */
 static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
 
@@ -693,6 +697,11 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 {
 	int ret;
 
+	if (ath12k_ftm_mode) {
+		ab->fw_mode = ATH12K_FIRMWARE_MODE_FTM;
+		ath12k_info(ab, "Booting in ftm mode\n");
+	}
+
 	ret = ath12k_qmi_init_service(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to initialize qmi :%d\n", ret);
@@ -741,8 +750,7 @@ static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 	ath12k_dp_pdev_free(ab);
 }
 
-static int ath12k_core_start(struct ath12k_base *ab,
-			     enum ath12k_firmware_mode mode)
+static int ath12k_core_start(struct ath12k_base *ab)
 {
 	int ret;
 
@@ -1068,7 +1076,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	struct ath12k_hw_group *ag = ath12k_ab_to_ag(ab);
 	int ret, i;
 
-	ret = ath12k_core_start_firmware(ab, ATH12K_FIRMWARE_MODE_NORMAL);
+	ret = ath12k_core_start_firmware(ab, ab->fw_mode);
 	if (ret) {
 		ath12k_err(ab, "failed to start firmware: %d\n", ret);
 		return ret;
@@ -1089,7 +1097,7 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	mutex_lock(&ag->mutex);
 	mutex_lock(&ab->core_lock);
 
-	ret = ath12k_core_start(ab, ATH12K_FIRMWARE_MODE_NORMAL);
+	ret = ath12k_core_start(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to start core: %d\n", ret);
 		goto err_dp_free;
@@ -1237,7 +1245,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 
 	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
-		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
+		if (!ah || ah->state == ATH12K_HW_STATE_OFF ||
+		    ah->state == ATH12K_HW_STATE_TM)
 			continue;
 
 		ieee80211_stop_queues(ah->hw);
@@ -1306,6 +1315,9 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 			ath12k_warn(ab,
 				    "device is wedged, will not restart hw %d\n", i);
 			break;
+		case ATH12K_HW_STATE_TM:
+			ath12k_warn(ab, "fw mode reset done radio %d\n", i);
+			break;
 		}
 
 		mutex_unlock(&ah->hw_mutex);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3dd01ad100c5..78a59ab77012 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CORE_H
@@ -235,6 +235,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+	ATH12K_FLAG_FTM_SEGMENTED,
 };
 
 struct ath12k_tx_conf {
@@ -534,12 +535,19 @@ enum ath12k_hw_state {
 	ATH12K_HW_STATE_RESTARTING,
 	ATH12K_HW_STATE_RESTARTED,
 	ATH12K_HW_STATE_WEDGED,
+	ATH12K_HW_STATE_TM,
 	/* Add other states as required */
 };
 
 /* Antenna noise floor */
 #define ATH12K_DEFAULT_NOISE_FLOOR -95
 
+struct ath12k_ftm_event_obj {
+	u32 data_pos;
+	u32 expected_seq;
+	u8 *eventdata;
+};
+
 struct ath12k_fw_stats {
 	u32 pdev_id;
 	u32 stats_id;
@@ -714,6 +722,7 @@ struct ath12k {
 
 	struct completion mlo_setup_done;
 	u32 mlo_setup_status;
+	u8 ftm_msgref;
 };
 
 struct ath12k_hw {
@@ -873,6 +882,7 @@ struct ath12k_wsi_info {
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
+	enum ath12k_firmware_mode fw_mode;
 	struct platform_device *pdev;
 	struct device *dev;
 	struct ath12k_qmi qmi;
@@ -986,6 +996,7 @@ struct ath12k_base {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
 	} stats;
+	struct ath12k_ftm_event_obj ftm_event_obj;
 	u32 pktlog_defs_checksum;
 
 	struct ath12k_dbring_cap *db_caps;
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index 90e801136bc6..0aa7c8ccb14c 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH12K_DEBUG_H_
@@ -37,6 +37,7 @@ __printf(2, 3) void __ath12k_warn(struct device *dev, const char *fmt, ...);
 #define ath12k_hw_warn(ah, fmt, ...) __ath12k_warn((ah)->dev, fmt, ##__VA_ARGS__)
 
 extern unsigned int ath12k_debug_mask;
+extern bool ath12k_ftm_mode;
 
 #ifdef CONFIG_ATH12K_DEBUG
 __printf(3, 4) void __ath12k_dbg(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9e5a4e75f2f6..b1f27c3ac723 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -1315,6 +1315,9 @@ void ath12k_dp_cc_config(struct ath12k_base *ab)
 	u32 wbm_base = HAL_SEQ_WCSS_UMAC_WBM_REG;
 	u32 val = 0;
 
+	if (ath12k_ftm_mode)
+		return;
+
 	ath12k_hif_write32(ab, reo_base + HAL_REO1_SW_COOKIE_CFG0(ab), cmem_base);
 
 	val |= u32_encode_bits(ATH12K_CMEM_ADDR_MSB,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 48d110e2a7de..6e729f12b058 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -15,6 +15,7 @@
 #include "hw.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
+#include "testmode.h"
 #include "peer.h"
 #include "debugfs.h"
 #include "hif.h"
@@ -675,7 +676,10 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
 		return NULL;
 
 	for (i = 0; i < ab->num_radios; i++) {
-		pdev = rcu_dereference(ab->pdevs_active[i]);
+		if (ab->fw_mode == ATH12K_FIRMWARE_MODE_FTM)
+			pdev = &ab->pdevs[i];
+		else
+			pdev = rcu_dereference(ab->pdevs_active[i]);
 
 		if (pdev && pdev->pdev_id == pdev_id)
 			return (pdev->ar ? pdev->ar : NULL);
@@ -7357,9 +7361,14 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 static void ath12k_drain_tx(struct ath12k_hw *ah)
 {
-	struct ath12k *ar;
+	struct ath12k *ar = ah->radio;
 	int i;
 
+	if (ath12k_ftm_mode) {
+		ath12k_err(ar->ab, "fail to start mac operations in ftm mode\n");
+		return;
+	}
+
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
 	for_each_ar(ah, ar, i)
@@ -7388,6 +7397,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	case ATH12K_HW_STATE_RESTARTED:
 	case ATH12K_HW_STATE_WEDGED:
 	case ATH12K_HW_STATE_ON:
+	case ATH12K_HW_STATE_TM:
 		ah->state = ATH12K_HW_STATE_OFF;
 
 		WARN_ON(1);
@@ -10293,6 +10303,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.resume				= ath12k_wow_op_resume,
 	.set_wakeup			= ath12k_wow_op_set_wakeup,
 #endif
+	CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 06cff3849ab8..4a50d7118b3e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1561,6 +1561,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ab_pci->ab = ab;
 	ab_pci->pdev = pdev;
 	ab->hif.ops = &ath12k_pci_hif_ops;
+	ab->fw_mode = ATH12K_FIRMWARE_MODE_NORMAL;
 	pci_set_drvdata(pdev, ab);
 	spin_lock_init(&ab_pci->window_lock);
 
diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
new file mode 100644
index 000000000000..71fc4fb4274f
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "testmode.h"
+#include <net/netlink.h>
+#include "debug.h"
+#include "wmi.h"
+#include "hw.h"
+#include "core.h"
+#include "hif.h"
+#include "../testmode_i.h"
+
+#define ATH12K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
+#define ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
+
+static const struct nla_policy ath12k_tm_policy[ATH_TM_ATTR_MAX + 1] = {
+	[ATH_TM_ATTR_CMD]		= { .type = NLA_U32 },
+	[ATH_TM_ATTR_DATA]		= { .type = NLA_BINARY,
+					    .len = ATH_TM_DATA_MAX_LEN },
+	[ATH_TM_ATTR_WMI_CMDID]		= { .type = NLA_U32 },
+	[ATH_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
+	[ATH_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
+};
+
+static struct ath12k *ath12k_tm_get_ar(struct ath12k_base *ab)
+{
+	struct ath12k_pdev *pdev;
+	struct ath12k *ar;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		if (ar && ar->ah->state == ATH12K_HW_STATE_TM)
+			return ar;
+	}
+
+	return NULL;
+}
+
+void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
+				     struct sk_buff *skb)
+{
+	struct sk_buff *nl_skb;
+	struct ath12k *ar;
+
+	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d skb length %d\n",
+		   cmd_id, skb->len);
+
+	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
+
+	ar = ath12k_tm_get_ar(ab);
+	if (!ar) {
+		ath12k_warn(ab, "testmode event not handled due to invalid pdev\n");
+		return;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->ah->hw->wiphy,
+						   2 * nla_total_size(sizeof(u32)) +
+						   nla_total_size(skb->len),
+						   GFP_ATOMIC);
+	spin_unlock_bh(&ar->data_lock);
+
+	if (!nl_skb) {
+		ath12k_warn(ab,
+			    "failed to allocate skb for unsegmented testmode wmi event\n");
+		return;
+	}
+
+	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD, ATH_TM_CMD_WMI) ||
+	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH_TM_ATTR_DATA, skb->len, skb->data)) {
+		ath12k_warn(ab, "failed to populate testmode unsegmented event\n");
+		kfree_skb(nl_skb);
+		return;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+}
+
+void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
+			     const struct ath12k_wmi_ftm_event *ftm_msg,
+			     u16 length)
+{
+	struct sk_buff *nl_skb;
+	struct ath12k *ar;
+	u32 data_pos, pdev_id;
+	u16 datalen;
+	u8 total_segments, current_seq;
+	u8 const *buf_pos;
+
+	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   cmd_id, ftm_msg, length);
+	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", ftm_msg, length);
+	pdev_id = DP_HW2SW_MACID(le32_to_cpu(ftm_msg->seg_hdr.pdev_id));
+
+	if (pdev_id >= ab->num_radios) {
+		ath12k_warn(ab, "testmode event not handled due to invalid pdev id\n");
+		return;
+	}
+
+	ar = ab->pdevs[pdev_id].ar;
+
+	if (!ar) {
+		ath12k_warn(ab, "testmode event not handled due to absence of pdev\n");
+		return;
+	}
+
+	current_seq = le32_get_bits(ftm_msg->seg_hdr.segmentinfo,
+				    ATH12K_FTM_SEGHDR_CURRENT_SEQ);
+	total_segments = le32_get_bits(ftm_msg->seg_hdr.segmentinfo,
+				       ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS);
+	datalen = length - (sizeof(struct ath12k_wmi_ftm_seg_hdr_params));
+	buf_pos = ftm_msg->data;
+
+	if (current_seq == 0) {
+		ab->ftm_event_obj.expected_seq = 0;
+		ab->ftm_event_obj.data_pos = 0;
+	}
+
+	data_pos = ab->ftm_event_obj.data_pos;
+
+	if ((data_pos + datalen) > ATH_FTM_EVENT_MAX_BUF_LENGTH) {
+		ath12k_warn(ab,
+			    "Invalid event length date_pos[%d] datalen[%d]\n",
+			    data_pos, datalen);
+		return;
+	}
+
+	memcpy(&ab->ftm_event_obj.eventdata[data_pos], buf_pos, datalen);
+	data_pos += datalen;
+
+	if (++ab->ftm_event_obj.expected_seq != total_segments) {
+		ab->ftm_event_obj.data_pos = data_pos;
+		ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
+			   "partial data received current_seq[%d], total_seg[%d]\n",
+			    current_seq, total_segments);
+		return;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
+		   "total data length[%d] = [%d]\n",
+		   data_pos, ftm_msg->seg_hdr.len);
+
+	spin_lock_bh(&ar->data_lock);
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->ah->hw->wiphy,
+						   2 * nla_total_size(sizeof(u32)) +
+						   nla_total_size(data_pos),
+						   GFP_ATOMIC);
+	spin_unlock_bh(&ar->data_lock);
+
+	if (!nl_skb) {
+		ath12k_warn(ab,
+			    "failed to allocate skb for testmode wmi event\n");
+		return;
+	}
+
+	if (nla_put_u32(nl_skb, ATH_TM_ATTR_CMD,
+			ATH_TM_CMD_WMI_FTM) ||
+	    nla_put_u32(nl_skb, ATH_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH_TM_ATTR_DATA, data_pos,
+		    &ab->ftm_event_obj.eventdata[0])) {
+		ath12k_warn(ab, "failed to populate testmode event");
+		kfree_skb(nl_skb);
+		return;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+}
+
+static int ath12k_tm_cmd_get_version(struct ath12k *ar, struct nlattr *tb[])
+{
+	struct sk_buff *skb;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
+		   "testmode cmd get version_major %d version_minor %d\n",
+		   ATH_TESTMODE_VERSION_MAJOR,
+		   ATH_TESTMODE_VERSION_MINOR);
+
+	spin_lock_bh(&ar->data_lock);
+	skb = cfg80211_testmode_alloc_reply_skb(ar->ah->hw->wiphy,
+						2 * nla_total_size(sizeof(u32)));
+	spin_unlock_bh(&ar->data_lock);
+
+	if (!skb)
+		return -ENOMEM;
+
+	if (nla_put_u32(skb, ATH_TM_ATTR_VERSION_MAJOR,
+			ATH_TESTMODE_VERSION_MAJOR) ||
+	    nla_put_u32(skb, ATH_TM_ATTR_VERSION_MINOR,
+			ATH_TESTMODE_VERSION_MINOR)) {
+		kfree_skb(skb);
+		return -ENOBUFS;
+	}
+
+	return cfg80211_testmode_reply(skb);
+}
+
+static int ath12k_tm_cmd_process_ftm(struct ath12k *ar, struct nlattr *tb[])
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct sk_buff *skb;
+	struct ath12k_wmi_ftm_cmd *ftm_cmd;
+	int ret = 0;
+	void *buf;
+	size_t aligned_len;
+	u32 cmd_id, buf_len;
+	u16 chunk_len, total_bytes, num_segments;
+	u8 segnumber = 0, *bufpos;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE, "ah->state  %d\n", ar->ah->state);
+	if (ar->ah->state != ATH12K_HW_STATE_TM)
+		return -ENETDOWN;
+
+	if (!tb[ATH_TM_ATTR_DATA])
+		return -EINVAL;
+
+	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
+	cmd_id = WMI_PDEV_UTF_CMDID;
+	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
+		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
+		   cmd_id, buf, buf_len);
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
+	bufpos = buf;
+	total_bytes = buf_len;
+	num_segments = total_bytes / MAX_WMI_UTF_LEN;
+
+	if (buf_len - (num_segments * MAX_WMI_UTF_LEN))
+		num_segments++;
+
+	while (buf_len) {
+		if (buf_len > MAX_WMI_UTF_LEN)
+			chunk_len = MAX_WMI_UTF_LEN;    /* MAX message */
+		else
+			chunk_len = buf_len;
+
+		skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, (chunk_len +
+					sizeof(struct ath12k_wmi_ftm_cmd)));
+
+		if (!skb)
+			return -ENOMEM;
+
+		ftm_cmd = (struct ath12k_wmi_ftm_cmd *)skb->data;
+		aligned_len  = chunk_len + sizeof(struct ath12k_wmi_ftm_seg_hdr_params);
+		ftm_cmd->tlv_header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, aligned_len);
+		ftm_cmd->seg_hdr.len = cpu_to_le32(total_bytes);
+		ftm_cmd->seg_hdr.msgref = cpu_to_le32(ar->ftm_msgref);
+		ftm_cmd->seg_hdr.segmentinfo =
+			le32_encode_bits(num_segments,
+					 ATH12K_FTM_SEGHDR_TOTAL_SEGMENTS) |
+			le32_encode_bits(segnumber,
+					 ATH12K_FTM_SEGHDR_CURRENT_SEQ);
+		segnumber++;
+		memcpy(&ftm_cmd->data, bufpos, chunk_len);
+		ret = ath12k_wmi_cmd_send(wmi, skb, cmd_id);
+
+		if (ret) {
+			ath12k_warn(ar->ab, "ftm wmi command fail: %d\n", ret);
+			kfree_skb(skb);
+			return ret;
+		}
+
+		buf_len -= chunk_len;
+		bufpos += chunk_len;
+	}
+
+	++ar->ftm_msgref;
+	return ret;
+}
+
+static int ath12k_tm_cmd_testmode_start(struct ath12k *ar, struct nlattr *tb[])
+{
+	if (ar->ah->state == ATH12K_HW_STATE_TM)
+		return -EALREADY;
+
+	if (ar->ah->state != ATH12K_HW_STATE_OFF)
+		return -EBUSY;
+
+	ar->ab->ftm_event_obj.eventdata = kzalloc(ATH_FTM_EVENT_MAX_BUF_LENGTH,
+						  GFP_KERNEL);
+
+	if (!ar->ab->ftm_event_obj.eventdata)
+		return -ENOMEM;
+
+	ar->ah->state = ATH12K_HW_STATE_TM;
+	ar->ftm_msgref = 0;
+	return 0;
+}
+
+static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct sk_buff *skb;
+	u32 cmd_id, buf_len;
+	int ret = 0;
+	void *buf;
+
+	if (!tb[ATH_TM_ATTR_DATA])
+		return -EINVAL;
+
+	if (!tb[ATH_TM_ATTR_WMI_CMDID])
+		return -EINVAL;
+
+	buf = nla_data(tb[ATH_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
+
+	if (!buf_len) {
+		ath12k_warn(ar->ab, "No data present in testmode command\n");
+		return -EINVAL;
+	}
+
+	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
+		   "testmode cmd wmi cmd_id %d  buf length %d\n",
+		   cmd_id, buf_len);
+
+	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
+
+	if (!skb)
+		return -ENOMEM;
+
+	memcpy(skb->data, buf, buf_len);
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, cmd_id);
+	if (ret) {
+		dev_kfree_skb(skb);
+		ath12k_warn(ar->ab, "failed to transmit wmi command (testmode): %d\n",
+			    ret);
+	}
+
+	return ret;
+}
+
+int ath12k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len)
+{
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k *ar = NULL;
+	struct nlattr *tb[ATH_TM_ATTR_MAX + 1];
+	struct ath12k_base *ab;
+	struct wiphy *wiphy = hw->wiphy;
+	int ret;
+
+	lockdep_assert_held(&wiphy->mtx);
+
+	ret = nla_parse(tb, ATH_TM_ATTR_MAX, data, len, ath12k_tm_policy,
+			NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[ATH_TM_ATTR_CMD])
+		return -EINVAL;
+
+	/* TODO: have to handle ar for MLO case */
+	if (ah->num_radio)
+		ar = ah->radio;
+
+	if (!ar)
+		return -EINVAL;
+
+	ab = ar->ab;
+	switch (nla_get_u32(tb[ATH_TM_ATTR_CMD])) {
+	case ATH_TM_CMD_WMI:
+		return ath12k_tm_cmd_wmi(ar, tb);
+	case ATH_TM_CMD_TESTMODE_START:
+		return ath12k_tm_cmd_testmode_start(ar, tb);
+	case ATH_TM_CMD_GET_VERSION:
+		return ath12k_tm_cmd_get_version(ar, tb);
+	case ATH_TM_CMD_WMI_FTM:
+		set_bit(ATH12K_FLAG_FTM_SEGMENTED, &ab->dev_flags);
+		return ath12k_tm_cmd_process_ftm(ar, tb);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/testmode.h b/drivers/net/wireless/ath/ath12k/testmode.h
new file mode 100644
index 000000000000..ef6ab21d19b8
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/testmode.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+#include "hif.h"
+
+#ifdef CONFIG_NL80211_TESTMODE
+
+void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
+				     struct sk_buff *skb);
+void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
+			     const struct ath12k_wmi_ftm_event *ftm_msg,
+			     u16 length);
+int ath12k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len);
+
+#else
+
+static inline void ath12k_tm_wmi_event_unsegmented(struct ath12k_base *ab, u32 cmd_id,
+						   struct sk_buff *skb)
+{
+}
+
+static inline void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
+					   const struct ath12k_wmi_ftm_event *msg,
+					   u16 length)
+{
+}
+
+static inline int ath12k_tm_cmd(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				void *data, int len)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 246b8aab49a9..a7625a3d1a3a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -20,6 +20,7 @@
 #include "hw.h"
 #include "peer.h"
 #include "p2p.h"
+#include "testmode.h"
 
 struct ath12k_wmi_svc_ready_parse {
 	bool wmi_svc_bitmap_done;
@@ -6997,6 +6998,35 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	kfree(tb);
 }
 
+static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
+					  struct sk_buff *skb)
+{
+	const struct ath12k_wmi_ftm_event *ev;
+	const void **tb;
+	int ret;
+	u16 length;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse ftm event tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_ARRAY_BYTE];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch ftm msg\n");
+		kfree(tb);
+		return;
+	}
+
+	length = skb->len - TLV_HDR_SIZE;
+	ath12k_tm_process_event(ab, cmd_id, ev, length);
+	kfree(tb);
+	tb = NULL;
+}
+
 static void
 ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 				  struct sk_buff *skb)
@@ -7555,7 +7585,12 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
 		/* debug might flood hence silently ignore (no-op) */
 		break;
-	/* TODO: Add remaining events */
+	case WMI_PDEV_UTF_EVENTID:
+		if (test_bit(ATH12K_FLAG_FTM_SEGMENTED, &ab->dev_flags))
+			ath12k_tm_wmi_event_segmented(ab, id, skb);
+		else
+			ath12k_tm_wmi_event_unsegmented(ab, id, skb);
+		break;
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 00d024d4eb2c..38aed18b99f4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3624,6 +3624,26 @@ struct ath12k_wmi_p2p_noa_info {
 	struct ath12k_wmi_p2p_noa_descriptor descriptors[WMI_P2P_MAX_NOA_DESCRIPTORS];
 } __packed;
 
+#define MAX_WMI_UTF_LEN 252
+
+struct ath12k_wmi_ftm_seg_hdr_params {
+	__le32 len;
+	__le32 msgref;
+	__le32 segmentinfo;
+	__le32 pdev_id;
+} __packed;
+
+struct ath12k_wmi_ftm_cmd {
+	__le32 tlv_header;
+	struct ath12k_wmi_ftm_seg_hdr_params seg_hdr;
+	u8 data[];
+} __packed;
+
+struct ath12k_wmi_ftm_event {
+	struct ath12k_wmi_ftm_seg_hdr_params seg_hdr;
+	u8 data[];
+} __packed;
+
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
 #define WMI_EMA_BEACON_CNT      GENMASK(7, 0)
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 9e1c0bfd212f..dce9bd0bcaef 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -990,6 +990,7 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 		case ATH12K_HW_STATE_RESTARTING:
 		case ATH12K_HW_STATE_RESTARTED:
 		case ATH12K_HW_STATE_WEDGED:
+		case ATH12K_HW_STATE_TM:
 			ath12k_warn(ar->ab, "encountered unexpected device state %d on resume, cannot recover\n",
 				    ah->state);
 			ret = -EIO;
-- 
2.34.1


