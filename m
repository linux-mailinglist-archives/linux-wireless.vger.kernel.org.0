Return-Path: <linux-wireless+bounces-6616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D18AC2EB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 05:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D511C209AE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC356AB8;
	Mon, 22 Apr 2024 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IjwgiDML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423710940
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713755201; cv=none; b=ONk4bkQ6WgcqldUNBZLW2pKPP/lAoTpBdSRnVkov5KUpci8cTYrRV97itLJAhUICDmN8KgwUttaBUb65cWGTNtiMsxQLBDXG7aD0dTsFeX25tNXlgFFxmmiTmSIo5aAaQ8eoTStEiFAmblPTO+VtnCf+40WEciP+obPwZMl5bxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713755201; c=relaxed/simple;
	bh=3Fc+HqEzBMC10Wu63EsG9qbkWc4ZWH46XnOLEzOdgdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIqoOrGX7jGGZAJPGvhzlT510JzdsRr7YiIE8411SxauVage2/wuwaCHPUAHgnfPWOD3ohZ+V5z6f9jCmxu7tpAC+PZ9UOrKvbSDF7WA+shfmUeY56+xqIx/hqnlohO9JwaSgVnv0d3BCNvAKry81D0Jds9xr1eoiVsxZCoow1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IjwgiDML; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M1UZKe006912;
	Mon, 22 Apr 2024 03:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4N81kbrjp1CzjUZ7mqn/sWlULF77xhIuLLdyqLj8bRo=; b=Ij
	wgiDMLkZelkYcGwi6HZfeHLLYFYBxOssr0Zk9iTbCFuA7Oeb8huKoERzSTqFhb75
	MwWuuCbiSaAF1vJ0Px+J8VNmDO340J43X8OJIeEDzzuZJ+INFBMlSQXuXn2vpzgu
	PxtYWa/8CB7io4XqbJSSdqDEclI/1d2sj/0Gf5oFHWhoSyWku+Blfxj+5iCmjOkg
	Z+E613cziMHCgwAGT4ueUoxieIT5AIgcSEvcfVmJT3gvsC8x2LFoF3g1TAonN/5i
	dJ4Kn6pWCJ/Xvf92eO6ysN1DnG20JjV1MViDwWD+0XrUgAwiAvPC9H0BynKdw0M3
	BndJK6Ls4tPg1y6BhWbQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5a733dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M36AtF024490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 03:06:10 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Apr 2024 20:06:08 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v9 2/4] wifi: ath12k: ACPI SAR support
Date: Mon, 22 Apr 2024 11:05:42 +0800
Message-ID: <20240422030545.954-3-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: DS-2RLMnW0dOt43BLLQs5LJom7GYZyQH
X-Proofpoint-ORIG-GUID: DS-2RLMnW0dOt43BLLQs5LJom7GYZyQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_22,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220014

In order to enable ACPI SAR (Specific Absorption Rate), ath12k gets SAR and GEO
offset tables from ACPI and sends the data to firmware using
WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID and WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID
commands.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 105 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  18 +++++
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c  |  99 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  19 +++++
 5 files changed, 244 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index dc8135703fc7..177babc50f25 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -55,6 +55,30 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acpi.tas_sar_power_table, obj->buffer.pointer,
 			       obj->buffer.length);
 
+			break;
+		case ATH12K_ACPI_DSM_FUNC_BIOS_SAR:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI BIOS SAR data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.bios_sar_data, obj->buffer.pointer,
+			       obj->buffer.length);
+
+			break;
+		case ATH12K_ACPI_DSM_FUNC_GEO_OFFSET:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE) {
+				ath12k_warn(ab, "invalid ACPI GEO OFFSET data size: %d\n",
+					    obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+
+			memcpy(&ab->acpi.geo_offset_data, obj->buffer.pointer,
+			       obj->buffer.length);
+
 			break;
 		}
 	} else {
@@ -93,6 +117,25 @@ static int ath12k_acpi_set_power_limit(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_acpi_set_bios_sar_power(struct ath12k_base *ab)
+{
+	int ret;
+
+	if (ab->acpi.bios_sar_data[0] != ATH12K_ACPI_POWER_LIMIT_VERSION ||
+	    ab->acpi.bios_sar_data[1] != ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG) {
+		ath12k_warn(ab, "invalid latest ACPI BIOS SAR data\n");
+		return -EINVAL;
+	}
+
+	ret = ath12k_wmi_set_bios_sar_cmd(ab, ab->acpi.bios_sar_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS SAR table: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath12k_acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 {
 	int ret;
@@ -119,6 +162,40 @@ static void ath12k_acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 		ath12k_warn(ab, "failed to set ACPI TAS power limit data: %d", ret);
 		return;
 	}
+
+	if (!ab->acpi.acpi_bios_sar_enable)
+		return;
+
+	ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BIOS_SAR);
+	if (ret) {
+		ath12k_warn(ab, "failed to update BIOS SAR: %d\n", ret);
+		return;
+	}
+
+	ret = ath12k_acpi_set_bios_sar_power(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to set BIOS SAR power limit: %d\n", ret);
+		return;
+	}
+}
+
+static int ath12k_acpi_set_bios_sar_params(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_wmi_set_bios_sar_cmd(ab, ab->acpi.bios_sar_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS SAR table: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath12k_wmi_set_bios_geo_cmd(ab, ab->acpi.geo_offset_data);
+	if (ret) {
+		ath12k_warn(ab, "failed to set ACPI BIOS GEO table: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int ath12k_acpi_set_tas_params(struct ath12k_base *ab)
@@ -184,6 +261,28 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 			ab->acpi.acpi_tas_enable = true;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BIOS_SAR)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BIOS_SAR);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI bios sar data: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_GEO_OFFSET)) {
+		ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_GEO_OFFSET);
+		if (ret) {
+			ath12k_warn(ab, "failed to get ACPI geo offset data: %d\n", ret);
+			return ret;
+		}
+
+		if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BIOS_SAR) &&
+		    ab->acpi.bios_sar_data[0] == ATH12K_ACPI_POWER_LIMIT_VERSION &&
+		    ab->acpi.bios_sar_data[1] == ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG &&
+		    !ab->acpi.acpi_tas_enable)
+			ab->acpi.acpi_bios_sar_enable = true;
+	}
+
 	if (ab->acpi.acpi_tas_enable) {
 		ret = ath12k_acpi_set_tas_params(ab);
 		if (ret) {
@@ -192,6 +291,12 @@ int ath12k_acpi_start(struct ath12k_base *ab)
 		}
 	}
 
