Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8F2FC5EA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 01:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbhATAeh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 19:34:37 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:55065 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbhATAdV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 19:33:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611102777; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ccY7X0iCiIayizldYYaZuq9rdMjyVrhM68DqrWglyew=; b=UlzTk0p0iPLMCiBVnZ5Qoa4fUF+BjzLAXl4cfY0eXCP6DzfmB5TBa0vHDJKccAMNj1X7YaPm
 b9dTj8UvAnWjkHITLKef83/XXLqsZFB9WDuXdeRo03EleQlIJ4+I6QhHa6FLUpJMITng/UL6
 mXntsYz2MDqMtjXpvOA2CSFhnnI=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60077a1e21210999ed830cac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 00:32:30
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 987E1C433ED; Wed, 20 Jan 2021 00:32:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8964DC433C6;
        Wed, 20 Jan 2021 00:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8964DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6] ath11k: add multiple bssid support
Date:   Tue, 19 Jan 2021 16:32:21 -0800
Message-Id: <20210120003221.21984-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add the required wmi support and make use of it in the beacon template
code. We need to split the beacon code up into 2 code paths so that
we can also send EMA templates.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v6:
Modified beacon_tx_offload_max_vdev to include EMA VAPs required
by firmware to allocate enough memory for beacon templates.
New hardware flags max_num_vaps and max_profile_periodicity.
Initialized instances of struct vdev_up_params to avoid random
values.

 drivers/net/wireless/ath/ath11k/hw.c  |   3 +
 drivers/net/wireless/ath/ath11k/hw.h  |   1 +
 drivers/net/wireless/ath/ath11k/mac.c | 201 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c |  28 +++-
 drivers/net/wireless/ath/ath11k/wmi.h |  90 +++++++++++-
 5 files changed, 287 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 66331da35012..11a35af7d794 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -129,6 +129,9 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->peer_map_unmap_v2_support = 1;
 	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
+	config->ema_max_vap_cnt = ab->num_radios;
+	config->ema_max_profile_period = TARGET_EMA_MAX_PROFILE_PERIOD;
+	config->beacon_tx_offload_max_vdev += config->ema_max_vap_cnt;
 }
 
 static int ath11k_hw_mac_id_to_pdev_id_ipq8074(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 8af0034fdb05..5dabbec954ce 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -62,6 +62,7 @@
 #define TARGET_NUM_WDS_ENTRIES		32
 #define TARGET_DMA_BURST_SIZE		1
 #define TARGET_RX_BATCHMODE		1
+#define TARGET_EMA_MAX_PROFILE_PERIOD	8
 
 #define ATH11K_HW_MAX_QUEUES		4
 #define ATH11K_QUEUE_LEN		4096
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c1608f64ea95..78c161b9dc7f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -717,9 +717,12 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 
 static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 {
+	struct vdev_up_params params = { 0 };
 	int ret = 0;
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	params.vdev_id = vdev_id;
+	params.bssid = ar->mac_addr;
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -741,27 +744,18 @@ static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return 0;
 }
 
-static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+static int __ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif,
+				       struct sk_buff *bcn,
+				       struct ieee80211_mutable_offsets offs,
+				       int ema_idx, int ema_cnt)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
-	struct ieee80211_vif *vif = arvif->vif;
-	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn;
 	struct ieee80211_mgmt *mgmt;
+	u32 ema_param = 0;
 	u8 *ies;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
-		return 0;
-
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
-	if (!bcn) {
-		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
-		return -EPERM;
-	}
-
 	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
 	ies += sizeof(mgmt->u.beacon);
 
@@ -773,21 +767,96 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 				    ies, (skb_tail_pointer(bcn) - ies)))
 		arvif->wpaie_present = true;
 
-	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
+	if (ema_cnt) {
+		ema_param = (ema_cnt << WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT);
+		ema_param |= (ema_idx << WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT);
+		ema_param |= ((!ema_idx ? 1 : 0) <<
+			      WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT);
+		ema_param |= ((ema_idx + 1 == ema_cnt ? 1 : 0) <<
+			      WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT);
+	}
 
-	kfree_skb(bcn);
+	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, ema_param);
 
 	if (ret)
