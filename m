Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE35110AB2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEAQIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfEAQID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:08:03 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7240721734;
        Wed,  1 May 2019 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726882;
        bh=SHHvAsYQ0fONaPTK0ySLlGNviq+WyE43LNOJwVw5vWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4imgJqkfi4kyymX6sIDAYC5sqaV92mEsqN/zNc3OqsKRU5/yJ5Hbh3ym4jY6Moax
         3Xq0HYJrK1qM6B770D2sdBtRrysDPYIHtK0l4ZhRtCwPpfjOXV9OE4GnqoEtcXDGbv
         Wjyj4SuNfHfvf3zrqsMMzOJqXLTkRMGqkBb1ll3A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 07/17] mt7615: mcu: remove unused paramter in mt7615_mcu_del_wtbl
Date:   Wed,  1 May 2019 18:07:29 +0200
Message-Id: <5022c02e913ba014f6b16a97f97f258e4078842b.1556726268.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556726268.git.lorenzo@kernel.org>
References: <cover.1556726268.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused vif paramter in mt7615_mcu_del_wtbl signature

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c45ab9980b69..d6b350a248f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -336,7 +336,7 @@ void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
 	mt7615_mcu_set_sta_rec(dev, vif, sta, 0);
-	mt7615_mcu_del_wtbl(dev, vif, sta);
+	mt7615_mcu_del_wtbl(dev, sta);
 }
 
 static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a6a00bad0f11..e71a79c11812 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1060,7 +1060,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				     sizeof(struct wtbl_rx));
 }
 
-int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+int mt7615_mcu_del_wtbl(struct mt7615_dev *dev,
 			struct ieee80211_sta *sta)
 {
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 2331f0a9bc65..81501cb64f1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -122,8 +122,7 @@ int mt7615_mcu_wtbl_bmc(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			bool enable);
 int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
-int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta);
+int mt7615_mcu_del_wtbl(struct mt7615_dev *dev, struct ieee80211_sta *sta);
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
 int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 			       struct ieee80211_vif *vif, bool en);
-- 
2.20.1

