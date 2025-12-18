Return-Path: <linux-wireless+bounces-29888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4CCCA7C1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0773061EAF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B730163;
	Thu, 18 Dec 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="L0d72egy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476F327BF1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039539; cv=none; b=aQlafLEGzw2zg25UTRc0mV9ftT6tQxPKT5+8NZOWzV+2Pf+0DPIByGVEuZDrdHUJDAUGmE+J0sV+tGplNuICIrWLmKq3chw6iOgJLXGISJCodVWZmW93jdHVt8rWtvn0lnhnIiht9ldH66NXeBMP3BtU0GiZvaLjA/Z7c4Lqskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039539; c=relaxed/simple;
	bh=QCYcYLSF7k7k+3PWkSm3wBDYXVSzOjWD3b/96wyyMd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjSYiIRmUde/zo5rhEAoELk+Ui7RR9krU3G8q15p0+qhO/XPOWnVeIqqNTv71PH2NmongGhbatpZ/A79q8gW29uirLNZqNYZtCa2UVAmfTXUqyc9RpCnnUtDOQ88GyU0bazboCk0iQaJyU8kT8JgfmMfEOH703hhtHm62ZTQ7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L0d72egy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6WFV303333871, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039535; bh=o50e1uQhEmpLi03u5on1Xwq+jZqfHp47WGgs3Uoj8Qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=L0d72egy+0uXuz/lVJ8JlN8VjIpSlZeJYuh9pI0K0qG9qjn8Okew0SvKFHz4QBEIS
	 ++r/ZSkJFvEDB4Sq1qs7L5DBqPfAOT63lFEAtJ/QDIP3uRzJPkR4Hvyo0MsgwTrgTx
	 mPvRk0P3h+TPiYG1bAjPPYg5XspuCTvlQliBPIn9Liaf/++XTWhwkqlDDJ7IJlXnAI
	 StLr5YRrUgCXCG+Z2eKVovBnBGTK2GlXb29COSt5CUhaxrTNhcOrXi0gSpQumqkmmo
	 Iu2P8yGRhiUVa85QTb7D7WEI/zh6Va2iiZ+4LwA7AwZQ2mUZGiWwXutBJPaw2Hgwe0
	 hr6AgF2f8D1vg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6WFV303333871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:15 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:15 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:14 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 07/12] wifi: rtw89: debug: add ser_counters dbgfs
Date: Thu, 18 Dec 2025 14:31:12 +0800
Message-ID: <20251218063117.26278-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Dump counters of SER (system error recoery) L0/L1 related cases.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 57 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h   |  5 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1264c2f82600..0d9a158f6df1 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -79,6 +79,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv send_h2c;
 	struct rtw89_debugfs_priv early_h2c;
 	struct rtw89_debugfs_priv fw_crash;
+	struct rtw89_debugfs_priv ser_counters;
 	struct rtw89_debugfs_priv btc_info;
 	struct rtw89_debugfs_priv btc_manual;
 	struct rtw89_debugfs_priv fw_log_manual;
