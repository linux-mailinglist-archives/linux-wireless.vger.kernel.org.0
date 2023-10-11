Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2F7C4AC1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjJKGh5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 02:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbjJKGh4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 02:37:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7359B
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 23:37:54 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B6bhfbF3659990, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B6bhfbF3659990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 14:37:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 11 Oct 2023 14:37:43 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 11 Oct
 2023 14:37:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <keescook@chromium.org>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: coex: add annotation __counted_by() for struct rtw89_btc_btf_set_slot_table
Date:   Wed, 11 Oct 2023 14:37:24 +0800
Message-ID: <20231011063725.25276-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Use struct_size() and flex_array_size() helpers to calculate proper sizes
for allocation and memcpy().

Don't change logic at all, and result is identical as before.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 4ba8b3df70ae..9f9da122f3f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -237,7 +237,7 @@ struct rtw89_btc_btf_set_report {
 struct rtw89_btc_btf_set_slot_table {
 	u8 fver;
 	u8 tbl_num;
-	u8 buf[];
+	struct rtw89_btc_fbtc_slot tbls[] __counted_by(tbl_num);
 } __packed;
 
 struct rtw89_btc_btf_set_mon_reg {
@@ -1821,19 +1821,17 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev, u8 num,
 				   struct rtw89_btc_fbtc_slot *s)
 {
-	struct rtw89_btc_btf_set_slot_table *tbl = NULL;
-	u8 *ptr = NULL;
-	u16 n = 0;
+	struct rtw89_btc_btf_set_slot_table *tbl;
+	u16 n;
 
-	n = sizeof(*s) * num + sizeof(*tbl);
+	n = struct_size(tbl, tbls, num);
 	tbl = kmalloc(n, GFP_KERNEL);
 	if (!tbl)
 		return;
 
 	tbl->fver = BTF_SET_SLOT_TABLE_VER;
 	tbl->tbl_num = num;
-	ptr = &tbl->buf[0];
-	memcpy(ptr, s, num * sizeof(*s));
+	memcpy(tbl->tbls, s, flex_array_size(tbl, tbls, num));
 
 	_send_fw_cmd(rtwdev, BTFC_SET, SET_SLOT_TABLE, tbl, n);
 
-- 
2.25.1

