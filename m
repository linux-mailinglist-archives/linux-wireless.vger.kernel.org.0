Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131E531A56F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBLTa7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 14:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbhBLTa5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 14:30:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B63BC64DEC;
        Fri, 12 Feb 2021 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613158215;
        bh=cAFVI/sIUjqcYPK+/LdAFJjFZevRIqoT+WGVKV/53Xk=;
        h=From:To:Cc:Subject:Date:From;
        b=J6J72jBruFPIYO69xn0Ib7DEacfJBTTe0eaXkjU5XeQKhn1rOM9wcX6kQlLnC2zpu
         4kMmibq9Ge7BLRybzXZ894NrjnuHafU05ohT60ycdwXPE3Jtto2q1BfP9w04eHWg+q
         rOXeo01+M6+p++SDkGgt1hCZ94F2pv9YF57DtfFmWyeL7xecnv/LaLpqJK5ISVlIXq
         GKwTRSYgBzIUgkVcQyq7NEODNc8WsazPbROhQWi083Mn3KZNN6NFxWOgLz1iHEROCO
         H6+nezDhREvdEaPK6YAcpmoI4qqUZoycyh2wjlYmI43rv4ucqlF23LpWdVBZBbHLOe
         PIMTcr+mfIZWQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: always check return value from mt7915_mcu_alloc_wtbl_req
Date:   Fri, 12 Feb 2021 20:30:04 +0100
Message-Id: <b1a1e14bda1b3cd561ff53cb991851a6b1f872aa.1613158075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As done for mt76_connac_mcu_alloc_wtbl_req, even if this is not a real
bug since mt7915_mcu_alloc_wtbl_req routine can fails just if nskb is NULL,
always check return value from mt7915_mcu_alloc_wtbl_req in order to avoid
possible future mistake.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 195929242b72..12281e4cf817 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1188,6 +1188,9 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
 					     &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	mt7915_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
 
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -1704,6 +1707,9 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 		return -ENOMEM;
 
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD(WTBL_UPDATE),
@@ -1728,6 +1734,9 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
 					     &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -2253,6 +2262,9 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
 					     sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	if (enable) {
 		mt7915_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
 		mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
-- 
2.29.2

