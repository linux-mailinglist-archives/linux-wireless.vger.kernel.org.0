Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0715706A61
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEQOAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEQOAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 10:00:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2C59DA
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 07:00:10 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HDQNbo001920;
        Wed, 17 May 2023 14:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FJz1PPaowKL1wxOSc0c6h/0BvK3H6mTdJ0d+zGdA9yQ=;
 b=lLXeWIwqfQyzQIhJyUv87Ym8AzIOAyD6KydTcIfC5Ue6ZGynCQhLyzj8GzbHlDr6xndz
 tRs02yFpkfAVqPtSD5Uv96AIX1mJ3JUxbFwhyYtjoUo6RzEeWrYp47GeGCUPXCs46sTM
 CrX26/1TeMeK2+bmP+zQCjlbUjhgelVbDUSXq4eo4w8/rFZhTq5EpWHuseyyNEbX0lxz
 FqwomE+N8jJiVgOdsPXY+W3Ffycmi86FtQ3a44oCfjPfL7lF80NyNaViK/wnHR1vkFah
 UwzV7gOd09gweuSA1kqgwzGseqHRIRV8uznwCXLH4qya2nveBlj/8HHEwyDb0PQYxzzg 3w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmcc62ea7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HE05SZ016898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:05 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 07:00:03 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH v4 3/4] wifi: ath11k: factory test mode support
Date:   Wed, 17 May 2023 19:29:33 +0530
Message-ID: <20230517135934.16408-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
References: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wizr5-Qrni9pRiXO2W5Je8p-sQcsGybZ
X-Proofpoint-ORIG-GUID: Wizr5-Qrni9pRiXO2W5Je8p-sQcsGybZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>

Add support to process factory test mode commands(FTM) for calibration.
By default firmware start with NORMAL mode and to process the FTM commands
firmware needs to be restarted in FTM mode using module parameter ftm_mode.
The pre-request is all the radios should be down before starting the test.

When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
is set to Test Mode. If the FTM command or event length is greater
than 256 bytes, it will be broken down into multiple segments and
encoded with TLV header if it is segmented commands, else it is sent
to firmware as it is.

On receiving UTF event from firmware, if it is segmented event, the driver
will wait until it receives all the segments and notify the complete
data to user application. In case the segmented sequence are missed or
lost from the firmware, driver will skip the already received partial data.

In case of unsegmented UTF event from firmware, driver notifies the
data to the user application as it comes. Applications handles
the data further.

Command to boot in ftm mode:

