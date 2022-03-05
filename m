Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517924CE592
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Mar 2022 16:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiCEPjx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Mar 2022 10:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiCEPjw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Mar 2022 10:39:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030113C4B3
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 07:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 936F5612AE
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 15:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F3C004E1;
        Sat,  5 Mar 2022 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646494740;
        bh=MQCA4Ubrc/bC37Qj/M5bhNntPhyM9X3eRtGepgIRr84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDH55GTWhK5szEbaLdxnTXET1E8vwyD3scnYLQTy7u8nCf7e4rfxj+vM8FfAYY9kT
         cVOZ5ifkbwrTheG65RcPvyZqLZuZABiZdmpsy12dtJGdotFXgF4hPvc+NprkBtflDy
         KDBDxl0ZIWFuQ/JFUhDnnbT9XHnNsudWMyOjHzDn/vRKFWUQB4gZy7fFuHO/A/dA9g
         cpppxBjdI+XI8ONLrJs99mQm+++l62tjbWo4JDr+CAUvuHEKp99qZBwE2SxnBNtoPD
         wA8osmFFDcKJO9QCo06HgHvKO9K9rbNOgxLNIRt7kS7yM3Kbxc+WVAXyLfmCKVE73W
         XNsEQDyYGfsoQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 8/9] mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
Date:   Sat,  5 Mar 2022 16:38:18 +0100
Message-Id: <83c0fd180f37b440d348870af2e0f031f976143e.1646494452.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646494452.git.lorenzo@kernel.org>
References: <cover.1646494452.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add mt7921u driver support.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 12 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 11 -----------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index c0f78e3c05b2..0c0309133502 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1706,3 +1706,15 @@ void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_complete_skb);
+
+bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mac_sta_poll(dev);
+	mt7921_mutex_release(dev);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_status_data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index edd3c5938035..b952372c5565 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -445,7 +445,6 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_init(struct mt7921_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
-bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
 
@@ -455,4 +454,5 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   struct mt76_tx_info *tx_info);
 void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 				     struct mt76_queue_entry *e);
+bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 507bd550b063..9b2bc0b11492 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -93,7 +93,7 @@ static int mt7921s_probe(struct sdio_func *func,
 				SURVEY_INFO_TIME_BSS_RX,
 		.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
 		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
-		.tx_status_data = mt7921s_tx_status_data,
+		.tx_status_data = mt7921_usb_sdio_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
 		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index fa9db21bb3e8..1b3adb3d91e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -140,14 +140,3 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 
 	return err;
 }
-
-bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update)
-{
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-
-	mt7921_mutex_acquire(dev);
-	mt7921_mac_sta_poll(dev);
-	mt7921_mutex_release(dev);
-
-	return false;
-}
-- 
2.35.1

