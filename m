Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05059628A54
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiKNUTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiKNUT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB10E24
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEJtsmE015905;
        Mon, 14 Nov 2022 20:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=oPie5dD/iSznhdOlGx0nadX5ACzNfJQXxEiSTkqvrGg=;
 b=IGurx8NWPD+hTeUsHWquVghyGCdRqGwqCbmSqb3KhDuYlkjMZYsvitDQdagqXYNV8N18
 XRodqx7aW2wAkH+5F49VJAUdYazFXjzUc1rOd7h8rZuVq021t5ebCgNlMc7bFlF8FNr3
 W3ugIQ+Ed3WD0GO80YsGoPYTVPn1TD5Vb0JoSk96JMgLYlah7YHS92DcE1Dv0vAnETKh
 d4UtAUeRW6INNi6fwK8kapXg/mlagGzt5+Wx5i8GiLpwOcKZURCOyfn+Oqb60IJi8Jh2
 2D1t5GXmoEAxxBV+B/cLD9BFYiZ8JzWhMk8ZEA9GbjEv/C81Tpb3/v5N4i1UhliNv4OG 9g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kut8x0e13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJN56028462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:23 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 07/10] ath11k: configure MBSSID device parameters
Date:   Mon, 14 Nov 2022 12:19:09 -0800
Message-ID: <20221114201912.22893-8-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s_KiLOsZTi6bOTsyaEVg0XBTAonlwHrY
X-Proofpoint-ORIG-GUID: s_KiLOsZTi6bOTsyaEVg0XBTAonlwHrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=865 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new field nontransmitting_vif_count in struct ath11k_vif which
keeps track of non-transmitting interfaces associated with a
transmitting interface when MBSSID is enabled.
The count is decremented when WMI vdev down is invoked and incremented
when WMI vdev up is invoked.
Use this field to set the newly added members of struct vdev_up_params,
profile idx and profile_cnt, during WMI vdev up operation.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
v2: Additions in struct vdev_up_params moved from patch 5/9 in v1 to
this patch.

 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 32 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c  |  5 ++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  3 +++
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 22460b0abf03..abe3b9b35c8f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -358,6 +358,8 @@ struct ath11k_vif {
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_twt;
 #endif /* CONFIG_ATH11K_DEBUGFS */
+
+	u8 nontransmitting_vif_count;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d4b87d4de22a..64886f9a0358 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1425,9 +1425,13 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct ath11k_vif *tx_arvif = NULL;
 	int ret = 0;
 	struct vdev_up_params params = { 0 };
 
+	if (arvif->vif->mbssid_tx_vif)
+		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+
 	lockdep_assert_held(&arvif->ar->conf_mutex);
 
 	if (!info->enable_beacon) {
@@ -1437,6 +1441,9 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				    arvif->vdev_id, ret);
 
 		arvif->is_up = false;
+		if (tx_arvif)
+			tx_arvif->nontransmitting_vif_count = 0;
+
 		return;
 	}
 
@@ -1457,6 +1464,13 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = arvif->aid;
 	params.bssid = arvif->bssid;
+	if (tx_arvif) {
+		params.tx_bssid = tx_arvif->bssid;
+		params.profile_idx = info->bssid_index;
+		if (params.profile_idx >= tx_arvif->nontransmitting_vif_count)
+			tx_arvif->nontransmitting_vif_count = params.profile_idx;
+		params.profile_cnt = tx_arvif->nontransmitting_vif_count;
+	}
 	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
@@ -2818,7 +2832,7 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv, *tx_arvif;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2832,6 +2846,11 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 
 	arvif->is_up = false;
+	if (arvif->vif->mbssid_tx_vif) {
+		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+		if (tx_arvif != arvif)
+			tx_arvif->nontransmitting_vif_count--;
+	}
 
 	memset(&arvif->rekey_data, 0, sizeof(arvif->rekey_data));
 
@@ -3383,7 +3402,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				info->he_bss_color.enabled);
+				arvif->vif->bss_conf.nontransmitted ?
+				0 : info->he_bss_color.enabled);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
@@ -7007,7 +7027,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			   int n_vifs)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif;
+	struct ath11k_vif *arvif, *tx_arvif;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7066,6 +7086,12 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = arvif->aid;
 		params.bssid = arvif->bssid;
+		if (arvif->vif->mbssid_tx_vif) {
+			tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+			params.tx_bssid = tx_arvif->bssid;
+			params.profile_idx = arvif->vif->bss_conf.bssid_index;
+			params.profile_cnt = tx_arvif->nontransmitting_vif_count;
+		}
 		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b108ce423e8e..bd3a6feda540 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1017,6 +1017,11 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 
 	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
+	cmd->profile_idx = params->profile_idx;
+	cmd->profile_cnt = params->profile_cnt;
+	if (params->tx_bssid)
+		ether_addr_copy(cmd->tx_vdev_bssid.addr, params->tx_bssid);
+
 	if (arvif && arvif->vif->type == NL80211_IFTYPE_STATION) {
 		bss_conf = &arvif->vif->bss_conf;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 1a563e88f7fb..e0ffe198b95f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2616,6 +2616,9 @@ struct vdev_up_params {
 	u32 vdev_id;
 	u32 aid;
 	const u8 *bssid;
+	u32 profile_idx;
+	u32 profile_cnt;
+	u8 *tx_bssid;
 };
 
 struct wmi_vdev_up_cmd {
-- 
2.17.1