insmod ath11k ftm_mode=1

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c        |   3 +-
 drivers/net/wireless/ath/ath11k/core.c       |  21 +-
 drivers/net/wireless/ath/ath11k/core.h       |  16 +-
 drivers/net/wireless/ath/ath11k/debug.h      |   1 +
 drivers/net/wireless/ath/ath11k/mac.c        |  11 +-
 drivers/net/wireless/ath/ath11k/pci.c        |   3 +-
 drivers/net/wireless/ath/ath11k/testmode.c   | 348 ++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/testmode.h   |   5 +
 drivers/net/wireless/ath/ath11k/testmode_i.h |  18 +-
 drivers/net/wireless/ath/ath11k/wmi.c        |  11 +-
 drivers/net/wireless/ath/ath11k/wmi.h        |  22 ++
 drivers/net/wireless/ath/ath11k/wow.c        |   3 +-
 12 files changed, 442 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 5cbba9a8b6ba..32911fa6e505 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1155,6 +1155,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ab->hif.ops = hif_ops;
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
+	ab->fw_mode = ATH11K_FIRMWARE_MODE_NORMAL;
 	platform_set_drvdata(pdev, ab);
 
 	ret = ath11k_pcic_register_pci_ops(ab, pci_ops);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b1b90bd34d67..618643cd1dce 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -32,6 +32,10 @@ module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
 MODULE_PARM_DESC(frame_mode,
 		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
 
+bool ath11k_ftm_mode;
+module_param_named(ftm_mode, ath11k_ftm_mode, bool, 0444);
+MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
+
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
@@ -1354,6 +1358,11 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 {
 	int ret;
 
+	if (ath11k_ftm_mode) {
+		ab->fw_mode = ATH11K_FIRMWARE_MODE_FTM;
+		ath11k_info(ab, "Booting in factory test mode\n");
+	}
+
 	ret = ath11k_qmi_init_service(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to initialize qmi :%d\n", ret);
@@ -1580,7 +1589,7 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
+	ret = ath11k_core_start_firmware(ab, ab->fw_mode);
 	if (ret) {
 		ath11k_err(ab, "failed to start firmware: %d\n", ret);
 		return ret;
@@ -1745,7 +1754,8 @@ void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
-		if (!ar || ar->state == ATH11K_STATE_OFF)
+		if (!ar || ar->state == ATH11K_STATE_OFF ||
+		    ar->state == ATH11K_STATE_FTM)
 			continue;
 
 		ieee80211_stop_queues(ar->hw);
@@ -1814,7 +1824,12 @@ static void ath11k_core_post_reconfigure_recovery(struct ath11k_base *ab)
 			ath11k_warn(ab,
 				    "device is wedged, will not restart radio %d\n", i);
 			break;
+		case ATH11K_STATE_FTM:
+			ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
+				   "fw mode reset done radio %d\n", i);
+			break;
 		}
+
 		mutex_unlock(&ar->conf_mutex);
 	}
 	complete(&ab->driver_recovery);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0830276e5028..9d15b4390b9c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -52,6 +52,7 @@
 #define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
 
 extern unsigned int ath11k_frame_mode;
+extern bool ath11k_ftm_mode;
 
 #define ATH11K_SCAN_TIMEOUT_HZ (20 * HZ)
 
@@ -277,6 +278,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_FIXED_MEM_RGN,
 	ATH11K_FLAG_DEVICE_INIT_DONE,
 	ATH11K_FLAG_MULTI_MSI_VECTORS,
+	ATH11K_FLAG_FTM_SEGMENTED,
 };
 
 enum ath11k_monitor_flags {
@@ -530,6 +532,7 @@ enum ath11k_state {
 	ATH11K_STATE_RESTARTING,
 	ATH11K_STATE_RESTARTED,
 	ATH11K_STATE_WEDGED,
+	ATH11K_STATE_FTM,
 	/* Add other states as required */
 };
 
@@ -709,6 +712,8 @@ struct ath11k {
 	u32 last_ppdu_id;
 	u32 cached_ppdu_id;
 	int monitor_vdev_id;
+	struct completion fw_mode_reset;
+	u8 ftm_msgref;
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct ath11k_debug debug;
 #endif
@@ -838,6 +843,7 @@ struct ath11k_msi_config {
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
+	enum ath11k_firmware_mode fw_mode;
 	struct platform_device *pdev;
 	struct device *dev;
 	struct ath11k_qmi qmi;
@@ -978,6 +984,14 @@ struct ath11k_base {
 		const struct ath11k_pci_ops *ops;
 	} pci;
 
+#ifdef CONFIG_NL80211_TESTMODE
+	struct {
+		u32 data_pos;
+		u32 expected_seq;
+		u8 *eventdata;
+	} testmode;
+#endif
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 91545640c47b..621d85f3118c 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH11K_DEBUG_H_
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c947d1c8d8c1..a31b8e89684b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -643,7 +643,10 @@ struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id)
 		return NULL;
 
 	for (i = 0; i < ab->num_radios; i++) {
-		pdev = rcu_dereference(ab->pdevs_active[i]);
+		if (ab->fw_mode == ATH11K_FIRMWARE_MODE_FTM)
+			pdev = &ab->pdevs[i];
+		else
+			pdev = rcu_dereference(ab->pdevs_active[i]);
 
 		if (pdev && pdev->pdev_id == pdev_id)
 			return (pdev->ar ? pdev->ar : NULL);
@@ -6271,6 +6274,11 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	struct ath11k_pdev *pdev = ar->pdev;
 	int ret;
 
+	if (ath11k_ftm_mode) {
+		ath11k_warn(ab, "mac operations not supported in factory test mode\n");
+		return -EOPNOTSUPP;
+	}
+
 	ath11k_mac_drain_tx(ar);
 	mutex_lock(&ar->conf_mutex);
 
@@ -6285,6 +6293,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 	case ATH11K_STATE_RESTARTED:
 	case ATH11K_STATE_WEDGED:
 	case ATH11K_STATE_ON:
+	case ATH11K_STATE_FTM:
 		WARN_ON(1);
 		ret = -EINVAL;
 		goto err;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7b33731a50ee..5a779abe666b 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -745,6 +745,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ab_pci->ab = ab;
 	ab_pci->pdev = pdev;
 	ab->hif.ops = &ath11k_pci_hif_ops;
+	ab->fw_mode = ATH11K_FIRMWARE_MODE_NORMAL;
 	pci_set_drvdata(pdev, ab);
 	spin_lock_init(&ab_pci->window_lock);
 
diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index f562f860ebf3..9dbe88e0546b 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -12,6 +12,9 @@
 #include "core.h"
 #include "testmode_i.h"
 
+#define ATH11K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
+#define ATH11K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
+
 static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
 	[ATH11K_TM_ATTR_CMD]		= { .type = NLA_U32 },
 	[ATH11K_TM_ATTR_DATA]		= { .type = NLA_BINARY,
@@ -21,6 +24,210 @@ static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
 	[ATH11K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
 };
 
+static struct ath11k *ath11k_tm_get_ar(struct ath11k_base *ab)
+{
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar = NULL;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		if (ar && ar->state == ATH11K_STATE_FTM)
+			break;
+	}
+
+	return ar;
+}
+
+/* This function handles unsegmented events. Data in various events are aggregated
+ * in application layer, this event is unsegmented from host perspective.
+ */
+static void ath11k_tm_wmi_event_unsegmented(struct ath11k_base *ab, u32 cmd_id,
+					    struct sk_buff *skb)
+{
+	struct sk_buff *nl_skb;
+	struct ath11k *ar;
+
+	ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d skb length %d\n",
+		   cmd_id, skb->len);
+	ath11k_dbg_dump(ab, ATH11K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
+
+	ar = ath11k_tm_get_ar(ab);
+	if (!ar) {
+		ath11k_warn(ab, "testmode event not handled due to invalid pdev\n");
+		return;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
+						   2 * nla_total_size(sizeof(u32)) +
+						   nla_total_size(skb->len),
+						   GFP_ATOMIC);
+	if (!nl_skb) {
+		ath11k_warn(ab,
+			    "failed to allocate skb for unsegmented testmode wmi event\n");
+		goto out;
+	}
+
+	if (nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD, ATH11K_TM_CMD_WMI) ||
+	    nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH11K_TM_ATTR_DATA, skb->len, skb->data)) {
+		ath11k_warn(ab, "failed to populate testmode unsegmented event\n");
+		kfree_skb(nl_skb);
+		goto out;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+	spin_unlock_bh(&ar->data_lock);
+	return;
+
+out:
+	spin_unlock_bh(&ar->data_lock);
+	ath11k_warn(ab, "Failed to send testmode event to higher layers\n");
+}
+
+/* This function handles segmented events. Data of various events received
+ * from firmware is aggregated and sent to application layer
+ */
+static int ath11k_tm_process_event(struct ath11k_base *ab, u32 cmd_id,
+				   const struct wmi_ftm_event_msg *ftm_msg,
+				   u16 length)
+{
+	struct sk_buff *nl_skb;
+	int ret = 0;
+	struct ath11k *ar;
+	u8 const *buf_pos;
+	u16 datalen;
+	u8 total_segments, current_seq;
+	u32 data_pos;
+	u32 pdev_id;
+
+	ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   cmd_id, ftm_msg, length);
+	ath11k_dbg_dump(ab, ATH11K_DBG_TESTMODE, NULL, "", ftm_msg, length);
+	pdev_id = DP_HW2SW_MACID(ftm_msg->seg_hdr.pdev_id);
+
+	if (pdev_id >= ab->num_radios) {
+		ath11k_warn(ab, "testmode event not handled due to invalid pdev id: %d\n",
+			    pdev_id);
+		return -EINVAL;
+	}
+
+	ar = ab->pdevs[pdev_id].ar;
+	if (!ar) {
+		ath11k_warn(ab, "testmode event not handled due to absence of pdev\n");
+		return -ENODEV;
+	}
+
+	current_seq = FIELD_GET(ATH11K_FTM_SEGHDR_CURRENT_SEQ,
+				ftm_msg->seg_hdr.segmentinfo);
+	total_segments = FIELD_GET(ATH11K_FTM_SEGHDR_TOTAL_SEGMENTS,
+				   ftm_msg->seg_hdr.segmentinfo);
+	datalen = length - (sizeof(struct wmi_ftm_seg_hdr));
+	buf_pos = ftm_msg->data;
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (current_seq == 0) {
+		ab->testmode.expected_seq = 0;
+		ab->testmode.data_pos = 0;
+	}
+
+	data_pos = ab->testmode.data_pos;
+
+	if ((data_pos + datalen) > ATH11K_FTM_EVENT_MAX_BUF_LENGTH) {
+		ath11k_warn(ab, "Invalid ftm event length at %d: %d\n",
+			    data_pos, datalen);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&ab->testmode.eventdata[data_pos], buf_pos, datalen);
+	data_pos += datalen;
+
+	if (++ab->testmode.expected_seq != total_segments) {
+		ab->testmode.data_pos = data_pos;
+		ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
+			   "partial data received current_seq %d total_seg %d\n",
+			    current_seq, total_segments);
+		goto out;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_TESTMODE,
+		   "total data length pos %d len %d\n",
+		    data_pos, ftm_msg->seg_hdr.len);
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
+						   2 * nla_total_size(sizeof(u32)) +
+						   nla_total_size(data_pos),
+						   GFP_ATOMIC);
+	if (!nl_skb) {
+		ath11k_warn(ab,
+			    "failed to allocate skb for segmented testmode wmi event\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD,
+			ATH11K_TM_CMD_WMI_FTM) ||
+	    nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id) ||
+	    nla_put(nl_skb, ATH11K_TM_ATTR_DATA, data_pos,
+		    &ab->testmode.eventdata[0])) {
+		ath11k_warn(ab, "failed to populate segmented testmode event");
+		kfree_skb(nl_skb);
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+
+out:
+	spin_unlock_bh(&ar->data_lock);
+	return ret;
+}
+
+static void ath11k_tm_wmi_event_segmented(struct ath11k_base *ab, u32 cmd_id,
+					  struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_ftm_event_msg *ev;
+	u16 length;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse ftm event tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_ARRAY_BYTE];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch ftm msg\n");
+		kfree(tb);
+		return;
+	}
+
+	length = skb->len - TLV_HDR_SIZE;
+	ret = ath11k_tm_process_event(ab, cmd_id, ev, length);
+	if (ret)
+		ath11k_warn(ab, "Failed to process ftm event\n");
+
+	kfree(tb);
+}
+
+void ath11k_tm_wmi_event(struct ath11k_base *ab, u32 cmd_id, struct sk_buff *skb)
+{
+	if (test_bit(ATH11K_FLAG_FTM_SEGMENTED, &ab->dev_flags))
+		ath11k_tm_wmi_event_segmented(ab, cmd_id, skb);
+	else
+		ath11k_tm_wmi_event_unsegmented(ab, cmd_id, skb);
+}
+
 static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 {
 	struct sk_buff *skb;
@@ -46,6 +253,43 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 	return cfg80211_testmode_reply(skb);
 }
 
