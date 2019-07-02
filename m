Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688545D25F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGBPGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 11:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfGBPGO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 11:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AED982F8BCC;
        Tue,  2 Jul 2019 15:06:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54F77608BA;
        Tue,  2 Jul 2019 15:06:14 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 3/3] mt76: usb: use full intermediate buffer in mt76u_copy
Date:   Tue,  2 Jul 2019 17:06:01 +0200
Message-Id: <1562079961-15527-4-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 15:06:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of use several 4 bytes usb requests, use full 32 bytes buffer
to copy data to device. With the change we use less requests and copy
exact data size to the device regardless size is multiple of 4 or not.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a61bb8171557..7c564cc68c7c 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -160,19 +160,24 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 		       const void *data, int len)
 {
 	struct mt76_usb *usb = &dev->usb;
-	const u32 *val = data;
-	int i, ret;
+	int ret, req_len;
 
 	mutex_lock(&usb->usb_ctrl_mtx);
-	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned(val[i], usb->data);
+	do {
+		req_len = min_t(int, len, sizeof(usb->data));
+
+		memcpy(usb->data, data, req_len);
+
 		ret = __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 					     USB_DIR_OUT | USB_TYPE_VENDOR,
-					     0, offset + i * 4, usb->data,
-					     sizeof(u32));
+					     0, offset, usb->data, req_len);
 		if (ret < 0)
 			break;
-	}
+
+		data += req_len;
+		offset += req_len;
+		len -= req_len;
+	} while (len > 0);
 	mutex_unlock(&usb->usb_ctrl_mtx);
 }
 
-- 
1.9.3

