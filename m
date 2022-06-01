Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF0539E87
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350325AbiFAHkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbiFAHkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4DB972BE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ma6NY/yDeNWSdZDnYqORkmknqq/c7h0TANOhkMUqrL8=;
        t=1654069205; x=1655278805; b=RLRBiHvQE08iBupMnLVCvjvplufeU2TgOjXednGL9F9Xtgx
        7nnTeYyRPs+ACSm44uL/q0ghUZ28gM0tnFwbuWTZqrj1irhJVoDBg1FC2dPNF8KuqLO2vhvK9SneA
        8u8PQV35ndMrXJvkNAzShj9S6i9llr7L/5cme8XL10INddl6e/QnhrlrkM41r2l8Ni50cquBWnrAY
        9bGY/JJU7qP/XPJQ0iX8u+10XgBzGE63XMf0vi/PFsnk6CS04HPEI2sBUtXRCWR8eE9NHxsqszGuh
        hhR0WGktW+DrmopG0gtxjSFDaZP67KJ4KiYg2rOSPZMt3EaLwZ9+/g+akBFbHhoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxW-00AJPK-VL;
        Wed, 01 Jun 2022 09:40:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] mac80211: refactor some sta_info link handling
Date:   Wed,  1 Jun 2022 09:39:49 +0200
Message-Id: <20220601093922.6c0a4c18504b.I3424a3712c5005740d65a62ba766469dead8689c@changeid>
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

Refactor the code a bit to initialize a link belonging
to a station, and (later) free all allocated links.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6f6d83def8b8..f20ce7bbcb39 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -245,6 +245,20 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 	return NULL;
 }
 
+static void sta_info_free_links(struct sta_info *sta)
+{
+	unsigned int link_id;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+		if (!sta->link[link_id])
+			continue;
+		free_percpu(sta->link[link_id]->pcpu_rx_stats);
+
+		if (sta->link[link_id] != &sta->deflink)
+			kfree(sta->link[link_id]);
+	}
+}
+
 /**
  * sta_info_free - free STA
  *
@@ -287,7 +301,8 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
-	free_percpu(sta->deflink.pcpu_rx_stats);
+
+	sta_info_free_links(sta);
 	kfree(sta);
 }
 
@@ -333,6 +348,40 @@ static int sta_prepare_rate_control(struct ieee80211_local *local,
 	return 0;
 }
 
+static int sta_info_init_link(struct sta_info *sta,
+			      unsigned int link_id,
+			      struct link_sta_info *link_info,
+			      struct ieee80211_link_sta *link_sta,
+			      gfp_t gfp)
+{
+	struct ieee80211_local *local = sta->local;
+	struct ieee80211_hw *hw = &local->hw;
+	int i;
+
+	link_info->sta = sta;
+	link_info->link_id = link_id;
+
+	if (ieee80211_hw_check(hw, USES_RSS)) {
+		link_info->pcpu_rx_stats =
+			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
+		if (!link_info->pcpu_rx_stats)
+			return -ENOMEM;
+	}
+
+	sta->link[link_id] = link_info;
+	sta->sta.link[link_id] = link_sta;
+
+	link_info->rx_stats.last_rx = jiffies;
+	u64_stats_init(&link_info->rx_stats.syncp);
+
+	ewma_signal_init(&link_info->rx_stats_avg.signal);
+	ewma_avg_signal_init(&link_info->status_stats.avg_ack_signal);
+	for (i = 0; i < ARRAY_SIZE(link_info->rx_stats_avg.chain_signal); i++)
+		ewma_signal_init(&link_info->rx_stats_avg.chain_signal[i]);
+
+	return 0;
+}
+
 struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 				const u8 *addr, gfp_t gfp)
 {
@@ -345,12 +394,11 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return NULL;
 
-	if (ieee80211_hw_check(hw, USES_RSS)) {
-		sta->deflink.pcpu_rx_stats =
-			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
-		if (!sta->deflink.pcpu_rx_stats)
-			goto free;
-	}
+	sta->local = local;
+	sta->sdata = sdata;
+
+	if (sta_info_init_link(sta, 0, &sta->deflink, &sta->sta.deflink, gfp))
+		return NULL;
 
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
@@ -378,12 +426,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	/* TODO link specific alloc and assignments for MLO Link STA */
 
-	/* For non MLO STA, link info can be accessed either via deflink
-	 * or link[0]
-	 */
-	sta->link[0] = &sta->deflink;
-	sta->sta.link[0] = &sta->sta.deflink;
-
 	/* Extended Key ID needs to install keys for keyid 0 and 1 Rx-only.
 	 * The Tx path starts to use a key as soon as the key slot ptk_idx
 	 * references to is not NULL. To not use the initial Rx-only key
@@ -393,11 +435,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	BUILD_BUG_ON(ARRAY_SIZE(sta->ptk) <= INVALID_PTK_KEYIDX);
 	sta->ptk_idx = INVALID_PTK_KEYIDX;
 
-	sta->local = local;
-	sta->sdata = sdata;
-	sta->deflink.rx_stats.last_rx = jiffies;
-
-	u64_stats_init(&sta->deflink.rx_stats.syncp);
 
 	ieee80211_init_frag_cache(&sta->frags);
 
@@ -407,10 +444,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->reserved_tid = IEEE80211_TID_UNRESERVED;
 
 	sta->last_connected = ktime_get_seconds();
-	ewma_signal_init(&sta->deflink.rx_stats_avg.signal);
-	ewma_avg_signal_init(&sta->deflink.status_stats.avg_ack_signal);
-	for (i = 0; i < ARRAY_SIZE(sta->deflink.rx_stats_avg.chain_signal); i++)
-		ewma_signal_init(&sta->deflink.rx_stats_avg.chain_signal[i]);
 
 	if (local->ops->wake_tx_queue) {
 		void *txq_data;
@@ -532,7 +565,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (sta->sta.txq[0])
 		kfree(to_txq_info(sta->sta.txq[0]));
 free:
-	free_percpu(sta->deflink.pcpu_rx_stats);
+	sta_info_free_links(sta);
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
-- 
2.36.1

