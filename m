Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D32330AD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 13:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG3LBH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG3LBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 07:01:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3CC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:01:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k16J4-00DTsE-3u; Thu, 30 Jul 2020 13:01:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: invert HE BSS color 'disabled' to 'enabled'
Date:   Thu, 30 Jul 2020 13:00:52 +0200
Message-Id: <20200730130051.5d8399545bd9.Ie62fdcd1a6cd9c969315bc124084a494ca6c8df3@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is in fact 'disabled' in the spec, but there it's in a
place where that actually makes sense. In our internal data
structures, it doesn't really make sense, and in fact the
previous commit just fixed a bug in that area.

Make this safer by inverting the polarity from 'disabled' to
'enabled'.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 include/net/cfg80211.h                | 4 ++--
 net/mac80211/cfg.c                    | 2 +-
 net/mac80211/mlme.c                   | 8 ++++----
 net/wireless/nl80211.c                | 7 ++-----
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07d3e031c75a..94ae2b9ea663 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2072,7 +2072,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				!info->he_bss_color.disabled);
+				info->he_bss_color.enabled);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 39fe21edd2c5..d9e6b9fbd95b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -267,12 +267,12 @@ struct ieee80211_he_obss_pd {
  * struct cfg80211_he_bss_color - AP settings for BSS coloring
  *
  * @color: the current color.
- * @disabled: is the feature disabled.
+ * @enabled: HE BSS color is used
  * @partial: define the AID equation.
  */
 struct cfg80211_he_bss_color {
 	u8 color;
-	bool disabled;
+	bool enabled;
 	bool partial;
 };
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bbd86cd79954..e78832e0ccf9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1019,7 +1019,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 		changed |= BSS_CHANGED_HE_OBSS_PD;
 
-		if (!params->he_bss_color.disabled)
+		if (params->he_bss_color.enabled)
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8a92a62dc54d..839d0367446c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3460,11 +3460,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		bss_conf->he_bss_color.partial =
 			le32_get_bits(elems->he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR);
-		bss_conf->he_bss_color.disabled =
-			le32_get_bits(elems->he_operation->he_oper_params,
-				      IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+		bss_conf->he_bss_color.enabled =
+			!le32_get_bits(elems->he_operation->he_oper_params,
+				       IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
 
-		if (!bss_conf->he_bss_color.disabled)
+		if (bss_conf->he_bss_color.enabled)
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 
 		bss_conf->htc_trig_based_pkt_ext =
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4048f3c5134..8d78a6fc59a3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4713,8 +4713,8 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 
 	he_bss_color->color =
 		nla_get_u8(tb[NL80211_HE_BSS_COLOR_ATTR_COLOR]);
-	he_bss_color->disabled =
-		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
+	he_bss_color->enabled =
+		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
 	he_bss_color->partial =
 		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
 
@@ -4865,9 +4865,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
-	/* disable BSS color by default */
-	params.he_bss_color.disabled = true;
-
 	/* these are required for START_AP */
 	if (!info->attrs[NL80211_ATTR_BEACON_INTERVAL] ||
 	    !info->attrs[NL80211_ATTR_DTIM_PERIOD] ||
-- 
2.26.2

