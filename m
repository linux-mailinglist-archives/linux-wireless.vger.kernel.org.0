Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC367AD6
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGMPJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfGMPJ2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:09:28 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041D1208E4;
        Sat, 13 Jul 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030567;
        bh=Xbu0QY+d5tpvTiSTiaqzzfwAfj3i3TxnGMNG4j1jp6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPNzyxv79LbaNMcjrsEgQlBaFcrg6gdXDYvsIrIjjRXZQ0cvu62B92GhnfKII8mmD
         MdyriBR1KBv6nvo8xUmmLjTLxlhzavrebX5MTjmrT+uFjuLXI7E7LyLHm3odgQcl9X
         zAT0XBQ5Al7OekiNF6Esb2yW7ZQdCDmB1cWjbTNg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH 6/7] mt76: intorduce mt76_mmio_read_copy routine
Date:   Sat, 13 Jul 2019 17:09:06 +0200
Message-Id: <3fc528561d3edcf186c7127d32be5231302a57e1.1563029769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563029769.git.lorenzo@kernel.org>
References: <cover.1563029769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76_mmio_read_copy routine and the related function pointer in
mt76_bus_ops data structure. mt76_mmio_read_copy will be used to add
BIP_CMAC_128 cipher hw support to mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mmio.c | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h | 12 ++++++++----
 drivers/net/wireless/mediatek/mt76/usb.c  |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 83c96a47914f..33512801dc02 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -40,12 +40,18 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32 val)
 	return val;
 }
 
-static void mt76_mmio_copy(struct mt76_dev *dev, u32 offset, const void *data,
-			   int len)
+static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
+				 const void *data, int len)
 {
 	__iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
 }
 
+static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
+				void *data, int len)
+{
+	__ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, 4));
+}
+
 static int mt76_mmio_wr_rp(struct mt76_dev *dev, u32 base,
 			   const struct mt76_reg_pair *data, int len)
 {
@@ -89,7 +95,8 @@ void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
 		.rr = mt76_mmio_rr,
 		.rmw = mt76_mmio_rmw,
 		.wr = mt76_mmio_wr,
-		.copy = mt76_mmio_copy,
+		.write_copy = mt76_mmio_write_copy,
+		.read_copy = mt76_mmio_read_copy,
 		.wr_rp = mt76_mmio_wr_rp,
 		.rd_rp = mt76_mmio_rd_rp,
 		.type = MT76_BUS_MMIO,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 094e6e543542..3da9cbe3ebc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -48,8 +48,10 @@ struct mt76_bus_ops {
 	u32 (*rr)(struct mt76_dev *dev, u32 offset);
 	void (*wr)(struct mt76_dev *dev, u32 offset, u32 val);
 	u32 (*rmw)(struct mt76_dev *dev, u32 offset, u32 mask, u32 val);
-	void (*copy)(struct mt76_dev *dev, u32 offset, const void *data,
-		     int len);
+	void (*write_copy)(struct mt76_dev *dev, u32 offset, const void *data,
+			   int len);
+	void (*read_copy)(struct mt76_dev *dev, u32 offset, void *data,
+			  int len);
 	int (*wr_rp)(struct mt76_dev *dev, u32 base,
 		     const struct mt76_reg_pair *rp, int len);
 	int (*rd_rp)(struct mt76_dev *dev, u32 base,
@@ -540,7 +542,8 @@ struct mt76_rx_status {
 #define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
 #define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
 #define __mt76_rmw(dev, ...)	(dev)->bus->rmw((dev), __VA_ARGS__)
-#define __mt76_wr_copy(dev, ...)	(dev)->bus->copy((dev), __VA_ARGS__)
+#define __mt76_wr_copy(dev, ...)	(dev)->bus->write_copy((dev), __VA_ARGS__)
+#define __mt76_rr_copy(dev, ...)	(dev)->bus->read_copy((dev), __VA_ARGS__)
 
 #define __mt76_set(dev, offset, val)	__mt76_rmw(dev, offset, 0, val)
 #define __mt76_clear(dev, offset, val)	__mt76_rmw(dev, offset, val, 0)
@@ -548,7 +551,8 @@ struct mt76_rx_status {
 #define mt76_rr(dev, ...)	(dev)->mt76.bus->rr(&((dev)->mt76), __VA_ARGS__)
 #define mt76_wr(dev, ...)	(dev)->mt76.bus->wr(&((dev)->mt76), __VA_ARGS__)
 #define mt76_rmw(dev, ...)	(dev)->mt76.bus->rmw(&((dev)->mt76), __VA_ARGS__)
-#define mt76_wr_copy(dev, ...)	(dev)->mt76.bus->copy(&((dev)->mt76), __VA_ARGS__)
+#define mt76_wr_copy(dev, ...)	(dev)->mt76.bus->write_copy(&((dev)->mt76), __VA_ARGS__)
+#define mt76_rr_copy(dev, ...)	(dev)->mt76.bus->read_copy(&((dev)->mt76), __VA_ARGS__)
 #define mt76_wr_rp(dev, ...)	(dev)->mt76.bus->wr_rp(&((dev)->mt76), __VA_ARGS__)
 #define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 00069c2536f8..d8d4d4573f39 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -929,7 +929,7 @@ int mt76u_init(struct mt76_dev *dev,
 		.rr = mt76u_rr,
 		.wr = mt76u_wr,
 		.rmw = mt76u_rmw,
-		.copy = mt76u_copy,
+		.write_copy = mt76u_copy,
 		.wr_rp = mt76u_wr_rp,
 		.rd_rp = mt76u_rd_rp,
 		.type = MT76_BUS_USB,
-- 
2.21.0

