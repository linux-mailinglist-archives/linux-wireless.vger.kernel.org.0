Return-Path: <linux-wireless+bounces-29885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0E5CCA7A6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 164623035E40
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E2857FA;
	Thu, 18 Dec 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CbTG45c6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AB1DF256
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039527; cv=none; b=JHWnJ9nAnjGEAgE5UvRO9+fEWdzthsdc0r+KZoiif0t2Kmxo7Kl9iCMITSGXFLnyhjZw4awvMpukgZm7fJc5M45EnirobGDrS4/w/kZgERVjo9PdFTYa63FIV+aptEmzkF2h0+NlhQ7KPCLS67X+3/unRhAgA+QhRc+4Lipu0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039527; c=relaxed/simple;
	bh=GkOjUom+F5cF9M2681hb5zRZUAQtRvgWxRYjR5neu/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGKz3BVZtu9XSTtDVxnW1tOSCFFJ0bdOHLVue5xqVBTpjEyfIg6UPkYfxKjSX+Om9KcDgXCQUXXpPaXJlUD5OfokKok8OmNuFLx/NrHmUOz64do1H0Uc+HfKuwDWg8b5PZBHFV6ZMhxOByGXdNAg22snSTqXvEkPGcWun1agyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CbTG45c6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6VwCtA3322980, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039518; bh=8VfaGGrrjfk9U0rc9+uWpJsPaGL/G+G5Mi+gKKOfu20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CbTG45c6gP7HY2pT02/IrPxAi5YgB2XqZIKki0HErXVyQO/8PtlqKKh2gkjcVwuIX
	 spKyXVstK+03vJ7dOTuJ+Jzjzv8+LJNlyRH8Xpx1xong5Ug+FAWauFtQ/qfzFxg68B
	 c4IoRL96gRjisyJ/OGKupqw/oRYuzA18HUPv3VVjyZXZTIMbOs9Cqt63MI5OeaVKzF
	 XF4os575Vg0vOW1TtbxWPCAhdoNdvxY0wc7s9Bi70DtfyfUPOTkCE8X6hp24q2ew/8
	 +wyFcAzJjDFRuPaA51bPcIHls82cH4/nE0mCyj2wHSCZUanO+vqzdxrNmrH/ZWIBbK
	 lo72fufOPV3IQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6VwCtA3322980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:31:58 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:31:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:31:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 04/12] wifi: rtw89: mac: reset power state before switching to power on
Date: Thu, 18 Dec 2025 14:31:09 +0800
Message-ID: <20251218063117.26278-5-pkshih@realtek.com>
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

To run power on function properly, reset power states (off/on/PS) to
initial state. Otherwise, it might be unusable due to fail to power on.

Since a USB adapter might play as USB mass storage with driver and then
switch to WiFi adapter, causing it stays on power-on state when doing WiFi
USB probe. Exclude this case.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: prevent warning on USB adapter for first time power-on
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  99 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h    |   1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 130 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  27 ++++
 4 files changed, 250 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d78fbe73e365..f08b0f25f44c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1478,13 +1478,11 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
 
 static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 {
-#define PWR_ACT 1
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
 	int (*cfg_func)(struct rtw89_dev *rtwdev);
 	int ret;
-	u8 val;
 
 	rtw89_mac_power_switch_boot_mode(rtwdev);
 
@@ -1499,10 +1497,10 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
 		__rtw89_leave_ps_mode(rtwdev);
 
-	val = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
-	if (on && val == PWR_ACT) {
-		rtw89_err(rtwdev, "MAC has already powered on\n");
-		return -EBUSY;
+	if (on) {
+		ret = mac->reset_pwr_state(rtwdev);
+		if (ret)
+			return ret;
 	}
 
 	ret = cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq);
@@ -1529,7 +1527,6 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	}
 
 	return 0;
-#undef PWR_ACT
 }
 
 int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
