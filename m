Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4787B2156BB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgGFLwe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgGFLwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:52:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C927C08C5E1
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 04:52:32 -0700 (PDT)
Received: from [134.101.131.141] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsPfi-000600-7x; Mon, 06 Jul 2020 13:52:30 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 06/10] ath11k: pass multiple bssid info to FW when a new vdev is created
Date:   Mon,  6 Jul 2020 13:52:15 +0200
Message-Id: <20200706115219.663650-6-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When we use multiple bssid the FW needs to know if the bssid is
non/transmitting and what the vdev_id of the parent is. This patch adds
the required code to achieve this.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 28 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c |  2 ++
 drivers/net/wireless/ath/ath11k/wmi.h | 10 ++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f197ab..498f9a15d0e4 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4065,17 +4065,36 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void
+static int
 ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 				    struct vdev_create_params *params)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_pdev *pdev = ar->pdev;
+	struct ieee80211_vif *parent;
 
 	params->if_id = arvif->vdev_id;
 	params->type = arvif->vdev_type;
 	params->subtype = arvif->vdev_subtype;
 	params->pdev_id = pdev->pdev_id;
+	params->vdevid_trans = 0;
+	switch (ieee80211_get_multi_bssid_mode(arvif->vif)) {
+	case NL80211_MULTIPLE_BSSID_TRANSMITTED:
+		params->flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+		break;
+	case NL80211_MULTIPLE_BSSID_NON_TRANSMITTED:
+		params->flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+		parent = ieee80211_get_multi_bssid_parent(arvif->vif);
+		if (!parent)
+			return -ENOENT;
+		if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
+			return -EINVAL;
+		params->vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
+		break;
+	default:
+		params->flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+		break;
+	}
 
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		params->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
@@ -4085,6 +4104,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static u32
@@ -4234,7 +4254,11 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a972377687..90c68d1d9087 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -603,6 +603,8 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+	cmd->flags = param->flags;
+	cmd->vdevid_trans = param->vdevid_trans;
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b9f3e559ced7..fa6665584caf 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -107,6 +107,12 @@ enum {
 	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
 };
 
+enum {
+	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 1,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 2,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 4,
+};
+
 /*
  * wmi command groups.
  */
@@ -2419,6 +2425,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2429,6 +2437,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
-- 
2.25.1

