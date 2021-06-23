Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE51C3B1AF6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFWNVn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 09:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhFWNVn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 09:21:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8646D61075;
        Wed, 23 Jun 2021 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624454366;
        bh=YfMl0k0uwWCbYGg35fm16QFSPWQC8p7NnZmobKectlg=;
        h=From:To:Cc:Subject:Date:From;
        b=q/3+7i/LSRXQeydNxUep7FQPUnLU9KVw1moiqzI5X+V7ffTdN9Jkx22LoXQ3Ih4Mr
         aFpGMOrHv2R84eGJ5XJGoxq4kpCKpbRyMODdsdz1D+zMGAmGJXvj0oz/qrJfl4XWBE
         Rjg0rSSoC0UtLZDJK/I9RdwxZqdF47KcIEpAJhEjnEoQOQzTa7sV0YC24+RmO/Ihqt
         Xxw0HqCEQPlWfg47f59u918jftTkPTm+x+BUOts3WyDNqN/TbWN5g9SVjH6t1O6oXZ
         4Yxa9ChEEUOdePvVrE8ZdwfxyA9rvCmLtXF/bMCAq1m0i52qjTypIStdbS9IntwqrF
         ISlnED2aby3Dw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: fix survey-dump reporting
Date:   Wed, 23 Jun 2021 15:19:19 +0200
Message-Id: <b78d7f13a4d1257ec99eb9754b82ae55f32db000.1624453803.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix MIB tx-rx MIB counters for survey-dump reporting.

Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 08d85c6a7bc4..e9de038771a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -106,6 +106,10 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
 
+	/* enable MIB tx-rx time reporting */
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_TXDUR_EN);
+	mt76_set(dev, MT_MIB_SCR1(band), MT_MIB_RXDUR_EN);
+
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	/* disable rx rate report by default due to hw issues */
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index b6944c867a57..26fb11823762 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -96,6 +96,10 @@
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
+#define MT_MIB_SCR1(_band)		MT_WF_MIB(_band, 0x004)
+#define MT_MIB_TXDUR_EN			BIT(8)
+#define MT_MIB_RXDUR_EN			BIT(9)
+
 #define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
 #define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
 
@@ -108,9 +112,9 @@
 #define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
-#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x098)
+#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x054)
 #define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
-#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x09c)
+#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x058)
 #define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
 
 #define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
-- 
2.31.1