-		ath11k_warn(ab, "failed to submit beacon template command: %d\n",
+		ath11k_warn(ab,
+			    "failed to submit beacon template command: %d\n",
 			    ret);
 
 	return ret;
 }
 
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_ema_bcn_list *bcn;
+	struct ieee80211_hw *hw = ar->hw;
+	struct list_head bcns;
+	int cnt, idx = 0, ret = 0;
+
+	INIT_LIST_HEAD(&bcns);
+	cnt = ieee80211_beacon_get_template_ema_list(hw, vif, &bcns);
+	if (!cnt) {
+		ath11k_warn(ar->ab,
+			    "failed to get ema beacon template from mac80211\n");
+		return -EPERM;
+	}
+
+	list_for_each_entry(bcn, &bcns, list) {
+		ret = __ath11k_mac_setup_bcn_tmpl(arvif, bcn->skb, bcn->offs, idx++, cnt);
+		if (ret)
+			break;
+	}
+
+	ieee80211_beacon_free_ema_list(&bcns);
+
+	return ret;
+}
+
+static int ath11k_mac_setup_bcn_tmpl_legacy(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_mutable_offsets offs = {};
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_hw *hw = ar->hw;
+	struct sk_buff *bcn;
+	int ret;
+
+	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
+	if (!bcn) {
+		ath11k_warn(ar->ab,
+			    "failed to get beacon template from mac80211\n");
+		return -EPERM;
+	}
+
+	ret = __ath11k_mac_setup_bcn_tmpl(arvif, bcn, offs, 0, 0);
+
+	kfree_skb(bcn);
+
+	return ret;
+}
+
+static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+{
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+		return 0;
+
+	if (arvif->vif->multiple_bssid.flags &
+	    IEEE80211_VIF_MBSS_NON_TRANSMITTING)
+		return 0;
+
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+
+	return ath11k_mac_setup_bcn_tmpl_legacy(arvif);
+}
+
 static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct vdev_up_params params = { 0 };
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -815,9 +884,19 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	arvif->aid = 0;
 
 	ether_addr_copy(arvif->bssid, info->bssid);
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+		struct ath11k_vif *pvif;
+
+		pvif = (struct ath11k_vif *)arvif->vif->multiple_bssid.parent->drv_priv;
 
-	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+		params.trans_bssid = pvif->bssid;
+	}
+
+	params.vdev_id = arvif->vdev_id;
+	params.bssid = arvif->bssid;
+	params.profile_num = info->multiple_bssid.count;
+	params.profile_idx = info->multiple_bssid.index;
+	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -1665,6 +1744,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct peer_assoc_params peer_arg;
+	struct vdev_up_params params = { 0 };
 	struct ieee80211_sta *ap_sta;
 	int ret;
 
@@ -1713,7 +1793,10 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = bss_conf->aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	params.vdev_id = arvif->vdev_id;
+	params.bssid = bss_conf->bssid;
+	params.aid = bss_conf->aid;
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -2122,7 +2205,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				info->he_bss_color.enabled);
+				(arvif->vif->multiple_bssid.flags &
+				 IEEE80211_VIF_MBSS_NON_TRANSMITTING) ?
+				0 : info->he_bss_color.enabled);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
@@ -4306,7 +4391,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void
+static int
 ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 				    struct vdev_create_params *params)
 {
@@ -4317,6 +4402,29 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 	params->type = arvif->vdev_type;
 	params->subtype = arvif->vdev_subtype;
 	params->pdev_id = pdev->pdev_id;
+	params->vdevid_trans = 0;
+
+	if (!test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		      ar->ab->wmi_ab.svc_map)) {
+		if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+			struct ieee80211_vif *parent;
+
+			params->flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+			parent = arvif->vif->multiple_bssid.parent;
+			if (!parent)
+				return -ENOENT;
+			if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
+				return -EINVAL;
+			params->vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
+		} else if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+			params->flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+		} else {
+			params->flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+		}
+
+		if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+			params->flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
+	}
 
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		params->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
@@ -4331,6 +4439,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static u32
@@ -4510,7 +4619,11 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
 		vif->hw_queue[i] = i % (ATH11K_HW_MAX_QUEUES - 1);
 
-	ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	ret = ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to prepare vdev %d\n", ret);
+		goto err;
+	}
 
 	ret = ath11k_wmi_vdev_create(ar, vif->addr, &vdev_param);
 	if (ret) {
@@ -4968,6 +5081,29 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		   arg.vdev_id, arg.channel.freq,
 		   ath11k_wmi_phymode_str(arg.channel.mode));
 
+	arg.vdevid_trans = 0;
+	if (test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+			struct ieee80211_vif *parent;
+
+			arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+			parent = arvif->vif->multiple_bssid.parent;
+			if (!parent)
+				return -ENOENT;
+			if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
+				return -EINVAL;
+			arg.vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
+		} else if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+			arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+		} else {
+			arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+		}
+
+		if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+			arg.mbss_capability_flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
+	}
+
 	ret = ath11k_wmi_vdev_start(ar, &arg, restart);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to %s WMI vdev %i\n",
