Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB05F1320FF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2020 09:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAGIIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 03:08:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47730 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 03:08:20 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00788AFh008457, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00788AFh008457
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 7 Jan 2020 16:08:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 7 Jan 2020 16:08:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <mikhail.v.gavrilov@gmail.com>, <rtereguloff@gmail.com>
Subject: [PATCH] rtw88: fix potential NULL skb access in TX ISR
Date:   Tue, 7 Jan 2020 16:08:07 +0800
Message-ID: <20200107080807.14433-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Sometimes the TX queue may be empty and we could possible
dequeue a NULL pointer, crash the kernel. If the skb is NULL
then there is nothing to do, just leave the ISR.

And the TX queue should not be empty here, so print an error
to see if there is anything wrong for DMA ring.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a58e8276a41a..a6746b5a9ff2 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -832,6 +832,11 @@ static void rtw_pci_tx_isr(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 
 	while (count--) {
 		skb = skb_dequeue(&ring->queue);
+		if (!skb) {
+			rtw_err(rtwdev, "failed to dequeue %d skb TX queue %d, BD=0x%08x, rp %d -> %d\n",
+				count, hw_queue, bd_idx, ring->r.rp, cur_rp);
+			break;
+		}
 		tx_data = rtw_pci_get_tx_data(skb);
 		pci_unmap_single(rtwpci->pdev, tx_data->dma, skb->len,
 				 PCI_DMA_TODEVICE);
-- 
2.17.1

