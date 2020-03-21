Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AE18E252
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2020 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCUPOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Mar 2020 11:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgCUPOw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Mar 2020 11:14:52 -0400
Received: from localhost.localdomain (unknown [151.48.139.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB3A20409;
        Sat, 21 Mar 2020 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584803692;
        bh=Jgs2IKu8wCZxhbCjpPKEoex9MwTGh097SHWHgFKyZK0=;
        h=From:To:Cc:Subject:Date:From;
        b=ol1aSsqaAiQlwQ2o60yMe20YFheThCJ72819wtA8rwEg9T/HGXFrrPhW/fgkguom+
         OI/o+jPT1iQlsIBuAC2fZJ3VBfbhYwaLCpgTFj26kuFgLNRQKuIEKP5YskY7zl1vth
         fPTW97xIv6qbjI347YXqHkSOIJJE3X34drg3IdWs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x2u: introduce Mercury UD13 support
Date:   Sat, 21 Mar 2020 16:14:42 +0100
Message-Id: <af2ea4a6881ca91c03320976e61e875bcb5cb46f.1584803570.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce Mercury UD13 dual-band dongle support to mt76x2u driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index eafa283ca699..7be7fe7a068b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -16,6 +16,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0e8d, 0x7612) },	/* Aukey USBAC1200 - Alfa AWUS036ACM */
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
+	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ },
-- 
2.25.1

