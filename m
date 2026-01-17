Return-Path: <linux-wireless+bounces-30921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F303D38C48
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D1B3033B89
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB12D77EA;
	Sat, 17 Jan 2026 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GwsM+bi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30118C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624927; cv=none; b=PsBnOQPlF4/xkDMgQ8sPNS1f3lC/ScjEsMrSY9IBF/8Xg5koX03alXvxH4+mtXPmmDtJg7SpywN42sj9h2HtNszGQ5d295t2P2cGpc0m6KZf8Pb4T+gmaf7BC+Mx/cLVoY2XlTtUIls59oq2hB1SOfzCUY7QmHYNNlvVtpuolrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624927; c=relaxed/simple;
	bh=TWsZlDAL4nXuf9ve0UN5CeJJ32uT+0Ji9823H9AyWmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hY5jSlabL//olPyY43rwl/U6kG2aOxWzKjYwjvNh7mmtVO5DgO6FvqHe+tsw/9qAdgcIKKvtjARBmrRM3UZILZhhokO8bDUAS0Q4WWbRkf2WE6MvbedAA2twLekaHtRnbH03J6vWDM6k6mp7Qgnc5yk666PSUbqj0GPt/CcPTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GwsM+bi6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4g3XP12464442, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624923; bh=Z+fuuXFiXC7xdTZeB1NSJkf9f3cRvYzvO8OQIJvMgEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GwsM+bi6dCvffEtzRCTgHO9w51cN/nZCWeDi9Y1MVgha1WA81SdmcMEIn9D9LPdgv
	 fF6ioSrDruNKtAd1sayoLyqqAIdbv5Q2s6STAa2/n67hqz/STU+SDu0UzQvuN6mMv/
	 ZgIj6daVUU1LqswElSz+m+4jpCoAyFsvslQ0hH+/j0hUYTV/LGf91cKIRfncTiUeri
	 OBuisLRsUe7uNLM+s89v+6ZR4+w6TOdT9H//atAU47+MPv0enGNJDFHIYhuroTv6Qu
	 cTYoOD2oXZSxkJOrOLbcMHrznSDbkTnnsLxGnB325v5vhI7KsMS6tp+DhudbT3C6Cv
	 hGbfsjBcHOXzQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4g3XP12464442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:03 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:03 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:03 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/9] wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
Date: Sat, 17 Jan 2026 12:41:49 +0800
Message-ID: <20260117044157.2392958-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In PS mode, it needs to restore RX gain settings while waking up. Add to
get RX gain values from chip specific ops, and pass these data to firmware
when going to enter PS mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 25 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 7 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1abd09d9d29c..5c3684064d38 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -23,6 +23,7 @@ struct rtw89_efuse_block_cfg;
 struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
+struct rtw89_phy_calc_efuse_gain;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
 struct rtw89_wow_cam_info;
@@ -3822,6 +3823,11 @@ struct rtw89_chip_ops {
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	void (*digital_pwr_comp)(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx);
+	void (*calc_rx_gain_normal)(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_rf_path path,
+				    enum rtw89_phy_idx phy_idx,
+				    struct rtw89_phy_calc_efuse_gain *calc);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
 	void (*query_rxdesc)(struct rtw89_dev *rtwdev,
@@ -5887,6 +5893,12 @@ struct rtw89_phy_efuse_gain {
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
+struct rtw89_phy_calc_efuse_gain {
+	s8 cck_mean_gain_bias;
+	s8 cck_rpl_ofst;
+	s8 rssi_ofst;
+};
+
 #define RTW89_MAX_PATTERN_NUM             18
 #define RTW89_MAX_PATTERN_MASK_SIZE       4
 #define RTW89_MAX_PATTERN_SIZE            128
@@ -7341,6 +7353,19 @@ static inline void rtw89_chip_digital_pwr_comp(struct rtw89_dev *rtwdev,
 		chip->ops->digital_pwr_comp(rtwdev, phy_idx);
 }
 
+static inline
+void rtw89_chip_calc_rx_gain_normal(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_rf_path path,
+				    enum rtw89_phy_idx phy_idx,
+				    struct rtw89_phy_calc_efuse_gain *calc)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->calc_rx_gain_normal)
+		chip->ops->calc_rx_gain_normal(rtwdev, chan, path, phy_idx, calc);
+}
+
 static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 					  const struct rtw89_txpwr_table *tbl)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 0383d3b5c7bc..d6deb44a685b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2530,6 +2530,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 329fc0a7b07b..5ea7a36ab5ab 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2224,6 +2224,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.cfg_txrx_path		= NULL,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f44674a39e30..197e3f5fb21b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -857,6 +857,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index ab60ed389ff7..92bbd6e5d699 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -703,6 +703,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= rtw8852bt_pwr_on_func,
 	.pwr_off_func		= rtw8852bt_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d2138be3640d..de5d343f80a5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3065,6 +3065,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6d2cd914e16e..0a3c2207dd4b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2838,6 +2838,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.cfg_txrx_path		= rtw8922a_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= NULL,
 	.digital_pwr_comp	= rtw8922a_digital_pwr_comp,
+	.calc_rx_gain_normal	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
-- 
2.25.1


