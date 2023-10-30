Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5307DC26D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjJ3W1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJ3W1t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54098C6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULtJWu002144;
        Mon, 30 Oct 2023 22:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=oCdQz+w5aPjXPKrgIivnaoFls1dP8AheoVNQ3yVg2Gs=;
 b=morwlZ/cds2dh9RVACOPCrTd6srCKpFUkcuwutkqW0e9Fe+4ITI60+5qG7X7cAXPgQm1
 i9uYbPR/1uooZIhv4GGIc4cWqjOrHtjtsH4mM/vnWQ69jyXezHbbpFQiLpDYXicY+Gt3
 OX9Cqxd8CNrCE/zd3Um9G9uJKnJOmao11gUOrZ+kBkOykjahOjWb6i8YDe9AdaqmYHYw
 15bxPOm2FG87htxhtxJwM18R50BooN7npRothYUoNB3JKFfaBcDwkCitv6K2pUaMZWct
 vQGdfTR3ZOjcHq7MtV04Xf5RBlUw6FbN32db2NWSVLWPcF2844pahtDQyUma/Gc/ol4g qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey175q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:43 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRg99021337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:42 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:40 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 04/13] wifi: ath12k: add support for peer meta data version
Date:   Tue, 31 Oct 2023 03:56:51 +0530
Message-ID: <20231030222700.18914-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O_8mr1gY_hxoALZDEP8YZ5N6u1ZTPcQi
X-Proofpoint-GUID: O_8mr1gY_hxoALZDEP8YZ5N6u1ZTPcQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Harshitha Prem <quic_hprem@quicinc.com>

Add support to process WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT
service bit. If this service bit is set by firmware, then it expects
host to set rx_peer_meta_data_ver in wmi_resource_config's flags2
with value 3 for QCN9274 to indicate as V1B meta version. If this is
not set firmware crash is seen during peer addition.

Hence, if WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT service bit
is set by firmware, set correct peer metadata version to avoid
firmware crash.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.h  | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.c | 6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 2d6427cf4..2fb50941c 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -66,6 +66,8 @@
 #define TARGET_NUM_WDS_ENTRIES		32
 #define TARGET_DMA_BURST_SIZE		1
 #define TARGET_RX_BATCHMODE		1
+#define TARGET_RX_PEER_METADATA_VER_V1A	2
+#define TARGET_RX_PEER_METADATA_VER_V1B	3
 
 #define ATH12K_HW_MAX_QUEUES		4
 #define ATH12K_QUEUE_LEN		4096
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ead77688a..460f38a22 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -228,6 +228,9 @@ void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 	config->peer_map_unmap_version = 0x32;
 	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT, ab->wmi_ab.svc_map))
+		config->dp_peer_meta_data_ver = TARGET_RX_PEER_METADATA_VER_V1B;
 }
 
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -3266,6 +3269,9 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
 	wmi_cfg->twt_ap_sta_count = cpu_to_le32(tg_cfg->twt_ap_sta_count);
+	wmi_cfg->flags2 = le32_encode_bits(tg_cfg->dp_peer_meta_data_ver,
+					   WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION);
+
 	wmi_cfg->host_service_flags = cpu_to_le32(tg_cfg->is_reg_cc_ext_event_supported <<
 				WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0fa73a651..8377e8b5a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2161,6 +2161,8 @@ enum wmi_tlv_service {
 
 	WMI_TLV_SERVICE_11BE = 289,
 
+	WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT = 365,
+
 	WMI_MAX_EXT2_SERVICE,
 };
 
@@ -2356,6 +2358,7 @@ struct ath12k_wmi_resource_config_arg {
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
 	bool is_reg_cc_ext_event_supported;
+	u8  dp_peer_meta_data_ver;
 };
 
 struct ath12k_wmi_init_cmd_arg {
@@ -2408,6 +2411,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
+#define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 
 struct ath12k_wmi_resource_config_params {
 	__le32 tlv_header;
-- 
2.17.1

