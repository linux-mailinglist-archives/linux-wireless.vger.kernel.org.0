Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBED42AFECF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgKLFi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38672 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FUYc8025856, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FUYc8025856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 03/11] rtw88: coex: add write scoreboard action when WLAN in critical procedure
Date:   Thu, 12 Nov 2020 11:14:22 +0800
Message-ID: <20201112031430.4846-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
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

When WLAN in critical procedure, such as connecting, scan and so on,
coexistence will notify BT by scoreboard.
While BT firmware received the scoreboard interrupt, it will adjust
BT page priority lower to avoid WLAN critical procedure suffering impact.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index f0d300e197b7..cbc0b7417887 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -460,6 +460,12 @@ static void rtw_coex_update_wl_link_info(struct rtw_dev *rtwdev, u8 reason)
 		coex_dm->wl_rssi_state[i] = rssi_state;
 	}
 
+	if (coex_stat->wl_linkscan_proc || coex_stat->wl_hi_pri_task1 ||
+	    coex_stat->wl_hi_pri_task2 || coex_stat->wl_gl_busy)
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, true);
+	else
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_SCAN, false);
+
 	switch (reason) {
 	case COEX_RSN_5GSCANSTART:
 	case COEX_RSN_5GSWITCHBAND:
-- 
2.21.0