+static int ath11k_tm_cmd_testmode_start(struct ath11k *ar, struct nlattr *tb[])
+{
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state == ATH11K_STATE_FTM) {
+		ret = -EALREADY;
+		goto err;
+	}
+
+	/* start utf only when the driver is not in use  */
+	if (ar->state != ATH11K_STATE_OFF) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ar->ab->testmode.eventdata = kzalloc(ATH11K_FTM_EVENT_MAX_BUF_LENGTH,
+					     GFP_KERNEL);
+	if (!ar->ab->testmode.eventdata) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ar->state = ATH11K_STATE_FTM;
+	ar->ftm_msgref = 0;
+
+	mutex_unlock(&ar->conf_mutex);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE, "testmode cmd start\n");
+	return 0;
+
+err:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
@@ -56,11 +300,6 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 
 	mutex_lock(&ar->conf_mutex);
 
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto out;
-	}
-
 	if (!tb[ATH11K_TM_ATTR_DATA]) {
 		ret = -EINVAL;
 		goto out;
@@ -73,11 +312,17 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 
 	buf = nla_data(tb[ATH11K_TM_ATTR_DATA]);
 	buf_len = nla_len(tb[ATH11K_TM_ATTR_DATA]);
+	if (!buf_len) {
+		ath11k_warn(ar->ab, "No data present in testmode wmi command\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	cmd_id = nla_get_u32(tb[ATH11K_TM_ATTR_WMI_CMDID]);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
-		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
-		   cmd_id, buf, buf_len);
+		   "testmode cmd wmi cmd_id %d buf length %d\n",
+		   cmd_id, buf_len);
 
 	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", buf, buf_len);
 
@@ -104,6 +349,91 @@ static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
 	return ret;
 }
 
