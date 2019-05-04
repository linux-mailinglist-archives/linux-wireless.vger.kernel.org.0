Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7813AEC
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDP3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfEDP3d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:33 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B262086C;
        Sat,  4 May 2019 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983773;
        bh=JB0z18H3isabjXCN9JxyL2Q4H27UcuAzHjS1FsKtk+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO/IJ/hvxmByZ16mjc/TID9Redhrs8ByG8wlENCme4eVcP/a6hUf/hqL6TQmrDCCG
         kHDrBLknH+7fwcQt31zxGyxVjl+2wZ4MzC3z2NY+5gLC1BpwTk/g7lPP56AaDLt3Ng
         TT81C+9YTBS/eVSBiGX+r49Pwthl6ITXCsoQY0vo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 04/17] mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
Date:   Sat,  4 May 2019 17:28:56 +0200
Message-Id: <46b837f2da648d3b2a578bb00756c0fcb82cf048.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
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
index 2a73ac8b0d90..ab72e34f5d0c 100644
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

