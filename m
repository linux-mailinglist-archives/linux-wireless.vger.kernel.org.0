Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780F8784167
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjHVM7Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjHVM7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E904CD0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwqXhB022565, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwqXhB022565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 20:59:14 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: mac: generalize code to indirectly access WiFi internal memory
Date:   Tue, 22 Aug 2023 20:58:18 +0800
Message-ID: <20230822125822.23817-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822125822.23817-1-pkshih@realtek.com>
References: <20230822125822.23817-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
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

To diagnose abnormal behavior, we need to dump certain internal memory.
For example, dump security CAM when debugging encryption/decryption
problems, or dump BA CAM when debugging abnormal BlockAck.

Since the indirect address and internal memory base address are different
between WiFi 6 and 7 chips, add fields to reuse codes.

Also, only WiFi 6 chips initialize DMAC and CMAC tables via this indirect
interface, so no need to change the constant register address, and
new firmware will help to initialize these tables.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 13 ++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c   | 25 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h   |  5 +++--
 drivers/net/wireless/realtek/rtw89/ser.c   | 20 +++++++++++------
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f6f1e90c3934..13b5937e918f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -793,6 +793,9 @@ static void rtw89_debug_dump_mac_mem(struct seq_file *m,
 				     struct rtw89_dev *rtwdev,
 				     u8 sel, u32 start_addr, u32 len)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 filter_model_addr = mac->filter_model_addr;
+	u32 indir_access_addr = mac->indir_access_addr;
 	u32 base_addr, start_page, residue;
 	u32 i, j, p, pages;
 	u32 dump_len, remain;
