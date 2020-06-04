Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7F1EDDAE
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgFDHKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgFDHKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:03 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A1C03E96D
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0m-0001P3-Ad; Thu, 04 Jun 2020 09:10:00 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 08/12] ath11k: pass multiple bssid info to FW when a new vdev is created
Date:   Thu,  4 Jun 2020 09:09:48 +0200
Message-Id: <20200604070952.15481-9-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
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
index 2f11259de24a..b38b687d1100 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4163,17 +4163,36 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
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
@@ -4183,6 +4202,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static u32
@@ -4334,7 +4354,11 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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
index 5b35d06a0d81..a46aa831d8be 100644
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
index 82929415e119..761e27a3a306 100644
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
@@ -2376,6 +2382,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2386,6 +2394,8 @@ struct wmi_vdev_create_cmd {
 	struct wmi_mac_addr vdev_macaddr;
 	u32 num_cfg_txrx_streams;
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 } __packed;
 
 struct wmi_vdev_txrx_streams {
-- 
2.20.1

