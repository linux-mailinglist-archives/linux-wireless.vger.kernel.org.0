Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7D573325
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiGMJpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7EDBFACF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3E1IjrZTgAObBmKv7uM9WAkvcFoBmkRrl4X/Sky8YFA=;
        t=1657705508; x=1658915108; b=gfRoPrtsZXZjXwY7v/KdOt3mUFYCPf0qzrKk/44Aea/tdbK
        I/Ab9bv4diQPKw8Q3ZrHemuzZigAMKgXISEdgvDHCC/EkBWlGWMIxdmYo8K9ELAIcTQ2TeLT79YJg
        LcTI63mFH2+mHgE6c95Cr3CiYgzMU4hV//zM6u/HE0b86LOU5FEOKZf0k6RPhtLy96KhZAYyi9lfm
        ogUC/KhSgFV+EldknC13ycV7hpkGTgZAu3gsoWbCT3H8L254ikvjW11hqIarO2JpwHrcRmRznrsrY
        m8ahX4e6G5cDLrmVx7L682oA/Ic14L7JSmliYgRwSxz71CvrkGKV+6FXv4eSHEHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYva-00EgvB-BA;
        Wed, 13 Jul 2022 11:45:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 06/76] wifi: mac80211: Remove AP SMPS leftovers
Date:   Wed, 13 Jul 2022 11:43:52 +0200
Message-Id: <20220713114425.e8b1ab17944a.I8056f66854f340649f20327620dda5bd3888d999@changeid>
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

AP SMPS was removed and not needed anymore. Remove the leftovers.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/sta_info.c    | 30 ------------------------------
 net/mac80211/sta_info.h    |  4 ----
 net/mac80211/status.c      |  3 ---
 4 files changed, 38 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 46413b6a8de3..18bab27eda4f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1921,7 +1921,6 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
 			       const u8 *bssid);
-void ieee80211_request_smps_ap_work(struct work_struct *work);
 void ieee80211_request_smps_mgd_work(struct work_struct *work);
 bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
 				   enum ieee80211_smps_mode smps_mode_new);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index c9852f71e8e1..d738534a709e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -616,36 +616,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sta->sta.smps_mode = IEEE80211_SMPS_OFF;
-	if (sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-		struct ieee80211_supported_band *sband;
-		u8 smps;
-
-		sband = ieee80211_get_sband(sdata);
-		if (!sband)
-			goto free_txq;
-
-		smps = (sband->ht_cap.cap & IEEE80211_HT_CAP_SM_PS) >>
-			IEEE80211_HT_CAP_SM_PS_SHIFT;
-		/*
-		 * Assume that hostapd advertises our caps in the beacon and
-		 * this is the known_smps_mode for a station that just assciated
-		 */
-		switch (smps) {
-		case WLAN_HT_SMPS_CONTROL_DISABLED:
-			sta->known_smps_mode = IEEE80211_SMPS_OFF;
-			break;
-		case WLAN_HT_SMPS_CONTROL_STATIC:
-			sta->known_smps_mode = IEEE80211_SMPS_STATIC;
-			break;
-		case WLAN_HT_SMPS_CONTROL_DYNAMIC:
-			sta->known_smps_mode = IEEE80211_SMPS_DYNAMIC;
-			break;
-		default:
-			WARN_ON(1);
-		}
-	}
-
 	sta->sta.max_rc_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_BA;
 
 	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 70ee55ec5518..a1724e366a35 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -615,8 +615,6 @@ struct link_sta_info {
  * @rcu_head: RCU head used for freeing this station struct
  * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
  *	taken from HT/VHT capabilities or VHT operating mode notification
- * @known_smps_mode: the smps_mode the client thinks we are in. Relevant for
- *	AP only.
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @fast_tx: TX fastpath information
@@ -699,8 +697,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	enum ieee80211_smps_mode known_smps_mode;
-
 	struct codel_params cparams;
 
 	u8 reserved_tid;
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 9bd4d336d444..fad457f99711 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -225,9 +225,6 @@ static void ieee80211_frame_acked(struct sta_info *sta, struct sk_buff *skb)
 			 */
 			sdata->deflink.smps_mode = smps_mode;
 			ieee80211_queue_work(&local->hw, &sdata->recalc_smps);
-		} else if (sdata->vif.type == NL80211_IFTYPE_AP ||
-			   sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
-			sta->known_smps_mode = smps_mode;
 		}
 	}
 }
-- 
2.36.1