@@ -802,17 +805,17 @@ static void rtw89_debug_dump_mac_mem(struct seq_file *m,
 	pages = len / MAC_MEM_DUMP_PAGE_SIZE + 1;
 	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
 	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
-	base_addr = rtw89_mac_mem_base_addrs[sel];
+	base_addr = mac->mem_base_addrs[sel];
 	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
 
 	for (p = 0; p < pages; p++) {
 		dump_len = min_t(u32, remain, MAC_MEM_DUMP_PAGE_SIZE);
-		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, base_addr);
-		for (i = R_AX_INDIR_ACCESS_ENTRY + residue;
-		     i < R_AX_INDIR_ACCESS_ENTRY + dump_len;) {
+		rtw89_write32(rtwdev, filter_model_addr, base_addr);
+		for (i = indir_access_addr + residue;
+		     i < indir_access_addr + dump_len;) {
 			seq_printf(m, "%08xh:", i);
 			for (j = 0;
-			     j < 4 && i < R_AX_INDIR_ACCESS_ENTRY + dump_len;
+			     j < 4 && i < indir_access_addr + dump_len;
 			     j++, i += 4) {
 				val = rtw89_read32(rtwdev, i);
 				seq_printf(m, "  %08x", val);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index edfa1a2e677a..e0925a21a096 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -12,7 +12,7 @@
 #include "reg.h"
 #include "util.h"
 
-const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_NUM] = {
+static const u32 rtw89_mac_mem_base_addrs_ax[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
 	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
 	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
@@ -39,19 +39,21 @@ const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_NUM] = {
 static void rtw89_mac_mem_write(struct rtw89_dev *rtwdev, u32 offset,
 				u32 val, enum rtw89_mac_mem_sel sel)
 {
-	u32 addr = rtw89_mac_mem_base_addrs[sel] + offset;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 addr = mac->mem_base_addrs[sel] + offset;
 
-	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, addr);
-	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY, val);
+	rtw89_write32(rtwdev, mac->filter_model_addr, addr);
+	rtw89_write32(rtwdev, mac->indir_access_addr, val);
 }
 
 static u32 rtw89_mac_mem_read(struct rtw89_dev *rtwdev, u32 offset,
 			      enum rtw89_mac_mem_sel sel)
 {
-	u32 addr = rtw89_mac_mem_base_addrs[sel] + offset;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 addr = mac->mem_base_addrs[sel] + offset;
 
-	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, addr);
-	return rtw89_read32(rtwdev, R_AX_INDIR_ACCESS_ENTRY);
+	rtw89_write32(rtwdev, mac->filter_model_addr, addr);
+	return rtw89_read32(rtwdev, mac->indir_access_addr);
 }
 
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
@@ -3661,6 +3663,9 @@ static void rtw89_mac_dmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 {
 	u8 i;
 
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+		return;
+
 	for (i = 0; i < 4; i++) {
 		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR,
 			      DMAC_TBL_BASE_ADDR + (macid << 4) + (i << 2));
@@ -3670,6 +3675,9 @@ static void rtw89_mac_dmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 
 static void rtw89_mac_cmac_tbl_init(struct rtw89_dev *rtwdev, u8 macid)
 {
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+		return;
+
 	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR,
 		      CMAC_TBL_BASE_ADDR + macid * CCTL_INFO_SIZE);
 	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY, 0x4);
@@ -5678,5 +5686,8 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 
 const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.band1_offset = RTW89_MAC_AX_BAND_REG_OFFSET,
+	.filter_model_addr = R_AX_FILTER_MODEL_ADDR,
+	.indir_access_addr = R_AX_INDIR_ACCESS_ENTRY,
+	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 26a89130fa48..b31c78ca27da 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -327,8 +327,6 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_NUM,
 };
 
-extern const u32 rtw89_mac_mem_base_addrs[];
-
 enum rtw89_rpwm_req_pwr_state {
 	RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE = 0,
 	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND0_RFON = 1,
@@ -829,6 +827,9 @@ extern const struct rtw89_mac_size_set rtw89_mac_size;
 
 struct rtw89_mac_gen_def {
 	u32 band1_offset;
+	u32 filter_model_addr;
+	u32 indir_access_addr;
+	const u32 *mem_base_addrs;
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 0462ba693f6f..c1644353053f 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -529,6 +529,9 @@ static void ser_do_hci_st_hdl(struct rtw89_ser *ser, u8 evt)
 static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
 			     u8 sel, u32 start_addr, u32 len)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 filter_model_addr = mac->filter_model_addr;
+	u32 indir_access_addr = mac->indir_access_addr;
 	u32 *ptr = (u32 *)buf;
 	u32 base_addr, start_page, residue;
 	u32 cnt = 0;
@@ -536,14 +539,14 @@ static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
 
 	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
 	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
-	base_addr = rtw89_mac_mem_base_addrs[sel];
+	base_addr = mac->mem_base_addrs[sel];
 	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
 
 	while (cnt < len) {
-		rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, base_addr);
+		rtw89_write32(rtwdev, filter_model_addr, base_addr);
 
-		for (i = R_AX_INDIR_ACCESS_ENTRY + residue;
-		     i < R_AX_INDIR_ACCESS_ENTRY + MAC_MEM_DUMP_PAGE_SIZE;
+		for (i = indir_access_addr + residue;
+		     i < indir_access_addr + MAC_MEM_DUMP_PAGE_SIZE;
 		     i += 4, ptr++) {
 			*ptr = rtw89_read32(rtwdev, i);
 			cnt += 4;
@@ -585,6 +588,9 @@ static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
 				       const struct __fw_backtrace_entry *ent)
 {
 	struct __fw_backtrace_info *ptr = (struct __fw_backtrace_info *)buf;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 filter_model_addr = mac->filter_model_addr;
+	u32 indir_access_addr = mac->indir_access_addr;
 	u32 fwbt_addr = ent->wcpu_addr & RTW89_WCPU_BASE_MASK;
 	u32 fwbt_size = ent->size;
 	u32 fwbt_key = ent->key;
@@ -610,10 +616,10 @@ static int rtw89_ser_fw_backtrace_dump(struct rtw89_dev *rtwdev, u8 *buf,
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_SER, "dump fw backtrace start\n");
-	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, fwbt_addr);
+	rtw89_write32(rtwdev, filter_model_addr, fwbt_addr);
 
-	for (i = R_AX_INDIR_ACCESS_ENTRY;
-	     i < R_AX_INDIR_ACCESS_ENTRY + fwbt_size;
+	for (i = indir_access_addr;
+	     i < indir_access_addr + fwbt_size;
 	     i += RTW89_FW_BACKTRACE_INFO_SIZE, ptr++) {
 		*ptr = (struct __fw_backtrace_info){
 			.ra = rtw89_read32(rtwdev, i),
-- 
2.25.1

