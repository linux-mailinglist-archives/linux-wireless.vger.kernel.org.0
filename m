Return-Path: <linux-wireless+bounces-33758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL3GJxQuwml5ZwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D6302D11
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14A90302EB02
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2742BD5B4;
	Tue, 24 Mar 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vLNiB7VJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D63A7588
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333285; cv=none; b=duREqXi70ssnt1AUxTVonk88m/vSJoTSSovMHDSIa/6j8o8o8rUwFDlqCC8ivZKSPJaNjjP9ikgjyBaRW/QRUkXMXQWxXaTsJmA9GZy0/cKatxqbOzun/2s5mRqg+6G3ry5zile9A+zruql8CMiCvavad7lAjSd5GF1QXNiiwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333285; c=relaxed/simple;
	bh=ShfMme5NU+Osl/QxhFjhCo+SWD3SzV7wWIxfZJj/NME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFKs92xS+iuki1nzFT+uxb3MXZWqf/wijpO3W7gzaJxGtTeAmWG5g9lTpLXT/VjVxNK2JUB3OWIS7fylGA0av+tVG72glfhsg1XXFAYMiaDf89eNVceK1ZnAlnCKjLZfaSiApRbUWuHTuV55vRveaS7gE/CDQ2L0O8KnjKUL3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vLNiB7VJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O6LLW30557252, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774333281; bh=jTWioBpi7m+6j956CedLBQO0L6mH7Dh4MDgKm+vmz38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vLNiB7VJLzQBOrycPh2Kj7KbKGmFfZbgOG2IoJ5RDtsBQcdwrNRFwnY86h5b0ruHt
	 SphZFxr2h/fSowK90szN2D/53iV2j/SR+9X0DbQ2bhCXcRo/DIY31OR4B2Gh4tWD6m
	 s8KQ+RqdGAI6WWcnHTtt7kW/r72Nyin1OchK+1OFpTJswkNnfeYK/68Z446Q5ozEI3
	 y+iga9sM8PrfLK0uh6swcHRV72niUFM5CToTsRuubOUsuxXHz4p/D/0wf3LO/uIePM
	 UL7BRO6uPuFSAkHwnoPOqXWJAJIQig+tFLFdGJoR7L/YweoSCSkqYvMIh1gJ5Qjy8m
	 h0Jdvz3QEr8Lw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O6LLW30557252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:21:21 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 14:21:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 rtw-next 2/7] wifi: rtw89: 8922d: add power on/off functions
Date: Tue, 24 Mar 2026 14:20:44 +0800
Message-ID: <20260324062049.52266-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260324062049.52266-1-pkshih@realtek.com>
References: <20260324062049.52266-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33758-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C6D6302D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The power on function is the first entry to power on hardware including
all MAC/BB/RF circuits, and then it becomes possible to do high level
operations, such as WiFi scan, connection.

If connection becomes unavailable, device stays into idle mode, calling
power off function to cut power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  63 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 237 ++++++++++++++++++
 2 files changed, 300 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2cb35458a822..b6fd7b434de9 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4403,6 +4403,31 @@
 #define B_BE_FS_GPIO17_INT_EN BIT(1)
 #define B_BE_FS_GPIO16_INT_EN BIT(0)
 
+#define R_BE_FWS1ISR 0x019C
+#define B_BE_FS_WL_HW_RADIO_OFF_INT BIT(28)
+#define B_BE_SWRD_BOD_INT BIT(27)
+#define B_BE_HCIDBG_INT BIT(25)
+#define B_BE_FS_RPWM_INT_V1 BIT(24)
+#define B_BE_PCIE_HOTRST BIT(22)
+#define B_BE_PCIE_SER_TIMEOUT_INDIC BIT(21)
+#define B_BE_PCIE_RXI300_SLVTOUT_INDIC BIT(20)
+#define B_BE_AON_PCIE_FLR_INT BIT(19)
+#define B_BE_PCIE_ERR_INDIC BIT(18)
+#define B_BE_SDIO_ERR_INDIC BIT(17)
+#define B_BE_USB_ERR_INDIC BIT(16)
+#define B_BE_FS_GPIO27_INT BIT(11)
+#define B_BE_FS_GPIO26_INT BIT(10)
+#define B_BE_FS_GPIO25_INT BIT(9)
+#define B_BE_FS_GPIO24_INT BIT(8)
+#define B_BE_FS_GPIO23_INT BIT(7)
+#define B_BE_FS_GPIO22_INT BIT(6)
+#define B_BE_FS_GPIO21_INT BIT(5)
+#define B_BE_FS_GPIO20_INT BIT(4)
+#define B_BE_FS_GPIO19_INT BIT(3)
+#define B_BE_FS_GPIO18_INT BIT(2)
+#define B_BE_FS_GPIO17_INT BIT(1)
+#define B_BE_FS_GPIO16_INT BIT(0)
+
 #define R_BE_HIMR0 0x01A0
 #define B_BE_WDT_DATACPU_TIMEOUT_INT_EN BIT(25)
 #define B_BE_HALT_D2H_INT_EN BIT(24)
