Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3C4DCBDA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 17:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiCQQ5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCQQ5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 12:57:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934DE19EC5D
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 09:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 414DCB81F3B
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 16:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B03C340E9;
        Thu, 17 Mar 2022 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647536173;
        bh=kBBByNMLrkjCMdd2lU+nQrX8EsLYhXWFLHlmHOqlLXE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ikx0ixPQ6BUL6//q62UnWjAKTULspF9Jis1U6V0fxRm33YNrjCMRwBRyE98Enklbg
         YEwloDoSsa8qQMdjt5mYGeG5In5hlWguokg5IM7O5TFXmhzcUvtVwDk1Yenahh2h/N
         Lvpye6K7HwTid96b6qDVJaH7+UNhc1yDXdAVIvjqfGoHFOedB+uJlczFioRCrw9U20
         1RdFXR3Vr37/AJSEnkzx8rPzfbLhbKantkbu7cVRBqli8mKAk2j4oGaTEpZsUG6y1A
         CqiGFPTxDmtO2n+ve5WeUFDhke14ieCRud2QDdmR4ogSsYR7vF0W/4iFytka4G4+7K
         NeCiynVn2QYPQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7921u: add suspend/resume support
Date:   Thu, 17 Mar 2022 17:55:59 +0100
Message-Id: <f07e7ab403b3b72e6c1f72046a90026b398c179f.1647536048.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce suspend/resume callbacks for mt7921u driver.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  5 ++
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 62 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  7 ++-
 4 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 7690364bc079..459226c5bb11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -467,7 +467,7 @@ bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 
 int mt7921u_mcu_power_on(struct mt7921_dev *dev);
 int mt7921u_wfsys_reset(struct mt7921_dev *dev);
-int mt7921u_dma_init(struct mt7921_dev *dev);
+int mt7921u_dma_init(struct mt7921_dev *dev, bool resume);
 int mt7921u_init_reset(struct mt7921_dev *dev);
 int mt7921u_mac_reset(struct mt7921_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 6712ff60c722..ea643260ceb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -516,4 +516,9 @@
 #define MT_TOP_MISC2_FW_PWR_ON		BIT(0)
 #define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
 
+#define MT_WF_SW_DEF_CR(ofs)		(0x401a00 + (ofs))
+#define MT_WF_SW_DEF_CR_USB_MCU_EVENT	MT_WF_SW_DEF_CR(0x028)
+#define MT_WF_SW_SER_TRIGGER_SUSPEND	BIT(6)
+#define MT_WF_SW_SER_DONE_SUSPEND	BIT(7)
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index b7771e9f1fcd..dc38baef273a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -246,7 +246,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	if (ret)
 		goto error;
 
-	ret = mt7921u_dma_init(dev);
+	ret = mt7921u_dma_init(dev, false);
 	if (ret)
 		return ret;
 
@@ -288,6 +288,61 @@ static void mt7921u_disconnect(struct usb_interface *usb_intf)
 	mt76_free_device(&dev->mt76);
 }
 
+#ifdef CONFIG_PM
+static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
+{
+	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	int err;
+
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
+	if (err)
+		return err;
+
+	mt76u_stop_rx(&dev->mt76);
+	mt76u_stop_tx(&dev->mt76);
+
+	set_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
+
+	return 0;
+}
+
+static int mt7921u_resume(struct usb_interface *intf)
+{
+	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	bool reinit = true;
+	int err, i;
+
+	for (i = 0; i < 10; i++) {
+		u32 val = mt76_rr(dev, MT_WF_SW_DEF_CR_USB_MCU_EVENT);
+
+		if (!(val & MT_WF_SW_SER_TRIGGER_SUSPEND)) {
+			reinit = false;
+			break;
+		}
+		if (val & MT_WF_SW_SER_DONE_SUSPEND) {
+			mt76_wr(dev, MT_WF_SW_DEF_CR_USB_MCU_EVENT, 0);
+			break;
+		}
+
+		msleep(20);
+	}
+
+	if (reinit || mt7921_dma_need_reinit(dev)) {
+		err = mt7921u_dma_init(dev, true);
+		if (err)
+			return err;
+	}
+
+	clear_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
+
+	err = mt76u_resume_rx(&dev->mt76);
+	if (err < 0)
+		return err;
+
+	return mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+}
+#endif /* CONFIG_PM */
+
 MODULE_DEVICE_TABLE(usb, mt7921u_device_table);
 MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7921_ROM_PATCH);
@@ -297,6 +352,11 @@ static struct usb_driver mt7921u_driver = {
 	.id_table	= mt7921u_device_table,
 	.probe		= mt7921u_probe,
 	.disconnect	= mt7921u_disconnect,
+#ifdef CONFIG_PM
+	.suspend	= mt7921u_suspend,
+	.resume		= mt7921u_resume,
+	.reset_resume	= mt7921u_resume,
+#endif /* CONFIG_PM */
 	.soft_unbind	= 1,
 	.disable_hub_initiated_lpm = 1,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
index 99bcbd858b65..cd2f09743d2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -121,7 +121,7 @@ static void mt7921u_epctl_rst_opt(struct mt7921_dev *dev, bool reset)
 	mt7921u_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
-int mt7921u_dma_init(struct mt7921_dev *dev)
+int mt7921u_dma_init(struct mt7921_dev *dev, bool resume)
 {
 	int err;
 
@@ -136,6 +136,9 @@ int mt7921u_dma_init(struct mt7921_dev *dev)
 		   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
 	mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
 
+	if (resume)
+		return 0;
+
 	err = mt7921u_dma_rx_evt_ep4(dev);
 	if (err)
 		return err;
@@ -221,7 +224,7 @@ int mt7921u_mac_reset(struct mt7921_dev *dev)
 	if (err)
 		goto out;
 
-	err = mt7921u_dma_init(dev);
+	err = mt7921u_dma_init(dev, false);
 	if (err)
 		goto out;
 
-- 
2.35.1

