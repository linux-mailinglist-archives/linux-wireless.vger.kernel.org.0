Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193BB67AD2
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfGMPJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPJV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:09:21 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D69C20838;
        Sat, 13 Jul 2019 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030560;
        bh=fd4IavovR/bNyKUIlTxowqh3rbDHp5AfLZO7lc+/SWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyeMMefm+Tq8HvIFWI/zewCw5bv7OughikbPna4HAlgpo+1bcwR6WgCQda2jW+745
         RWzHzww+oe2yv1PSkkom+pPyYSucUwyqK9Smr5r8K30v+ipfPDRmK5iAEWKi/RhcGs
         6NSkkyvLQGnc8THHKpw4Hx52No6z//YrEfZbFddU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] mt76: mt7615: add mt7615_mac_wtbl_addr routine
Date:   Sat, 13 Jul 2019 17:09:02 +0200
Message-Id: <8ebcb9d6fe715a9a7683cd25250325c5a3d2ddb2.1563029769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563029769.git.lorenzo@kernel.org>
References: <cover.1563029769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mac_wtbl_addr rouinte to compute sta wtbl address.
This is a preliminary patch to update wtbl key directly from host
processor

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 53937573662f..fb28f68486fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -449,13 +449,18 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
 
+static u32 mt7615_mac_wtbl_addr(int wcid)
+{
+	return MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
+}
+
 void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
 {
 	struct ieee80211_tx_rate *ref;
 	int wcid = sta->wcid.idx;
-	u32 addr = MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
+	u32 addr = mt7615_mac_wtbl_addr(wcid);
 	bool stbc = false;
 	int n_rates = sta->n_rates;
 	u8 bw, bw_prev, bw_idx = 0;
-- 
2.21.0