@@ -4503,6 +4528,44 @@
 #define R_BE_UDM2 0x01F8
 #define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
 
+#define R_BE_SPS_DIG_ON_CTRL1 0x0204
+#define B_BE_SN_N_L_MASK GENMASK(31, 28)
+#define B_BE_SP_N_L_MASK GENMASK(27, 24)
+#define B_BE_SN_P_L_MASK GENMASK(23, 20)
+#define B_BE_SP_P_L_MASK GENMASK(19, 16)
+#define B_BE_VO_DISCHG_PWM_H BIT(15)
+#define B_BE_REG_MODE_PREDRIVER BIT(14)
+#define B_BE_VREFOCP_MASK GENMASK(13, 10)
+#define B_BE_POWOCP_L1 BIT(9)
+#define B_BE_PWM_FORCE BIT(8)
+#define B_BE_PFM_PD_RST BIT(7)
+#define B_BE_VC_PFM_RSTB BIT(6)
+#define B_BE_PFM_IN_SEL BIT(5)
+#define B_BE_VC_RSTB BIT(4)
+#define B_BE_FPWMDELAY BIT(3)
+#define B_BE_ENFPWMDELAY_H BIT(2)
+#define B_BE_REG_MOS_HALF_L BIT(1)
+#define B_BE_CURRENT_SENSE_MOS BIT(0)
+
+#define R_BE_SPS_ANA_ON_CTRL1 0x0224
+#define B_BE_SN_N_L_ANA_MASK GENMASK(31, 28)
+#define B_BE_SP_N_L_ANA_MASK GENMASK(27, 24)
+#define B_BE_SN_P_L_ANA_MASK GENMASK(23, 20)
+#define B_BE_SP_P_L_ANA_MASK GENMASK(19, 16)
+#define B_BE_VO_DISCHG_PWM_H_ANA BIT(15)
+#define B_BE_REG_MODE_PREDRIVER_ANA BIT(14)
+#define B_BE_VREFOCP_ANA_MASK GENMASK(13, 10)
+#define B_BE_POWOCP_L1_ANA BIT(9)
+#define B_BE_PWM_FORCE_ANA BIT(8)
+#define B_BE_PFM_PD_RST_ANA BIT(7)
+#define B_BE_VC_PFM_RSTB_ANA BIT(6)
+#define B_BE_PFM_IN_SEL_ANA BIT(5)
+#define B_BE_VC_RSTB_ANA BIT(4)
+#define B_BE_FPWMDELAY_ANA BIT(3)
+#define B_BE_ENFPWMDELAY_H_ANA BIT(2)
+#define B_BE_REG_MOS_HALF_L_ANA BIT(1)
+#define B_BE_CURRENT_SENSE_MOS_ANA BIT(0)
+
 #define R_BE_AFE_ON_CTRL0 0x0240
 #define B_BE_REG_LPF_R3_3_0_MASK GENMASK(31, 29)
 #define B_BE_REG_LPF_R2_MASK GENMASK(28, 24)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 6a90ded1b33e..194e2901232b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -231,6 +231,243 @@ static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static int rtw8922d_pwr_on_func(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 val32;
