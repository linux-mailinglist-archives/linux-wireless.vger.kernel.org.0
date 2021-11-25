Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4C45E12B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbhKYTwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbhKYTub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:50:31 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FCC061799
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 11:45:12 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1mqKgA-0002NO-5q; Thu, 25 Nov 2021 20:45:10 +0100
Date:   Thu, 25 Nov 2021 19:45:03 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2] mt76: eeprom: tolerate corrected bit-flips
Message-ID: <YZ/nv74JH/uQwpBt@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mtd_read() returns -EUCLEAN in case of corrected bit-flips.
As data was read, don't error out in this case.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: fix wrong variable name

 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 2d58aa31db934..4a5d14473ddc4 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -65,7 +65,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	offset = be32_to_cpup(list);
 	ret = mtd_read(mtd, offset, len, &retlen, eep);
 	put_mtd_device(mtd);
-	if (ret) {
+	if (ret && !mtd_is_bitflip(ret)) {
 		dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\n",
 			part, ret);
 		goto out_put_node;
-- 
2.34.0

