Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44113BDEA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgAOK7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:51 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7629624681;
        Wed, 15 Jan 2020 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085990;
        bh=wA1B2Rxa+gvLwcsDiYxjJ7KdH2wQQtdq6egKpgzIG9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3OkSIAwrOx30MQaaDLDe3PmhZRUf4VtQj/TaGqLK8SNq8A4iBacInb7BahZaB34h
         hDpby37MA87L3YkU6M6i5WaOzyE9iYt5OMjJre8CXyVAsrFwJ5iUe57RZhEqKNMBNi
         bZU2l4VSS56Zkcn4qedkY0/ndjtUNFUoU3zTWsAs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 13/18] mt76: mt76u: introduce mt76u_alloc_mcu_queue utility routine
Date:   Wed, 15 Jan 2020 11:58:53 +0100
Message-Id: <dd206b77304641f15de1dc7811ab744b5e6b9aa6.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76u_alloc_mcu_queue  utility routine to allocate mcu hw rx queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 217f8c5ad201..d58d76e31a84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -889,6 +889,7 @@ void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
 int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
 void mt76u_deinit(struct mt76_dev *dev);
+int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
 int mt76u_alloc_queues(struct mt76_dev *dev);
 void mt76u_stop_tx(struct mt76_dev *dev);
 void mt76u_stop_rx(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d85268c6df70..4e0a115c6fd2 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -629,6 +629,12 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	return mt76u_submit_rx_buffers(dev, qid);
 }
 
+int mt76u_alloc_mcu_queue(struct mt76_dev *dev)
+{
+	return mt76u_alloc_rx_queue(dev, MT_RXQ_MCU);
+}
+EXPORT_SYMBOL_GPL(mt76u_alloc_mcu_queue);
+
 static void
 mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-- 
2.21.1

