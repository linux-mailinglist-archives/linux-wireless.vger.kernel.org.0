Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85D913BDE5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgAOK7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:43 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B7FA2467E;
        Wed, 15 Jan 2020 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085983;
        bh=GgpiMo92WKFy3HYxGgK2WZjDLR+l93Je2vtTitpvpMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DH1hvp7puJmCKhjTXLjgRQhdJooIIBL9uQNlIuiXPLZJ/sZOwhaep6ZV36LM8WHBa
         Swmtf7KrP0j0yW8vU5eZCY+RI6UCvkf12V0g0a9W0D1rr2cCsf2Gk9YhgJ06QvANAL
         l2Bf/4jP5TEWYunChokYFobpdxWr0fX7UYzBDTlo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 08/18] mt76: mt76u: introduce mt76u_free_rx_queue utility routine
Date:   Wed, 15 Jan 2020 11:58:48 +0100
Message-Id: <a1f7a73b823af389bd620b4739e05690271762e7.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_free_rx_queue utility routine to free rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 96269e8eb170..8f0d92c11abf 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -627,9 +627,9 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	return mt76u_submit_rx_buffers(dev, MT_RXQ_MAIN);
 }
 
-static void mt76u_free_rx(struct mt76_dev *dev)
+static void
+mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	struct page *page;
 	int i;
 
@@ -644,6 +644,13 @@ static void mt76u_free_rx(struct mt76_dev *dev)
 	memset(&q->rx_page, 0, sizeof(q->rx_page));
 }
 
+static void mt76u_free_rx(struct mt76_dev *dev)
+{
+	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+
+	mt76u_free_rx_queue(dev, q);
+}
+
 void mt76u_stop_rx(struct mt76_dev *dev)
 {
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-- 
2.21.1

