Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E647EE60
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352504AbhLXK6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51864 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352500AbhLXK6i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA5D62036
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E9C36AE5;
        Fri, 24 Dec 2021 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343517;
        bh=ziDoLAPnxxXrCrRD195Ea9byZQlkFE+2y4IKhVR8vbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XURLVhcFseIfQX4APCDcschGYN/g4UIenz3GU2Jone0GC96KcCLmtIQnB324BWAIu
         btpvSGRwA723CWYONzbqInyZgIsVmppNhcy9b5zhU5Kkt6Lpq6FWG3rl4N+qjqfrCG
         MDtJLQ1Wntj9wyqsoKV6tYngm0M7NjLpe2BBYuc38G0rVxki8Mtta1JcEtd9bjPPlQ
         GSVkkcx5nl1OFpMmYoqwiPnROSBkCQJ35S+rb7j13WIPktWo8oo/4DSI+7VClmBtTH
         B6FFAXCZSxXY1utdCCy6KlW0Sy5cmegV82t9jfP0XDmruuyoIps9DLvqMVEfMOnm9I
         N5mVNNUg9DAsA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 05/10] mt76: connac: move mt76_connac_mcu_restart in common module
Date:   Fri, 24 Dec 2021 11:58:06 +0100
Message-Id: <39c47276dafbdb967ab11ddeaea1c01d7dd175a1.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_restart routine in mt76-connac since it is shared
between mt7921 and mt7915.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c  | 14 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c   | 15 +--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c   | 14 --------------
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c   |  2 +-
 6 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6b714928d70a..efd0519a1872 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2750,5 +2750,19 @@ int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_pm);
 
+int mt76_connac_mcu_restart(struct mt76_dev *dev)
+{
+	struct {
+		u8 power_mode;
+		u8 rsv[3];
+	} req = {
+		.power_mode = 1,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
+				 sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_restart);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 285c6529474d..0dd02d79a297 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1610,4 +1610,5 @@ void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
 				   struct ieee80211_sta *sta,
 				   void *sta_wtbl, void *wtbl_tlv);
 int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
+int mt76_connac_mcu_restart(struct mt76_dev *dev);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f5d24e03a861..77fa79ca8719 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1941,19 +1941,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
-static int mt7915_mcu_restart(struct mt76_dev *dev)
-{
-	struct {
-		u8 power_mode;
-		u8 rsv[3];
-	} req = {
-		.power_mode = 1,
-	};
-
-	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
-				 sizeof(req), false);
-}
-
 static int mt7915_mcu_patch_sem_ctrl(struct mt7915_dev *dev, bool get)
 {
 	struct {
@@ -2428,7 +2415,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 		.headroom = sizeof(struct mt7915_mcu_txd),
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
 		.mcu_parse_response = mt7915_mcu_parse_response,
-		.mcu_restart = mt7915_mcu_restart,
+		.mcu_restart = mt76_connac_mcu_restart,
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 7ca1e2291674..fa6c0d8d3b22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -444,20 +444,6 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 				      enable, false);
 }
 
-int mt7921_mcu_restart(struct mt76_dev *dev)
-{
-	struct {
-		u8 power_mode;
-		u8 rsv[3];
-	} req = {
-		.power_mode = 1,
-	};
-
-	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
-				 sizeof(req), false);
-}
-EXPORT_SYMBOL_GPL(mt7921_mcu_restart);
-
 static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f9c0fd7ca073..fd9331783931 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -433,7 +433,6 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq);
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
-int mt7921_mcu_restart(struct mt76_dev *dev);
 
 void mt7921e_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			  struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index a020352122a1..f9e350b67fdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -42,7 +42,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
 		.headroom = sizeof(struct mt7921_mcu_txd),
 		.mcu_skb_send_msg = mt7921_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
-		.mcu_restart = mt7921_mcu_restart,
+		.mcu_restart = mt76_connac_mcu_restart,
 	};
 	int err;
 
-- 
2.33.1

