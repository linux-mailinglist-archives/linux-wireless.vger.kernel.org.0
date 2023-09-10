Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B226799D0E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Sep 2023 10:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbjIJI2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Sep 2023 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbjIJI2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Sep 2023 04:28:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6118F
        for <linux-wireless@vger.kernel.org>; Sun, 10 Sep 2023 01:28:31 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A8SQsR003564;
        Sun, 10 Sep 2023 08:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zWy9wX9hsB/koGSQsohNGhaRk5SQGyduDwf2jHIrqSE=;
 b=NwrgChTsRX2l5sKrw0YEnkjNtFZiYjmAABJ64O1ppfiH7OVDvufFL1EDHvZaYef5+W78
 Ate/Retdg2hoG2krDIyHWBqN5QCnOcxp72ZDIFXLr+mYoyrNEGCsW7oLJgDlCMKWN050
 uhDblHrOrbXGyY7kUnplIpfrPeptKhTuxsuWjGNHNkYYbis7GMFUDV+y3zz/N6cNJIz+
 HsE+bg8C+YTGATOGXgIzNrMPgbT2L1YmMHIUneVj7FAmKhg7P74mBU9KlHCpeQ/6tAJw
 GKS03HTlkq8hS5VB3aH399jbsLq4LDG5sX1aEKjZ1Sa0Ku1nDNZIOBYndc9/faaU2T1N 0g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0ga6hfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38A8SOo0011162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:24 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 10 Sep 2023 01:28:23 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 1/4] wifi: ath12k: add TAS capability for WCN7850
Date:   Sun, 10 Sep 2023 16:27:59 +0800
Message-ID: <20230910082802.9198-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230910082802.9198-1-quic_lingbok@quicinc.com>
References: <20230910082802.9198-1-quic_lingbok@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m4Vgfr9DpR7qfD3nCtlI3IltoFukpZkr
X-Proofpoint-ORIG-GUID: m4Vgfr9DpR7qfD3nCtlI3IltoFukpZkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309100073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath12k does not support Time-Average-SAR(TAS) for WCN7850. In
order to enable Time-Average-SAR(TAS) for WCN7850, ath12k defines
ath12k_get_acpi_all_data() function to get TAS configuration and SAR power
table, then sets pdev_id, param_type_id, and finally sends the TAS
configuration, SAR power table and WMI_PDEV_SET_BIOS_INTERFACE_CMDID
command to firmware to implement TAS during the initialization phase.
Besides, ath12k registers an ACPI event callback so that ACPI can notify
ath12k to get the updated SAR power table and sends it to firmware when the
device state is changed.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v4:
1.revise commit log using imperative voice
2.delete guid_is_null()

v3:
1.remove unnecessary cpu_to_le32()

v2:
1.put <linux/acpi.h> in the include guard

 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/acpi.c   | 203 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  29 ++++
 drivers/net/wireless/ath/ath12k/core.c   |   6 +
 drivers/net/wireless/ath/ath12k/core.h   |   8 +
 drivers/net/wireless/ath/ath12k/hw.c     |  10 ++
 drivers/net/wireless/ath/ath12k/hw.h     |   4 +-
 drivers/net/wireless/ath/ath12k/pci.c    |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c    |  80 +++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  20 ++-
 10 files changed, 366 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 62c52e733b5e..a479fe06caac 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -19,7 +19,8 @@ ath12k-y += core.o \
 	    hw.o \
 	    mhi.o \
 	    pci.o \
