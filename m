Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF436B8F18
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCNKAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCNKAM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:00:12 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5EB302AF
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RFp18Vozbn36N6p9ZvBzZC9ULWqDNP1W16QzSXooU24=; b=L7Jy9nOFbmxPaPS+RzBYyolg5W
        OWizTbalGA25skVzbJAvwt0xQ/QKp56PQEVIhnAs7ETmRTXqJ3/aWjaCAT6j/zwvyhLWt0dQTTM9N
        EF0qP5XHXAGG1tr19SUtCIbWdBxPA2y51tFvaBn/6r6lEExdJbr9ktLf2D2Osiw0+s/o=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pc1Rn-001pV5-1H; Tue, 14 Mar 2023 10:59:59 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/7] wifi: mac80211: fix qos on mesh interfaces
Date:   Tue, 14 Mar 2023 10:59:50 +0100
Message-Id: <20230314095956.62085-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When ieee80211_select_queue is called for mesh, the sta pointer is usually
NULL, since the nexthop is looked up much later in the tx path.
Explicitly check for unicast address in that case in order to make qos work
again.

Fixes: 50e2ab392919 ("wifi: mac80211: fix queue selection for mesh/OCB interfaces")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/wme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index a12c63638680..1601be576414 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -147,6 +147,7 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 			   struct sta_info *sta, struct sk_buff *skb)
 {
+	const struct ethhdr *eth = (void *)skb->data;
 	struct mac80211_qos_map *qos_map;
 	bool qos;
 
@@ -154,8 +155,9 @@ u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	skb_get_hash(skb);
 
 	/* all mesh/ocb stations are required to support WME */
-	if (sta && (sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
-		    sdata->vif.type == NL80211_IFTYPE_OCB))
+	if ((sdata->vif.type == NL80211_IFTYPE_MESH_POINT &&
+	    !is_multicast_ether_addr(eth->h_dest)) ||
+	    (sdata->vif.type == NL80211_IFTYPE_OCB && sta))
 		qos = true;
 	else if (sta)
 		qos = sta->sta.wme;
-- 
2.39.0

