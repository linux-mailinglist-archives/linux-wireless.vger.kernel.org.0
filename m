Return-Path: <linux-wireless+bounces-20837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67257A70ECB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231603B0AAE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2F41C85;
	Wed, 26 Mar 2025 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mRr0Q3dY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51E3AC17
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954857; cv=none; b=NZsw9oq3epHlxVjKRUH102+t0L9VP5Jo/gyZnHfSFkZQEz84+3hBbmsnhkwoQpGwWdLTgAhT0Sd09Zv74/SJwC80DSw/wWm2ACwTh8GLHVbFcLDOPbfUU9HOFjtKQinFi8pBV4ado1/LIdf07+wpv6E/EM/A8N+DEbiivOw/aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954857; c=relaxed/simple;
	bh=F7Zo3evsE/9ITOZ6TFNIK5SkC3eHzJKF3YxDFOQWAco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DINKs/10iCyvvZ8LJO3uWN1IMqA/R54I0RQwOsUlxm0ypmj0Ce/zqCSS5GPxE3VHvlY5DPgikQexUVTOekERSP9BCAZxWtlqoga3tIDelHlBzBpi65ZyzM/hphYw15LQrWJpj1ETUikwNnTUpCcaScmgFWXkjf0AIJ5ef1/T0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mRr0Q3dY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q27YuE41408223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954854; bh=F7Zo3evsE/9ITOZ6TFNIK5SkC3eHzJKF3YxDFOQWAco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mRr0Q3dYmvc6VrFLRmwOKAL+TXDhh5QVI+11xK6FOgVUAR9G/PXXlGXNA9lixivDS
	 XIYI/YxyYZzDBJeJSRp9K4OiFxYqA6BDLtphKVkQXkaTmKW1J5BEwryWJZM9FTSXXc
	 2ubHkAya3OS5sjfOj5gdQeQaWgGD2BXzu887/XPci1HoJ7fMNh8t4qIh6cH6ZH8aih
	 O4JudVO7F402C0HTDWCauGnvr6HQF3nCwlzKGr2VrzTdJHZ3ru3zI5H45RNrFCI6EX
	 /Tl/PtpkeOIz+lnoV+gD+bQHeHqJdba0NRjY78ufHDICnnliJnPY9FMpeM5bS2vCD/
	 TfB/W8X06tGQg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q27YuE41408223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 12/12] wifi: rtw89: 8852bx: support different SAR configs by antenna
Date: Wed, 26 Mar 2025 10:06:43 +0800
Message-ID: <20250326020643.14487-13-pkshih@realtek.com>
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

Calculate difference of SAR configs between RF path A and RF path B.
And then, based on the calculated result, set the TX power reference
CR (control register). Finally, declare to support SAR by antenna in
8852b/8852bt chip info.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 +-
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 24 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  2 +-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 47233f0c6ea0..dec736a07c54 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -853,7 +853,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
-	.support_sar_by_ant	= false,
+	.support_sar_by_ant	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 99c9505b3cbd..0cf03f18cbb1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b_common.h"
+#include "sar.h"
 #include "util.h"
 
 static const struct rtw89_reg3_def rtw8852bx_pmac_ht20_mcs7_tbl[] = {
@@ -1234,6 +1235,7 @@ static u32 rtw8852bx_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 	       u32_encode_bits(ref, B_DPD_REF);
 }
 
+/* @pwr_ofst (unit: 1/8 dBm): power of path A minus power of path B */
 static void rtw8852bx_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				    enum rtw89_phy_idx phy_idx, s16 pwr_ofst)
 {
@@ -1336,6 +1338,27 @@ static void rtw8852bx_set_tx_shape(struct rtw89_dev *rtwdev,
 			       tx_shape_ofdm);
 }
 
+static s16 rtw8852bx_get_txpwr_sar_diff(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan)
+{
+	struct rtw89_sar_parm sar_parm = {
+		.center_freq = chan->freq,
+		.force_path = true,
+	};
+	s16 sar_bb_a, sar_bb_b;
+	s8 sar_mac;
+
+	sar_parm.path = RF_PATH_A;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_bb_a = rtw89_phy_txpwr_mac_to_bb(rtwdev, sar_mac);
+
+	sar_parm.path = RF_PATH_B;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_bb_b = rtw89_phy_txpwr_mac_to_bb(rtwdev, sar_mac);
+
+	return sar_bb_a - sar_bb_b;
+}
+
 static void rtw8852bx_set_txpwr_diff(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     enum rtw89_phy_idx phy_idx)
@@ -1343,6 +1366,7 @@ static void rtw8852bx_set_txpwr_diff(struct rtw89_dev *rtwdev,
 	s16 pwr_ofst;
 
 	pwr_ofst = rtw89_phy_ant_gain_pwr_offset(rtwdev, chan);
+	pwr_ofst += rtw8852bx_get_txpwr_sar_diff(rtwdev, chan);
 	rtw8852bx_set_txpwr_ref(rtwdev, phy_idx, pwr_ofst);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 0903e902d8f4..3aaf70e32652 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -786,7 +786,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
-	.support_sar_by_ant	= false,
+	.support_sar_by_ant	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
-- 
2.25.1


