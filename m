Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFD8129A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHEG4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 02:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEG4J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 02:56:09 -0400
Received: from localhost.localdomain (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D160217F4;
        Mon,  5 Aug 2019 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564988168;
        bh=ky7GxIk3D02wBE5vnLK1JSNSb9zdPh/Qy1DanQw3NN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqtyuCjjbD9mbbyY+OzqeK+lbwOv3Jx3MTILRv5jyGwkBvC5X4HHHjtIPdob4G7jx
         YUNDIXMpG86jCxxr4JI1GJAE7UouZgB9420SM361uwEy/KfRHxCApkyR2OpoQRC42l
         CH75m4m9ud1X2VhdA3Dw+J2c4B2RkzV92f2hy1fw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com, ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 1/3] mt76: mt76x02u: enable survey support
Date:   Mon,  5 Aug 2019 08:55:51 +0200
Message-Id: <3dc00f31e4c88b590f56ee1af6f075b923b3ec56.1564987866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564987866.git.lorenzo@kernel.org>
References: <cover.1564987866.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce channel survey support for mt76x2u and mt76x0u drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      | 9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 627ed1fc7b15..927b8bd31f5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -132,6 +132,7 @@ static const struct ieee80211_ops mt76x0u_ops = {
 	.set_rts_threshold = mt76x02_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.get_txpower = mt76_get_txpower,
+	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
 };
@@ -161,6 +162,13 @@ static int mt76x0u_init_hardware(struct mt76x02_dev *dev)
 		FIELD_PREP(MT_TXOP_TRUN_EN, 0x3f) |
 		FIELD_PREP(MT_TXOP_EXT_CCA_DLY, 0x58));
 
+	mt76_wr(dev, MT_CH_TIME_CFG,
+		MT_CH_TIME_CFG_TIMER_EN |
+		MT_CH_TIME_CFG_TX_AS_BUSY |
+		MT_CH_TIME_CFG_RX_AS_BUSY |
+		MT_CH_TIME_CFG_NAV_AS_BUSY |
+		MT_CH_TIME_CFG_EIFS_AS_BUSY);
+
 	return 0;
 }
 
@@ -200,6 +208,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
+		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
 		.tx_status_data = mt76x02_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 7a994a783510..2c1e508b4609 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -36,6 +36,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
+		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
 		.tx_status_data = mt76x02_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 94f52f98019b..098f225dac72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -195,6 +195,13 @@ int mt76x2u_init_hardware(struct mt76x02_dev *dev)
 	mt76x02_phy_set_rxpath(dev);
 	mt76x02_phy_set_txdac(dev);
 
+	mt76_wr(dev, MT_CH_TIME_CFG,
+		MT_CH_TIME_CFG_TIMER_EN |
+		MT_CH_TIME_CFG_TX_AS_BUSY |
+		MT_CH_TIME_CFG_RX_AS_BUSY |
+		MT_CH_TIME_CFG_NAV_AS_BUSY |
+		MT_CH_TIME_CFG_EIFS_AS_BUSY);
+
 	return mt76x2u_mac_stop(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 7e9e44b96671..9933b78c1308 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -59,6 +59,10 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 
 	err = mt76x2u_phy_set_channel(dev, chandef);
 
+	/* channel cycle counters read-and-clear */
+	mt76_rr(dev, MT_CH_IDLE);
+	mt76_rr(dev, MT_CH_BUSY);
+
 	mt76x2_mac_resume(dev);
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
@@ -125,6 +129,7 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.sw_scan_complete = mt76x02_sw_scan_complete,
 	.sta_rate_tbl_update = mt76x02_sta_rate_tbl_update,
 	.get_txpower = mt76_get_txpower,
+	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
 };
-- 
2.21.0

