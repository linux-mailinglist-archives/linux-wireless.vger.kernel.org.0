Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91059FEBC1
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKPLS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:18:27 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59110 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfKPLS0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:18:26 -0500
Received: from isengard.fritz.box (unknown [87.147.48.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id F345B58007C;
        Sat, 16 Nov 2019 12:18:24 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/4] mt76: mt76x02: ommit beacon slot clearing
Date:   Sat, 16 Nov 2019 12:17:06 +0100
Message-Id: <20191116111709.4686-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76 hw does not send beacons from beacon slots, if the corresponding
bitmask is set accordingly. Therefore we can ommit clearing the beacon
memory. Clearing uses many usb calls, if usb drivers are used. These
calls unnecessarily slow down the beacon tasklet. Thanks to Stanislaw
Gruzska for pointing this out.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 4209209ac940..54fe449f01c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -56,10 +56,6 @@ __mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 bcn_idx,
 		ret = mt76x02_write_beacon(dev, beacon_addr, skb);
 		if (!ret)
 			dev->beacon_data_mask |= BIT(bcn_idx);
-	} else {
-		dev->beacon_data_mask &= ~BIT(bcn_idx);
-		for (i = 0; i < beacon_len; i += 4)
-			mt76_wr(dev, beacon_addr + i, 0);
 	}
 
 	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xff00 | ~dev->beacon_data_mask);
@@ -241,17 +237,11 @@ EXPORT_SYMBOL_GPL(mt76x02_enqueue_buffered_bc);
 
 void mt76x02_init_beacon_config(struct mt76x02_dev *dev)
 {
-	int i;
-
 	mt76_clear(dev, MT_BEACON_TIME_CFG, (MT_BEACON_TIME_CFG_TIMER_EN |
 					     MT_BEACON_TIME_CFG_TBTT_EN |
 					     MT_BEACON_TIME_CFG_BEACON_TX));
 	mt76_set(dev, MT_BEACON_TIME_CFG, MT_BEACON_TIME_CFG_SYNC_MODE);
 	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xffff);
-
-	for (i = 0; i < 8; i++)
-		mt76x02_mac_set_beacon(dev, i, NULL);
-
 	mt76x02_set_beacon_offsets(dev);
 }
 EXPORT_SYMBOL_GPL(mt76x02_init_beacon_config);
-- 
2.24.0