@@ -5145,6 +5281,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
+		struct vdev_up_params params = { 0 };
+
 		arvif = (void *)vifs[i].vif->drv_priv;
 
 		if (WARN_ON(!arvif->is_started))
@@ -5165,8 +5303,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			continue;
 		}
 
-		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id,
+		params.bssid = arvif->bssid,
+		params.aid = arvif->aid,
+		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
@@ -6144,19 +6284,23 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 
 static const u8 ath11k_if_types_ext_capa[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 };
 
 static const u8 ath11k_if_types_ext_capa_sta[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
 };
 
 static const u8 ath11k_if_types_ext_capa_ap[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT,
+	[10] = WLAN_EXT_CAPA11_EMA_SUPPORT,
 };
 
 static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
@@ -6273,6 +6417,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID_AP);
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
@@ -6334,6 +6480,9 @@ static int __ath11k_mac_register(struct ath11k *ar)
 				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	}
 
+	ar->hw->wiphy->multiple_bssid.max_num_vaps = TARGET_MAX_BCN_OFFLD;
+	ar->hw->wiphy->multiple_bssid.max_profile_periodicity = TARGET_EMA_MAX_PROFILE_PERIOD;
+
 	ath11k_reg_init(ar);
 
 	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 73869d445c5b..32759a7c4dd9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -651,6 +651,9 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+	cmd->flags = param->flags;
+	cmd->vdevid_trans = param->vdevid_trans;
+
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
@@ -855,6 +858,8 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->cac_duration_ms = arg->cac_duration_ms;
 	cmd->regdomain = arg->regdomain;
 	cmd->he_ops = arg->he_ops;
+	cmd->mbss_capability_flags = arg->mbss_capability_flags;
+	cmd->vdevid_trans = arg->vdevid_trans;
 
 	if (!restart) {
 		if (arg->ssid) {
@@ -908,7 +913,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -923,10 +928,14 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_UP_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
-	cmd->vdev_id = vdev_id;
-	cmd->vdev_assoc_id = aid;
+	cmd->vdev_id = params->vdev_id;
+	cmd->vdev_assoc_id = params->aid;
+	cmd->profile_idx = params->profile_idx;
+	cmd->profile_num = params->profile_num;
 
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	if (params->trans_bssid)
+		ether_addr_copy(cmd->trans_bssid.addr, params->trans_bssid);
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
@@ -935,8 +944,9 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   "WMI mgmt vdev up id 0x%x assoc id %d idx %d num %d bssid %pM trans_bssid %pM\n",
+		   params->vdev_id, params->aid, params->profile_idx, params->profile_num,
+		   params->bssid, params->trans_bssid);
 
 	return ret;
 }
@@ -1583,7 +1593,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn, u32 ema_params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
@@ -1608,6 +1618,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
 	cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->multiple_bssid_offset;
+	cmd->ema_params = ema_params;
 
 	ptr = skb->data + sizeof(*cmd);
 
@@ -3273,6 +3285,8 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->ema_max_vap_cnt = tg_cfg->ema_max_vap_cnt;
+	wmi_cfg->ema_max_profile_period = tg_cfg->ema_max_profile_period;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 993674228c9e..4ac3ca3eeabe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -119,6 +119,14 @@ enum {
 	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
 };
 
+enum {
+	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 0x00000001,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 0x00000002,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 0x00000004,
+	WMI_HOST_VDEV_FLAGS_EMA_MODE		= 0x00000008,
+	WMI_HOST_VDEV_FLAGS_SCAN_MODE_VAP	= 0x00000010,
+};
+
 /*
  * wmi command groups.
  */
