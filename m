Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720B1377F50
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEJJ2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhEJJ2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 05:28:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF5C061760
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pVtLWlZ1ypbXlX6qXsgvhng1/2mOJz8mXkRcbpFQF3A=; b=SndGS9jlexG+IJztXjdtujakiZ
        2IntOrbHRtQAXxET7OYHQw/YhKUJUHUDqo/01jfyp1qk/7C3lv54A4RPbg5Wv/hja/ugALIhnHz92
        o+wikCEQTaDhD3v6neH8l2HgPvXlPqGBXGJ9UAs5pqjYn689R4OEsle+Rbgmokdn8Hhk=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lg2Bu-000572-04
        for linux-wireless@vger.kernel.org; Mon, 10 May 2021 11:27:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] mt76: intialize tx queue entry wcid to 0xffff by default
Date:   Mon, 10 May 2021 11:26:59 +0200
Message-Id: <20210510092703.90500-5-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210510092703.90500-1-nbd@nbd.name>
References: <20210510092703.90500-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid accidentally mapping them to WCID 0 on completion

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/sdio.c | 1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 72b1cc0ecfda..75c1f54b1fe5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -191,6 +191,7 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 	q->entry[idx].txwi = txwi;
 	q->entry[idx].skb = skb;
+	q->entry[idx].wcid = 0xffff;
 
 	return idx;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index a18d2896ee1f..1665fe88ebb8 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -256,6 +256,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 	q->entry[q->head].skb = tx_info.skb;
 	q->entry[q->head].buf_sz = len;
+	q->entry[q->head].wcid = 0xffff;
 
 	smp_wmb();
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 30bc54e98c58..1e9f60bb811a 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -925,6 +925,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 	q->head = (q->head + 1) % q->ndesc;
 	q->entry[idx].skb = tx_info.skb;
+	q->entry[idx].wcid = 0xffff;
 	q->queued++;
 
 	return idx;
-- 
2.30.1

