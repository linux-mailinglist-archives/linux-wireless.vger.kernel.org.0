Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714C539E8A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbiFAHkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349068AbiFAHkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE0994C1
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Y4u7VniItOvRLcAbRwRPXJ7acscj1tnnhkg/mC5Tig=;
        t=1654069206; x=1655278806; b=kL5ewSfVOFjNdzdBf6DPe/wuAmh48tLCubzZ4Tjeh2BfMTd
        ZzHqQPnLkBBkL4Kt29Q46T4FdaV+qjD/wRIm/OS3wmY/abFClsor8zq5VIeWvto4PhD7nU1MzE7dx
        zKKHTMs6apb9ESwCNDILiOxqOAYo4deqfvrewQtLWvpm241AbTZIzm019qHcLRLcrTiPSP6NYJBig
        P73nIVcEihik06Fvt5JnQy7yFrF2WTm+Qmrs/7XuuGpURpT2e9x6/KzbJoffE7tDD7YQtkyv51TKL
        gfKaZCD3+ZWZGxU/1RFzXQecydsoMw+4RL7GpXD9uK+iW0FQ+psy5y0CrLFUowog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxY-00AJPK-Hx;
        Wed, 01 Jun 2022 09:40:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] mac80211: HT: make ieee80211_ht_cap_ie_to_sta_ht_cap() MLO-aware
Date:   Wed,  1 Jun 2022 09:39:55 +0200
Message-Id: <20220601093922.22afd6b3cda3.Ibd21d8bb2652b4382fd90d8fd553f6d485497c60@changeid>
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

Update ieee80211_ht_cap_ie_to_sta_ht_cap() to handle per-link
data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ht.c          | 13 +++++++------
 net/mac80211/ibss.c        |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh_plink.c  |  2 +-
 net/mac80211/mlme.c        |  2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0afff3b0aeee..cc332b31d219 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1762,7 +1762,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-						  params->ht_capa, sta);
+						  params->ht_capa, sta, 0);
 
 	/* VHT can override some HT caps such as the A-MSDU max length */
 	if (params->vht_capa)
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index ac94dd69c0a2..22677df83ed8 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -138,7 +138,7 @@ void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_supported_band *sband,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
-				       struct sta_info *sta)
+				       struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sta_ht_cap ht_cap, own_cap;
 	u8 ampdu_info, tx_mcs_set_cap;
@@ -243,11 +243,12 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_3839;
 
  apply:
-	changed = memcmp(&sta->sta.deflink.ht_cap, &ht_cap, sizeof(ht_cap));
+	changed = memcmp(&sta->sta.link[link_id]->ht_cap,
+			 &ht_cap, sizeof(ht_cap));
 
-	memcpy(&sta->sta.deflink.ht_cap, &ht_cap, sizeof(ht_cap));
+	memcpy(&sta->sta.link[link_id]->ht_cap, &ht_cap, sizeof(ht_cap));
 
-	switch (sdata->vif.bss_conf.chandef.width) {
+	switch (sdata->vif.link_conf[link_id]->chandef.width) {
 	default:
 		WARN_ON_ONCE(1);
 		fallthrough;
@@ -264,9 +265,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	sta->sta.deflink.bandwidth = bw;
+	sta->sta.link[link_id]->bandwidth = bw;
 
-	sta->deflink.cur_max_bandwidth =
+	sta->link[link_id]->cur_max_bandwidth =
 		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 87815a3624f3..09c11c067cbf 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1051,7 +1051,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		memcpy(&htcap_ie, elems->ht_cap_elem, sizeof(htcap_ie));
 		rates_updated |= ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 								   &htcap_ie,
-								   sta);
+								   sta, 0);
 
 		if (elems->vht_operation && elems->vht_cap_elem &&
 		    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_20 &&
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c59dc8f6126b..e75496a99299 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2065,7 +2065,7 @@ void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
 bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_supported_band *sband,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
-				       struct sta_info *sta);
+				       struct sta_info *sta, unsigned int link_id);
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 			  const u8 *da, u16 tid,
 			  u16 initiator, u16 reason_code);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index fb7e8a9600ca..b64614cd314d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -438,7 +438,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	sta->sta.deflink.supp_rates[sband->band] = rates;
 
 	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-					      elems->ht_cap_elem, sta))
+					      elems->ht_cap_elem, sta, 0))
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 459780169e23..30423b2d4eee 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3566,7 +3566,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	/* Set up internal HT/VHT capabilities */
 	if (elems->ht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-						  elems->ht_cap_elem, sta);
+						  elems->ht_cap_elem, sta, 0);
 
 	if (elems->vht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-- 
2.36.1