@@ -2039,6 +2047,40 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
+	WMI_TLV_SERVICE_WPA3_SAE_ROAM_SUPPORT = 221,
+	WMI_TLV_SERVICE_WPA3_OWE_ROAM_SUPPORT = 222,
+	WMI_TLV_SERVICE_AUDIO_AGGR = 223,
+	WMI_TLV_SERVICE_6GHZ_SUPPORT = 224,
+	WMI_TLV_SERVICE_QMI_STATS_SUPPORT = 225,
+	WMI_TLV_SERVICE_CFR_CAPTURE_FILTER_SUPPORT = 226,
+	WMI_TLV_SERVICE_STA_BSS_MAX_IDLE_TIME = 227,
+	WMI_TLV_SERVICE_BIP_CIPHER_SUPPORT = 228,
+	WMI_TLV_SERVICE_BW_165MHZ_SUPPORT = 229,
+	WMI_TLV_SERVICE_BW_RESTRICTED_80P80_SUPPORT = WMI_TLV_SERVICE_BW_165MHZ_SUPPORT,
+	WMI_TLV_SERVICE_NAN_NDI_SAP_SAP_SCC_SUPPORT = 230,
+	WMI_TLV_SERVICE_NAN_VDEV_SUPPORT = 231,
+	WMI_TLV_SERVICE_AUDIO_SYNC_SUPPORT = 232,
+	WMI_TLV_SERVICE_DUAL_STA_ROAM_SUPPORT = 233,
+	WMI_TLV_SERVICE_PEER_CREATE_CONF = 234,
+	WMI_TLV_SERVICE_MULTIPLE_VDEV_RESTART_RESPONSE_SUPPORT = 235,
+	WMI_TLV_SERVICE_ROAM_SCAN_CHANNEL_LIST_TO_HOST_SUPPORT = 236,
+	WMI_TLV_SERVICE_PEER_DELETE_NO_PEER_FLUSH_TIDS_CMD = 237,
+	WMI_TLV_SERVICE_NSS_RATIO_TO_HOST_SUPPORT = 238,
+	WMI_TLV_SERVICE_WPA3_SUITEB_ROAM_SUPPORT = 239,
+	WMI_TLV_SERVICE_PERIODIC_FRAME_INJECT_SUPPORT = 240,
+	WMI_TLV_SERVICE_NDI_NDI_STA_SUPPORT = 241,
+	WMI_TLV_SERVICE_BW_TRUE_160_SUPPORT = 242,
+	WMI_TLV_SERVICE_HOST_SCAN_STOP_VDEV_ALL_SUPPORT = 243,
+	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
+	WMI_TLV_SERVICE_EMA_AP_SUPPORT = 245,
+	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
+	WMI_TLV_SERVICE_5_DOT_9GHZ_SUPPORT = 247,
+	WMI_TLV_SERVICE_MU_PREAMBLE_PUNCTURE_SUPPORT = 248,
+	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_REQUEST_CTRL_PATH_STATS_REQUEST = 250,
+	WMI_TLV_SERVICE_TPC_STATS_EVENT = 251,
+	WMI_TLV_SERVICE_NO_INTERBAND_MCC_SUPPORT = 252,
+	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	WMI_MAX_EXT_SERVICE
 };
@@ -2284,6 +2326,18 @@ struct wmi_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 max_nlo_ssids;
+	u32 num_pkt_filters;
+	u32 num_max_sta_vdevs;
+	u32 max_bssid_indicator;
+	u32 ul_resp_config;
+	u32 msdu_flow_override_config0;
+	u32 msdu_flow_override_config1;
+	u32 flags2;
+	u32 host_service_flags;
+	u32 max_rnr_neighbours;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -2461,6 +2515,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2471,6 +2527,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
@@ -2485,6 +2543,15 @@ struct wmi_vdev_delete_cmd {
 	u32 vdev_id;
 } __packed;
 
+struct vdev_up_params {
+	u32 vdev_id;
+	u16 aid;
+	u32 profile_idx;
+	u32 profile_num;
+	const u8 *bssid;
+	u8 *trans_bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -2533,6 +2600,9 @@ struct wmi_vdev_start_request_cmd {
 	u32 he_ops;
 	u32 cac_duration_ms;
 	u32 regdomain;
+	u32 min_data_rate;
+	u32 mbss_capability_flags;
+	u32 vdevid_trans;
 } __packed;
 
 #define MGMT_TX_DL_FRM_LEN		     64
@@ -2702,6 +2772,9 @@ struct wmi_vdev_start_req_arg {
 	u32 pref_rx_streams;
 	u32 pref_tx_streams;
 	u32 num_noa_descriptors;
+	u32 min_data_rate;
+	u32 mbss_capability_flags;
+	u32 vdevid_trans;
 };
 
 struct peer_create_params {
@@ -3418,6 +3491,11 @@ struct wmi_get_pdev_temperature_cmd {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT		0
+#define WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT		8
+#define WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT		16
+#define WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT		24
+
 struct wmi_bcn_tmpl_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -3428,6 +3506,11 @@ struct wmi_bcn_tmpl_cmd {
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
@@ -5014,6 +5097,8 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 };
 
 #define WMI_MAX_MEM_REQS 32
@@ -5214,10 +5299,9 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn, u32 ema_param);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);

base-commit: be8cd9b8f5ed435c27530430aa1b1da30f9825d5
prerequisite-patch-id: 1c9127eb0d6efce75a0aa085527bf81ced427387
prerequisite-patch-id: 41af1c46bdedfa8768dd4205bb0647101de27dea
prerequisite-patch-id: f197607d75899cbecffd775e1ca243aa2fe082d0
prerequisite-patch-id: 55dad75c4f560213110f57f1abf24d9b7301a1b2
-- 
2.25.0

