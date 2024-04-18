Return-Path: <linux-wireless+bounces-6533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470498A9FEB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34FE28354A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14454D9E8;
	Thu, 18 Apr 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7ojrPzg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA891635A6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457223; cv=none; b=C3XEYjVXE/EPyVIjG8LvQZ4XJci5GNmYQcM202xKAzbvuTetVZS38VAi33mn4fhdFKSp5ODg+M9lFzzfoDH9TsUuG+iV0m/PF8q7hNoVObK2qBbFVrbgeA7kMVYY5ZHZHWfOwZwhcYTR6oBx8wHHR6z4kbDKQyaV51eQQf5+iTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457223; c=relaxed/simple;
	bh=W6DakZuH2CftTf7Fuk2KUxC5XB3upe3og1Fe4bqRvDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiQtpcRrHc3UYho+e8FbvdnwjrGoLQUpo2l1H7PKcanXJ+jr5Xt87obq52jGa4ftZSAsr5i7xDbbA2YEV11IjPVRI7nxYbaII8pwLhnGsbWPv87Y/nLvQfSq0rloRmpgKVMAfmL82zK5RtAuadlLSoIdUdk/fMHoFxbsR/kW/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7ojrPzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8DEC116B1;
	Thu, 18 Apr 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457223;
	bh=W6DakZuH2CftTf7Fuk2KUxC5XB3upe3og1Fe4bqRvDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7ojrPzglH/3yOgDw60W3CZl1aTEmVU+fP7mCjQ6gm3fGAEfgVlfX/XrCfslCJq5Z
	 LE7Bu/wqF/hJsntWfC8eocxVqh/pocBk/aDscIRk9dy2JP6ZmYjwdOGTRH/xaBZ7kH
	 tKlKh1jSXI0GwVFNV5FTiEueR8WY+Zq74A0BLhukFfEAwql3Ft2tPnkQvK/lbP2nXZ
	 T8FDAlID7ejxj5RJs0hF35fppz65lTK7CjXcRa6iHfUFG9rgMzQDdgHy/j3AkTBDIG
	 U5Cs4VvmHbQqXYyEN1LQVr6/Xd51Y8zuRbGN5/hioCkFot7NrX8+cQ4+0mWYAYey2a
	 W3+SV9aOvvtIA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v8 1/4] wifi: ath12k: ACPI TAS support
Date: Thu, 18 Apr 2024 19:20:16 +0300
Message-Id: <20240418162019.1246749-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418162019.1246749-1-kvalo@kernel.org>
References: <20240418162019.1246749-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lingbo Kong <quic_lingbok@quicinc.com>

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
index 000000000000..5904ff0a6f9c
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -0,0 +1,216 @@
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
index 000000000000..785758b1e999
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -0,0 +1,45 @@
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
2.39.2


