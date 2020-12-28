Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5A2E3507
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgL1IZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 03:25:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40471 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgL1IZq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 03:25:46 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BS8Ow7W2029773, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BS8Ow7W2029773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Dec 2020 16:24:58 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 28 Dec
 2020 16:24:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH] rtw88: reduce the log level for failure of tx report
Date:   Mon, 28 Dec 2020 16:24:33 +0800
Message-ID: <20201228082433.16431-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Sometimes driver does not get tx report from firmware because wifi
environment is too noisy to get ack from AP about a TX frame,
or firmware is too busy to report driver in a estimated time.
But the condition will not affect wifi function or throughput.
So we reduce the log level to rtw_debug instead of scary backtrace.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index ca8072177ae3..18ec0088bf41 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -158,7 +158,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 	if (skb_queue_len(&tx_report->queue) == 0)
 		return;
 
-	WARN(1, "purge skb(s) not reported by firmware\n");
+	rtw_dbg(rtwdev, RTW_DBG_TX, "purge skb(s) not reported by firmware\n");
 
 	spin_lock_irqsave(&tx_report->q_lock, flags);
 	skb_queue_purge(&tx_report->queue);
-- 
2.21.0

