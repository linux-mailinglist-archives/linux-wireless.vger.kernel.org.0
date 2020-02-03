Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8933315018F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 07:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgBCGCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 01:02:16 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53592 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgBCGCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 01:02:16 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0136256M007987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0136256M007987
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Feb 2020 14:02:05 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 14:02:05 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 14:02:05 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Mon, 3 Feb 2020 14:02:05 +0800
Received: from localhost.localdomain (172.21.69.117) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 3 Feb 2020 14:02:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <natechancellor@gmail.com>
Subject: [PATCH 5.6] rtw88: Fix return value of rtw_wow_check_fw_status
Date:   Mon, 3 Feb 2020 14:01:57 +0800
Message-ID: <20200203060157.15330-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.117]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Clang warns that ret is used uninitialzed.
And we found that actually the return type should be "int" instead
of "bool".

Fixes: 44bc17f7f5b3 ("rtw88: support wowlan feature for 8822c")
Link: https://github.com/ClangBuiltLinux/linux/issues/850
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/wow.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index af5c27e1bb07..4820dca958dd 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -281,27 +281,26 @@ static void rtw_wow_rx_dma_start(struct rtw_dev *rtwdev)
 	rtw_write32_clr(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE);
 }
 
-static bool rtw_wow_check_fw_status(struct rtw_dev *rtwdev, bool wow_enable)
+static int rtw_wow_check_fw_status(struct rtw_dev *rtwdev, bool wow_enable)
 {
-	bool ret;
-
 	/* wait 100ms for wow firmware to finish work */
 	msleep(100);
 
 	if (wow_enable) {
-		if (!rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON))
-			ret = 0;
+		if (rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON))
+			goto wow_fail;
 	} else {
-		if (rtw_read32_mask(rtwdev, REG_FE1IMR, BIT_FS_RXDONE) == 0 &&
-		    rtw_read32_mask(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE) == 0)
-			ret = 0;
+		if (rtw_read32_mask(rtwdev, REG_FE1IMR, BIT_FS_RXDONE) ||
+		    rtw_read32_mask(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE))
+			goto wow_fail;
 	}
 
-	if (ret)
-		rtw_err(rtwdev, "failed to check wow status %s\n",
-			wow_enable ? "enabled" : "disabled");
+	return 0;
 
-	return ret;
+wow_fail:
+	rtw_err(rtwdev, "failed to check wow status %s\n",
+		wow_enable ? "enabled" : "disabled");
+	return -EBUSY;
 }
 
 static void rtw_wow_fw_security_type_iter(struct ieee80211_hw *hw,
-- 
2.17.1

