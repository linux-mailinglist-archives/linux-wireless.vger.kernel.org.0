Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4115FDFA
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2020 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgBOKbw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Feb 2020 05:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgBOKbv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Feb 2020 05:31:51 -0500
Received: from localhost.lan (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD702067D;
        Sat, 15 Feb 2020 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581762711;
        bh=aEbYe6PJRsQmJsofXlmH5NsgC9Vo1q6sNwaoq6ZaSe4=;
        h=From:To:Cc:Subject:Date:From;
        b=wv3sMl3V8VTRQ0Nq688i15P+PDZ7j80Gxp0ldXWm82zg+JuB0C7OxPn6CISt7CcWd
         YQq4rgS0hhp2tgRk/3W68LFmYKDmM3GxFapzfhSrL+/uThbCfBGdKdFipIO6Lk+9/Z
         D0/qG3jVQQrEH/eUx8QFuIGJ2FcKCWCgI+Sh6jT8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76u: loop over all possible rx queues in mt76u_rx_tasklet
Date:   Sat, 15 Feb 2020 11:31:31 +0100
Message-Id: <4333bba5fbac33d1df33032bb851bcef41b806c2.1581762346.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loop over all possible hw rx queues in mt76u_rx_tasklet since new
devices will report mcu events through mcu hw queue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 36ba81d63f12..fffa12cbb3e3 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -672,10 +672,17 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 static void mt76u_rx_tasklet(unsigned long data)
 {
 	struct mt76_dev *dev = (struct mt76_dev *)data;
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76_queue *q;
+	int i;
 
 	rcu_read_lock();
-	mt76u_process_rx_queue(dev, q);
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
+		if (!q->ndesc)
+			continue;
+
+		mt76u_process_rx_queue(dev, q);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.24.1

