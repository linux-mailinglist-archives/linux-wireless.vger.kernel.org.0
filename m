Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58C100468
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 12:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRLj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 06:39:58 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:37322 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfKRLj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 06:39:57 -0500
Received: from localhost.localdomain (unknown [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BE63958007C;
        Mon, 18 Nov 2019 12:39:54 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v2 3/4] mt76: speed up usb bulk copy
Date:   Mon, 18 Nov 2019 12:39:06 +0100
Message-Id: <20191118113907.9862-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118113907.9862-1-markus.theil@tu-ilmenau.de>
References: <20191118113907.9862-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use larger batches for usb copy to speed this operation up. Otherwise it
would be too slow for copying new beacons or broadcast frames over usb.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c |  1 -
 drivers/net/wireless/mediatek/mt76/usb.c        | 17 +++++++++++------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8aec7ccf2d79..7a6f5d097a3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -383,7 +383,7 @@ enum mt76u_out_ep {
 struct mt76_usb {
 	struct mutex usb_ctrl_mtx;
 	union {
-		u8 data[32];
+		u8 data[128];
 		__le32 reg_val;
 	};
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index faa6de6914a3..873c8323bb70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -81,7 +81,6 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 	dev->beacons[vif_idx] = skb;
 	__mt76x02_mac_set_beacon(dev, vif_idx, skb);
 
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 20c6fe510e9d..382004128897 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -149,18 +149,23 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 		       const void *data, int len)
 {
 	struct mt76_usb *usb = &dev->usb;
-	const u32 *val = data;
-	int i, ret;
+	const u8 *val = data;
+	int ret;
+	int current_batch_size;
+	int i = 0;
 
 	mutex_lock(&usb->usb_ctrl_mtx);
-	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned(val[i], (u32 *)usb->data);
+	while (i < len) {
+		current_batch_size = min(sizeof(usb->data), len - i);
+		memcpy(usb->data, val + i, current_batch_size);
 		ret = __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 					     USB_DIR_OUT | USB_TYPE_VENDOR,
-					     0, offset + i * 4, usb->data,
-					     sizeof(u32));
+					     0, offset + i, usb->data,
+					     current_batch_size);
 		if (ret < 0)
 			break;
+
+		i += current_batch_size;
 	}
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
-- 
2.24.0

