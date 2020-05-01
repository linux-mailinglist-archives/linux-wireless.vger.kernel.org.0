Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED51C10E7
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgEAKgn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKgn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:43 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62338206B8;
        Fri,  1 May 2020 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329402;
        bh=xx8u5L1X+0NoyS147oh30fBvdi8e0a66RQ09atUkKBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGhxLAnaZWnoEM+5KA0kGO61+eFMOCk1j/UDyBuwHPAq4CNjDnb34vcnZAaJY259y
         1p50LqjZwn4XEoWI2n26Jtf8wjlc3PF8Nuz8DFwp02kz02r2n5iD+OUe84y1i6wNun
         h65/GMS8Q32XzSR69KhzHUnfsKp5FJgoQr916nNo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 4/7] mt76: mt7663u: introduce suspend/resume to mt7663u
Date:   Fri,  1 May 2020 12:36:14 +0200
Message-Id: <1f86bd7a7db73139504571065a87c986d888796d.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Tested on Chromebok by "echo mem to /sys/power/state" to suspend and
then waked up by keyboard keystrokes to resume system.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 43 ++++++++++++++++---
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f1c9116b6ab4..728a2fb8b14d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -381,6 +381,7 @@ enum mt_vendor_req {
 	MT_VEND_READ_CFG =	0x47,
 	MT_VEND_READ_EXT =	0x63,
 	MT_VEND_WRITE_EXT =	0x66,
+	MT_VEND_FEATURE_SET =	0x91,
 };
 
 enum mt76u_in_ep {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 9353175b139b..5ed83500541c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -372,17 +372,48 @@ static void mt7663u_disconnect(struct usb_interface *usb_intf)
 	ieee80211_free_hw(dev->mt76.hw);
 }
 
-static int __maybe_unused
-mt7663u_suspend(struct usb_interface *intf,
-		pm_message_t state)
+static int __maybe_unused mt7663u_suspend(struct usb_interface *intf,
+					  pm_message_t state)
 {
+	struct mt7615_dev *dev = usb_get_intfdata(intf);
+
+	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
+	    mt7615_firmware_offload(dev)) {
+		int err;
+
+		err = mt7615_mcu_set_hif_suspend(dev, true);
+		if (err < 0)
+			return err;
+	}
+
+	mt76u_stop_rx(&dev->mt76);
+
+	mt76u_stop_tx(&dev->mt76);
+	tasklet_kill(&dev->mt76.tx_tasklet);
+
 	return 0;
 }
 
-static int __maybe_unused
-mt7663u_resume(struct usb_interface *intf)
+static int __maybe_unused mt7663u_resume(struct usb_interface *intf)
 {
-	return 0;
+	struct mt7615_dev *dev = usb_get_intfdata(intf);
+	int err;
+
+	err = mt76u_vendor_request(&dev->mt76, MT_VEND_FEATURE_SET,
+				   USB_DIR_OUT | USB_TYPE_VENDOR,
+				   0x5, 0x0, NULL, 0);
+	if (err)
+		return err;
+
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err < 0)
+		return err;
+
+	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
+	    mt7615_firmware_offload(dev))
+		err = mt7615_mcu_set_hif_suspend(dev, false);
+
+	return err;
 }
 
 MODULE_DEVICE_TABLE(usb, mt7615_device_table);
-- 
2.25.4

