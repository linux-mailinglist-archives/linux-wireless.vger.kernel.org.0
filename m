Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B34C7930
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiB1TxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 14:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiB1TxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 14:53:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C203FDB4
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 11:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36EEAB8162C
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 19:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9960C340F1;
        Mon, 28 Feb 2022 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646077414;
        bh=UMEyIoOxoDoUxxCiGRer02tCBhA6J3ZXE5lS18bcLDo=;
        h=From:To:Cc:Subject:Date:From;
        b=qJxeDrPepzfcWaqbfXD2eB4hIwQf47i0sUlyPZjDO52d5NV+h3iv1Q29ePzyPHquY
         x+WM7lYm5Jwn8KqsIx+disU3NLA08Q6Pb0hhsZhkAcaz1O9f2ATa2FJVWXywHNEzAq
         /7U2GqPlZrjla5UnN2qSley917nYlUT4z/xdrQfzuVhjlU/RPHKvaJJ1xLMmFbz+jr
         kpYWsP1/qcRRdr9JdBxUV5aKfbascqVQPXx3//TEN78yHVt8FeFVWSHiSdek1KvIUt
         IrzL5C1SEEdWVTfC9ftRmt6+kAnnbSQVDODh1Jlygdl40m/umFCEgzthzgQwswI3Gv
         jh7nfvCzHLutg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7663u: introduce mt7663u_mcu_power_on routine
Date:   Mon, 28 Feb 2022 20:43:23 +0100
Message-Id: <ce24cf02240e26747ffda25982973111eb77ef26.1646077376.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7663u_mcu_power_on utility routine since the code is shared
between mt7663u_mcu_init() and mt7663u_probe().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 22 +++----------
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   | 31 +++++++++++++------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 600fa2be4da0..2e91f6a27d0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -559,6 +559,7 @@ void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 				     struct mt76_queue_entry *e);
 int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
+int mt7663u_mcu_power_on(struct mt7615_dev *dev);
 
 /* sdio */
 int mt7663s_mcu_init(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 5cad398abf63..aeeba7c72f14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -100,27 +100,15 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	if (mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
-			   FW_STATE_PWR_ON << 1, 500)) {
-		dev_dbg(dev->mt76.dev, "Usb device already powered on\n");
-		set_bit(MT76_STATE_POWER_OFF, &dev->mphy.state);
-		goto alloc_queues;
-	}
-
-	ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
-				   USB_DIR_OUT | USB_TYPE_VENDOR,
-				   0x0, 0x1, NULL, 0);
-	if (ret)
-		goto error;
-
 	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
 			    FW_STATE_PWR_ON << 1, 500)) {
-		dev_err(dev->mt76.dev, "Timeout for power on\n");
-		ret = -EIO;
-		goto error;
+		ret = mt7663u_mcu_power_on(dev);
+		if (ret)
+			goto error;
+	} else {
+		set_bit(MT76_STATE_POWER_OFF, &dev->mphy.state);
 	}
 
-alloc_queues:
 	ret = mt76u_alloc_mcu_queue(&dev->mt76);
 	if (ret)
 		goto error;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index b560d0db6a92..98bf2f6ae936 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -42,6 +42,26 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
+int mt7663u_mcu_power_on(struct mt7615_dev *dev)
+{
+	int ret;
+
+	ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
+				   USB_DIR_OUT | USB_TYPE_VENDOR,
+				   0x0, 0x1, NULL, 0);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
+			    MT_TOP_MISC2_FW_PWR_ON,
+			    FW_STATE_PWR_ON << 1, 500)) {
+		dev_err(dev->mt76.dev, "Timeout for power on\n");
+		ret = -EIO;
+	}
+
+	return 0;
+}
+
 int mt7663u_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7663u_mcu_ops = {
@@ -65,18 +85,9 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 				    MT_TOP_MISC2_FW_PWR_ON, 0, 500))
 			return -EIO;
 
-		ret = mt76u_vendor_request(&dev->mt76, MT_VEND_POWER_ON,
-					   USB_DIR_OUT | USB_TYPE_VENDOR,
-					   0x0, 0x1, NULL, 0);
+		ret = mt7663u_mcu_power_on(dev);
 		if (ret)
 			return ret;
-
-		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
-				    MT_TOP_MISC2_FW_PWR_ON,
-				    FW_STATE_PWR_ON << 1, 500)) {
-			dev_err(dev->mt76.dev, "Timeout for power on\n");
-			return -EIO;
-		}
 	}
 
 	ret = __mt7663_load_firmware(dev);
-- 
2.35.1

