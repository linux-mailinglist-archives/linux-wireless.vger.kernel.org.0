Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86F1128D6A
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLVKd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKd6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:58 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCCA2084D;
        Sun, 22 Dec 2019 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010837;
        bh=3GJfT1rZU+uFuwqqxmOB+an4Z7IryzAip33S+CYQ9Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKZuhyFfCT2ytmMsx1+zoD/V8NiYTJaHb83djqn15UjAzSVkMDiXuY0dHG5Vx4vI/
         0qEGEULI9cGHUW94ckei4xuNM2SZxERbbrfycPvCN+gEmvlSDtfx0mYK4Qqh7TW8t8
         gtQLMiJRBJZzm7o9GqtvKnf6aiezDv2QzMPaAp2Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 13/18] mt76: mt76u: introduce mt76u_alloc_mcu_queue utility routine
Date:   Sun, 22 Dec 2019 11:33:15 +0100
Message-Id: <64224e7e934bf0ac3f713ed6114734cc1a8a6b7b.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76u_alloc_mcu_queue  utility routine to allocate mcu hw rx queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 drivers/net/wireless/mediatek/mt76/usb.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 289c890fd951..1171f0a7a032 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -888,6 +888,7 @@ void mt76u_single_wr(struct mt76_dev *dev, const u8 req,
 		     const u16 offset, const u32 val);
 int mt76u_init(struct mt76_dev *dev, struct usb_interface *intf);
 void mt76u_deinit(struct mt76_dev *dev);
+int mt76u_alloc_mcu_queue(struct mt76_dev *dev);
 int mt76u_alloc_queues(struct mt76_dev *dev);
 void mt76u_stop_tx(struct mt76_dev *dev);
 void mt76u_stop_rx(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 575a1d1e6e66..22fd09fe7815 100644
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
2.24.1

