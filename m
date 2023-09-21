Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23687A9BA3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjIUTDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjIUTCp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD280F81
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:36:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC734C32792;
        Thu, 21 Sep 2023 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695291843;
        bh=ehQHm3wQjPz5ob4mnIzc73+FRvEMgAEVSzJm4I0ftfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4wQYg2FXYgwZCLnNlK4ZOM4HD2QxFithW8IcM1z4MyxXxANJaBZay62XU+oovQdm
         3x9n7q4zClVV1G2Mo7NLVmg9DNMm3O0p/WNZOOsyDsTFsyVeRuIlTe8A+gZAYGwesg
         8PmG2nq3CnIX7cMTTC+Tzc47HNZ91Qdlf7M1RRGvJxYgAEWN3jfhEEJrWzIz2kziU4
         bxvc4GZiDL8qtZWLJIh9IMLYuVzdgw9PVtZ6oI/y5IG1VMjrdR9mmf8VqdoNvRsTnL
         cHT/wRkDE2pzXdQj7L7YdOcjhg6Vr8eSoQcSiRhycPQmTq4P8VqCaY79aJ5eV1xMyz
         AVyG+itFFJcJA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 1/2] wifi: mt76: mt792x: move mt7921_skb_add_usb_sdio_hdr in mt792x module
Date:   Thu, 21 Sep 2023 12:23:47 +0200
Message-ID: <b4f7cded1065c208a03432d85cc0c64aa99f9c10.1695291565.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695291565.git.lorenzo@kernel.org>
References: <cover.1695291565.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since mt7921_skb_add_usb_sdio_hdr is shared between mt7925 and mt7921
drivers, move it in mt792x module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h   | 16 ----------------
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mt7925.h   | 15 ---------------
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 16 ++++++++++++++++
 8 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 21f937454229..867e14f6b93a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -794,7 +794,7 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	mt7921_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 
 	type = mt76_is_sdio(mdev) ? MT7921_SDIO_DATA : 0;
-	mt7921_skb_add_usb_sdio_hdr(dev, skb, type);
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, type);
 	pad = round_up(skb->len, 4) - skb->len;
 	if (mt76_is_usb(mdev))
 		pad += 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 87dd06855f68..d454b5e43636 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -23,9 +23,6 @@
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
 
-#define MT7921_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
-#define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
-
 #define MCU_UNI_EVENT_ROC  0x27
 
 enum {
@@ -235,19 +232,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-static inline void
-mt7921_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
-			    int type)
-{
-	u32 hdr, len;
-
-	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
-	hdr = FIELD_PREP(MT7921_SDIO_HDR_TX_BYTES, len) |
-	      FIELD_PREP(MT7921_SDIO_HDR_PKT_TYPE, type);
-
-	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
-}
-
 void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 310eeca024ad..5e4501d7f1c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -38,7 +38,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (cmd == MCU_CMD(FW_SCATTER))
 		type = MT7921_SDIO_FWDL;
 
-	mt7921_skb_add_usb_sdio_hdr(dev, skb, type);
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, type);
 	pad = round_up(skb->len, 4) - skb->len;
 	__skb_put_zero(skb, pad);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 59cd3d98bf90..33a87f447dca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -43,7 +43,7 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		ep = MT_EP_OUT_AC_BE;
 
-	mt7921_skb_add_usb_sdio_hdr(dev, skb, 0);
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, 0);
 	pad = round_up(skb->len, 4) + 4 - skb->len;
 	__skb_put_zero(skb, pad);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 2b27611c7f4b..1b9fbd9a140d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1378,7 +1378,7 @@ int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
 	mt7925_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 
-	mt7925_skb_add_usb_sdio_hdr(dev, skb, 0);
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, 0);
 	pad = round_up(skb->len, 4) - skb->len;
 	if (mt76_is_usb(mdev))
 		pad += 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 1133d95383ca..9a2d38a2b2bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -25,9 +25,6 @@
 #define MT7925_SKU_MAX_DELTA_IDX	MT7925_SKU_RATE_NUM
 #define MT7925_SKU_TABLE_SIZE		(MT7925_SKU_RATE_NUM + 1)
 
-#define MT7925_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
-#define MT7925_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
-
 #define MCU_UNI_EVENT_ROC  0x27
 
 enum {
@@ -210,18 +207,6 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
 int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
-static inline void
-mt7925_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
-			    int type)
-{
-	u32 hdr, len;
-
-	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
-	hdr = FIELD_PREP(MT7925_SDIO_HDR_TX_BYTES, len) |
-	      FIELD_PREP(MT7925_SDIO_HDR_PKT_TYPE, type);
-
-	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
-}
 
 void mt7925_stop(struct ieee80211_hw *hw);
 int mt7925_mac_init(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 6cbcecabf40e..ea09b9b9d303 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -34,7 +34,7 @@ mt7925u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	else
 		ep = MT_EP_OUT_AC_BE;
 
-	mt7925_skb_add_usb_sdio_hdr(dev, skb, 0);
+	mt792x_skb_add_usb_sdio_hdr(dev, skb, 0);
 	pad = round_up(skb->len, 4) + 4 - skb->len;
 	__skb_put_zero(skb, pad);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 548e89fad4d9..fd1614e4926b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -42,6 +42,9 @@
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
 #define MT7925_ROM_PATCH	"mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin"
 
+#define MT792x_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
+#define MT792x_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
+
 struct mt792x_vif;
 struct mt792x_sta;
 
@@ -343,6 +346,19 @@ u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
 void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len);
 void mt792xu_disconnect(struct usb_interface *usb_intf);
 
+static inline void
+mt792x_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
+			    int type)
+{
+	u32 hdr, len;
+
+	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
+	hdr = FIELD_PREP(MT792x_SDIO_HDR_TX_BYTES, len) |
+	      FIELD_PREP(MT792x_SDIO_HDR_PKT_TYPE, type);
+
+	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
+}
+
 int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
-- 
2.41.0

