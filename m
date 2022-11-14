Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8EF628A5D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiKNUTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiKNUTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E154B843
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:29 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEJwgBp011523;
        Mon, 14 Nov 2022 20:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NPxm5plIby1eE+7FRKVOUCqr3+FFldpUrctIVmB0vyQ=;
 b=lZT+XOA7ojWOUGOfNNhA6bdqIrvgTvNwyCGmL7H9zSrgm6Z8QxvvkumK3zFa8c25Kx7Z
 Ha+bB89Yubc4TYsWZm3Af8Li7wnvyRKnT6fuKyfZmQ4x+01kivbUYt3qTmq9yFhATG9e
 8/vH6S2eOHCXDoOM5YksFuAkUWVMU24l44r4w37QgrFHQppMyESTUwQpSGpZtdvmCMxp
 CjR+e9b+HPx7B8E+qvbTqKiqmk/FkycPHRBZ8jfeyInBwQqt1VNucP2jkDKzAIYQ0OVv
 yq0nSbovuQnC6u9X4j+5UnZ+jsV7SLPTx8IV2mOE6WGM4ez0/WUeAp/v98rj0Tykvlhr kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusye0h34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJOtG025532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:24 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:24 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 09/10] ath11k: EMA beacon support
Date:   Mon, 14 Nov 2022 12:19:11 -0800
Message-ID: <20221114201912.22893-10-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: iwtfHgFn1XsVh_p0lc-jsvdN9_7GYUuG
X-Proofpoint-ORIG-GUID: iwtfHgFn1XsVh_p0lc-jsvdN9_7GYUuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new function ath11k_mac_setup_bcn_tmpl_ema() which invokes the new
API provided by MAC80211 to retrieve EMA beacons. For non EMA APs,
ath11k_mac_setup_bcn_tmpl_legacy() is added which maintains the current
functionality.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 103 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.h |  12 ++-
 3 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eef7fe61b7d9..a47f24ba767e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1376,37 +1376,114 @@ static void ath11k_mac_setup_bcn_tmpl_vif_params(struct ath11k_vif *arvif,
 		arvif->wpaie_present = false;
 }
 
-static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+static int __ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif,
+				       struct sk_buff *bcn,
+				       struct ieee80211_mutable_offsets offs,
+				       int ema_idx, int ema_cnt)
 {
 	struct ath11k *ar = arvif->ar;
-	struct ath11k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
-	struct ieee80211_vif *vif = arvif->vif;
+	u32 ema_param = 0;
+
+	if (ema_cnt) {
+		ema_param = (ema_cnt << WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT);
+		ema_param |= (ema_idx << WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT);
+		ema_param |= ((!ema_idx ? 1 : 0) <<
+			      WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT);
+		ema_param |= ((ema_idx + 1 == ema_cnt ? 1 : 0) <<
+			      WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT);
+	}
+
+	return ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, ema_param);
+}
+
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+{
+	struct ath11k_vif *tx_arvif;
+	struct ieee80211_ema_beacons *beacons;
+	u8 i = 0;
+	int ret = 0;
+
+	if (!arvif->vif->mbssid_tx_vif)
+		return -1;
+
+	tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
+							 tx_arvif->vif, 0);
+	if (!beacons || !beacons->cnt) {
+		ath11k_warn(arvif->ar->ab,
+			    "failed to get ema beacon templates from mac80211\n");
+		return -EPERM;
+	}
+
+	if (tx_arvif == arvif)
+		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif,
+						     beacons->bcn[0].skb);
+
+	for (i = 0; i < beacons->cnt; i++) {
+		ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, beacons->bcn[i].skb,
+						  beacons->bcn[i].offs,
+						  i, beacons->cnt);
+		if (ret) {
+			ath11k_warn(arvif->ar->ab,
+				    "failed to set ema beacon template id %i error %d\n",
+				    i, ret);
+			break;
+		}
+	}
+
+	ieee80211_beacon_free_ema_list(beacons);
+	return ret;
+}
+
+static int ath11k_mac_setup_bcn_tmpl_non_ema(struct ath11k_vif *arvif)
+{
+	struct ath11k_vif *tx_arvif = arvif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
-		return 0;
+	if (arvif->vif->mbssid_tx_vif)
+		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
 
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
+	bcn = ieee80211_beacon_get_template(tx_arvif->ar->hw, tx_arvif->vif,
+					    &offs, 0);
 	if (!bcn) {
-		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
+		ath11k_warn(arvif->ar->ab,
+			    "failed to get beacon template from mac80211\n");
 		return -EPERM;
 	}
 
-	ath11k_mac_setup_bcn_tmpl_vif_params(arvif, bcn);
-	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
-
-	kfree_skb(bcn);
+	if (tx_arvif == arvif)
+		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif, bcn);
 
+	ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, bcn, offs, 0, 0);
 	if (ret)
-		ath11k_warn(ab, "failed to submit beacon template command: %d\n",
+		ath11k_warn(arvif->ar->ab,
+			    "failed to submit beacon template command: %d\n",
 			    ret);
 
+	kfree_skb(bcn);
 	return ret;
 }
 
+static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+{
+	struct ieee80211_vif *vif = arvif->vif;
+
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+		return 0;
+
+	if (vif->mbssid_tx_vif &&
+	    arvif != (void *)vif->mbssid_tx_vif->drv_priv &&
+	    arvif->is_up)
+		return 0;
+
+	if (vif->bss_conf.ema_ap)
+		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+	else
+		return ath11k_mac_setup_bcn_tmpl_non_ema(arvif);
+}
+
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bd3a6feda540..77f83fda08ed 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1690,7 +1690,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn, u32 ema_params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
@@ -1728,6 +1728,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	}
 
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->mbssid_off;
+	cmd->ema_params = ema_params;
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index e0ffe198b95f..86779b9edba0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3555,6 +3555,11 @@ struct wmi_get_pdev_temperature_cmd {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT         0
+#define WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT            8
+#define WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT          16
+#define WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT           24
+
 struct wmi_bcn_tmpl_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -3565,6 +3570,11 @@ struct wmi_bcn_tmpl_cmd {
 	u32 csa_event_bitmap;
 	u32 mbssid_ie_offset;
 	u32 esp_ie_offset;
+	u32 csc_switch_count_offset;
+	u32 csc_event_bitmap;
+	u32 mu_edca_ie_offset;
+	u32 feature_enable_bitmap;
+	u32 ema_params;
 } __packed;
 
 struct wmi_key_seq_counter {
@@ -6020,7 +6030,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn, u32 ema_param);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
-- 
2.17.1

