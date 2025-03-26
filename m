Return-Path: <linux-wireless+bounces-20836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84323A70EC7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025F91766F1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65D12CD96;
	Wed, 26 Mar 2025 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qrPcXQ0C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B18143888
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954853; cv=none; b=Kto6S5IZWqvGEzu8P4e2Opm+kGqsVbBn/3XHnsqYe94hzZhomSDHB3p0Go/Dwi4o29yztXrI9Uh3k8zXVeM3BKkfTV4Cji560Hbv6IcG86oPNVVAltvC9kzf1n9qxkylh/KE5Qts73F31OiNOoRG1efJWLNjNVKsRAxyIFJvJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954853; c=relaxed/simple;
	bh=WB5WvR5gmqFIYloWawRlV9Cxlpx8k2z1NjurFlIw3Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQ/nob5HHsmAzwpZhNSDn2UTwuKWI3/VxHqlWN3JM+tJm+c+UjDfYpLVc70Mjs5hgtM55GjnIHoQN2tdqN8wmNDPk21DxlddIBXex0QqdUj8hWXXpY6UTyqjE1tWNJAvSiQzEbnAoJMmpd61uoQLMFjREq9TB3HvpuM1dwcRnv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qrPcXQ0C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q27UGd81408020, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954850; bh=WB5WvR5gmqFIYloWawRlV9Cxlpx8k2z1NjurFlIw3Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qrPcXQ0Cai45reen5kRJ8ospQAVcWjVinATsfn3jM8AWMURdihoreI6dgCUrk8470
	 Ep9DTOJfKKy+hePz5fyxt9XWyokaWY6Ek3LchI0d2pc+5KyqS7Mrr9nJL6U4y/NKyU
	 V9Ns9VtykDqYPpaGTfXySpmSESIcifmm6x0oaAtv/jjOGnfcJsCXVNywXEO8DYPtLb
	 cKf4ikehPtiUBXehGHkNph2PBrkL1+0WxgyDlEXNwBLBzBGU5oN608579wfonBu40m
	 8I7K/RdRmC2bMMPtktOcqo2hD/tNNSznuZG5HLK0jCVkznez9jq5ffy6ICDL3RIEAu
	 wezl0BdrXR7Sw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q27UGd81408020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 11/12] wifi: rtw89: 8852c: support different SAR configs by antenna
Date: Wed, 26 Mar 2025 10:06:42 +0800
Message-ID: <20250326020643.14487-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326020643.14487-1-pkshih@realtek.com>
References: <20250326020643.14487-1-pkshih@realtek.com>
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

Set SAR configs to the corresponding CRs (control registers) according to
RF path. Then, declare to support SAR by antenna in chip info.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 28 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 3c01b4994537..c1332934246e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8737,8 +8737,10 @@
 #define B_DPD_GDIS BIT(13)
 #define B_IQK_RFC_ON BIT(1)
 #define R_TXPWRB 0x56CC
+#define R_P1_TXPWRB 0x76CC
 #define B_TXPWRB_ON BIT(28)
 #define B_TXPWRB_VAL GENMASK(27, 19)
+#define B_TXPWRB_MAX GENMASK(8, 0)
 #define R_DPD_OFT_EN 0x5800
 #define B_DPD_OFT_EN BIT(28)
 #define B_DPD_TSSI_CW GENMASK(26, 18)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cbbb6a9169d1..a8fd573d5048 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2079,6 +2079,31 @@ static void rtw8852c_set_txpwr_diff(struct rtw89_dev *rtwdev,
 	rtw8852c_set_txpwr_ref(rtwdev, phy_idx, pwr_ofst);
 }
 
+static void rtw8852c_set_txpwr_sar_diff(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_sar_parm sar_parm = {
+		.center_freq = chan->freq,
+		.force_path = true,
+	};
+	s16 sar_rf;
+	s8 sar_mac;
+
+	if (phy_idx != RTW89_PHY_0)
+		return;
+
+	sar_parm.path = RF_PATH_A;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_rf = rtw89_phy_txpwr_mac_to_rf(rtwdev, sar_mac);
+	rtw89_phy_write32_mask(rtwdev, R_TXPWRB, B_TXPWRB_MAX, sar_rf);
+
+	sar_parm.path = RF_PATH_B;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_rf = rtw89_phy_txpwr_mac_to_rf(rtwdev, sar_mac);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPWRB, B_TXPWRB_MAX, sar_rf);
+}
+
 static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
@@ -2089,6 +2114,7 @@ static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
 	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 	rtw8852c_set_txpwr_diff(rtwdev, chan, phy_idx);
+	rtw8852c_set_txpwr_sar_diff(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852c_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
@@ -3014,7 +3040,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= true,
-	.support_sar_by_ant	= false,
+	.support_sar_by_ant	= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.rx_freq_frome_ie	= false,
-- 
2.25.1


