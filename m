Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3462F26E20E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIQRSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 13:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIQRSm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 13:18:42 -0400
Received: from lore-desk.redhat.com (unknown [151.66.80.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1984221EC;
        Thu, 17 Sep 2020 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600363120;
        bh=M0g03Jk8PcGnHHfPnlJpFByNV6Nnt8ajf1Aq7Il51DY=;
        h=From:To:Cc:Subject:Date:From;
        b=XFksq00InABAiwMDbrLhtrB3DPQqz8W85Ev0LsRU0UxgWTqkI0zjIeaDEWQ7sX8vy
         0tpE068NMh9lckUuLd5pWwxJ1QNWH98BMhmv26zxhkQ0iiv5QojTt2N8jh6E8RdBX4
         xknjITnmt77znVCsJagXKcq/pcuDliPRpmcOsH0k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663s: remove max_tx_fragments limitation
Date:   Thu, 17 Sep 2020 19:18:22 +0200
Message-Id: <d53480062911ac119ec4e91fe06b27c0b0d6c7dd.1600362639.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove A-MSDU max_tx_fragments constraint for sdio since the check is
already performed in mt7663s_tx_run_queue routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c    | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index c24f26499537..3b29a6d3dc64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -365,14 +365,15 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev)
 	if (err)
 		return err;
 
-	/* check hw sg support in order to enable AMSDU */
-	if (dev->mt76.usb.sg_en || mt76_is_sdio(&dev->mt76))
-		hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
-	else
-		hw->max_tx_fragments = 1;
 	hw->extra_tx_headroom += MT_USB_TXD_SIZE;
-	if (mt76_is_usb(&dev->mt76))
+	if (mt76_is_usb(&dev->mt76)) {
 		hw->extra_tx_headroom += MT_USB_HDR_SIZE;
+		/* check hw sg support in order to enable AMSDU */
+		if (dev->mt76.usb.sg_en)
+			hw->max_tx_fragments = MT_HW_TXP_MAX_BUF_NUM;
+		else
+			hw->max_tx_fragments = 1;
+	}
 
 	err = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
-- 
2.26.2