@@ -3931,6 +3928,93 @@ static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_mac_reset_pwr_state_ax(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 val32;
+	int ret;
+
+	val32 = rtw89_read32(rtwdev, R_AX_SYSON_FSM_MON);
+	val32 &= WLAN_FSM_MASK;
+	val32 |= WLAN_FSM_SET;
+	rtw89_write32(rtwdev, R_AX_SYSON_FSM_MON, val32);
+
+	ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == WLAN_FSM_IDLE,
+				1000, 2000000, false,
+				rtwdev, R_AX_SYSON_FSM_MON, WLAN_FSM_STATE_MASK);
+	if (ret) {
+		/*
+		 * A USB adapter might play as USB mass storage with driver and
+		 * then switch to WiFi adapter, causing it stays on power-on
+		 * state when doing WiFi USB probe. Return EAGAIN to caller to
+		 * power-off and power-on again to reset the state.
+		 */
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
+		    !test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
+			return -EAGAIN;
+
+		rtw89_err(rtwdev, "[ERR]Polling WLAN PMC timeout= %X\n", val32);
+		return ret;
+	}
+
+	val32 = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
+	if (val32 == MAC_AX_MAC_OFF) {
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	} else if (val32 == MAC_AX_MAC_ON) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
+					1000, 2000000, false,
+					rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	} else if (val32 == MAC_AX_MAC_LPS) {
+		rtw89_write32_set(rtwdev, R_AX_WLLPS_CTRL, B_AX_FORCE_LEAVE_LPS);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_ON,
+					1000, 2000000, false,
+					rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC STS timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
+					1000, 2000000, false,
+					rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_AX_WLLPS_CTRL, B_AX_FORCE_LEAVE_LPS);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	}
+
+	switch (chip_id) {
+	case RTL8852A:
+	case RTL8852B:
+	case RTL8851B:
+		rtw89_write32_clr(rtwdev, R_AX_AFE_CTRL1, B_AX_CMAC_CLK_SEL);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -7206,6 +7290,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.set_cpuio = set_cpuio_ax,
 	.dle_quota_change = dle_quota_change_ax,
 
+	.reset_pwr_state = rtw89_mac_reset_pwr_state_ax,
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0007229d6753..9ec70729e9e1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1052,6 +1052,7 @@ struct rtw89_mac_gen_def {
 			 struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
 	int (*dle_quota_change)(struct rtw89_dev *rtwdev, bool band1_en);
 
+	int (*reset_pwr_state)(struct rtw89_dev *rtwdev);
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
 				bool dlfw, bool include_bb);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 556e5f98e8d4..65c0c0de3a30 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -425,6 +425,135 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 	return 0;
 }
 
+static int rtw89_mac_reset_pwr_state_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	val32 = rtw89_read32(rtwdev, R_BE_SYSON_FSM_MON);
+	val32 &= WLAN_FSM_MASK;
+	val32 |= WLAN_FSM_SET;
+	rtw89_write32(rtwdev, R_BE_SYSON_FSM_MON, val32);
+
+	ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == WLAN_FSM_IDLE,
+				1000, 2000000, false,
+				rtwdev, R_BE_SYSON_FSM_MON, WLAN_FSM_STATE_MASK);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]Polling WLAN PMC timeout= %X\n", val32);
+		return ret;
+	}
+
+	val32 = rtw89_read32_mask(rtwdev, R_BE_IC_PWR_STATE, B_BE_WLMAC_PWR_STE_MASK);
+	if (val32 == MAC_AX_MAC_OFF) {
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL,
+					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	} else if (val32 == MAC_AX_MAC_ON) {
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL,
+					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
+					1000, 2000000, false,
+					rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	} else if (val32 == MAC_AX_MAC_LPS) {
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL,
+					B_BE_HAXIDMA_IO_ST | B_BE_HAXIDMA_BACKUP_RESTORE_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling HAXI IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, !val32,
+					1000, 2000000, false,
+					rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_ST);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling WLAN IO timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_set(rtwdev, R_BE_WLLPS_CTRL, B_BE_FORCE_LEAVE_LPS);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_ON,
+					1000, 2000000, false,
+					rtwdev, R_BE_IC_PWR_STATE, B_BE_WLMAC_PWR_STE_MASK);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC STS timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == MAC_AX_MAC_OFF,
+					1000, 2000000, false,
+					rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]Polling MAC state timeout= %X\n", val32);
+			return ret;
+		}
+
+		rtw89_write32_clr(rtwdev, R_BE_WLLPS_CTRL, B_BE_FORCE_LEAVE_LPS);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	}
+
+	return 0;
+}
+
 static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -2623,6 +2752,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.set_cpuio = set_cpuio_be,
 	.dle_quota_change = dle_quota_change_be,
 
