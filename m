Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF024D76C2
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiCMQYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiCMQYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 12:24:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15B84EF7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 09:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B96B80CA4
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 16:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B60EC340F6;
        Sun, 13 Mar 2022 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647188602;
        bh=iOnTymIef0AyAtZy+eqdTRzdqkwvlWyBJHKNsM+a0+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLRuNlVu4gfQF2gLkUVBQHmqlJPVzUDUVfBzIKUR2o3TuR7P87WiXh17Z9PJPNg7N
         +7m7I94Tn+3DWU1EsM53qcuq8SvS0Zksu2c1QrKYIhQNDxAiMLxFgR39qU+RTNR3hd
         oFFBi4o9k7IzOFEfAHb0DSIHZMCR4fW+rE+xtGZ5Q8AFSArB7AfGLYgOTHs3d16J+7
         SH2tNnq5L9d2RqTBi7WU8AMuv2HwG8EKcy3SgqSOSknYwrWM+O4qIM63u350dFzPkm
         oVPvuOEKw5u5qfnLUjPxbYfT8yWmYUnZ+OnXoX9qivcFgeX/Xru4oPEYiNGxy59iu+
         xzUrSaB0V1BGQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 8/9] mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
Date:   Sun, 13 Mar 2022 17:22:40 +0100
Message-Id: <2f41acfadc4466e920a991be4c88df158972da7e.1647188302.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647188301.git.lorenzo@kernel.org>
References: <cover.1647188301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 310b3da77d83..bdcc68b85f35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -444,7 +444,6 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_init(struct mt7921_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
-bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
 
@@ -454,4 +453,5 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
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

