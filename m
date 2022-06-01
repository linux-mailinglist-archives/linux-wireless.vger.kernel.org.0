Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC9539E8D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350331AbiFAHkV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbiFAHkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2F996B9
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=D81KOglcWeLn2KQhYc8nohtfeYLH/BrQ4mCfsMVhdsM=;
        t=1654069206; x=1655278806; b=gAd3zUiwxoYBbUssztQI93cCwhnWe6dyVRDmZ6VOmS0qzzw
        5YKKYFQ7ma4Z6BTuZV9Eq3JmNozLdqyrMG/xSrEreuBrs9W6N00OU2kKxSbnyMa7FJ7UVnHiYtMPO
        Mqbn4KNq5NSh6X9xOq/Ym0wxZmLYFpdKhNN2TyVPoFYR+9Efj/9rF1GpxVktbj8DqBm/V4SDm785k
        DIIhGrB0EVORreoYdqlJwrUNktJAZ9Z4qQ9ZNk8PBi+BhwQ0OG1JzAEsQmGQGlE9buG2l/Nmb6d9d
        BnXcGWe0zCwIt8CQFCuJSKol6kdFvgn65bpzOnzKWdj6iz2dz1lS+IEpPG7xOLqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxZ-00AJPK-4O;
        Wed, 01 Jun 2022 09:40:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] mac80211: make ieee80211_he_cap_ie_to_sta_he_cap() MLO-aware
Date:   Wed,  1 Jun 2022 09:39:57 +0200
Message-Id: <20220601093922.a6b1df141776.I5ccafef7ec56a6fa393852b2489ebbd955b0bdec@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add the link_id parameter and adjust the code accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/he.c          | 16 +++++++++-------
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh_plink.c  |  2 +-
 net/mac80211/mlme.c        |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cf63542d40fa..bc243716bda0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1774,7 +1774,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 						  (void *)params->he_capa,
 						  params->he_capa_len,
 						  (void *)params->he_6ghz_capa,
-						  sta);
+						  sta, 0);
 
 	if (params->eht_capa)
 		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 20448dda8c4d..e48e9a021622 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -10,7 +10,7 @@
 
 static void
 ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
-				   struct sta_info *sta)
+				   struct sta_info *sta, unsigned int link_id)
 {
 	enum ieee80211_smps_mode smps_mode;
 
@@ -49,7 +49,7 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 		break;
 	}
 
-	sta->sta.deflink.he_6ghz_capa = *he_6ghz_capa;
+	sta->sta.link[link_id]->he_6ghz_capa = *he_6ghz_capa;
 }
 
 static void ieee80211_he_mcs_disable(__le16 *he_mcs)
@@ -108,9 +108,9 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
-				  struct sta_info *sta)
+				  struct sta_info *sta, unsigned int link_id)
 {
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.link[link_id]->he_cap;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -153,11 +153,13 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta, 0);
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
+	sta->link[link_id]->cur_max_bandwidth =
+		ieee80211_sta_cap_rx_bw(sta, link_id);
+	sta->sta.link[link_id]->bandwidth =
+		ieee80211_sta_cur_vht_bw(sta, link_id);
 
 	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
-		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
+		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta, link_id);
 
 	ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80,
 				      &he_cap->he_mcs_nss_supp.rx_mcs_80,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0948d074c4b9..c3387ffe27f5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2153,7 +2153,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
-				  struct sta_info *sta);
+				  struct sta_info *sta, unsigned int link_id);
 void
 ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 				const struct ieee80211_he_spr *he_spr_ie_elem);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index b64614cd314d..e24bd48bc915 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -447,7 +447,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
 					  elems->he_cap_len,
 					  elems->he_6ghz_capa,
-					  sta);
+					  sta, 0);
 
 	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cdbf7a5dc2ba..b6ee8da07663 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3579,7 +3579,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						  elems->he_cap,
 						  elems->he_cap_len,
 						  elems->he_6ghz_capa,
-						  sta);
+						  sta, 0);
 
 		bss_conf->he_support = sta->sta.deflink.he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
-- 
2.36.1

