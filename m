Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD7B350F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfIPHD6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:03:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60331 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfIPHD5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:03:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73q9k029963, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73q9k029963
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:52 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 03/15] rtw88: pci: reset H2C queue indexes in a single write
Date:   Mon, 16 Sep 2019 15:03:33 +0800
Message-ID: <1568617425-28062-4-git-send-email-yhchuang@realtek.com>
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

If the driver doesn't reset the host's and device's indexes
in a single write, the indexes will become different in a
short period. And it will confuse the DMA engine, make it
start to process non-existed entries.

Better to Write-1-to-reset the indexes, for the DMA engine
to know that this is a reset of the H2C queue, not a kick
off.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 3fdb52a..9cc068a 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -441,9 +441,9 @@ static void rtw_pci_reset_buf_desc(struct rtw_dev *rtwdev)
 	/* reset read/write point */
 	rtw_write32(rtwdev, RTK_PCI_TXBD_RWPTR_CLR, 0xffffffff);
 
-	/* rest H2C Queue index */
-	rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR, BIT_CLR_H2CQ_HOST_IDX);
-	rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR, BIT_CLR_H2CQ_HW_IDX);
+	/* reset H2C Queue index in a single write */
+	rtw_write32_set(rtwdev, RTK_PCI_TXBD_H2CQ_CSR,
+			BIT_CLR_H2CQ_HOST_IDX | BIT_CLR_H2CQ_HW_IDX);
 }
 
 static void rtw_pci_reset_trx_ring(struct rtw_dev *rtwdev)
-- 
2.7.4

