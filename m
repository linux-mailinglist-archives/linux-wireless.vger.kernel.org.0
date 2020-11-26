Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E522C4D2C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgKZCM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:28 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60684 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbgKZCM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:27 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CK2s8030312, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CK2s8030312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 10:12:20 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 26 Nov 2020 10:12:19 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 01/10] rtw88: coex: run coexistence when WLAN entering/leaving LPS
Date:   Thu, 26 Nov 2020 10:10:50 +0800
Message-ID: <20201126021059.11981-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201126021059.11981-1-pkshih@realtek.com>
References: <20201126021059.11981-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

When WLAN entering or leaving, it's necessary to run coexistence mechanism
to ensure the setting matched current status.
Without calling rtw_coex_run_coex(), WLAN poor throughput or bad A2DP
quality may happen.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4bb0d373c862..7b69c7b01e22 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2476,6 +2476,8 @@ void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type)
 
 		if (!coex_stat->wl_force_lps_ctrl)
 			rtw_coex_query_bt_info(rtwdev);
+
+		rtw_coex_run_coex(rtwdev, COEX_RSN_LPS);
 	}
 }
 
-- 
2.21.0

