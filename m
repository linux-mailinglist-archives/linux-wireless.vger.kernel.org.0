Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95105B3506
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfIPHD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:03:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60338 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfIPHD7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:03:59 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73rS3029972, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73rS3029972
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:53 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:53 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
Date:   Mon, 16 Sep 2019 15:03:35 +0800
Message-ID: <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Interrupt is disabled to stop PCI, which means the skbs
queued for each TX ring will not be released via DMA
interrupt. To avoid those skbs remained being left in
the skb queue until PCI has been removed, driver needs
to release skbs by itself.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 3238161..509743c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -500,6 +500,17 @@ static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 	rtwpci->rx_tag = 0;
 }
 
+static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
+{
+	struct rtw_pci_tx_ring *tx_ring;
+	u8 queue;
+
+	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++) {
+		tx_ring = &rtwpci->tx_rings[queue];
+		rtw_pci_free_tx_ring_skbs(rtwdev, tx_ring);
+	}
+}
+
 static int rtw_pci_start(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
@@ -521,6 +532,7 @@ static void rtw_pci_stop(struct rtw_dev *rtwdev)
 
 	spin_lock_irqsave(&rtwpci->irq_lock, flags);
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+	rtw_pci_dma_release(rtwdev, rtwpci);
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 }
 
-- 
2.7.4

