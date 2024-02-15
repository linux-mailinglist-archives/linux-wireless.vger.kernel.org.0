Return-Path: <linux-wireless+bounces-3609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2C855A40
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 06:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AA4B24500
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 05:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E84A12;
	Thu, 15 Feb 2024 05:58:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC212BA29
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976734; cv=none; b=GcbAbNwm6r17eecJg4eEdGRmqnVhhuirYfwg44ia6U2ssfmfG3ccTDihBYgQBgDF9thlNQ3z7IWczT1qBbI09EH/p3VfZdLIVrSeTgoSvtJ4rIm0itg6Pu9hT6jIzCgvyE6vNFowyIhaTgc1D4jvg1zh1NzfehiDxsWp0EyQ9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976734; c=relaxed/simple;
	bh=U5ug+CB+X6fcY/zW7whSVSHGi7954pO1xBA5IdOgDYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYJa2kHlJhcwcjhBVtzUs7B3xg7TJ7TqmYaAA+EgTme9ktfpc34BhLuU3CyYZM9Xf0aXqRg3qqIzdp+rKAuxvbbUsp7z9qxmhKiCI3+odcUKkQtePhI090tuO+xfPekQfLAy7ojRiPj6D8UDt2/s905Egpj57M8qzjeEB3wygvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F5wmd872372816, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F5wmd872372816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:58:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 15 Feb 2024 13:58:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Feb
 2024 13:58:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: 8922a: add helper of set_channel
Date: Thu, 15 Feb 2024 13:57:41 +0800
Message-ID: <20240215055741.14148-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215055741.14148-1-pkshih@realtek.com>
References: <20240215055741.14148-1-pkshih@realtek.com>
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

Reset hardware state to prevent hardware stays at abnormal state during
setting channel. Besides, add preparation for MLO/DBCC before setting
channel, and reconfigure registers after that.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 51 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 23 +++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |  2 +
 3 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index dbbf6f344f3a..247f95d1d59a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1774,6 +1774,37 @@ static void rtw8922a_set_channel_bb(struct rtw89_dev *rtwdev,
 	rtw8922a_tssi_reset(rtwdev, RF_PATH_AB, phy_idx);
 }
 
+static void rtw8922a_pre_set_channel_bb(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy_idx)
+{
+	if (!rtwdev->dbcc_en)
+		return;
+
+	if (phy_idx == RTW89_PHY_0) {
+		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0x6180);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xBBAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xABA9);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEBA9);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEAA9);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xBBAB);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR, B_EMLSR_PARM, 0xEEFF);
+	}
+}
+
+static void rtw8922a_post_set_channel_bb(struct rtw89_dev *rtwdev,
+					 enum rtw89_mlo_dbcc_mode mode)
+{
+	if (!rtwdev->dbcc_en)
+		return;
+
+	rtw8922a_ctrl_mlo(rtwdev, mode);
+}
+
 static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
 				 enum rtw89_mac_idx mac_idx,
@@ -1863,6 +1894,25 @@ void rtw8922a_hal_reset(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8922a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
+				      struct rtw89_channel_help_params *p,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_mac_idx mac_idx,
+				      enum rtw89_phy_idx phy_idx)
+{
+	if (enter) {
+		rtw8922a_pre_set_channel_bb(rtwdev, phy_idx);
+		rtw8922a_pre_set_channel_rf(rtwdev, phy_idx);
+	}
+
+	rtw8922a_hal_reset(rtwdev, phy_idx, mac_idx, chan->band_type, &p->tx_en, enter);
+
+	if (!enter) {
+		rtw8922a_post_set_channel_bb(rtwdev, rtwdev->mlo_dbcc_mode);
+		rtw8922a_post_set_channel_rf(rtwdev, phy_idx);
+	}
+}
+
 static void rtw8922a_rfk_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
@@ -2169,6 +2219,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_rf		= rtw89_phy_read_rf_v2,
 	.write_rf		= rtw89_phy_write_rf_v2,
 	.set_channel		= rtw8922a_set_channel,
+	.set_channel_help	= rtw8922a_set_channel_help,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
 	.fem_setup		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 72953b7358df..2a371829268c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -353,3 +353,26 @@ void rtw8922a_rfk_hw_init(struct rtw89_dev *rtwdev)
 
 	rtw8922a_rfk_pll_init(rtwdev);
 }
+
+void rtw8922a_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	bool mlo_1_1;
+
+	if (!rtwdev->dbcc_en)
+		return;
+
+	mlo_1_1 = rtw89_is_mlo_1_1(rtwdev);
+	if (mlo_1_1)
+		rtw8922a_set_syn01(rtwdev, RF_SYN_ALLON);
+	else if (phy_idx == RTW89_PHY_0)
+		rtw8922a_set_syn01(rtwdev, RF_SYN_ON_OFF);
+	else
+		rtw8922a_set_syn01(rtwdev, RF_SYN_OFF_ON);
+
+	fsleep(1000);
+}
+
+void rtw8922a_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_rfk_mlo_ctrl(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
index 27a2ff8166d0..66bdd57c1eea 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
@@ -12,5 +12,7 @@ void rtw8922a_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
 void rtw8922a_rfk_hw_init(struct rtw89_dev *rtwdev);
+void rtw8922a_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8922a_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 
 #endif
-- 
2.25.1


