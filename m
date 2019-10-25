Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F9E475C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfJYJd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 05:33:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50464 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfJYJd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:56 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P9XnOi026479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P9XnOi026479
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:33:49 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 17:33:49 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
Subject: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
Date:   Fri, 25 Oct 2019 17:33:42 +0800
Message-ID: <20191025093345.22643-4-yhchuang@realtek.com>
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

If the number of packets is less than the LPS threshold, driver
can then enter LPS mode.
And driver used to take RTW_LPS_THRESHOLD as the threshold. As
the macro can not be changed after compiled, use a parameter
instead.

The larger of the threshold, the more traffic required to leave
power save mode, responsive time could be longer, but also the
power consumption could be lower.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 7 +++++--
 drivers/net/wireless/realtek/rtw88/ps.h   | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7c1b89c4fb6c..bff8a0b129d9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -16,16 +16,19 @@
 #include "debug.h"
 #include "bf.h"
 
+unsigned int rtw_lps_threshold = 2;
 unsigned int rtw_fw_lps_deep_mode;
 EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
 bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
 
+module_param_named(lps_threshold, rtw_lps_threshold, uint, 0644);
 module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
 module_param_named(support_bf, rtw_bf_support, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
+MODULE_PARM_DESC(lps_threshold, "Threshold of number of packets in every 2 seconds");
 MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
 MODULE_PARM_DESC(support_bf, "Set Y to enable beamformee support");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
@@ -199,8 +202,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev);
 
-	if (stats->tx_cnt > RTW_LPS_THRESHOLD ||
-	    stats->rx_cnt > RTW_LPS_THRESHOLD)
+	if (stats->tx_cnt > rtw_lps_threshold ||
+	    stats->rx_cnt > rtw_lps_threshold)
 		ps_active = true;
 	else
 		ps_active = false;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 25925eedbad4..fe43f8d96d04 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -5,8 +5,6 @@
 #ifndef __RTW_PS_H_
 #define __RTW_PS_H_
 
-#define RTW_LPS_THRESHOLD	2
-
 #define POWER_MODE_ACK		BIT(6)
 #define POWER_MODE_PG		BIT(4)
 #define POWER_MODE_LCLK		BIT(0)
-- 
2.17.1