+	.reset_pwr_state = rtw89_mac_reset_pwr_state_be,
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5b4a459cf29c..fb641cefa4c9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -149,6 +149,7 @@
 #define R_AX_WLLPS_CTRL 0x0090
 #define B_AX_LPSOP_ASWRM BIT(17)
 #define B_AX_LPSOP_DSWRM BIT(9)
+#define B_AX_FORCE_LEAVE_LPS BIT(3)
 #define B_AX_DIS_WLBT_LPSEN_LOPC BIT(1)
 #define SW_LPS_OPTION 0x0001A0B2
 
@@ -313,6 +314,9 @@
 #define R_AX_IC_PWR_STATE 0x03F0
 #define B_AX_WHOLE_SYS_PWR_STE_MASK GENMASK(25, 16)
 #define B_AX_WLMAC_PWR_STE_MASK GENMASK(9, 8)
+#define MAC_AX_MAC_OFF 0
+#define MAC_AX_MAC_ON 1
+#define MAC_AX_MAC_LPS 2
 #define B_AX_UART_HCISYS_PWR_STE_MASK GENMASK(7, 6)
 #define B_AX_SDIO_HCISYS_PWR_STE_MASK GENMASK(5, 4)
 #define B_AX_USB_HCISYS_PWR_STE_MASK GENMASK(3, 2)
@@ -2094,6 +2098,7 @@
 #define B_AX_B1_ISR_ERR_USRCTL_REINIT BIT(0)
 
 #define R_AX_AFE_CTRL1 0x0024
+#define B_AX_CMAC_CLK_SEL BIT(21)
 
 #define B_AX_R_SYM_WLCMAC1_P4_PC_EN BIT(4)
 #define B_AX_R_SYM_WLCMAC1_P3_PC_EN BIT(3)
@@ -2107,6 +2112,12 @@
 #define B_AX_R_SYM_FEN_WLBBFUN_1 BIT(16)
 #define B_AX_R_SYM_ISO_CMAC12PP BIT(5)
 
+#define R_AX_SYSON_FSM_MON 0x00A0
+#define B_AX_FSM_MON_SEL_MASK GENMASK(26, 24)
+#define B_AX_DOP_ELDO BIT(23)
+#define B_AX_FSM_MON_UPD BIT(15)
+#define B_AX_FSM_PAR_MASK GENMASK(14, 0)
+
 #define R_AX_CMAC_REG_START 0xC000
 
 #define R_AX_CMAC_FUNC_EN 0xC000
@@ -4172,6 +4183,22 @@
 #define B_BE_LPSROP_LOWPWRPLL BIT(7)
 #define B_BE_LPSROP_DSWRSD_SEL_MASK GENMASK(5, 4)
 
+#define R_BE_SYSON_FSM_MON 0x00A0
+#define B_BE_FSM_MON_SEL_MASK GENMASK(26, 24)
+#define B_BE_DOP_ELDO BIT(23)
+#define B_BE_AFE_PLL_BYPASS BIT(22)
+#define B_BE_PON_SWR_BYPASS BIT(21)
+#define B_BE_PON_ADIE_BYPASS BIT(20)
+#define B_BE_AFE_LS_BYPASS BIT(19)
+#define B_BE_BTPMC_XTAL_SI_BYPASS BIT(17)
+#define B_BE_WLPMC_XTAL_SI_BYPASS BIT(16)
+#define B_BE_FSM_MON_UPD BIT(15)
+#define B_BE_FSM_PAR_MASK GENMASK(14, 0)
+#define WLAN_FSM_MASK 0xFFFFFF
+#define WLAN_FSM_SET 0x4000000
+#define WLAN_FSM_STATE_MASK 0x1FF
+#define WLAN_FSM_IDLE 0
+
 #define R_BE_EFUSE_CTRL_2_V1 0x00A4
 #define B_BE_EF_ENT BIT(31)
 #define B_BE_EF_TCOLUMN_EN BIT(29)
-- 
2.25.1


