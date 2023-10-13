Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14037C84C4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJMLpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJMLo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 07:44:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C497C9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 04:44:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DAF1V8028467;
        Fri, 13 Oct 2023 11:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9M/HneumYeweKZWofbw990Dtq+CjoEz/y37Dt7aOwbo=;
 b=CwzeSwVwOaaMK8YcMINDaieDIvUm9F4522bR5i+RaUoMm6+1pIeKd0B/JzvcNGeVM14F
 ERU0qUtJwGiFQdIch73L8rBia+abIh2SSTc2DXQRIr2GsRJ3PziHTQN5Lle05NnqpZni
 kBs1qhQubEUWGN11lgGCopxB/GAeCMkKLPsAW66UKhz807YXDN/an2jjLYnz0YSpWx+N
 Y5C7BPo0gNNAG/gNzeTW/8QSw8ZfeY/VLFt82E9vt1nyPz/WTidtc0BFlmGTM35YRPXa
 6/sn1nygynjmaAF2GemC2msZu+p0S99uBc5K3S2ImmKCsj0/cZtK0rI2K2wkTb106zBo uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tq2sr8b63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:44:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DBiqrY024148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 11:44:52 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 04:44:51 -0700
From:   Lingbo Kong <quic_lingbok@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v7 4/4] wifi: ath12k: add set band edge channel power for WCN7850
Date:   Fri, 13 Oct 2023 07:44:34 -0400
Message-ID: <20231013114434.81648-5-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013114434.81648-1-quic_lingbok@quicinc.com>
References: <20231013114434.81648-1-quic_lingbok@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hnrrXnFh_zhjLuKVYyWKRuDY2a3vCQ57
X-Proofpoint-ORIG-GUID: hnrrXnFh_zhjLuKVYyWKRuDY2a3vCQ57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=879 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath12k does not have the ability to set band edge channel power
for WCN7850. In order to support this, ath12k gets band edge channel power
table in ath12k_acpi_dsm_get_data() function and sets pdev_id and
param_type_id, then finally sends these data and
WMI_PDEV_SET_BIOS_INTERFACE_CMDID to firmware to set band edge channel
power.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v7:
1.adjust the length of line

v6:
1.no change

v5:
1.rebase to the latest tag

v4:
1.revise commit log using imperative voice

v3:
1.remove unnecessary cpu_to_le32()
2.adjust the order of the macros

v2:
no change

 drivers/net/wireless/ath/ath12k/acpi.c | 31 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/acpi.h |  5 +++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 44 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  2 ++
 5 files changed, 83 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index cb0850ae110a..bcffd925e750 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -82,6 +82,16 @@ static int ath12k_acpi_dsm_get_data(struct ath12k_base *ab, int func)
 			memcpy(&ab->acdata->cca_data, obj->buffer.pointer,
 			       obj->buffer.length);
 			break;
+		case ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE:
+			if (obj->buffer.length != ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE) {
+				ath12k_err(ab, "Invalid BAND EDGE data size %d\n",
+					   obj->buffer.length);
+				ret = -EINVAL;
+				goto out;
+			}
+			memcpy(&ab->acdata->band_edge_power, obj->buffer.pointer,
+			       obj->buffer.length);
+			break;
 		}
 	} else {
 		ath12k_err(ab,
@@ -308,6 +318,27 @@ int ath12k_get_acpi_all_data(struct ath12k_base *ab)
 		}
 	}
 
