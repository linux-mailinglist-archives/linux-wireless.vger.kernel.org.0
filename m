Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A956A47EE65
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbhLXK6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352517AbhLXK6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81BC061401
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 02:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BA67B82287
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C54C36AE8;
        Fri, 24 Dec 2021 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343523;
        bh=RxUjsA6LmLRqW+EGij9jTueFCuuJe4H9HyHezMUYYCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZ5X4YRG4E7YncbWOA+JrX+KKrq4DanCfJnxpmkWFEBHoU1z3jpZ7pL9adP9ehiKg
         /lrfduYaiVS9YlKvJHeg6QSW6scHbebtQo3t43Wq2g+IceDXgIjamfzSpLndv7w37X
         YdlirMJddbkQ0PKfSX4Jl1jPExmp2nfmE6y71KjWpWRHkdLorHWzoWYm3Z1mR4HZCz
         zGk9/Ra1doHW4Lk4Tf1vB4dOiCP4OFua71o8skba7VjYQ5fNKRiHTilfLzXVi3fl/c
         Mz7EWyAjqk5roZtEswfqWA3JYXxCffiFVMGnMyIqO9VpELqYnNu58Ckzcxx9jRCz2A
         67rvC7WLyvi3A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 09/10] mt76: mt7915: rely on mt76_connac_mcu_set_rts_thresh
Date:   Fri, 24 Dec 2021 11:58:10 +0100
Message-Id: <3c7e5f4248f5fb6a13d30d4443734c43d376225b.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_set_rts_thresh routine in mt7915 driver and
remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 +++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 -------------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 -
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 228bbc6e98c8..aed0a5303aa8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -65,7 +65,8 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
-	ret = mt7915_mcu_set_rts_thresh(phy, 0x92b);
+	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
+					     phy != &dev->phy);
 	if (ret)
 		goto out;
 
@@ -747,7 +748,7 @@ static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 	int ret;
 
 	mutex_lock(&dev->mt76.mutex);
-	ret = mt7915_mcu_set_rts_thresh(phy, val);
+	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, phy != &dev->phy);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index cc09677e99de..eb9ce86d5303 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2483,26 +2483,6 @@ int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable)
 				 sizeof(req), false);
 }
 
-int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val)
-{
-	struct mt7915_dev *dev = phy->dev;
-	struct {
-		u8 prot_idx;
-		u8 band;
-		u8 rsv[2];
-		__le32 len_thresh;
-		__le32 pkt_thresh;
-	} __packed req = {
-		.prot_idx = 1,
-		.band = phy != &dev->phy,
-		.len_thresh = cpu_to_le32(val),
-		.pkt_thresh = cpu_to_le32(0x2),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PROTECT_CTRL), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *param)
 {
 	struct mt7915_mcu_tx *req = (struct mt7915_mcu_tx *)param;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 9fb2810f9c33..3f32ae274600 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -440,7 +440,6 @@ int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 			      u8 en);
 int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable);
 int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
-int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
-- 
2.33.1

