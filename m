Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02146A17D8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBXIWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 03:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBXIWQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 03:22:16 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02446165
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 00:22:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31O8Lsh16017151, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31O8Lsh16017151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 24 Feb 2023 16:21:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Feb 2023 16:21:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Feb
 2023 16:21:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fix SER L1 might stop entering LPS issue
Date:   Fri, 24 Feb 2023 16:21:17 +0800
Message-ID: <20230224082117.21241-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

When SER L1 triggered, driver need to stop Rx and clear RTW89_FLAG_RUNNING
flag. If track_work check RTW89_FLAG_RUNNING simultaneously, it will check
failed and never queue track_work again, and LPS won't enter either.
Therefore, we cancel delayed work when enter SER L1, and queue delayed work
when leave SER L1.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/ser.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 61db7189fdab8..9e9f6947e7f14 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -414,8 +414,11 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 
 static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
 	switch (evt) {
 	case SER_EV_STATE_IN:
+		cancel_delayed_work_sync(&rtwdev->track_work);
 		drv_stop_tx(ser);
 
 		if (hal_stop_dma(ser)) {
@@ -446,6 +449,8 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		hal_enable_dma(ser);
 		drv_resume_rx(ser);
 		drv_resume_tx(ser);
+		ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
+					     RTW89_TRACK_WORK_PERIOD);
 		break;
 
 	default:
-- 
2.25.1

