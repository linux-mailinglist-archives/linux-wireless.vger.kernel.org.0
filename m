Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9281251180
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHYF3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgHYF3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2579C061755
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UjdJ+DqFY1vz3zp2NdZ9v4r61Ys8Xln81rOGSrgrQco=; b=NM31q6Vn0SxmpVPHWtwIg+oQMR
        4xpZHzqYnYp8y8xKieT0zoT1QVBQc+UOC6mGh/xBQBbxuICDq4/lGw84hxx5vIdySxfLgLt5qImDK
        mf70QN2tK+TL1rTAHateFNSiWUFs8JfHyV5Vk6levhgJkwVi50wROvgNJnzPa/PJHOGY=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWB-0006jr-6V
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:11 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/9] mt76: mt7615: fix reading airtime statistics
Date:   Tue, 25 Aug 2020 07:29:01 +0200
Message-Id: <20200825052909.36955-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- change the WTBL LMAC access function to set the mapping window only once
- use ac * 2 as offset, since each AC has separate words for rx and tx

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9e17be5005e9..ff08a59c747c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -88,13 +88,12 @@ bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-static u32 mt7915_mac_wtbl_lmac_read(struct mt7915_dev *dev, u16 wcid,
-				     u16 addr)
+static u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid)
 {
 	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
 		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
 
-	return mt76_rr(dev, MT_WTBL_LMAC_OFFS(wcid, addr));
+	return MT_WTBL_LMAC_OFFS(wcid, 0);
 }
 
 /* TODO: use txfree airtime info to avoid runtime accessing in the long run */
@@ -121,6 +120,7 @@ void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 
 	while (true) {
 		bool clear = false;
+		u32 addr;
 		u16 idx;
 
 		spin_lock_bh(&dev->sta_poll_lock);
@@ -133,20 +133,23 @@ void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		list_del_init(&msta->poll_list);
 		spin_unlock_bh(&dev->sta_poll_lock);
 
-		for (i = 0, idx = msta->wcid.idx; i < IEEE80211_NUM_ACS; i++) {
+		idx = msta->wcid.idx;
+		addr = mt7915_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			u32 tx_last = msta->airtime_ac[i];
-			u32 rx_last = msta->airtime_ac[i + IEEE80211_NUM_ACS];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
 
-			msta->airtime_ac[i] =
-				mt7915_mac_wtbl_lmac_read(dev, idx, 20 + i);
-			msta->airtime_ac[i + IEEE80211_NUM_ACS] =
-				mt7915_mac_wtbl_lmac_read(dev, idx, 21 + i);
 			tx_time[i] = msta->airtime_ac[i] - tx_last;
-			rx_time[i] = msta->airtime_ac[i + IEEE80211_NUM_ACS] -
-				     rx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
 
 			if ((tx_last | rx_last) & BIT(30))
 				clear = true;
+
+			addr += 8;
 		}
 
 		if (clear) {
-- 
2.28.0

