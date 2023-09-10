Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3986799D0D
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Sep 2023 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346484AbjIJI2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Sep 2023 04:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbjIJI2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Sep 2023 04:28:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B920195
        for <linux-wireless@vger.kernel.org>; Sun, 10 Sep 2023 01:28:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38A8OlHW020174;
        Sun, 10 Sep 2023 08:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Vg5vsoXVTDjbl1byBVRxYAMwPv3NHjcjg/0nAJ8Tab0=;
 b=czl9xXTvyM2V3dkE6ROLwJf9yjeV4zomp8F6XOfbMBGidu875ki5k3iUx+etBUBN/7kn
 t6ddvT3ZMky4YjcG4CbwuEnqUGr9VFi4X0reJHQ+2gE0S5IUQAfQ6hfOGH9+r+Tq4hlH
 G0ZtB8oeZU8vQ7IyGVTgPcbee541KJ/pgiiC/kfwHlf9PSlGhSf/8LXTHIud+EXsiLCP
 wBOrbpNswdD/fMlrUyacI9JOY+S7FxwgCdlHppmJzQUJdcruCLWZ/JrT9uwMQ921EM3h
 hJHTVVNIPnvehz6L3JDlPjW+0YtIS+tCH17CD2EOeLCORgBsLBRHWywKjUFkt/G/C/VZ sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0j0fhgps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38A8SQVa006831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 08:28:26 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 10 Sep 2023 01:28:24 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 2/4] wifi: ath12k: add BIOS SAR capability for WCN7850
Date:   Sun, 10 Sep 2023 16:28:00 +0800
Message-ID: <20230910082802.9198-3-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kj4V4yyaMVrCn7c7pmKyxTI8Nd8mUhXI
X-Proofpoint-GUID: kj4V4yyaMVrCn7c7pmKyxTI8Nd8mUhXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-10_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309100073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath12k does not support BIOS SAR for WCN7850. In order to enable
BIOS SAR for WCN7850, ath12k gets BIOS SAR table and GEO offset table in
ath12k_acpi_dsm_get_data() function, then sets pdev_id, length of data, and
finally sends these data and WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID and
WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID to firmware to implement BIOS SAR during
the initialization phase. Besides, ath12k registers an ACPI event callback
so that ACPI can notify ath12k to get the updated BIOS SAR table and sends
it to firmware when the device state is changed.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v4:
1.revise commit log using imperative voice

v3:
1.adjust the order of the macros
2.apply jeff's advice
3.remove unnecessary cpu_to_le32()

v2:
no change

 drivers/net/wireless/ath/ath12k/acpi.c | 103 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  18 +++++
 drivers/net/wireless/ath/ath12k/core.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c  |  92 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  21 +++++
 5 files changed, 237 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 384e01748b32..ae1ce7b99d2d 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -52,6 +52,26 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acdata->tas_sar_power_table, obj->buffer.pointer,
 			       obj->buffer.length);
 			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE) {
+				ath12k_err(ab, "Invalid BIOS SAR data size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->bios_sar_data, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_GEO_OFFSET:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE) {
+				ath12k_err(ab, "Invalid GEO OFFSET data size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->geo_offset_data, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
 		}
 	} else {
 		ath12k_err(ab,
@@ -83,6 +103,24 @@ static int ath12k_set_tas_power_limit_data(struct ath12k_base *ab)
 	return ret;
 }
 
+static int ath12k_set_bios_sar_power_limit_data(struct ath12k_base *ab)
+{
+	int ret;
+
+	if (ab->acdata->bios_sar_data[0] == ATH12K_ACPI_POWER_LIMIT_VERSION &&
+	    ab->acdata->bios_sar_data[1] == ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG) {
+		ret = ath12k_wmi_pdev_set_bios_sar_table_param(ab,
+							       ab->acdata->bios_sar_data);
+		if (ret)
+			ath12k_err(ab, "failed to pass bios sar table %d\n", ret);
+	} else {
+		ath12k_err(ab, "the latest bios sar data is invalid\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 void acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 {
 	int ret;
@@ -101,6 +139,20 @@ void acpi_dsm_notify(acpi_handle handle, u32 event, void *data)
 			if (ret)
 				return;
 		}
+
+		if (ab->acdata->acpi_bios_sar_enable) {
+			ret = ath12k_acpi_dsm_get_data(ab,
+						       ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR);
+			if (ret) {
+				ath12k_err(ab, "failed to update bios sar %d\n", ret);
+				return;
+			}
+
+			ret = ath12k_set_bios_sar_power_limit_data(ab);
+			if (ret)
+				return;
+		}
+
 	} else {
 		ath12k_err(ab, "unknown acpi notify %u\n", event);
 	}
@@ -113,6 +165,27 @@ void ath12k_acpi_remove_notify(struct ath12k_base *ab)
 				   acpi_dsm_notify);
 }
 
+static int ath12k_pass_acpi_bios_sar_and_geo_to_fw(struct ath12k_base *ab)
+{
+	int ret;
+
+	ret = ath12k_wmi_pdev_set_bios_sar_table_param(ab,
+						       ab->acdata->bios_sar_data);
+
+	if (ret) {
+		ath12k_err(ab, "failed to pass bios sar table to fw %d\n", ret);
+		return ret;
+	}
+
+	ret = ath12k_wmi_pdev_set_bios_geo_table_param(ab,
+						       ab->acdata->geo_offset_data);
+
+	if (ret)
+		ath12k_err(ab, "failed to pass bios geo table to fw %d\n", ret);
+
+	return ret;
+}
+
 static int ath12k_pass_acpi_cfg_and_data_to_fw(struct ath12k_base *ab)
 {
 	int ret;
@@ -172,12 +245,42 @@ int ath12k_get_acpi_all_data(struct ath12k_base *ab)
 			ab->acdata->acpi_tas_enable = true;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_BIOS_SAR)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR);
