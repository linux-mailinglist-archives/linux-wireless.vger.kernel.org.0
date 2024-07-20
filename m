Return-Path: <linux-wireless+bounces-10410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B73937EBB
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6751C21282
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A707E1;
	Sat, 20 Jul 2024 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sMW3405Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA25E8F59
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441681; cv=none; b=aAdd243u2NeU7U/QbuQqPSwzBGd1l+/e0LEPYfCKXB9wH/Y4IU7gsBcYUmDZWnXOmToDOe4lR6LwHYpQLKOJvZY1ntvuwfljPaloOl8PDmNn9B4MdRrNq6mIaysB5Qd1rkxCaR9fROiAebtvBVQ+Vs/ab8c8fQRkuwxXuBtuGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441681; c=relaxed/simple;
	bh=3qo607EYITYwjpEcfawwZ00sxapSEpqhnEnimT/iD7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lE20OyaUKStg+S1iOcLTn4OE5TE47N7z7e9jj9Vza4CETKHEIgE4FcOdqGdEc7je6XllhZGoCmRsuywraapTJny+wedE2jWSnYhv6ArQtZlN4i2lwbhlzd/fAyjsZTu0PrbyuZRt/+9fkO+lR8d8Jc/lbLOO+E5TaL1XGzYlbYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sMW3405Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K2EaHhA1147858, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441676; bh=3qo607EYITYwjpEcfawwZ00sxapSEpqhnEnimT/iD7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sMW3405Yd3MtNXK44YGtxoI5I3JmyUXAedGFP79nO2uORTwu1DBLzLOdAfGE1mNaF
	 5nHKXjfdmTltU3+pITTG7JZ8JODmpfkVp6H7Kj6n2bimvtIkYKG2vImVAYuJOUXljA
	 CSUG/Vm64rgQhzxK4XohjUgrSo5IlUrs9PZtLvZF+z4fvYfho83M5FT97ik1WC3aFj
	 BL1FBkO2k488cLWsCq/GUKzTBOg0FcTCq9Tt06vRJW9HDC6oMQn0g/1kA2+1qLstE7
	 OOEMZ77IPLISUZCtoQW9kj2n3Mc9G3twbWewADyoqicIUeXjoIKpzeR3CkTprTQNWQ
	 M6FO6cIJhD9eQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K2EaHhA1147858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 10:14:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:14:37 +0800
Received: from [127.0.1.1] (172.16.22.168) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jul
 2024 10:14:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 4/7] wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
Date: Sat, 20 Jul 2024 10:13:37 +0800
Message-ID: <20240720021340.12102-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240720021340.12102-1-pkshih@realtek.com>
References: <20240720021340.12102-1-pkshih@realtek.com>
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