-	    dp_mon.o
+	    dp_mon.o \
+	    acpi.o
 
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 
diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
new file mode 100644
index 000000000000..384e01748b32
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+#include "acpi.h"
+#include "debug.h"
+
+static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
+{
+	union acpi_object *obj;
+	acpi_handle root_handle;
+	int ret = 0;
+
+	root_handle = ACPI_HANDLE(ab->dev);
+	if (!root_handle) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "invalid ACPI handler\n");
+		return -EOPNOTSUPP;
+	}
+
+	obj = acpi_evaluate_dsm(root_handle, ab->hw_params->acpi_guid, 0, func,
+				NULL);
+
+	if (!obj) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "ACPI _DSM method invocation failed\n");
+		return -ENOENT;
+	}
+
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		ab->acdata->func_bit = obj->integer.value;
+	} else if (obj->type == ACPI_TYPE_BUFFER) {
+		switch (func) {
+		case ATH12K_ACPI_DSM_FUNC_INDEX_TAS_CFG:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_TAS_CFG_SIZE) {
+				ath12k_err(ab, "Invalid TAS cfg size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->tas_cfg, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_TAS_DATA_SIZE) {
+				ath12k_err(ab, "Invalid TAS data size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->tas_sar_power_table, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		}
+	} else {
+		ath12k_err(ab,
+			   "ACPI: DSM method did not return a valid object, type %d\n",
+			   obj->type);
+		ret = -EINVAL;
+	}
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+
+static int ath12k_set_tas_power_limit_data(struct ath12k_base *ab)
+{
+	int ret;
+
+	if (ab->acdata->tas_sar_power_table[0] == ATH12K_ACPI_TAS_DATA_VERSION &&
+	    ab->acdata->tas_sar_power_table[1] == ATH12K_ACPI_TAS_DATA_ENABLE_FLAG) {
+		ret = ath12k_wmi_pdev_set_tas_data_table_param(ab,
+							       ab->acdata->tas_sar_power_table);
+		if (ret)
+			ath12k_err(ab, "failed to pass tas data table %d\n", ret);
+	} else {
+		ath12k_err(ab, "the latest tas data is invalid\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+void acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
+{
+	int ret;
+	struct ath12k_base *ab = data;
+
+	if (event == ATH12K_ACPI_NOTIFY_EVENT) {
+		if (ab->acdata->acpi_tas_enable) {
+			ret = ath12k_acpi_dsm_get_data(ab,
+						       ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA);
+			if (ret) {
+				ath12k_err(ab, "failed to update tas data table %d\n", ret);
+				return;
+			}
+
+			ret = ath12k_set_tas_power_limit_data(ab);
+			if (ret)
+				return;
+		}
+	} else {
+		ath12k_err(ab, "unknown acpi notify %u\n", event);
+	}
+}
+
+void ath12k_acpi_remove_notify(struct ath12k_base *ab)
+{
+	acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
+				   ACPI_DEVICE_NOTIFY,
+				   acpi_dsm_notify);
+}
+
+static int ath12k_pass_acpi_cfg_and_data_to_fw(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_wmi_pdev_set_tas_cfg_table_param(ab,
+						      ab->acdata->tas_cfg);
+	if (ret) {
+		ath12k_err(ab, "failed to pass tas cfg table to fw %d\n", ret);
+		return ret;
+	}
+
+	ret = ath12k_wmi_pdev_set_tas_data_table_param(ab,
+						       ab->acdata->tas_sar_power_table);
+	if (ret)
+		ath12k_err(ab, "failed to pass tas data table to fw %d\n", ret);
+
+	return ret;
+}
+
+int ath12k_get_acpi_all_data(struct ath12k_base *ab)
+{
+	int ret;
+	acpi_status status;
+
+	ab->acdata = kzalloc(sizeof(*ab->acdata), GFP_KERNEL);
+	if (!ab->acdata)
+		return -ENOMEM;
+
+	ab->acdata->acpi_tas_enable = false;
+
+	ret = ath12k_acpi_dsm_get_data(ab,
+				       ATH12K_ACPI_DSM_FUNC_INDEX_SUPPORT_FUNCS);
+
+	if (ret)
+		return ret;
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_TAS_CFG);
+		if (ret) {
+			ath12k_err(ab, "failed to get tas cfg table %d\n", ret);
+			goto err_free_acdata;
+		}
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_TAS_DATA)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA);
+		if (ret) {
+			ath12k_err(ab, "failed to get tas data table %d\n", ret);
+			goto err_free_acdata;
+		}
+
+		if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_TAS_CFG) &&
+		    ab->acdata->tas_sar_power_table[0] == ATH12K_ACPI_TAS_DATA_VERSION &&
+		    ab->acdata->tas_sar_power_table[1] == ATH12K_ACPI_TAS_DATA_ENABLE_FLAG)
+			ab->acdata->acpi_tas_enable = true;
+	}
+
+	if (ab->acdata->acpi_tas_enable) {
+		ret = ath12k_pass_acpi_cfg_and_data_to_fw(ab);
+		if (ret)
+			goto err_free_acdata;
+	}
+
+	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_dsm_notify, ab);
+	if (ACPI_FAILURE(status)) {
+		ath12k_err(ab, "failed to install DSM notify callback\n");
+		goto err_remove_notify;
+	}
+
+	return 0;
+
+err_remove_notify:
+	acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
+				   ACPI_DEVICE_NOTIFY,
+				   acpi_dsm_notify);
+
+	ret = -EIO;
+
+err_free_acdata:
+	kfree(ab->acdata);
+	ab->acdata = NULL;
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
new file mode 100644
index 000000000000..2331b8e3e035
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef ATH12K_ACPI_H
+#define ATH12K_ACPI_H
+
+#include <linux/acpi.h>
+
+#define ATH12K_ACPI_DSM_FUNC_INDEX_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_INDEX_TAS_CFG		8
+#define ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA		9
+
+#define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
+#define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
+
+#define ATH12K_ACPI_NOTIFY_EVENT			0x86
+#define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	((((_acdata)->func_bit) & (_func)) != 0)
+
+#define ATH12K_ACPI_TAS_DATA_VERSION		0x1
+#define ATH12K_ACPI_TAS_DATA_ENABLE_FLAG	0x1
+
+#define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
+#define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
+
+int ath12k_get_acpi_all_data(struct ath12k_base *ab);
+void acpi_dsm_notify(acpi_handle handle, u32 event, void *data);
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 39f938fafa81..5abef586e3e7 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -538,6 +538,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_reo_cleanup;
 	}
 
