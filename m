Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1C19C1A7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbgDBNHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732262AbgDBNHh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:37 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E37206F5;
        Thu,  2 Apr 2020 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832856;
        bh=Bi6G1MBCsKgox0GNF9MhtgVmuYfRFKSdL7Jv3Cl+e0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzWsWUxnUs1AVF7Z7EyPsUd2rIyR/b1wZU1i+iy1eGMXCnRfKGGcYttSM6HSeclW2
         h9Mh5agUdYVgXn65xKRUJoiFMVSj0AssgtLtsn2KThPyRS8dhurywXpvzhe4OcP40G
         rxCp+kTioE/WLQ0FcgBDF7IoZKMUSWPYb+LqxCUo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 02/12] mt76: mt7663: enable nf estimation
Date:   Thu,  2 Apr 2020 15:06:32 +0200
Message-Id: <8a0475040d343dd94b0f6ffc8ec343b8df63985c.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable Noise floor estimation for mt7663 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 16 +++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 656231786d55..5961650e7245 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1556,10 +1556,12 @@ void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
 
 void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy)
 {
-	u32 rxtd;
+	u32 rxtd, reg;
 
 	if (is_mt7663(&dev->mt76))
-		return;
+		reg = MT7663_WF_PHY_R0_PHYMUX_5;
+	else
+		reg = MT_WF_PHY_R0_PHYMUX_5(ext_phy);
 
 	if (ext_phy)
 		rxtd = MT_WF_PHY_RXTD2(10);
@@ -1567,7 +1569,7 @@ void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy)
 		rxtd = MT_WF_PHY_RXTD(12);
 
 	mt76_set(dev, rxtd, BIT(18) | BIT(29));
-	mt76_set(dev, MT_WF_PHY_R0_PHYMUX_5(ext_phy), 0x5 << 12);
+	mt76_set(dev, reg, 0x5 << 12);
 }
 
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy)
@@ -1691,10 +1693,14 @@ static u8
 mt7615_phy_get_nf(struct mt7615_dev *dev, int idx)
 {
 	static const u8 nf_power[] = { 92, 89, 86, 83, 80, 75, 70, 65, 60, 55, 52 };
-	u32 reg = idx ? MT_WF_PHY_RXTD2(17) : MT_WF_PHY_RXTD(20);
-	u32 val, sum = 0, n = 0;
+	u32 reg, val, sum = 0, n = 0;
 	int i;
 
+	if (is_mt7663(&dev->mt76))
+		reg = MT7663_WF_PHY_RXTD(20);
+	else
+		reg = idx ? MT_WF_PHY_RXTD2(17) : MT_WF_PHY_RXTD(20);
+
 	for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
 		val = mt76_rr(dev, reg);
 		sum += val * nf_power[i];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index f7c2a633841c..b7e25b91733a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -170,6 +170,8 @@ enum mt7615_reg_base {
 #define MT_WF_PHY_RXTD_BASE		MT_WF_PHY(0x2200)
 #define MT_WF_PHY_RXTD(_n)		(MT_WF_PHY_RXTD_BASE + ((_n) << 2))
 
+#define MT7663_WF_PHY_RXTD(_n)		(MT_WF_PHY(0x25b0) + ((_n) << 2))
+
 #define MT_WF_PHY_RXTD_CCK_PD(_phy)	MT_WF_PHY((_phy) ? 0x2314 : 0x2310)
 #define MT_WF_PHY_PD_CCK_MASK(_phy)	(_phy) ? GENMASK(31, 24) : \
 					 GENMASK(8, 1)
-- 
2.25.1

