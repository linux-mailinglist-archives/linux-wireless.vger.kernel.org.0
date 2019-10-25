Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5EE4760
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393259AbfJYJd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 05:33:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50466 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfJYJd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P9XoIs026483, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P9XoIs026483
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:33:50 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 17:33:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
Subject: [PATCH 4/6] rtw88: rearrange if..else statements for rx rate indexes
Date:   Fri, 25 Oct 2019 17:33:43 +0800
Message-ID: <20191025093345.22643-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025093345.22643-1-yhchuang@realtek.com>
References: <20191025093345.22643-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Driver just memset() rx_status to 0 before assigning rate indexes.
And driver could never hit the 'else' because the driver checks
if 'pkt_stat->rate >= DESC_RATEMCS0', so the 'else' statement can
be removed.

Also rearrange the if..else statements because DESC_RATEMCS0 is
actually larger than DESC_RATE1M ~ DESC_RATE54M, move the check
of 'pkt_stat->rate >= DESC_RATEMCS0' to the last to keep an
increasing order.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 36887f998090..9b90339ab697 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -160,19 +160,17 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 	else if (pkt_stat->rate >= DESC_RATEMCS0)
 		rx_status->encoding = RX_ENC_HT;
 
-	if (pkt_stat->rate >= DESC_RATEMCS0) {
-		rtw_desc_to_mcsrate(pkt_stat->rate, &rx_status->rate_idx,
-				    &rx_status->nss);
-	} else if (rx_status->band == NL80211_BAND_5GHZ &&
-		   pkt_stat->rate >= DESC_RATE6M &&
-		   pkt_stat->rate <= DESC_RATE54M) {
+	if (rx_status->band == NL80211_BAND_5GHZ &&
+	    pkt_stat->rate >= DESC_RATE6M &&
+	    pkt_stat->rate <= DESC_RATE54M) {
 		rx_status->rate_idx = pkt_stat->rate - DESC_RATE6M;
 	} else if (rx_status->band == NL80211_BAND_2GHZ &&
 		   pkt_stat->rate >= DESC_RATE1M &&
 		   pkt_stat->rate <= DESC_RATE54M) {
 		rx_status->rate_idx = pkt_stat->rate - DESC_RATE1M;
-	} else {
-		rx_status->rate_idx = 0;
+	} else if (pkt_stat->rate >= DESC_RATEMCS0) {
+		rtw_desc_to_mcsrate(pkt_stat->rate, &rx_status->rate_idx,
+				    &rx_status->nss);
 	}
 
 	rx_status->flag |= RX_FLAG_MACTIME_START;
-- 
2.17.1

