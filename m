Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA4124CC3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLRQI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 11:08:56 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51434 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfLRQI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 11:08:56 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4D90058007C;
        Wed, 18 Dec 2019 17:08:52 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>, kvalo@codeaurora.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v10 5/6] mt76: speed up usb bulk copy
Date:   Wed, 18 Dec 2019 17:07:53 +0100
Message-Id: <20191218160754.24111-6-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
References: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use larger batches for usb copy to speed this operation up. Otherwise it
would be too slow for copying new beacons or broadcast frames over usb.
Assure, that always a multiple of 4 Bytes is copied, as outlined in
850e8f6fbd "mt76: round up length on mt76_wr_copy" from Felix Fietkau.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c  | 24 +++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6109a6e95a73..d6f27131c6f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -384,7 +384,7 @@ enum mt76u_out_ep {
 struct mt76_usb {
 	struct mutex usb_ctrl_mtx;
 	union {
-		u8 data[32];
+		u8 data[128];
 		__le32 reg_val;
 	};
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d6d47081e281..97b263ce3872 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -149,18 +149,30 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 		       const void *data, int len)
 {
 	struct mt76_usb *usb = &dev->usb;
-	const u32 *val = data;
-	int i, ret;
+	const u8 *val = data;
+	int ret;
+	int current_batch_size;
+	int i = 0;
+
+	/* Assure that always a multiple of 4 bytes are copied,
+	 * otherwise beacons can be corrupted.
+	 * See: "mt76: round up length on mt76_wr_copy"
+	 * Commit 850e8f6fbd5d0003b0
+	 */
+	len = round_up(len, 4);
 
 	mutex_lock(&usb->usb_ctrl_mtx);
-	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned(val[i], (u32 *)usb->data);
+	while (i < len) {
+		current_batch_size = min_t(int, sizeof(usb->data), len - i);
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
2.24.1

