Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F43BF7D5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfIZRrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:37 -0400
Received: from nbd.name ([46.4.11.11]:55230 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZRrf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2sxprl85AKFA4xYDqGI4ytBXsQqkpDlhYWTNuzb7o50=; b=TNVAUwLTu5dfDzhi2vjftAyJyM
        GmsTnTuFjLh1+3vaeSKEgJfvrCmjKIxWZynkn+yXU1h5IXq+BVQN3+6G3yu3uDhU3AILGF/Qploag
        JGSQGoprAAoDoXFpVJdJB+LUdmzVGST6nzAv44aSy7TAk1Dxf4FYb/l9i8WGuqQ5SEDA=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXrZ-0000yZ-8l
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:33 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B3B5469B6A81; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 12/15] mt76: mt7615: fix survey channel busy time
Date:   Thu, 26 Sep 2019 19:47:29 +0200
Message-Id: <20190926174732.42375-12-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Like on mt7603, MIB status register 16 tracks CCA time, but does not
include tx time. Switch to status register 9 to includ NAV and tx
time as well.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9b113037c4f2..f688390bfd3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -53,7 +53,7 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 	/* TODO: add DBDC support */
 
 	/* reset airtime counters */
-	mt76_rr(dev, MT_MIB_SDR16(0));
+	mt76_rr(dev, MT_MIB_SDR9(0));
 	mt76_rr(dev, MT_MIB_SDR36(0));
 	mt76_rr(dev, MT_MIB_SDR37(0));
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
@@ -1274,7 +1274,8 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 	u64 busy_time, tx_time, rx_time, obss_time;
 
 	/* TODO: add DBDC support */
-	busy_time = mt76_get_field(dev, MT_MIB_SDR16(0), MT_MIB_BUSY_MASK);
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(0),
+				   MT_MIB_SDR9_BUSY_MASK);
 	tx_time = mt76_get_field(dev, MT_MIB_SDR36(0),
 				 MT_MIB_SDR36_TXTIME_MASK);
 	rx_time = mt76_get_field(dev, MT_MIB_SDR37(0),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 9a2ff1f3a68c..226b9ada89f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -293,8 +293,11 @@
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-#define MT_MIB_SDR16(n)			MT_WF_MIB(0x48 + ((n) << 9))
-#define MT_MIB_BUSY_MASK		GENMASK(23, 0)
+#define MT_MIB_SDR9(n)			MT_WF_MIB(0x02c + ((n) << 9))
+#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR16(n)			MT_WF_MIB(0x048 + ((n) << 9))
+#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
 
 #define MT_MIB_SDR36(n)			MT_WF_MIB(0x098 + ((n) << 9))
 #define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
-- 
2.17.0

