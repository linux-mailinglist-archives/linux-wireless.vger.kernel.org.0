Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B54336F2B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Mar 2021 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhCKJrB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 04:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhCKJqf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 04:46:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FF2964F95;
        Thu, 11 Mar 2021 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615455994;
        bh=B6Qmk5XRUx655qfYh8rFCeL68eoar0l6w3+GP67aOr8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZU6NNwzMssu/dq62MhYTs52BFiuVNYmAkKp547syHAUtpGWz/+Q/7pQ7u8lXGKZiO
         zsnZCC4GYK0/2H3afJLlsayveClzg4wWdINbqRinGUI4qTlGIxQ2XhZo4aDf1JYo1f
         Cc7L9QYRlszLqeHsi0kBfG5GS+jeMnL3h7zm/dTbduyRzebEgqvyIQW3IK98EvcgEC
         B6wQRBwfSuN2pvFn43RO+sdgS81rmH+zdb3C/KDRKSsuzl7G9bWOPi9LMhavXz+igU
         uY1VDl3YIB2PNU22yfc6JYakMP8ZTDYSdA2/zxMETJxWlq0wZb8YbRXFP8ZY/9BQAS
         OWDAvv8mJL3AQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: remove leftovers from dbdc configuration
Date:   Thu, 11 Mar 2021 10:46:21 +0100
Message-Id: <33202fa1d77066f8c75997f33db79ee2eecc3eec.1615455907.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove leftovers from dbdc configuration since mt7921
does not support it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7cd13b1ecc0a..1cf1b04304aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -465,7 +465,6 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	bool band = phy != &dev->phy;
 	int ret;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
@@ -486,9 +485,9 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		else
 			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
-		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+		mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
-		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+		mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
 	}
 
 	mt7921_mutex_release(dev);
@@ -517,7 +516,6 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	bool band = phy != &dev->phy;
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -557,12 +555,12 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_NDPA);
 
 	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+	mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
 
 	if (*total_flags & FIF_CONTROL)
-		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
+		mt76_clear(dev, MT_WF_RFCR1(0), ctl_flags);
 	else
-		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
+		mt76_set(dev, MT_WF_RFCR1(0), ctl_flags);
 
 	mt7921_mutex_release(dev);
 }
@@ -876,9 +874,7 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
-	bool band = phy != &dev->phy;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -889,9 +885,9 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
 	/* TSF software read */
-	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE);
-	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
-	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_MODE);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(0));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(0));
 
 	mt7921_mutex_release(dev);
 
@@ -904,9 +900,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	u8 omac_idx = mvif->mt76.omac_idx;
-	bool band = phy != &dev->phy;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -916,10 +910,10 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7921_mutex_acquire(dev);
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
-	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
-	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
+	mt76_wr(dev, MT_LPON_UTTR0(0), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(0), tsf.t32[1]);
 	/* TSF software overwrite */
-	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_WRITE);
 
 	mt7921_mutex_release(dev);
 }
-- 
2.29.2

