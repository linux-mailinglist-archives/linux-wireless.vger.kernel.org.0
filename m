Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6302D8895
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392633AbgLLRZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Dec 2020 12:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLLRZa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Dec 2020 12:25:30 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: run mt7915_configure_filter holding mt76 mutex
Date:   Sat, 12 Dec 2020 18:24:31 +0100
Message-Id: <5321dd20920d2c912d3bfe1c44ec7cb4d5bde1de.1607793699.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid races, run mt7915_configure_filter routine holding
mt76 mutex

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0c82aa2ef219..ce348c5ccc6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -427,7 +427,6 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool band = phy != &dev->phy;
-
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -441,6 +440,8 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
+	mutex_lock(&dev->mt76.mutex);
+
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
 			   MT_WF_RFCR_DROP_OTHER_BEACON |
 			   MT_WF_RFCR_DROP_FRAME_REPORT |
@@ -471,6 +472,8 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
 	else
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+
+	mutex_unlock(&dev->mt76.mutex);
 }
 
 static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
-- 
2.29.2