+static int ath11k_tm_cmd_wmi_ftm(struct ath11k *ar, struct nlattr *tb[])
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = ar->ab;
+	struct sk_buff *skb;
+	u32 cmd_id, buf_len, hdr_info;
+	int ret;
+	void *buf;
+	u8 segnumber = 0, seginfo;
+	u16 chunk_len, total_bytes, num_segments;
+	u8 *bufpos;
+	struct wmi_ftm_cmd *ftm_cmd;
+
+	set_bit(ATH11K_FLAG_FTM_SEGMENTED, &ab->dev_flags);
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_FTM) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	if (!tb[ATH11K_TM_ATTR_DATA]) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf = nla_data(tb[ATH11K_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH11K_TM_ATTR_DATA]);
+	cmd_id = WMI_PDEV_UTF_CMDID;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
+		   "testmode cmd wmi ftm cmd_id %d buffer length %d\n",
+		   cmd_id, buf_len);
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", buf, buf_len);
+
+	bufpos = buf;
+	total_bytes = buf_len;
+	num_segments = total_bytes / MAX_WMI_UTF_LEN;
+
+	if (buf_len - (num_segments * MAX_WMI_UTF_LEN))
+		num_segments++;
+
+	while (buf_len) {
+		chunk_len = min_t(u16, buf_len, MAX_WMI_UTF_LEN);
+
+		skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, (chunk_len +
+					   sizeof(struct wmi_ftm_cmd)));
+		if (!skb) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ftm_cmd = (struct wmi_ftm_cmd *)skb->data;
+		hdr_info = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+			   FIELD_PREP(WMI_TLV_LEN, (chunk_len +
+				      sizeof(struct wmi_ftm_seg_hdr)));
+		ftm_cmd->tlv_header = hdr_info;
+		ftm_cmd->seg_hdr.len = total_bytes;
+		ftm_cmd->seg_hdr.msgref = ar->ftm_msgref;
+		seginfo = FIELD_PREP(ATH11K_FTM_SEGHDR_TOTAL_SEGMENTS, num_segments) |
+			  FIELD_PREP(ATH11K_FTM_SEGHDR_CURRENT_SEQ, segnumber);
+		ftm_cmd->seg_hdr.segmentinfo = seginfo;
+		segnumber++;
+
+		memcpy(&ftm_cmd->data, bufpos, chunk_len);
+
+		ret = ath11k_wmi_cmd_send(wmi, skb, cmd_id);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to send wmi ftm command: %d\n", ret);
+			goto out;
+		}
+
+		buf_len -= chunk_len;
+		bufpos += chunk_len;
+	}
+
+	ar->ftm_msgref++;
+	ret = 0;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  void *data, int len)
 {
@@ -124,6 +454,10 @@ int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return ath11k_tm_cmd_get_version(ar, tb);
 	case ATH11K_TM_CMD_WMI:
 		return ath11k_tm_cmd_wmi(ar, tb);
+	case ATH11K_TM_CMD_TESTMODE_START:
+		return ath11k_tm_cmd_testmode_start(ar, tb);
+	case ATH11K_TM_CMD_WMI_FTM:
+		return ath11k_tm_cmd_wmi_ftm(ar, tb);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/testmode.h b/drivers/net/wireless/ath/ath11k/testmode.h
index ffdb0c30b276..b75edda594c8 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.h
+++ b/drivers/net/wireless/ath/ath11k/testmode.h
@@ -8,11 +8,16 @@
 
 #ifdef CONFIG_NL80211_TESTMODE
 
+void ath11k_tm_wmi_event(struct ath11k_base *ab, u32 cmd_id, struct sk_buff *skb);
 int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  void *data, int len);
 
 #else
 
