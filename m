Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3CEAB6B
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfJaIPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfJaIPX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:15:23 -0400
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B606F2083E;
        Thu, 31 Oct 2019 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572509722;
        bh=auvTv1rGUf5XvxRMXCb9dPpK8dVzR/GrprLrCiEyDXU=;
        h=From:To:Cc:Subject:Date:From;
        b=2OnmamyBeT9XK0Q/3tRpGKa6rU7YhV9HPPwspUbxaqMnCiIhpXQnXWVtuI0dgEK3U
         txi7qke9x/8i5rSN2iA0nA4dpEB/UfHcQRhpr7h3iWiUI4azIRPL/ZChaF817m27bG
         FPk+o70pnvar6wted3QJKdzXZGexJx5j7KHtgl6I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com
Subject: [PATCH] mt76: move SUPPORTS_REORDERING_BUFFER hw property in mt76_register_device
Date:   Thu, 31 Oct 2019 09:15:09 +0100
Message-Id: <65fc93b488e77916f1fa60e940475d8be2044675.1572509560.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move SUPPORTS_REORDERING_BUFFER hw property configuration from chip
specific code to mt76_register_device since it is supported by all mt76
drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 1 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/init.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6535921fcea4..17d04ebff996 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -337,6 +337,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
 	ieee80211_hw_set(hw, NEEDS_UNIQUE_STA_ADDR);
+	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 3a2927a524c3..50c6a2828c18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -556,7 +556,6 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	wiphy->iface_combinations = if_comb;
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 
-	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
 	/* init led callbacks */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 4f56b4a4a015..888ca8bbdef0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -294,7 +294,6 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
-	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 
 	dev->mt76.sband_2g.sband.ht_cap.cap |= IEEE80211_HT_CAP_LDPC_CODING;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index c57a93fa2557..2ce852caf247 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -190,7 +190,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	hw->vif_data_size = sizeof(struct mt76x02_vif);
 
 	ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
-	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
 
 	dev->mt76.global_wcid.idx = 255;
 	dev->mt76.global_wcid.hw_key_idx = -1;
-- 
2.21.0

