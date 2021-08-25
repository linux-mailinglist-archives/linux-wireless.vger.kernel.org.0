Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB133F6D2A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 03:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhHYBiJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhHYBiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 21:38:08 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84DC061757
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 18:37:23 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mIhmE-0007rm-DA; Wed, 25 Aug 2021 03:32:25 +0200
Date:   Wed, 25 Aug 2021 02:32:16 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] mt76: support reading EEPROM data embedded in fdt
Message-ID: <YSWdoKIaVCqAU6nG@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some platforms boot from SD card and don't come with calibration data
stored anywhere on the board.
As EEPROM data is rather small it can be embedded into the device tree
to be loaded from there by the mt76.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 3b47e85e95e7c..01bc42dc71c26 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -15,6 +15,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	struct device_node *np = dev->dev->of_node;
 	struct mtd_info *mtd;
 	const __be32 *list;
+	const void *data;
 	const char *part;
 	phandle phandle;
 	int size;
@@ -24,6 +25,16 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!np)
 		return -ENOENT;
 
+	data = of_get_property(np, "mediatek,eeprom-data", &size);
+	if (data) {
+		if (size > len)
+			return -EINVAL;
+
+		memcpy(eep, data, size);
+
+		return 0;
+	}
+
 	list = of_get_property(np, "mediatek,mtd-eeprom", &size);
 	if (!list)
 		return -ENOENT;
-- 
2.32.0

