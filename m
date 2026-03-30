Return-Path: <linux-wireless+bounces-34168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJRuIVYfymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C435626B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91D623003608
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E238551A;
	Mon, 30 Mar 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="smvHhM7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A88286D73
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853972; cv=none; b=u+ZL76UHTaTjTY+sYYC6mLSd8BREEWMT3alu6oTvSTw0C4oVWAFAEmSkKZX/G7p5UoaGMBR1IWEHZIa8CqCxmkb39MeYtzc0yxp1hSw3ENlyyNVVQC5ZnVtB0Dk4poQwFgfH/1zxFUN5AJNVEfPImsVnjorLE1ckKqQFkuqWSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853972; c=relaxed/simple;
	bh=FAuI8A7nLp8vjTCoJau8SqNUIsoNk793aCPWtnz3WWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX9tLYY/cdqhXOpUEaFzcOOZU4Iyd6ec2Pjd2h/ctwILt8DM0priVQ4H6nEAD7gXn/i/GLDp1w4KvZpqHeVG5x2wtl8xqS2tWfiLbiqIyz4F5VoKxUgFIKNdUdhDGpkUFnWzG8VTEthMYVnKqWnmI7XKiVYahWhJ9kWPU7Rr1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=smvHhM7q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6xS6F1673861, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853968; bh=Bnvn9WC10rKnbnH8yA571x3gq2xdetMGeYdO2ffIkhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=smvHhM7qs59q9nNP6YggqxL7l3I0sr/uquTcf7fA97fZnw4aqLDPsp7/S0VQrAr5Q
	 QempMjHPwKecYDzjDeq4PepPRHAcd10sIWG6ADnO+cWopCBTacKiG2H/7eQ0WRQLMM
	 tkzK9PIZOehcSGCuHijmZr8f5Fa/bIhnAnZnZ76Xh3ephkoPzLw1EXK7mrkP2osgvP
	 viegLgBjG+9owIg8svmG/ZBwFuZTHb23N7K4FamMiPHkLq+SygZX3TV/I7hYPP/0/7
	 Q1aHx3TGmpQo6ODB4X9ynuzoUU5j9eM3ZlAp6IZbAEvhsV5TP3e6SICbsi/l3X0kda
	 KcGHsL1SVyTzw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6xS6F1673861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:28 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:27 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 7/9] wifi: rtw89: 8922d: add ops related to BT coexistence mechanism
Date: Mon, 30 Mar 2026 14:58:45 +0800
Message-ID: <20260330065847.48946-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260330065847.48946-1-pkshih@realtek.com>
References: <20260330065847.48946-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34168-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D5C435626B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ops is used by shared BT coexistence mechanism to set WiFi TX power,
get BT RSSI, and TX/RX parameters.

The RTL8922D uses TX/RX parameter v9, so define it and fill NULL for
other chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  21 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 123 ++++++++++++++++++
 8 files changed, 168 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 696a1d92d62b..5c5bd7d02a62 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -873,6 +873,14 @@ enum rtw89_phy_idx {
 	RTW89_PHY_NUM,
 };
 
+enum rtw89_fbtc_bt_index {
+	BTC_BT_1ST = 0x0,
+	BTC_BT_2ND = 0x1,
+	BTC_BT_EXT = 0x2,
+	BTC_ALL_BT = 0x2,
+	BTC_ALL_BT_EZL = 0x3 /* BT0+BT1+Ext-ZB(or Thread, or LTE) */
+};
+
 #define __RTW89_MLD_MAX_LINK_NUM 2
 #define RTW89_MLD_NON_STA_LINK_NUM 1
 
@@ -2197,6 +2205,15 @@ struct rtw89_btc_bt_info {
 	u32 rsvd: 17;
 };
 
