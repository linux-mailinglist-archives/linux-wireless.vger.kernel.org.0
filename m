Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFDC47E2ED
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbhLWMIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbhLWMIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FAEC061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40606B81FDC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F3C36AE9;
        Thu, 23 Dec 2021 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261295;
        bh=5jlWdDWajc7u7ENz0rzdx523p8WsoOuSDFLNpmg1d2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXyuUgFLgpQWekco7HHal2BKOR6TQtwvYvS604shmZ8/ZVKis421e2UE9JBfL4BNT
         zvdgdKCb8dVmvGuhKnGoM9aB/WFwWRkBOE8NT6tHu7oUfD3sJnivcN+n4d8/5KwyM4
         H2cn7XsEFP7VeQLYnqTYO/FDWsuAZ4ykLyJeUJMIhViqiUaXFMkPYX7iSsM+Q56+Yt
         YlFCKpygVHfAX1Iazov4+hL/e+hmYo7rvK4cJbhyygMCxRqh0CZgP/AR30DDWFy8xV
         yQWW/r0PO1/4idMnupNJEuxBpf8z/GFlQFiRFjd7yJ18tYQ/hSxATWq0HWbeTc/syS
         oxcIzWZykBTBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 08/15] mt76: mt7915: rely on mt76_connac_mcu_wtbl_generic_tlv
Date:   Thu, 23 Dec 2021 13:07:36 +0100
Message-Id: <973c72fc1607b0525d41f2fe8bff97d4cadfc969.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_wtbl_generic_tlv routine in mt7915 and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 45 +------------------
 2 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 14bfbbb3114e..b25f4ab44ad6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -530,7 +530,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 		generic->muar_idx = mvif->omac_idx;
 		generic->qos = sta->wme;
 	} else {
-		if (is_mt7921(dev) &&
+		if ((is_mt7921(dev) || is_mt7915(dev)) &&
 		    vif->type == NL80211_IFTYPE_STATION)
 			memcpy(generic->peer_addr, vif->bss_conf.bssid,
 			       ETH_ALEN);
@@ -548,7 +548,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 	rx->rca2 = 1;
 	rx->rv = 1;
 
-	if (is_mt7921(dev))
+	if (is_mt7921(dev) || is_mt7915(dev))
 		return;
 
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ef81b3ff48f9..03deec48a758 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -769,48 +769,6 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 				      enable, false);
 }
 
-static void
-mt7915_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, void *sta_wtbl,
-			    void *wtbl_tlv)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct wtbl_generic *generic;
-	struct wtbl_rx *rx;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_GENERIC,
-					     sizeof(*generic),
-					     wtbl_tlv, sta_wtbl);
-	generic = (struct wtbl_generic *)tlv;
-
-	if (sta) {
-		if (vif->type == NL80211_IFTYPE_STATION)
-			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
-		else
-			generic->partial_aid = cpu_to_le16(sta->aid);
-		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->muar_idx = mvif->mt76.omac_idx;
-		generic->qos = sta->wme;
-	} else {
-		/* use BSSID in station mode */
-		if (vif->type == NL80211_IFTYPE_STATION)
-			memcpy(generic->peer_addr, vif->bss_conf.bssid,
-			       ETH_ALEN);
-		else
-			eth_broadcast_addr(generic->peer_addr);
-
-		generic->muar_idx = 0xe;
-	}
-
-	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_RX, sizeof(*rx),
-					     wtbl_tlv, sta_wtbl);
-	rx = (struct wtbl_rx *)tlv;
-	rx->rca1 = sta ? vif->type != NL80211_IFTYPE_AP : 1;
-	rx->rca2 = 1;
-	rx->rv = 1;
-}
-
 static void
 mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, bool enable)
@@ -1249,7 +1207,8 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, tlv, wtbl_hdr);
+	mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, skb, vif, sta, tlv,
+					 wtbl_hdr);
 	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, tlv, wtbl_hdr);
 
 	if (sta)
-- 
2.33.1

