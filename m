Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ABC7047B2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEPIZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPIZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 04:25:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87E40D3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 01:25:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34G8OwJoA024354, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34G8OwJoA024354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 16 May 2023 16:24:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 16 May 2023 16:25:07 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 May
 2023 16:25:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: tweak H2C TX waiting function for SER
Date:   Tue, 16 May 2023 16:24:40 +0800
Message-ID: <20230516082441.11154-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516082441.11154-1-pkshih@realtek.com>
References: <20230516082441.11154-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some specific H2C (host to chip command) needs waiting until FW ACK by
C2H (chip to host event). However, during SER (system error recovery),
most interrupts are disabled, so we can't receive C2H immediately. It
causes this kind of H2C TX waits will always time out during SER.

To save time spent by SER, we don't do these redundant waits. And, to
make a difference from -ETIMEDOUT in other cases, we make the function
return 1 for SER case. When some H2C callers really catch `ret == 1` at
runtime, they can determine whether it's reasonable or not, and consider
how to resolve their flow if needed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/ser.c  | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b60cd9852259e..5893ac9eb3f9b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3504,6 +3504,7 @@ enum rtw89_flags {
 	RTW89_FLAG_LOW_POWER_MODE,
 	RTW89_FLAG_INACTIVE_PS,
 	RTW89_FLAG_CRASH_SIMULATING,
+	RTW89_FLAG_SER_HANDLING,
 	RTW89_FLAG_WOWLAN,
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 	RTW89_FLAG_CHANGING_INTERFACE,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ad277f22b1973..b7befcfd4a913 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3792,6 +3792,11 @@ int rtw89_fw_wow_cam_update(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+/* Return < 0, if failures happen during waiting for the condition.
+ * Return 0, when waiting for the condition succeeds.
+ * Return > 0, if the wait is considered unreachable due to driver/FW design,
+ * where 1 means during SER.
+ */
 static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 				 struct rtw89_wait_info *wait, unsigned int cond)
 {
@@ -3804,6 +3809,9 @@ static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		return -EBUSY;
 	}
 
+	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+		return 1;
+
 	return rtw89_wait_for_cond(wait, cond);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 54b314b8b3292..0462ba693f6fd 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -409,6 +409,7 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		rtw89_hci_recovery_complete(rtwdev);
+		clear_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
 		break;
 	case SER_EV_L1_RESET_PREPARE:
@@ -421,6 +422,7 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 		ser_state_goto(ser, SER_L2_RESET_ST);
 		break;
 	case SER_EV_STATE_OUT:
+		set_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags);
 		rtw89_hci_recovery_start(rtwdev);
 		break;
 	default:
-- 
2.25.1

