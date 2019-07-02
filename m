Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D655D260
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBPGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 11:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfGBPGP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 11:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D640A87630;
        Tue,  2 Jul 2019 15:06:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA831001B18;
        Tue,  2 Jul 2019 15:06:07 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 1/3] mt76: usb: fix endian in mt76u_copy
Date:   Tue,  2 Jul 2019 17:05:59 +0200
Message-Id: <1562079961-15527-2-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 15:06:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In contrast to mt76_wr() which we use to program registers,
on mt76_wr_copy() we should not change endian of the data.

Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 87ecbe290f99..db90ec6b8775 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -165,11 +165,11 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
 
 	mutex_lock(&usb->usb_ctrl_mtx);
 	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
-		put_unaligned_le32(val[i], usb->data);
+		put_unaligned(val[i], usb->data);
 		ret = __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
 					     USB_DIR_OUT | USB_TYPE_VENDOR,
 					     0, offset + i * 4, usb->data,
-					     sizeof(__le32));
+					     sizeof(u32));
 		if (ret < 0)
 			break;
 	}
-- 
1.9.3

