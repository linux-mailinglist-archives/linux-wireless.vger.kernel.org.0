Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8E6CB5B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfGRJAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 05:00:18 -0400
Received: from nbd.name ([46.4.11.11]:36044 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRJAS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 05:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i19wCCIEB6zWpPD7x1ZyJASWqwoz2UvHp25FT5g7JZk=; b=WkOlnDLkdYMDQYCIAue4X5wA/4
        3ycZDvlnEV6gbJjlZ1flS3I/xh1IVDkFp1ZM+ed1qbD6otrGBqoGGGC6JkvJEU1UgzWFtVPTAfA/I
        kEdCLxdANNPKOmPQrDHUDQnd6gq0xs9EknbaaRzgYLYEB+3gfGVBR2ihJH9J3qZDWe8w=;
Received: from p54ae9abd.dip0.t-ipconnect.de ([84.174.154.189] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ho2Gv-000446-EA
        for linux-wireless@vger.kernel.org; Thu, 18 Jul 2019 11:00:17 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B2890624FD56; Thu, 18 Jul 2019 11:00:16 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: add missing register initialization
Date:   Thu, 18 Jul 2019 11:00:16 +0200
Message-Id: <20190718090016.34634-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- initialize CCA signal source
- initialize clock for band 1 (7615D)
- initialize BAR rate

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 22 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 13 +++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 280db9445d94..be144e13fe4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -20,10 +20,24 @@ static void mt7615_phy_init(struct mt7615_dev *dev)
 
 static void mt7615_mac_init(struct mt7615_dev *dev)
 {
-	/* enable band 0 clk */
-	mt76_rmw(dev, MT_CFG_CCR,
-		 MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN,
-		 MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN);
+	u32 val;
+
+	/* enable band 0/1 clk */
+	mt76_set(dev, MT_CFG_CCR,
+		 MT_CFG_CCR_MAC_D0_1X_GC_EN | MT_CFG_CCR_MAC_D0_2X_GC_EN |
+		 MT_CFG_CCR_MAC_D1_1X_GC_EN | MT_CFG_CCR_MAC_D1_2X_GC_EN);
+
+	val = mt76_rmw(dev, MT_TMAC_TRCR0,
+		       MT_TMAC_TRCR_CCA_SEL | MT_TMAC_TRCR_SEC_CCA_SEL,
+		       FIELD_PREP(MT_TMAC_TRCR_CCA_SEL, 2) |
+		       FIELD_PREP(MT_TMAC_TRCR_SEC_CCA_SEL, 0));
+	mt76_wr(dev, MT_TMAC_TRCR1, val);
+
+	val = MT_AGG_ACR_PKT_TIME_EN | MT_AGG_ACR_NO_BA_AR_RULE |
+	      FIELD_PREP(MT_AGG_ACR_CFEND_RATE, 0x49) | /* 24M */
+	      FIELD_PREP(MT_AGG_ACR_BAR_RATE, 0x4b); /* 6M */
+	mt76_wr(dev, MT_AGG_ACR0, val);
+	mt76_wr(dev, MT_AGG_ACR1, val);
 
 	mt76_rmw_field(dev, MT_TMAC_CTCR0,
 		       MT_TMAC_CTCR0_INS_DDLMT_REFTIME, 0x3f);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index f2cd858730c3..c1353deb2b7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -97,12 +97,25 @@
 					MT_AGG_ARxCR_LIMIT_SHIFT(_n), \
 					MT_AGG_ARxCR_LIMIT_SHIFT(_n))
 
+#define MT_AGG_ACR0			MT_WF_AGG(0x070)
+#define MT_AGG_ACR1			MT_WF_AGG(0x170)
+#define MT_AGG_ACR_NO_BA_RULE		BIT(0)
+#define MT_AGG_ACR_NO_BA_AR_RULE	BIT(1)
+#define MT_AGG_ACR_PKT_TIME_EN		BIT(2)
+#define MT_AGG_ACR_CFEND_RATE		GENMASK(15, 4)
+#define MT_AGG_ACR_BAR_RATE		GENMASK(31, 20)
+
 #define MT_AGG_SCR			MT_WF_AGG(0x0fc)
 #define MT_AGG_SCR_NLNAV_MID_PTEC_DIS	BIT(3)
 
 #define MT_WF_TMAC_BASE			0x21000
 #define MT_WF_TMAC(ofs)			(MT_WF_TMAC_BASE + (ofs))
 
+#define MT_TMAC_TRCR0			MT_WF_TMAC(0x09c)
+#define MT_TMAC_TRCR1			MT_WF_TMAC(0x070)
+#define MT_TMAC_TRCR_CCA_SEL		GENMASK(31, 30)
+#define MT_TMAC_TRCR_SEC_CCA_SEL	GENMASK(29, 28)
+
 #define MT_TMAC_CTCR0			MT_WF_TMAC(0x0f4)
 #define MT_TMAC_CTCR0_INS_DDLMT_REFTIME	GENMASK(5, 0)
 #define MT_TMAC_CTCR0_INS_DDLMT_DENSITY	GENMASK(15, 12)
-- 
2.17.0

