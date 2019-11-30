Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B110DE08
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK3Pas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:48 -0500
Received: from nbd.name ([46.4.11.11]:56036 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfK3Pas (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3zwYI2dF8IoVXzl+9VV4JQpMJuvbgYt5nfJiZA5GH4E=; b=f00dW4iEQXtQ/KfYq9AS80y0gX
        vhfpd5nMS9ncs3HNVVuhZzAiOPw8+SUSwMaxhLbHProd+vanVexATWqvg2XV0pQvTEp+erM01VDZi
        bhIS7uRNvnCOXnUmLB4v9Qb4w/S0MIJJVF9PneeWrsU4+UvlTtXjPxy3x5Vyn2QKcTXY=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hZ-5I
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0732B721EBD9; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 20/29] mt76: mt7615: add missing register init for dual-wiphy support
Date:   Sat, 30 Nov 2019 16:30:36 +0100
Message-Id: <20191130153045.28105-20-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize low-power beacon mode setting

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3d8bc93fa8d2..9dcc3b26ff33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -13,9 +13,9 @@
 
 static void mt7615_phy_init(struct mt7615_dev *dev)
 {
-	/* disable band 0 rf low power beacon mode */
-	mt76_rmw(dev, MT_WF_PHY_WF2_RFCTRL0, MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN,
-		 MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
+	/* disable rf low power beacon mode */
+	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(0), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
+	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(1), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 }
 
 static void mt7615_mac_init(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index afb1eb08462d..a805561d10c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -81,7 +81,7 @@
 #define MT_WF_PHY_BASE			0x10000
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
-#define MT_WF_PHY_WF2_RFCTRL0		MT_WF_PHY(0x1900)
+#define MT_WF_PHY_WF2_RFCTRL0(n)	MT_WF_PHY(0x1900 + ((n) * 0x400))
 #define MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN	BIT(9)
 
 #define MT_WF_PHY_R0_PHYMUX_5(_phy)	MT_WF_PHY(0x0614 + ((_phy) << 9))
-- 
2.24.0

