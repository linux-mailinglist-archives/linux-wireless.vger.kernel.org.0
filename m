Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D523125D1B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSI6n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 03:58:43 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59554 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSI6m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 03:58:42 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBJ8wWRX024852, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBJ8wWRX024852
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:58:32 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 19 Dec 2019 16:58:31 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <chiu@endlessm.com>
Subject: [PATCH v4 1/7] rtw88: pci: reset ring index when release skbs in tx ring
Date:   Thu, 19 Dec 2019 16:58:10 +0800
Message-ID: <20191219085816.20709-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219085816.20709-1-yhchuang@realtek.com>
References: <20191219085816.20709-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

When skbs queued for each TX ring are relased in PCI stop flow,
the ring index should be reset at the same time.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * no change

v2 -> v3
 * no change

v3 -> v4
 * no change

 drivers/net/wireless/realtek/rtw88/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a58e8276a41a..068f1bec88e6 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -506,6 +506,7 @@ static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 	struct rtw_pci_tx_ring *tx_ring;
 	u8 queue;
 
+	rtw_pci_reset_trx_ring(rtwdev);
 	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++) {
 		tx_ring = &rtwpci->tx_rings[queue];
 		rtw_pci_free_tx_ring_skbs(rtwdev, tx_ring);
-- 
2.17.1

