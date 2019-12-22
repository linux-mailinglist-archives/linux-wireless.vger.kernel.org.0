Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A663128D65
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLVKdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:50 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 598CD2070A;
        Sun, 22 Dec 2019 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010830;
        bh=5OtcLDGJVKQTi5yW5GJf2qAhOn4pzIQuuYFLNR5sMLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLyIP9hLhYt8FgptjmQqj2LdGAO8m8auUzCYr/7fGw/7F/bX6/Ms9/GBHIyhTJEdA
         uygqA8NAPcPvXowE0PexorxODPZ/f+W54IdgtmIro8nxk54raWoiXzvRTmIGUFP6IC
         G+GOIuUFavNxYdFSzbEWGIe4D2voPJ7lh1j8IVXo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 08/18] mt76: mt76u: introduce mt76u_free_rx_queue utility routine
Date:   Sun, 22 Dec 2019 11:33:10 +0100
Message-Id: <1fb87da13d04f00ea74cb56f614b6cd65d435ac4.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76u_free_rx_queue utility routine to free rx hw queue.
This is a preliminary patch to support new devices (e.g. mt7663u) that
rely on a hw queue for mcu messages

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 8b9c598cbeac..b20c26da57d3 100644
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
2.24.1

