Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD86011E72C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfLMP6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:15 -0500
Received: from nbd.name ([46.4.11.11]:56208 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfLMP6O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKU-00073u-4w; Fri, 13 Dec 2019 16:58:10 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 3/7] mac80211: add handling for BSS color
Date:   Fri, 13 Dec 2019 16:57:58 +0100
Message-Id: <20191213155802.25491-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213155802.25491-1-john@phrozen.org>
References: <20191213155802.25491-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is now possible to propagate BSS color settings into the subsystem. Lets
make mac80211 also handle them so that we can send them further down the
stack into the drivers. We continue to populate the old bss_color field
until all users have been updated to use the new he_bss_color struct.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 5 ++++-
 net/mac80211/mlme.c    | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 16a5525ddab1..994686443553 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -316,6 +316,7 @@ struct ieee80211_vif_chanctx_switch {
  *	functionality changed for this BSS (AP mode).
  * @BSS_CHANGED_TWT: TWT status changed
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
+ * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
  *
  */
 enum ieee80211_bss_change {
@@ -348,6 +349,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_FTM_RESPONDER	= 1<<26,
 	BSS_CHANGED_TWT			= 1<<27,
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
+	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ed56b0c6fe19..e109b47c4219 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -981,7 +981,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER |
 		      BSS_CHANGED_TWT |
-		      BSS_CHANGED_HE_OBSS_PD;
+		      BSS_CHANGED_HE_OBSS_PD |
+		      BSS_CHANGED_HE_BSS_COLOR;
 	int err;
 	int prev_beacon_int;
 
@@ -1054,6 +1055,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	memcpy(&sdata->vif.bss_conf.he_obss_pd, &params->he_obss_pd,
 	       sizeof(struct ieee80211_he_obss_pd));
+	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
+	       sizeof(struct ieee80211_he_bss_color));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 641876982ab9..319d43f4082b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3372,8 +3372,16 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	if (bss_conf->he_support) {
 		bss_conf->bss_color =
+		bss_conf->he_bss_color.color =
 			le32_get_bits(elems.he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
+		bss_conf->he_bss_color.partial =
+			le32_get_bits(elems.he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR);
+		bss_conf->he_bss_color.disabled =
+			le32_get_bits(elems.he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 
 		bss_conf->htc_trig_based_pkt_ext =
 			le32_get_bits(elems.he_operation->he_oper_params,
-- 
2.20.1

