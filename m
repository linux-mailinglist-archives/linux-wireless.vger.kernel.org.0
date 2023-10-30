Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABD7DC26C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJ3W1t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjJ3W1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F7FE
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:44 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UM7uR1028002;
        Mon, 30 Oct 2023 22:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=F8LiVZZSwSOMvtokTgHKWp1Tyez2a9SaGzHSzQob2i8=;
 b=VY/e1g6ccsN69xNcWHhGEg/kUjoa2vVNr5GEkaYrJK0qkfopmFjkgdMKuMVfUC+glRma
 nS/7/PT1Zkto7cq6YNtb64ktmOycvAJagov3Gn139UnqKMD8ALzxZrCsI8YRmvQ3NowE
 sH7cZ0gw4IOkwa0CA5+TtNPoyBemPtP5DAXU6cbmVfUFUa8/7h/1lpeloixQ2fRfQvxX
 7ZY/1fbePwndNTrQi2nNlahOfBcloyLTnl0t2w6Yb4nxtI1kQaX7TfvSHNO/IyXnEGlu
 XRlSJzU0d0Z9Eh2Q3Y2DiVpslWTEchbrl+9xUUaGDua5jCAsWfcLm+m88Ng7IvlDKtAy 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey175n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMReEY020694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:40 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:38 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 03/13] wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID
Date:   Tue, 31 Oct 2023 03:56:50 +0530
Message-ID: <20231030222700.18914-4-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BiGCmaRLHnCnDKAL_wD7wK3yBFJevCTY
X-Proofpoint-GUID: BiGCmaRLHnCnDKAL_wD7wK3yBFJevCTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=905
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

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Currently while fetching for pdev id from WMI_SERVICE_READY_EXT_EVENTID
we consider 32 bit pdev_id in ath12k_wmi_caps_ext_params structure. But
Firmware sends lower 16 bit for pdev id along with higher 16 bit for
hw_link_id. Due to this wrong pdev id is fetched. This wrong pdev id
when used for WMI commands leads to Firmware crash.

Hence fetch the correct pdev id considering only the lower 16 bits.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c |  9 +++---
 drivers/net/wireless/ath/ath12k/wmi.h | 44 ++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 88ec77dee..ead77688a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -493,13 +493,13 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 
 	mac_caps = wmi_mac_phy_caps + phy_idx;
 
-	pdev->pdev_id = le32_to_cpu(mac_caps->pdev_id);
+	pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 
 	fw_pdev = &ab->fw_pdev[ab->fw_pdev_count];
 	fw_pdev->supported_bands = le32_to_cpu(mac_caps->supported_bands);
-	fw_pdev->pdev_id = le32_to_cpu(mac_caps->pdev_id);
+	fw_pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	fw_pdev->phy_id = le32_to_cpu(mac_caps->phy_id);
 	ab->fw_pdev_count++;
 
@@ -4215,7 +4215,7 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 		for (i = 0; i < ab->fw_pdev_count; i++) {
 			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
 
-			if (fw_pdev->pdev_id == le32_to_cpu(caps->pdev_id) &&
+			if (fw_pdev->pdev_id == ath12k_wmi_caps_ext_get_pdev_id(caps) &&
 			    fw_pdev->phy_id == le32_to_cpu(caps->phy_id)) {
 				bands = fw_pdev->supported_bands;
 				break;
@@ -4272,7 +4272,8 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 			return 0;
 	} else {
 		for (i = 0; i < ab->num_radios; i++) {
-			if (ab->pdevs[i].pdev_id == le32_to_cpu(caps->pdev_id))
+			if (ab->pdevs[i].pdev_id ==
+			    ath12k_wmi_caps_ext_get_pdev_id(caps))
 				break;
 		}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index dfe9eb0cb..0fa73a651 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2548,9 +2548,17 @@ struct ath12k_wmi_hw_mode_cap_params {
 
 #define WMI_MAX_HECAP_PHY_SIZE                 (3)
 
+/* pdev_id is present in lower 16 bits of pdev_and_hw_link_ids in
+ * ath12k_wmi_mac_phy_caps_params & ath12k_wmi_caps_ext_params.
+ *
+ * hw_link_id is present in higher 16 bits of pdev_and_hw_link_ids.
+ */
+#define WMI_CAPS_PARAMS_PDEV_ID		GENMASK(15, 0)
+#define WMI_CAPS_PARAMS_HW_LINK_ID	GENMASK(31, 16)
+
 struct ath12k_wmi_mac_phy_caps_params {
 	__le32 hw_mode_id;
-	__le32 pdev_id;
+	__le32 pdev_and_hw_link_ids;
 	__le32 phy_id;
 	__le32 supported_flags;
 	__le32 supported_bands;
@@ -2642,13 +2650,7 @@ struct wmi_service_ready_ext2_event {
 
 struct ath12k_wmi_caps_ext_params {
 	__le32 hw_mode_id;
-	union {
-		struct {
-			__le16 pdev_id;
-			__le16 hw_link_id;
-		} __packed ath12k_wmi_pdev_to_link_map;
-		__le32 pdev_id;
-	};
+	__le32 pdev_and_hw_link_ids;
 	__le32 phy_id;
 	__le32 wireless_modes_ext;
 	__le32 eht_cap_mac_info_2ghz[WMI_MAX_EHTCAP_MAC_SIZE];
@@ -4950,4 +4952,30 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
 
+static inline u32
+ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids, WMI_CAPS_PARAMS_PDEV_ID);
+}
+
+static inline u32
+ath12k_wmi_caps_ext_get_hw_link_id(const struct ath12k_wmi_caps_ext_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids, WMI_CAPS_PARAMS_HW_LINK_ID);
+}
+
+static inline u32
+ath12k_wmi_mac_phy_get_pdev_id(const struct ath12k_wmi_mac_phy_caps_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids,
+			     WMI_CAPS_PARAMS_PDEV_ID);
+}
+
+static inline u32
+ath12k_wmi_mac_phy_get_hw_link_id(const struct ath12k_wmi_mac_phy_caps_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids,
+			     WMI_CAPS_PARAMS_HW_LINK_ID);
+}
+
 #endif
-- 
2.17.1

