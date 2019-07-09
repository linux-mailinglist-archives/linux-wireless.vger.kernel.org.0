Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76C6386E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGIPPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 11:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPPE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 11:15:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 467262EED00;
        Tue,  9 Jul 2019 15:15:04 +0000 (UTC)
Received: from localhost (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3628871C3;
        Tue,  9 Jul 2019 15:15:03 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH v2 2/2] mt76: usb: remove unneeded {put,get}_unaligned
Date:   Tue,  9 Jul 2019 17:14:55 +0200
Message-Id: <20190709151455.24003-3-sgruszka@redhat.com>
In-Reply-To: <20190709151455.24003-1-sgruszka@redhat.com>
References: <20190709151455.24003-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 09 Jul 2019 15:15:04 +0000 (UTC)
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
index 828939e78a3b..00069c2536f8 100644
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
2.20.1

