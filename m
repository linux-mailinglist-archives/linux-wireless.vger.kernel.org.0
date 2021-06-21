Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0094A3AF818
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFUVzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 17:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhFUVzo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 17:55:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 038B661001;
        Mon, 21 Jun 2021 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624312409;
        bh=ohYCjxpQLVW8UEqoLOFciBvqpUrfpOGOvmJF/KWSl+w=;
        h=From:To:Cc:Subject:Date:From;
        b=VE3Fq4flPhJInWZfB5zRyQVR2U51pgsbTUJkgpNSa8h4x2+xFzZEICwdBbfE4SVd1
         2GJpPlikqgZVv5aimwJNqmyvMKF92b+d4HOjdTGz3BkrSM5DjY2wsAbLruExasP+gB
         Ig+VN7rWDmJ2jqosaoKWg0WvP4SZcK9LfXLnT/YG7vXjgMISdKYZP48Ai5TOikS1Gy
         xVSvWmrgh7NrhswFVNIdtWMXGeQMq/B1QhPueQNqGulurxNtIdokGVQrh0fSEknizr
         PoP0au7fChnvOmzPBRAx9ZxwOHaP7S2y30AasOAdLajMBnguGHlwztpJo3yu0CwYdX
         RFdJsdOvCvMGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix endianness warning in mt7615_mac_write_txwi
Date:   Mon, 21 Jun 2021 23:53:22 +0200
Message-Id: <82825956b62cec7832b70e21f166e1f6d3ca2fc0.1624312262.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7615_mac_write_txwi routine:
drivers/net/wireless/mediatek/mt76/mt7615/mac.c:758:17:
	warning: incorrect type in assignment
	expected restricted __le32 [usertype]
	got unsigned long

Fixes: 04b8e65922f63 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Fixes: d4bf77bd74930 ("mt76: mt7615: introduce mt7663u support to mt7615_write_txwi")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ff3f85e4087c..5a8539d5f030 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -755,12 +755,15 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
 
-	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype) |
-		  FIELD_PREP(MT_TXD7_SPE_IDX, 0x18);
-	if (!is_mmio)
-		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
-			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD7_SPE_IDX, 0x18);
+	txwi[7] = cpu_to_le32(val);
+	if (!is_mmio) {
+		val = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+		txwi[8] = cpu_to_le32(val);
+	}
 
 	return 0;
 }
-- 
2.31.1

