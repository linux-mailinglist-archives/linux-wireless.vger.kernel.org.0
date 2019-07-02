Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB75D25E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfGBPGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 11:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfGBPGN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 11:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 484303082EF1;
        Tue,  2 Jul 2019 15:06:13 +0000 (UTC)
Received: from localhost (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E419F1750A;
        Tue,  2 Jul 2019 15:06:11 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 2/3] mt76: usb: remove unneeded {put,get}_unaligned
Date:   Tue,  2 Jul 2019 17:06:00 +0200
Message-Id: <1562079961-15527-3-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 15:06:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Compiler give us guaranties on variables alignment, so use
an variable as buffer when read/write registers and remove
unneeded {put,get}_unaligned.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 5 ++++-
 drivers/net/wireless/mediatek/mt76/usb.c  | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 56bf93a8988e..094e6e543542 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -389,7 +389,10 @@ enum mt76u_out_ep {
 #define MCU_RESP_URB_SIZE	1024
 struct mt76_usb {
 	struct mutex usb_ctrl_mtx;
-	u8 data[32];
+	union {
+		u8 data[32];
+		__le32 reg_val;
+	};
 
 	struct tasklet_struct rx_tasklet;
 	struct delayed_work stat_work;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index db90ec6b8775..a61bb8171557 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -95,9 +95,9 @@ static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
 
 	ret = __mt76u_vendor_request(dev, req,
 				     USB_DIR_IN | USB_TYPE_VENDOR,
-				     0, offset, usb->data, sizeof(__le32));
+				     0, offset, &usb->reg_val, sizeof(__le32));
 	if (ret == sizeof(__le32))
-		data = get_unaligned_le32(usb->data);
+		data = le32_to_cpu(usb->reg_val);
 	trace_usb_reg_rr(dev, addr, data);
 
 	return data;
@@ -131,10 +131,10 @@ static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 	}
 	offset = addr & ~MT_VEND_TYPE_MASK;
 
-	put_unaligned_le32(val, usb->data);
+	usb->reg_val = cpu_to_le32(val);
 	__mt76u_vendor_request(dev, req,
 			       USB_DIR_OUT | USB_TYPE_VENDOR, 0,
-			       offset, usb->data, sizeof(__le32));
+			       offset, &usb->reg_val, sizeof(__le32));
 	trace_usb_reg_wr(dev, addr, val);
 }
 
-- 
1.9.3