Add chip_info of RTL8852BT accordingly, including power on/off function,
BB reset, TSSI settings while setting channel, RF calibration, and
BT coexistence.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: no change
v2: no change
---
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 461 ++++++++++++++++++
 2 files changed, 463 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 0e5f268616f7..7678fb8bcf7e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -193,6 +193,8 @@ enum btc_wa_type {
 	BTC_WA_5G_HI_CH_RX = BIT(0),
 	BTC_WA_NULL_AP = BIT(1),
 	BTC_WA_HFP_ZB = BIT(2),  /* HFP PTA req bit4 define issue */
+	BTC_WA_HFP_LAG = BIT(3),  /* 52BT WL break BT Rx lag issue */
+	BTC_WA_INIT_SCAN = BIT(4)  /* 52A/C/D init scan move to wl slot WA */
 };
 
 enum btc_3cx_type {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 0ecd9d41c2ad..dd9fbddc411a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -8,6 +8,8 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852bt.h"
+#include "rtw8852bt_rfk.h"
+#include "rtw8852b_common.h"
 
 #define RTW8852BT_FW_FORMAT_MAX 0
 #define RTW8852BT_FW_BASENAME "rtw89/rtw8852bt_fw"
@@ -230,7 +232,466 @@ static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852bt_mon_reg[] = {
 static const u8 rtw89_btc_8852bt_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {70, 60, 50, 40};
 static const u8 rtw89_btc_8852bt_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
 
+static int rtw8852bt_pwr_on_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
+
+	rtw89_write32_set(rtwdev, R_AX_LDO_AON_CTRL0, B_AX_PD_REGU_L);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
+						    B_AX_AFSM_PCIE_SUS_EN);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_DIS_WLBT_PDNSUSEN_SOPC);
+	rtw89_write32_set(rtwdev, R_AX_WLLPS_CTRL, B_AX_DIS_WLBT_LPSEN_LOPC);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APDM_HPDN);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_OCP_L1_MASK, 7);
+
+	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_AX_RDY_SYSPWR,
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFN_ONMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFN_ONMAC),
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL,
+				      XTAL_SI_GND_SHDN_WL, XTAL_SI_GND_SHDN_WL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL,
+				      XTAL_SI_SHDN_WL, XTAL_SI_SHDN_WL);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_WEI,
+				      XTAL_SI_OFF_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_EI,
+				      XTAL_SI_OFF_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_RFC2RF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_PON_WEI,
+				      XTAL_SI_PON_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_PON_EI,
+				      XTAL_SI_PON_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_SRAM2RFC);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_SRAM_CTRL, 0, XTAL_SI_SRAM_DIS);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_2, 0, XTAL_SI_LDO_LPS);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_XMD_4, 0, XTAL_SI_LPS_CAP);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_ISO_EB2CORE);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B15);
+
+	fsleep(1000);
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
+	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+
+	if (!rtwdev->efuse.valid || rtwdev->efuse.power_k_valid)
+		goto func_en;
+
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VOL_L1_MASK, 0x9);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_VREFPFM_L_MASK, 0xA);
+
+func_en:
+	rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
+			  B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MPDU_PROC_EN |
+			  B_AX_WD_RLS_EN | B_AX_DLE_WDE_EN | B_AX_TXPKT_CTRL_EN |
+			  B_AX_STA_SCH_EN | B_AX_DLE_PLE_EN | B_AX_PKT_BUF_EN |
+			  B_AX_DMAC_TBL_EN | B_AX_PKT_IN_EN | B_AX_DLE_CPUIO_EN |
+			  B_AX_DISPATCHER_EN | B_AX_BBRPT_EN | B_AX_MAC_SEC_EN |
+			  B_AX_DMACREG_GCKEN);
+	rtw89_write32_set(rtwdev, R_AX_CMAC_FUNC_EN,
+			  B_AX_CMAC_EN | B_AX_CMAC_TXEN | B_AX_CMAC_RXEN |
+			  B_AX_FORCE_CMACREG_GCKEN | B_AX_PHYINTF_EN | B_AX_CMAC_DMA_EN |
+			  B_AX_PTCLTOP_EN | B_AX_SCHEDULER_EN | B_AX_TMAC_EN |
+			  B_AX_RMAC_EN);
+
+	rtw89_write32_mask(rtwdev, R_AX_EECS_EESK_FUNC_SEL,
+			   B_AX_PINMUX_EESK_FUNC_SEL_MASK, 0x1);
+
+	return 0;
+}
+
+static int rtw8852bt_pwr_off_func(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
+				      XTAL_SI_RFC2RF);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_OFF_WEI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0, XTAL_SI_RF00);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0, XTAL_SI_RF10);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_SRAM2RFC,
+				      XTAL_SI_SRAM2RFC);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_EI);
+	if (ret)
+		return ret;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_PON_WEI);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_EN_WLON);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN, B_AX_FEN_BB_GLB_RSTN | B_AX_FEN_BBRSTB);
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_RFC_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_SHDN_WL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_clr(rtwdev, R_AX_SYS_ADIE_PAD_PWR_CTRL, B_AX_SYM_PADPDN_WL_PTA_1P3);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, 0, XTAL_SI_GND_SHDN_WL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_OFFMAC);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_APFM_OFFMAC),
+				1000, 20000, false, rtwdev, R_AX_SYS_PW_CTRL);
+	if (ret)
+		return ret;
+
+	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x3);
+	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
+	return 0;
+}
+
+static void rtw8852bt_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
+				  enum rtw89_phy_idx phy_idx, bool en)
+{
+	if (en) {
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+		if (band == RTW89_BAND_2G)
+			rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x1);
+		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
+				      B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS,
+				      B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+		fsleep(1);
+		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
+	}
+}
+
+static void rtw8852bt_bb_reset(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
+			       B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI, 0x1);
+	rtw89_phy_write32_set(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB,
+			       B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI, 0x1);
+	rtw89_phy_write32_set(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
+	rtw8852bx_bb_reset_all(rtwdev, phy_idx);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
+			       B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI, 3);
+	rtw89_phy_write32_clr(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB,
+			       B_P1_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI, 0x3);
+	rtw89_phy_write32_clr(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
+}
+
+static void rtw8852bt_set_channel(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_mac_idx mac_idx,
+				  enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8852bx_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8852bt_set_channel_rf(rtwdev, chan, phy_idx);
+}
+
+static void rtw8852bt_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
+				   enum rtw89_rf_path path)
+{
+	static const u32 tssi_trk[2] = {R_P0_TSSI_TRK, R_P1_TSSI_TRK};
+
+	if (en)
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], B_P0_TSSI_TRK_EN, 0x0);
+	else
+		rtw89_phy_write32_mask(rtwdev, tssi_trk[path], B_P0_TSSI_TRK_EN, 0x1);
+}
+
+static void rtw8852bt_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en,
+					  u8 phy_idx)
+{
+	if (!rtwdev->dbcc_en) {
+		rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_B);
+		rtw8852bt_tssi_scan(rtwdev, phy_idx);
+	} else {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_A);
+		else
+			rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_B);
+	}
+}
+
+static void rtw8852bt_adc_en(struct rtw89_dev *rtwdev, bool en)
+{
+	if (en)
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0x0);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_ADC_FIFO, B_ADC_FIFO_RST, 0xf);
+}
+
+static void rtw8852bt_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
+				       struct rtw89_channel_help_params *p,
+				       const struct rtw89_chan *chan,
+				       enum rtw89_mac_idx mac_idx,
+				       enum rtw89_phy_idx phy_idx)
+{
+	if (enter) {
+		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw8852bt_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
+		rtw8852bt_adc_en(rtwdev, false);
+		fsleep(40);
+		rtw8852bt_bb_reset_en(rtwdev, chan->band_type, phy_idx, false);
+	} else {
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw8852bt_adc_en(rtwdev, true);
+		rtw8852bt_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
+		rtw8852bt_bb_reset_en(rtwdev, chan->band_type, phy_idx, true);
+		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
+	}
+}
+
+static void rtw8852bt_rfk_init(struct rtw89_dev *rtwdev)
+{
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+
+	rtw8852bt_dpk_init(rtwdev);
+	rtw8852bt_rck(rtwdev);
+	rtw8852bt_dack(rtwdev);
+	rtw8852bt_rx_dck(rtwdev, RTW89_PHY_0);
+}
+
+static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+
+	rtw8852bt_rx_dck(rtwdev, phy_idx);
+	rtw8852bt_iqk(rtwdev, phy_idx);
+	rtw8852bt_tssi(rtwdev, phy_idx, true);
+	rtw8852bt_dpk(rtwdev, phy_idx);
+}
+
+static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bt_tssi_scan(rtwdev, phy_idx);
+}
+
+static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+{
+	rtw8852bt_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+}
+
+static void rtw8852bt_rfk_track(struct rtw89_dev *rtwdev)
+{
+	rtw8852bt_dpk_track(rtwdev);
+}
+
+static void rtw8852bt_btc_set_rfe(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
+
+	if (ver->fcxinit == 7) {
+		md->md_v7.rfe_type = rtwdev->efuse.rfe_type;
+		md->md_v7.kt_ver = rtwdev->hal.cv;
+		md->md_v7.kt_ver_adie = rtwdev->hal.acv;
+		md->md_v7.bt_solo = 0;
+		md->md_v7.bt_pos = BTC_BT_BTG;
+		md->md_v7.switch_type = BTC_SWITCH_INTERNAL;
+		md->md_v7.wa_type = 0;
+
+		md->md_v7.ant.type = BTC_ANT_SHARED;
+		md->md_v7.ant.num = 2;
+		md->md_v7.ant.isolation = 10;
+		md->md_v7.ant.diversity = 0;
+		/* WL 1-stream+1-Ant is located at 0:s0(path-A) or 1:s1(path-B) */
+		md->md_v7.ant.single_pos = RF_PATH_A;
+		md->md_v7.ant.btg_pos = RF_PATH_B;
+
+		if (md->md_v7.rfe_type == 0) {
+			rtwdev->btc.dm.error.map.rfe_type0 = true;
+			return;
+		}
+
+		md->md_v7.ant.num = (md->md_v7.rfe_type % 2) ? 2 : 3;
+		md->md_v7.ant.stream_cnt = 2;
+		md->md_v7.wa_type |= BTC_WA_INIT_SCAN;
+
+		if (md->md_v7.ant.num == 2) {
+			md->md_v7.ant.type = BTC_ANT_SHARED;
+			md->md_v7.bt_pos = BTC_BT_BTG;
+			md->md_v7.wa_type |= BTC_WA_HFP_LAG;
+		} else {
+			md->md_v7.ant.type = BTC_ANT_DEDICATED;
+			md->md_v7.bt_pos = BTC_BT_ALONE;
+		}
+	} else {
+		return;
+	}
+}
+
+static void
+rtw8852bt_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
+{
+	u16 ctrl_all_time = u32_get_bits(txpwr_val, GENMASK(15, 0));
+	u16 ctrl_gnt_bt = u32_get_bits(txpwr_val, GENMASK(31, 16));
+
+	switch (ctrl_all_time) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_RATE_CTRL,
+					     B_AX_FORCE_PWR_BY_RATE_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_RATE_CTRL,
+					     B_AX_FORCE_PWR_BY_RATE_VALUE_MASK, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_RATE_CTRL,
+					     B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
+					     ctrl_all_time);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_RATE_CTRL,
+					     B_AX_FORCE_PWR_BY_RATE_EN, 0x1);
+		break;
+	}
+
+	switch (ctrl_gnt_bt) {
+	case 0xffff:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_COEXT_CTRL,
+					     B_AX_TXAGC_BT_EN, 0x0);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_COEXT_CTRL,
+					     B_AX_TXAGC_BT_MASK, 0x0);
+		break;
+	default:
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_COEXT_CTRL,
+					     B_AX_TXAGC_BT_MASK, ctrl_gnt_bt);
+		rtw89_mac_txpwr_write32_mask(rtwdev, RTW89_PHY_0, R_AX_PWR_COEXT_CTRL,
+					     B_AX_TXAGC_BT_EN, 0x1);
+		break;
+	}
+}
+
 static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