+	if (ab->acpi.acpi_bios_sar_enable) {
+		ret = ath12k_acpi_set_bios_sar_params(ab);
+		if (ret)
+			return ret;
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     ath12k_acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index be7d1d9b0d28..7ade8b3f640d 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -9,9 +9,13 @@
 #include <linux/acpi.h>
 
 #define ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_BIOS_SAR		4
+#define ATH12K_ACPI_DSM_FUNC_GEO_OFFSET		5
 #define ATH12K_ACPI_DSM_FUNC_TAS_CFG		8
 #define ATH12K_ACPI_DSM_FUNC_TAS_DATA		9
 
+#define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
+#define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
 #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
 
@@ -20,10 +24,24 @@
 
 #define ATH12K_ACPI_TAS_DATA_VERSION		0x1
 #define ATH12K_ACPI_TAS_DATA_ENABLE		0x1
+#define ATH12K_ACPI_POWER_LIMIT_VERSION		0x1
+#define ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG	0x1
+
+#define ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET	1
+#define ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET	2
+#define ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN	10
+#define ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET	12
+#define ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN	18
+#define ATH12K_ACPI_BIOS_SAR_TABLE_LEN		22
 
 #define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
 #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
 
+#define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE (ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET + \
+					      ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN)
+#define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE (ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET + \
+					    ATH12K_ACPI_BIOS_SAR_TABLE_LEN)
+
 #ifdef CONFIG_ACPI
 
 int ath12k_acpi_start(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d724ce32d0b6..dac4a6cd60f1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -908,8 +908,11 @@ struct ath12k_base {
 		bool started;
 		u32 func_bit;
 		bool acpi_tas_enable;
+		bool acpi_bios_sar_enable;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
+		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
+		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
 	} acpi;
 
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dc09b7a9022c..c0ead7da9866 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2767,6 +2767,105 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 	return 0;
 }
 
+int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_sar_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_table_len_aligned, sar_dbs_backoff_len_aligned;
+	const u8 *psar_value = psar_table + ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET;
+	const u8 *pdbs_value = psar_table + ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET;
+
+	sar_table_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_TABLE_LEN, sizeof(u32));
+	sar_dbs_backoff_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN,
+					      sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_table_len_aligned +
+		TLV_HDR_SIZE + sar_dbs_backoff_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_sar_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->sar_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_TABLE_LEN);
+	cmd->dbs_backoff_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE,
+					 sar_table_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, psar_value, ATH12K_ACPI_BIOS_SAR_TABLE_LEN);
+
+	buf_ptr += sar_table_len_aligned;
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE,
+					 sar_dbs_backoff_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pdbs_value, ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_geo_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_geo_len_aligned;
+	const u8 *pgeo_value = pgeo_table + ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET;
+
+	sar_geo_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_geo_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_geo_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->geo_len = cpu_to_le32(ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, sar_geo_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pgeo_value, ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath12k_wmi_delba_send(struct ath12k *ar, u32 vdev_id, const u8 *mac,
 			  u32 tid, u32 initiator, u32 reason)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ad9cdd3d69aa..8ace566f7eb5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -353,6 +353,8 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID = 0x4044,
+	WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID = 0x4045,
 	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
@@ -1926,6 +1928,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
+	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD = 0x3D9,
 	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD = 0x3FB,
 	WMI_TAG_MAX
 };
@@ -4806,6 +4810,19 @@ enum wmi_bios_param_type {
 	WMI_BIOS_PARAM_TYPE_MAX,
 };
 
+struct wmi_pdev_set_bios_sar_table_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 sar_len;
+	__le32 dbs_backoff_len;
+} __packed;
+
+struct wmi_pdev_set_bios_geo_table_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 geo_len;
+} __packed;
+
 #define ATH12K_FW_STATS_BUF_SIZE (1024 * 1024)
 
 enum wmi_sys_cap_info_flags {
@@ -4966,6 +4983,8 @@ int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
 int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 			    const u8 *buf, size_t buf_len);
+int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
+int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.34.1