+	if (ab->hw_params->acpi_guid) {
+		ret = ath12k_get_acpi_all_data(ab);
+		if (!ret)
+			ath12k_info(ab, "success to get acpi cfg data\n");
+	}
+
 	return 0;
 
 err_reo_cleanup:
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d873b573dac6..cba4f176c018 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -22,6 +22,7 @@
 #include "hal_rx.h"
 #include "reg.h"
 #include "dbring.h"
+#include "acpi.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -771,6 +772,13 @@ struct ath12k_base {
 	u64 fw_soc_drop_count;
 	bool static_window_map;
 
+	struct {
+		u32 func_bit;
+		bool acpi_tas_enable;
+		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
+		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
+	} *acdata;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 5991cc91cd00..f0f7f9dbb08a 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -15,6 +15,10 @@
 #include "mhi.h"
 #include "dp_rx.h"
 
+static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
+					     0x90, 0xd6, 0x02, 0x42,
+					     0xac, 0x12, 0x00, 0x03);
+
 static u8 ath12k_hw_qcn9274_mac_from_pdev_id(int pdev_idx)
 {
 	return pdev_idx;
@@ -907,6 +911,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.acpi_guid = NULL,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -964,6 +970,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
 					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+
+		.acpi_guid = &wcn7850_uuid,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1019,6 +1027,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.acpi_guid = NULL,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e6c4223c283c..ab409e8ae268 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -8,7 +8,7 @@
 #define ATH12K_HW_H
 
 #include <linux/mhi.h>
-
+#include <linux/uuid.h>
 #include "wmi.h"
 #include "hal.h"
 
@@ -186,6 +186,8 @@ struct ath12k_hw_params {
 	const struct hal_ops *hal_ops;
 
 	u64 qmi_cnss_feature_bitmap;
+
+	const guid_t *acpi_guid;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index bd689efa7daa..8284f2ca59b0 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1340,6 +1340,12 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 
 	ath12k_hal_srng_deinit(ab);
 	ath12k_ce_free_pipes(ab);
+	if (ab->hw_params->acpi_guid && ab->acdata) {
+		acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
+					   ACPI_DEVICE_NOTIFY,
+					   acpi_dsm_notify);
+		kfree(ab->acdata);
+	}
 	ath12k_core_free(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f48ab69e256a..f49f4325edff 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6918,3 +6918,83 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
 
 	ath12k_wmi_free_dbring_caps(ab);
 }
+
+int ath12k_wmi_pdev_set_tas_cfg_table_param(struct ath12k_base *ab,
+					    const u8 *ptas_cfg)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_interface_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *buf_ptr;
+	u32 len, len_aligned;
+	int ret;
+
+	len_aligned = roundup(ATH12K_ACPI_DSM_TAS_CFG_SIZE, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_interface_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->param_type_id = cpu_to_le32(WMI_BIOS_PARAM_TAS_CONFIG_TYPE);
+	cmd->length = cpu_to_le32(ATH12K_ACPI_DSM_TAS_CFG_SIZE);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, ptas_cfg, ATH12K_ACPI_DSM_TAS_CFG_SIZE);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
+	if (ret) {
+		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_pdev_set_tas_data_table_param(struct ath12k_base *ab,
+					     const u8 *ptas_data)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_interface_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *buf_ptr;
+	u32 len, len_aligned;
+	int ret;
+
+	len_aligned = roundup(ATH12K_ACPI_DSM_TAS_DATA_SIZE, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_interface_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->param_type_id = cpu_to_le32(WMI_BIOS_PARAM_TAS_DATA_TYPE);
+	cmd->length = cpu_to_le32(ATH12K_ACPI_DSM_TAS_DATA_SIZE);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, ptas_data, ATH12K_ACPI_DSM_TAS_DATA_SIZE);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
+	if (ret) {
+		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c75a6fa1f7e0..38bbf59fc6b7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -361,6 +361,7 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
 	WMI_VDEV_START_REQUEST_CMDID,
@@ -1931,6 +1932,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS = 0x3FB,
 	WMI_TAG_MAX
 };
 
@@ -4791,6 +4793,19 @@ struct ath12k_wmi_base {
 	struct ath12k_wmi_target_cap_arg *targ_cap;
 };
 
+struct wmi_pdev_set_bios_interface_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 param_type_id;
+	__le32 length;
+} __packed;
+
+enum bios_param_type {
+	WMI_BIOS_PARAM_TAS_CONFIG_TYPE	=	1,
+	WMI_BIOS_PARAM_TAS_DATA_TYPE	=	2,
+	WMI_BIOS_PARAM_TYPE_MAX,
+};
+
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
@@ -4912,5 +4927,8 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
-
+int ath12k_wmi_pdev_set_tas_cfg_table_param(struct ath12k_base *ab,
+					    const u8 *ptas_cfg);
+int ath12k_wmi_pdev_set_tas_data_table_param(struct ath12k_base *ab,
+					     const u8 *ptas_data);
 #endif
-- 
2.34.1

