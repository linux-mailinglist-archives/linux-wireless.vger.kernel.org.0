Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C272CCC56
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 03:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLCCQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 21:16:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51733 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLCCQ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 21:16:56 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B32G8sY4005642, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B32G8sY4005642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 3 Dec 2020 10:16:08 +0800
Received: from localhost (172.21.69.213) by RTEXMB04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 3 Dec 2020
 10:16:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <pkshih@realtek.com>
Subject: [PATCH] rtw88: reduce polling time of IQ calibration
Date:   Thu, 3 Dec 2020 10:16:02 +0800
Message-ID: <20201203021602.9414-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

When 8822CE is associating with AP, driver will poll status bit of
IQ calibration to confirm the IQ calibration is done, and then move on
the association process. Current polling time for IQ calibration is 6
seconds.

But occasionally driver fails in polling the status bit because the status
bit is not set after IQ calibration is done. When it happends, association
process will be serieously delayed up to 6 seconds. To avoid it, we reduce
polling time to 300ms, in which the IQ calibration can be done.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 7dd3ccb73793..7661d8d494c9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2108,22 +2108,21 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
 {
+#define IQK_DONE_8822C 0xaa
+
 	struct rtw_iqk_para para = {0};
 	u8 iqk_chk;
-	int counter;
+	int ret;
 
 	para.clear = 1;
 	rtw_fw_do_iqk(rtwdev, &para);
 
-	for (counter = 0; counter < 300; counter++) {
-		iqk_chk = rtw_read8(rtwdev, REG_RPT_CIP);
-		if (iqk_chk == 0xaa)
-			break;
-		msleep(20);
-	}
-	rtw_write8(rtwdev, REG_IQKSTAT, 0x0);
+	ret = read_poll_timeout(rtw_read8, iqk_chk, iqk_chk == IQK_DONE_8822C,
+				20000, 300000, false, rtwdev, REG_RPT_CIP);
+	if (ret)
+		rtw_warn(rtwdev, "failed to poll iqk status bit\n");
 
-	rtw_dbg(rtwdev, RTW_DBG_RFK, "iqk counter=%d\n", counter);
+	rtw_write8(rtwdev, REG_IQKSTAT, 0x0);
 }
 
 /* for coex */
-- 
2.21.0