+	if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acdata,
+				       ATH12K_ACPI_FUNC_BIT_BAND_EDGE_CHAN_POWER)) {
+		ret = ath12k_acpi_dsm_get_data(ab,
+					       ATH12K_ACPI_DSM_FUNC_INDEX_BAND_EDGE);
+		if (ret) {
+			ath12k_err(ab, "fail to get band edge channel power %d\n", ret);
+			goto err_free_acdata;
+		}
+
+		if (ab->acdata->band_edge_power[0] == ATH12K_ACPI_BAND_EDGE_VERSION &&
+		    ab->acdata->band_edge_power[1] == ATH12K_ACPI_BAND_EDGE_ENABLE_FLAG) {
+			ret = ath12k_wmi_pdev_set_band_edge_power(ab);
+			if (ret) {
+				ath12k_err(ab,
+					   "set band edge channel power failed %d\n",
+					   ret);
+				goto err_free_acdata;
+			}
+		}
+	}
+
 	status = acpi_install_notify_handler(ACPI_HANDLE(ab->dev),
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_dsm_notify, ab);
diff --git a/drivers/net/wireless/ath/ath12k/acpi.h b/drivers/net/wireless/ath/ath12k/acpi.h
index f9ad4d573b78..a419c47046ce 100644
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
 #define ATH12K_ACPI_FUNC_BIT_VALID(_acdata, _func)	(((_acdata)->func_bit) & (_func))
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
index 4b663577c2b9..350cff3c30e3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -803,6 +803,7 @@ struct ath12k_base {
 		u8 bios_sar_data[ATH12K_ACPI_DSM_BIOS_SAR_DATA_SIZE];
 		u8 geo_offset_data[ATH12K_ACPI_DSM_GEO_OFFSET_DATA_SIZE];
 		u8 cca_data[ATH12K_ACPI_DSM_CCA_DATA_SIZE];
+		u8 band_edge_power[ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE];
 	} *acdata;
 
 	/* must be last */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 0d9101f9643a..06f68dd2542c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7205,3 +7205,47 @@ int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab)
 	}
 	return ret;
 }
+
+int ath12k_wmi_pdev_set_band_edge_power(struct ath12k_base *ab)
+{
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
+	struct wmi_pdev_set_bios_interface_cmd *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int ret;
+	u8 *buf_ptr;
+	u32 len, len_aligned;
+	u8 *pchan_table = ab->acdata->band_edge_power;
+
+	len_aligned = roundup(ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE, sizeof(u32));
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
+	cmd->param_type_id = cpu_to_le32(WMI_BIOS_PARAM_TYPE_BANDEDGE_CTL_POWER);
+	cmd->length = cpu_to_le32(ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE);
+
+	buf_ptr = skb->data + sizeof(*cmd);
+	tlv = (struct wmi_tlv *)buf_ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len_aligned);
+	buf_ptr += TLV_HDR_SIZE;
+	memcpy(buf_ptr, pchan_table, ATH12K_ACPI_DSM_BAND_EDGE_DATA_SIZE);
+
+	ret = ath12k_wmi_cmd_send(&wmi_ab->wmi[0],
+				  skb,
+				  WMI_PDEV_SET_BIOS_INTERFACE_CMDID);
+	if (ret) {
+		ath12k_warn(ab,
+			    "failed to send WMI_PDEV_SET_BIOS_INTERFACE_CMDID %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8c6b16a572ee..fa03c0f507d4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4811,6 +4811,7 @@ enum bios_param_type {
 	WMI_BIOS_PARAM_CCA_THRESHOLD_TYPE	=	0,
 	WMI_BIOS_PARAM_TAS_CONFIG_TYPE		=	1,
 	WMI_BIOS_PARAM_TAS_DATA_TYPE		=	2,
+	WMI_BIOS_PARAM_TYPE_BANDEDGE_CTL_POWER	=	3,
 	WMI_BIOS_PARAM_TYPE_MAX,
 };
 
@@ -4982,4 +4983,5 @@ int ath12k_wmi_pdev_set_bios_sar_table_param(struct ath12k_base *ab,
 int ath12k_wmi_pdev_set_bios_geo_table_param(struct ath12k_base *ab,
 					     u8 *pgeo_table);
 int ath12k_wmi_pdev_set_cca_thr_table_param(struct ath12k_base *ab);
+int ath12k_wmi_pdev_set_band_edge_power(struct ath12k_base *ab);
 #endif
-- 
2.34.1

