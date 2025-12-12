Return-Path: <linux-wireless+bounces-29691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1719CB7BB0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7919301C97C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A92512C8;
	Fri, 12 Dec 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HOYZ14On"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2121E091
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509251; cv=none; b=lXEQx6pZB9NwtAU2GFcve+he6yVrwhLu0aZQkNMGMZzt5T9uZmCS+otEGWDOBgcVFRRB3UMDRt1EyRa8mdM+MRZcEw0y3ZThdcSpu1H0507tkxcJKrL55kCMNJZPRVxChmN3cZfHf+DZYs9TSKBIX1cRV98fnaW1CLB+taVUWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509251; c=relaxed/simple;
	bh=Aixk/n5f3nZsvsIuPb28qhySp+3FLKIvMG9xojuElio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPaDGdtEXVj2tndgRez6wzYw5NlcepU5oaEXvtW/kYCVHn9UjR0hDAtqP1xdz0tuHDL0I/VIgQQuVB0KSjvS00EMnXB9FOWACvj8xYibZ6FfIryHu+ebZFBZeDaRMAMZFmP1hrII+XbdvJFcCohJhVVpaLENNr712YSAyroEfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HOYZ14On; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3E7IX03508158, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509247; bh=gpxLKiOu0oeqj2hTKVLU6O3H9UrAJ0THGRYA2d6ZnqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HOYZ14OnP/FBkTLciL4IY8ljRXMP5h1Qm2jK4uvglsaMDXMEOYAXosPRSwYrmGKl4
	 h6FASco/rKkgKXokz+aSEPjoTAHSiCBQoyadREPnbaeIrc6aQfSN2fPwm2hoIfcMCk
	 rdKd8yz5W7aMnGyK8frUTBCc3PvBwwELgG+13y9ifdT8QN7Rz7EGzMv5ZklE1WTgrm
	 dmtWzlcQx1yNXGu6WdTfB4a9L26VKU/1A17NW+TBk18AmItfTLVYHCr27sztc1S6Bu
	 LHghcwi4iTyzKmi715gx6xkn8SdHbo/JrF2loWD8TUMXh5vwjRHB/pJXtCpt0ACJS9
	 12/ADzspAfDKQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3E7IX03508158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:14:07 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:13:55 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:13:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: mac: reset power state before switching to power on
Date: Fri, 12 Dec 2025 11:12:55 +0800
Message-ID: <20251212031303.19882-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
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

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  89 ++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h    |   1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 130 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  27 ++++
 4 files changed, 240 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d78fbe73e365..ba4344a640f5 100644
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
@@ -3931,6 +3928,83 @@ static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
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
@@ -7206,6 +7280,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
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


