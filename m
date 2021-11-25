Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AA45E0CE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbhKYTEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhKYTCX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:02:23 -0500
X-Greylist: delayed 1334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Nov 2021 10:59:12 PST
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64302C061746
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 10:59:12 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mqJc4-00026U-4x; Thu, 25 Nov 2021 19:36:52 +0100
Date:   Thu, 25 Nov 2021 18:36:45 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] mt76: eeprom: tolerate corrected bit-flips
Message-ID: <YZ/XvfwzqUyjmBCm@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mtd_read() returns -EUCLEAN in case of corrected bit-flips.
As data was read, don't error out in this case.

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 2d58aa31db934..0eb98f7ff7ec0 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -65,7 +65,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	offset = be32_to_cpup(list);
 	ret = mtd_read(mtd, offset, len, &retlen, eep);
 	put_mtd_device(mtd);
-	if (ret) {
+	if (ret && !mtd_is_bitflip(err)) {
 		dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\n",
 			part, ret);
 		goto out_put_node;
-- 
2.34.0

