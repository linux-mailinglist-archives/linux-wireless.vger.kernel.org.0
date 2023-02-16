Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA71698972
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 01:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBPArp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 19:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPAro (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 19:47:44 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEBA40C3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 16:47:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31G0lQOZ1011281, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31G0lQOZ1011281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Feb 2023 08:47:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 16 Feb 2023 08:47:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Feb
 2023 08:47:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <Jes.Sorensen@gmail.com>, <kvalo@kernel.org>
CC:     <rtl8821cerfe2@gmail.com>, <error27@gmail.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtl8xxxu: 8188e: parse single one element of RA report for station mode
Date:   Thu, 16 Feb 2023 08:46:54 +0800
Message-ID: <20230216004654.4642-1-pkshih@realtek.com>
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

Intentionally parsing single one element of RA report by breaking loop
causes a smatch warning:
  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c:1678 rtl8188e_handle_ra_tx_report2() warn:
  ignoring unreachable code.

With existing comments, it intends to process single one element for
station mode, but it will parse more elements in AP mode if it's
implemented. Implement program logic according to existing comment to avoid
smatch warning, and also be usable for both AP and stations modes.

Compile test only.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302142135.LCqUTVGY-lkp@intel.com/
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index a99ddb41cd244..f15b099899e5c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1699,6 +1699,12 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *s
 
 	dev_dbg(dev, "%s: len: %d items: %d\n", __func__, tx_rpt_len, items);
 
+	/* We only use macid 0, so only the first item is relevant.
+	 * AP mode will use more of them if it's ever implemented.
+	 */
+	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION)
+		items = 1;
+
 	for (macid = 0; macid < items; macid++) {
 		valid = false;
 
@@ -1741,12 +1747,6 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_priv *priv, struct sk_buff *s
 			min_rpt_time = ra->rpt_time;
 
 		rpt += TX_RPT2_ITEM_SIZE;
-
-		/*
-		 * We only use macid 0, so only the first item is relevant.
-		 * AP mode will use more of them if it's ever implemented.
-		 */
-		break;
 	}
 
 	if (min_rpt_time != ra->pre_min_rpt_time) {
-- 
2.25.1

