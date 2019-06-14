Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1798645608
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFNHYc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:24:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48182 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfFNHYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:30 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5E7OQNo024971, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5E7OQNo024971
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:24:26 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 15:24:25 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 10/11] rtw88: rsvd page should go though management queue
Date:   Fri, 14 Jun 2019 15:24:14 +0800
Message-ID: <1560497055-17197-11-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
References: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The hardware default uses management queue to transmit frames that are
downloaded into reserved page, so we need to clearly assign the frames
to use qsel in TX_DESC_QSEL_MGMT to avoid using wrong queue.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index e32faf8..8eaa980 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -362,6 +362,6 @@ void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->bmc = bmc;
 	pkt_info->tx_pkt_size = skb->len;
 	pkt_info->offset = chip->tx_pkt_desc_sz;
-	pkt_info->qsel = skb->priority;
+	pkt_info->qsel = TX_DESC_QSEL_MGMT;
 	pkt_info->ls = true;
 }
-- 
2.7.4

