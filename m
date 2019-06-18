Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99049DE9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfFRKCT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 06:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfFRKCT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 06:02:19 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F195D206BA;
        Tue, 18 Jun 2019 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560852138;
        bh=FPyTcelLm0uegh8To+m6f7YmXqxje0dKC/ZmKDMla1M=;
        h=From:To:Cc:Subject:Date:From;
        b=ga3jLJBqSV5jxVcjlWt1vHUvnRzPilORcjzewYrwovn1yLEcpEc5fAo6oJP3dihCI
         GTfoyJWKvzsB6nyDUXSEh2wpo2bPnZKOWTd+4d9UhlHEkYGzgRnQo/5KszbSzQXl8j
         yN0M4dixRWiV07rhS6fnUpD7wJgPUiVbcsbO71KU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix sparse warnings: warning: dubious: x & !y
Date:   Tue, 18 Jun 2019 12:02:10 +0200
Message-Id: <d8a003eda05150fb21842d7755fe8081b86cf6df.1560851052.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix following sparse warnings in mt7603/mac.c and mt76x02_mac.c

drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:113:17: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:145:16: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:730:9: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:790:15: warning: dubious: x & !y

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index ab5141701997..62e0a7f4716a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -709,6 +709,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
 {
 	enum mt7603_cipher_type cipher;
 	u32 addr = mt7603_wtbl3_addr(wcid);
+	bool key_set = !!key;
 	u8 key_data[32];
 	int key_len = sizeof(key_data);
 
@@ -727,7 +728,7 @@ int mt7603_wtbl_set_key(struct mt7603_dev *dev, int wcid,
 	mt76_rmw_field(dev, addr + 2 * 4, MT_WTBL1_W2_KEY_TYPE, cipher);
 	if (key)
 		mt76_rmw_field(dev, addr, MT_WTBL1_W0_KEY_IDX, key->keyidx);
-	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, !!key);
+	mt76_rmw_field(dev, addr, MT_WTBL1_W0_RX_KEY_VALID, key_set);
 
 	return 0;
 }
@@ -745,6 +746,7 @@ mt7603_mac_write_txwi(struct mt7603_dev *dev, __le32 *txwi,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_queue *q = dev->mt76.q_tx[qid].q;
 	struct mt7603_vif *mvif;
+	bool key_set = !!key;
 	int wlan_idx;
 	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
 	int tx_count = 8;
@@ -787,7 +789,7 @@ mt7603_mac_write_txwi(struct mt7603_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
 	      FIELD_PREP(MT_TXD1_HDR_INFO, hdr_len / 2) |
 	      FIELD_PREP(MT_TXD1_WLAN_IDX, wlan_idx) |
-	      FIELD_PREP(MT_TXD1_PROTECTED, !!key);
+	      FIELD_PREP(MT_TXD1_PROTECTED, key_set);
 	txwi[1] = cpu_to_le32(val);
 
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 97621dbfd114..b3a35911deb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -110,8 +110,10 @@ int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 
 	memset(iv_data, 0, sizeof(iv_data));
 	if (key) {
+		bool pw_key = !!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE);
+
 		mt76_rmw_field(dev, MT_WCID_ATTR(idx), MT_WCID_ATTR_PAIRWISE,
-			       !!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE));
+			       pw_key);
 
 		pn = atomic64_read(&key->tx_pn);
 
@@ -139,10 +141,11 @@ void mt76x02_mac_wcid_setup(struct mt76x02_dev *dev, u8 idx,
 			    u8 vif_idx, u8 *mac)
 {
 	struct mt76_wcid_addr addr = {};
+	bool ext_id = !!(vif_idx & 8);
 	u32 attr;
 
 	attr = FIELD_PREP(MT_WCID_ATTR_BSS_IDX, vif_idx & 7) |
-	       FIELD_PREP(MT_WCID_ATTR_BSS_IDX_EXT, !!(vif_idx & 8));
+	       FIELD_PREP(MT_WCID_ATTR_BSS_IDX_EXT, ext_id);
 
 	mt76_wr(dev, MT_WCID_ATTR(idx), attr);
 
-- 
2.21.0

