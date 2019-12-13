Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E3811E72E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfLMP6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:18 -0500
Received: from nbd.name ([46.4.11.11]:56236 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfLMP6O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKW-00073u-Ii; Fri, 13 Dec 2019 16:58:12 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 7/7] ath11k: add handling for BSS color
Date:   Fri, 13 Dec 2019 16:58:02 +0100
Message-Id: <20191213155802.25491-7-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds code to handle the BSS_CHANGED_BSS_COLOR flag. It will
trigger the propagation of BSS color settings into the FW. Handling is
slightly different between AP and STA interfaces.

Signed-off-by: John Crispin <john@phrozen.org>

Changes in V2
* handle return codes
---
 drivers/net/wireless/ath/ath11k/mac.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6a8c1c3b8da2..fec268b9b711 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1928,6 +1928,33 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
 					     &info->he_obss_pd);
 
+	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
+		if (vif->type == NL80211_IFTYPE_AP) {
+			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
+				ar, arvif->vdev_id, info->he_bss_color.color,
+				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
+				!info->he_bss_color.disabled);
+			if (ret)
+				ath11k_warn(ar->ab,
+				    "failed to set bss color collision on vdev %i: %d\n",
+				    arvif->vdev_id,  ret);
+		} else if (vif->type == NL80211_IFTYPE_STATION) {
+			ret = ath11k_wmi_send_bss_color_change_enable_cmd(ar,
+								arvif->vdev_id, 1);
+			if (ret)
+				ath11k_warn(ar->ab,
+				    "failed to enable bss color change on vdev %i: %d\n",
+				    arvif->vdev_id,  ret);
+			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
+				ar, arvif->vdev_id, 0,
+				ATH11K_BSS_COLOR_COLLISION_DETECTION_STA_PERIOD_MS, 1);
+			if (ret)
+				ath11k_warn(ar->ab,
+				    "failed to set bss color collision on vdev %i: %d\n",
+				    arvif->vdev_id,  ret);
+}
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
-- 
2.20.1

