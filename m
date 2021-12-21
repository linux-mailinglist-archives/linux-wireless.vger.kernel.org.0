Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07547B81F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhLUCEV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 21:04:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49474 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhLUCCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 21:02:42 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BL22YyF4006213, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BL22YyF4006213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Dec 2021 10:02:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Dec 2021 10:02:34 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 10:02:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH] rtw88: don't consider deep PS mode when transmitting packet
Date:   Tue, 21 Dec 2021 10:02:30 +0800
Message-ID: <20211221020230.20764-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/21/2021 01:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzIxIKRXpMggMTI6MTk6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

In original flow, driver needs to ensure chip leave deep ps mode
before transmitting any packet, and don't enter deep ps mode beofre
PCIE DMA is finished. Now with the support of 8822ce's hardware
setting and firmware after v9.9.11, these limits are removed.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.h  | 1 +
 drivers/net/wireless/realtek/rtw88/pci.c | 8 ++++++--
 drivers/net/wireless/realtek/rtw88/ps.c  | 3 +++
 drivers/net/wireless/realtek/rtw88/ps.h  | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 09c7afb99e631..3d1ba29b8c869 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -98,6 +98,7 @@ enum rtw_fw_feature {
 	FW_FEATURE_LPS_C2H = BIT(1),
 	FW_FEATURE_LCLK = BIT(2),
 	FW_FEATURE_PG = BIT(3),
+	FW_FEATURE_TX_WAKE = BIT(4),
 	FW_FEATURE_BCN_FILTER = BIT(5),
 	FW_FEATURE_NOTIFY_SCAN = BIT(6),
 	FW_FEATURE_ADAPTIVITY = BIT(7),
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 08cf66141889b..a0991d3f15c01 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -611,6 +611,9 @@ static void rtw_pci_deep_ps_enter(struct rtw_dev *rtwdev)
 	bool tx_empty = true;
 	u8 queue;
 
+	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
+		goto enter_deep_ps;
+
 	lockdep_assert_held(&rtwpci->irq_lock);
 
 	/* Deep PS state is not allowed to TX-DMA */
@@ -636,7 +639,7 @@ static void rtw_pci_deep_ps_enter(struct rtw_dev *rtwdev)
 			"TX path not empty, cannot enter deep power save state\n");
 		return;
 	}
-
+enter_deep_ps:
 	set_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags);
 	rtw_power_mode_change(rtwdev, true);
 }
@@ -807,7 +810,8 @@ static void rtw_pci_tx_kick_off_queue(struct rtw_dev *rtwdev, u8 queue)
 	bd_idx = rtw_pci_tx_queue_idx_addr[queue];
 
 	spin_lock_bh(&rtwpci->irq_lock);
-	rtw_pci_deep_ps_leave(rtwdev);
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
+		rtw_pci_deep_ps_leave(rtwdev);
 	rtw_write16(rtwdev, bd_idx, ring->r.wp & TRX_BD_IDX_MASK);
 	spin_unlock_bh(&rtwpci->irq_lock);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 3f0ac33156d6a..bfa64c038f5f0 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -83,6 +83,9 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 	/* Each request require an ack from firmware */
 	request |= POWER_MODE_ACK;
 
+	if (rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_TX_WAKE))
+		request |= POWER_TX_WAKE;
+
 	rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
 
 	/* Check firmware get the power requset and ack via cpwm register */
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 7819391c86638..c194386f6db53 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -9,6 +9,7 @@
 
 #define POWER_MODE_ACK		BIT(6)
 #define POWER_MODE_PG		BIT(4)
+#define POWER_TX_WAKE		BIT(1)
 #define POWER_MODE_LCLK		BIT(0)
 
 #define LEAVE_LPS_TRY_CNT	5
-- 
2.25.1

