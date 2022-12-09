Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0A648974
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLIUV3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 15:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIUVZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 15:21:25 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E2F8D1A2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 12:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fKYI6OAqF+SpWA8qiyC81/qgHDKojzn+u9djASHchYA=; b=KqCeJNVjlH/LoX1WxrQ0uyQxPC
        AUgSYhyFE/qh4mcZCz/GaRSxv4cmNEqBxGKNe00Sj1d6k5QLbTHe/4tT2uhqsChvQ+xYn9tC4TtwL
        V8ywtpON0ihOaw0VRjmZFGE10XMcS/KqAg0M94pByVc4muOu2NyMg/lRfyweOPYZYXGQ=;
Received: from p200300daa71613018d4aa8a5d898f578.dip0.t-ipconnect.de ([2003:da:a716:1301:8d4a:a8a5:d898:f578] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p3js2-007Tjz-6G; Fri, 09 Dec 2022 21:21:22 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC 3/5] wifi: mac80211: remove mesh forwarding congestion check
Date:   Fri,  9 Dec 2022 21:21:19 +0100
Message-Id: <20221209202121.55951-3-nbd@nbd.name>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209202121.55951-1-nbd@nbd.name>
References: <20221209202121.55951-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that all drivers use iTXQ, it does not make sense to check to drop
tx forwarding packets when the driver has stopped the queues.
fq_codel will take care of dropping packets when the queues fill up

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/debugfs_netdev.c | 3 ---
 net/mac80211/ieee80211_i.h    | 1 -
 net/mac80211/rx.c             | 5 -----
 3 files changed, 9 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index c87e1137e5da..0bac9af3ca96 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -603,8 +603,6 @@ IEEE80211_IF_FILE(fwded_mcast, u.mesh.mshstats.fwded_mcast, DEC);
 IEEE80211_IF_FILE(fwded_unicast, u.mesh.mshstats.fwded_unicast, DEC);
 IEEE80211_IF_FILE(fwded_frames, u.mesh.mshstats.fwded_frames, DEC);
 IEEE80211_IF_FILE(dropped_frames_ttl, u.mesh.mshstats.dropped_frames_ttl, DEC);
-IEEE80211_IF_FILE(dropped_frames_congestion,
-		  u.mesh.mshstats.dropped_frames_congestion, DEC);
 IEEE80211_IF_FILE(dropped_frames_no_route,
 		  u.mesh.mshstats.dropped_frames_no_route, DEC);
 
@@ -740,7 +738,6 @@ static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 	MESHSTATS_ADD(fwded_frames);
 	MESHSTATS_ADD(dropped_frames_ttl);
 	MESHSTATS_ADD(dropped_frames_no_route);
-	MESHSTATS_ADD(dropped_frames_congestion);
 #undef MESHSTATS_ADD
 }
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..6ec4deb77568 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -327,7 +327,6 @@ struct mesh_stats {
 	__u32 fwded_frames;		/* Mesh total forwarded frames */
 	__u32 dropped_frames_ttl;	/* Not transmitted since mesh_ttl == 0*/
 	__u32 dropped_frames_no_route;	/* Not transmitted, no route found */
-	__u32 dropped_frames_congestion;/* Not forwarded due to congestion */
 };
 
 #define PREQ_Q_F_START		0x1
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7e3ab6e1b28f..5c354d3c6b90 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2926,11 +2926,6 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	ac = ieee802_1d_to_ac[skb->priority];
-	q = sdata->vif.hw_queue[ac];
-	if (ieee80211_queue_stopped(&local->hw, q)) {
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_congestion);
-		return RX_DROP_MONITOR;
-	}
 	skb_set_queue_mapping(skb, ac);
 
 	if (!--mesh_hdr->ttl) {
-- 
2.38.1

