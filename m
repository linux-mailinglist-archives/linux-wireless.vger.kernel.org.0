Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369DE6978A1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjBOJHV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjBOJHU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 04:07:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A7A298E9
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=30omODvdUwgcFGtZeR3UZrGUHZefoMYLhhUe2x89sEo=; t=1676452039; x=1677661639; 
        b=farhVL8+79zt7C/qywQCQQbfvguKa0wkjlS8gXgqU10n0gygHSLktRPtDVMmTZ+TGMQc+yqnfud
        7x0nsnQWs8WKRH2qJHvXh4sFx3PH6D1twVw3Cfq42fkxu390VK/bMHeqvCe0POKgdt14Hminxn8l/
        TYlMHAK2du4srMEZ1K40Dov2ZtxC/pxB/co0WQCCDyBA+C9KGyJ4x9+HECZ8Aks38qxuramy8JE/8
        UEkv3A0mluW6ObInq0G/HjaJwqO6fsXvIpuaCy+NnZft0WV2hvCdIuYSvNjV7KjPKCWFI66ZAbbLg
        Y5RzpRce76JB3A8wRhvO6m7OWQXsS8i9rA9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSDkq-00CzjM-20;
        Wed, 15 Feb 2023 10:07:12 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: pass 'sta' to ieee80211_rx_data_set_sta()
Date:   Wed, 15 Feb 2023 10:07:05 +0100
Message-Id: <20230215100704.2d77db5fb9d3.I8458a64f5ef0029dd8d6bc66380df156d0b6895c@changeid>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's at least one case in ieee80211_rx_for_interface()
where we might pass &((struct sta_info *)NULL)->sta to it
only to then do container_of(), and then checking the
result for NULL, but checking the result of container_of()
for NULL looks really odd.

Fix this by just passing the struct sta_info * instead.

Fixes: e66b7920aa5a ("wifi: mac80211: fix initialization of rx->link and rx->link_sta")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7bcd77384191..69aa623163c6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4115,13 +4115,8 @@ static bool ieee80211_rx_data_set_link(struct ieee80211_rx_data *rx,
 }
 
 static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
-				      struct ieee80211_sta *pubsta,
-				      int link_id)
+				      struct sta_info *sta, int link_id)
 {
-	struct sta_info *sta;
-
-	sta = container_of(pubsta, struct sta_info, sta);
-
 	rx->link_id = link_id;
 	rx->sta = sta;
 
@@ -4159,7 +4154,7 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 	if (sta->sta.valid_links)
 		link_id = ffs(sta->sta.valid_links) - 1;
 
-	if (!ieee80211_rx_data_set_sta(&rx, &sta->sta, link_id))
+	if (!ieee80211_rx_data_set_sta(&rx, sta, link_id))
 		return;
 
 	tid_agg_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
@@ -4205,7 +4200,7 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 
 	sta = container_of(pubsta, struct sta_info, sta);
 
-	if (!ieee80211_rx_data_set_sta(&rx, pubsta, -1))
+	if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
 		return;
 
 	rcu_read_lock();
@@ -4914,6 +4909,7 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_fast_rx *fast_rx;
 	struct ieee80211_rx_data rx;
+	struct sta_info *sta;
 	int link_id = -1;
 
 	memset(&rx, 0, sizeof(rx));
@@ -4941,7 +4937,8 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	 * link_id is used only for stats purpose and updating the stats on
 	 * the deflink is fine?
 	 */
-	if (!ieee80211_rx_data_set_sta(&rx, pubsta, link_id))
+	sta = container_of(pubsta, struct sta_info, sta);
+	if (!ieee80211_rx_data_set_sta(&rx, sta, link_id))
 		goto drop;
 
 	fast_rx = rcu_dereference(rx.sta->fast_rx);
@@ -4981,7 +4978,7 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 			link_id = status->link_id;
 	}
 
-	if (!ieee80211_rx_data_set_sta(rx, &sta->sta, link_id))
+	if (!ieee80211_rx_data_set_sta(rx, sta, link_id))
 		return false;
 
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
@@ -5048,7 +5045,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			link_id = status->link_id;
 
 		if (pubsta) {
-			if (!ieee80211_rx_data_set_sta(&rx, pubsta, link_id))
+			sta = container_of(pubsta, struct sta_info, sta);
+			if (!ieee80211_rx_data_set_sta(&rx, sta, link_id))
 				goto out;
 
 			/*
@@ -5085,8 +5083,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			}
 
 			rx.sdata = prev_sta->sdata;
-			if (!ieee80211_rx_data_set_sta(&rx, &prev_sta->sta,
-						       link_id))
+			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
 			if (!status->link_valid && prev_sta->sta.mlo)
@@ -5099,8 +5096,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 		if (prev_sta) {
 			rx.sdata = prev_sta->sdata;
-			if (!ieee80211_rx_data_set_sta(&rx, &prev_sta->sta,
-						       link_id))
+			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
 			if (!status->link_valid && prev_sta->sta.mlo)
-- 
2.39.1

