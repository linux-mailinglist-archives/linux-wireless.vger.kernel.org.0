Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E626C9613
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Mar 2023 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjCZPRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Mar 2023 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCZPRN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Mar 2023 11:17:13 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E70618B
        for <linux-wireless@vger.kernel.org>; Sun, 26 Mar 2023 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g67iemp4a5ZY3/Izgvc6vMuYMeqghqWqTzNujp08mHA=; b=FjuB6TO5drnp+p/fp+z3SStJ8b
        Cq96BDFQlHwDj9xPJvsc0hSqtZsqKyrqxtXKodd9WwaQex1qMA1DIuxttlfWwlSL5qmQV/rHu9ehO
        auil/hOHDWRkL2nc40ui3HNgiW6LeRAHiA9lREPKB4Tn6/rS9vfjOGEjEXD4KMxCnABQ=;
Received: from p200300daa7147b001c0995ef5c325d3e.dip0.t-ipconnect.de ([2003:da:a714:7b00:1c09:95ef:5c32:5d3e] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pgS7J-0073JK-St; Sun, 26 Mar 2023 17:17:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        =?UTF-8?q?Thomas=20H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        Nick Hainke <vincent@systemli.org>
Subject: [PATCH] wifi: mac80211: fix receiving mesh packets in forwarding=0 networks
Date:   Sun, 26 Mar 2023 17:17:09 +0200
Message-Id: <20230326151709.17743-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When forwarding is set to 0, frames are typically sent with ttl=1.
Move the ttl decrement check below the check for local receive in order to
fix packet drops.

Reported-by: Thomas Hühn <thomas.huehn@hs-nordhausen.de>
Reported-by: Nick Hainke <vincent@systemli.org>
Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bab839a0f59a..7e270eaeef72 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2769,14 +2769,6 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	if (sdata->crypto_tx_tailroom_needed_cnt)
 		tailroom = IEEE80211_ENCRYPT_TAILROOM;
 
-	if (!--mesh_hdr->ttl) {
-		if (multicast)
-			goto rx_accept;
-
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
-		return RX_DROP_MONITOR;
-	}
-
 	if (mesh_hdr->flags & MESH_FLAGS_AE) {
 		struct mesh_path *mppath;
 		char *proxied_addr;
@@ -2807,6 +2799,14 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	if (ether_addr_equal(sdata->vif.addr, eth->h_dest))
 		goto rx_accept;
 
+	if (!--mesh_hdr->ttl) {
+		if (multicast)
+			goto rx_accept;
+
+		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
+		return RX_DROP_MONITOR;
+	}
+
 	if (!ifmsh->mshcfg.dot11MeshForwarding) {
 		if (is_multicast_ether_addr(eth->h_dest))
 			goto rx_accept;
-- 
2.39.0

