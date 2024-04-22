Return-Path: <linux-wireless+bounces-6615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919228AC2EA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488F1280D9B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B308462;
	Mon, 22 Apr 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pXhVe1e5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D7CA62
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713755187; cv=none; b=H1SCVcPJTeWPwhODB3PJvyWu6t+T4NptC17UfwX3bTvGNiA86N9S+IJaXWNdfCigSpL/YH3aXIw03B4YdmRXm1Bh7al3tmHi2V6UcUkF2QeFDP6JItBu1mz+UpRXGMQjKZauFxOE7hKXopqqjucsldPg1079n07o7E5wbpMq4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713755187; c=relaxed/simple;
	bh=UIvELIwu1bCFOap6OHugFTpB9Q5BnJmKARY7dmKccvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4zBr+Y1S/FGacQsEyhmGfQAjaRyeubdL2zGne5w3+IOaXtH6DZMGIEv8TU4Lnnj/rTTHEM3Ga4U2PMrgZbqphPc/XISbNXJ+IyUB/fa+cb2dEzzEo+ZA8QSKgj1G69N7ROJ8kNuOoROpj9hawdYL9dEQby7jXAHp4V1bUL65Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pXhVe1e5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M19DGZ024778;
	Mon, 22 Apr 2024 03:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2Kop9rSuFPJ/K8XMbTr9wWWl/NRHCzi4TM5InBPgMxA=; b=pX
	hVe1e5JbSCl0tpVKsc2FwAp8xt5g0qB2KQR3+k/8REPFcqFJtswMgnPcHfHvjIoE
	6+2vcEKCWLj1Yg2Bn8/ZLBah3WorZ5nsQ7rykP2nus+OUhJkboX3MqAKojBlWMft
	Pg+Nv59gaiQ/b11yi2h9hyuHJNOsKPtWezBKO3mgK/wZ208kCCv85luHmkEblxpV
	zBjA5h5naSr5JKWfqbZQtBblnGKgiAhOU9LJV74TaPL15v3dPZzNviSnEFnz5c9W
	hxa5f90wC71VLHmaeh5Hn+ONUGtWhhw5qPbnbcykVyJcBT76h1VMI416ypyEkDiV
	HmUSMFtqozKY3T09fdrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm63a324e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M36856010799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:08 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 20:06:06 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v9 1/4] wifi: ath12k: ACPI TAS support
Date: Mon, 22 Apr 2024 11:05:41 +0800
Message-ID: <20240422030545.954-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240422030545.954-1-quic_lingbok@quicinc.com>
References: <20240422030545.954-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W1OyjrcI_02O8cG1NdPerlhgYexqphtN
X-Proofpoint-ORIG-GUID: W1OyjrcI_02O8cG1NdPerlhgYexqphtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_22,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220014

Currently, ath12k does not support Time-Average-SAR (TAS). In order to enable
TAS read the tables from ACPI and send them to the firmware using
WMI_PDEV_SET_BIOS_INTERFACE_CMDID command. Besides, ath12k registers an ACPI
event callback so that ACPI can notify ath12k to get the updated SAR power
table and sends it to the firmware when the device state is changed.

ACPI is only enabled for WCN7850 using struct ath12k_hw_params::acpi_guid
field. Most likely QCN9274 will never support ACPI as the chip is not used in
laptops.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/acpi.c   | 216 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h   |  45 +++++
 drivers/net/wireless/ath/ath12k/core.c   |   7 +
 drivers/net/wireless/ath/ath12k/core.h   |  13 ++
 drivers/net/wireless/ath/ath12k/hw.c     |  10 ++
 drivers/net/wireless/ath/ath12k/hw.h     |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c    |  44 +++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  17 ++
 9 files changed, 356 insertions(+)
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/acpi.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 7b8b3d7526c8..d42480db7463 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -24,6 +24,7 @@ ath12k-y += core.o \
 	    p2p.o
 
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o
+ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 
 # for tracing framework to find trace.h
diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
new file mode 100644
index 000000000000..dc8135703fc7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
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
+	int ret;
+
+	root_handle = ACPI_HANDLE(ab->dev);
+	if (!root_handle) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "invalid acpi handler\n");
+		return -EOPNOTSUPP;
+	}
+
+	obj = acpi_evaluate_dsm(root_handle, ab->hw_params->acpi_guid, 0, func,
+				NULL);
+
+	if (!obj) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi_evaluate_dsm() failed\n");
+		return -ENOENT;
+	}
+
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		ab->acpi.func_bit = obj->integer.value;
+	} else if (obj->type == ACPI_TYPE_BUFFER) {
+		switch (func) {
+		case ATH12K_ACPI_DSM_FUNC_TAS_CFG:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_TAS_CFG_SIZE) {
+				ath12k_warn(ab, "invalid ACPI DSM TAS config size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.tas_cfg, obj->buffer.pointer,
+			       obj->buffer.length);
+
+			break;
+		case ATH12K_ACPI_DSM_FUNC_TAS_DATA:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_TAS_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI DSM TAS data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.tas_sar_power_table, obj->buffer.pointer,
+			       obj->buffer.length);
+
+			break;
+		}
+	} else {
+		ath12k_warn(ab, "ACPI DSM method returned an unsupported object type: %d\n",
+			    obj->type);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+
+static int ath12k_acpi_set_power_limit(struct ath12k_base *ab)
+{
+	const u8 *tas_sar_power_table = ab->acpi.tas_sar_power_table;
+	int ret;
+
+	if (tas_sar_power_table[0] != ATH12K_ACPI_TAS_DATA_VERSION ||
+	    tas_sar_power_table[1] != ATH12K_ACPI_TAS_DATA_ENABLE) {
+		ath12k_warn(ab, "latest ACPI TAS data is invalid\n");
+		return -EINVAL;
+	}
+
+	ret = ath12k_wmi_set_bios_cmd(ab, WMI_BIOS_PARAM_TAS_DATA_TYPE,
+				      tas_sar_power_table,
+				      ATH12K_ACPI_DSM_TAS_DATA_SIZE);
+	if (ret) {
+		ath12k_warn(ab, "failed to send ACPI TAS data table: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void ath12k_acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
+{
+	int ret;
+	struct ath12k_base *ab = data;
+
+	if (event == ATH12K_ACPI_NOTIFY_EVENT) {
+		ath12k_warn(ab, "unknown acpi notify %u\n", event);
+		return;
+	}
+
+	if (!ab->acpi.acpi_tas_enable) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi_tas_enable is false\n");
+		return;
+	}
+
+	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_DATA);
+	if (ret) {
+		ath12k_warn(ab, "failed to update ACPI TAS data table: %d\n", ret);
+		return;
+	}
+
+	ret = ath12k_acpi_set_power_limit(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI TAS power limit data: %d", ret);
+		return;
+	}
+}
+
+static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_wmi_set_bios_cmd(ab, WMI_BIOS_PARAM_TAS_CONFIG_TYPE,
+				      ab->acpi.tas_cfg,
+				      ATH12K_ACPI_DSM_TAS_CFG_SIZE);
+	if (ret) {
+		ath12k_warn(ab, "failed to send ACPI TAS config table parameter: %d\n",
+			    ret);
+		return ret;
+	}
+
+	ret = ath12k_wmi_set_bios_cmd(ab, WMI_BIOS_PARAM_TAS_DATA_TYPE,
+				      ab->acpi.tas_sar_power_table,
+				      ATH12K_ACPI_DSM_TAS_DATA_SIZE);
+	if (ret) {
+		ath12k_warn(ab, "failed to send ACPI TAS data table parameter: %d\n",
+			    ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath12k_acpi_start(struct ath12k_base *ab)
+{
+	acpi_status status;
+	int ret;
+
+	if (!ab->hw_params->acpi_guid)
+		/* not supported with this hardware */
+		return 0;
+
+	ab->acpi.acpi_tas_enable = false;
+
+	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS);
+	if (ret) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to get ACPI DSM data: %d\n", ret);
+		return ret;
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_CFG);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI TAS config table: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_DATA)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_DATA);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI TAS data table: %d\n", ret);
+			return ret;
+		}
+
+		if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG) &&
+		    ab->acpi.tas_sar_power_table[0] == ATH12K_ACPI_TAS_DATA_VERSION &&
+		    ab->acpi.tas_sar_power_table[1] == ATH12K_ACPI_TAS_DATA_ENABLE)
+			ab->acpi.acpi_tas_enable = true;
+	}
+
+	if (ab->acpi.acpi_tas_enable) {
+		ret = ath12k_acpi_set_tas_params(ab);
+		if (ret) {
+			ath12k_warn(ab, "failed to send ACPI parameters: %d\n", ret);
+			return ret;
+		}
+	}
+
+	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
+					     ACPI_DEVICE_NOTIFY,
+					     ath12k_acpi_dsm_notify, ab);
+	if (ACPI_FAILURE(status)) {
+		ath12k_warn(ab, "failed to install DSM notify callback: %d\n", status);
+		return -EIO;
+	}
+
+	ab->acpi.started = true;
+
+	return 0;
+}
+
+void ath12k_acpi_stop(struct ath12k_base *ab)
+{
+	if (!ab->acpi.started)
+		return;
+
+	acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
+				   ACPI_DEVICE_NOTIFY,
+				   ath12k_acpi_dsm_notify);
+}
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
new file mode 100644
index 000000000000..be7d1d9b0d28
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef ATH12K_ACPI_H
+#define ATH12K_ACPI_H
+
+#include <linux/acpi.h>
+
+#define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_TAS_CFG		8
+#define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
+
+#define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
+#define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
+
+#define ATH12K_ACPI_NOTIFY_EVENT			0x86
+#define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	(((_acdata).func_bit) & (_func))
+
+#define ATH12K_ACPI_TAS_DATA_VERSION		0x1
+#define ATH12K_ACPI_TAS_DATA_ENABLE		0x1
+
+#define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
+#define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
+
+#ifdef CONFIG_ACPI
+
+int ath12k_acpi_start(struct ath12k_base *ab);
+void ath12k_acpi_stop(struct ath12k_base *ab);
+
+#else
+
+static inline int ath12k_acpi_start(struct ath12k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath12k_acpi_stop(struct ath12k_base *ab)
+{
+}
+
+#endif /* CONFIG_ACPI */
+
+#endif /* ATH12K_ACPI_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3c522a4b3e9b..9b209c04cbf9 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -543,6 +543,8 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath12k_qmi_firmware_stop(ab);
 
+	ath12k_acpi_stop(ab);
+
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
@@ -784,6 +786,11 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_reo_cleanup;
 	}
 
