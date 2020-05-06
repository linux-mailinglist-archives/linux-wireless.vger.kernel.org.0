Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0831C6DAF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgEFJyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgEFJyU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:54:20 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4166820753;
        Wed,  6 May 2020 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588758860;
        bh=cMT+LnOQZwADrMUesZWSporgJBGKOdjgwOZSRIZB66Q=;
        h=From:To:Cc:Subject:Date:From;
        b=OiTXLs4jEP0QfulH+VOZAnUAcZiJ8LiowsvT1frEnkIsyWOsLlI+f0okYgLWbnoig
         jnFo8t4b46i0BSaJJ7iN2VA2AxJqSVxPKGOLAP7zcaTGprtwwbzA8BRh0Cc8ueBInV
         jwEw5jRxTfIw4FJ3o9uWFEcWrubP/Fz2YGjaNe8Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663: introduce WoW with net detect support
Date:   Wed,  6 May 2020 11:53:35 +0200
Message-Id: <48bfe7a59ecf6cdb5f37f1eec268836a803373ad.1588758700.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce WoW with net detect support

Co-developed-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Signed-off-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8ada03afe7d0..89fadff44fa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1882,10 +1882,11 @@ mt7615_mcu_send_ram_firmware(struct mt7615_dev *dev,
 
 static const struct wiphy_wowlan_support mt7615_wowlan_support = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
-		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY,
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY | WIPHY_WOWLAN_NET_DETECT,
 	.n_patterns = 1,
 	.pattern_min_len = 1,
 	.pattern_max_len = MT7615_WOW_PATTEN_MAX_LEN,
+	.max_nd_match_sets = 10,
 };
 
 static int mt7615_load_n9(struct mt7615_dev *dev, const char *name)
@@ -3316,10 +3317,11 @@ mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 }
 
 static int
-mt7615_mcu_set_wow_ctrl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			bool suspend, struct cfg80211_wowlan *wowlan)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt7615_dev *dev = phy->dev;
 	struct {
 		struct {
 			u8 bss_idx;
@@ -3341,6 +3343,11 @@ mt7615_mcu_set_wow_ctrl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		req.wow_ctrl_tlv.trigger |= BIT(0);
 	if (wowlan->disconnect)
 		req.wow_ctrl_tlv.trigger |= BIT(2);
+	if (wowlan->nd_config) {
+		mt7615_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		req.wow_ctrl_tlv.trigger |= BIT(5);
+	}
+	mt7615_mcu_sched_scan_enable(phy, vif, suspend);
 
 	if (mt76_is_mmio(&dev->mt76))
 		req.wow_ctrl_tlv.wakeup_hif = 2;
@@ -3461,7 +3468,7 @@ void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
 	for (i = 0; i < wowlan->n_patterns; i++)
 		mt7615_mcu_set_wow_pattern(phy->dev, vif, i, suspend,
 					   &wowlan->patterns[i]);
-	mt7615_mcu_set_wow_ctrl(phy->dev, vif, suspend, wowlan);
+	mt7615_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
 }
 
 static void
-- 
2.26.2

