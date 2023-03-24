Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6C6C7DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCXMJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCXMJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 08:09:28 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469F136CC
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=edqPWcX+G96zWJ41I+N+V/aw5XhgRf/AlL6WPK207lI=; b=Y7pzb8wyq+YSKYB0vKDEUhcITs
        ncH5+cY+HVI7lDmGTdmc18tKyvJ1chUfCp4ip9/ym0xpwwBdwWU10eB0kHmfT1Jz9LrsH3Yo7SpmQ
        EU2RqhDsLAB+FeJBhHYu64i7/QhIb9rZDoHSfj4NXfzywuMZUExQ5faki64YLbVX18JA=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pfgEX-006Liq-1y; Fri, 24 Mar 2023 13:09:25 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/3] wifi: mac80211: fix mesh forwarding
Date:   Fri, 24 Mar 2023 13:09:22 +0100
Message-Id: <20230324120924.38412-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linearize packets (needed for forwarding A-MSDU subframes).

Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e8de500eb9f3..4be80c7dda95 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2833,6 +2833,9 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 
 		if (skb_cow_head(fwd_skb, hdrlen - sizeof(struct ethhdr)))
 			return RX_DROP_UNUSABLE;
+
+		if (skb_linearize(fwd_skb))
+			return RX_DROP_UNUSABLE;
 	}
 
 	fwd_hdr = skb_push(fwd_skb, hdrlen - sizeof(struct ethhdr));
-- 
2.39.0

