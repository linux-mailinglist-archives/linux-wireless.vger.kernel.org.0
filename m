Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7793710AB1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfEAQID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfEAQIC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:02 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAD472089E;
        Wed,  1 May 2019 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726881;
        bh=cDaCli9GIN+/QnR8bChGLchuMdOhKUHrtTemwDfd9xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpxN8Lljy+hmN7QR825D7J2haaSuY3CMbkHuZG0F1ZrnLlgstmgqAOyKO37dmDSNW
         SLen3W92ELtoHdC+sZDkBS4kDONFbMSXnuAtQCWQFlmGX369VFbrj8ei364CZNhomj
         7erenqYrWlbyYgLRo60iiD8/UlufM+27f/mwFyLc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 06/17] mt7615: mcu: unify mt7615_mcu_add_wtbl_bmc and mt7615_mcu_del_wtbl_bmc
Date:   Wed,  1 May 2019 18:07:28 +0200
Message-Id: <527b84e666748e1615e51370079fbb17222c126a.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicated code in mt7615_bss_info_changed

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  | 15 ++++-----------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   | 12 ++++++++----
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h    |  4 ++--
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 80e6b211f60b..c45ab9980b69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -290,17 +290,10 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		if (info->enable_beacon) {
-			mt7615_mcu_set_bss_info(dev, vif, 1);
-			mt7615_mcu_add_wtbl_bmc(dev, vif);
-			mt7615_mcu_set_sta_rec_bmc(dev, vif, 1);
-			mt7615_mcu_set_bcn(dev, vif, 1);
-		} else {
-			mt7615_mcu_set_sta_rec_bmc(dev, vif, 0);
-			mt7615_mcu_del_wtbl_bmc(dev, vif);
-			mt7615_mcu_set_bss_info(dev, vif, 0);
-			mt7615_mcu_set_bcn(dev, vif, 0);
-		}
+		mt7615_mcu_set_bss_info(dev, vif, info->enable_beacon);
+		mt7615_mcu_wtbl_bmc(dev, vif, info->enable_beacon);
+		mt7615_mcu_set_sta_rec_bmc(dev, vif, info->enable_beacon);
+		mt7615_mcu_set_bcn(dev, vif, info->enable_beacon);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 1d7c8cf56040..a6a00bad0f11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -987,10 +987,10 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 				     &wtbl_sec_key, buf_len);
 }
 
-int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif)
+static int
+mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
+			struct mt7615_vif *mvif)
 {
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct {
 		struct wtbl_generic g_wtbl;
 		struct wtbl_rx rx_wtbl;
@@ -1016,10 +1016,14 @@ int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev,
 				     sizeof(struct wtbl_rx));
 }
 
-int mt7615_mcu_del_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif)
+int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev,
+			struct ieee80211_vif *vif, bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 
+	if (enable)
+		return mt7615_mcu_add_wtbl_bmc(dev, mvif);
+
 	return __mt7615_mcu_set_wtbl(dev, mvif->sta.wcid.idx,
 				     WTBL_RESET_AND_SET, 0, NULL, 0);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 895c2904d7eb..2331f0a9bc65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -118,8 +118,8 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 void mt7615_mcu_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
-int mt7615_mcu_add_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif);
-int mt7615_mcu_del_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif);
+int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			bool enable);
 int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
 int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-- 
2.20.1

