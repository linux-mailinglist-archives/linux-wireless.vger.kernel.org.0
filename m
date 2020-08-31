Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE425792E
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHaM0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgHaM0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D93C06123B
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=48lYLp6z1A5P9C32cVXbH73W/YTGMaabPmcrwtWidz8=; b=pf5B8lcw8fcIhvyoc7x9XUHeRY
        ytbk3R5/uVoL/gBzBHQ39M7ftj0AZ4BFdf+irB3aMZIRJBztdp1zfXkxy9ZdcPx2EWOJtv5OsKoro
        cm0n01jZXK1VdmV0Xq/nUcg8Em5x8gxOg410oBBq8GlqVD/Y/MVa1ctMhr1trEB7CSaQ=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kCiss-0000Ok-T9
        for linux-wireless@vger.kernel.org; Mon, 31 Aug 2020 14:26:02 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] mt76: mt7603: tune tx ring size
Date:   Mon, 31 Aug 2020 14:25:57 +0200
Message-Id: <20200831122558.1388-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831122558.1388-1-nbd@nbd.name>
References: <20200831122558.1388-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop relying on global tx ring size, reduce size for PS/mgmt queue

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 4ab35d2f8cef..b51b894a6d84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -192,13 +192,13 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(wmm_queue_map); i++) {
 		ret = mt7603_init_tx_queue(dev, i, wmm_queue_map[i],
-					   MT_TX_RING_SIZE);
+					   MT7603_TX_RING_SIZE);
 		if (ret)
 			return ret;
 	}
 
 	ret = mt7603_init_tx_queue(dev, MT_TXQ_PSD,
-				   MT_TX_HW_QUEUE_MGMT, MT_TX_RING_SIZE);
+				   MT_TX_HW_QUEUE_MGMT, MT7603_PSD_RING_SIZE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index f40dbfa7d2da..2a6e4332ad06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -17,6 +17,8 @@
 
 #define MT7603_MCU_RX_RING_SIZE	64
 #define MT7603_RX_RING_SIZE     128
+#define MT7603_TX_RING_SIZE	256
+#define MT7603_PSD_RING_SIZE	128
 
 #define MT7603_FIRMWARE_E1	"mt7603_e1.bin"
 #define MT7603_FIRMWARE_E2	"mt7603_e2.bin"
-- 
2.28.0

