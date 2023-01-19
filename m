Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF86731E9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASGoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjASGoM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:44:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36FB0F769
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:44:10 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6i2Pz9026322, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6i2Pz9026322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:44:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 Jan 2023 14:44:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:44:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: refine MCC C2H debug logs
Date:   Thu, 19 Jan 2023 14:43:42 +0800
Message-ID: <20230119064342.65391-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119064342.65391-1-pkshih@realtek.com>
References: <20230119064342.65391-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

To debug channel concurrency more centrally, we add a new debug flag,
RTW89_DBG_CHAN, for channel related things, especially channel concurrency.
Then, we change MCC (multi-channel concurrency) C2H (chip to host packets)
debug flag to it.

Besides, refine debug logs to show TSF in u64 directly.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c   | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index d1de5e600836c..079269bb5251c 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -28,6 +28,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_STATE = BIT(17),
 	RTW89_DBG_WOW = BIT(18),
 	RTW89_DBG_UL_TB = BIT(19),
+	RTW89_DBG_CHAN = BIT(20),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5ab0590485e0d..4239262659f78 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4263,12 +4263,12 @@ rtw89_mac_c2h_mcc_rcv_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 	case H2C_FUNC_MCC_SET_DURATION:
 		break;
 	default:
-		rtw89_debug(rtwdev, RTW89_DBG_FW,
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "invalid MCC C2H RCV ACK: func %d\n", func);
 		return;
 	}
 
-	rtw89_debug(rtwdev, RTW89_DBG_FW,
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 		    "MCC C2H RCV ACK: group %d, func %d\n", group, func);
 }
 
@@ -4296,12 +4296,12 @@ rtw89_mac_c2h_mcc_req_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 	case H2C_FUNC_DEL_MCC_GROUP:
 	case H2C_FUNC_RESET_MCC_GROUP:
 	default:
-		rtw89_debug(rtwdev, RTW89_DBG_FW,
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "invalid MCC C2H REQ ACK: func %d\n", func);
 		return;
 	}
 
-	rtw89_debug(rtwdev, RTW89_DBG_FW,
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 		    "MCC C2H REQ ACK: group %d, func %d, return code %d\n",
 		    group, func, retcode);
 
@@ -4329,6 +4329,11 @@ rtw89_mac_c2h_mcc_tsf_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 	rpt->tsf_y_low = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_Y(c2h->data);
 	rpt->tsf_y_high = RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_Y(c2h->data);
 
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC C2H TSF RPT: macid %d> %llu, macid %d> %llu\n",
+		    rpt->macid_x, (u64)rpt->tsf_x_high << 32 | rpt->tsf_x_low,
+		    rpt->macid_y, (u64)rpt->tsf_y_high << 32 | rpt->tsf_y_low);
+
 	cond = RTW89_MCC_WAIT_COND(group, H2C_FUNC_MCC_REQ_TSF);
 	rtw89_complete_cond(&rtwdev->mcc.wait, cond, &data);
 }
@@ -4386,14 +4391,14 @@ rtw89_mac_c2h_mcc_status_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 		rsp = false;
 		break;
 	default:
-		rtw89_debug(rtwdev, RTW89_DBG_FW,
+		rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 			    "invalid MCC C2H STS RPT: status %d\n", status);
 		return;
 	}
 
-	rtw89_debug(rtwdev, RTW89_DBG_FW,
-		    "MCC C2H STS RPT: group %d, macid %d, status %d, tsf {%d, %d}\n",
-		     group, macid, status, tsf_low, tsf_high);
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC C2H STS RPT: group %d, macid %d, status %d, tsf %llu\n",
+		     group, macid, status, (u64)tsf_high << 32 | tsf_low);
 
 	if (!rsp)
 		return;
-- 
2.25.1

