Return-Path: <linux-wireless+bounces-30801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5461D1BF85
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 097E5300872F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF81B6527;
	Wed, 14 Jan 2026 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wvdu8W8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2E2874E1
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354870; cv=none; b=oerI4MSZ8tgIizdD+JwfCTk+YtdGt4IXts9bjsA9w5fbAdO6+KAsk4+NX2fIkcASUdCJAfom6vbzSaecF2rikNnv/MeAacwONQvdGZ2JiGbIz/QQBatmDT+yxye5RTDV0TAIQMWkzKKjZvy96N7mCuva5gns+uxZJPLFDJbUjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354870; c=relaxed/simple;
	bh=1N8ecda4wIPbMghUHkqaaJ62U8sR4NR9cw+33csSWJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrkoeiOtnkAMlvNPWv0lBtWXzuwRE266RwLvcXdMKytdF10sMVZRJa7Aohi65euE+2aIe0soN16nzTFVgfvfgoYlgzuyUovz7SoJV7hiMoa3gOVGVwWVCz2noS+GojAACu74LihbW/9kH9kxj/Wmgcd/mzV/AYcvfmWHBrXPcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wvdu8W8r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1f6PW14168639, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354866; bh=DFCdxnsuYKP2nJ97ysQXzCHx/MeGWrWTdrBbGXAXeoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wvdu8W8rnYMCCH+8wN1iofz7PhfEHVQFI9ad+FUBErsyFGj0LA5rh5UZrp5zq2sb+
	 X390AuooxpV2KjI5kaKVcGYCXSWO3crp7LbKZnMnd5UW+CcLQ52lxsXNkZdAAueHiB
	 gfAS9xOQP4qer9DVk/EB1Kb0HtbVPItd053QqViQD5NLnUQrA/DB5C37b9ek15fXoN
	 NstEvmV+dobqmRi5z8VqSc47zq1UsV2ExWlEfgHDxOAsUFekVuLmuaxKGZzpOxqbek
	 dfYsYaLMZdd3f0RJWUGru/S91g1DuNyiy2SDK0cnTviVTwnfGC/hlO6P7LhChx5Y38
	 8gu5l4KZfJ6xA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1f6PW14168639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:41:06 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:41:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:41:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: phy: write BB wrapper registers with flush
Date: Wed, 14 Jan 2026 09:39:47 +0800
Message-ID: <20260114013950.19704-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

BB wrapper is a hardware circuit to control TX power, and for single
writing it needs an additional flush to ensure writing is properly
completed.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 40 +++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index f64dc47a5850..d037bbb907a8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -414,6 +414,42 @@ static void rtw89_phy_preinit_rf_nctl_be_v1(struct rtw89_dev *rtwdev)
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_C1_BE4, B_IQK_DPK_PRST, 0x1);
 }
 
+static u32 rtw89_phy_bb_wrap_flush_addr(struct rtw89_dev *rtwdev, u32 addr)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		return 0;
+
+	if (rtwdev->chip->chip_id == RTL8922D && hal->cid == RTL8922D_CID7025) {
+		if (addr >= R_BE_PWR_MACID_PATH_BASE_V1 &&
+		    addr <= R_BE_PWR_MACID_PATH_BASE_V1 + 0xFF)
+			return addr + 0x800;
+
+		if (addr >= R_BE_PWR_MACID_LMT_BASE_V1 &&
+		    addr <= R_BE_PWR_MACID_LMT_BASE_V1 + 0xFF)
+			return addr - 0x800;
+	}
+
+	return 0;
+}
+
+static
+void rtw89_write_bb_wrap_flush(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+{
+	/* To write registers of pwr_macid_lmt and pwr_macid_path with flush */
+	u32 flush_addr;
+	u32 val32;
+
+	flush_addr = rtw89_phy_bb_wrap_flush_addr(rtwdev, addr);
+	if (flush_addr) {
+		val32 = rtw89_read32(rtwdev, flush_addr);
+		rtw89_write32(rtwdev, flush_addr, val32);
+	}
+
+	rtw89_write32(rtwdev, addr, data);
+}
+
 static
 void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 {
@@ -425,7 +461,7 @@ void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 
 	for (macid_idx = 0; macid_idx < 4 * max_macid; macid_idx += 4) {
 		cr = base_macid_lmt + macid_idx;
-		rtw89_write32(rtwdev, cr, 0x03007F7F);
+		rtw89_write_bb_wrap_flush(rtwdev, cr, 0x03007F7F);
 	}
 }
 
@@ -438,7 +474,7 @@ void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
 	int i, max_macid = 32;
 
 	for (i = 0; i < max_macid; i++, cr += 4)
-		rtw89_write32(rtwdev, cr, 0x03C86000);
+		rtw89_write_bb_wrap_flush(rtwdev, cr, 0x03C86000);
 }
 
 static void rtw89_phy_bb_wrap_tpu_set_all(struct rtw89_dev *rtwdev,
-- 
2.25.1


