Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494C787FC7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjHYGZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 02:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHYGZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 02:25:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09851BDB
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 23:24:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P6OPSU0023129, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P6OPSU0023129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 14:24:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 25 Aug 2023 14:24:48 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 25 Aug
 2023 14:24:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
Date:   Fri, 25 Aug 2023 14:24:04 +0800
Message-ID: <20230825062404.50813-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

The probe function of 8822cu is misplaced to 8822bu, so we fix it.

Fixes: 07cef03b8d44 ("wifi: rtw88: Add rtw8822cu chipset support")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
index af28ca09d41f..157d5102a4b1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
@@ -25,7 +25,7 @@ static const struct usb_device_id rtw_8822cu_id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822cu_id_table);
 
-static int rtw8822bu_probe(struct usb_interface *intf,
+static int rtw8822cu_probe(struct usb_interface *intf,
 			   const struct usb_device_id *id)
 {
 	return rtw_usb_probe(intf, id);
@@ -34,7 +34,7 @@ static int rtw8822bu_probe(struct usb_interface *intf,
 static struct usb_driver rtw_8822cu_driver = {
 	.name = "rtw_8822cu",
 	.id_table = rtw_8822cu_id_table,
-	.probe = rtw8822bu_probe,
+	.probe = rtw8822cu_probe,
 	.disconnect = rtw_usb_disconnect,
 };
 module_usb_driver(rtw_8822cu_driver);
-- 
2.25.1

