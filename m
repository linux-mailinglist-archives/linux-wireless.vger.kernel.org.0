Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684525792F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHaM0i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgHaM0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF0C06123C
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dmZSWTGqweDqbNSv0L1axe9cFDIvtE4O03SjNZ9N1qk=; b=SIY1NhMKnAtYfJqaqSFKjzFToe
        vCkFXXYiWinEbZl7GgvzVee+/Ep+7+A7G/AlEHLQIl24xDgIIydYMfZvKGM6pQt/o1UYJjMJ6Ss+j
        3oucz5RUyimjGZfgNjA9OhcBlnqMt5VOdXmlbQy3yuG4mFJTaQEq2RTp2M5R32VFuWPk=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCist-0000Ok-2S
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:03 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 9/9] mt76: mt76x02: tune tx ring size
Date:   Mon, 31 Aug 2020 14:25:58 +0200
Message-Id: <20200831122558.1388-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase data queue size to improve performance.
Reduce PS/mgmt queue size

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h         | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02.h      | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3600b0e84aeb..59eed5374b38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -17,7 +17,6 @@
 #include "util.h"
 #include "testmode.h"
 
-#define MT_TX_RING_SIZE     256
 #define MT_MCU_RING_SIZE    32
 #define MT_RX_BUF_SIZE      2048
 #define MT_SKB_HEAD_LEN     128
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4660b9691ec3..d626817a2103 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -15,6 +15,8 @@
 #include "mt76x02_dfs.h"
 #include "mt76x02_dma.h"
 
+#define MT76x02_TX_RING_SIZE	512
+#define MT76x02_PSD_RING_SIZE	128
 #define MT76x02_N_WCIDS 128
 #define MT_CALIBRATE_INTERVAL	HZ
 #define MT_MAC_WORK_INTERVAL	(HZ / 10)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 66453c85f0de..4016ffe840ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -209,13 +209,13 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		ret = mt76x02_init_tx_queue(dev, i, mt76_ac_to_hwq(i),
-					    MT_TX_RING_SIZE);
+					    MT76x02_TX_RING_SIZE);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt76x02_init_tx_queue(dev, MT_TXQ_PSD,
-				    MT_TX_HW_QUEUE_MGMT, MT_TX_RING_SIZE);
+				    MT_TX_HW_QUEUE_MGMT, MT76x02_PSD_RING_SIZE);
 	if (ret)
 		return ret;
 
-- 
2.28.0

