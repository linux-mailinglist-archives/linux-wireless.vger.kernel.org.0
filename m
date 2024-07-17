Return-Path: <linux-wireless+bounces-10299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74359933BE7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51131F24362
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6417F519;
	Wed, 17 Jul 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aO96wO93"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3417F4EA
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214647; cv=none; b=S8kZmIK4Lizt7O9wZQ/o8ulzs/roDMsjuBPspdj2It6RQsB71T73YkmjZ6205i8AJUf/AIMqN0d4kWKEYGQ5eqEMN6bPsiL+4nFi5860V0tLOYBjBHPud00uQE/e7lPnp3/ywSdWBVuB/YjIO/LQDxs2nP6Cn6erTIURIzonUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214647; c=relaxed/simple;
	bh=DAbCKqiJXvF+fu2ILrVe2PTVyklAEPsPLQ51BTma3I4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw0/N8YaJuZ7h08RfDav7l90WxI0PXvO10jUB3Q7GtX0E8hgtNMcpyiqHwuYrMtFZzVGJj3TwjOodQyfZ8cpzy3FRREN5749KeTDsAhkEGIeIxu+/zFqFs6oSQhEuaLRZ0TsLZhLIn9l0DUDGbQhWNeJN7lPysFYJr8Sgd//ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aO96wO93; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H7VSSA005223;
	Wed, 17 Jul 2024 11:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZpGTvvpixMhQWqOBMS+3yeYX7LQSwRpZhQ+IiRfeyY=; b=aO96wO93djyyyP9b
	eqgg9M4QR0OuP8rr8heWNMZw0eiX9xD8JV2srBoRInadWQfrmj1GPo+v70wH0A2+
	YnNjRxA4KAeX9XTih9rIPqWNxPOf2HvLUHX89NQDR1G2/IQN06FEpfsXpRYSfHfj
	PdWcz6AYu0jjcBCPxuKEJ6hqSYe/kSauMrmS6QhaTTT4qaQd+oYFHBDGZ+GoOVJz
	kI0RAg76PyRYLT15fl/HpZvsTWLsXaQiQhYkQZChVtXE9e4ueVSlbZD0Y5ZAN2Zd
	BIAjf92+MJPiGEUTqb1r6q+sZBG9RN9gA2mF0YFwLugyHpu23LCBtl2t5/Zafg0m
	31xgrw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfuj48f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HBAd7J014233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:10:39 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 04:10:38 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: Adjust the timing to access ACPI table
Date: Wed, 17 Jul 2024 19:10:22 +0800
Message-ID: <20240717111023.78798-4-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717111023.78798-1-quic_lingbok@quicinc.com>
References: <20240717111023.78798-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: 6bz9cWlbXkbXhOZAZV3LoCNLsky3Q55p
X-Proofpoint-ORIG-GUID: 6bz9cWlbXkbXhOZAZV3LoCNLsky3Q55p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170086

Currently, the timing for accessing the ACPI table is inappropriate.

Due to special ACPI requirements, the ACPI table must be obtained before
downloading the board data file. Therefore, adjust the timing for accessing
the ACPI table accordingly.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 98 ++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/acpi.h |  5 ++
 drivers/net/wireless/ath/ath12k/core.c |  5 +-
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  5 ++
 5 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 53050f83bc76..33aa1427e6c0 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -268,15 +268,69 @@ static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
 	return 0;
 }
 
+void ath12k_acpi_set_dsm_func(struct ath12k_base *ab)
+{
+	int ret;
+	u8 *buf;
+
+	if (!ab->hw_params->acpi_guid)
+		/* not supported with this hardware */
+		return;
+
+	if (ab->acpi.acpi_tas_enable) {
+		ret = ath12k_acpi_set_tas_params(ab);
+		if (ret) {
+			ath12k_warn(ab, "failed to send ACPI TAS parameters: %d\n", ret);
+			return;
+		}
+	}
+
+	if (ab->acpi.acpi_bios_sar_enable) {
+		ret = ath12k_acpi_set_bios_sar_params(ab);
+		if (ret) {
+			ath12k_warn(ab, "failed to send ACPI BIOS SAR: %d\n", ret);
+			return;
+		}
+	}
+
+	if (ab->acpi.acpi_cca_enable) {
+		buf = ab->acpi.cca_data + ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET;
+		ret = ath12k_wmi_set_bios_cmd(ab,
+					      WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE,
+					      buf,
+					      ATH12K_ACPI_CCA_THR_OFFSET_LEN);
+		if (ret) {
+			ath12k_warn(ab, "failed to set ACPI DSM CCA threshold: %d\n",
+				    ret);
+			return;
+		}
+	}
+
+	if (ab->acpi.acpi_band_edge_enable) {
+		ret = ath12k_wmi_set_bios_cmd(ab,
+					      WMI_BIOS_PARAM_TYPE_BANDEDGE,
+					      ab->acpi.band_edge_power,
+					      sizeof(ab->acpi.band_edge_power));
+		if (ret) {
+			ath12k_warn(ab,
+				    "failed to set ACPI DSM band edge channel power: %d\n",
+				    ret);
+			return;
+		}
+	}
+}
+
 int ath12k_acpi_start(struct ath12k_base *ab)
 {
 	acpi_status status;
-	u8 *buf;
 	int ret;
 
 	ab->acpi.acpi_tas_enable = false;
 	ab->acpi.acpi_disable_11be = false;
 	ab->acpi.acpi_disable_rfkill = false;
+	ab->acpi.acpi_bios_sar_enable = false;
+	ab->acpi.acpi_cca_enable = false;
+	ab->acpi.acpi_band_edge_enable = false;
 
 	if (!ab->hw_params->acpi_guid)
 		/* not supported with this hardware */
@@ -347,20 +401,6 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 			ab->acpi.acpi_bios_sar_enable = true;
 	}
 
