Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F397242BCA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHLPBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHLPBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF0C061389
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:01 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFO-0002OP-2L; Wed, 12 Aug 2020 17:00:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 5/9] ath11k: add a struct to pass parameters into ath11k_wmi_vdev_up
Date:   Wed, 12 Aug 2020 17:00:46 +0200
Message-Id: <20200812150050.2683396-6-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When setting up a multiple bssid we need to pass additional parameters to
the FW. Doing this as individual parameters would make the call signature
very long. Use an intermediate struct instead and adjust all callees to
make use of it.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 37 ++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/wmi.c | 17 +++++++-----
 drivers/net/wireless/ath/ath11k/wmi.h | 12 +++++++--
 3 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3c034e8428a2..2e4f1966da21 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -739,9 +739,13 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 
 static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 {
+	struct vdev_up_params params = {
+		.vdev_id = vdev_id,
+		.bssid = ar->mac_addr,
+	};
 	int ret = 0;
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -835,6 +839,12 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct vdev_up_params params = {
+		.vdev_id = arvif->vdev_id,
+		.bssid = arvif->bssid,
+		.profile_num = info->multiple_bssid.count,
+		.profile_idx = info->multiple_bssid.index,
+	};
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -862,9 +872,15 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	arvif->aid = 0;
 
 	ether_addr_copy(arvif->bssid, info->bssid);
+	if (arvif->vif->multiple_bssid.parent) {
+		struct ath11k_vif *pvif;
 
-	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+		pvif = (struct ath11k_vif *)arvif->vif->multiple_bssid.parent->drv_priv;
+
+		params.trans_bssid = pvif->bssid;
+	}
+
+	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -1687,6 +1703,11 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct peer_assoc_params peer_arg;
+	struct vdev_up_params params = {
+		.vdev_id = arvif->vdev_id,
+		.bssid = bss_conf->bssid,
+		.aid = bss_conf->aid,
+	};
 	struct ieee80211_sta *ap_sta;
 	int ret;
 
@@ -1735,7 +1756,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = bss_conf->aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -5059,6 +5080,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
+		struct vdev_up_params params;
+
 		arvif = (void *)vifs[i].vif->drv_priv;
 
 		if (WARN_ON(!arvif->is_started))
@@ -5079,8 +5102,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
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
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 01931e838b4e..04ef73d1f032 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -898,7 +898,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -913,10 +913,14 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
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
@@ -925,8 +929,9 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   "WMI mgmt vdev up id 0x%x assoc id %d idx %d num %d bssid %pM trans_bssid %pM\n",
+		   params->vdev_id, params->aid, params->profile_idx, params->profile_num,
+		   params->bssid, params->trans_bssid);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4f7078369b3c..a2d81abf6356 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2480,6 +2480,15 @@ struct wmi_vdev_delete_cmd {
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
@@ -5023,8 +5032,7 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.25.1

