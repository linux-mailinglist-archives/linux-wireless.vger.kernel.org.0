Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489EE530AF3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiEWHqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiEWHqm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB118B03
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653292000; x=1684828000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lRFtBepfYOuqz0OgRXKPpKI89Q15dBcl7oeg3f9e/w0=;
  b=m9amPMjqKruBNmE2ifc9dhwCoxXAAFqyQLuew9f5x3WVMnFNzNMXXKv/
   Xs2j6QqmbQ1r5JfpRzj9ByEquDuG55LBv81/zUDrEL5Es4+aK4Ueffm2/
   wH9nZ+9epDCe0Ae9+KlWl3M7WCRopwWgvrw15qVbyQL1MRjvnnjy9GwDA
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 May 2022 23:01:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 8/9] ath11k: EMA beacon support
Date:   Sun, 22 May 2022 23:01:07 -0700
Message-ID: <20220523060108.23982-9-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new function ath11k_mac_setup_bcn_tmpl_ema() which invokes the new
API provided by MAC80211 to retrieve EMA beacons. For non EMA APs,
ath11k_mac_setup_bcn_tmpl_legacy() is added which maintains the current
functionality.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 103 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.h |  12 ++-
 3 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ff50341f1574..4ead94554724 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1373,37 +1373,114 @@ static void ath11k_mac_setup_bcn_tmpl_vif_params(struct ath11k_vif *arvif,
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
+							 tx_arvif->vif);
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
+					    &offs);
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
index fa443a2646b5..362c516db07f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1676,7 +1676,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn, u32 ema_params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
@@ -1714,6 +1714,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	}
 
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->mbssid_off;
+	cmd->ema_params = ema_params;
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index fa46fb6ef1ad..f66131d915c8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3554,6 +3554,11 @@ struct wmi_get_pdev_temperature_cmd {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT         0
+#define WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT            8
+#define WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT          16
+#define WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT           24
+
 struct wmi_bcn_tmpl_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -3564,6 +3569,11 @@ struct wmi_bcn_tmpl_cmd {
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
@@ -6005,7 +6015,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn, u32 ema_param);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
-- 
2.31.1

