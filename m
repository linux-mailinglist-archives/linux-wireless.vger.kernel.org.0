Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEA6A3FF8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB0LHq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 06:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0LHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 06:07:45 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA014C35
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MzlInYWhSuoosdFdJsg44R3H5Qz6NGq11b+GR5jwlB0=; b=mZRBMFZLtPkLkvdMDXMX/LUbqX
        SVVoFxHFLjK21OJq15+UYceg7rzKbYCDPdvwalC8sixDPQCu7cKjdeIoNmIPYygbpvGiYxRW3VYIa
        qylNKfLDcjoQTmXCQkwjFBsW0dNo3XiMfZ5SqxwCpx4z9OmiZqJpBIExapn+61PBHuME=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pWbM5-00CVRm-QI; Mon, 27 Feb 2023 12:07:41 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC 3/5] wifi: mac80211: fix mesh path discovery based on unicast packets
Date:   Mon, 27 Feb 2023 12:07:36 +0100
Message-Id: <20230227110738.54241-3-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230227110738.54241-1-nbd@nbd.name>
References: <20230227110738.54241-1-nbd@nbd.name>
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

If a packet has reached its intended destination, it was bumped to the code
that accepts it, without first checking if a mesh_path needs to be created
based on the discovered source.
Fix this by moving the destination address check further down

Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f7fdfe710951..e8de500eb9f3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2765,17 +2765,6 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	    mesh_rmc_check(sdata, eth->h_source, mesh_hdr))
 		return RX_DROP_MONITOR;
 
-	/* Frame has reached destination.  Don't forward */
-	if (ether_addr_equal(sdata->vif.addr, eth->h_dest))
-		goto rx_accept;
-
-	if (!ifmsh->mshcfg.dot11MeshForwarding) {
-		if (is_multicast_ether_addr(eth->h_dest))
-			goto rx_accept;
-
-		return RX_DROP_MONITOR;
-	}
-
 	/* forward packet */
 	if (sdata->crypto_tx_tailroom_needed_cnt)
 		tailroom = IEEE80211_ENCRYPT_TAILROOM;
@@ -2814,6 +2803,17 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 		rcu_read_unlock();
 	}
 
+	/* Frame has reached destination.  Don't forward */
+	if (ether_addr_equal(sdata->vif.addr, eth->h_dest))
+		goto rx_accept;
+
+	if (!ifmsh->mshcfg.dot11MeshForwarding) {
+		if (is_multicast_ether_addr(eth->h_dest))
+			goto rx_accept;
+
+		return RX_DROP_MONITOR;
+	}
+
 	skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
 
 	ieee80211_fill_mesh_addresses(&hdr, &hdr.frame_control,
-- 
2.39.0

