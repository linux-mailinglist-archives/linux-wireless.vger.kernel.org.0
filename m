Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAE793CBD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjIFMfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbjIFMfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 08:35:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72376171D
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 05:35:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3866WAlY006933;
        Wed, 6 Sep 2023 12:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=haT0y71c0tkMxTttEkszXwnpDKe2bj9/nvxgmipz/iY=;
 b=iDaL9pq+csYQw0kuk2PYZMg1WX6yzr3exKuAI5AjtMuX+GN4qoWbWKLHsOpQ6LAZnA1p
 UIBi7D8KSxwZNzFAB14aXPaW2h3ZGLllJCGuIr6jd1sAalmaAKrsM4XXQwSWk8YB+Xo6
 yejhQQ8RxNZCyXL+jBsVYQ2DWSFm5LFvLKbx4pLAwH+lIeZBglTnc/HE8RswUZNS5S+3
 spTp0MnkDpIHb7p/gmKbX53ibf/5mA1lG5ip8IH43+TpF9TCjWrpnXFsP1gh/+w080uD
 BBNeXB+pXE2HyXvjQTUHC/tmZBh45ilpvLGsv8xwG55ZckJoizS9LbSa8PUaiVW3Ln9c LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxfrkhe83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 12:35:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 386CZc1A032129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 12:35:38 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 05:35:37 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/4] wifi: ath12k: adjust configuration of CCA threshold value
Date:   Wed, 6 Sep 2023 20:35:19 +0800
Message-ID: <20230906123520.184726-4-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906123520.184726-1-quic_lingbok@quicinc.com>
References: <20230906123520.184726-1-quic_lingbok@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -1sKwzC1QKp9eHCDeGCPdH7Xc9Gk0WBY
X-Proofpoint-ORIG-GUID: -1sKwzC1QKp9eHCDeGCPdH7Xc9Gk0WBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath12k need to adjust CCA threshold values to meet the regulatory
requirement. ath12k can retrieve CCA threshold configuration by invoking
ACPI _DSM method.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v2:
1.no change

 drivers/net/wireless/ath/ath12k/acpi.c | 30 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  8 +++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 41 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  7 +++--
 5 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index ae1ce7b99d2d..a9931e17bd17 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -72,6 +72,16 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acdata->geo_offset_data, obj->buffer.pointer,
 			       obj->buffer.length);
 			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_CCA:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_CCA_DATA_SIZE) {
+				ath12k_err(ab, "Invalid CCA data size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->cca_data, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
 		}
 	} else {
 		ath12k_err(ab,
@@ -281,6 +291,26 @@ int ath12k_get_acpi_all_data(struct ath12k_base *ab)
 			goto err_free_acdata;
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata, ATH12K_ACPI_FUNC_BIT_CCA)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_CCA);
+		if (ret) {
+			ath12k_err(ab, "failed to get cca threshold configuration %d\n", ret);
+			goto err_free_acdata;
+		}
+
+		if (ab->acdata->cca_data[0] == ATH12K_ACPI_CCA_THR_VERSION &&
+		    ab->acdata->cca_data[ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET] ==
+		    ATH12K_ACPI_CCA_THR_ENABLE_FLAG) {
+			ret = ath12k_wmi_pdev_set_cca_thr_table_param(ab,
+								      ab->acdata->cca_data);
+			if (ret) {
+				ath12k_err(ab, "set cca threshold failed %d\n", ret);
+				goto err_free_acdata;
+			}
+		}
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index fdb32ba37b77..60d674fdeb41 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.h
+++ b/drivers/net/wireless/ath/ath12k/acpi.h
@@ -13,14 +13,17 @@
 #define ATH12K_ACPI_DSM_FUNC_INDEX_TAS_DATA		9
 #define ATH12K_ACPI_DSM_FUNC_INDEX_BIOS_SAR		4
 #define ATH12K_ACPI_DSM_FUNC_INDEX_GEO_OFFSET		5
+#define ATH12K_ACPI_DSM_FUNC_INDEX_CCA			6
 
 #define ATH12K_ACPI_DSM_TAS_CFG_SIZE			108
 #define ATH12K_ACPI_DSM_TAS_DATA_SIZE			69
 #define ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE		34
 #define ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE		19
