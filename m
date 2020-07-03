Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56AE213618
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGCIQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgGCIQj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:39 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75808207DA;
        Fri,  3 Jul 2020 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764198;
        bh=Fm9tOeu5GWojK5JnL0gGHEVoqiwCaWtUgZ5slvkwdxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1lxRLZclXhD1E+SbYgUD74L/+A8bIU3B8vItqwE0vSUVbrsI+HOYN2boaB2gvLY8
         c877Um1jQlcUFi/d99AB8ududUW7SNcP2QiCKamjfKXwfaL0RZ5ay235qmeD2IEQPs
         8F83/Kvx+VMPtZ+u5ZoFxFbKQ1aXt37rfMT9X92U=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 10/22] mt76: mt7615: wake device before performing freq scan
Date:   Fri,  3 Jul 2020 10:15:49 +0200
Message-Id: <5a2efad230b8fe371fa03a1c07ea948bb3475b6d.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set device in full power before performing hw scan or hw scheduled scan

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d1ddd5b15955..eb56cd7cb429 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -915,17 +915,26 @@ static int
 mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_scan_request *req)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
+	int err;
 
-	return mt7615_mcu_hw_scan(mphy->priv, vif, req);
+	mt7615_mutex_acquire(dev);
+	err = mt7615_mcu_hw_scan(mphy->priv, vif, req);
+	mt7615_mutex_release(dev);
+
+	return err;
 }
 
 static void
 mt7615_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 
+	mt7615_mutex_acquire(dev);
 	mt7615_mcu_cancel_hw_scan(mphy->priv, vif);
+	mt7615_mutex_release(dev);
 }
 
 static int
@@ -933,22 +942,35 @@ mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct cfg80211_sched_scan_request *req,
 			struct ieee80211_scan_ies *ies)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
+	mt7615_mutex_acquire(dev);
+
 	err = mt7615_mcu_sched_scan_req(mphy->priv, vif, req);
 	if (err < 0)
-		return err;
+		goto out;
 
-	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, true);
+	err = mt7615_mcu_sched_scan_enable(mphy->priv, vif, true);
+out:
+	mt7615_mutex_release(dev);
+
+	return err;
 }
 
 static int
 mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
+	int err;
+
+	mt7615_mutex_acquire(dev);
+	err = mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
+	mt7615_mutex_release(dev);
 
-	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
+	return err;
 }
 
 static int mt7615_remain_on_channel(struct ieee80211_hw *hw,
@@ -1074,7 +1096,11 @@ static void mt7615_set_rekey_data(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct cfg80211_gtk_rekey_data *data)
 {
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+
+	mt7615_mutex_acquire(dev);
 	mt7615_mcu_update_gtk_rekey(hw, vif, data);
+	mt7615_mutex_release(dev);
 }
 #endif /* CONFIG_PM */
 
-- 
2.26.2

