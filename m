Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9712CBF7D6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfIZRrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:36 -0400
Received: from nbd.name ([46.4.11.11]:55246 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbfIZRrf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TSgSn4N1S5Ak0ccsbrJ4tsqc+OSxZr96i+Ri2FchQ3I=; b=d8POyTuvBleTc1jX3lSLRoymV9
        pHSya5ORkJJMJrzJUj/977ppoPISnvrJWeushP9V1+OUnnxcW60onBXjtw3zRUiHA//NT5cu8psza
        3jPWM5oYOuuLwEvAoNYwRAPEosRUFBwgvV4+SrnduNRyIE6KMYC+DteCobkX/NvfoOg0=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yl-A7
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B676969B6A88; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/15] mt76: mt76x02: move MT_CH_TIME_CFG init to mt76x02_mac_cc_reset
Date:   Thu, 26 Sep 2019 19:47:26 +0200
Message-Id: <20190926174732.42375-9-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduces code duplication and adds missing bits for USB variants

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      | 9 ---------
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      | 7 -------
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     | 9 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c | 9 ---------
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 7 -------
 5 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index f42450b4319c..9f224f0f7c00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -132,15 +132,6 @@ static int mt76x0e_register_device(struct mt76x02_dev *dev)
 	mt76_clear(dev, 0x110, BIT(9));
 	mt76_set(dev, MT_MAX_LEN_CFG, BIT(13));
 
-	mt76_wr(dev, MT_CH_TIME_CFG,
-		MT_CH_TIME_CFG_TIMER_EN |
-		MT_CH_TIME_CFG_TX_AS_BUSY |
-		MT_CH_TIME_CFG_RX_AS_BUSY |
-		MT_CH_TIME_CFG_NAV_AS_BUSY |
-		MT_CH_TIME_CFG_EIFS_AS_BUSY |
-		MT_CH_CCA_RC_EN |
-		FIELD_PREP(MT_CH_TIME_CFG_CH_TIMER_CLR, 1));
-
 	err = mt76x0_register_device(dev);
 	if (err < 0)
 		return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 54f9c0cc881f..259bd2a55b23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -165,13 +165,6 @@ static int mt76x0u_init_hardware(struct mt76x02_dev *dev, bool reset)
 		FIELD_PREP(MT_TXOP_TRUN_EN, 0x3f) |
 		FIELD_PREP(MT_TXOP_EXT_CCA_DLY, 0x58));
 
-	mt76_wr(dev, MT_CH_TIME_CFG,
-		MT_CH_TIME_CFG_TIMER_EN |
-		MT_CH_TIME_CFG_TX_AS_BUSY |
-		MT_CH_TIME_CFG_RX_AS_BUSY |
-		MT_CH_TIME_CFG_NAV_AS_BUSY |
-		MT_CH_TIME_CFG_EIFS_AS_BUSY);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index e49d0136adbc..d32efc0b100d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1148,6 +1148,15 @@ void mt76x02_mac_cc_reset(struct mt76x02_dev *dev)
 {
 	dev->mt76.survey_time = ktime_get_boottime();
 
+	mt76_wr(dev, MT_CH_TIME_CFG,
+		MT_CH_TIME_CFG_TIMER_EN |
+		MT_CH_TIME_CFG_TX_AS_BUSY |
+		MT_CH_TIME_CFG_RX_AS_BUSY |
+		MT_CH_TIME_CFG_NAV_AS_BUSY |
+		MT_CH_TIME_CFG_EIFS_AS_BUSY |
+		MT_CH_CCA_RC_EN |
+		FIELD_PREP(MT_CH_TIME_CFG_CH_TIMER_CLR, 1));
+
 	/* channel cycle counters read-and-clear */
 	mt76_rr(dev, MT_CH_BUSY);
 	mt76_rr(dev, MT_CH_IDLE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 3cf54963854a..33fcec9179b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -133,15 +133,6 @@ int mt76x2_mac_reset(struct mt76x02_dev *dev, bool hard)
 	for (i = 0; i < 16; i++)
 		mt76_rr(dev, MT_TX_STAT_FIFO);
 
-	mt76_wr(dev, MT_CH_TIME_CFG,
-		MT_CH_TIME_CFG_TIMER_EN |
-		MT_CH_TIME_CFG_TX_AS_BUSY |
-		MT_CH_TIME_CFG_RX_AS_BUSY |
-		MT_CH_TIME_CFG_NAV_AS_BUSY |
-		MT_CH_TIME_CFG_EIFS_AS_BUSY |
-		MT_CH_CCA_RC_EN |
-		FIELD_PREP(MT_CH_TIME_CFG_CH_TIMER_CLR, 1));
-
 	mt76x02_set_tx_ackto(dev);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index e305b374c904..2910068f4e79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -184,13 +184,6 @@ int mt76x2u_init_hardware(struct mt76x02_dev *dev)
 	mt76x02_phy_set_rxpath(dev);
 	mt76x02_phy_set_txdac(dev);
 
-	mt76_wr(dev, MT_CH_TIME_CFG,
-		MT_CH_TIME_CFG_TIMER_EN |
-		MT_CH_TIME_CFG_TX_AS_BUSY |
-		MT_CH_TIME_CFG_RX_AS_BUSY |
-		MT_CH_TIME_CFG_NAV_AS_BUSY |
-		MT_CH_TIME_CFG_EIFS_AS_BUSY);
-
 	return mt76x2u_mac_stop(dev);
 }
 
-- 
2.17.0

