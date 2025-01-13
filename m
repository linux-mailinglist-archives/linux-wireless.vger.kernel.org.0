Return-Path: <linux-wireless+bounces-17402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E7A0B041
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7312D3A67D7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE7232794;
	Mon, 13 Jan 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n3oM/KIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524A232386
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754511; cv=none; b=mHv3CVfS0tx9wki5N2UsSpzd7qy7aJZmhAnlWddQgKc+eB4rtORr0HXv7NJ4vxVV3qPJh3tpeYjFMEkhXsW6JUX8bCbk/wnoZrXmILxQik27jnjjKUf6N/ZxP8wbxOR1uSNsY6Xvem6ZnkCeTdtXq6xdVS6GUHgjAX6wBlBJM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754511; c=relaxed/simple;
	bh=2JuwE44OJf2sNxuIIEBokkO3OA//KE5GjMs6uoQetmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRg+i6TgJOUJlw8Zgm4WMmM9if9yInY1DUG+hhL8RoiJ+HYq/zwVWPrkrnm3GTPPkVnhyQe64rP4LHUIq0EYlDvb+7IlL9dSrLteMW6MKxBsgqpcLTw+MYwwk4BODk5voDiGy1nU5h7Nw/+dH/t/FFMAT7nSECl6WAVH4GI0xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n3oM/KIk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNieht026061;
	Mon, 13 Jan 2025 07:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEYgkb9Qg732j7w10Pb49tTKPCDnKesJTrWDo8DT4fQ=; b=n3oM/KIkEyJE1ahs
	asZJYlRu6pCHaHD/0UoHpDzGlKSVZ/mcT8R7uWi5QjHENGB+EAjs/9j/1P760OFy
	OPd5PnHR7AErCHUR+hrMXmTt/LEEu892TmwnzDLYcMY+7j2NTw+pyVc9QmEhEujX
	Xi8VFISNfg7miM8ciaZkHCCyo6/OpbY6gYrW68YWdRKHkPnoaMtCrMhiOml9Q9ku
	UWtD7OtCWQBZJ1JWSlO2NgYv1VDsbYofWcCsjpJPmrQ0WWuJ29kpNnW2Vqy9J7ah
	s5lm5KYNLpz7OOxn12fnfhwitF2Hs2mTMFPYY71rfATjCoHWZ0oyrepA5k8DzP0k
	lG00Lg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444f5bhg62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D7mQLH024111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 07:48:26 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 12 Jan 2025 23:48:25 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v4 3/4] wifi: ath12k: Adjust the timing to access ACPI table
Date: Mon, 13 Jan 2025 15:48:09 +0800
Message-ID: <20250113074810.29729-4-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TOOKxB87OWdJASLfGHhQlzhpi5hjQbe_
X-Proofpoint-ORIG-GUID: TOOKxB87OWdJASLfGHhQlzhpi5hjQbe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130066

Currently, the timing for accessing the ACPI table is inappropriate.

Due to special ACPI requirements, the ACPI table must be obtained before
downloading the board data file. Therefore, adjust the timing for accessing
the ACPI table accordingly.

This patch will not affect QCN9274, because only WCN7850 supports ACPI.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v4:
1.rebase to 0c5fcd9069dd

v3:
no change

v2:
no change

 drivers/net/wireless/ath/ath12k/acpi.c | 98 ++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/acpi.h |  5 ++
 drivers/net/wireless/ath/ath12k/core.c |  5 +-
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  5 ++
 5 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index a3f3d0712722..fe6f051debda 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -278,15 +278,69 @@ bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
 	return ab->acpi.acpi_disable_11be;
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
@@ -357,20 +411,6 @@ int ath12k_acpi_start(struct ath12k_base *ab)
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
@@ -381,18 +421,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 
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
@@ -405,18 +435,8 @@ int ath12k_acpi_start(struct ath12k_base *ab)
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
index 4b154cfdbd39..7c18a3f60e3f 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -70,6 +70,7 @@ int ath12k_acpi_start(struct ath12k_base *ab);
 void ath12k_acpi_stop(struct ath12k_base *ab);
 bool ath12k_acpi_get_disable_rfkill(struct ath12k_base *ab);
 bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab);
+void ath12k_acpi_set_dsm_func(struct ath12k_base *ab);
 
 #else
 
@@ -92,6 +93,10 @@ static inline bool ath12k_acpi_get_disable_11be(struct ath12k_base *ab)
 	return false;
 }
 
+static inline void ath12k_acpi_set_dsm_func(struct ath12k_base *ab)
+{
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* ATH12K_ACPI_H */
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6c51c57778ec..de7fb84d69cd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -839,10 +839,7 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_reo_cleanup;
 	}
 
-	ret = ath12k_acpi_start(ab);
-	if (ret)
-		/* ACPI is optional so continue in case of an error */
-		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
+	ath12k_acpi_set_dsm_func(ab);
 
 	if (!test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
 		/* Indicate the core start in the appropriate group */
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 41a934c13fe7..c11c8c03b357 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1040,6 +1040,8 @@ struct ath12k_base {
 		bool acpi_bios_sar_enable;
 		bool acpi_disable_11be;
 		bool acpi_disable_rfkill;
+		bool acpi_cca_enable;
+		bool acpi_band_edge_enable;
 		u32 bit_flag;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5c3563383fab..86d055c45ace 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2740,6 +2740,11 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
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


