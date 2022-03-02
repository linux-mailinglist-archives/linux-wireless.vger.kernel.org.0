Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C214CA98A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiCBPtu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 10:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiCBPtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802631341
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 07:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BACEB82083
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 15:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE0C340F7;
        Wed,  2 Mar 2022 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236121;
        bh=+tTvYWBMNc6CsypY4VP96CvkPp7+15R7ul2KuoBxz8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDmMGO8jPTSOokkQ291RGhIFQUwL4UAUf3anVWoGbAcu/drzgfxaysdEucNuiDBih
         XFtegUtkBmuQ36cP+sENTcxxcgt7XI56h3WYpCVncqJGlYJ0xFlg0DxsK/4YoYyn7K
         lgySCWI7QP4uxgAUWzdz43ZyWa+xfoPAaE4RgbalvwXSde09WmQEmXJdlLAlmVcuaZ
         Fi1EfR5GdlFmHp8/ju7ESrXrVhDtsYktdM/V+dGZ68U40DTBzFhOE/PuEqfCvY9zuy
         zNpmIerqufTJsK/JqzRG27ntFrwS6mVQcUA1/xJEv1NDma7DxlHoijOW3pWlB3iJBI
         wSeNOw4vcZEkQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/9] mt76: usb: introduce __mt76u_init utility routine
Date:   Wed,  2 Mar 2022 16:48:07 +0100
Message-Id: <4f32408172a7dfbd0da27e0c7ed37306ae9006eb.1646235785.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646235785.git.lorenzo@kernel.org>
References: <cover.1646235785.git.lorenzo@kernel.org>
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

Introduce __mt76u_init unitility routine and move mt7615 usb bus ops
into mt7615 module in order to allow specifying driver specific
parameter.
This is a preliminary patch to add usb support to mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  68 ++++++++++-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 112 +++++-------------
 5 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5e10fe156926..9b2aee9b6ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1274,13 +1274,21 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats);
 int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
+int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
+			   u16 val, u16 offset, void *buf, size_t len);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
 			 void *buf, size_t len);
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
-int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
-	       bool ext);
+void mt76u_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len);
+u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type, u32 addr);
+void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
+		 u32 addr, u32 val);
+int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
+		 struct mt76_bus_ops *ops);
+int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
 int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
 int mt76u_alloc_queues(struct mt76_dev *dev);
 void mt76u_stop_tx(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index aeeba7c72f14..967641aebf5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -21,6 +21,64 @@ static const struct usb_device_id mt7615_device_table[] = {
 	{ },
 };
 
+static u32 mt7663u_rr(struct mt76_dev *dev, u32 addr)
+{
+	u32 ret;
+
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			  USB_DIR_IN | USB_TYPE_VENDOR, addr);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return ret;
+}
+
+static void mt7663u_wr(struct mt76_dev *dev, u32 addr, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+}
+
+static u32 mt7663u_rmw(struct mt76_dev *dev, u32 addr,
+		       u32 mask, u32 val)
+{
+	mutex_lock(&dev->usb.usb_ctrl_mtx);
+	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			   USB_DIR_IN | USB_TYPE_VENDOR, addr) & ~mask;
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
+	mutex_unlock(&dev->usb.usb_ctrl_mtx);
+
+	return val;
+}
+
+static void mt7663u_copy(struct mt76_dev *dev, u32 offset,
+			 const void *data, int len)
+{
+	struct mt76_usb *usb = &dev->usb;
+	int ret, i = 0, batch_len;
+	const u8 *val = data;
+
+	len = round_up(len, 4);
+
+	mutex_lock(&usb->usb_ctrl_mtx);
+	while (i < len) {
+		batch_len = min_t(int, usb->data_len, len - i);
+		memcpy(usb->data, val + i, batch_len);
+		ret = __mt76u_vendor_request(dev, MT_VEND_WRITE_EXT,
+					     USB_DIR_OUT | USB_TYPE_VENDOR,
+					     (offset + i) >> 16, offset + i,
+					     usb->data, batch_len);
+		if (ret < 0)
+			break;
+
+		i += batch_len;
+	}
+	mutex_unlock(&usb->usb_ctrl_mtx);
+}
+
 static void mt7663u_stop(struct ieee80211_hw *hw)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -66,6 +124,14 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
 	};