+void ath11k_tm_wmi_event(struct ath11k_base *ab, u32 cmd_id, struct sk_buff *skb)
+{
+}
+
 static inline int ath11k_tm_cmd(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				void *data, int len)
diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/ath11k/testmode_i.h
index 4bae2a9eeea4..91b83873d660 100644
--- a/drivers/net/wireless/ath/ath11k/testmode_i.h
+++ b/drivers/net/wireless/ath/ath11k/testmode_i.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /* "API" level of the ath11k testmode interface. Bump it after every
@@ -11,9 +12,10 @@
 /* Bump this after every _compatible_ interface change, for example
  * addition of a new command or an attribute.
  */
-#define ATH11K_TESTMODE_VERSION_MINOR 0
+#define ATH11K_TESTMODE_VERSION_MINOR 1
 
 #define ATH11K_TM_DATA_MAX_LEN		5000
+#define ATH11K_FTM_EVENT_MAX_BUF_LENGTH 2048
 
 enum ath11k_tm_attr {
 	__ATH11K_TM_ATTR_INVALID		= 0,
@@ -47,4 +49,18 @@ enum ath11k_tm_cmd {
 	 * ATH11K_TM_ATTR_DATA.
 	 */
 	ATH11K_TM_CMD_WMI = 1,
+
+	/* Boots the UTF firmware, the netdev interface must be down at the
+	 * time.
+	 */
+	ATH11K_TM_CMD_TESTMODE_START = 2,
+
+	/* The command used to transmit a FTM WMI command to the firmware
+	 * and the event to receive WMI events from the firmware. The data
+	 * received only contain the payload, need to add the tlv header
+	 * and send the cmd to firmware with command id WMI_PDEV_UTF_CMDID.
+	 * The data payload size could be large and the driver needs to
+	 * send segmented data to firmware.
+	 */
+	ATH11K_TM_CMD_WMI_FTM = 3,
 };
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 443199e85fa2..68622a850527 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021, 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -19,6 +19,7 @@
 #include "mac.h"
 #include "hw.h"
 #include "peer.h"
+#include "testmode.h"
 
 struct wmi_tlv_policy {
 	size_t min_len;
@@ -237,9 +238,8 @@ static int ath11k_wmi_tlv_parse(struct ath11k_base *ar, const void **tb,
 				   (void *)tb);
 }
 
-static const void **
-ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
-			   size_t len, gfp_t gfp)
+const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
+					size_t len, gfp_t gfp)
 {
 	const void **tb;
 	int ret;
@@ -8606,6 +8606,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_CSA_SWITCH_COUNT_STATUS_EVENTID:
 		ath11k_wmi_pdev_csa_switch_count_status_event(ab, skb);
 		break;
+	case WMI_PDEV_UTF_EVENTID:
+		ath11k_tm_wmi_event(ab, id, skb);
+		break;
 	case WMI_PDEV_TEMPERATURE_EVENTID:
 		ath11k_wmi_pdev_temperature_event(ab, skb);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 43aaf55b7f2a..100bb816b592 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_WMI_H
@@ -68,6 +69,7 @@ struct wmi_tlv {
 
 #define WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG 1
 
+#define MAX_WMI_UTF_LEN 252
 #define WMI_BA_MODE_BUFFER_SIZE_256  3
 /*
  * HW mode config type replicated from FW header
@@ -3564,6 +3566,24 @@ struct wmi_get_pdev_temperature_cmd {
 	u32 pdev_id;
 } __packed;
 
+struct wmi_ftm_seg_hdr {
+	u32 len;
+	u32 msgref;
+	u32 segmentinfo;
+	u32 pdev_id;
+} __packed;
+
+struct wmi_ftm_cmd {
+	u32 tlv_header;
+	struct wmi_ftm_seg_hdr seg_hdr;
+	u8 data[];
+} __packed;
+
+struct wmi_ftm_event_msg {
+	struct wmi_ftm_seg_hdr seg_hdr;
+	u8 data[];
+} __packed;
+
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
 #define WMI_EMA_TMPL_IDX_SHIFT            8
@@ -6300,6 +6320,8 @@ enum wmi_sta_keepalive_method {
 #define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
 #define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
 
+const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab, const void *ptr,
+					size_t len, gfp_t gfp);
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 1dec23b0699c..99d8ba45a75b 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -838,6 +838,7 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 		case ATH11K_STATE_RESTARTING:
 		case ATH11K_STATE_RESTARTED:
 		case ATH11K_STATE_WEDGED:
+		case ATH11K_STATE_FTM:
 			ath11k_warn(ar->ab, "encountered unexpected device state %d on resume, cannot recover\n",
 				    ar->state);
 			ret = -EIO;
-- 
2.17.1

