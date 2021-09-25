Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04931418248
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbhIYN2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 09:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245112AbhIYN2u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 09:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57B9D60FDC;
        Sat, 25 Sep 2021 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632576436;
        bh=ckBsi+oCymeeY9PQYCUfWjfLEvf+9QPus5sCYcP/pnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XDmZuQTHuDbdjad/Vpo4c9+V7/VoSswVPjCGmKdeYnek8+z4uytDJpwsnNu3pQxr4
         n7TgMqFX1aIHFXQsmWcW/hpV3tMX5lx3oOW2kjWK/xpS7US9hmUG1q3MAz+0hS7d75
         0PbOCPVwHRiRmMfsPwvnSl2iKgbNHktpyEPrdAyrOiRj5p5K3ia/gopmSWyZIPyLWi
         os0jClYn5cRF9uabFz4UXtG1TwLTya0spmIozdGy4+14AacaUjtdBHNbt0mPEXol1U
         51bKzhDfd5zkHl/jbyok317yHQMpP562QVxgGjoaGv2cEH+2gv9K5JaBYBhybNrg3Y
         H5dbeTQgQov9g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: debugfs: improve queue node readability
Date:   Sat, 25 Sep 2021 15:27:02 +0200
Message-Id: <f796458c09c87be56d0ab7ecf60bb253b130f396.1632576343.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve {xmit,rx}-queue debugfs node readability

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index e23fabddec1f..b8bcf22a07fd 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -56,14 +56,14 @@ int mt76_queues_read(struct seq_file *s, void *data)
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
+	seq_puts(s, "     queue | hw-queued |      head |      tail |\n");
 	for (i = 0; i < ARRAY_SIZE(dev->phy.q_tx); i++) {
 		struct mt76_queue *q = dev->phy.q_tx[i];
 
 		if (!q)
 			continue;
 
-		seq_printf(s,
-			   "%d:	queued=%d head=%d tail=%d\n",
+		seq_printf(s, " %9d | %9d | %9d | %9d |\n",
 			   i, q->queued, q->head, q->tail);
 	}
 
@@ -76,12 +76,13 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 	struct mt76_dev *dev = dev_get_drvdata(s->private);
 	int i, queued;
 
+	seq_puts(s, "     queue | hw-queued |      head |      tail |\n");
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
 		queued = mt76_is_usb(dev) ? q->ndesc - q->queued : q->queued;
-		seq_printf(s, "%d:	queued=%d head=%d tail=%d\n",
-			   i, queued, q->head, q->tail);
+		seq_printf(s, " %9d | %9d | %9d | %9d |\n",
+			   i, q->queued, q->head, q->tail);
 	}
 
 	return 0;
-- 
2.31.1