+	static struct mt76_bus_ops bus_ops = {
+		.rr = mt7663u_rr,
+		.wr = mt7663u_wr,
+		.rmw = mt7663u_rmw,
+		.read_copy = mt76u_read_copy,
+		.write_copy = mt7663u_copy,
+		.type = MT76_BUS_USB,
+	};
 	struct usb_device *udev = interface_to_usbdev(usb_intf);
 	struct ieee80211_ops *ops;
 	struct mt7615_dev *dev;
@@ -92,7 +158,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 	INIT_WORK(&dev->mcu_work, mt7663u_init_work);
 	dev->reg_map = mt7663_usb_sdio_reg_map;
 	dev->ops = ops;
-	ret = mt76u_init(mdev, usb_intf, true);
+	ret = __mt76u_init(mdev, usb_intf, &bus_ops);
 	if (ret < 0)
 		goto error;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 436daf6d6d86..0422c332354a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -245,7 +245,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	usb_set_intfdata(usb_intf, dev);
 
 	mt76x02u_init_mcu(mdev);
-	ret = mt76u_init(mdev, usb_intf, false);
+	ret = mt76u_init(mdev, usb_intf);
 	if (ret)
 		goto err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 2575369e44e2..55068f3252ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -57,7 +57,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	mt76x02u_init_mcu(mdev);
-	err = mt76u_init(mdev, intf, false);
+	err = mt76u_init(mdev, intf);
 	if (err < 0)
 		goto err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 4b7a816f1b93..a85e192c9d59 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -15,9 +15,8 @@ static bool disable_usb_sg;
 module_param_named(disable_usb_sg, disable_usb_sg, bool, 0644);
 MODULE_PARM_DESC(disable_usb_sg, "Disable usb scatter-gather support");
 
-static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
-				  u8 req_type, u16 val, u16 offset,
-				  void *buf, size_t len)
+int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
+			   u16 val, u16 offset, void *buf, size_t len)
 {
 	struct usb_interface *uintf = to_usb_interface(dev->dev);
 	struct usb_device *udev = interface_to_usbdev(uintf);
@@ -45,6 +44,7 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 		req, offset, ret);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__mt76u_vendor_request);
 
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
@@ -62,8 +62,7 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 }
 EXPORT_SYMBOL_GPL(mt76u_vendor_request);
 
-static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type,
-		       u32 addr)
+u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type, u32 addr)
 {
 	struct mt76_usb *usb = &dev->usb;
 	u32 data = ~0;
@@ -77,6 +76,7 @@ static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type,
 
 	return data;
 }
+EXPORT_SYMBOL_GPL(___mt76u_rr);
 
 static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
 {
@@ -109,20 +109,8 @@ static u32 mt76u_rr(struct mt76_dev *dev, u32 addr)
 	return ret;
 }
 
-static u32 mt76u_rr_ext(struct mt76_dev *dev, u32 addr)
-{
-	u32 ret;
-
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT,
-			  USB_DIR_IN | USB_TYPE_VENDOR, addr);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-
-	return ret;
-}
-
-static void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
-			u32 addr, u32 val)
+void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
+		 u32 addr, u32 val)
 {
 	struct mt76_usb *usb = &dev->usb;
 
@@ -131,6 +119,7 @@ static void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
 			       addr, usb->data, sizeof(__le32));
 	trace_usb_reg_wr(dev, addr, val);
 }
+EXPORT_SYMBOL_GPL(___mt76u_wr);
 
 static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 {
@@ -155,14 +144,6 @@ static void mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 }
 
