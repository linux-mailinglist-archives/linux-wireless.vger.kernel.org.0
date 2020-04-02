Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D695A19C1A6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbgDBNHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbgDBNHc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:32 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0191920678;
        Thu,  2 Apr 2020 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832851;
        bh=y1u6ArJqsP+G1ZrMNbmTXLz6p9X+BwNgaQp7JxSuvQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6cmvjikjnErvPjuFS85RWYCx7p8gZZCTdsnVlcC7OqSQDxGlbkwshDYG2KRUk317
         rXk5/P2SBUHTsAmN9+AEwFHh5yoKzG2np3jEEqajLT9MYjtG0T59JsfhnNp2b+8OSP
         JwzTaQnhbxFFuZ8Amo9kqMAVRD10g/heo/KmlIbY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/12] mt76: mt7663: fix mt7615_mac_cca_stats_reset routine
Date:   Thu,  2 Apr 2020 15:06:31 +0200
Message-Id: <212be6740634f8dbc859a90a754c97bc24e72d27.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix PHYMUX_5 register definition for mt7663 in
mt7615_mac_cca_stats_reset routine

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index a27a6d164009..656231786d55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1574,8 +1574,14 @@ void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
-	u32 reg = MT_WF_PHY_R0_PHYMUX_5(ext_phy);
+	u32 reg;
 
+	if (is_mt7663(&dev->mt76))
+		reg = MT7663_WF_PHY_R0_PHYMUX_5;
+	else
+		reg = MT_WF_PHY_R0_PHYMUX_5(ext_phy);
+
+	/* reset PD and MDRDY counters */
 	mt76_clear(dev, reg, GENMASK(22, 20));
 	mt76_set(dev, reg, BIT(22) | BIT(20));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 1e0d95b917e1..f7c2a633841c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -151,6 +151,7 @@ enum mt7615_reg_base {
 #define MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN	BIT(9)
 
 #define MT_WF_PHY_R0_PHYMUX_5(_phy)	MT_WF_PHY(0x0614 + ((_phy) << 9))
+#define MT7663_WF_PHY_R0_PHYMUX_5	MT_WF_PHY(0x0414)
 
 #define MT_WF_PHY_R0_PHYCTRL_STS0(_phy)	MT_WF_PHY(0x020c + ((_phy) << 9))
 #define MT_WF_PHYCTRL_STAT_PD_OFDM	GENMASK(31, 16)
-- 
2.25.1

