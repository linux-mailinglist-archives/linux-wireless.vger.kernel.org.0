Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6163F21C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiLAN5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 08:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiLAN5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 08:57:36 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDBD4F
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cG6IJ2ZiykwAKzxlwE2Og+qUliEvZPYZU6XfRJtVBVM=; b=qXDTZ4bcB/+OjXGXUPWP9okNXT
        BJ8fDdDASJzLu5Kgr8aaj+uhPVxZijwjo0WaYqSUQAYmxdcGpY1b8QQztY9DbaqYZzX3D5HVDhylr
        6V7K9bF6W8/o+6t5lWkrf0egLLZ8nagXk2JltaBvh2h+xAKWBXerxv5vIUOLP+YkhoPQ=;
Received: from p200300daa7225c08186973351f2f7021.dip0.t-ipconnect.de ([2003:da:a722:5c08:1869:7335:1f2f:7021] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p0k4B-005gV6-9z; Thu, 01 Dec 2022 14:57:31 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: fix and simplify unencrypted drop check for mesh
Date:   Thu,  1 Dec 2022 14:57:30 +0100
Message-Id: <20221201135730.19723-1-nbd@nbd.name>
X-Mailer: git-send-email 2.38.1
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

ieee80211_drop_unencrypted is called from ieee80211_rx_h_mesh_fwding and
ieee80211_frame_allowed.

Since ieee80211_rx_h_mesh_fwding can forward packets for other mesh nodes
and is called earlier, it needs to check the decryptions status and if the
packet is using the control protocol on its own, instead of deferring to
the later call from ieee80211_frame_allowed.

Because of that, ieee80211_drop_unencrypted has a mesh specific check
that skips over the mesh header in order to check the payload protocol.
This code is invalid when called from ieee80211_frame_allowed, since that
happens after the 802.11->802.3 conversion.

Fix this by moving the mesh specific check directly into
ieee80211_rx_h_mesh_fwding.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c28c6fbf786e..7e3ab6e1b28f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2403,7 +2403,6 @@ static int ieee80211_802_1x_port_control(struct ieee80211_rx_data *rx)
 
 static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 {
-	struct ieee80211_hdr *hdr = (void *)rx->skb->data;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
@@ -2414,31 +2413,6 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	if (status->flag & RX_FLAG_DECRYPTED)
 		return 0;
 
-	/* check mesh EAPOL frames first */
-	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) &&
-		     ieee80211_is_data(fc))) {
-		struct ieee80211s_hdr *mesh_hdr;
-		u16 hdr_len = ieee80211_hdrlen(fc);
-		u16 ethertype_offset;
-		__be16 ethertype;
-
-		if (!ether_addr_equal(hdr->addr1, rx->sdata->vif.addr))
-			goto drop_check;
-
-		/* make sure fixed part of mesh header is there, also checks skb len */
-		if (!pskb_may_pull(rx->skb, hdr_len + 6))
-			goto drop_check;
-
-		mesh_hdr = (struct ieee80211s_hdr *)(skb->data + hdr_len);
-		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr) +
-				   sizeof(rfc1042_header);
-
-		if (skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2) == 0 &&
-		    ethertype == rx->sdata->control_port_protocol)
-			return 0;
-	}
-
-drop_check:
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
 		     !ieee80211_is_any_nullfunc(fc) &&
@@ -2892,8 +2866,16 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 	hdr = (struct ieee80211_hdr *) skb->data;
 	mesh_hdr = (struct ieee80211s_hdr *) (skb->data + hdrlen);
 
-	if (ieee80211_drop_unencrypted(rx, hdr->frame_control))
-		return RX_DROP_MONITOR;
+	if (ieee80211_drop_unencrypted(rx, hdr->frame_control)) {
+		int offset = hdrlen + ieee80211_get_mesh_hdrlen(mesh_hdr) +
+			     sizeof(rfc1042_header);
+		__be16 ethertype;
+
+		if (!ether_addr_equal(hdr->addr1, rx->sdata->vif.addr) ||
+		    skb_copy_bits(rx->skb, offset, &ethertype, 2) != 0 ||
+		    ethertype != rx->sdata->control_port_protocol)
+			return RX_DROP_MONITOR;
+	}
 
 	/* frame is in RMC, don't forward */
 	if (ieee80211_is_data(hdr->frame_control) &&
-- 
2.38.1

