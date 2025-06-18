Return-Path: <linux-wireless+bounces-24248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1889ADECF9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04293B40B6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10852AD18;
	Wed, 18 Jun 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="C1CQUfRr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374D2E06FA
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250849; cv=none; b=OJ7BFBz+tmkYbUQfu69tFetJ23m5cQ2XTM53wjJfd/UdFJfYvZzYumO9XgiWP1OXp9tMX6HTyLGXU1iSBiwXxBefXw/dULp+vHmUFw73pW5dX3usc15wIjaVyhqy03PiFZvuVw94ho5TJ0iCV3nnXAZ4xDi5MeDV5PATmwodJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250849; c=relaxed/simple;
	bh=KxZYMDBuXKBZV4Tv6FkdS7dKWmsUgml21Qayrd9hFB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWgST5Z77E0IWxCt7NiwbDDg/8JONJSEeGb+3kGcAcwDDSHOtS426ZQL9VwqsFzvg1CRLB7RvW9rJ/PXooJCNXlBkeitAR7/rdwkMBCXVtSPrp8VfkkG42Y4HVSo1EETf7sG7jAk1m49qLPifiZU7pV5B840YEWZwHaZOh2wbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C1CQUfRr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClO3k94151144, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250844; bh=uORYtniRuecOHWG7dvTHHN2wy35C8J0qbJeUFq2/ESo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C1CQUfRrHzbkLDzsjOF1DEtdZzkwd4j6qEY20JlKm27RkdIU0n9Eeowk8myeVIjYW
	 PSoa+3HiCAD/dnX9NRMJS3IVqvxQ67d8zsUXe8icGjkeir2OKx5f3YczexLTOc3OIt
	 XaWV5I7r6OQa1LEakP5f+vy90ptkOAo2L4OaHZ/UybFu+rvn5q5tTw8DaTbdPpFHNG
	 TVlK48wut6nz4oLa2k9Tx5ln2J0BzGSydwehwk5t33YjwqhyzzW9RFIxeVcTYu2eSV
	 1NlAW8fcmxQroRgCpLqq2telJhlJoRraa9V9oAHuT8snBU0xpm9UK47rvGalY4Nktr
	 R3E2tuMEHRSaA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClO3k94151144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 20:47:31 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/6] wifi: rtw89: mac: differentiate mem_page_size by chip generation
Date: Wed, 18 Jun 2025 20:46:44 +0800
Message-ID: <20250618124649.11436-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618124649.11436-1-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

When debugging or recovering system error recovery (SER), it's
necessary to dump internal memory to perform status inspection.
Since the memory page size differs between WiFi 6 and 7 chips,
define them accordingly.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c  | 13 +++++++------
 drivers/net/wireless/realtek/rtw89/mac.c    |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h    |  5 ++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c    | 11 ++++++-----
 5 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d6016fa107fb..4acb567b3ad4 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -1114,6 +1114,7 @@ static int rtw89_debug_dump_mac_mem(struct rtw89_dev *rtwdev,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 filter_model_addr = mac->filter_model_addr;
 	u32 indir_access_addr = mac->indir_access_addr;
+	u32 mem_page_size = mac->mem_page_size;
 	u32 base_addr, start_page, residue;
 	char *p = buf, *end = buf + bufsz;
 	u32 i, j, pp, pages;
@@ -1121,14 +1122,14 @@ static int rtw89_debug_dump_mac_mem(struct rtw89_dev *rtwdev,
 	u32 val;
 
 	remain = len;
-	pages = len / MAC_MEM_DUMP_PAGE_SIZE + 1;
-	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
-	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
+	pages = len / mem_page_size + 1;
+	start_page = start_addr / mem_page_size;
+	residue = start_addr % mem_page_size;
 	base_addr = mac->mem_base_addrs[sel];
-	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
+	base_addr += start_page * mem_page_size;
 
 	for (pp = 0; pp < pages; pp++) {
-		dump_len = min_t(u32, remain, MAC_MEM_DUMP_PAGE_SIZE);
+		dump_len = min_t(u32, remain, mem_page_size);
 		rtw89_write32(rtwdev, filter_model_addr, base_addr);
 		for (i = indir_access_addr + residue;
 		     i < indir_access_addr + dump_len;) {
@@ -1142,7 +1143,7 @@ static int rtw89_debug_dump_mac_mem(struct rtw89_dev *rtwdev,
 			}
 			p += scnprintf(p, end - p, "\n");
 		}
-		base_addr += MAC_MEM_DUMP_PAGE_SIZE;
+		base_addr += mem_page_size;
 	}
 
 	return p - buf;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8ec86e1fa9d6..53628838a7c5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6914,6 +6914,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.filter_model_addr = R_AX_FILTER_MODEL_ADDR,
 	.indir_access_addr = R_AX_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
+	.mem_page_size = MAC_MEM_DUMP_PAGE_SIZE_AX,
 	.rx_fltr = R_AX_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_ax,
 	.agg_len_ht = R_AX_AGG_LEN_HT_0,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index c1cbc53b16a7..b7fd4a0fdb84 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -8,7 +8,9 @@
 #include "core.h"
 #include "reg.h"
 
-#define MAC_MEM_DUMP_PAGE_SIZE 0x40000
+#define MAC_MEM_DUMP_PAGE_SIZE_AX 0x40000
+#define MAC_MEM_DUMP_PAGE_SIZE_BE 0x80000
+
 #define ADDR_CAM_ENT_SIZE  0x40
 #define ADDR_CAM_ENT_SHORT_SIZE 0x20
 #define BSSID_CAM_ENT_SIZE 0x08
@@ -970,6 +972,7 @@ struct rtw89_mac_gen_def {
 	u32 filter_model_addr;
 	u32 indir_access_addr;
 	const u32 *mem_base_addrs;
+	u32 mem_page_size;
 	u32 rx_fltr;
 	const struct rtw89_port_reg *port_base;
 	u32 agg_len_ht;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 8c9d326dc907..0078080b3999 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2567,6 +2567,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
 	.indir_access_addr = R_BE_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
+	.mem_page_size = MAC_MEM_DUMP_PAGE_SIZE_BE,
 	.rx_fltr = R_BE_RX_FLTR_OPT,
 	.port_base = &rtw89_port_base_be,
 	.agg_len_ht = R_BE_AGG_LEN_HT_0,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 811c91481441..d504518b8a57 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -566,21 +566,22 @@ static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 filter_model_addr = mac->filter_model_addr;
 	u32 indir_access_addr = mac->indir_access_addr;
+	u32 mem_page_size = mac->mem_page_size;
 	u32 *ptr = (u32 *)buf;
 	u32 base_addr, start_page, residue;
 	u32 cnt = 0;
 	u32 i;
 
-	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
-	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
+	start_page = start_addr / mem_page_size;
+	residue = start_addr % mem_page_size;
 	base_addr = mac->mem_base_addrs[sel];
-	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
+	base_addr += start_page * mem_page_size;
 
 	while (cnt < len) {
 		rtw89_write32(rtwdev, filter_model_addr, base_addr);
 
 		for (i = indir_access_addr + residue;
-		     i < indir_access_addr + MAC_MEM_DUMP_PAGE_SIZE;
+		     i < indir_access_addr + mem_page_size;
 		     i += 4, ptr++) {
 			*ptr = rtw89_read32(rtwdev, i);
 			cnt += 4;
@@ -589,7 +590,7 @@ static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
 		}
 
 		residue = 0;
-		base_addr += MAC_MEM_DUMP_PAGE_SIZE;
+		base_addr += mem_page_size;
 	}
 }
 
-- 
2.25.1


