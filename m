Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E925E6B4
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgIEJ0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 05:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgIEJ0Y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 05:26:24 -0400
Received: from localhost.localdomain (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4CE2074D;
        Sat,  5 Sep 2020 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599297983;
        bh=27iJwRfY74SCfzmkfNmv1It2jJJ/kZKlF9GiIuGLyZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8ZQZlBsQu1gGEO0OPECncS4ESBdomqFW6Hyd8KXNaeXnEKX3IE20ylEVlwg5XJqz
         5jctiFmwAu3BGzrEBPF+VHxe7bhug0GR0bPjl/PzkVZcLRScjyxenJInQWeA8fnist
         LlDQXmpqHVVCZfThLSLT4r9vAb39Y4J0kiin4P98=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 5/7] mt76: mt7663s: fix possible quota leak in mt7663s_refill_sched_quota
Date:   Sat,  5 Sep 2020 11:26:05 +0200
Message-Id: <f344ec4b8cd3e90e961d472c0874812e17fa754a.1599297449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599297449.git.lorenzo@kernel.org>
References: <cover.1599297449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Look just at reported quota since the hw sporadically reports mcu tx
quota without setting WHIER_TX_DONE_INT_EN bit

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index 4754b3abd0a2..4033fe431312 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -19,21 +19,40 @@
 #include "sdio.h"
 #include "mac.h"
 
-static void mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
+static int mt7663s_refill_sched_quota(struct mt76_dev *dev, u32 *data)
 {
+	u32 ple_ac_data_quota[] = {
+		FIELD_GET(TXQ_CNT_L, data[4]), /* VO */
+		FIELD_GET(TXQ_CNT_H, data[3]), /* VI */
+		FIELD_GET(TXQ_CNT_L, data[3]), /* BE */
+		FIELD_GET(TXQ_CNT_H, data[2]), /* BK */
+	};
+	u32 pse_ac_data_quota[] = {
+		FIELD_GET(TXQ_CNT_H, data[1]), /* VO */
+		FIELD_GET(TXQ_CNT_L, data[1]), /* VI */
+		FIELD_GET(TXQ_CNT_H, data[0]), /* BE */
+		FIELD_GET(TXQ_CNT_L, data[0]), /* BK */
+	};
+	u32 pse_mcu_quota = FIELD_GET(TXQ_CNT_L, data[2]);
+	u32 pse_data_quota = 0, ple_data_quota = 0;
 	struct mt76_sdio *sdio = &dev->sdio;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pse_ac_data_quota); i++) {
+		pse_data_quota += pse_ac_data_quota[i];
+		ple_data_quota += ple_ac_data_quota[i];
+	}
+
+	if (!pse_data_quota && !ple_data_quota && !pse_mcu_quota)
+		return 0;
 
 	mutex_lock(&sdio->sched.lock);
-	sdio->sched.pse_data_quota += FIELD_GET(TXQ_CNT_L, data[0]) + /* BK */
-				      FIELD_GET(TXQ_CNT_H, data[0]) + /* BE */
-				      FIELD_GET(TXQ_CNT_L, data[1]) + /* VI */
-				      FIELD_GET(TXQ_CNT_H, data[1]);  /* VO */
-	sdio->sched.ple_data_quota += FIELD_GET(TXQ_CNT_H, data[2]) + /* BK */
-				      FIELD_GET(TXQ_CNT_L, data[3]) + /* BE */
-				      FIELD_GET(TXQ_CNT_H, data[3]) + /* VI */
-				      FIELD_GET(TXQ_CNT_L, data[4]);  /* VO */
-	sdio->sched.pse_mcu_quota += FIELD_GET(TXQ_CNT_L, data[2]);
+	sdio->sched.pse_mcu_quota += pse_mcu_quota;
+	sdio->sched.pse_data_quota += pse_data_quota;
+	sdio->sched.ple_data_quota += ple_data_quota;
 	mutex_unlock(&sdio->sched.lock);
+
+	return pse_data_quota + ple_data_quota + pse_mcu_quota;
 }
 
 static struct sk_buff *mt7663s_build_rx_skb(void *data, int data_len,
@@ -259,10 +278,8 @@ void mt7663s_rx_work(struct work_struct *work)
 		}
 	}
 
-	if (intr->isr & WHIER_TX_DONE_INT_EN) {
-		mt7663s_refill_sched_quota(dev, intr->tx.wtqcr);
+	if (mt7663s_refill_sched_quota(dev, intr->tx.wtqcr))
 		queue_work(sdio->txrx_wq, &sdio->tx.xmit_work);
-	}
 
 	if (nframes) {
 		queue_work(sdio->txrx_wq, &sdio->rx.recv_work);
-- 
2.26.2

