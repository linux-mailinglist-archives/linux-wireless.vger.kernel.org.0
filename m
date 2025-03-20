Return-Path: <linux-wireless+bounces-20597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E63A69EC2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35B418954FC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA31EB9E3;
	Thu, 20 Mar 2025 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PMztRyUb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8951EDA2A
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441268; cv=none; b=Vmc15Z3YAuY9/hRCWvNPLP6uUDSs7A4kphTTeJT6yB2GCXWd825YPvptcYXdqM/CG/u6yWb6WnOQifZVBEpM9/DygbfY7meUEYsNPTagzmAfIvKgsHDcbH4AeAxh3gf0vW4S2Whpe0rI8AlGsFpyz/cuCwgDAidSCZow2FBZuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441268; c=relaxed/simple;
	bh=HZfZWymxIyl9atejQwVuAssVYGFxYLOB3ftHwTC/gqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNUUCDObn9tH+hhBfs2vFPMbM+WyyBYjsyd0hOKLXiSv1F4kys/qTKvvQlCtHL5M7u2ZCI4jp89KiAG7nTOEDrU+dyrOSKJH8GaeRqUbcHdPaohtxWSfNeZDxb5oqorbfE/M1aZkGt1jyfum+pubPrN9ywmx/PJqlFYoVlcteQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PMztRyUb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3RhJO21750903, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441263; bh=HZfZWymxIyl9atejQwVuAssVYGFxYLOB3ftHwTC/gqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PMztRyUbbCPHnxHuUNYETEGUMhXqFndHFQdHla87fDGvPd1gELxHceeiq9gnNvwrr
	 d+1cUoEdwwxj1NeLoiEqmY8XL+z6MzMomr4ZuCGaKA3zeLboiJk2w0PESyfD81u941
	 8Aoq9kXtb6BfhpxPuTCNKOe85k+w5h9KXia4zWbZw378zToPMG6FabkMORTWdWUvUW
	 7ulMKVMJ29095kJWlxq3zSz9HaU0ScOKFBm+0YCR1q7mJRA6RCO4fHgaCRho9S4iud
	 EfSrEhm+2uUwTufx+pIEs8zNLWNK7AK07pLTVBRBY4mBDcBHuTRbi7SI7UvI8PLRLv
	 mOmT8p0icuX0w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3RhJO21750903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: regd: introduce string getter for reuse
Date: Thu, 20 Mar 2025 11:27:02 +0800
Message-ID: <20250320032712.20284-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Introduce a function to get the string for a given regulatory. It will be
used in the following. Besides, drop similar things in debug code and use
this too.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 29 +-------------------
 drivers/net/wireless/realtek/rtw89/regd.c  | 32 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8e9697679aaa..18340a9cd72b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7185,6 +7185,7 @@ void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
 int rtw89_regd_setup(struct rtw89_dev *rtwdev);
 int rtw89_regd_init_hint(struct rtw89_dev *rtwdev);
+const char *rtw89_regd_get_string(enum rtw89_regulation_type regd);
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats);
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f2c5753fd386..5105a192b15a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -854,11 +854,6 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	return p - buf;
 }
 
-#define case_REGD(_regd) \
-	case RTW89_ ## _regd: \
-		p += scnprintf(p, end - p, #_regd "\n"); \
-		break
-
 static int __print_regd(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 			const struct rtw89_chan *chan)
 {
@@ -866,33 +861,11 @@ static int __print_regd(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
-	switch (regd) {
-	default:
-		p += scnprintf(p, end - p, "UNKNOWN: %d\n", regd);
-		break;
-	case_REGD(WW);
-	case_REGD(ETSI);
-	case_REGD(FCC);
-	case_REGD(MKK);
-	case_REGD(NA);
-	case_REGD(IC);
-	case_REGD(KCC);
-	case_REGD(NCC);
-	case_REGD(CHILE);
-	case_REGD(ACMA);
-	case_REGD(MEXICO);
-	case_REGD(UKRAINE);
-	case_REGD(CN);
-	case_REGD(QATAR);
-	case_REGD(UK);
-	case_REGD(THAILAND);
-	}
+	p += scnprintf(p, end - p, "%s\n", rtw89_regd_get_string(regd));
 
 	return p - buf;
 }
 
-#undef case_REGD
-
 struct dbgfs_txpwr_table {
 	const struct txpwr_map *byr;
 	const struct txpwr_map *lmt;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 655323a79608..49e9540f2049 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -588,6 +588,38 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 	kfree(sband);
 }
 
+#define RTW89_DEF_REGD_STR(regd) \
+	[RTW89_ ## regd] = #regd
+
+static const char * const rtw89_regd_string[] = {
+	RTW89_DEF_REGD_STR(WW),
+	RTW89_DEF_REGD_STR(ETSI),
+	RTW89_DEF_REGD_STR(FCC),
+	RTW89_DEF_REGD_STR(MKK),
+	RTW89_DEF_REGD_STR(NA),
+	RTW89_DEF_REGD_STR(IC),
+	RTW89_DEF_REGD_STR(KCC),
+	RTW89_DEF_REGD_STR(ACMA),
+	RTW89_DEF_REGD_STR(NCC),
+	RTW89_DEF_REGD_STR(MEXICO),
+	RTW89_DEF_REGD_STR(CHILE),
+	RTW89_DEF_REGD_STR(UKRAINE),
+	RTW89_DEF_REGD_STR(CN),
+	RTW89_DEF_REGD_STR(QATAR),
+	RTW89_DEF_REGD_STR(UK),
+	RTW89_DEF_REGD_STR(THAILAND),
+};
+
+static_assert(ARRAY_SIZE(rtw89_regd_string) == RTW89_REGD_NUM);
+
+const char *rtw89_regd_get_string(enum rtw89_regulation_type regd)
+{
+	if (regd < 0 || regd >= RTW89_REGD_NUM)
+		return "(unknown)";
+
+	return rtw89_regd_string[regd];
+}
+
 int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
-- 
2.25.1