+	ret = ath12k_acpi_start(ab);
+	if (ret)
+		/* ACPI is optional so continue in case of an error */
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
+
 	return 0;
 
 err_reo_cleanup:
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 397d8c973265..d724ce32d0b6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -26,6 +26,7 @@
 #include "reg.h"
 #include "dbring.h"
 #include "fw.h"
+#include "acpi.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -901,6 +902,18 @@ struct ath12k_base {
 	 */
 	u8 mlo_capable_flags;
 
+#ifdef CONFIG_ACPI
+
+	struct {
+		bool started;
+		u32 func_bit;
+		bool acpi_tas_enable;
+		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
+		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
+	} acpi;
+
+#endif /* CONFIG_ACPI */
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0b17dfd47856..6161688941b2 100644
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
@@ -920,6 +924,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 
 		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -993,6 +999,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = 0,
 
 		.supports_sta_ps = true,
+
+		.acpi_guid = &wcn7850_uuid,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1061,6 +1069,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 
 		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e34c4f76c1ec..3f450ee93f34 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -8,6 +8,7 @@
 #define ATH12K_HW_H
 
 #include <linux/mhi.h>
+#include <linux/uuid.h>
 
 #include "wmi.h"
 #include "hal.h"
@@ -212,6 +213,8 @@ struct ath12k_hw_params {
 	u32 otp_board_id_register;
 
 	bool supports_sta_ps;
+
+	const guid_t *acpi_guid;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ab4f9e07ef03..dc09b7a9022c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2723,6 +2723,50 @@ int ath12k_wmi_send_dfs_phyerr_offload_enable_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
+			    const u8 *buf, size_t buf_len)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_interface_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *ptr;
+	u32 len, len_aligned;
+	int ret;
+
+	len_aligned = roundup(buf_len, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_interface_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->param_type_id = cpu_to_le32(param_id);
+	cmd->length = cpu_to_le32(buf_len);
+
+	ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len_aligned);
+	ptr += TLV_HDR_SIZE;
+	memcpy(ptr, buf, buf_len);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID parameter id %d: %d\n",
+			    param_id, ret);
+		dev_kfree_skb(skb);
+	}
+
+	return 0;
+}
+
 int ath12k_wmi_delba_send(struct ath12k *ar, u32 vdev_id, const u8 *mac,
 			  u32 tid, u32 initiator, u32 reason)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6f5a80a4490b..ad9cdd3d69aa 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -353,6 +353,7 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
 	WMI_VDEV_START_REQUEST_CMDID,
@@ -1925,6 +1926,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD = 0x3FB,
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
+enum wmi_bios_param_type {
+	WMI_BIOS_PARAM_TAS_CONFIG_TYPE		= 1,
+	WMI_BIOS_PARAM_TAS_DATA_TYPE		= 2,
+	WMI_BIOS_PARAM_TYPE_MAX,
+};
+
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
 enum wmi_sys_cap_info_flags {
@@ -4949,6 +4964,8 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
+int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
+			    const u8 *buf, size_t buf_len);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.34.1


