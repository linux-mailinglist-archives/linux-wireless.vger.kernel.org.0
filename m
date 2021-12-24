Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBA47EE5E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352502AbhLXK6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44356 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbhLXK6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EFE8B82287
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1465BC36AE8;
        Fri, 24 Dec 2021 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343514;
        bh=SvM5BeOUtWVls+FK8zLQvD62SeS7aSWyOVj/bVOyWqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqpgxE3c3wOBQswhydbFOukTi0fyoRy/XUZNXqkexxtYTSvKQSAtTDEQBn+xB8Sqq
         wYkQvCVgew9Vuyixd3J2nxfhOBVHsD2zIvUfIVfLlYH1ZA0J5M4N/bzGCTRziBNtpz
         fioVUkahdxcn4IddGajuCYZ69DhKl94hzcy9Q3ivRWnBwjdZCYxWleK+KhAldbwuHk
         1QJ2/jzmPFjuNojcOQx6Xnv7iy206E/ydFZG1L89/1eOwYzkRGEcKfqvhY2NbbKEv2
         3SNWNTx1v06YRy2/HHvqJwQGPMRJae4vFBiz8fuas3ldZfQzFMRqT6f5S/FpkpXEzX
         EkAEAhAbaKJsg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 03/10] mt76: mt7921: get rid of mt7921_mcu_get_eeprom
Date:   Fri, 24 Dec 2021 11:58:04 +0100
Message-Id: <bdbb57a655ec30b72c79ccbafe21e16da36f8e83.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove mt7921_mcu_get_eeprom since it is no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 24 -------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index b0022713c469..7ca1e2291674 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -960,30 +960,6 @@ int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
 
-int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
-{
-	struct mt7921_mcu_eeprom_info req = {
-		.addr = cpu_to_le32(round_down(offset, 16)),
-	};
-	struct mt7921_mcu_eeprom_info *res;
-	struct sk_buff *skb;
-	int ret;
-	u8 *buf;
-
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
-					MCU_EXT_QUERY(EFUSE_ACCESS),
-					&req, sizeof(req), true, &skb);
-	if (ret)
-		return ret;
-
-	res = (struct mt7921_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
-	dev_kfree_skb(skb);
-
-	return 0;
-}
-
 int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c0fcc5eda5ca..f9c0fd7ca073 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -297,7 +297,6 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
 int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
-int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset);
 int mt7921_mcu_get_rx_rate(struct mt7921_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
-- 
2.33.1

