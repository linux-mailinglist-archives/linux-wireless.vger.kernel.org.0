Return-Path: <linux-wireless+bounces-20607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E5A69ED2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4208D8A05F2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D95157A72;
	Thu, 20 Mar 2025 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SgkOcM3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263181EE7A9
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441303; cv=none; b=GmvLIDzKkdButO9E1DtYjD3zn/iIZ+mrX4ZtHNX+MmHdiVymBXvZ9oQ14DjircBi/WqEbKbyCBzXDRYg7DQahxW2inbuqdDJ2/k0PgVLLPw75Gd3GuCPT1F1Orj5T5JPwMMiiI2dPDxZlkN+qYz6VYy7CCBcRseSbhNwCuVoiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441303; c=relaxed/simple;
	bh=8545nkNNbKMJdnTU3QxNiMSk9d4FWHLEUKrWn+M43P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMkv3TSPcs+WEr7VbtVggkmwPeY60dT5gqzNSn7wr8pVw7TdCgzW73PAV5+Vg3ppWMAKr3VHL29DXce6w17xQuGopn24tEpgWMsC9hEVT9sQMGhA4R9dY8+8T8z+PuDi9rAcNieZcTVDTi1cMqE2UKyGuYbEfh505AMYvDsdHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SgkOcM3x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3SIQA01751023, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441298; bh=8545nkNNbKMJdnTU3QxNiMSk9d4FWHLEUKrWn+M43P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SgkOcM3x+KR/BB8GKsyZ9m+L6noaSp+1fA3F0y+otgHpwYTKcENrMwqxKhcPy0Oaa
	 LyqBX1kaUYmTPy3s/48+4ULOrWpgOI3ZbMV1jywPmHE+Or+NjmehDbAou6naDH57xR
	 Q23590+63dmEjgFRBtLtgib7QY06712hHQZzWI8MaRPKfMF6GyGI7mvWIV4fSlFUfl
	 EDv/PCsRiQ+fg/8farfVuMoeUVwinaRYtxlxYRonsjmraIDieuHf+7U6rF6X1WiARq
	 Q6k0nKKs4REjCouHUVyV4TcLzJGNjLKXZWc2+LGHJ/sjOIjtjLp//Tv43HWQIjq3PU
	 a7wV0UFYgpc2w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3SIQA01751023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:28:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:28:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:28:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: 8852bx: support different SAR configs by antenna
Date: Thu, 20 Mar 2025 11:27:12 +0800
Message-ID: <20250320032712.20284-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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


