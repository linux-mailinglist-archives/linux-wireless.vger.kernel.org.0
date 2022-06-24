Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C855A1C0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiFXTNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiFXTNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 15:13:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7DB4B1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ci4rribwEHxyUcm1miVtwoazSs6ChpHM66/8j+Vi/jM=; b=OJEzeSe7h8WP71MphydWBwkKzT
        +mcYssrc5KuCakaTqceSbn4jk1yyvfHwuAWr6U9eWAKLUSuqkfKCg5ICrmB3A54tjjTVqCmf/hiik
        eHroevOPGSFUqfh4AakFqESd+5lA9JS17WGt7o9ekdMmeKm6hntkbnj6Ly2AwkQrcZ4w=;
Received: from p200300daa71a4800391046fbc91acf5a.dip0.t-ipconnect.de ([2003:da:a71a:4800:3910:46fb:c91a:cf5a] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o4ojm-0002r8-Tv
        for linux-wireless@vger.kernel.org; Fri, 24 Jun 2022 21:13:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: allow receiving frames with invalid CCMP PN via monitor interfaces
Date:   Fri, 24 Jun 2022 21:12:59 +0200
Message-Id: <20220624191300.52766-3-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624191300.52766-1-nbd@nbd.name>
References: <20220624191300.52766-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be useful for debugging

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ecf5bd9605db..cb41f54bdd1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1018,7 +1018,7 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	*hw = mt76_phy_hw(dev, mstat.ext_phy);
 }
 
-static int
+static void
 mt76_check_ccmp_pn(struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -1028,13 +1028,13 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	int ret;
 
 	if (!(status->flag & RX_FLAG_DECRYPTED))
-		return 0;
+		return;
 
 	if (status->flag & RX_FLAG_ONLY_MONITOR)
-		return 0;
+		return;
 
 	if (!wcid || !wcid->rx_check_pn)
-		return 0;
+		return;
 
 	security_idx = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	if (status->flag & RX_FLAG_8023)
@@ -1048,7 +1048,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 		 */
 		if (ieee80211_is_frag(hdr) &&
 		    !ieee80211_is_first_frag(hdr->frame_control))
-			return 0;
+			return;
 	}
 
 	/* IEEE 802.11-2020, 12.5.3.4.4 "PN and replay detection" c):
@@ -1065,15 +1065,15 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	BUILD_BUG_ON(sizeof(status->iv) != sizeof(wcid->rx_key_pn[0]));
 	ret = memcmp(status->iv, wcid->rx_key_pn[security_idx],
 		     sizeof(status->iv));
-	if (ret <= 0)
-		return -EINVAL; /* replay */
+	if (ret <= 0) {
+		status->flag |= RX_FLAG_ONLY_MONITOR;
+		return;
+	}
 
 	memcpy(wcid->rx_key_pn[security_idx], status->iv, sizeof(status->iv));
 
 	if (status->flag & RX_FLAG_IV_STRIPPED)
 		status->flag |= RX_FLAG_PN_VALIDATED;
-
-	return 0;
 }
 
 static void
@@ -1246,11 +1246,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 	while ((skb = __skb_dequeue(frames)) != NULL) {
 		struct sk_buff *nskb = skb_shinfo(skb)->frag_list;
 
-		if (mt76_check_ccmp_pn(skb)) {
-			dev_kfree_skb(skb);
-			continue;
-		}
-
+		mt76_check_ccmp_pn(skb);
 		skb_shinfo(skb)->frag_list = NULL;
 		mt76_rx_convert(dev, skb, &hw, &sta);
 		ieee80211_rx_list(hw, sta, skb, &list);
-- 
2.36.1

