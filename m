Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202E69C5FB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBTH3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTH3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 02:29:17 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77AEFA8
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 23:29:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K72jXZ2025222, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K72jXZ2025222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 15:02:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Feb 2023 15:02:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Feb
 2023 15:02:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: add tx_wake notify for 8852B
Date:   Mon, 20 Feb 2023 15:01:57 +0800
Message-ID: <20230220070202.29868-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220070202.29868-1-pkshih@realtek.com>
References: <20230220070202.29868-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

8852B has the same issue: management frames get stuck when wifi
chip enters low ps mode, so we alse add notify wake function to
trigger wifi chip wake before forwarding management frames.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0b73dc2e9ad77..3acbb0e3a55a3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -258,6 +258,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 38, 0, PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, NO_LPS_PG),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 20, 0, PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
-- 
2.25.1