+struct rtw89_btc_rf_trx_para_v9 {
+	u32 wl_tx_power[RTW89_PHY_NUM]; /* absolute Tx power (dBm), 1's complement -5->0x85 */
+	u32 wl_rx_gain[RTW89_PHY_NUM]; /* rx gain table index (TBD.) */
+	u32 bt_tx_power[BTC_ALL_BT]; /* decrease Tx power (dB) */
+	u32 bt_rx_gain[BTC_ALL_BT]; /* LNA constrain level */
+	u32 zb_tx_power[BTC_ALL_BT]; /* 15.4 devrease Tx power (dB) */
+	u32 zb_rx_gain[BTC_ALL_BT]; /* 15.4 constrain level */
+};
+
 struct rtw89_btc_cx {
 	struct rtw89_btc_wl_info wl;
 	struct rtw89_btc_bt_info bt;
@@ -4609,6 +4626,10 @@ struct rtw89_chip_info {
 	const struct rtw89_btc_rf_trx_para *rf_para_ulink;
 	u8 rf_para_dlink_num;
 	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
+	const struct rtw89_btc_rf_trx_para_v9 *rf_para_ulink_v9;
+	const struct rtw89_btc_rf_trx_para_v9 *rf_para_dlink_v9;
+	u8 rf_para_ulink_num_v9;
+	u8 rf_para_dlink_num_v9;
 	u8 ps_mode_supported;
 	u8 low_power_hci_modes;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index a3a5b6fbe46c..f9eda3f16d32 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2681,6 +2681,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8851b_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8851b_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8851b_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED),
 	.low_power_hci_modes	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 898c534a5762..c894c31156e4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2418,6 +2418,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8852a_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852a_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8852a_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 19a9f07e8714..f2e839122194 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1014,6 +1014,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8852b_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852b_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8852b_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index c86b995a7cb1..b1eb6fb1ece8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -853,6 +853,10 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8852bt_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852bt_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8852bt_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7ea0a8905282..0f2902af1c72 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3211,6 +3211,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8852c_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852c_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8852c_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a489aaf90f23..e8731d2f1703 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3015,6 +3015,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.rf_para_ulink		= rtw89_btc_8922a_rf_ul,
 	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8922a_rf_dl),
 	.rf_para_dlink		= rtw89_btc_8922a_rf_dl,
+	.rf_para_ulink_v9	= NULL,
+	.rf_para_dlink_v9	= NULL,
+	.rf_para_ulink_num_v9	= 0,
+	.rf_para_dlink_num_v9	= 0,
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 49b84d49ccac..a9a7ffb5fb58 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2619,6 +2619,129 @@ static u32 rtw8922d_chan_to_rf18_val(struct rtw89_dev *rtwdev,
 	return val;
 }
 
+static void rtw8922d_btc_set_rfe(struct rtw89_dev *rtwdev)
+{
+}
+
+static void rtw8922d_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	/* offload to firmware */
+}
+
+static void
+rtw8922d_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
+{
+	u16 ctrl_all_time = u32_get_bits(txpwr_val, GENMASK(15, 0));
+	u16 ctrl_gnt_bt = u32_get_bits(txpwr_val, GENMASK(31, 16));
+
+	switch (ctrl_all_time) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_VAL, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_VAL, ctrl_all_time);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_RATE_CTRL,
+					     B_BE_FORCE_PWR_BY_RATE_EN, 0x1);
+		break;
+	}
+
+	switch (ctrl_gnt_bt) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_REG_CTRL,
+					     B_BE_PWR_BT_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_COEX_CTRL,
+					     B_BE_PWR_BT_VAL, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_COEX_CTRL,
+					     B_BE_PWR_BT_VAL, ctrl_gnt_bt);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_BE_PWR_REG_CTRL,
+					     B_BE_PWR_BT_EN, 0x1);
+		break;
+	}
+}
+
+static
+s8 rtw8922d_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
+{
+	return clamp_t(s8, val, -100, 0) + 100;
+}
+
+static const struct rtw89_btc_rf_trx_para_v9 rtw89_btc_8922d_rf_ul_v9[] = {
+	/*
+	 * 0 -> original
+	 * 1 -> for BT-connected ACI issue && BTG co-rx
+	 * 2 ~ 4 ->reserved for shared-antenna
+	 * 5 ~ 8 ->for non-shared-antenna free-run
+	 */
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {2, 2}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{ 6,  6}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{13, 13}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{13, 13}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+};
+
+static const struct rtw89_btc_rf_trx_para_v9 rtw89_btc_8922d_rf_dl_v9[] = {
+	/*
+	 * 0 -> original
+	 * 1 -> for BT-connected ACI issue && BTG co-rx
+	 * 2 ~ 4 ->reserved for shared-antenna
+	 * 5 ~ 8 ->for non-shared-antenna free-run
+	 */
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {2, 2}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {0, 0}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+	{{15, 15}, {1, 1}, {0, 0}, {7, 7}, {0, 0}, {0, 0}},
+};
+
+static const u8 rtw89_btc_8922d_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {60, 50, 40, 30};
+static const u8 rtw89_btc_8922d_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
+
+static const struct rtw89_btc_fbtc_mreg rtw89_btc_8922d_mon_reg[] = {
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe300),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe330),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe334),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe338),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe344),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe348),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe34c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe350),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe354),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe35c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe370),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xe380),
+};
+
+static
+void rtw8922d_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
+{
+	/* Feature move to firmware */
+}
+
+static
+void rtw8922d_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
+{
+	/* Feature move to firmware */
+}
+
+static void rtw8922d_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
+{
+	/* Feature move to firmware */
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


