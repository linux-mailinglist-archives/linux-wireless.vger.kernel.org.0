Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0836CFF63
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjC3JAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC3JAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:00:08 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E77ABC
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZmDoX9tqRdpumEpPrqcNwimERQbafC5h+WYFHMB+fps=; b=G3voeXTZredRt/hahKlsqGPDCf
        VfSjhWuqWsQ8RQPmE2tVGDU15T7WcislnOa0T6AY8k89RK4KiHdIKpZaZeDJpGvs4YdfdjfuIU8iG
        Ka1Vpb5Mh85759g6inSM/MTe/1ZWDEg5nAR8tECsNEB0albhUVah96OCNi7uPmkg6Pkc=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pho8Y-008U3j-Bp; Thu, 30 Mar 2023 11:00:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH wireless 2/2] wifi: mac80211: fix potential null pointer dereference
Date:   Thu, 30 Mar 2023 11:00:01 +0200
Message-Id: <20230330090001.60750-2-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230330090001.60750-1-nbd@nbd.name>
References: <20230330090001.60750-1-nbd@nbd.name>
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

rx->sta->amsdu_mesh_control is being passed to ieee80211_amsdu_to_8023s
without checking rx->sta. Since it doesn't make sense to accept A-MSDU
packets without a sta, simply add a check earlier.

Fixes: 6e4c0d0460bd ("wifi: mac80211: add a workaround for receiving non-standard mesh A-MSDU")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b7b584a28163..af57616d2f1d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2933,7 +2933,7 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 					  data_offset, true))
 		return RX_DROP_UNUSABLE;
 
-	if (rx->sta && rx->sta->amsdu_mesh_control < 0) {
+	if (rx->sta->amsdu_mesh_control < 0) {
 		bool valid_std = ieee80211_is_valid_amsdu(skb, true);
 		bool valid_nonstd = ieee80211_is_valid_amsdu(skb, false);
 
@@ -3009,7 +3009,7 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 		}
 	}
 
-	if (is_multicast_ether_addr(hdr->addr1))
+	if (is_multicast_ether_addr(hdr->addr1) || !rx->sta)
 		return RX_DROP_UNUSABLE;
 
 	if (rx->key) {
-- 
2.39.0

