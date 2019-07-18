Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064BC6CCE2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGRKiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 06:38:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfGRKiP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 06:38:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61F4A3084295;
        Thu, 18 Jul 2019 10:38:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB5D36012C;
        Thu, 18 Jul 2019 10:38:12 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH 5.3] mt76: mt76x0u: do not reset radio on resume
Date:   Thu, 18 Jul 2019 12:38:10 +0200
Message-Id: <1563446290-2813-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 18 Jul 2019 10:38:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On some machines mt76x0u firmware can hung during resume,
what result on messages like below:

[  475.480062] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  475.990066] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
[  475.990075] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  476.500003] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
[  476.500012] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  477.010046] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
[  477.010055] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  477.529997] mt76x0 1-8:1.0: Error: send MCU cmd failed:-110
[  477.530006] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  477.824907] mt76x0 1-8:1.0: Error: send MCU cmd failed:-71
[  477.824916] mt76x0 1-8:1.0: Error: MCU response pre-completed!
[  477.825029] usb 1-8: USB disconnect, device number 6

and possible whole system freeze.

This can be avoided, if we do not perform mt76x0_chip_onoff() reset.

Cc: stable@vger.kernel.org
Fixes: 134b2d0d1fcf ("mt76x0: init files")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 627ed1fc7b15..645f4d15fb61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -136,11 +136,11 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 	.release_buffered_frames = mt76_release_buffered_frames,
 };
 
-static int mt76x0u_init_hardware(struct mt76x02_dev *dev)
+static int mt76x0u_init_hardware(struct mt76x02_dev *dev, bool reset)
 {
 	int err;
 
-	mt76x0_chip_onoff(dev, true, true);
+	mt76x0_chip_onoff(dev, true, reset);
 
 	if (!mt76x02_wait_for_mac(&dev->mt76))
 		return -ETIMEDOUT;
@@ -173,7 +173,7 @@ static int mt76x0u_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		goto out_err;
 
-	err = mt76x0u_init_hardware(dev);
+	err = mt76x0u_init_hardware(dev, true);
 	if (err < 0)
 		goto out_err;
 
@@ -309,7 +309,7 @@ static int __maybe_unused mt76x0_resume(struct usb_interface *usb_intf)
 	if (ret < 0)
 		goto err;
 
-	ret = mt76x0u_init_hardware(dev);
+	ret = mt76x0u_init_hardware(dev, false);
 	if (ret)
 		goto err;
 
-- 
1.9.3