-static void mt76u_wr_ext(struct mt76_dev *dev, u32 addr, u32 val)
-{
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
-		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-}
-
 static u32 mt76u_rmw(struct mt76_dev *dev, u32 addr,
 		     u32 mask, u32 val)
 {
@@ -174,19 +155,6 @@ static u32 mt76u_rmw(struct mt76_dev *dev, u32 addr,
 	return val;
 }
 
-static u32 mt76u_rmw_ext(struct mt76_dev *dev, u32 addr,
-			 u32 mask, u32 val)
-{
-	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
-			   USB_DIR_IN | USB_TYPE_VENDOR, addr) & ~mask;
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
-		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
-	mutex_unlock(&dev->usb.usb_ctrl_mtx);
-
-	return val;
-}
-
 static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 		       const void *data, int len)
 {
@@ -219,33 +187,8 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
 
-static void mt76u_copy_ext(struct mt76_dev *dev, u32 offset,
-			   const void *data, int len)
-{
-	struct mt76_usb *usb = &dev->usb;
-	int ret, i = 0, batch_len;
-	const u8 *val = data;
-
-	len = round_up(len, 4);
-	mutex_lock(&usb->usb_ctrl_mtx);
-	while (i < len) {
-		batch_len = min_t(int, usb->data_len, len - i);
-		memcpy(usb->data, val + i, batch_len);
-		ret = __mt76u_vendor_request(dev, MT_VEND_WRITE_EXT,
-					     USB_DIR_OUT | USB_TYPE_VENDOR,
-					     (offset + i) >> 16, offset + i,
-					     usb->data, batch_len);
-		if (ret < 0)
-			break;
-
-		i += batch_len;
-	}
-	mutex_unlock(&usb->usb_ctrl_mtx);
-}
-
-static void
-mt76u_read_copy_ext(struct mt76_dev *dev, u32 offset,
-		    void *data, int len)
+void mt76u_read_copy(struct mt76_dev *dev, u32 offset,
+		     void *data, int len)
 {
 	struct mt76_usb *usb = &dev->usb;
 	int i = 0, batch_len, ret;
@@ -267,6 +210,7 @@ mt76u_read_copy_ext(struct mt76_dev *dev, u32 offset,
 	}
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
+EXPORT_SYMBOL_GPL(mt76u_read_copy);
 
 void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val)
@@ -1115,24 +1059,13 @@ static const struct mt76_queue_ops usb_queue_ops = {
 	.kick = mt76u_tx_kick,
 };
 
-int mt76u_init(struct mt76_dev *dev,
-	       struct usb_interface *intf, bool ext)
+int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
+		 struct mt76_bus_ops *ops)
 {
-	static struct mt76_bus_ops mt76u_ops = {
-		.read_copy = mt76u_read_copy_ext,
-		.wr_rp = mt76u_wr_rp,
-		.rd_rp = mt76u_rd_rp,
-		.type = MT76_BUS_USB,
-	};
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
 	int err;
 
-	mt76u_ops.rr = ext ? mt76u_rr_ext : mt76u_rr;
-	mt76u_ops.wr = ext ? mt76u_wr_ext : mt76u_wr;
-	mt76u_ops.rmw = ext ? mt76u_rmw_ext : mt76u_rmw;
-	mt76u_ops.write_copy = ext ? mt76u_copy_ext : mt76u_copy;
-
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
 
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
@@ -1144,7 +1077,7 @@ int mt76u_init(struct mt76_dev *dev,
 		return -ENOMEM;
 
 	mutex_init(&usb->usb_ctrl_mtx);
-	dev->bus = &mt76u_ops;
+	dev->bus = ops;
 	dev->queue_ops = &usb_queue_ops;
 
 	dev_set_drvdata(&udev->dev, dev);
@@ -1170,6 +1103,23 @@ int mt76u_init(struct mt76_dev *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mt76u_init);
+
+int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf)
+{
+	static struct mt76_bus_ops bus_ops = {
+		.rr = mt76u_rr,
+		.wr = mt76u_wr,
+		.rmw = mt76u_rmw,
+		.read_copy = mt76u_read_copy,
+		.write_copy = mt76u_copy,
+		.wr_rp = mt76u_wr_rp,
+		.rd_rp = mt76u_rd_rp,
+		.type = MT76_BUS_USB,
+	};
+
+	return __mt76u_init(dev, intf, &bus_ops);
+}
 EXPORT_SYMBOL_GPL(mt76u_init);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
-- 
2.35.1

