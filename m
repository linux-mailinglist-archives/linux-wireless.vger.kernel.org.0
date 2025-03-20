Return-Path: <linux-wireless+bounces-20598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1653A69EC7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2377A1555
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858D1EDA2A;
	Thu, 20 Mar 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cDDsMsPL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300D1EEA23
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441271; cv=none; b=QUCs6usbvkOOM4F4F+GVxWbLjLbzzsd6I/ijOfJjOj65xK3zetJXqRU1DuAjg8oGFZ/4a/6/Fp+SkEw89Y/9QV3sJJ/ODb6brZZOs3ONGYizgC5vfeaz5lgZ1hah8Dsr2cpmVB4rfTxtnhO4b4CCHQGD2DJ2UCWyYY7huu3X/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441271; c=relaxed/simple;
	bh=rZtCMbY1EfdNnsJryuqqCmZY4razLXlj3RFRHo9g8ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsTzvAvGABcJSWkTMEd/8sy37zsjlaK4WtfZcyWV+wyoyDPvmNdmngRmseaypu4SbfkC+7ER2pq3O+50pEIGROL/TO3GphOtqcXvaLhCcKDmJ4tAT6a2MURgjtbZ5YELQBthrVf4EriUouZwAwoIi/Zrtmsm421a8D7MG1YlOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cDDsMsPL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3Rk8rA1750917, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441266; bh=rZtCMbY1EfdNnsJryuqqCmZY4razLXlj3RFRHo9g8ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cDDsMsPLtvLrxlUyqLc4d4WB8jSkcWfoUqX3hgc0J0LXeZKP/xA0YR52FJkf3/IFY
	 gEZgji9bZUmkXtda3COOO5l2SA6d/G+5bd3awxRt9oHg7qQz+rJhnaLnyjv9Ibff53
	 /c9ip8K4qnBm1Rgroc2WKaDfa0jZ3sgGTnuy3OasPLDM9RlrM1Y9C7nfJ7J/+5dVjF
	 pPAnpzm1WCkMeYPQsTklphmsYvgH1osPyPXkCEm6QbT/1Ml/QiVQ+2wyOmHtnlQTSB
	 +E2s0RQnwrlXyQBTp7NvjBBst3Bs1LUOFyQ1cLdw86pDo35DCVAoW0vqFwP6PLWAeO
	 3wgtkJZwm+psg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3Rk8rA1750917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: sar: introduce structure to wrap query parameters
Date: Thu, 20 Mar 2025 11:27:03 +0800
Message-ID: <20250320032712.20284-4-pkshih@realtek.com>
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

The following implementations will support SAR source from ACPI/BIOS.
And when querying, it needs to take more parameters into account. To
avoid changing function prototype of querying SAR everytime when new
SAR source is introduced, wrap query parameters into a structure first.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/phy.c   | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/sar.c   | 16 ++++++++++------
 drivers/net/wireless/realtek/rtw89/sar.h   | 11 ++++++++---
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 5105a192b15a..a7ef9cb9c6fe 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -922,6 +922,7 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 					 char *buf, size_t bufsz)
 {
 	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	struct rtw89_sar_parm sar_parm = {};
 	const struct dbgfs_txpwr_table *tbl;
 	const struct rtw89_chan *chan;
 	char *p = buf, *end = buf + bufsz;
@@ -931,11 +932,12 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 
 	rtw89_leave_ps_mode(rtwdev);
 	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	sar_parm.center_freq = chan->freq;
 
 	p += rtw89_debug_priv_txpwr_table_get_regd(rtwdev, p, end - p, chan);
 
 	p += scnprintf(p, end - p, "[SAR]\n");
-	p += rtw89_print_sar(rtwdev, p, end - p, chan->freq);
+	p += rtw89_print_sar(rtwdev, p, end - p, &sar_parm);
 
 	p += scnprintf(p, end - p, "[TAS]\n");
 	p += rtw89_print_tas(rtwdev, p, end - p);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f4eee642e5ce..64eb4154a696 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2264,6 +2264,9 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
+	struct rtw89_sar_parm sar_parm = {
+		.center_freq = freq,
+	};
 	s8 lmt = 0, sar, offset;
 	s8 cstr;
 
@@ -2298,7 +2301,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 
 	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
 	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt + offset);
