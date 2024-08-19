Return-Path: <linux-wireless+bounces-11612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7E9566BE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC341C219AA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23091157A5A;
	Mon, 19 Aug 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dtvz6Btw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4915C125
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059098; cv=none; b=el6KuSB+ougGcvxSBMJbCrr4PIQSmkiL4ecFPfBb9oKeYL0VkaPzEwhzumZkpSAxajWEpKe/RRpr9yPZv8aoQ1dCG++X9nOnnKwJpVRS5X7D4/gXwYa2A6l7leVBZi7sJC6j9JNUF6Y/IA5H3sGe97SFSbEqEty1iZcMPg3bx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059098; c=relaxed/simple;
	bh=nsZKIbz1hXfD7PYJjBMANxd3i4q1uOh5JXRxCdvOu/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y63+IPMt5Kt/wnuD/XE87Z9ndySHbBgB9e0WNrlG3HOB7sT7YPcH7hp8qJrYbP1RGQnpUmlDWr0P35FyLiautnD8gBoPt2NEldZWSk3eUtQZ/joNrqPvMgCmqgooUPTdZqK0MW+rg6E42sDt8Kx4K+VHVYBb9FioPTu+Y4DDorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dtvz6Btw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9IDD204126206, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059093; bh=nsZKIbz1hXfD7PYJjBMANxd3i4q1uOh5JXRxCdvOu/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Dtvz6Btwv4kkvYdh98cFJ3QhKrsOcTFHCOMDOVQIPpmfQSUPLRSi9XF3vUfLXaqnu
	 YyoEUjihRmUPyjvtka7pZHP24Q51uVrX8h4l6Ah2mrytortUzq7Wygh5ZWBI7umYcQ
	 e7vS1l2WxyqkAwk1pD9nR4typ3cBX8GPNxZHBR1xl9UHY1mHuIKadWC5JL7HzGoJbJ
	 S6Z6Oz+0kfHrZ+ExdpSHaaSqvn8bsa3rb7+tO749evsEsdXdAHlmlmE5p7bjPzb49z
	 tmij4IxNvm3Sty0xiynkVW1ykDEipjt6NzJ0wNL1JFvVEgvicv2g3x8RP9iS4CbJo4
	 hjDK8DPmioV0A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9IDD204126206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:18:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:18:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:18:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 8/8] wifi: rtw89: introduce chip support link number and driver MLO capability
Date: Mon, 19 Aug 2024 17:17:24 +0800
Message-ID: <20240819091724.33730-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

Configure supported link number by chip. And, introduce driver capability
flag for MLO. Driver should depend on runtime FW features and chip info to
determine whether to set the MLO capability flag or not. Once the MLO flag
is set, driver will consider/register/initialize things for MLO usages.

However, we just add the driver MLO capability flag ahead and don't really
set it. Then, we can start to tweak driver architecture for MLO. Some code
should depend on this flag. And after tweaking driver architecture is done,
we will set it based on runtime conditions as mentioned above.

Besides, MLD number supported by HW should be
	chip supported mac_id number / chip supported link number
Without driver MLO capability flag, we allocate stations based on supported
mac_id number. With driver MLO capability flag, we allocate stations based
on supported MLD number.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 24 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 8 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 9aa64ce85678..9d38b586441e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4263,9 +4263,14 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 u8 rtw89_acquire_mac_id(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 mac_id_num = chip->support_macid_num;
+	u8 mac_id_num;
 	u8 mac_id;
 
+	if (rtwdev->support_mlo)
+		mac_id_num = chip->support_macid_num / chip->support_link_num;
+	else
+		mac_id_num = chip->support_macid_num;
+
 	mac_id = find_first_zero_bit(rtwdev->mac_id_map, mac_id_num);
 	if (mac_id == mac_id_num)
 		return RTW89_MAX_MAC_ID_NUM;
@@ -4681,6 +4686,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	if (chip->chip_gen == RTW89_CHIP_BE)
 		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
+	if (rtwdev->support_mlo)
+		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
@@ -4781,6 +4789,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	struct ieee80211_ops *ops;
 	u32 driver_data_size;
 	int fw_format = -1;
+	bool support_mlo;
 	bool no_chanctx;
 
 	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_fw, &fw_format);
@@ -4809,6 +4818,14 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	if (!hw)
 		goto err;
 
+	/* TODO: When driver MLO arch. is done, determine whether to support MLO
+	 * according to the following conditions.
+	 * 1. run with chanctx_ops
+	 * 2. chip->support_link_num != 0
+	 * 3. FW feature supports AP_LINK_PS
+	 */
+	support_mlo = false;
+
 	hw->wiphy->iface_combinations = rtw89_iface_combs;
 
 	if (no_chanctx || chip->support_chanctx_num == 1)
@@ -4823,9 +4840,12 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->chip = chip;
 	rtwdev->fw.req.firmware = firmware;
 	rtwdev->fw.fw_format = fw_format;
+	rtwdev->support_mlo = support_mlo;
 
-	rtw89_debug(rtwdev, RTW89_DBG_FW, "probe driver %s chanctx\n",
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "probe driver %s chanctx\n",
 		    no_chanctx ? "without" : "with");
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "probe driver %s MLO cap\n",
+		    support_mlo ? "with" : "without");
 
 	return rtwdev;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0ac77376e130..93b463659a3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4181,6 +4181,7 @@ struct rtw89_chip_info {
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
 	u8 support_macid_num;
+	u8 support_link_num;
 	u8 support_chanctx_num;
 	u8 support_bands;
 	u16 support_bandwidths;
@@ -5424,6 +5425,7 @@ struct rtw89_dev {
 	const struct ieee80211_ops *ops;
 
 	bool dbcc_en;
+	bool support_mlo;
 	enum rtw89_mlo_dbcc_mode mlo_dbcc_mode;
 	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c2fa8e270a4b..6dc07edd18a2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2465,6 +2465,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dig_regs		= &rtw8851b_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_link_num	= 0,
 	.support_chanctx_num	= 0,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1034d8b29f5d..5eadb0cba29c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2183,6 +2183,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dig_regs		= &rtw8852a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_link_num	= 0,
 	.support_chanctx_num	= 1,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 4a4e825302ea..b7e92ce9256b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -820,6 +820,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dig_regs		= &rtw8852b_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_link_num	= 0,
 	.support_chanctx_num	= 0,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index f7d133ac34de..52a76d2646e9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -753,6 +753,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.dig_regs		= &rtw8852bt_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_link_num       = 0,
 	.support_chanctx_num	= 1,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d4adab43f4f2..4a7eaebcdddc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2961,6 +2961,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dig_regs		= &rtw8852c_dig_regs,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
 	.support_macid_num	= RTW89_MAX_MAC_ID_NUM,
+	.support_link_num	= 0,
 	.support_chanctx_num	= 2,
 	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 85bdeeda95de..3387989299c9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2621,6 +2621,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dig_regs		= &rtw8922a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_macid_num	= 32,
+	.support_link_num	= 2,
 	.support_chanctx_num	= 2,
 	.support_rnr		= true,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
-- 
2.25.1


