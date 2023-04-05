Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A436D8A79
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 00:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDEWRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjDEWRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 18:17:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF25BA9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 15:17:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335Lr1S9011054;
        Wed, 5 Apr 2023 22:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6h5kuUZ8GSGBx7RVOfYfrrXvpCx2r9nUW9yYRhJOJUA=;
 b=Rhk9Rko3MEP7CS9n7IdoZsL7bzA26GzDoadXtmF4fTx2wkC0iQHBZlwwbYTwOZXSfZ10
 y9lrQO/hTHfPSmsSTTUW/gUCFNiY0I8w/Fvpm+pLe5APgdiOu7H9TH3JYzsARsFIvHWo
 D1MmWrnfoPgJFsp4NVylUbxIldTbfyBZcxUREk1mRKag20o+CnC1WOmAoUPlqxfIpVgu
 UllJX8dw4K4LxAqTQN5K+irW1aHe+7NxlW2oPpYIJ/15UVLqoRhPLLNoPhpQPAaaK+bz
 4QssbfbYBufDdDGe1Lu63BNXpPdBRhD0krmU7pdkq8V6rMVc5LduYRcgwu7kjTEQPrgA 3g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prn7qm2we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 22:16:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335MGwUL022489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 22:16:58 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 15:16:57 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 4/7] wifi: ath11k: MBSSID parameter configuration in AP mode
Date:   Wed, 5 Apr 2023 15:16:45 -0700
Message-ID: <20230405221648.17950-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230405221648.17950-1-quic_alokad@quicinc.com>
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FxROU4bjZtuzYglAgUgQvBLK05nLBhXn
X-Proofpoint-GUID: FxROU4bjZtuzYglAgUgQvBLK05nLBhXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=872 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050199
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include MBSSID parameters in WMI vdev up operation.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
v3: No logical changes from v2. But '[v2,05/10] ath11k: create a
    structure for WMI vdev up parameters' is deleted in this
    version hence the function prototype is diffferent.

v2: Additions in struct vdev_up_params moved from patch 5/9 in
    v1 to this patch.

 drivers/net/wireless/ath/ath11k/mac.c | 26 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/wmi.c |  8 +++++++-
 drivers/net/wireless/ath/ath11k/wmi.h |  3 ++-
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8c852bf6294f..87f21a3f0ac6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -964,7 +964,7 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 		return ret;
 	}
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr, NULL, 0, 0);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -1423,6 +1423,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct ath11k_vif *tx_arvif = NULL;
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -1451,8 +1452,14 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
+	if (arvif->vif->mbssid_tx_vif)
+		tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
+
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+				 arvif->bssid,
+				 tx_arvif ? tx_arvif->bssid : NULL,
+				 info->bssid_index,
+				 1 << info->bssid_indicator);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -2879,7 +2886,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid,
+				 NULL, 0, 0);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -7099,7 +7107,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			   int n_vifs)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif;
+	struct ath11k_vif *arvif, *tx_arvif = NULL;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7153,8 +7161,13 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
+		if (arvif->vif->mbssid_tx_vif)
+			tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+					 arvif->bssid,
+					 tx_arvif ? tx_arvif->bssid : NULL,
+					 arvif->vif->bss_conf.bssid_index,
+					 1 << arvif->vif->bss_conf.bssid_indicator);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
@@ -7272,7 +7285,8 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr);
+		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr,
+					 NULL, 0, 0);
 		if (ret) {
 			ath11k_warn(ab, "failed put monitor up: %d\n", ret);
 			return ret;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 1265f4c98860..039df4847108 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -994,7 +994,8 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid,
+		       u8 *tx_bssid, u32 nontx_profile_idx, u32 nontx_profile_cnt)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -1018,6 +1019,11 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
 
+	cmd->nontx_profile_idx = nontx_profile_idx;
+	cmd->nontx_profile_cnt = nontx_profile_cnt;
+	if (tx_bssid)
+		ether_addr_copy(cmd->tx_vdev_bssid.addr, tx_bssid);
+
 	if (arvif && arvif->vif->type == NL80211_IFTYPE_STATION) {
 		bss_conf = &arvif->vif->bss_conf;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index cc695318ab7c..b83807087174 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -6296,7 +6296,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct sk_buff *bcn);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+		       const u8 *bssid, u8 *tx_bssid, u32 nontx_profile_idx,
+		       u32 nontx_profile_cnt);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.39.0