+#define ATH12K_ACPI_DSM_CCA_DATA_SIZE			41
 
 #define ATH12K_ACPI_FUNC_BIT_BIOS_SAR			BIT(3)
 #define ATH12K_ACPI_FUNC_BIT_GEO_OFFSET			BIT(4)
+#define ATH12K_ACPI_FUNC_BIT_CCA			BIT(5)
 #define ATH12K_ACPI_FUNC_BIT_TAS_CFG			BIT(7)
 #define ATH12K_ACPI_FUNC_BIT_TAS_DATA			BIT(8)
 
@@ -37,6 +40,11 @@
 #define ATH12K_ACPI_POWER_LIMIT_ENABLE_FLAG	0x1
 #define ATH12K_ACPI_GEO_OFFSET_DATA_OFFSET	1
 #define ATH12K_ACPI_BIOS_SAR_GEO_OFFSET_LEN	18
+#define ATH12K_ACPI_CCA_THR_VERSION		0x1
+#define ATH12K_ACPI_CCA_THR_ENABLE_FLAG		0x1
+#define ATH12K_ACPI_CCA_THR_OFFSET_LEN		36
+#define ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET	5
+
 
 int ath12k_get_acpi_all_data(struct ath12k_base *ab);
 void acpi_dsm_notify(acpi_handle handle, u32 event, void *data);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6fe4f0ddee4a..d57e2013b0fe 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -780,6 +780,7 @@ struct ath12k_base {
 		u8 tas_sar_power_table[ATH12K_ACPI_DSM_TAS_DATA_SIZE];
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
 		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
+		u8 cca_data[ATH12K_ACPI_DSM_CCA_DATA_SIZE];
 	} *acdata;
 
 	/* must be last */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 07f0a35900e0..d97849b028d6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7094,3 +7094,44 @@ int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
 
 	return ret;
 }
+
+int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab,
+					    u8 *pcca_table)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_interface_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, cca_thr_len_aligned;
+	u8 *pcca_value = pcca_table + ATH12K_ACPI_CCA_THR_OFFSET_DATA_OFFSET;
+
+	cca_thr_len_aligned = roundup(ATH12K_ACPI_CCA_THR_OFFSET_LEN, sizeof(u32));
+	len = sizeof(*cmd) + TLV_HDR_SIZE + cca_thr_len_aligned;
+
+	skb = ath12k_wmi_alloc_skb(wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_bios_interface_cmd *)skb->data;
+	cmd->tlv_header =
+		cpu_to_le32(ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD_PARAMS,
+						   sizeof(*cmd)));
+	cmd->pdev_id = cpu_to_le32(WMI_PDEV_ID_SOC);
+	cmd->param_type_id = cpu_to_le32(WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE);
+	cmd->length = ATH12K_ACPI_CCA_THR_OFFSET_LEN;
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, cca_thr_len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pcca_value, ATH12K_ACPI_CCA_THR_OFFSET_LEN);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
+	if (ret) {
+		ath12k_warn(ab, "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8a774655fe9f..7607cd7ab699 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4805,8 +4805,9 @@ struct wmi_pdev_set_bios_interface_cmd {
 } __packed;
 
 enum bios_param_type {
-	WMI_BIOS_PARAM_TAS_CONFIG_TYPE	=	1,
-	WMI_BIOS_PARAM_TAS_DATA_TYPE	=	2,
+	WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE	=	0,
+	WMI_BIOS_PARAM_TAS_CONFIG_TYPE		=	1,
+	WMI_BIOS_PARAM_TAS_DATA_TYPE		=	2,
 	WMI_BIOS_PARAM_TYPE_MAX,
 };
 
@@ -4952,4 +4953,6 @@ int ath12k_wmi_pdev_set_bios_sar_table_param(struct ath12k_base *ab,
 					     u8 *psar_table);
 int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
 					     u8 *pgeo_table);
+int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab,
+					    u8 *pcca_table);
 #endif
-- 
2.34.1

