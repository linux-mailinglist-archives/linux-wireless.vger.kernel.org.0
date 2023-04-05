Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5436D8A7A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 00:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjDEWRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 18:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjDEWRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 18:17:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0D659E
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 15:17:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335MGUg5006999;
        Wed, 5 Apr 2023 22:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=6p0WhPyYOsxZG+SRdZ7y/DE/uVNxgKEG71yhfpXDu2Y=;
 b=onuMoI3w6UP+XP/+7+uhnKYuvN/uCd+PNh2r61VoeIZplgPF59lJPuFg0JiPMpXBlBL3
 n8ENUtnXyOLtPP0LjfrUY4kzVAmxoxXj7caWWrmqjXyVePF3XfP74UK0OIw5BXh4DNwc
 kV8GTC8wWtwRJLgZS0PxWM2XzwgI5MkrvzNBfUDWpTjynCu/hQ3jQ6wqw1qyC53TD+al
 G7Mk7WOSEY9B97Wa2+zEbVQhkS+KpeXjWeURFMORalik80JLwQEM7X2TO4PHDjApmT3E
 H0XCOD6/zW5ZK0Oxc3lkXCJQMaZMcYgKaUBwspYMDKOWAdEDg2L74sFxgbU5Q8DwMJMy CA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prn7qm2wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 22:17:00 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335MGxXJ002117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 22:16:59 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 15:16:59 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 7/7] wifi: ath11k: EMA beacon support
Date:   Wed, 5 Apr 2023 15:16:48 -0700
Message-ID: <20230405221648.17950-8-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: G9YVWalrUnkpVaM_v7Evue25FsRLZq1q
X-Proofpoint-GUID: G9YVWalrUnkpVaM_v7Evue25FsRLZq1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
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

Add new function ath11k_mac_setup_bcn_tmpl_ema() which invokes the new
API provided by MAC80211 to retrieve EMA beacons.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
v3: Moved the MBSSID (non-EMA) support to the previous patch.
v2: Rebase only.

 drivers/net/wireless/ath/ath11k/mac.c | 59 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c |  3 +-
 drivers/net/wireless/ath/ath11k/wmi.h | 11 ++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ee910fd756f2..ad22ec3d24bf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1452,6 +1452,60 @@ static void ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 		arvif->wpaie_present = false;
 }
 
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+{
+	struct ath11k_vif *tx_arvif;
+	struct ieee80211_ema_beacons *beacons;
+	int ret = 0;
+	bool nontx_vif_params_set = false;
+	u32 params = 0;
+	u8 i = 0;
+
+	tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+
+	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
+							 tx_arvif->vif, 0);
+	if (!beacons || !beacons->cnt) {
+		ath11k_warn(arvif->ar->ab,
+			    "failed to get ema beacon templates from mac80211\n");
+		return -EPERM;
+	}
+
+	if (tx_arvif == arvif)
+		ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb);
+	else
+		arvif->wpaie_present = tx_arvif->wpaie_present;
+
+	for (i = 0; i < beacons->cnt; i++) {
+		if (tx_arvif != arvif && !nontx_vif_params_set)
+			nontx_vif_params_set =
+				ath11k_mac_set_nontx_vif_params(tx_arvif, arvif,
+								beacons->bcn[i].skb);
+
+		params = beacons->cnt;
+		params |= (i << WMI_EMA_TMPL_IDX_SHIFT);
+		params |= ((!i ? 1 : 0) << WMI_EMA_FIRST_TMPL_SHIFT);
+		params |= ((i + 1 == beacons->cnt ? 1 : 0) << WMI_EMA_LAST_TMPL_SHIFT);
+
+		ret = ath11k_wmi_bcn_tmpl(tx_arvif->ar, tx_arvif->vdev_id,
+					  &beacons->bcn[i].offs,
+					  beacons->bcn[i].skb, params);
+		if (ret) {
+			ath11k_warn(tx_arvif->ar->ab,
+				    "failed to set ema beacon template id %i error %d\n",
+				    i, ret);
+			break;
+		}
+	}
+
+	ieee80211_beacon_free_ema_list(beacons);
+
+	if (tx_arvif != arvif && !nontx_vif_params_set)
+		return -EINVAL; /* Profile not found in the beacons */
+
+	return ret;
+}
+
 static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 {
 	struct ath11k *ar = arvif->ar;
@@ -1484,7 +1538,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 	else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn))
 		return -EINVAL;
 
-	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
+	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
 	kfree_skb(bcn);
 
 	if (ret)
@@ -1508,6 +1562,9 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	    arvif != (void *)vif->mbssid_tx_vif->drv_priv && arvif->is_up)
 		return 0;
 
+	if (vif->bss_conf.ema_ap && vif->mbssid_tx_vif)
+		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+
 	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 16bc4d16c7d2..8efdc1e78ae4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1692,7 +1692,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn, u32 ema_params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
@@ -1731,6 +1731,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 
 	cmd->buf_len = bcn->len;
 	cmd->mbssid_ie_offset = offs->mbssid_off;
+	cmd->ema_params = ema_params;
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b83807087174..c036aa037339 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3561,6 +3561,10 @@ struct wmi_get_pdev_temperature_cmd {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_EMA_TMPL_IDX_SHIFT            8
+#define WMI_EMA_FIRST_TMPL_SHIFT          16
+#define WMI_EMA_LAST_TMPL_SHIFT           24
+
 struct wmi_bcn_tmpl_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -3571,6 +3575,11 @@ struct wmi_bcn_tmpl_cmd {
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
@@ -6293,7 +6302,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn, u32 ema_param);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
 		       const u8 *bssid, u8 *tx_bssid, u32 nontx_profile_idx,
-- 
2.39.0

