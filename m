Return-Path: <linux-wireless+bounces-6536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D58A9FEE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E22852EB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4A16FF48;
	Thu, 18 Apr 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHiibymx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832816FF3E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457227; cv=none; b=qQwXVDkgM6eRxbpotVI+erb5qLAoE6NAkl0u+mKc5wZzMadBrtwZsiBFhGyH8Q+i9l0rIbvG4HwDSYPpq41FIQ2Lk/SFUnLKJQXZ0eQfgIqtZbgKn6XIPsVevGWHVZcPzxOLmhL+dxiDqr3F5V/tja3+QTlj6tJ6z0XmdZVtX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457227; c=relaxed/simple;
	bh=IYPhM8l3/Khs0CYddYJzgYk7V7vpwY74+t3vTBGqmt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sn0DmlDYNcgSU4I0OCcc9ICTs9u9y3VMSKkfrsWEy42OVeWJOp5z77ZrKSLUFLwpmTrwx6fBaFR895a6BSlu1uJDpzP/bKs/jTPraF9TVku6Wr5iA7SDUK9I2NF3QGOyHN4nTtOxYJjpaEq3+DLRXkx6im5SOAkkg49fUc8GJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHiibymx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07E9C32782;
	Thu, 18 Apr 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457226;
	bh=IYPhM8l3/Khs0CYddYJzgYk7V7vpwY74+t3vTBGqmt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHiibymxf63Sp3LeUBZxB5PqkZYltL8P69FtfMvyXUDIgfmgaiCPd6Sk7bNx0lRPv
	 LVjPgkP6vC0a66sx81n2OARC8R+0omVLnQnGxlc4TEDhQSlSTffJhTGXL+BVqMNIb0
	 zsFcj21xMC+MI84+gtu1qZGb5uYI8+fN4Xzv6qN4ii0dZ9Dp0fJBBY8tIVBvMwB5XF
	 CLhTf5J5r2Az1WWAw/3BtLc7RlgceHE+Xc2FzChBDrOMjVQWoijYo9DgEZiQBtT4vn
	 o8s7dF548lDv+fieSNjtuVCeePrmYnAUUqc1emjvYzFSzhSIZEly7cBOLNyVvm0yWO
	 PZPI06Qf/Bs0A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v8 4/4] wifi: ath12k: ACPI band edge channel power support
Date: Thu, 18 Apr 2024 19:20:19 +0300
Message-Id: <20240418162019.1246749-5-kvalo@kernel.org>
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

Currently, ath12k does not have the ability to set band edge channel power
for WCN7850. In order to support this, ath12k gets band edge channel power
table in ath12k_acpi_dsm_get_data() function and sets pdev_id and
param_type_id, then finally sends these data and
WMI_PDEV_SET_BIOS_INTERFACE_CMDID to firmware to set band edge channel
power.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 36 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  5 ++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/wmi.h  |  4 +++
 4 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 2fb8d53de68f..816c6e5fad0c 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -91,6 +91,18 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acpi.cca_data, obj->buffer.pointer,
 			       obj->buffer.length);
 
+			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI DSM band edge data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.band_edge_power, obj->buffer.pointer,
+			       obj->buffer.length);
+
 			break;
 		}
 	} else {
@@ -334,6 +346,30 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 		}
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi,
+				       ATH12K_ACPI_FUNC_BIT_BAND_EDGE_CHAN_POWER)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI DSM band edge channel power: %d\n",
+				    ret);
+			return ret;
+		}
+
+		if (ab->acpi.band_edge_power[0] == ATH12K_ACPI_BAND_EDGE_VERSION &&
+		    ab->acpi.band_edge_power[1] == ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG) {
+			ret = ath12k_wmi_set_bios_cmd(ab,
+						      WMI_BIOS_PARAM_TYPE_BANDEDGE,
+						      ab->acpi.band_edge_power,
+						      sizeof(ab->acpi.band_edge_power));
+			if (ret) {
+				ath12k_warn(ab,
+					    "failed to set ACPI DSM band edge channel power: %d\n",
+					    ret);
+				return ret;
+			}
+		}
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     ath12k_acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 9900fe3b1b1c..31e764adc088 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -14,12 +14,14 @@
 #define ATH12K_ACPI_DSM_FUNC_INDEX_CCA		6
 #define ATH12K_ACPI_DSM_FUNC_TAS_CFG		8
 #define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
+#define ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE		10
 
 #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
 #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
 #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
 #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
+#define ATH12K_ACPI_FUNC_BIT_BAND_EDGE_CHAN_POWER	BIT(9)
 
 #define ATH12K_ACPI_NOTIFY_EVENT			0x86
 #define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	(((_acdata).func_bit) & (_func))
@@ -30,6 +32,8 @@
 #define ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG	0x1
 #define ATH12K_ACPI_CCA_THR_VERSION		0x1
 #define ATH12K_ACPI_CCA_THR_ENABLE_FLAG		0x1
+#define ATH12K_ACPI_BAND_EDGE_VERSION		0x1
+#define ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG	0x1
 
 #define ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET	1
 #define ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET	2
@@ -41,6 +45,7 @@
 #define ATH12K_ACPI_CCA_THR_OFFSET_LEN		36
 
 #define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
+#define ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE		100
 #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
 
 #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0e33cf783f62..3333f88520ce 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -914,6 +914,7 @@ struct ath12k_base {
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
 		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
 		u8 cca_data[ATH12K_ACPI_DSM_CCA_DATA_SIZE];
+		u8 band_edge_power[ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE];
 	} acpi;
 
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6db15a0a4735..b5285ed78534 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4808,6 +4808,10 @@ enum wmi_bios_param_type {
 	WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE	= 0,
 	WMI_BIOS_PARAM_TAS_CONFIG_TYPE		= 1,
 	WMI_BIOS_PARAM_TAS_DATA_TYPE		= 2,
+
+	/* bandedge control power */
+	WMI_BIOS_PARAM_TYPE_BANDEDGE		= 3,
+
 	WMI_BIOS_PARAM_TYPE_MAX,
 };
 
-- 
2.39.2


