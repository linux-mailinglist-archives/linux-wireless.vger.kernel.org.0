Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A827A24CC95
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHUEUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHUEUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:20:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F76C061344
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qH6HbVR5l88KQtZQN6tDQwkuMqYledfoH9ECPrkSWq0=; b=Hxhkm5GA5dgzUX8ilI+0R0982V
        h8JFgln7gU5IhduqALdgZITnj9TnNn66dtqvA75U4Es6AejwbiF/AEiSoyOEOI5qZhgw4JIgcDsKx
        YL5zvkaTo8VECul+OQdw41CsLrJL0H0mqEXpnXfp9g7th3coFB8vVSe0XmnI6Cqj3GvQ=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX7-0005s7-39; Fri, 21 Aug 2020 06:20:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 07/13] mac80211: add missing queue/hash initialization to 802.3 xmit
Date:   Fri, 21 Aug 2020 06:19:55 +0200
Message-Id: <20200821042001.23388-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes AQL for encap-offloaded tx

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 518a1ed4f088..04d8e528357b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4209,6 +4209,12 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (is_zero_ether_addr(ra))
 		goto out_free;
 
+	if (local->ops->wake_tx_queue) {
+		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		skb_set_queue_mapping(skb, queue);
+		skb_get_hash(skb);
+	}
+
 	multicast = is_multicast_ether_addr(ra);
 
 	if (sta)
-- 
2.28.0

