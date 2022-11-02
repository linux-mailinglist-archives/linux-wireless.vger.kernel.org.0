Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547066170AB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 23:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKBW3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBW3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 18:29:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2A6584
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 15:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F5561BC5
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 22:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D9CC433C1;
        Wed,  2 Nov 2022 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428169;
        bh=h7x7JNvtwU3kqFiLlHTf5XVyqgYU/LagZg1od2ZFB+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzmQhd8Gyp5i+HYBUjNKj02/qSW8gMV7je7TkCN6c9RIxEHKpxZpEGP8l9e+IeVMG
         sCMFmp8ItzqqJAgrzGjUuBlTzTBN+wyApNHX5yQyf/TwHh0YCYkCnrMRkup8MvPaGz
         fsBddNKxQrkCs+Tefn0hX80Q2mJ4svd9hWx5bguR7x+vsoHe8/6yfmN99pgrW6MIf4
         wmAlrV25VPAGqESVtk1rDAkWMBr5RgFLZNmWDcssfC7BXmQVn1pamE8jTtkIRgSyDT
         QZucRTLdCrgjyA+PaKUSRwH8KKGC+Ukg+g0pjsXJ0dG6HRfySc6fw+X+nnF6qme2QB
         YOe7zee07I3JA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 1/2] wifi: mt76: mt7615: rely on mt7615_phy in mt7615_mac_reset_counters
Date:   Wed,  2 Nov 2022 23:29:14 +0100
Message-Id: <18a4a52db5da53e73c10ac64ac6be89ab568e237.1667427944.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667427944.git.lorenzo@kernel.org>
References: <cover.1667427944.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to move aggr_stats array in mt76_phy
structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 8 +++-----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2ce1705c0f43..7bda801581ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -107,9 +107,9 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-void mt7615_mac_reset_counters(struct mt7615_dev *dev)
+void mt7615_mac_reset_counters(struct mt7615_phy *phy)
 {
-	struct mt76_phy *mphy_ext = dev->mt76.phys[MT_BAND1];
+	struct mt7615_dev *dev = phy->dev;
 	int i;
 
 	for (i = 0; i < 4; i++) {
@@ -118,9 +118,7 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 	}
 
 	memset(dev->mt76.aggr_stats, 0, sizeof(dev->mt76.aggr_stats));
-	dev->mt76.phy.survey_time = ktime_get_boottime();
-	if (mphy_ext)
-		mphy_ext->survey_time = ktime_get_boottime();
+	phy->mt76->survey_time = ktime_get_boottime();
 
 	/* reset airtime counters */
 	mt76_rr(dev, MT_MIB_SDR9(0));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8d4733f87cda..24865a6f679c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -83,7 +83,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work, timeout);
 
 	if (!running)
-		mt7615_mac_reset_counters(dev);
+		mt7615_mac_reset_counters(phy);
 
 out:
 	mt7615_mutex_release(dev);
@@ -320,7 +320,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	if (ret)
 		goto out;
 
-	mt7615_mac_reset_counters(dev);
+	mt7615_mac_reset_counters(phy);
 	phy->noise = 0;
 	phy->chfreq = mt76_rr(dev, MT_CHFREQ(ext_phy));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 060d52c81d9e..98f19476f385 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -469,7 +469,7 @@ void mt7615_init_work(struct mt7615_dev *dev);
 int mt7615_mcu_restart(struct mt76_dev *dev);
 void mt7615_update_channel(struct mt76_phy *mphy);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
-void mt7615_mac_reset_counters(struct mt7615_dev *dev);
+void mt7615_mac_reset_counters(struct mt7615_phy *phy);
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
 void mt7615_mac_set_scs(struct mt7615_phy *phy, bool enable);
 void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy);
-- 
2.38.1

