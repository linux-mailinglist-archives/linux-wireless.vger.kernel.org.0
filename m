Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38B7539E8B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350322AbiFAHkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347765AbiFAHkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC995A0F
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yu984Nx+p1tOxjZoDfYkMQpqrmtsUeOgvEVlPrjwWos=;
        t=1654069206; x=1655278806; b=u8KvsygJIH5asbDRXOJJgQaS8+MbNhXV03PJFounrDobY8y
        MptoARpGwE0ME4cWiZKEFCZN8l0AdAHQAFghJ/sfRicKW4dChBkr73MyuTmeRnx1e6fbFyZ9GgbEo
        FJQGWhc6RdxdV/sDolnqcE+jWAOL4ad2HJcPvwV8k8lPZJs2LL7j3s604RGl/lAPGBHv+/5PWg0O/
        FdIDyH8HvMGnzLgoMdj/Q+RxtJBwJ2dneEY3t53mQYKeZuxeapjJ5hYfsAOhuv6/q+LsGKqP6N59b
        LGQNAvQejczCgcFD2AiaLPnt9hiN1xSeztE0lqbcL2zg9Vr1AgJjnG2RJ/Hm697A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxY-00AJPK-9c;
        Wed, 01 Jun 2022 09:40:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] mac80211: add link_id to eht.c code for MLO
Date:   Wed,  1 Jun 2022 09:39:54 +0200
Message-Id: <20220601093922.df8b484509f6.I7f6db8cc8f7e7bfb8cad4926a962cd5630fae330@changeid>
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

Update the code in eht.c and add the link_id parameter where
necessary.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/eht.c         | 12 ++++++++----
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/mlme.c        |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 27eb281f53b6..0afff3b0aeee 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1782,7 +1782,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 						    params->he_capa_len,
 						    params->eht_capa,
 						    params->eht_capa_len,
-						    sta);
+						    sta, 0);
 
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 2d9c6e845ce4..de762a803c38 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -12,9 +12,11 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const u8 *he_cap_ie, u8 he_cap_len,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
-				    u8 eht_cap_len, struct sta_info *sta)
+				    u8 eht_cap_len, struct sta_info *sta,
+				    unsigned int link_id)
 {
-	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.deflink.eht_cap;
+	struct ieee80211_sta_eht_cap *eht_cap =
+		&sta->sta.link[link_id]->eht_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 eht_ppe_size = 0;
 	u8 mcs_nss_size;
@@ -71,6 +73,8 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	eht_cap->has_eht = true;
 
-	sta->deflink.cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta, 0);
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
+	sta->link[link_id]->cur_max_bandwidth =
+		ieee80211_sta_cap_rx_bw(sta, link_id);
+	sta->sta.link[link_id]->bandwidth =
+		ieee80211_sta_cur_vht_bw(sta, link_id);
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5be96b0bbd96..c59dc8f6126b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2577,5 +2577,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const u8 *he_cap_ie, u8 he_cap_len,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
-				    u8 eht_cap_len, struct sta_info *sta);
+				    u8 eht_cap_len, struct sta_info *sta,
+				    unsigned int link_id);
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 643ef0ae786e..459780169e23 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3599,7 +3599,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 							    elems->he_cap_len,
 							    elems->eht_cap,
 							    elems->eht_cap_len,
-							    sta);
+							    sta, 0);
 
 			bss_conf->eht_support = sta->sta.deflink.eht_cap.has_eht;
 		} else {
-- 
2.36.1

