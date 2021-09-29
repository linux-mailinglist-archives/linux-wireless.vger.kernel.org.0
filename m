Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2841C1F5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbhI2JtS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 05:49:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38668 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbhI2JtR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 05:49:17 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18T9lT481020604, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18T9lT481020604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 17:47:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 17:47:29 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 29 Sep
 2021 17:47:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: consider triggering state of simulating fw crash
Date:   Wed, 29 Sep 2021 17:47:24 +0800
Message-ID: <20210929094724.23595-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2021 09:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjkgpFekyCAwNzoyODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In certain cases, triggering fw crash simulation via fw_crash debugfs
will take a while. If the state is queried too early before restart
begins processing, it may mistakenly think restart process has been
done. If some tests are started at this time, something unexpected
might happen due to the follow-up restart process.

To avoid that, we consider the triggering state.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 5 ++++-
 drivers/net/wireless/realtek/rtw88/main.c  | 1 +
 drivers/net/wireless/realtek/rtw88/main.h  | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index babf7fb238cc..682b23502e6e 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -886,6 +886,7 @@ static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
 
 	mutex_lock(&rtwdev->mutex);
 	rtw_leave_lps_deep(rtwdev);
+	set_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags);
 	rtw_write8(rtwdev, REG_HRCV_MSG, 1);
 	mutex_unlock(&rtwdev->mutex);
 
@@ -897,7 +898,9 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 
-	seq_printf(m, "%d\n", test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
+	seq_printf(m, "%d\n",
+		   test_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags) ||
+		   test_bit(RTW_FLAG_RESTARTING, rtwdev->flags));
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index cee2acabb042..a0d4d6e31fb4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -564,6 +564,7 @@ static void __fw_recovery_work(struct rtw_dev *rtwdev)
 	int ret = 0;
 
 	set_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
+	clear_bit(RTW_FLAG_RESTART_TRIGGERING, rtwdev->flags);
 
 	ret = rtw_fwcd_prep(rtwdev);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 723316347876..bbdd535b64e7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -363,6 +363,7 @@ enum rtw_flags {
 	RTW_FLAG_BUSY_TRAFFIC,
 	RTW_FLAG_WOWLAN,
 	RTW_FLAG_RESTARTING,
+	RTW_FLAG_RESTART_TRIGGERING,
 
 	NUM_OF_RTW_FLAGS,
 };
-- 
2.25.1

