Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5A5AA32
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfF2KgY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 06:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2KgY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:24 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA9B214DA;
        Sat, 29 Jun 2019 10:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561804583;
        bh=U2NALAF+QCwFWpq2czCf3H4p6PrhWYxVkitxZNHdy4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFIAqynjQ/ue2hqjcl5jGRKB5ND+Gpfi9CaBhCFbjVLFcCBzq57ictY6+w3uTPJTP
         KEfOeiJnOQLznLIomq4HIjS6QDdfHDjqwRJOLQixvkFVSfJK8vDzyQNNafzzwKh4WG
         PTJDMxnvVcGJJxZuQETKAKlX331xrrrbICwcfKlA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [PATCH 1/6] mt76: mt7615: introduce mt7615_regd_notifier
Date:   Sat, 29 Jun 2019 12:36:06 +0200
Message-Id: <9373440a3e8767df6ce1803306fa9be5017064b3.1561804422.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561804422.git.lorenzo@kernel.org>
References: <cover.1561804422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_regd_notifier callback. This is a preliminary patch to
add radar detection support to mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 859de2454ec6..edce96ce79a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -208,6 +208,16 @@ mt7615_init_txpower(struct mt7615_dev *dev,
 	}
 }
 
+static void
+mt7615_regd_notifier(struct wiphy *wiphy,
+		     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct mt7615_dev *dev = hw->priv;
+
+	dev->mt76.region = request->dfs_region;
+}
+
 int mt7615_register_device(struct mt7615_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
@@ -230,6 +240,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
+	wiphy->reg_notifier = mt7615_regd_notifier;
 
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
-- 
2.21.0