+	int ret;
+
+	if (hal->cid != RTL8922D_CID7025)
+		goto begin;
+
+	switch (hal->cv) {
+	case CHIP_CAV:
+	case CHIP_CBV:
+		rtw89_write32_set(rtwdev, R_BE_SPS_DIG_ON_CTRL1, B_BE_PWM_FORCE);
+		rtw89_write32_set(rtwdev, R_BE_SPS_ANA_ON_CTRL1, B_BE_PWM_FORCE_ANA);
+		break;
+	default:
+		break;
+	}
+
+begin:
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_AFSM_WLSUS_EN |
+						    B_BE_AFSM_PCIE_SUS_EN);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_DIS_WLBT_PDNSUSEN_SOPC);
+	rtw89_write32_set(rtwdev, R_BE_WLLPS_CTRL, B_BE_DIS_WLBT_LPSEN_LOPC);
+	if (hal->cid != RTL8922D_CID7090)
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APDM_HPDN);
+	rtw89_write32_clr(rtwdev, R_BE_FWS1ISR, B_BE_FS_WL_HW_RADIO_OFF_INT);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_RDY_SYSPWR,
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+	rtw89_write32_set(rtwdev, R_BE_WLRESUME_CTRL, B_BE_LPSROP_CMAC0 |
+						      B_BE_LPSROP_CMAC1);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFN_ONMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_APFN_ONMAC),
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write8_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_PLATFORM_EN);
+	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_HAXIDMA_IO_ST,
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_HCI_WLAN_IO_ST,
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_PCIE_FORCE_IBX_EN);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_NORMAL_WRITE, 0x10, 0x10);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC1_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x40, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL, B_BE_SYM_PADPDN_WL_RFC0_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x20, 0x20);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x04, 0x04);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x08, 0x08);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xEB, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xEB, 0xFF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x01, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x02, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x80);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0, 0x70);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_SRAM_CTRL, 0, 0x02);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+	rtw89_write32_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_ISO_EB2CORE);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_B);
+
+	mdelay(1);
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_S);
+	rtw89_write32_clr(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+
+	rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN,
+			  B_BE_MAC_FUNC_EN | B_BE_DMAC_FUNC_EN |
+			  B_BE_MPDU_PROC_EN | B_BE_WD_RLS_EN |
+			  B_BE_DLE_WDE_EN | B_BE_TXPKT_CTRL_EN |
+			  B_BE_STA_SCH_EN | B_BE_DLE_PLE_EN |
+			  B_BE_PKT_BUF_EN | B_BE_DMAC_TBL_EN |
+			  B_BE_PKT_IN_EN | B_BE_DLE_CPUIO_EN |
+			  B_BE_DISPATCHER_EN | B_BE_BBRPT_EN |
+			  B_BE_MAC_SEC_EN | B_BE_H_AXIDMA_EN |
+			  B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
+			  B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN |
+			  B_BE_LTR_CTL_EN);
+
+	set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
+
+	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_FUNC_EN,
+			  B_BE_CMAC_SHARE_EN | B_BE_RESPBA_EN |
+			  B_BE_ADDRSRCH_EN | B_BE_BTCOEX_EN);
+
+	rtw89_write32_set(rtwdev, R_BE_CMAC_FUNC_EN,
+			  B_BE_CMAC_EN | B_BE_CMAC_TXEN |
+			  B_BE_CMAC_RXEN | B_BE_SIGB_EN |
+			  B_BE_PHYINTF_EN | B_BE_CMAC_DMA_EN |
+			  B_BE_PTCLTOP_EN | B_BE_SCHEDULER_EN |
+			  B_BE_TMAC_EN | B_BE_RMAC_EN |
+			  B_BE_TXTIME_EN | B_BE_RESP_PKTCTL_EN);
+
+	set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
+
+	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE,
+			  B_BE_FEN_BB_IP_RSTN | B_BE_FEN_BBPLAT_RSTB);
+
+	return 0;
+}
+
+static int rtw8922d_pwr_off_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x10, 0x10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x08);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x04);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0, 0x01);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0x80, 0x80);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x02);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x01);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_EN_WLON);
+	rtw89_write8_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
+						      B_BE_FEN_BBPLAT_RSTB);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL,
+			  B_BE_SYM_PADPDN_WL_RFC0_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x20);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_SYS_ADIE_PAD_PWR_CTRL,
+			  B_BE_SYM_PADPDN_WL_RFC1_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, 0x40);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_IO_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+	ret = read_poll_timeout(rtw89_read32, val32,
+				!(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HCI_WLAN_IO_ST),
+				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_OFFMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_APFM_OFFMAC),
+				1000, 3000000, false, rtwdev, R_BE_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32(rtwdev, R_BE_WLLPS_CTRL, 0x00015002);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_XTAL_OFF_A_DIE);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	rtw89_write32(rtwdev, R_BE_UDM1, 0);
+
+	return 0;
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