-	if (ab->acpi.acpi_tas_enable) {
-		ret = ath12k_acpi_set_tas_params(ab);
-		if (ret) {
-			ath12k_warn(ab, "failed to send ACPI parameters: %d\n", ret);
-			return ret;
-		}
-	}
-
-	if (ab->acpi.acpi_bios_sar_enable) {
-		ret = ath12k_acpi_set_bios_sar_params(ab);
-		if (ret)
-			return ret;
-	}
-
 	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_CCA)) {
 		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_INDEX_CCA);
 		if (ret) {
@@ -371,18 +411,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 
 		if (ab->acpi.cca_data[0] == ATH12K_ACPI_CCA_THR_VERSION &&
 		    ab->acpi.cca_data[ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET] ==
-		    ATH12K_ACPI_CCA_THR_ENABLE_FLAG) {
-			buf = ab->acpi.cca_data + ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET;
-			ret = ath12k_wmi_set_bios_cmd(ab,
-						      WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE,
-						      buf,
-						      ATH12K_ACPI_CCA_THR_OFFSET_LEN);
-			if (ret) {
-				ath12k_warn(ab, "failed to set ACPI DSM CCA threshold: %d\n",
-					    ret);
-				return ret;
-			}
-		}
+		    ATH12K_ACPI_CCA_THR_ENABLE_FLAG)
+			ab->acpi.acpi_cca_enable = true;
 	}
 
 	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi,
@@ -395,18 +425,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 		}
 
 		if (ab->acpi.band_edge_power[0] == ATH12K_ACPI_BAND_EDGE_VERSION &&
-		    ab->acpi.band_edge_power[1] == ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG) {
-			ret = ath12k_wmi_set_bios_cmd(ab,
-						      WMI_BIOS_PARAM_TYPE_BANDEDGE,
-						      ab->acpi.band_edge_power,
-						      sizeof(ab->acpi.band_edge_power));
-			if (ret) {
-				ath12k_warn(ab,
-					    "failed to set ACPI DSM band edge channel power: %d\n",
-					    ret);
-				return ret;
-			}
-		}
+		    ab->acpi.band_edge_power[1] == ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG)
+			ab->acpi.acpi_band_edge_enable = true;
 	}
 
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index cdfd63c60ffb..f3546b02aab7 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -68,6 +68,7 @@
 
 int ath12k_acpi_start(struct ath12k_base *ab);
 void ath12k_acpi_stop(struct ath12k_base *ab);
+void ath12k_acpi_set_dsm_func(struct ath12k_base *ab);
 
 #else
 
@@ -80,6 +81,10 @@ static inline void ath12k_acpi_stop(struct ath12k_base *ab)
 {
 }
 
+static inline void ath12k_acpi_set_dsm_func(struct ath12k_base *ab)
+{
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* ATH12K_ACPI_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 75869e8b211f..3fd7ece7bcdd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -842,10 +842,7 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_reo_cleanup;
 	}
 
-	ret = ath12k_acpi_start(ab);
-	if (ret)
-		/* ACPI is optional so continue in case of an error */
-		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
+	ath12k_acpi_set_dsm_func(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cac6647f2776..5177147e2b40 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -942,6 +942,8 @@ struct ath12k_base {
 		bool acpi_bios_sar_enable;
 		bool acpi_disable_11be;
 		bool acpi_disable_rfkill;
+		bool acpi_cca_enable;
+		bool acpi_band_edge_enable;
 		u32 bit_flag;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b93ce9f87f61..6e5ec4ed533f 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2527,6 +2527,11 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 	if (r)
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
 
+	r = ath12k_acpi_start(ab);
+	if (r)
+		/* ACPI is optional so continue in case of an error */
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", r);
+
 out:
 	return ret;
 }
-- 
2.34.1


