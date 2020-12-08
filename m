Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7302D2755
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 10:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgLHJS7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 04:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgLHJS6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 04:18:58 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_queue
Date:   Tue,  8 Dec 2020 10:18:11 +0100
Message-Id: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
can occur if status thread runs before allocating tx queues

Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_worker")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 7cd995118257..0b6facb17ff7 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -157,10 +157,14 @@ static void mt76s_net_worker(struct mt76_worker *w)
 
 static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	bool mcu = q == dev->q_mcu[MT_MCUQ_WM];
 	struct mt76_queue_entry entry;
 	int nframes = 0;
+	bool mcu;
 
+	if (!q)
+		return 0;
+
+	mcu = q == dev->q_mcu[MT_MCUQ_WM];
 	while (q->queued > 0) {
 		if (!q->entry[q->tail].done)
 			break;
-- 
2.28.0