@@ -3680,6 +3681,60 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+struct rtw89_dbg_ser_counters {
+	unsigned int l0;
+	unsigned int l1;
+	unsigned int l0_to_l1;
+};
+
+static void rtw89_dbg_get_ser_counters_ax(struct rtw89_dev *rtwdev,
+					  struct rtw89_dbg_ser_counters *cnt)
+{
+	const u32 val = rtw89_read32(rtwdev, R_AX_SER_DBG_INFO);
+
+	cnt->l0 = u32_get_bits(val, B_AX_SER_L0_COUNTER_MASK);
+	cnt->l1 = u32_get_bits(val, B_AX_SER_L1_COUNTER_MASK);
+	cnt->l0_to_l1 = u32_get_bits(val, B_AX_L0_TO_L1_EVENT_MASK);
+}
+
+static void rtw89_dbg_get_ser_counters_be(struct rtw89_dev *rtwdev,
+					  struct rtw89_dbg_ser_counters *cnt)
+{
+	const u32 val = rtw89_read32(rtwdev, R_BE_SER_DBG_INFO);
+
+	cnt->l0 = u32_get_bits(val, B_BE_SER_L0_COUNTER_MASK);
+	cnt->l1 = u32_get_bits(val, B_BE_SER_L1_COUNTER_MASK);
+	cnt->l0_to_l1 = u32_get_bits(val, B_BE_SER_L0_PROMOTE_L1_EVENT_MASK);
+}
+
+static ssize_t rtw89_debug_priv_ser_counters_get(struct rtw89_dev *rtwdev,
+						 struct rtw89_debugfs_priv *debugfs_priv,
+						 char *buf, size_t bufsz)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_dbg_ser_counters cnt = {};
+	char *p = buf, *end = buf + bufsz;
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	switch (chip->chip_gen) {
+	case RTW89_CHIP_AX:
+		rtw89_dbg_get_ser_counters_ax(rtwdev, &cnt);
+		break;
+	case RTW89_CHIP_BE:
+		rtw89_dbg_get_ser_counters_be(rtwdev, &cnt);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	p += scnprintf(p, end - p, "SER L0 Count: %d\n", cnt.l0);
+	p += scnprintf(p, end - p, "SER L1 Count: %d\n", cnt.l1);
+	p += scnprintf(p, end - p, "SER L0 promote event: %d\n", cnt.l0_to_l1);
+
+	return p - buf;
+}
+
 static ssize_t rtw89_debug_priv_btc_info_get(struct rtw89_dev *rtwdev,
 					     struct rtw89_debugfs_priv *debugfs_priv,
 					     char *buf, size_t bufsz)
@@ -4767,6 +4822,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.send_h2c = rtw89_debug_priv_set(send_h2c),
 	.early_h2c = rtw89_debug_priv_set_and_get(early_h2c, RWLOCK),
 	.fw_crash = rtw89_debug_priv_set_and_get(fw_crash, WLOCK),
+	.ser_counters = rtw89_debug_priv_get(ser_counters, RLOCK),
 	.btc_info = rtw89_debug_priv_get(btc_info, RSIZE_12K),
 	.btc_manual = rtw89_debug_priv_set(btc_manual),
 	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual, WLOCK),
@@ -4814,6 +4870,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_w(send_h2c);
 	rtw89_debugfs_add_rw(early_h2c);
 	rtw89_debugfs_add_rw(fw_crash);
+	rtw89_debugfs_add_r(ser_counters);
 	rtw89_debugfs_add_r(btc_info);
 	rtw89_debugfs_add_w(btc_manual);
 	rtw89_debugfs_add_w(fw_log_manual);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index fb641cefa4c9..28ceab7726c6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -607,6 +607,9 @@
 
 #define R_AX_SER_DBG_INFO 0x8424
 #define B_AX_L0_TO_L1_EVENT_MASK GENMASK(31, 28)
+#define B_AX_SER_L1_COUNTER_MASK GENMASK(27, 24)
+#define B_AX_RMAC_PPDU_HANG_CNT_MASK GENMASK(23, 16)
+#define B_AX_SER_L0_COUNTER_MASK GENMASK(7, 0)
 
 #define R_AX_DLE_EMPTY0 0x8430
 #define B_AX_PLE_EMPTY_QTA_DMAC_CPUIO BIT(26)
@@ -4731,7 +4734,7 @@
 #define B_BE_SER_L0_PROMOTE_L1_EVENT_MASK GENMASK(31, 28)
 #define B_BE_SER_L1_COUNTER_MASK GENMASK(27, 24)
 #define B_BE_RMAC_PPDU_HANG_CNT_MASK GENMASK(23, 16)
-#define B_BE_SER_L0_COUNTER_MASK GENMASK(8, 0)
+#define B_BE_SER_L0_COUNTER_MASK GENMASK(7, 0)
 
 #define R_BE_DMAC_SYS_CR32B 0x842C
 #define B_BE_DMAC_BB_PHY1_MASK GENMASK(31, 16)
-- 
2.25.1