+	.enable_bb_rf		= rtw8852bx_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8852bx_mac_disable_bb_rf,
+	.bb_preinit		= NULL,
+	.bb_postinit		= NULL,
+	.bb_reset		= rtw8852bt_bb_reset,
+	.bb_sethw		= rtw8852bx_bb_sethw,
+	.read_rf		= rtw89_phy_read_rf_v1,
+	.write_rf		= rtw89_phy_write_rf_v1,
+	.set_channel		= rtw8852bt_set_channel,
+	.set_channel_help	= rtw8852bt_set_channel_help,
+	.read_efuse		= rtw8852bx_read_efuse,
+	.read_phycap		= rtw8852bx_read_phycap,
+	.fem_setup		= NULL,
+	.rfe_gpio		= NULL,
+	.rfk_hw_init		= NULL,
+	.rfk_init		= rtw8852bt_rfk_init,
+	.rfk_init_late		= NULL,
+	.rfk_channel		= rtw8852bt_rfk_channel,
+	.rfk_band_changed	= rtw8852bt_rfk_band_changed,
+	.rfk_scan		= rtw8852bt_rfk_scan,
+	.rfk_track		= rtw8852bt_rfk_track,
+	.power_trim		= rtw8852bx_power_trim,
+	.set_txpwr		= rtw8852bx_set_txpwr,
+	.set_txpwr_ctrl		= rtw8852bx_set_txpwr_ctrl,
+	.init_txpwr_unit	= rtw8852bx_init_txpwr_unit,
+	.get_thermal		= rtw8852bx_get_thermal,
+	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
+	.query_ppdu		= rtw8852bx_query_ppdu,
+	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
+	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
+	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
+	.pwr_on_func		= rtw8852bt_pwr_on_func,
+	.pwr_off_func		= rtw8852bt_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc,
+	.fill_txdesc		= rtw89_core_fill_txdesc,
+	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
+	.h2c_dctl_sec_cam	= NULL,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
+	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_default_dmac_tbl	= NULL,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
+
+	.btc_set_rfe		= rtw8852bt_btc_set_rfe,
+	.btc_init_cfg		= rtw8852bx_btc_init_cfg,
+	.btc_set_wl_pri		= rtw8852bx_btc_set_wl_pri,
+	.btc_set_wl_txpwr_ctrl	= rtw8852bt_btc_set_wl_txpwr_ctrl,
+	.btc_get_bt_rssi	= rtw8852bx_btc_get_bt_rssi,
+	.btc_update_bt_cnt	= rtw8852bx_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8852bx_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8852bx_btc_set_wl_rx_gain,
+	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
 #ifdef CONFIG_PM
-- 
2.25.1


