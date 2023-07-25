Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAB7627A5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 02:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGZALS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 20:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZALR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 20:11:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D81AD
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 17:11:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PMMcFN020538;
        Tue, 25 Jul 2023 22:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=prNiTbjF56KR1wKuzRGRZ2M5D2yZeAr0/YXKcg345yk=;
 b=ZRkbjfPuAPneZLzQi4I9ElI4NnLhOKSXOKdB7Uq8R/hrqTHyPG8Oa0pTD3VPjGjk4PQX
 pqi4YXf/2FJcB8ntPxI3T5htE6nU9qGRvVGDMFm/dwy51Av/+YXPjzyeb4o4W3iRffH7
 H8/7yARqRDRtFbuGjS/uCmIvbwoJqgsmvK1A0RRm6PIwED3If4EM1VUFiOUdfODm2zRP
 3uGhNhkrpkwE/KR2I2aXrn7dSgyaqgzXLnpN8mEeDu9l4EZvunF6n7tCzJKtxdOMqcXS
 P1OfLhdzsjouvqpNgqBrDoghLWxGRs9dkOAns4QW5623zwg/DI1Abb3kcMY5cueONtdN SA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2aq69t7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PMenRH027727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 22:40:49 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 15:40:48 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v5 10/11] wifi: ath12k: parse WMI service ready ext2 event
Date:   Tue, 25 Jul 2023 15:40:33 -0700
Message-ID: <20230725224034.14045-11-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725224034.14045-1-quic_alokad@quicinc.com>
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CsHbaKVvZkQuOo3NRAmhi8jhqk5Hc4PB
X-Proofpoint-ORIG-GUID: CsHbaKVvZkQuOo3NRAmhi8jhqk5Hc4PB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Parse WMI service ready ext2 event.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v5: No change from v4.
v4: No change from v3.
v3: No change from v2.
v2: No change from v1.

 drivers/net/wireless/ath/ath12k/wmi.c | 48 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 16 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 1debda890b8c..f4093beb8536 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -62,7 +62,23 @@ struct ath12k_wmi_svc_rdy_ext_parse {
 	bool dma_ring_cap_done;
 };
 
+struct ath12k_wmi_svc_rdy_ext2_arg {
+	u32 reg_db_version;
+	u32 hw_min_max_tx_power_2ghz;
+	u32 hw_min_max_tx_power_5ghz;
+	u32 chwidth_num_peer_caps;
+	u32 preamble_puncture_bw;
+	u32 max_user_per_ppdu_ofdma;
+	u32 max_user_per_ppdu_mumimo;
+	u32 target_cap_flags;
+	u32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
+	u32 max_num_linkview_peers;
+	u32 max_num_msduq_supported_per_tid;
+	u32 default_num_msduq_supported_per_tid;
+};
+
 struct ath12k_wmi_svc_rdy_ext2_parse {
+	struct ath12k_wmi_svc_rdy_ext2_arg arg;
 	struct ath12k_wmi_dma_ring_caps_parse dma_caps_parse;
 	bool dma_ring_cap_done;
 	bool spectral_bin_scaling_done;
@@ -4098,6 +4114,26 @@ static int ath12k_service_ready_ext_event(struct ath12k_base *ab,
 	return ret;
 }
 
+static int ath12k_pull_svc_ready_ext2(struct ath12k_wmi_pdev *wmi_handle,
+				      const void *ptr,
+				      struct ath12k_wmi_svc_rdy_ext2_arg *arg)
+{
+	const struct wmi_service_ready_ext2_event *ev = ptr;
+
+	if (!ev)
+		return -EINVAL;
+
+	arg->reg_db_version = le32_to_cpu(ev->reg_db_version);
+	arg->hw_min_max_tx_power_2ghz = le32_to_cpu(ev->hw_min_max_tx_power_2ghz);
+	arg->hw_min_max_tx_power_5ghz = le32_to_cpu(ev->hw_min_max_tx_power_5ghz);
+	arg->chwidth_num_peer_caps = le32_to_cpu(ev->chwidth_num_peer_caps);
+	arg->preamble_puncture_bw = le32_to_cpu(ev->preamble_puncture_bw);
+	arg->max_user_per_ppdu_ofdma = le32_to_cpu(ev->max_user_per_ppdu_ofdma);
+	arg->max_user_per_ppdu_mumimo = le32_to_cpu(ev->max_user_per_ppdu_mumimo);
+	arg->target_cap_flags = le32_to_cpu(ev->target_cap_flags);
+	return 0;
+}
+
 static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 				      const __le32 cap_mac_info[],
 				      const __le32 cap_phy_info[],
@@ -4221,10 +4257,22 @@ static int ath12k_wmi_svc_rdy_ext2_parse(struct ath12k_base *ab,
 					 u16 tag, u16 len,
 					 const void *ptr, void *data)
 {
+	struct ath12k_wmi_pdev *wmi_handle = &ab->wmi_ab.wmi[0];
 	struct ath12k_wmi_svc_rdy_ext2_parse *parse = data;
 	int ret;
 
 	switch (tag) {
+	case WMI_TAG_SERVICE_READY_EXT2_EVENT:
+		ret = ath12k_pull_svc_ready_ext2(wmi_handle, ptr,
+						 &parse->arg);
+		if (ret) {
+			ath12k_warn(ab,
+				    "failed to extract wmi service ready ext2 parameters: %d\n",
+				    ret);
+			return ret;
+		}
+		break;
+
 	case WMI_TAG_ARRAY_STRUCT:
 		if (!parse->dma_ring_cap_done) {
 			ret = ath12k_wmi_dma_ring_caps(ab, len, ptr,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 764ca4947281..12a393302ebd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1925,6 +1925,7 @@ enum wmi_tlv_tag {
 	/* TODO add all the missing cmds */
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_CMD = 0x301,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_INFO,
+	WMI_TAG_SERVICE_READY_EXT2_EVENT = 0x334,
 	WMI_TAG_FILS_DISCOVERY_TMPL_CMD = 0x344,
 	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
@@ -2612,6 +2613,21 @@ struct ath12k_wmi_soc_hal_reg_caps_params {
 #define WMI_EHT_MCS_NSS_10_11  GENMASK(11, 8)
 #define WMI_EHT_MCS_NSS_12_13  GENMASK(15, 12)
 
+struct wmi_service_ready_ext2_event {
+	__le32 reg_db_version;
+	__le32 hw_min_max_tx_power_2ghz;
+	__le32 hw_min_max_tx_power_5ghz;
+	__le32 chwidth_num_peer_caps;
+	__le32 preamble_puncture_bw;
+	__le32 max_user_per_ppdu_ofdma;
+	__le32 max_user_per_ppdu_mumimo;
+	__le32 target_cap_flags;
+	__le32 eht_cap_mac_info[WMI_MAX_EHTCAP_MAC_SIZE];
+	__le32 max_num_linkview_peers;
+	__le32 max_num_msduq_supported_per_tid;
+	__le32 default_num_msduq_supported_per_tid;
+} __packed;
+
 struct ath12k_wmi_caps_ext_params {
 	__le32 hw_mode_id;
 	union {
-- 
2.39.0

