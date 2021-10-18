Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7AD432332
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhJRPpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 11:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232019AbhJRPpq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 11:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0694D60EFE;
        Mon, 18 Oct 2021 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634571814;
        bh=NldW1K44RZqsrxtSXG15hhriiNzqzrsESRgfVWvnf+w=;
        h=From:To:Cc:Subject:Date:From;
        b=GFFtDnvc9PF7cgiu5toklAwKcGCDl8Hv2GEG9hdQELKCIGLNleFzgN3mSdsMMi+k0
         FKA+kYkMSIvNLdKE+s+/cLWEp+MQPp7843AFHnWykrTV4GKsZJWQxH4qLdot0mQnVb
         vZ4Yt3r6QjS/h3o9NxhY3dVkTBZwGvaUnU/eIoieBhKn9KGKXhyAL+2MWf6ffwCrpT
         fFFYLTqWe3lph1V/7fxIgP/MM2XYOCEcjW/B87BRZu0X+a+3j4KcuD1Wn5Stc+fJ/P
         lBpxjicGWA01YYZ7pe6HwQ2l0Ip41FZEX9VvQWuhtFMWdhVFyGFv/bOLwjpxWpsnb5
         a/8aKn2Qi4VGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: remove dead code in debugfs code
Date:   Mon, 18 Oct 2021 17:43:23 +0200
Message-Id: <1d18f29fdba4436bb0f53871d6afd7fd64a63ee6.1634571733.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove some more not used code in mt7915 debugfs.
Squash mt7915_puts_rate_txpower and mt7915_rate_txpower_show.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 31 ++++---------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 08a80b81a6c5..4b7f38fcbe64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -124,9 +124,6 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 	bool ext_phy = phy != &dev->phy;
 	int bound[15], range[4], i, n;
 
-	if (!phy)
-		return;
-
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
 		range[i] = mt76_rr(dev, MT_MIB_ARNG(ext_phy, i));
@@ -156,12 +153,7 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
 	};
-	struct mib_stats *mib;
-
-	if (!phy)
-		return;
-
-	mib = &phy->mib;
+	struct mib_stats *mib = &phy->mib;
 
 	/* Tx Beamformer monitor */
 	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
@@ -397,8 +389,8 @@ mt7915_xmit_queues_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_xmit_queues);
 
-static void
-mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
+static int
+mt7915_rate_txpower_show(struct seq_file *file, void *data)
 {
 	static const char * const sku_group_name[] = {
 		"CCK", "OFDM", "HT20", "HT40",
@@ -406,14 +398,11 @@ mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 		"RU26", "RU52", "RU106", "RU242/SU20",
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
+	struct mt7915_phy *phy = file->private;
 	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
 	int i;
 
-	if (!phy)
-		return;
-
-	seq_printf(s, "\nBand %d\n", phy != &phy->dev->phy);
-
+	seq_printf(file, "\nBand %d\n", phy != &phy->dev->phy);
 	mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower));
 	for (i = 0, buf = txpower; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
 		u8 mcs_num = mt7915_sku_group_len[i];
@@ -421,17 +410,9 @@ mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 		if (i >= SKU_VHT_BW20 && i <= SKU_VHT_BW160)
 			mcs_num = 10;
 
-		mt76_seq_puts_array(s, sku_group_name[i], buf, mcs_num);
+		mt76_seq_puts_array(file, sku_group_name[i], buf, mcs_num);
 		buf += mt7915_sku_group_len[i];
 	}
-}
-
-static int
-mt7915_rate_txpower_show(struct seq_file *file, void *data)
-{
-	struct mt7915_phy *phy = file->private;
-
-	mt7915_puts_rate_txpower(file, phy);
 
 	return 0;
 }
-- 
2.31.1

