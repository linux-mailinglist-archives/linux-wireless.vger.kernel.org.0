Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45BE694256
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBMKJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 05:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBMKJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 05:09:32 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB7E11176
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oKmO2irHX8QYFTy+OUcG1vxyv0LndsMzQWUXUtY8SQk=; b=SyjSgex0c0EVIiSm3ddQbS4T0Q
        H+s3h5RKZI46YKXTo8olkwjuXgPzriy0XsmyJ8sPSBr4vzLQ28yIQ3sYFttw/0nSAFTBPdlpUCcTu
        +91+ZddYdGviFSBqIpvCkDKPLnXvH/XEqBRQYjKATMQqgrxM5QMNczeszQjJBT49KKz0=;
Received: from p200300daa73b49008dd6ef632c4ae296.dip0.t-ipconnect.de ([2003:da:a73b:4900:8dd6:ef63:2c4a:e296] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pRVld-007ay2-Cn; Mon, 13 Feb 2023 11:09:01 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 3/5] wifi: mac80211: remove mesh forwarding congestion check
Date:   Mon, 13 Feb 2023 11:08:53 +0100
Message-Id: <20230213100855.34315-3-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230213100855.34315-1-nbd@nbd.name>
References: <20230213100855.34315-1-nbd@nbd.name>
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
index d16606e84e22..23a01b68cf0f 100644
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
index e284897ba5e9..519bd9daea75 100644
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
2.39.0

