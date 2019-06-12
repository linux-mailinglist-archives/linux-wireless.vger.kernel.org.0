Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0701D41C7E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfFLGpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51312 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbfFLGpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:38 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jY0H004388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jY0H004388
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:34 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:33 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] rtw88: rsvd page should go though management queue
Date:   Wed, 12 Jun 2019 14:45:16 +0800
Message-ID: <1560321917-17751-11-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
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

