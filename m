Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB9109CB5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfKZLEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:48 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:54794
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfKZLEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766287;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=d94cGDRqS/XyhpNGxRVrQuzJi5bfRc/hQ2P0SM9KobA=;
        b=BUDrIISHvul06NAE40BIf7AlGGbsF+tnOL/I1R4CG2tNHi5C0PR/mEX/knaR4QnX
        +tISWNY+Q8F1gxoL6EKXALhpEGnoeyxWCoZSqN7m7ZvNg8uoxba4K4RcG/wXRcbqnFR
        IDGS9IDgpIzL08vIT4WUE35N7cOcNKI2I6xLqtKI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766287;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=d94cGDRqS/XyhpNGxRVrQuzJi5bfRc/hQ2P0SM9KobA=;
        b=WusLMlI41h7CpLDDZyk/jTcIvYCucBQIOjPyNGx49QcYUjzrTcX6CYYR54UKqomR
        A8lwG5Yy9xveQJfqwr/ey6v5zO+M0zT6cGqKx90K68ZWUbY26RxugJKvUt7QaR5bRXF
        fbW+dCI0f9dCOiqnBh9YlKdUy/e0PJ+Lvt2bfD/k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 430A4C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 02/10] ath11k: fix resource leak in ath11k_mac_sta_state
Date:   Tue, 26 Nov 2019 11:04:47 +0000
Message-ID: <0101016ea7629898-dc4aa1c0-7a49-477b-b26a-dc469670f926-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Handled the error case with proper resource cleanup and
moved the handling into a separate function from
ath11k_mac_sta_state.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 144 ++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c25817c51d87..6f82fdbbd358 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2682,6 +2682,87 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 	ar->num_stations--;
 }
 
+static int ath11k_mac_station_add(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct peer_create_params peer_param;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ret = ath11k_mac_inc_num_stations(arvif, sta);
+	if (ret) {
+		ath11k_warn(ab, "refusing to associate station: too many connected already (%d)\n",
+			    ar->max_num_stations);
+		goto exit;
+	}
+
+	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+	if (!arsta->rx_stats) {
+		ret = -ENOMEM;
+		goto dec_num_station;
+	}
+
+	peer_param.vdev_id = arvif->vdev_id;
+	peer_param.peer_addr = sta->addr;
+	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
+
+	ret = ath11k_peer_create(ar, arvif, sta, &peer_param);
+	if (ret) {
+		ath11k_warn(ab, "Failed to add peer: %pM for VDEV: %d\n",
+			    sta->addr, arvif->vdev_id);
+		goto free_rx_stats;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
+		   sta->addr, arvif->vdev_id);
+
+	if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
+		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
+		if (!arsta->tx_stats) {
+			ret = -ENOMEM;
+			goto free_peer;
+		}
+	}
+
+	if (ieee80211_vif_is_mesh(vif)) {
+		ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+						arvif->vdev_id,
+						WMI_PEER_USE_4ADDR, 1);
+		if (ret) {
+			ath11k_warn(ab, "failed to STA %pM 4addr capability: %d\n",
+				    sta->addr, ret);
+			goto free_tx_stats;
+		}
+	}
+
+	ret = ath11k_dp_peer_setup(ar, arvif->vdev_id, sta->addr);
+	if (ret) {
+		ath11k_warn(ab, "failed to setup dp for peer %pM on vdev %i (%d)\n",
+			    sta->addr, arvif->vdev_id, ret);
+		goto free_tx_stats;
+	}
+
+	return 0;
+
+free_tx_stats:
+	kfree(arsta->tx_stats);
+	arsta->tx_stats = NULL;
+free_peer:
+	ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
+free_rx_stats:
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
+dec_num_station:
+	ath11k_mac_dec_num_stations(arvif, sta);
+exit:
+	return ret;
+}
+
 static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -2691,7 +2772,6 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
-	struct peer_create_params peer_param;
 	int ret = 0;
 
 	/* cancel must be done outside the mutex to avoid deadlock */
@@ -2707,60 +2787,10 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		arsta->arvif = arvif;
 		INIT_WORK(&arsta->update_wk, ath11k_sta_rc_update_wk);
 
-		ret = ath11k_mac_inc_num_stations(arvif, sta);
-		if (ret) {
-			ath11k_warn(ar->ab, "refusing to associate station: too many connected already (%d)\n",
-				    ar->max_num_stations);
-			goto exit;
-		}
-
-		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
-		if (!arsta->rx_stats) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		peer_param.vdev_id = arvif->vdev_id;
-		peer_param.peer_addr = sta->addr;
-		peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
-		ret = ath11k_peer_create(ar, arvif, sta, &peer_param);
-		if (ret) {
-			ath11k_warn(ar->ab, "Failed to add peer: %pM for VDEV: %d\n",
+		ret = ath11k_mac_station_add(ar, vif, sta);
+		if (ret)
+			ath11k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
 				    sta->addr, arvif->vdev_id);
-			ath11k_mac_dec_num_stations(arvif, sta);
-			goto exit;
-		}
-
-		ath11k_info(ar->ab, "Added peer: %pM for VDEV: %d\n",
-			    sta->addr, arvif->vdev_id);
-
-		if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
-			arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats),
-						  GFP_KERNEL);
-			if (!arsta->tx_stats) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-		}
-
-		if (ieee80211_vif_is_mesh(vif)) {
-			ret = ath11k_wmi_set_peer_param(ar, sta->addr,
-							arvif->vdev_id,
-							WMI_PEER_USE_4ADDR, 1);
-			if (ret) {
-				ath11k_warn(ar->ab, "failed to STA %pM 4addr capability: %d\n",
-					    sta->addr, ret);
-				goto exit;
-			}
-		}
-
-		ret = ath11k_dp_peer_setup(ar, arvif->vdev_id, sta->addr);
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to setup dp for peer %pM on vdev %i (%d)\n",
-				    sta->addr, arvif->vdev_id, ret);
-			ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
-			ath11k_mac_dec_num_stations(arvif, sta);
-		}
 	} else if ((old_state == IEEE80211_STA_NONE &&
 		    new_state == IEEE80211_STA_NOTEXIST)) {
 		ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
@@ -2770,9 +2800,8 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 			ath11k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
 				    sta->addr, arvif->vdev_id);
 		else
-			ath11k_info(ar->ab,
-				    "Removed peer: %pM for VDEV: %d\n",
-				    sta->addr, arvif->vdev_id);
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "Removed peer: %pM for VDEV: %d\n",
+				   sta->addr, arvif->vdev_id);
 
 		ath11k_mac_dec_num_stations(arvif, sta);
 
@@ -2809,7 +2838,6 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				    sta->addr);
 	}
 
-exit:
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
-- 
2.7.4

