Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76924B5F57
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 01:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiBOAtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 19:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBOAtw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 19:49:52 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5723D13C390
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 16:49:43 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21F0nagN7021060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21F0nagN7021060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 08:49:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Feb 2022 08:49:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Feb
 2022 08:49:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH v2 6/6] rtw88: coex: Update rtl8822c COEX version to 22020720
Date:   Tue, 15 Feb 2022 08:48:55 +0800
Message-ID: <20220215004855.4098-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215004855.4098-1-pkshih@realtek.com>
References: <20220215004855.4098-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/15/2022 00:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTQgpFWkyCAwODo0MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Enable Wi-Fi/BT mailbox 0x45 handshake and Wi-Fi MIMO power save
mechanism for Bluetooth gaming controller.

BTCOEX Version: 22020720-2020
Desired_BT_Coex_Ver: 0x20
Desired_WL_FW_Ver: 9.9.11

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 39daca4405935..87ff1cf4ad7ec 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5374,8 +5374,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
 	.max_sched_scan_ssids = 4,
 #endif
-	.coex_para_ver = 0x2103181c,
-	.bt_desired_ver = 0x1c,
+	.coex_para_ver = 0x22020720,
+	.bt_desired_ver = 0x20,
 	.scbd_support = true,
 	.new_scbd10_def = true,
 	.ble_hid_profile_support = true,
-- 
2.25.1

