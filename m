Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4130B25E6B6
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgIEJ03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgIEJ00 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:26 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB30720757;
        Sat,  5 Sep 2020 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297985;
        bh=YIftfxD2XJ7ikfzyIsGJ9Eqff2OMPAJrwVxIyVY6D48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfRKd+GflFZTdSSO2hYfuuXfLBk2ftJa700PR6IgHfFdPIA5CduQfYxrY26ikfspN
         FJcwVflE0Boi8MY3bYZMqyS09F4EnEqEpC0CDnNDG+eQDjdGDJdrpM562wgFYQeJeI
         2SZ7hzhd6SQkb36ZT+vAAJtTtE/BdHRN0q9M0Cgo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 7/7] mt76: mt7663: check isr read return value in mt7663s_rx_work
Date:   Sat,  5 Sep 2020 11:26:07 +0200
Message-Id: <d5e8eed2c5f12ab091464620f1af44c54bdb10ff.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid using stale isr values, check return value from
sdio_readsb() in mt7663s_rx_work()

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index e82f6bdcbce4..2486cda3243b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -278,9 +278,12 @@ void mt7663s_rx_work(struct work_struct *work)
 	/* disable interrupt */
 	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
-	sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(struct mt76s_intr));
+	ret = sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
 	sdio_release_host(sdio->func);
 
+	if (ret < 0)
+		goto out;
+
 	trace_dev_irq(dev, intr->isr, 0);
 
 	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
@@ -306,7 +309,7 @@ void mt7663s_rx_work(struct work_struct *work)
 		queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
 		return;
 	}
-
+out:
 	/* enable interrupt */
 	sdio_claim_host(sdio->func);
 	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
-- 
2.26.2

