Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0510C88A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 13:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1MTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 07:19:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59537 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK1MTV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 07:19:21 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xASCJDmo004448, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xASCJDmo004448
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Nov 2019 20:19:13 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 28 Nov 2019 20:19:13 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 2/6] rtw88: pci: reset dma when reset pci trx ring
Date:   Thu, 28 Nov 2019 20:19:03 +0800
Message-ID: <20191128121907.6178-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128121907.6178-1-yhchuang@realtek.com>
References: <20191128121907.6178-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

When pci trx ring is reset, hw dma setting should be reset together.
Otherswise, the rx_tag of rx flow is not synchronous to hw.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 068f1bec88e6..78971cefb948 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -486,13 +486,6 @@ static void rtw_pci_disable_interrupt(struct rtw_dev *rtwdev,
 	rtwpci->irq_enabled = false;
 }
 
-static int rtw_pci_setup(struct rtw_dev *rtwdev)
-{
-	rtw_pci_reset_trx_ring(rtwdev);
-
-	return 0;
-}
-
 static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 {
 	/* reset dma and rx tag */
@@ -501,6 +494,16 @@ static void rtw_pci_dma_reset(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 	rtwpci->rx_tag = 0;
 }
 
+static int rtw_pci_setup(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	rtw_pci_reset_trx_ring(rtwdev);
+	rtw_pci_dma_reset(rtwdev, rtwpci);
+
+	return 0;
+}
+
 static void rtw_pci_dma_release(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci)
 {
 	struct rtw_pci_tx_ring *tx_ring;
-- 
2.17.1