+		if (ret) {
+			ath12k_err(ab, "failed to get bios sar data %d\n", ret);
+			goto err_free_acdata;
+		}
+	}
+
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_GEO_OFFSET)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_GEO_OFFSET);
+		if (ret) {
+			ath12k_err(ab, "failed to get geo offset data %d\n", ret);
+			goto err_free_acdata;
+		}
+
+		if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_BIOS_SAR) &&
+		    ab->acdata->bios_sar_data[0] == ATH12K_ACPI_POWER_LIMIT_VERSION &&
+		    ab->acdata->bios_sar_data[1] == ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG &&
+		    !ab->acdata->acpi_tas_enable)
+			ab->acdata->acpi_bios_sar_enable = true;
+	}
+
 	if (ab->acdata->acpi_tas_enable) {
 		ret = ath12k_pass_acpi_cfg_and_data_to_fw(ab);
 		if (ret)
 			goto err_free_acdata;
 	}
 
+	if (ab->acdata->acpi_bios_sar_enable) {
+		ret = ath12k_pass_acpi_bios_sar_and_geo_to_fw(ab);
+		if (ret)
+			goto err_free_acdata;
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index 2331b8e3e035..2f930f0718da 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -9,9 +9,13 @@
 #include <linux/acpi.h>
 
 #define ATH12K_ACPI_DSM_FUNC_INDEX_SUPPORT_FUNCS	0
+#define ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR             4
+#define ATH12K_ACPI_DSM_FUNC_INDEX_GEO_OFFSET           5
 #define ATH12K_ACPI_DSM_FUNC_INDEX_TAS_CFG		8
 #define ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA		9
 
+#define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
+#define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
 #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
 #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
 
@@ -20,10 +24,24 @@
 
 #define ATH12K_ACPI_TAS_DATA_VERSION		0x1
 #define ATH12K_ACPI_TAS_DATA_ENABLE_FLAG	0x1
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
 int ath12k_get_acpi_all_data(struct ath12k_base *ab);
 void acpi_dsm_notify(acpi_handle handle, u32 event, void *data);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cba4f176c018..6fe4f0ddee4a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -775,8 +775,11 @@ struct ath12k_base {
 	struct {
 		u32 func_bit;
 		bool acpi_tas_enable;
+		bool acpi_bios_sar_enable;
 		u8 tas_cfg[ATH12K_ACPI_DSM_TAS_CFG_SIZE];
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
+		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
+		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
 	} *acdata;
 
 	/* must be last */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f49f4325edff..9ad588897b09 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6998,3 +6998,95 @@ int ath12k_wmi_pdev_set_tas_data_table_param(struct ath12k_base *ab,
 
 	return ret;
 }
+
+int ath12k_wmi_pdev_set_bios_sar_table_param(struct ath12k_base *ab,
+					     u8 *psar_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_sar_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_table_len_aligned, sar_dbs_backoff_len_aligned;
+	u8 *psar_value = psar_table + ATH12K_ACPI_POWER_LIMIT_DATA_OFFSET;
+	u8 *pdbs_value = psar_table + ATH12K_ACPI_DBS_BACKOFF_DATA_OFFSET;
+
+	sar_table_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_TABLE_LEN, sizeof(u32));
+	sar_dbs_backoff_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_DBS_BACKOFF_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_table_len_aligned +
+		TLV_HDR_SIZE + sar_dbs_backoff_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_sar_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD_PARAMS,
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
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
+					     u8 *pgeo_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_geo_table_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, sar_geo_len_aligned;
+	u8 *pgeo_value = pgeo_table + ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET;
+
+	sar_geo_len_aligned = roundup(ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + sar_geo_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_geo_table_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD_PARAMS,
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
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID);
+	if (ret) {
+		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 38bbf59fc6b7..8a774655fe9f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -361,6 +361,8 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID = 0x4044,
+	WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID = 0x4045,
 	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
 	WMI_VDEV_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_DELETE_CMDID,
@@ -1932,6 +1934,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
+	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD_PARAMS = 0x3D8,
+	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD_PARAMS = 0x3D9,
 	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS = 0x3FB,
 	WMI_TAG_MAX
 };
@@ -4806,6 +4810,19 @@ enum bios_param_type {
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
 
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
@@ -4931,4 +4948,8 @@ int ath12k_wmi_pdev_set_tas_cfg_table_param(struct ath12k_base *ab,
 					    const u8 *ptas_cfg);
 int ath12k_wmi_pdev_set_tas_data_table_param(struct ath12k_base *ab,
 					     const u8 *ptas_data);
+int ath12k_wmi_pdev_set_bios_sar_table_param(struct ath12k_base *ab,
+					     u8 *psar_table);
+int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
+					     u8 *pgeo_table);
 #endif
-- 
2.34.1

