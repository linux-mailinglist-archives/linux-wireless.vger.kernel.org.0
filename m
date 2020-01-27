Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527B514A9B1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgA0SSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:18:00 -0500
Received: from nbd.name ([46.4.11.11]:48204 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgA0SR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iihLKt1FZfJPflNC1P9GfbgNR5V4BNntrvkLd/6G77A=; b=FLFs3t4xXo6Lf9FHLJ0omdvAb8
        sEole+8pHcLomp5nbNNn132umGm9DwpjbTCxnRkWfcOY0WON2q2XkI/9AfFQLiGMDxEw1THsqYo5y
        QVzQ/9nZjeGVjlD/H+6+nIFbK8uLc3qTJmQbPmqZ7PyKZCylknlK2vrw0xKJgk70HGXU=;
Received: from [178.162.209.132] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw8xP-0007de-Kq
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 19:17:55 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 212047A566E6; Mon, 27 Jan 2020 19:17:54 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/5] mt76: mt7603: increase dma mcu rx ring size
Date:   Mon, 27 Jan 2020 19:17:53 +0100
Message-Id: <20200127181754.2810-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127181754.2810-1-nbd@nbd.name>
References: <20200127181754.2810-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ring is used for looping back tx powersave filtered frames, so it could
use some more room, in case more than one aggregate was queued

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 57428467fe96..a08b85281170 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -221,7 +221,7 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 		return ret;
 
 	ret = mt7603_init_rx_queue(dev, &dev->mt76.q_rx[MT_RXQ_MCU], 1,
-				   MT_MCU_RING_SIZE, MT_RX_BUF_SIZE);
+				   MT7603_MCU_RX_RING_SIZE, MT_RX_BUF_SIZE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 12fd2db2df10..ef374641fe80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -15,6 +15,7 @@
 
 #define MT7603_RATE_RETRY	2
 
+#define MT7603_MCU_RX_RING_SIZE	64
 #define MT7603_RX_RING_SIZE     128
 
 #define MT7603_FIRMWARE_E1	"mt7603_e1.bin"
-- 
2.24.0

