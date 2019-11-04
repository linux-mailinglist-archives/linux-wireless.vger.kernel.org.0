Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA1EE30B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfKDPDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 10:03:49 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36268 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDPDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 10:03:48 -0500
Received: from thunderstorm.prakinf.tu-ilmenau.de (thunderstorm.prakinf.tu-ilmenau.de [141.24.212.108])
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPA id 419A4580068;
        Mon,  4 Nov 2019 16:03:47 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: mt76x02: fix num slots in beacon config init
Date:   Mon,  4 Nov 2019 16:03:41 +0100
Message-Id: <20191104150341.13896-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76x02 mmio and usb devices use a different number of beacon slots (8
vs. 5). Consider this in mt76x02_init_beacon_config.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 4209209ac940..b7412953ff26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -249,7 +249,7 @@ void mt76x02_init_beacon_config(struct mt76x02_dev *dev)
 	mt76_set(dev, MT_BEACON_TIME_CFG, MT_BEACON_TIME_CFG_SYNC_MODE);
 	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xffff);
 
-	for (i = 0; i < 8; i++)
+	for (i = 0; i < dev->beacon_ops->nslots; i++)
 		mt76x02_mac_set_beacon(dev, i, NULL);
 
 	mt76x02_set_beacon_offsets(dev);
-- 
2.17.1

