Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91B10AAF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEAQH7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAQH6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:07:58 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAEC5208C3;
        Wed,  1 May 2019 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726877;
        bh=y6zwq5TmNpkmP0Fjp1KhxhPVexi9KgxZXbLVfd6RL1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vhNRIud6wifd+uGh9Ogyx0EGt7onzkwI4NSXnb0up0T9MD/1yRbe68OppB7G8WW6
         C/CUjeACE8oltnpXmheOU1uql7eKSfvbbCdxP1sHc+2Kv6PR1THWUtRS5McUKGmo1+
         n+KIeEPYI8R5bSu1iolgOk28m9oG+LFwSuCAhVhY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 04/17] mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
Date:   Wed,  1 May 2019 18:07:26 +0200
Message-Id: <a5cc7b351c26d6f4f00fc66b580c188e2f339e65.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper mcu message size in mt7615_mcu_add_wtbl_bmc and do not
allocate a huge buffer. Moreover use stack memory instead of heap one

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 54 +++++++++----------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c79df00a6da6..8c76274fd79b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -987,39 +987,33 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 				     &wtbl_sec_key, buf_len);
 }
 
-int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
+int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct wtbl_generic *wtbl_generic;
-	struct wtbl_rx *wtbl_rx;
-	int buf_len, ret;
-	u8 *buf;
-
-	buf = kzalloc(MT7615_WTBL_UPDATE_MAX_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	wtbl_generic = (struct wtbl_generic *)buf;
-	buf_len = sizeof(*wtbl_generic);
-	wtbl_generic->tag = cpu_to_le16(WTBL_GENERIC);
-	wtbl_generic->len = cpu_to_le16(buf_len);
-	eth_broadcast_addr(wtbl_generic->peer_addr);
-	wtbl_generic->muar_idx = 0xe;
-
-	wtbl_rx = (struct wtbl_rx *)(buf + buf_len);
-	buf_len += sizeof(*wtbl_rx);
-	wtbl_rx->tag = cpu_to_le16(WTBL_RX);
-	wtbl_rx->len = cpu_to_le16(sizeof(*wtbl_rx));
-	wtbl_rx->rca1 = 1;
-	wtbl_rx->rca2 = 1;
-	wtbl_rx->rv = 1;
-
-	ret = __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
-				    WTBL_RESET_AND_SET, 2, buf,
-				    buf_len);
+	struct {
+		struct wtbl_generic g_wtbl;
+		struct wtbl_rx rx_wtbl;
+	} data = {
+		.g_wtbl = {
+			.tag = cpu_to_le16(WTBL_GENERIC),
+			.len = cpu_to_le16(sizeof(struct wtbl_generic)),
+			.muar_idx = 0xe,
+		},
+		.rx_wtbl = {
+			.tag = cpu_to_le16(WTBL_RX),
+			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
+			.rca1 = 1,
+			.rca2 = 1,
+			.rv = 1,
+		},
+	};
+	eth_broadcast_addr(data.g_wtbl.peer_addr);
 
-	kfree(buf);
-	return ret;
+	return __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
+				     WTBL_RESET_AND_SET, 2, &data,
+				     sizeof(struct wtbl_generic) +
+				     sizeof(struct wtbl_rx));
 }
 
 int mt7615_mcu_del_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
-- 
2.20.1

