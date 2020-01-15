Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24B913BDE9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgAOK7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7t (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:49 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8CA24680;
        Wed, 15 Jan 2020 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085989;
        bh=IfnCV33stvjYkB5kYeaPbB0bgWOKkEzPOHOe72GZpPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3xu06TK3IpoSY3r5PESktc5JPE/gZITPoziFBqGMR1fXGLO3h2eoygCe7bfQimQv
         XS/xykkpiYQlyT1wgG6LeC7BukH46C6sH/h4qtc8bJR7uN6t9YgiH2uUqFqTwmb2oA
         RdGl3lJ4JsDhhxc0lxMuZU1yk3uIYPxDb1F1XdWI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 12/18] mt76: mt76u: resume all rx queue in mt76u_resume_rx
Date:   Wed, 15 Jan 2020 11:58:52 +0100
Message-Id: <cef326bd53b364b3de456cefbe937f626643311c.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Resume all possible rx queues after suspend. This is a preliminary patch
to support mt7663u devices

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index f80380c674a1..d85268c6df70 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -680,13 +680,24 @@ EXPORT_SYMBOL_GPL(mt76u_stop_rx);
 
 int mt76u_resume_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i;
+	struct mt76_queue *q;
+	int i, j, err;
 
-	for (i = 0; i < q->ndesc; i++)
-		usb_unpoison_urb(q->entry[i].urb);
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
 
-	return mt76u_submit_rx_buffers(dev, MT_RXQ_MAIN);
+		if (!q->ndesc)
+			continue;
+
+		for (j = 0; j < q->ndesc; j++)
+			usb_unpoison_urb(q->entry[j].urb);
+
+		err = mt76u_submit_rx_buffers(dev, i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-- 
2.21.1

