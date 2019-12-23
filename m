Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410EF12963A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLWNDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 08:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfLWNDo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 08:03:44 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FD0206CB;
        Mon, 23 Dec 2019 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577106223;
        bh=WlrptsVcJSucGF3/RpaEbFaVPWaDeDbY2xmrpPU8Eo4=;
        h=From:To:Cc:Subject:Date:From;
        b=b9scGGAqy+p4Wa1CsSpeO35E5yJ33HMofcoZqg6pxTF8nzPYzg8xOPdlqmL0umCgH
         IrNT8tErAuL/XRph91ytzIpHEI5+II1LnnxozgQwf0nLsEjEy9GIMkhrEeojvMQGkU
         UM0nmp24AH6vZ3aEFry1vPfYZLybFyN8E/VBVhm0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76x02u: avoid overwrite max_tx_fragments
Date:   Mon, 23 Dec 2019 14:03:32 +0100
Message-Id: <3dd971ebf46f9c4e1151461b67a419cbb7370415.1577106053.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Starting from 'commit ee8040139ab1 ("mt76: do not overwrite
max_tx_fragments if it has been set")' we can avoid overwriting
max_tx_fragments for mt76x02u devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      | 8 ++------
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 8 ++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index abf0a19ee70e..68a00795c91e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -182,16 +182,12 @@ static int mt76x0u_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		goto out_err;
 
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
 	err = mt76x0_register_device(dev);
 	if (err < 0)
 		goto out_err;
 
-	/* check hw sg support in order to enable AMSDU */
-	if (dev->mt76.usb.sg_en)
-		hw->max_tx_fragments = MT_TX_SG_MAX_SIZE;
-	else
-		hw->max_tx_fragments = 1;
-
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 62e5e89baf23..d2ca8fe42655 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -207,17 +207,13 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		goto fail;
 
+	/* check hw sg support in order to enable AMSDU */
+	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
 	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
 				   ARRAY_SIZE(mt76x02_rates));
 	if (err)
 		goto fail;
 
-	/* check hw sg support in order to enable AMSDU */
-	if (dev->mt76.usb.sg_en)
-		hw->max_tx_fragments = MT_TX_SG_MAX_SIZE;
-	else
-		hw->max_tx_fragments = 1;
-
 	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	mt76x02_init_debugfs(dev);
-- 
2.21.0

