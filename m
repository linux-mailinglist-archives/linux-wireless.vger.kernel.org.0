Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4B13AED
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEDP3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfEDP3f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:35 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9C020862;
        Sat,  4 May 2019 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983774;
        bh=ovvIs8KIC5tqeu4vZAzQwXYmBLq3CuehM+sN8I8Tkxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lo/kq1ExlQ8A6siyjtlLNKq9I5nIUQkXoyNe3+3qb+O0FzfHSekDoj+R8tcf57xx8
         KtkZOw0GJD6UV8cbyLHOSKPXgx5kBp9SNL0xjw9kMytbeSLcAVH/KbVg28ra+RGP3W
         7VNTvAknQKh2eeXM9WPYhKxDMfJciRM/GYytckZs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 05/17] mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl
Date:   Sat,  4 May 2019 17:28:57 +0200
Message-Id: <516a205b27e1dee97295b1eee196ac14f10ac404.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper mcu message size in mt7615_mcu_add_wtbl and do not
allocate a huge buffer. Moreover use stack memory instead of heap one

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 54 +++++++++----------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ab72e34f5d0c..2bda4830dbaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1029,37 +1029,31 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
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
-	memcpy(wtbl_generic->peer_addr, sta->addr, ETH_ALEN);
-	wtbl_generic->muar_idx = mvif->omac_idx;
-	wtbl_generic->qos = sta->wme;
-	wtbl_generic->partial_aid = cpu_to_le16(sta->aid);
-
-	wtbl_rx = (struct wtbl_rx *)(buf + buf_len);
-	buf_len += sizeof(*wtbl_rx);
-	wtbl_rx->tag = cpu_to_le16(WTBL_RX);
-	wtbl_rx->len = cpu_to_le16(sizeof(*wtbl_rx));
-	wtbl_rx->rca1 = (vif->type == NL80211_IFTYPE_AP) ? 0 : 1;
-	wtbl_rx->rca2 = 1;
-	wtbl_rx->rv = 1;
-
-	ret = __mt7615_mcu_set_wtbl(dev, msta->wcid.idx, WTBL_RESET_AND_SET,
-				    2, buf, buf_len);
+	struct {
+		struct wtbl_generic g_wtbl;
+		struct wtbl_rx rx_wtbl;
+	} data = {
+		.g_wtbl = {
+			.tag = cpu_to_le16(WTBL_GENERIC),
+			.len = cpu_to_le16(sizeof(struct wtbl_generic)),
+			.muar_idx = mvif->omac_idx,
+			.qos = sta->wme,
+			.partial_aid = cpu_to_le16(sta->aid),
+		},
+		.rx_wtbl = {
+			.tag = cpu_to_le16(WTBL_RX),
+			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
+			.rca1 = vif->type != NL80211_IFTYPE_AP,
+			.rca2 = 1,
+			.rv = 1,
+		},
+	};
+	memcpy(data.g_wtbl.peer_addr, sta->addr, ETH_ALEN);
 
-	kfree(buf);
-	return ret;
+	return __mt7615_mcu_set_wtbl(dev, msta->wcid.idx,
+				     WTBL_RESET_AND_SET, 2, &data,
+				     sizeof(struct wtbl_generic) +
+				     sizeof(struct wtbl_rx));
 }
 
 int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.20.1

