Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255BA2DC7E8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgLPUon (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgLPUon (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:43 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E273C061282
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aT4lomNqApapOvvd60XSbBMC8nblHxG/yMRMWTVGhpA=; b=iBo7yB2SfP636TiTbdu4ZEcNWs
        mW/q/FFLtnWcEQosGScErCizgZMFZyR0yW+ZhVNb5lXJ6OVcmTS+ll1dak5CTNH5EBYs0nTkw1bd/
        ES3zdiMVyFh1OFfZYyAVB5gmEUc2Q2PGJYFMHcqZSxeaP4g/V4Wp+czKSAr8MsZxGN0I=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpddm-0002eR-6m; Wed, 16 Dec 2020 21:43:18 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/7] mac80211: force calculation of software hash for tx fair queueing
Date:   Wed, 16 Dec 2020 21:43:11 +0100
Message-Id: <20201216204316.44498-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Depending on the source, a hardware calculated hash may not provide the
same level of collision resistance.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..f1c934f21d7e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3937,7 +3937,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	if (local->ops->wake_tx_queue) {
 		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
+		if (!skb->sw_hash)
+			__skb_get_hash(skb);
 	}
 
 	if (sta) {
@@ -4191,7 +4192,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (local->ops->wake_tx_queue) {
 		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
-		skb_get_hash(skb);
+		if (!skb->sw_hash)
+			__skb_get_hash(skb);
 	}
 
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
-- 
2.28.0

