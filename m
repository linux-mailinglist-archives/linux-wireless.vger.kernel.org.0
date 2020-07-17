Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4232B2234E7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGQGuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55021 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0Mx9028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0Mx9028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] rtw88: coex: only skip coex triggered by BT info
Date:   Fri, 17 Jul 2020 14:49:34 +0800
Message-ID: <20200717064937.27966-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The coex mechanism used to skip upon the freeze flag is raised.
That will cause the coex mechanism being skipped unexpectedly.
Coex only wanted to keep the TDMA table from being changed by
BT side.

So, check the freeze and reason, if the coex reason is coming
from BT info, skip it, to make sure the coex triggered by Wifi
itself can work.

This is required for the AP mode, while the control flow is
different with STA mode. When starting an AP mode, the AP mode
needs to start working immedaitely after leaving IPS, and the
freeze flag could be raised. If the coex info is skipped, then
the AP mode will not set the antenna owner, leads to TX stuck.

Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 3abae32341c4..aa08fd7d9fcd 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1962,7 +1962,8 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	if (coex_stat->wl_under_ips)
 		return;
 
-	if (coex->freeze && !coex_stat->bt_setup_link)
+	if (coex->freeze && coex_dm->reason == COEX_RSN_BTINFO &&
+	    !coex_stat->bt_setup_link)
 		return;
 
 	coex_stat->cnt_wl[COEX_CNT_WL_COEXRUN]++;
-- 
2.17.1

