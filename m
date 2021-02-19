Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B531FDE1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSR34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSR3z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9683464E86;
        Fri, 19 Feb 2021 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755754;
        bh=swS/4qpAZ/hqSBinA9OmnMx6x7pB/o8RtEGCAqAU9A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P67zZe1apfaDBwBrMjQkmxDIeT2yYTGPc4trZOtEmT2LZoYOZulrqHVaW5InwZ+Ld
         rPszdE2PVVYayAcfgU3WrBkErUEZna9/pWVNqGsCwVGr7j4wV9qmUWG5JBI0J51bbB
         ky1MjzBwQiGJHLVspUrdq9jB38pCb6vEJL+TfsHSlmcgHwOfd5Kiq+tl3uu2T1UwVL
         2CfsbdgV5T05brO5Pq+3XGs7bP1KCfH8EUvSxtl3smIBbKqyt/aWG3L1+MIi9S2ua2
         d1f3i6SLQH88U8ORlJ7PECK/C1LIgYtULiFElQBaV95UK/BCvQnkKnUFQB8AujJd++
         /eLrmq80AcJcw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 3/8] mt76: mt7921: switch to new api for hardware beacon filter
Date:   Fri, 19 Feb 2021 18:28:46 +0100
Message-Id: <22be936230c356e9b57f541aaa40d6552783e92d.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613755428.git.lorenzo@kernel.org>
References: <cover.1613755428.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Current firmware only supports new api for enabling hardware beacon filter.

Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
Beacon filter cmd have to rely on the associatied access point's beacon
interval and DTIM information.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 49 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  8 ++-
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 729f6c42cdde..11d85cf9cfb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -295,15 +295,6 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	if (dev->pm.enable) {
-		ret = mt7921_mcu_set_bss_pm(dev, vif, true);
-		if (ret)
-			goto out;
-
-		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
-		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
-
 	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
@@ -349,13 +340,6 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 		phy->monitor_vif = NULL;
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
-
-	if (dev->pm.enable) {
-		mt7921_mcu_set_bss_pm(dev, vif, false);
-		mt76_clear(dev, MT_WF_RFCR(0),
-			   MT_WF_RFCR_DROP_OTHER_BEACON);
-	}
-
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
@@ -561,6 +545,36 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 	mt7921_mutex_release(dev);
 }
 
+static int
+mt7921_bss_bcnft_apply(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       bool assoc)
+{
+	int ret;
+
+	if (!dev->pm.enable)
+		return 0;
+
+	if (assoc) {
+		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
+		if (ret)
+			return ret;
+
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+		return 0;
+	}
+
+	ret = mt7921_mcu_set_bss_pm(dev, vif, false);
+	if (ret)
+		return ret;
+
+	vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+	mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+
+	return 0;
+}
+
 static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -587,6 +601,9 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
+	if (changed & BSS_CHANGED_ASSOC)
+		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
+
 	mt7921_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index db125cd22b91..d784c75d47bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1294,8 +1294,14 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct mt7921_phy *phy = priv;
 	struct mt7921_dev *dev = phy->dev;
+	int ret;
+
+	if (dev->pm.enable)
+		ret = mt7921_mcu_uni_bss_bcnft(dev, vif, true);
+	else
+		ret = mt7921_mcu_set_bss_pm(dev, vif, false);
 
-	if (mt7921_mcu_set_bss_pm(dev, vif, dev->pm.enable))
+	if (ret)
 		return;
 
 	if (dev->pm.enable) {
-- 
2.29.2

