Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E156A3FFA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB0LHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 06:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjB0LHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 06:07:45 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54EB472
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RFp18Vozbn36N6p9ZvBzZC9ULWqDNP1W16QzSXooU24=; b=XqLw/L1b6wCmXUZT2o1BLXFE9N
        Uip1V4BgxoP2JC72ESStw0xhOAZShXiXmoKsQvm0D78vkyu/r7eA00StrT2DDAes/LbdaM54aCtJv
        +FBaoy40l2qAq5f9UaNJG3J08U1zthLL3BZaWjVe3E7Y6QRvkoQjWhEnWLVitOiHhPGg=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pWbM5-00CVRm-Dk; Mon, 27 Feb 2023 12:07:41 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC 1/5] wifi: mac80211: fix qos on mesh interfaces
Date:   Mon, 27 Feb 2023 12:07:34 +0100
Message-Id: <20230227110738.54241-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
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

