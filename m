Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789957336C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiGMJrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiGMJpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF2F8949
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BQHS9XNHTPbS6zXIDpvJUWiT4fXCqc3OgZwQFQF8UmY=;
        t=1657705531; x=1658915131; b=waPmj/WL3FPNcd+pJAK97y+yircrlA6MiOFGsUJIACF3OUh
        YLCntOwbpYOzhxjcbUE6HkxRX+aWFy3SpDXPbzaeyzxlKVcLD7JCGp70zi0fz3fYmlsjJlQ4NB4/Q
        yIbxOU416Z56j2jVh1uXRzGyEeWWj4fXm8C3PkXkAWIktyGMvRQfBPu7VmHfixDRCul/mJX0pXuYd
        KMPoSgLt2cqgeXQOd0hRpX71kkHJb1KCWBXTijlYE8OZzRuDMBI8HmgM852oeDwWjNLNk8RfNU1Xf
        pSbSKiCeZNAnZHL7iFR6ZqDg20+WDQVcWiny8Fm3fEUBNLaX7yTLWjkweghjb4Qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvx-00EgvB-I4;
        Wed, 13 Jul 2022 11:45:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 72/76] wifi: mac80211: Support multi link in ieee80211_recalc_min_chandef()
Date:   Wed, 13 Jul 2022 11:44:58 +0200
Message-Id: <20220713114426.3f1c6708392a.Icc5de486a907462407b9bee8d49a92f89af2946b@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Recalculate min channel context for the given or all interface
links, depending on the caller. For a station state change, we
need to recalculate all of them since we don't know which link
(or multiple) it might be on.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/sta_info.c    |  6 +++---
 net/mac80211/util.c        | 40 +++++++++++++++++++++++++++++++-------
 net/mac80211/vht.c         |  2 +-
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 163e62dab045..877f2441b74b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2335,7 +2335,8 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 				 enum ieee80211_smps_mode smps_mode);
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_link_data *link);
-void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata);
+void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
+				  int link_id);
 
 size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset);
 u8 *ieee80211_ie_build_ht_cap(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 88ff61aadd96..f52a7fa6dde5 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -780,7 +780,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	 * change, this enables driver using the updated channel context right away.
 	 */
 	if (sta->sta_state >= IEEE80211_STA_ASSOC) {
-		ieee80211_recalc_min_chandef(sta->sdata);
+		ieee80211_recalc_min_chandef(sta->sdata, -1);
 		if (!sta->sta.support_p2p_ps)
 			ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
 	}
@@ -2136,7 +2136,7 @@ int sta_info_move_state(struct sta_info *sta,
 			set_bit(WLAN_STA_AUTH, &sta->_flags);
 		} else if (sta->sta_state == IEEE80211_STA_ASSOC) {
 			clear_bit(WLAN_STA_ASSOC, &sta->_flags);
-			ieee80211_recalc_min_chandef(sta->sdata);
+			ieee80211_recalc_min_chandef(sta->sdata, -1);
 			if (!sta->sta.support_p2p_ps)
 				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
 		}
@@ -2145,7 +2145,7 @@ int sta_info_move_state(struct sta_info *sta,
 		if (sta->sta_state == IEEE80211_STA_AUTH) {
 			set_bit(WLAN_STA_ASSOC, &sta->_flags);
 			sta->assoc_at = ktime_get_boottime_ns();
-			ieee80211_recalc_min_chandef(sta->sdata);
+			ieee80211_recalc_min_chandef(sta->sdata, -1);
 			if (!sta->sta.support_p2p_ps)
 				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
 		} else if (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4b11cf57f4fe..cb44fa9a5048 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2836,22 +2836,48 @@ void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&local->chanctx_mtx);
 }
 
-void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata)
+void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
+				  int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_chanctx *chanctx;
+	int i;
 
 	mutex_lock(&local->chanctx_mtx);
 
-	chanctx_conf = rcu_dereference_protected(sdata->vif.bss_conf.chanctx_conf,
-						 lockdep_is_held(&local->chanctx_mtx));
+	for (i = 0; i < ARRAY_SIZE(sdata->vif.link_conf); i++) {
+		struct ieee80211_bss_conf *bss_conf;
 
-	if (WARN_ON_ONCE(!chanctx_conf))
-		goto unlock;
+		if (link_id >= 0 && link_id != i)
+			continue;
 
-	chanctx = container_of(chanctx_conf, struct ieee80211_chanctx, conf);
-	ieee80211_recalc_chanctx_min_def(local, chanctx);
+		rcu_read_lock();
+		bss_conf = rcu_dereference(sdata->vif.link_conf[i]);
+		if (!bss_conf) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		chanctx_conf = rcu_dereference_protected(bss_conf->chanctx_conf,
+							 lockdep_is_held(&local->chanctx_mtx));
+		/*
+		 * Since we hold the chanctx_mtx (checked above)
+		 * we can take the chanctx_conf pointer out of the
+		 * RCU critical section, it cannot go away without
+		 * the mutex. Just the way we reached it could - in
+		 * theory - go away, but we don't really care and
+		 * it really shouldn't happen anyway.
+		 */
+		rcu_read_unlock();
+
+		if (WARN_ON_ONCE(!chanctx_conf))
+			goto unlock;
+
+		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
+				       conf);
+		ieee80211_recalc_chanctx_min_def(local, chanctx);
+	}
  unlock:
 	mutex_unlock(&local->chanctx_mtx);
 }
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c804890dc623..b2b09d421e8b 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -731,7 +731,7 @@ void ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 						    opmode, band);
 
 	if (changed > 0) {
-		ieee80211_recalc_min_chandef(sdata);
+		ieee80211_recalc_min_chandef(sdata, link_sta->link_id);
 		rate_control_rate_update(local, sband, link_sta->sta,
 					 link_sta->link_id, changed);
 	}
-- 
2.36.1

