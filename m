Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF714DD0F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgA3OrZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:47:25 -0500
Received: from nbd.name ([46.4.11.11]:57440 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgA3OrW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zO4DxtnSS75mXxwXEXEiPN17tuKiKc7EbcX7NGORWX0=; b=NL4YF5oiVIEQ9/SrLIqm7fsnBo
        t4Kc3iR3WMCe0FDp4wNkFV5/V3iNMvBhNM7+gngipav+I5j2MmEt+KpIOAGmZD1bjTaQyKpo3G1y0
        Ix+3WWWHhhi56XynA4ZQNGREyvewcmzzFXeL9YnhR3GCkEMv9HWOisWOzK8VRTLFXXOM=;
Received: from [178.162.209.135] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixB6G-0001Vk-IN
        for linux-wireless@vger.kernel.org; Thu, 30 Jan 2020 15:47:20 +0100
Received: by maeck.local (Postfix, from userid 501)
        id EE6827AE4693; Thu, 30 Jan 2020 15:47:18 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 13/15] mt76: mt7615: decrease rx ring size for MT7622
Date:   Thu, 30 Jan 2020 15:47:16 +0100
Message-Id: <20200130144718.14298-13-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130144718.14298-1-nbd@nbd.name>
References: <20200130144718.14298-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since it's 2.4 GHz only, it needs fewer buffers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 41dea1aa58db..aeccb35e14f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -188,6 +188,7 @@ static void mt7622_dma_sched_init(struct mt7615_dev *dev)
 
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
+	int rx_ring_size = MT7615_RX_RING_SIZE;
 	int ret;
 
 	mt76_dma_attach(&dev->mt76);
@@ -236,9 +237,11 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
+	if (!is_mt7615(&dev->mt76))
+	    rx_ring_size /= 2;
+
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
-			       MT7615_RX_RING_SIZE, MT_RX_BUF_SIZE,
-			       MT_RX_RING_BASE);
+			       rx_ring_size, MT_RX_BUF_SIZE, MT_RX_RING_BASE);
 	if (ret)
 		return ret;
 
-- 
2.24.0