-	sar = rtw89_query_sar(rtwdev, freq);
+	sar = rtw89_query_sar(rtwdev, &sar_parm);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
 	return min3(lmt, sar, cstr);
@@ -2524,6 +2527,9 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
+	struct rtw89_sar_parm sar_parm = {
+		.center_freq = freq,
+	};
 	s8 lmt_ru = 0, sar, offset;
 	s8 cstr;
 
@@ -2558,7 +2564,7 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 
 	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
 	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru + offset);
-	sar = rtw89_query_sar(rtwdev, freq);
+	sar = rtw89_query_sar(rtwdev, &sar_parm);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
 	return min3(lmt_ru, sar, cstr);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 0b5af9528702..95255e02f1bb 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -57,10 +57,12 @@ static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 }
 
 static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev,
-					 u32 center_freq, s32 *cfg)
+					 const struct rtw89_sar_parm *sar_parm,
+					 s32 *cfg)
 {
 	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
 	enum rtw89_sar_subband subband_l, subband_h;
+	u32 center_freq = sar_parm->center_freq;
 	const struct rtw89_6ghz_span *span;
 
 	span = rtw89_get_6ghz_span(rtwdev, center_freq);
@@ -175,7 +177,7 @@ static const char *rtw89_tas_state_str(enum rtw89_tas_state state)
 	}
 }
 
-s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev, const struct rtw89_sar_parm *sar_parm)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
@@ -191,7 +193,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
-	ret = sar_hdl->query_sar_config(rtwdev, center_freq, &cfg);
+	ret = sar_hdl->query_sar_config(rtwdev, sar_parm, &cfg);
 	if (ret)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
@@ -217,7 +219,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 }
 
 int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
-		    u32 center_freq)
+		    const struct rtw89_sar_parm *sar_parm)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
@@ -238,7 +240,7 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	p += scnprintf(p, end - p, "source: %d (%s)\n", src,
 		       sar_hdl->descr_sar_source);
 
-	ret = sar_hdl->query_sar_config(rtwdev, center_freq, &cfg);
+	ret = sar_hdl->query_sar_config(rtwdev, sar_parm, &cfg);
 	if (ret) {
 		p += scnprintf(p, end - p, "config: return code: %d\n", ret);
 		p += scnprintf(p, end - p,
@@ -369,12 +371,14 @@ static bool rtw89_tas_query_sar_config(struct rtw89_dev *rtwdev, s32 *cfg)
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
+	struct rtw89_sar_parm sar_parm = {};
 	int ret;
 
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return false;
 
-	ret = sar_hdl->query_sar_config(rtwdev, chan->freq, cfg);
+	sar_parm.center_freq = chan->freq;
+	ret = sar_hdl->query_sar_config(rtwdev, &sar_parm, cfg);
 	if (ret)
 		return false;
 
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 0df1661db9a8..3e4159c08409 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -10,17 +10,22 @@
 #define RTW89_SAR_TXPWR_MAC_MAX 63
 #define RTW89_SAR_TXPWR_MAC_MIN -64
 
+struct rtw89_sar_parm {
+	u32 center_freq;
+};
+
 struct rtw89_sar_handler {
 	const char *descr_sar_source;
 	u8 txpwr_factor_sar;
-	int (*query_sar_config)(struct rtw89_dev *rtwdev, u32 center_freq, s32 *cfg);
+	int (*query_sar_config)(struct rtw89_dev *rtwdev,
+				const struct rtw89_sar_parm *sar_parm, s32 *cfg);
 };
 
 extern const struct cfg80211_sar_capa rtw89_sar_capa;
 
-s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq);
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev, const struct rtw89_sar_parm *sar_parm);
 int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
-		    u32 center_freq);
+		    const struct rtw89_sar_parm *sar_parm);
 int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
-- 
2.25.1


