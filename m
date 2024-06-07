Return-Path: <linux-wireless+bounces-8665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA18FFCC9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D9B1C26C7C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07678155C91;
	Fri,  7 Jun 2024 07:07:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23574155A47
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744053; cv=none; b=jbQTMwfPg7RpToDy+gqYoh5uRqOrSIAOo8lk14XEMqrm+/dgtSalx7YlJEPbXIAa45QbcDRJI7b8K/fXSR5waCeIX3VadcIRs8WCt2QjfdEjjStZ+hD4coU93/fwRTdiNiR9Um3eCGB2EDnuGY5nfXWOMGiv2Ra/0MKv+f/azEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744053; c=relaxed/simple;
	bh=wUB3BGS3cL856CYPWZwW5ASXRNA2qf28/vRLyQw5ZPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBVMT/6Lgg09k7C/poU0Uz0yyRJnHHQyC/thfrlHIXKiWcpVIAmgIKiOgVdppZK42LmW2573b6m0cMLFLZyHIwovk6GZJhWS62guUvjvAc6kNm/ycTdeuVPf0Cg5rYst1KxsC/FAUVDad0Gw3eX12KF/o07XqCgsK+pPeBqbP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45777OvR43728578, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45777OvR43728578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 15:07:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 15:07:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 15:07:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
Date: Fri, 7 Jun 2024 15:06:57 +0800
Message-ID: <20240607070659.80263-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607070659.80263-1-pkshih@realtek.com>
References: <20240607070659.80263-1-pkshih@realtek.com>
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

New upcoming chip is RTL8852BE-VT (or RTL8852BTE; 8852BT PCIE interface),
which is a variant of 8852B, and many codes excepting to RF calibration
can be shared, so move common code to an new kernel module named
rtw89_8852b_common.ko.

No logic change.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig    |    4 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1691 +---------------
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  122 --
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 1701 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  339 ++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |   19 +-
 7 files changed, 2079 insertions(+), 1800 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index eaea4eaeb361..3c9f864805b1 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -22,6 +22,9 @@ config RTW89_8851B
 config RTW89_8852A
 	tristate
 
+config RTW89_8852B_COMMON
+	tristate
+
 config RTW89_8852B
 	tristate
 
@@ -59,6 +62,7 @@ config RTW89_8852BE
 	select RTW89_CORE
 	select RTW89_PCI
 	select RTW89_8852B
+	select RTW89_8852B_COMMON
 	help
 	  Select this option will enable support for 8852BE chipset
 
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 86a553fb0136..688847ce7084 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -39,6 +39,9 @@ rtw89_8852a-objs := rtw8852a.o \
 obj-$(CONFIG_RTW89_8852AE) += rtw89_8852ae.o
 rtw89_8852ae-objs := rtw8852ae.o
 
+obj-$(CONFIG_RTW89_8852B_COMMON) += rtw89_8852b_common.o
+rtw89_8852b_common-objs := rtw8852b_common.o
+
 obj-$(CONFIG_RTW89_8852B) += rtw89_8852b.o
 rtw89_8852b-objs := rtw8852b.o \
 		    rtw8852b_table.o \
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 517ad1a763fa..381c881fee69 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b.h"
+#include "rtw8852b_common.h"
 #include "rtw8852b_rfk.h"
 #include "rtw8852b_table.h"
 #include "txrx.h"
@@ -65,167 +66,6 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
-static const struct rtw89_reg3_def rtw8852b_pmac_ht20_mcs7_tbl[] = {
-	{0x4580, 0x0000ffff, 0x0},
-	{0x4580, 0xffff0000, 0x0},
-	{0x4584, 0x0000ffff, 0x0},
-	{0x4584, 0xffff0000, 0x0},
-	{0x4580, 0x0000ffff, 0x1},
-	{0x4578, 0x00ffffff, 0x2018b},
-	{0x4570, 0x03ffffff, 0x7},
-	{0x4574, 0x03ffffff, 0x32407},
-	{0x45b8, 0x00000010, 0x0},
-	{0x45b8, 0x00000100, 0x0},
-	{0x45b8, 0x00000080, 0x0},
-	{0x45b8, 0x00000008, 0x0},
-	{0x45a0, 0x0000ff00, 0x0},
-	{0x45a0, 0xff000000, 0x1},
-	{0x45a4, 0x0000ff00, 0x2},
-	{0x45a4, 0xff000000, 0x3},
-	{0x45b8, 0x00000020, 0x0},
-	{0x4568, 0xe0000000, 0x0},
-	{0x45b8, 0x00000002, 0x1},
-	{0x456c, 0xe0000000, 0x0},
-	{0x45b4, 0x00006000, 0x0},
-	{0x45b4, 0x00001800, 0x1},
-	{0x45b8, 0x00000040, 0x0},
-	{0x45b8, 0x00000004, 0x0},
-	{0x45b8, 0x00000200, 0x0},
-	{0x4598, 0xf8000000, 0x0},
-	{0x45b8, 0x00100000, 0x0},
-	{0x45a8, 0x00000fc0, 0x0},
-	{0x45b8, 0x00200000, 0x0},
-	{0x45b0, 0x00000038, 0x0},
-	{0x45b0, 0x000001c0, 0x0},
-	{0x45a0, 0x000000ff, 0x0},
-	{0x45b8, 0x00400000, 0x0},
-	{0x4590, 0x000007ff, 0x0},
-	{0x45b0, 0x00000e00, 0x0},
-	{0x45ac, 0x0000001f, 0x0},
-	{0x45b8, 0x00800000, 0x0},
-	{0x45a8, 0x0003f000, 0x0},
-	{0x45b8, 0x01000000, 0x0},
-	{0x45b0, 0x00007000, 0x0},
-	{0x45b0, 0x00038000, 0x0},
-	{0x45a0, 0x00ff0000, 0x0},
-	{0x45b8, 0x02000000, 0x0},
-	{0x4590, 0x003ff800, 0x0},
-	{0x45b0, 0x001c0000, 0x0},
-	{0x45ac, 0x000003e0, 0x0},
-	{0x45b8, 0x04000000, 0x0},
-	{0x45a8, 0x00fc0000, 0x0},
-	{0x45b8, 0x08000000, 0x0},
-	{0x45b0, 0x00e00000, 0x0},
-	{0x45b0, 0x07000000, 0x0},
-	{0x45a4, 0x000000ff, 0x0},
-	{0x45b8, 0x10000000, 0x0},
-	{0x4594, 0x000007ff, 0x0},
-	{0x45b0, 0x38000000, 0x0},
-	{0x45ac, 0x00007c00, 0x0},
-	{0x45b8, 0x20000000, 0x0},
-	{0x45a8, 0x3f000000, 0x0},
-	{0x45b8, 0x40000000, 0x0},
-	{0x45b4, 0x00000007, 0x0},
-	{0x45b4, 0x00000038, 0x0},
-	{0x45a4, 0x00ff0000, 0x0},
-	{0x45b8, 0x80000000, 0x0},
-	{0x4594, 0x003ff800, 0x0},
-	{0x45b4, 0x000001c0, 0x0},
-	{0x4598, 0xf8000000, 0x0},
-	{0x45b8, 0x00100000, 0x0},
-	{0x45a8, 0x00000fc0, 0x7},
-	{0x45b8, 0x00200000, 0x0},
-	{0x45b0, 0x00000038, 0x0},
-	{0x45b0, 0x000001c0, 0x0},
-	{0x45a0, 0x000000ff, 0x0},
-	{0x45b4, 0x06000000, 0x0},
-	{0x45b0, 0x00000007, 0x0},
-	{0x45b8, 0x00080000, 0x0},
-	{0x45a8, 0x0000003f, 0x0},
-	{0x457c, 0xffe00000, 0x1},
-	{0x4530, 0xffffffff, 0x0},
-	{0x4588, 0x00003fff, 0x0},
-	{0x4598, 0x000001ff, 0x0},
-	{0x4534, 0xffffffff, 0x0},
-	{0x4538, 0xffffffff, 0x0},
-	{0x453c, 0xffffffff, 0x0},
-	{0x4588, 0x0fffc000, 0x0},
-	{0x4598, 0x0003fe00, 0x0},
-	{0x4540, 0xffffffff, 0x0},
-	{0x4544, 0xffffffff, 0x0},
-	{0x4548, 0xffffffff, 0x0},
-	{0x458c, 0x00003fff, 0x0},
-	{0x4598, 0x07fc0000, 0x0},
-	{0x454c, 0xffffffff, 0x0},
-	{0x4550, 0xffffffff, 0x0},
-	{0x4554, 0xffffffff, 0x0},
-	{0x458c, 0x0fffc000, 0x0},
-	{0x459c, 0x000001ff, 0x0},
-	{0x4558, 0xffffffff, 0x0},
-	{0x455c, 0xffffffff, 0x0},
-	{0x4530, 0xffffffff, 0x4e790001},
-	{0x4588, 0x00003fff, 0x0},
-	{0x4598, 0x000001ff, 0x1},
-	{0x4534, 0xffffffff, 0x0},
-	{0x4538, 0xffffffff, 0x4b},
-	{0x45ac, 0x38000000, 0x7},
-	{0x4588, 0xf0000000, 0x0},
-	{0x459c, 0x7e000000, 0x0},
-	{0x45b8, 0x00040000, 0x0},
-	{0x45b8, 0x00020000, 0x0},
-	{0x4590, 0xffc00000, 0x0},
-	{0x45b8, 0x00004000, 0x0},
-	{0x4578, 0xff000000, 0x0},
-	{0x45b8, 0x00000400, 0x0},
-	{0x45b8, 0x00000800, 0x0},
-	{0x45b8, 0x00001000, 0x0},
-	{0x45b8, 0x00002000, 0x0},
-	{0x45b4, 0x00018000, 0x0},
-	{0x45ac, 0x07800000, 0x0},
-	{0x45b4, 0x00000600, 0x2},
-	{0x459c, 0x0001fe00, 0x80},
-	{0x45ac, 0x00078000, 0x3},
-	{0x459c, 0x01fe0000, 0x1},
-};
-
-static const struct rtw89_reg3_def rtw8852b_btc_preagc_en_defs[] = {
-	{0x46D0, GENMASK(1, 0), 0x3},
-	{0x4790, GENMASK(1, 0), 0x3},
-	{0x4AD4, GENMASK(31, 0), 0xf},
-	{0x4AE0, GENMASK(31, 0), 0xf},
-	{0x4688, GENMASK(31, 24), 0x80},
-	{0x476C, GENMASK(31, 24), 0x80},
-	{0x4694, GENMASK(7, 0), 0x80},
-	{0x4694, GENMASK(15, 8), 0x80},
-	{0x4778, GENMASK(7, 0), 0x80},
-	{0x4778, GENMASK(15, 8), 0x80},
-	{0x4AE4, GENMASK(23, 0), 0x780D1E},
-	{0x4AEC, GENMASK(23, 0), 0x780D1E},
-	{0x469C, GENMASK(31, 26), 0x34},
-	{0x49F0, GENMASK(31, 26), 0x34},
-};
-
-static DECLARE_PHY_REG3_TBL(rtw8852b_btc_preagc_en_defs);
-
-static const struct rtw89_reg3_def rtw8852b_btc_preagc_dis_defs[] = {
-	{0x46D0, GENMASK(1, 0), 0x0},
-	{0x4790, GENMASK(1, 0), 0x0},
-	{0x4AD4, GENMASK(31, 0), 0x60},
-	{0x4AE0, GENMASK(31, 0), 0x60},
-	{0x4688, GENMASK(31, 24), 0x1a},
-	{0x476C, GENMASK(31, 24), 0x1a},
-	{0x4694, GENMASK(7, 0), 0x2a},
-	{0x4694, GENMASK(15, 8), 0x2a},
-	{0x4778, GENMASK(7, 0), 0x2a},
-	{0x4778, GENMASK(15, 8), 0x2a},
-	{0x4AE4, GENMASK(23, 0), 0x79E99E},
-	{0x4AEC, GENMASK(23, 0), 0x79E99E},
-	{0x469C, GENMASK(31, 26), 0x26},
-	{0x49F0, GENMASK(31, 26), 0x26},
-};
-
-static DECLARE_PHY_REG3_TBL(rtw8852b_btc_preagc_dis_defs);
-
 static const u32 rtw8852b_h2c_regs[RTW89_H2CREG_MAX] = {
 	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
 	R_AX_H2CREG_DATA3
@@ -591,806 +431,6 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
-				    struct rtw8852b_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
-static void rtw8852b_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
-					struct rtw8852b_efuse *map)
-{
-	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
-	struct rtw8852b_tssi_offset *ofst[] = {&map->path_a_tssi, &map->path_b_tssi};
-	u8 i, j;
-
-	tssi->thermal[RF_PATH_A] = map->path_a_therm;
-	tssi->thermal[RF_PATH_B] = map->path_b_therm;
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		memcpy(tssi->tssi_cck[i], ofst[i]->cck_tssi,
-		       sizeof(ofst[i]->cck_tssi));
-
-		for (j = 0; j < TSSI_CCK_CH_GROUP_NUM; j++)
-			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
-				    "[TSSI][EFUSE] path=%d cck[%d]=0x%x\n",
-				    i, j, tssi->tssi_cck[i][j]);
-
-		memcpy(tssi->tssi_mcs[i], ofst[i]->bw40_tssi,
-		       sizeof(ofst[i]->bw40_tssi));
-		memcpy(tssi->tssi_mcs[i] + TSSI_MCS_2G_CH_GROUP_NUM,
-		       ofst[i]->bw40_1s_tssi_5g, sizeof(ofst[i]->bw40_1s_tssi_5g));
-
-		for (j = 0; j < TSSI_MCS_CH_GROUP_NUM; j++)
-			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
-				    "[TSSI][EFUSE] path=%d mcs[%d]=0x%x\n",
-				    i, j, tssi->tssi_mcs[i][j]);
-	}
-}
-
-static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
-{
-	if (high)
-		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
-	if (low)
-		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
-
-	return data != 0xff;
-}
-
-static void rtw8852b_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
-					       struct rtw8852b_efuse *map)
-{
-	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
-	bool valid = false;
-
-	valid |= _decode_efuse_gain(map->rx_gain_2g_cck,
-				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK],
-				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_CCK]);
-	valid |= _decode_efuse_gain(map->rx_gain_2g_ofdm,
-				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM],
-				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_OFDM]);
-	valid |= _decode_efuse_gain(map->rx_gain_5g_low,
-				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW],
-				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_LOW]);
-	valid |= _decode_efuse_gain(map->rx_gain_5g_mid,
-				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID],
-				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_MID]);
-	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
-				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
-				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH]);
-
-	gain->offset_valid = valid;
-}
-
-static int rtw8852b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
-			       enum rtw89_efuse_block block)
-{
-	struct rtw89_efuse *efuse = &rtwdev->efuse;
-	struct rtw8852b_efuse *map;
-
-	map = (struct rtw8852b_efuse *)log_map;
-
-	efuse->country_code[0] = map->country_code[0];
-	efuse->country_code[1] = map->country_code[1];
-	rtw8852b_efuse_parsing_tssi(rtwdev, map);
-	rtw8852b_efuse_parsing_gain_offset(rtwdev, map);
-
-	switch (rtwdev->hci.type) {
-	case RTW89_HCI_TYPE_PCIE:
-		rtw8852be_efuse_parsing(efuse, map);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
-
-	return 0;
-}
-
-static void rtw8852b_phycap_parsing_power_cal(struct rtw89_dev *rtwdev, u8 *phycap_map)
-{
-#define PWR_K_CHK_OFFSET 0x5E9
-#define PWR_K_CHK_VALUE 0xAA
-	u32 offset = PWR_K_CHK_OFFSET - rtwdev->chip->phycap_addr;
-
-	if (phycap_map[offset] == PWR_K_CHK_VALUE)
-		rtwdev->efuse.power_k_valid = true;
-}
-
-static void rtw8852b_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
-{
-	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
-	static const u32 tssi_trim_addr[RF_PATH_NUM_8852B] = {0x5D6, 0x5AB};
-	u32 addr = rtwdev->chip->phycap_addr;
-	bool pg = false;
-	u32 ofst;
-	u8 i, j;
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++) {
-			/* addrs are in decreasing order */
-			ofst = tssi_trim_addr[i] - addr - j;
-			tssi->tssi_trim[i][j] = phycap_map[ofst];
-
-			if (phycap_map[ofst] != 0xff)
-				pg = true;
-		}
-	}
-
-	if (!pg) {
-		memset(tssi->tssi_trim, 0, sizeof(tssi->tssi_trim));
-		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
-			    "[TSSI][TRIM] no PG, set all trim info to 0\n");
-	}
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++)
-		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++)
-			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
-				    "[TSSI] path=%d idx=%d trim=0x%x addr=0x%x\n",
-				    i, j, tssi->tssi_trim[i][j],
-				    tssi_trim_addr[i] - j);
-}
-
-static void rtw8852b_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
-						 u8 *phycap_map)
-{
-	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
-	static const u32 thm_trim_addr[RF_PATH_NUM_8852B] = {0x5DF, 0x5DC};
-	u32 addr = rtwdev->chip->phycap_addr;
-	u8 i;
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		info->thermal_trim[i] = phycap_map[thm_trim_addr[i] - addr];
-
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x\n",
-			    i, info->thermal_trim[i]);
-
-		if (info->thermal_trim[i] != 0xff)
-			info->pg_thermal_trim = true;
-	}
-}
-
-static void rtw8852b_thermal_trim(struct rtw89_dev *rtwdev)
-{
-#define __thm_setting(raw)				\
-({							\
-	u8 __v = (raw);					\
-	((__v & 0x1) << 3) | ((__v & 0x1f) >> 1);	\
-})
-	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
-	u8 i, val;
-
-	if (!info->pg_thermal_trim) {
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[THERMAL][TRIM] no PG, do nothing\n");
-
-		return;
-	}
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		val = __thm_setting(info->thermal_trim[i]);
-		rtw89_write_rf(rtwdev, i, RR_TM2, RR_TM2_OFF, val);
-
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[THERMAL][TRIM] path=%d thermal_setting=0x%x\n",
-			    i, val);
-	}
-#undef __thm_setting
-}
-
-static void rtw8852b_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
-						 u8 *phycap_map)
-{
-	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
-	static const u32 pabias_trim_addr[RF_PATH_NUM_8852B] = {0x5DE, 0x5DB};
-	u32 addr = rtwdev->chip->phycap_addr;
-	u8 i;
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
-
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
-			    i, info->pa_bias_trim[i]);
-
-		if (info->pa_bias_trim[i] != 0xff)
-			info->pg_pa_bias_trim = true;
-	}
-}
-
-static void rtw8852b_pa_bias_trim(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
-	u8 pabias_2g, pabias_5g;
-	u8 i;
-
-	if (!info->pg_pa_bias_trim) {
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[PA_BIAS][TRIM] no PG, do nothing\n");
-
-		return;
-	}
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
-		pabias_2g = FIELD_GET(GENMASK(3, 0), info->pa_bias_trim[i]);
-		pabias_5g = FIELD_GET(GENMASK(7, 4), info->pa_bias_trim[i]);
-
-		rtw89_debug(rtwdev, RTW89_DBG_RFK,
-			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
-			    i, pabias_2g, pabias_5g);
-
-		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG, pabias_2g);
-		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA, pabias_5g);
-	}
-}
-
-static void rtw8852b_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phycap_map)
-{
-	static const u32 comp_addrs[][RTW89_SUBBAND_2GHZ_5GHZ_NR] = {
-		{0x5BB, 0x5BA, 0, 0x5B9, 0x5B8},
-		{0x590, 0x58F, 0, 0x58E, 0x58D},
-	};
-	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
-	u32 phycap_addr = rtwdev->chip->phycap_addr;
-	bool valid = false;
-	int path, i;
-	u8 data;
-
-	for (path = 0; path < 2; path++)
-		for (i = 0; i < RTW89_SUBBAND_2GHZ_5GHZ_NR; i++) {
-			if (comp_addrs[path][i] == 0)
-				continue;
-
-			data = phycap_map[comp_addrs[path][i] - phycap_addr];
-			valid |= _decode_efuse_gain(data, NULL,
-						    &gain->comp[path][i]);
-		}
-
-	gain->comp_valid = valid;
-}
-
-static int rtw8852b_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
-{
-	rtw8852b_phycap_parsing_power_cal(rtwdev, phycap_map);
-	rtw8852b_phycap_parsing_tssi(rtwdev, phycap_map);
-	rtw8852b_phycap_parsing_thermal_trim(rtwdev, phycap_map);
-	rtw8852b_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
-	rtw8852b_phycap_parsing_gain_comp(rtwdev, phycap_map);
-
-	return 0;
-}
-
-static void rtw8852b_power_trim(struct rtw89_dev *rtwdev)
-{
-	rtw8852b_thermal_trim(rtwdev);
-	rtw8852b_pa_bias_trim(rtwdev);
-}
-
-static void rtw8852b_set_channel_mac(struct rtw89_dev *rtwdev,
-				     const struct rtw89_chan *chan,
-				     u8 mac_idx)
-{
-	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
-	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
-	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
-	u8 txsc20 = 0, txsc40 = 0;
-
-	switch (chan->band_width) {
-	case RTW89_CHANNEL_WIDTH_80:
-		txsc40 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_40);
-		fallthrough;
-	case RTW89_CHANNEL_WIDTH_40:
-		txsc20 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_20);
-		break;
-	default:
-		break;
-	}
-
-	switch (chan->band_width) {
-	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(1));
-		rtw89_write32(rtwdev, sub_carr, txsc20 | (txsc40 << 4));
-		break;
-	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(0));
-		rtw89_write32(rtwdev, sub_carr, txsc20);
-		break;
-	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_write8_clr(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK);
-		rtw89_write32(rtwdev, sub_carr, 0);
-		break;
-	default:
-		break;
-	}
-
-	if (chan->channel > 14) {
-		rtw89_write8_clr(rtwdev, chk_rate, B_AX_BAND_MODE);
-		rtw89_write8_set(rtwdev, chk_rate,
-				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
-	} else {
-		rtw89_write8_set(rtwdev, chk_rate, B_AX_BAND_MODE);
-		rtw89_write8_clr(rtwdev, chk_rate,
-				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
-	}
-}
-
-static const u32 rtw8852b_sco_barker_threshold[14] = {
-	0x1cfea, 0x1d0e1, 0x1d1d7, 0x1d2cd, 0x1d3c3, 0x1d4b9, 0x1d5b0, 0x1d6a6,
-	0x1d79c, 0x1d892, 0x1d988, 0x1da7f, 0x1db75, 0x1ddc4
-};
-
-static const u32 rtw8852b_sco_cck_threshold[14] = {
-	0x27de3, 0x27f35, 0x28088, 0x281da, 0x2832d, 0x2847f, 0x285d2, 0x28724,
-	0x28877, 0x289c9, 0x28b1c, 0x28c6e, 0x28dc1, 0x290ed
-};
-
-static void rtw8852b_ctrl_sco_cck(struct rtw89_dev *rtwdev, u8 primary_ch)
-{
-	u8 ch_element = primary_ch - 1;
-
-	rtw89_phy_write32_mask(rtwdev, R_RXSCOBC, B_RXSCOBC_TH,
-			       rtw8852b_sco_barker_threshold[ch_element]);
-	rtw89_phy_write32_mask(rtwdev, R_RXSCOCCK, B_RXSCOCCK_TH,
-			       rtw8852b_sco_cck_threshold[ch_element]);
-}
-
-static u8 rtw8852b_sco_mapping(u8 central_ch)
-{
-	if (central_ch == 1)
-		return 109;
-	else if (central_ch >= 2 && central_ch <= 6)
-		return 108;
-	else if (central_ch >= 7 && central_ch <= 10)
-		return 107;
-	else if (central_ch >= 11 && central_ch <= 14)
-		return 106;
-	else if (central_ch == 36 || central_ch == 38)
-		return 51;
-	else if (central_ch >= 40 && central_ch <= 58)
-		return 50;
-	else if (central_ch >= 60 && central_ch <= 64)
-		return 49;
-	else if (central_ch == 100 || central_ch == 102)
-		return 48;
-	else if (central_ch >= 104 && central_ch <= 126)
-		return 47;
-	else if (central_ch >= 128 && central_ch <= 151)
-		return 46;
-	else if (central_ch >= 153 && central_ch <= 177)
-		return 45;
-	else
-		return 0;
-}
-
-struct rtw8852b_bb_gain {
-	u32 gain_g[BB_PATH_NUM_8852B];
-	u32 gain_a[BB_PATH_NUM_8852B];
-	u32 gain_mask;
-};
-
-static const struct rtw8852b_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
-	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
-	  .gain_mask = 0x00ff0000 },
-	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
-	  .gain_mask = 0xff000000 },
-	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
-	  .gain_mask = 0x000000ff },
-	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
-	  .gain_mask = 0x0000ff00 },
-	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
-	  .gain_mask = 0x00ff0000 },
-	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
-	  .gain_mask = 0xff000000 },
-	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
-	  .gain_mask = 0x000000ff },
-};
-
-static const struct rtw8852b_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
-	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
-	  .gain_mask = 0x00ff0000 },
-	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
-	  .gain_mask = 0xff000000 },
-};
-
-static void rtw8852b_set_gain_error(struct rtw89_dev *rtwdev,
-				    enum rtw89_subband subband,
-				    enum rtw89_rf_path path)
-{
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
-	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
-	s32 val;
-	u32 reg;
-	u32 mask;
-	int i;
-
-	for (i = 0; i < LNA_GAIN_NUM; i++) {
-		if (subband == RTW89_CH_2G)
-			reg = bb_gain_lna[i].gain_g[path];
-		else
-			reg = bb_gain_lna[i].gain_a[path];
-
-		mask = bb_gain_lna[i].gain_mask;
-		val = gain->lna_gain[gain_band][path][i];
-		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
-	}
-
-	for (i = 0; i < TIA_GAIN_NUM; i++) {
-		if (subband == RTW89_CH_2G)
-			reg = bb_gain_tia[i].gain_g[path];
-		else
-			reg = bb_gain_tia[i].gain_a[path];
-
-		mask = bb_gain_tia[i].gain_mask;
-		val = gain->tia_gain[gain_band][path][i];
-		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
-	}
-}
-
-static void rtw8852b_set_gain_offset(struct rtw89_dev *rtwdev,
-				     enum rtw89_subband subband,
-				     enum rtw89_phy_idx phy_idx)
-{
-	static const u32 gain_err_addr[2] = {R_P0_AGC_RSVD, R_P1_AGC_RSVD};
-	static const u32 rssi_ofst_addr[2] = {R_PATH0_G_TIA1_LNA6_OP1DB_V1,
-					      R_PATH1_G_TIA1_LNA6_OP1DB_V1};
-	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_phy_efuse_gain *efuse_gain = &rtwdev->efuse_gain;
-	enum rtw89_gain_offset gain_ofdm_band;
-	s32 offset_a, offset_b;
-	s32 offset_ofdm, offset_cck;
-	s32 tmp;
-	u8 path;
-
-	if (!efuse_gain->comp_valid)
-		goto next;
-
-	for (path = RF_PATH_A; path < BB_PATH_NUM_8852B; path++) {
-		tmp = efuse_gain->comp[path][subband];
-		tmp = clamp_t(s32, tmp << 2, S8_MIN, S8_MAX);
-		rtw89_phy_write32_mask(rtwdev, gain_err_addr[path], MASKBYTE0, tmp);
-	}
-
-next:
-	if (!efuse_gain->offset_valid)
-		return;
-
-	gain_ofdm_band = rtw89_subband_to_gain_offset_band_of_ofdm(subband);
-
-	offset_a = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
-	offset_b = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
-
-	tmp = -((offset_a << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
-	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
-	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_A], B_PATH0_R_G_OFST_MASK, tmp);
-
-	tmp = -((offset_b << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
-	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
-	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_B], B_PATH0_R_G_OFST_MASK, tmp);
-
-	if (hal->antenna_rx == RF_B) {
-		offset_ofdm = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
-		offset_cck = -efuse_gain->offset[RF_PATH_B][0];
-	} else {
-		offset_ofdm = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
-		offset_cck = -efuse_gain->offset[RF_PATH_A][0];
-	}
-
-	tmp = (offset_ofdm << 4) + efuse_gain->offset_base[RTW89_PHY_0];
-	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
-	rtw89_phy_write32_idx(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
-
-	tmp = (offset_ofdm << 4) + efuse_gain->rssi_base[RTW89_PHY_0];
-	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
-	rtw89_phy_write32_idx(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
-
-	if (subband == RTW89_CH_2G) {
-		tmp = (offset_cck << 3) + (efuse_gain->offset_base[RTW89_PHY_0] >> 1);
-		tmp = clamp_t(s32, tmp, S8_MIN >> 1, S8_MAX >> 1);
-		rtw89_phy_write32_mask(rtwdev, R_RX_RPL_OFST,
-				       B_RX_RPL_OFST_CCK_MASK, tmp);
-	}
-}
-
-static
-void rtw8852b_set_rxsc_rpl_comp(struct rtw89_dev *rtwdev, enum rtw89_subband subband)
-{
-	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
-	u8 band = rtw89_subband_to_bb_gain_band(subband);
-	u32 val;
-
-	val = FIELD_PREP(B_P0_RPL1_20_MASK, (gain->rpl_ofst_20[band][RF_PATH_A] +
-					     gain->rpl_ofst_20[band][RF_PATH_B]) / 2) |
-	      FIELD_PREP(B_P0_RPL1_40_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][0] +
-					     gain->rpl_ofst_40[band][RF_PATH_B][0]) / 2) |
-	      FIELD_PREP(B_P0_RPL1_41_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][1] +
-					     gain->rpl_ofst_40[band][RF_PATH_B][1]) / 2);
-	val >>= B_P0_RPL1_SHIFT;
-	rtw89_phy_write32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_MASK, val);
-	rtw89_phy_write32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_MASK, val);
-
-	val = FIELD_PREP(B_P0_RTL2_42_MASK, (gain->rpl_ofst_40[band][RF_PATH_A][2] +
-					     gain->rpl_ofst_40[band][RF_PATH_B][2]) / 2) |
-	      FIELD_PREP(B_P0_RTL2_80_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][0] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][0]) / 2) |
-	      FIELD_PREP(B_P0_RTL2_81_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][1] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][1]) / 2) |
-	      FIELD_PREP(B_P0_RTL2_8A_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][10] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][10]) / 2);
-	rtw89_phy_write32(rtwdev, R_P0_RPL2, val);
-	rtw89_phy_write32(rtwdev, R_P1_RPL2, val);
-
-	val = FIELD_PREP(B_P0_RTL3_82_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][2] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][2]) / 2) |
-	      FIELD_PREP(B_P0_RTL3_83_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][3] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][3]) / 2) |
-	      FIELD_PREP(B_P0_RTL3_84_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][4] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][4]) / 2) |
-	      FIELD_PREP(B_P0_RTL3_89_MASK, (gain->rpl_ofst_80[band][RF_PATH_A][9] +
-					     gain->rpl_ofst_80[band][RF_PATH_B][9]) / 2);
-	rtw89_phy_write32(rtwdev, R_P0_RPL3, val);
-	rtw89_phy_write32(rtwdev, R_P1_RPL3, val);
-}
-
-static void rtw8852b_ctrl_ch(struct rtw89_dev *rtwdev,
-			     const struct rtw89_chan *chan,
-			     enum rtw89_phy_idx phy_idx)
-{
-	u8 central_ch = chan->channel;
-	u8 subband = chan->subband_type;
-	u8 sco_comp;
-	bool is_2g = central_ch <= 14;
-
-	/* Path A */
-	if (is_2g)
-		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
-				      B_PATH0_BAND_SEL_MSK_V1, 1, phy_idx);
-	else
-		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
-				      B_PATH0_BAND_SEL_MSK_V1, 0, phy_idx);
-
-	/* Path B */
-	if (is_2g)
-		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
-				      B_PATH1_BAND_SEL_MSK_V1, 1, phy_idx);
-	else
-		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
-				      B_PATH1_BAND_SEL_MSK_V1, 0, phy_idx);
-
-	/* SCO compensate FC setting */
-	sco_comp = rtw8852b_sco_mapping(central_ch);
-	rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_INV, sco_comp, phy_idx);
-
-	if (chan->band_type == RTW89_BAND_6G)
-		return;
-
-	/* CCK parameters */
-	if (central_ch == 14) {
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3b13ff);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x1c42de);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfdb0ad);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xf60f6e);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xfd8f92);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0x2d011);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0x1c02c);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xfff00a);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3d23ff);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x29b354);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfc1c8);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xfdb053);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xf86f9a);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0xfaef92);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0xfe5fcc);
-		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xffdff5);
-	}
-
-	rtw8852b_set_gain_error(rtwdev, subband, RF_PATH_A);
-	rtw8852b_set_gain_error(rtwdev, subband, RF_PATH_B);
-	rtw8852b_set_gain_offset(rtwdev, subband, phy_idx);
-	rtw8852b_set_rxsc_rpl_comp(rtwdev, subband);
-}
-
-static void rtw8852b_bw_setting(struct rtw89_dev *rtwdev, u8 bw, u8 path)
-{
-	static const u32 adc_sel[2] = {0xC0EC, 0xC1EC};
-	static const u32 wbadc_sel[2] = {0xC0E4, 0xC1E4};
-
-	switch (bw) {
-	case RTW89_CHANNEL_WIDTH_5:
-		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x1);
-		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x0);
-		break;
-	case RTW89_CHANNEL_WIDTH_10:
-		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x2);
-		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x1);
-		break;
-	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
-		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
-		break;
-	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
-		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
-		break;
-	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
-		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
-		break;
-	default:
-		rtw89_warn(rtwdev, "Fail to set ADC\n");
-	}
-}
-
-static void rtw8852b_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
-			     enum rtw89_phy_idx phy_idx)
-{
-	u32 rx_path_0;
-
-	switch (bw) {
-	case RTW89_CHANNEL_WIDTH_5:
-		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x1, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
-
-		/*Set RF mode at 3 */
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		break;
-	case RTW89_CHANNEL_WIDTH_10:
-		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x2, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
-
-		/*Set RF mode at 3 */
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		break;
-	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
-
-		/*Set RF mode at 3 */
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		break;
-	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x1, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
-				      pri_ch, phy_idx);
-
-		/*Set RF mode at 3 */
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
-		/*CCK primary channel */
-		if (pri_ch == RTW89_SC_20_UPPER)
-			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 1);
-		else
-			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 0);
-
-		break;
-	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x2, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
-				      pri_ch, phy_idx);
-
-		/*Set RF mode at A */
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
-		break;
-	default:
-		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri ch:%d)\n", bw,
-			   pri_ch);
-	}
-
-	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_A);
-	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_B);
-
-	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0,
-					 phy_idx);
-	if (rx_path_0 == 0x1)
-		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
-				      B_P1_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
-	else if (rx_path_0 == 0x2)
-		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
-				      B_P0_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
-}
-
-static void rtw8852b_ctrl_cck_en(struct rtw89_dev *rtwdev, bool cck_en)
-{
-	if (cck_en) {
-		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 1);
-	}
-}
-
-static void rtw8852b_5m_mask(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
-			     enum rtw89_phy_idx phy_idx)
-{
-	u8 pri_ch = chan->pri_ch_idx;
-	bool mask_5m_low;
-	bool mask_5m_en;
-
-	switch (chan->band_width) {
-	case RTW89_CHANNEL_WIDTH_40:
-		/* Prich=1: Mask 5M High, Prich=2: Mask 5M Low */
-		mask_5m_en = true;
-		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
-		break;
-	case RTW89_CHANNEL_WIDTH_80:
-		/* Prich=3: Mask 5M High, Prich=4: Mask 5M Low, Else: Disable */
-		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
-			     pri_ch == RTW89_SC_20_LOWEST;
-		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
-		break;
-	default:
-		mask_5m_en = false;
-		break;
-	}
-
-	if (!mask_5m_en) {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x0);
-		rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
-				      B_ASSIGN_SBD_OPT_EN_V1, 0x0, phy_idx);
-		return;
-	}
-
-	if (mask_5m_low) {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x1);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x0);
-	}
-	rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
-			      B_ASSIGN_SBD_OPT_EN_V1, 0x1, phy_idx);
-}
-
-static void rtw8852b_bb_reset_all(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
-{
-	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
-	fsleep(1);
-	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
-	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
-}
-
 static void rtw8852b_bb_reset_en(struct rtw89_dev *rtwdev, enum rtw89_band band,
 				 enum rtw89_phy_idx phy_idx, bool en)
 {
@@ -1422,87 +462,20 @@ static void rtw8852b_bb_reset(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_set(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
 	rtw89_phy_write32_set(rtwdev, R_P1_TXPW_RSTB, B_P1_TXPW_RSTB_MANON);
 	rtw89_phy_write32_set(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
-	rtw8852b_bb_reset_all(rtwdev, phy_idx);
+	rtw8852bx_bb_reset_all(rtwdev, phy_idx);
 	rtw89_phy_write32_clr(rtwdev, R_P0_TXPW_RSTB, B_P0_TXPW_RSTB_MANON);
 	rtw89_phy_write32_clr(rtwdev, R_P0_TSSI_TRK, B_P0_TSSI_TRK_EN);
 	rtw89_phy_write32_clr(rtwdev, R_P1_TXPW_RSTB, B_P1_TXPW_RSTB_MANON);
 	rtw89_phy_write32_clr(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_TRK_EN);
 }
 
-static void rtw8852b_bb_macid_ctrl_init(struct rtw89_dev *rtwdev,
-					enum rtw89_phy_idx phy_idx)
-{
-	u32 addr;
-
-	for (addr = R_AX_PWR_MACID_LMT_TABLE0;
-	     addr <= R_AX_PWR_MACID_LMT_TABLE127; addr += 4)
-		rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, 0);
-}
-
-static void rtw8852b_bb_sethw(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
-
-	rtw89_phy_write32_clr(rtwdev, R_P0_EN_SOUND_WO_NDP, B_P0_EN_SOUND_WO_NDP);
-	rtw89_phy_write32_clr(rtwdev, R_P1_EN_SOUND_WO_NDP, B_P1_EN_SOUND_WO_NDP);
-
-	rtw8852b_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
-
-	/* read these registers after loading BB parameters */
-	gain->offset_base[RTW89_PHY_0] =
-		rtw89_phy_read32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK);
-	gain->rssi_base[RTW89_PHY_0] =
-		rtw89_phy_read32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK);
-}
-
-static void rtw8852b_bb_set_pop(struct rtw89_dev *rtwdev)
-{
-	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR)
-		rtw89_phy_write32_clr(rtwdev, R_PKT_CTRL, B_PKT_POP_EN);
-}
-
-static void rtw8852b_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
-				    enum rtw89_phy_idx phy_idx)
-{
-	bool cck_en = chan->channel <= 14;
-	u8 pri_ch_idx = chan->pri_ch_idx;
-	u8 band = chan->band_type, chan_idx;
-
-	if (cck_en)
-		rtw8852b_ctrl_sco_cck(rtwdev,  chan->primary_channel);
-
-	rtw8852b_ctrl_ch(rtwdev, chan, phy_idx);
-	rtw8852b_ctrl_bw(rtwdev, pri_ch_idx, chan->band_width, phy_idx);
-	rtw8852b_ctrl_cck_en(rtwdev, cck_en);
-	if (chan->band_type == RTW89_BAND_5G) {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
-				       B_PATH0_BT_SHARE_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
-				       B_PATH0_BTG_PATH_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
-				       B_PATH1_BT_SHARE_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
-				       B_PATH1_BTG_PATH_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
-				       B_BT_DYN_DC_EST_EN_MSK, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
-	}
-	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
-	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0, chan_idx);
-	rtw8852b_5m_mask(rtwdev, chan, phy_idx);
-	rtw8852b_bb_set_pop(rtwdev);
-	rtw8852b_bb_reset_all(rtwdev, phy_idx);
-}
-
 static void rtw8852b_set_channel(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
 				 enum rtw89_mac_idx mac_idx,
 				 enum rtw89_phy_idx phy_idx)
 {
-	rtw8852b_set_channel_mac(rtwdev, chan, mac_idx);
-	rtw8852b_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8852bx_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8852bx_set_channel_bb(rtwdev, chan, phy_idx);
 	rtw8852b_set_channel_rf(rtwdev, chan, phy_idx);
 }
 
@@ -1602,540 +575,6 @@ static void rtw8852b_rfk_track(struct rtw89_dev *rtwdev)
 	rtw8852b_dpk_track(rtwdev);
 }
 
-static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
-				     enum rtw89_phy_idx phy_idx, s16 ref)
-{
-	const u16 tssi_16dbm_cw = 0x12c;
-	const u8 base_cw_0db = 0x27;
-	const s8 ofst_int = 0;
-	s16 pwr_s10_3;
-	s16 rf_pwr_cw;
-	u16 bb_pwr_cw;
-	u32 pwr_cw;
-	u32 tssi_ofst_cw;
-
-	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
-	bb_pwr_cw = FIELD_GET(GENMASK(2, 0), pwr_s10_3);
-	rf_pwr_cw = FIELD_GET(GENMASK(8, 3), pwr_s10_3);
-	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
-	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
-
-	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
-		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
-
-	return FIELD_PREP(B_DPD_TSSI_CW, tssi_ofst_cw) |
-	       FIELD_PREP(B_DPD_PWR_CW, pwr_cw) |
-	       FIELD_PREP(B_DPD_REF, ref);
-}
-
-static void rtw8852b_set_txpwr_ref(struct rtw89_dev *rtwdev,
-				   enum rtw89_phy_idx phy_idx)
-{
-	static const u32 addr[RF_PATH_NUM_8852B] = {0x5800, 0x7800};
-	const u32 mask = B_DPD_TSSI_CW | B_DPD_PWR_CW | B_DPD_REF;
-	const u8 ofst_ofdm = 0x4;
-	const u8 ofst_cck = 0x8;
-	const s16 ref_ofdm = 0;
-	const s16 ref_cck = 0;
-	u32 val;
-	u8 i;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
-
-	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
-				     B_AX_PWR_REF, 0x0);
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
-	val = rtw8852b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
-				      phy_idx);
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
-	val = rtw8852b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
-
-	for (i = 0; i < RF_PATH_NUM_8852B; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
-				      phy_idx);
-}
-
-static void rtw8852b_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
-					  const struct rtw89_chan *chan,
-					  u8 tx_shape_idx,
-					  enum rtw89_phy_idx phy_idx)
-{
-#define __DFIR_CFG_ADDR(i) (R_TXFIR0 + ((i) << 2))
-#define __DFIR_CFG_MASK 0xffffffff
-#define __DFIR_CFG_NR 8
-#define __DECL_DFIR_PARAM(_name, _val...) \
-	static const u32 param_ ## _name[] = {_val}; \
-	static_assert(ARRAY_SIZE(param_ ## _name) == __DFIR_CFG_NR)
-
-	__DECL_DFIR_PARAM(flat,
-			  0x023D23FF, 0x0029B354, 0x000FC1C8, 0x00FDB053,
-			  0x00F86F9A, 0x06FAEF92, 0x00FE5FCC, 0x00FFDFF5);
-	__DECL_DFIR_PARAM(sharp,
-			  0x023D83FF, 0x002C636A, 0x0013F204, 0x00008090,
-			  0x00F87FB0, 0x06F99F83, 0x00FDBFBA, 0x00003FF5);
-	__DECL_DFIR_PARAM(sharp_14,
-			  0x023B13FF, 0x001C42DE, 0x00FDB0AD, 0x00F60F6E,
-			  0x00FD8F92, 0x0602D011, 0x0001C02C, 0x00FFF00A);
-	u8 ch = chan->channel;
-	const u32 *param;
-	u32 addr;
-	int i;
-
-	if (ch > 14) {
-		rtw89_warn(rtwdev,
-			   "set tx shape dfir by unknown ch: %d on 2G\n", ch);
-		return;
-	}
-
-	if (ch == 14)
-		param = param_sharp_14;
-	else
-		param = tx_shape_idx == 0 ? param_flat : param_sharp;
-
-	for (i = 0; i < __DFIR_CFG_NR; i++) {
-		addr = __DFIR_CFG_ADDR(i);
-		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-			    "set tx shape dfir: 0x%x: 0x%x\n", addr, param[i]);
-		rtw89_phy_write32_idx(rtwdev, addr, __DFIR_CFG_MASK, param[i],
-				      phy_idx);
-	}
-
-#undef __DECL_DFIR_PARAM
-#undef __DFIR_CFG_NR
-#undef __DFIR_CFG_MASK
-#undef __DECL_CFG_ADDR
-}
-
-static void rtw8852b_set_tx_shape(struct rtw89_dev *rtwdev,
-				  const struct rtw89_chan *chan,
-				  enum rtw89_phy_idx phy_idx)
-{
-	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
-	u8 band = chan->band_type;
-	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_OFDM][regd];
-
-	if (band == RTW89_BAND_2G)
-		rtw8852b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
-
-	rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG,
-			       tx_shape_ofdm);
-}
-
-static void rtw8852b_set_txpwr(struct rtw89_dev *rtwdev,
-			       const struct rtw89_chan *chan,
-			       enum rtw89_phy_idx phy_idx)
-{
-	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
-	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
-	rtw8852b_set_tx_shape(rtwdev, chan, phy_idx);
-	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
-	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
-}
-
-static void rtw8852b_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
-				    enum rtw89_phy_idx phy_idx)
-{
-	rtw8852b_set_txpwr_ref(rtwdev, phy_idx);
-}
-
-static
-void rtw8852b_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
-				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
-{
-	u32 reg;
-
-	if (pw_ofst < -16 || pw_ofst > 15) {
-		rtw89_warn(rtwdev, "[ULTB] Err pwr_offset=%d\n", pw_ofst);
-		return;
-	}
-
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_CTRL, mac_idx);
-	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
-
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
-
-	pw_ofst = max_t(s8, pw_ofst - 3, -16);
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, pw_ofst);
-}
-
-static int
-rtw8852b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
-{
-	int ret;
-
-	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL2, 0x07763333);
-	if (ret)
-		return ret;
-
-	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_COEXT_CTRL, 0x01ebf000);
-	if (ret)
-		return ret;
-
-	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL0, 0x0002f8ff);
-	if (ret)
-		return ret;
-
-	rtw8852b_set_txpwr_ul_tb_offset(rtwdev, 0, phy_idx == RTW89_PHY_1 ?
-						   RTW89_MAC_1 : RTW89_MAC_0);
-
-	return 0;
-}
-
-void rtw8852b_bb_set_plcp_tx(struct rtw89_dev *rtwdev)
-{
-	const struct rtw89_reg3_def *def = rtw8852b_pmac_ht20_mcs7_tbl;
-	u8 i;
-
-	for (i = 0; i < ARRAY_SIZE(rtw8852b_pmac_ht20_mcs7_tbl); i++, def++)
-		rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
-}
-
-static void rtw8852b_stop_pmac_tx(struct rtw89_dev *rtwdev,
-				  struct rtw8852b_bb_pmac_info *tx_info,
-				  enum rtw89_phy_idx idx)
-{
-	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Stop Tx");
-	if (tx_info->mode == CONT_TX)
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 0, idx);
-	else if (tx_info->mode == PKTS_TX)
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 0, idx);
-}
-
-static void rtw8852b_start_pmac_tx(struct rtw89_dev *rtwdev,
-				   struct rtw8852b_bb_pmac_info *tx_info,
-				   enum rtw89_phy_idx idx)
-{
-	enum rtw8852b_pmac_mode mode = tx_info->mode;
-	u32 pkt_cnt = tx_info->tx_cnt;
-	u16 period = tx_info->period;
-
-	if (mode == CONT_TX && !tx_info->is_cck) {
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 1, idx);
-		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CTx Start");
-	} else if (mode == PKTS_TX) {
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 1, idx);
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD,
-				      B_PMAC_TX_PRD_MSK, period, idx);
-		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CNT, B_PMAC_TX_CNT_MSK,
-				      pkt_cnt, idx);
-		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC PTx Start");
-	}
-
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 1, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 0, idx);
-}
-
-void rtw8852b_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
-			     struct rtw8852b_bb_pmac_info *tx_info,
-			     enum rtw89_phy_idx idx)
-{
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-
-	if (!tx_info->en_pmac_tx) {
-		rtw8852b_stop_pmac_tx(rtwdev, tx_info, idx);
-		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
-		if (chan->band_type == RTW89_BAND_2G)
-			rtw89_phy_write32_clr(rtwdev, R_RXCCA, B_RXCCA_DIS);
-		return;
-	}
-
-	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Tx Enable");
-
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 1, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 1, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0x3f, idx);
-	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 1, idx);
-	rtw89_phy_write32_set(rtwdev, R_RXCCA, B_RXCCA_DIS);
-	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, idx);
-
-	rtw8852b_start_pmac_tx(rtwdev, tx_info, idx);
-}
-
-void rtw8852b_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
-				 u16 tx_cnt, u16 period, u16 tx_time,
-				 enum rtw89_phy_idx idx)
-{
-	struct rtw8852b_bb_pmac_info tx_info = {0};
-
-	tx_info.en_pmac_tx = enable;
-	tx_info.is_cck = 0;
-	tx_info.mode = PKTS_TX;
-	tx_info.tx_cnt = tx_cnt;
-	tx_info.period = period;
-	tx_info.tx_time = tx_time;
-
-	rtw8852b_bb_set_pmac_tx(rtwdev, &tx_info, idx);
-}
-
-void rtw8852b_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
-			   enum rtw89_phy_idx idx)
-{
-	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx PWR = %d", pwr_dbm);
-
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
-	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, pwr_dbm, idx);
-}
-
-void rtw8852b_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path)
-{
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 7, RTW89_PHY_0);
-
-	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx Path = %d", tx_path);
-
-	if (tx_path == RF_PATH_A) {
-		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 1);
-		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
-	} else if (tx_path == RF_PATH_B) {
-		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 2);
-		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
-	} else if (tx_path == RF_PATH_AB) {
-		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 3);
-		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 4);
-	} else {
-		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Error Tx Path");
-	}
-}
-
-void rtw8852b_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
-				enum rtw89_phy_idx idx, u8 mode)
-{
-	if (mode != 0)
-		return;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Tx mode switch");
-
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_PMAC_RXMOD, B_PMAC_RXMOD_MSK, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_DPD_EN, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0, idx);
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 0, idx);
-}
-
-void rtw8852b_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
-			     struct rtw8852b_bb_tssi_bak *bak)
-{
-	s32 tmp;
-
-	bak->tx_path = rtw89_phy_read32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, idx);
-	bak->rx_path = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, idx);
-	bak->p0_rfmode = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, idx);
-	bak->p0_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, idx);
-	bak->p1_rfmode = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, idx);
-	bak->p1_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, idx);
-	tmp = rtw89_phy_read32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, idx);
-	bak->tx_pwr = sign_extend32(tmp, 8);
-}
-
-void rtw8852b_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
-			      const struct rtw8852b_bb_tssi_bak *bak)
-{
-	rtw89_phy_write32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, bak->tx_path, idx);
-	if (bak->tx_path == RF_AB)
-		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x4);
-	else
-		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x0);
-	rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, bak->rx_path, idx);
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
-	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, bak->p0_rfmode, idx);
-	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, bak->p0_rfmode_ftm, idx);
-	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, bak->p1_rfmode, idx);
-	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, bak->p1_rfmode_ftm, idx);
-	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, bak->tx_pwr, idx);
-}
-
-static void rtw8852b_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
-				     enum rtw89_phy_idx phy_idx)
-{
-	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8852b_btc_preagc_en_defs_tbl :
-						 &rtw8852b_btc_preagc_dis_defs_tbl);
-}
-
-static void rtw8852b_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
-				    enum rtw89_phy_idx phy_idx)
-{
-	if (en) {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
-				       B_PATH0_BT_SHARE_V1, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
-				       B_PATH0_BTG_PATH_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
-				       B_PATH1_G_LNA6_OP1DB_V1, 0x20);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
-				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x30);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
-				       B_PATH1_BT_SHARE_V1, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
-				       B_PATH1_BTG_PATH_V1, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x2);
-		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
-				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x1);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
-				       B_PATH0_BT_SHARE_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
-				       B_PATH0_BTG_PATH_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
-				       B_PATH1_G_LNA6_OP1DB_V1, 0x1a);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
-				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x2a);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
-				       B_PATH1_BT_SHARE_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
-				       B_PATH1_BTG_PATH_V1, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0xc);
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
-				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
-		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
-	}
-}
-
-void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
-			      enum rtw89_rf_path_bit rx_path)
-{
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	u32 rst_mask0;
-	u32 rst_mask1;
-
-	if (rx_path == RF_A) {
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 1);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 1);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
-	} else if (rx_path == RF_B) {
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 2);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 2);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 2);
-		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
-	} else if (rx_path == RF_AB) {
-		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 3);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 3);
-		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 3);
-		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
-	}
-
-	rtw8852b_set_gain_offset(rtwdev, chan->subband_type, RTW89_PHY_0);
-
-	if (chan->band_type == RTW89_BAND_2G &&
-	    (rx_path == RF_B || rx_path == RF_AB))
-		rtw8852b_ctrl_btg_bt_rx(rtwdev, true, RTW89_PHY_0);
-	else
-		rtw8852b_ctrl_btg_bt_rx(rtwdev, false, RTW89_PHY_0);
-
-	rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
-	rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
-	if (rx_path == RF_A) {
-		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 1);
-		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 3);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 1);
-		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 3);
-	}
-}
-
-static void rtw8852b_bb_ctrl_rf_mode_rx_path(struct rtw89_dev *rtwdev,
-					     enum rtw89_rf_path_bit rx_path)
-{
-	if (rx_path == RF_A) {
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
-				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
-				       B_P0_RFMODE_FTM_RX, 0x333);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
-				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
-				       B_P1_RFMODE_FTM_RX, 0x111);
-	} else if (rx_path == RF_B) {
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
-				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
-				       B_P0_RFMODE_FTM_RX, 0x111);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
-				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
-				       B_P1_RFMODE_FTM_RX, 0x333);
-	} else if (rx_path == RF_AB) {
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
-				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
-		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
-				       B_P0_RFMODE_FTM_RX, 0x333);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
-				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
-		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
-				       B_P1_RFMODE_FTM_RX, 0x333);
-	}
-}
-
-static void rtw8852b_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_rf_path_bit rx_path = hal->antenna_rx ? hal->antenna_rx : RF_AB;
-
-	rtw8852b_bb_ctrl_rx_path(rtwdev, rx_path);
-	rtw8852b_bb_ctrl_rf_mode_rx_path(rtwdev, rx_path);
-
-	if (rtwdev->hal.rx_nss == 1) {
-		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
-		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
-	}
-
-	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0x0, RTW89_PHY_0);
-}
-
-static u8 rtw8852b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
-{
-	if (rtwdev->is_tssi_mode[rf_path]) {
-		u32 addr = 0x1c10 + (rf_path << 13);
-
-		return rtw89_phy_read32_mask(rtwdev, addr, 0x3F000000);
-	}
-
-	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
-	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
-	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
-
-	fsleep(200);
-
-	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
-}
-
 static void rtw8852b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
@@ -2402,15 +841,15 @@ static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	switch (level) {
 	case 0: /* original */
 	default:
-		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
-		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
-		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
+		rtw8852bx_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 1;
 		break;
 	}
@@ -2418,105 +857,19 @@ static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	rtw8852b_btc_set_wl_lna2(rtwdev, btc->dm.wl_lna2);
 }
 
-static void rtw8852b_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
-					 struct rtw89_rx_phy_ppdu *phy_ppdu,
-					 struct ieee80211_rx_status *status)
-{
-	u16 chan = phy_ppdu->chan_idx;
-	enum nl80211_band band;
-	u8 ch;
-
-	if (chan == 0)
-		return;
-
-	rtw89_decode_chan_idx(rtwdev, chan, &ch, &band);
-	status->freq = ieee80211_channel_to_frequency(ch, band);
-	status->band = band;
-}
-
-static void rtw8852b_query_ppdu(struct rtw89_dev *rtwdev,
-				struct rtw89_rx_phy_ppdu *phy_ppdu,
-				struct ieee80211_rx_status *status)
-{
-	u8 path;
-	u8 *rx_power = phy_ppdu->rssi;
-
-	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
-	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
-		status->chains |= BIT(path);
-		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
-	}
-	if (phy_ppdu->valid)
-		rtw8852b_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
-}
-
-static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
-{
-	int ret;
-
-	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
-			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
-	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x1);
-	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
-	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
-	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
-
-	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xC7,
-				      FULL_BIT_MASK);
-	if (ret)
-		return ret;
-
-	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xC7,
-				      FULL_BIT_MASK);
-	if (ret)
-		return ret;
-
-	rtw89_write8(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_XYN_CYCLE);
-
-	return 0;
-}
-
-static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
-{
-	u8 wl_rfc_s0;
-	u8 wl_rfc_s1;
-	int ret;
-
-	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
-	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
-			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
-
-	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, &wl_rfc_s0);
-	if (ret)
-		return ret;
-	wl_rfc_s0 &= ~XTAL_SI_RF00S_EN;
-	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, wl_rfc_s0,
-				      FULL_BIT_MASK);
-	if (ret)
-		return ret;
-
-	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, &wl_rfc_s1);
-	if (ret)
-		return ret;
-	wl_rfc_s1 &= ~XTAL_SI_RF10S_EN;
-	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, wl_rfc_s1,
-				      FULL_BIT_MASK);
-	return ret;
-}
-
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
-	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
-	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.enable_bb_rf		= rtw8852bx_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8852bx_mac_disable_bb_rf,
 	.bb_preinit		= NULL,
 	.bb_postinit		= NULL,
 	.bb_reset		= rtw8852b_bb_reset,
-	.bb_sethw		= rtw8852b_bb_sethw,
+	.bb_sethw		= rtw8852bx_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
 	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_channel		= rtw8852b_set_channel,
 	.set_channel_help	= rtw8852b_set_channel_help,
-	.read_efuse		= rtw8852b_read_efuse,
-	.read_phycap		= rtw8852b_read_phycap,
+	.read_efuse		= rtw8852bx_read_efuse,
+	.read_phycap		= rtw8852bx_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_hw_init		= NULL,
@@ -2526,16 +879,16 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.rfk_band_changed	= rtw8852b_rfk_band_changed,
 	.rfk_scan		= rtw8852b_rfk_scan,
 	.rfk_track		= rtw8852b_rfk_track,
-	.power_trim		= rtw8852b_power_trim,
-	.set_txpwr		= rtw8852b_set_txpwr,
-	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
-	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
-	.get_thermal		= rtw8852b_get_thermal,
-	.ctrl_btg_bt_rx		= rtw8852b_ctrl_btg_bt_rx,
-	.query_ppdu		= rtw8852b_query_ppdu,
-	.ctrl_nbtg_bt_tx	= rtw8852b_ctrl_nbtg_bt_tx,
-	.cfg_txrx_path		= rtw8852b_bb_cfg_txrx_path,
-	.set_txpwr_ul_tb_offset	= rtw8852b_set_txpwr_ul_tb_offset,
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
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
index 4f9b3d476879..5ec7180fd355 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -10,128 +10,6 @@
 #define RF_PATH_NUM_8852B 2
 #define BB_PATH_NUM_8852B 2
 
-enum rtw8852b_pmac_mode {
-	NONE_TEST,
-	PKTS_TX,
-	PKTS_RX,
-	CONT_TX
-};
-
-struct rtw8852b_u_efuse {
-	u8 rsvd[0x88];
-	u8 mac_addr[ETH_ALEN];
-};
-
-struct rtw8852b_e_efuse {
-	u8 mac_addr[ETH_ALEN];
-};
-
-struct rtw8852b_tssi_offset {
-	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
-	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
-	u8 rsvd[7];
-	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
-} __packed;
-
-struct rtw8852b_efuse {
-	u8 rsvd[0x210];
-	struct rtw8852b_tssi_offset path_a_tssi;
-	u8 rsvd1[10];
-	struct rtw8852b_tssi_offset path_b_tssi;
-	u8 rsvd2[94];
-	u8 channel_plan;
-	u8 xtal_k;
-	u8 rsvd3;
-	u8 iqk_lck;
-	u8 rsvd4[5];
-	u8 reg_setting:2;
-	u8 tx_diversity:1;
-	u8 rx_diversity:2;
-	u8 ac_mode:1;
-	u8 module_type:2;
-	u8 rsvd5;
-	u8 shared_ant:1;
-	u8 coex_type:3;
-	u8 ant_iso:1;
-	u8 radio_on_off:1;
-	u8 rsvd6:2;
-	u8 eeprom_version;
-	u8 customer_id;
-	u8 tx_bb_swing_2g;
-	u8 tx_bb_swing_5g;
-	u8 tx_cali_pwr_trk_mode;
-	u8 trx_path_selection;
-	u8 rfe_type;
-	u8 country_code[2];
-	u8 rsvd7[3];
-	u8 path_a_therm;
-	u8 path_b_therm;
-	u8 rsvd8[2];
-	u8 rx_gain_2g_ofdm;
-	u8 rsvd9;
-	u8 rx_gain_2g_cck;
-	u8 rsvd10;
-	u8 rx_gain_5g_low;
-	u8 rsvd11;
-	u8 rx_gain_5g_mid;
-	u8 rsvd12;
-	u8 rx_gain_5g_high;
-	u8 rsvd13[35];
-	u8 path_a_cck_pwr_idx[6];
-	u8 path_a_bw40_1tx_pwr_idx[5];
-	u8 path_a_ofdm_1tx_pwr_idx_diff:4;
-	u8 path_a_bw20_1tx_pwr_idx_diff:4;
-	u8 path_a_bw20_2tx_pwr_idx_diff:4;
-	u8 path_a_bw40_2tx_pwr_idx_diff:4;
-	u8 path_a_cck_2tx_pwr_idx_diff:4;
-	u8 path_a_ofdm_2tx_pwr_idx_diff:4;
-	u8 rsvd14[0xf2];
-	union {
-		struct rtw8852b_u_efuse u;
-		struct rtw8852b_e_efuse e;
-	};
-} __packed;
-
-struct rtw8852b_bb_pmac_info {
-	u8 en_pmac_tx:1;
-	u8 is_cck:1;
-	u8 mode:3;
-	u8 rsvd:3;
-	u16 tx_cnt;
-	u16 period;
-	u16 tx_time;
-	u8 duty_cycle;
-};
-
-struct rtw8852b_bb_tssi_bak {
-	u8 tx_path;
-	u8 rx_path;
-	u32 p0_rfmode;
-	u32 p0_rfmode_ftm;
-	u32 p1_rfmode;
-	u32 p1_rfmode_ftm;
-	s16 tx_pwr; /* S9 */
-};
-
 extern const struct rtw89_chip_info rtw8852b_chip_info;
 
-void rtw8852b_bb_set_plcp_tx(struct rtw89_dev *rtwdev);
-void rtw8852b_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
-			     struct rtw8852b_bb_pmac_info *tx_info,
-			     enum rtw89_phy_idx idx);
-void rtw8852b_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
-				 u16 tx_cnt, u16 period, u16 tx_time,
-				 enum rtw89_phy_idx idx);
-void rtw8852b_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
-			   enum rtw89_phy_idx idx);
-void rtw8852b_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path);
-void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
-			      enum rtw89_rf_path_bit rx_path);
-void rtw8852b_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
-				enum rtw89_phy_idx idx, u8 mode);
-void rtw8852b_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
-			     struct rtw8852b_bb_tssi_bak *bak);
-void rtw8852b_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
-			      const struct rtw8852b_bb_tssi_bak *bak);
-
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
new file mode 100644
index 000000000000..0826d257ddba
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -0,0 +1,1701 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8852b_common.h"
+
+static const struct rtw89_reg3_def rtw8852bx_pmac_ht20_mcs7_tbl[] = {
+	{0x4580, 0x0000ffff, 0x0},
+	{0x4580, 0xffff0000, 0x0},
+	{0x4584, 0x0000ffff, 0x0},
+	{0x4584, 0xffff0000, 0x0},
+	{0x4580, 0x0000ffff, 0x1},
+	{0x4578, 0x00ffffff, 0x2018b},
+	{0x4570, 0x03ffffff, 0x7},
+	{0x4574, 0x03ffffff, 0x32407},
+	{0x45b8, 0x00000010, 0x0},
+	{0x45b8, 0x00000100, 0x0},
+	{0x45b8, 0x00000080, 0x0},
+	{0x45b8, 0x00000008, 0x0},
+	{0x45a0, 0x0000ff00, 0x0},
+	{0x45a0, 0xff000000, 0x1},
+	{0x45a4, 0x0000ff00, 0x2},
+	{0x45a4, 0xff000000, 0x3},
+	{0x45b8, 0x00000020, 0x0},
+	{0x4568, 0xe0000000, 0x0},
+	{0x45b8, 0x00000002, 0x1},
+	{0x456c, 0xe0000000, 0x0},
+	{0x45b4, 0x00006000, 0x0},
+	{0x45b4, 0x00001800, 0x1},
+	{0x45b8, 0x00000040, 0x0},
+	{0x45b8, 0x00000004, 0x0},
+	{0x45b8, 0x00000200, 0x0},
+	{0x4598, 0xf8000000, 0x0},
+	{0x45b8, 0x00100000, 0x0},
+	{0x45a8, 0x00000fc0, 0x0},
+	{0x45b8, 0x00200000, 0x0},
+	{0x45b0, 0x00000038, 0x0},
+	{0x45b0, 0x000001c0, 0x0},
+	{0x45a0, 0x000000ff, 0x0},
+	{0x45b8, 0x00400000, 0x0},
+	{0x4590, 0x000007ff, 0x0},
+	{0x45b0, 0x00000e00, 0x0},
+	{0x45ac, 0x0000001f, 0x0},
+	{0x45b8, 0x00800000, 0x0},
+	{0x45a8, 0x0003f000, 0x0},
+	{0x45b8, 0x01000000, 0x0},
+	{0x45b0, 0x00007000, 0x0},
+	{0x45b0, 0x00038000, 0x0},
+	{0x45a0, 0x00ff0000, 0x0},
+	{0x45b8, 0x02000000, 0x0},
+	{0x4590, 0x003ff800, 0x0},
+	{0x45b0, 0x001c0000, 0x0},
+	{0x45ac, 0x000003e0, 0x0},
+	{0x45b8, 0x04000000, 0x0},
+	{0x45a8, 0x00fc0000, 0x0},
+	{0x45b8, 0x08000000, 0x0},
+	{0x45b0, 0x00e00000, 0x0},
+	{0x45b0, 0x07000000, 0x0},
+	{0x45a4, 0x000000ff, 0x0},
+	{0x45b8, 0x10000000, 0x0},
+	{0x4594, 0x000007ff, 0x0},
+	{0x45b0, 0x38000000, 0x0},
+	{0x45ac, 0x00007c00, 0x0},
+	{0x45b8, 0x20000000, 0x0},
+	{0x45a8, 0x3f000000, 0x0},
+	{0x45b8, 0x40000000, 0x0},
+	{0x45b4, 0x00000007, 0x0},
+	{0x45b4, 0x00000038, 0x0},
+	{0x45a4, 0x00ff0000, 0x0},
+	{0x45b8, 0x80000000, 0x0},
+	{0x4594, 0x003ff800, 0x0},
+	{0x45b4, 0x000001c0, 0x0},
+	{0x4598, 0xf8000000, 0x0},
+	{0x45b8, 0x00100000, 0x0},
+	{0x45a8, 0x00000fc0, 0x7},
+	{0x45b8, 0x00200000, 0x0},
+	{0x45b0, 0x00000038, 0x0},
+	{0x45b0, 0x000001c0, 0x0},
+	{0x45a0, 0x000000ff, 0x0},
+	{0x45b4, 0x06000000, 0x0},
+	{0x45b0, 0x00000007, 0x0},
+	{0x45b8, 0x00080000, 0x0},
+	{0x45a8, 0x0000003f, 0x0},
+	{0x457c, 0xffe00000, 0x1},
+	{0x4530, 0xffffffff, 0x0},
+	{0x4588, 0x00003fff, 0x0},
+	{0x4598, 0x000001ff, 0x0},
+	{0x4534, 0xffffffff, 0x0},
+	{0x4538, 0xffffffff, 0x0},
+	{0x453c, 0xffffffff, 0x0},
+	{0x4588, 0x0fffc000, 0x0},
+	{0x4598, 0x0003fe00, 0x0},
+	{0x4540, 0xffffffff, 0x0},
+	{0x4544, 0xffffffff, 0x0},
+	{0x4548, 0xffffffff, 0x0},
+	{0x458c, 0x00003fff, 0x0},
+	{0x4598, 0x07fc0000, 0x0},
+	{0x454c, 0xffffffff, 0x0},
+	{0x4550, 0xffffffff, 0x0},
+	{0x4554, 0xffffffff, 0x0},
+	{0x458c, 0x0fffc000, 0x0},
+	{0x459c, 0x000001ff, 0x0},
+	{0x4558, 0xffffffff, 0x0},
+	{0x455c, 0xffffffff, 0x0},
+	{0x4530, 0xffffffff, 0x4e790001},
+	{0x4588, 0x00003fff, 0x0},
+	{0x4598, 0x000001ff, 0x1},
+	{0x4534, 0xffffffff, 0x0},
+	{0x4538, 0xffffffff, 0x4b},
+	{0x45ac, 0x38000000, 0x7},
+	{0x4588, 0xf0000000, 0x0},
+	{0x459c, 0x7e000000, 0x0},
+	{0x45b8, 0x00040000, 0x0},
+	{0x45b8, 0x00020000, 0x0},
+	{0x4590, 0xffc00000, 0x0},
+	{0x45b8, 0x00004000, 0x0},
+	{0x4578, 0xff000000, 0x0},
+	{0x45b8, 0x00000400, 0x0},
+	{0x45b8, 0x00000800, 0x0},
+	{0x45b8, 0x00001000, 0x0},
+	{0x45b8, 0x00002000, 0x0},
+	{0x45b4, 0x00018000, 0x0},
+	{0x45ac, 0x07800000, 0x0},
+	{0x45b4, 0x00000600, 0x2},
+	{0x459c, 0x0001fe00, 0x80},
+	{0x45ac, 0x00078000, 0x3},
+	{0x459c, 0x01fe0000, 0x1},
+};
+
+static const struct rtw89_reg3_def rtw8852bx_btc_preagc_en_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x3},
+	{0x4790, GENMASK(1, 0), 0x3},
+	{0x4AD4, GENMASK(31, 0), 0xf},
+	{0x4AE0, GENMASK(31, 0), 0xf},
+	{0x4688, GENMASK(31, 24), 0x80},
+	{0x476C, GENMASK(31, 24), 0x80},
+	{0x4694, GENMASK(7, 0), 0x80},
+	{0x4694, GENMASK(15, 8), 0x80},
+	{0x4778, GENMASK(7, 0), 0x80},
+	{0x4778, GENMASK(15, 8), 0x80},
+	{0x4AE4, GENMASK(23, 0), 0x780D1E},
+	{0x4AEC, GENMASK(23, 0), 0x780D1E},
+	{0x469C, GENMASK(31, 26), 0x34},
+	{0x49F0, GENMASK(31, 26), 0x34},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8852bx_btc_preagc_en_defs);
+
+static const struct rtw89_reg3_def rtw8852bx_btc_preagc_dis_defs[] = {
+	{0x46D0, GENMASK(1, 0), 0x0},
+	{0x4790, GENMASK(1, 0), 0x0},
+	{0x4AD4, GENMASK(31, 0), 0x60},
+	{0x4AE0, GENMASK(31, 0), 0x60},
+	{0x4688, GENMASK(31, 24), 0x1a},
+	{0x476C, GENMASK(31, 24), 0x1a},
+	{0x4694, GENMASK(7, 0), 0x2a},
+	{0x4694, GENMASK(15, 8), 0x2a},
+	{0x4778, GENMASK(7, 0), 0x2a},
+	{0x4778, GENMASK(15, 8), 0x2a},
+	{0x4AE4, GENMASK(23, 0), 0x79E99E},
+	{0x4AEC, GENMASK(23, 0), 0x79E99E},
+	{0x469C, GENMASK(31, 26), 0x26},
+	{0x49F0, GENMASK(31, 26), 0x26},
+};
+
+static DECLARE_PHY_REG3_TBL(rtw8852bx_btc_preagc_dis_defs);
+
+static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
+				    struct rtw8852bx_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+}
+
+static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					 struct rtw8852bx_efuse *map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	struct rtw8852bx_tssi_offset *ofst[] = {&map->path_a_tssi, &map->path_b_tssi};
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+	tssi->thermal[RF_PATH_B] = map->path_b_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		memcpy(tssi->tssi_cck[i], ofst[i]->cck_tssi,
+		       sizeof(ofst[i]->cck_tssi));
+
+		for (j = 0; j < TSSI_CCK_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d cck[%d]=0x%x\n",
+				    i, j, tssi->tssi_cck[i][j]);
+
+		memcpy(tssi->tssi_mcs[i], ofst[i]->bw40_tssi,
+		       sizeof(ofst[i]->bw40_tssi));
+		memcpy(tssi->tssi_mcs[i] + TSSI_MCS_2G_CH_GROUP_NUM,
+		       ofst[i]->bw40_1s_tssi_5g, sizeof(ofst[i]->bw40_1s_tssi_5g));
+
+		for (j = 0; j < TSSI_MCS_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d mcs[%d]=0x%x\n",
+				    i, j, tssi->tssi_mcs[i][j]);
+	}
+}
+
+static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
+{
+	if (high)
+		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+	if (low)
+		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+
+	return data != 0xff;
+}
+
+static void rtw8852bx_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+						struct rtw8852bx_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	bool valid = false;
+
+	valid |= _decode_efuse_gain(map->rx_gain_2g_cck,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_CCK]);
+	valid |= _decode_efuse_gain(map->rx_gain_2g_ofdm,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_OFDM]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_low,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_LOW]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_mid,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_MID]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH]);
+
+	gain->offset_valid = valid;
+}
+
+static int __rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+				  enum rtw89_efuse_block block)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw8852bx_efuse *map;
+
+	map = (struct rtw8852bx_efuse *)log_map;
+
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	rtw8852bx_efuse_parsing_tssi(rtwdev, map);
+	rtw8852bx_efuse_parsing_gain_offset(rtwdev, map);
+
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		rtw8852be_efuse_parsing(efuse, map);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
+
+	return 0;
+}
+
+static void rtw8852bx_phycap_parsing_power_cal(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+#define PWR_K_CHK_OFFSET 0x5E9
+#define PWR_K_CHK_VALUE 0xAA
+	u32 offset = PWR_K_CHK_OFFSET - rtwdev->chip->phycap_addr;
+
+	if (phycap_map[offset] == PWR_K_CHK_VALUE)
+		rtwdev->efuse.power_k_valid = true;
+}
+
+static void rtw8852bx_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	static const u32 tssi_trim_addr[RF_PATH_NUM_8852BX] = {0x5D6, 0x5AB};
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = false;
+	u32 ofst;
+	u8 i, j;
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++) {
+			/* addrs are in decreasing order */
+			ofst = tssi_trim_addr[i] - addr - j;
+			tssi->tssi_trim[i][j] = phycap_map[ofst];
+
+			if (phycap_map[ofst] != 0xff)
+				pg = true;
+		}
+	}
+
+	if (!pg) {
+		memset(tssi->tssi_trim, 0, sizeof(tssi->tssi_trim));
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM] no PG, set all trim info to 0\n");
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI] path=%d idx=%d trim=0x%x addr=0x%x\n",
+				    i, j, tssi->tssi_trim[i][j],
+				    tssi_trim_addr[i] - j);
+}
+
+static void rtw8852bx_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						  u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 thm_trim_addr[RF_PATH_NUM_8852BX] = {0x5DF, 0x5DC};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		info->thermal_trim[i] = phycap_map[thm_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x\n",
+			    i, info->thermal_trim[i]);
+
+		if (info->thermal_trim[i] != 0xff)
+			info->pg_thermal_trim = true;
+	}
+}
+
+static void rtw8852bx_thermal_trim(struct rtw89_dev *rtwdev)
+{
+#define __thm_setting(raw)				\
+({							\
+	u8 __v = (raw);					\
+	((__v & 0x1) << 3) | ((__v & 0x1f) >> 1);	\
+})
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 i, val;
+
+	if (!info->pg_thermal_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		val = __thm_setting(info->thermal_trim[i]);
+		rtw89_write_rf(rtwdev, i, RR_TM2, RR_TM2_OFF, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_setting=0x%x\n",
+			    i, val);
+	}
+#undef __thm_setting
+}
+
+static void rtw8852bx_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						  u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 pabias_trim_addr[RF_PATH_NUM_8852BX] = {0x5DE, 0x5DB};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
+			    i, info->pa_bias_trim[i]);
+
+		if (info->pa_bias_trim[i] != 0xff)
+			info->pg_pa_bias_trim = true;
+	}
+}
+
+static void rtw8852bx_pa_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pabias_2g, pabias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		pabias_2g = FIELD_GET(GENMASK(3, 0), info->pa_bias_trim[i]);
+		pabias_5g = FIELD_GET(GENMASK(7, 4), info->pa_bias_trim[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pabias_2g, pabias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG, pabias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA, pabias_5g);
+	}
+}
+
+static void rtw8852bx_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	static const u32 comp_addrs[][RTW89_SUBBAND_2GHZ_5GHZ_NR] = {
+		{0x5BB, 0x5BA, 0, 0x5B9, 0x5B8},
+		{0x590, 0x58F, 0, 0x58E, 0x58D},
+	};
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	u32 phycap_addr = rtwdev->chip->phycap_addr;
+	bool valid = false;
+	int path, i;
+	u8 data;
+
+	for (path = 0; path < 2; path++)
+		for (i = 0; i < RTW89_SUBBAND_2GHZ_5GHZ_NR; i++) {
+			if (comp_addrs[path][i] == 0)
+				continue;
+
+			data = phycap_map[comp_addrs[path][i] - phycap_addr];
+			valid |= _decode_efuse_gain(data, NULL,
+						    &gain->comp[path][i]);
+		}
+
+	gain->comp_valid = valid;
+}
+
+static int __rtw8852bx_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8852bx_phycap_parsing_power_cal(rtwdev, phycap_map);
+	rtw8852bx_phycap_parsing_tssi(rtwdev, phycap_map);
+	rtw8852bx_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8852bx_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+	rtw8852bx_phycap_parsing_gain_comp(rtwdev, phycap_map);
+
+	return 0;
+}
+
+static void __rtw8852bx_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_thermal_trim(rtwdev);
+	rtw8852bx_pa_bias_trim(rtwdev);
+}
+
+static void __rtw8852bx_set_channel_mac(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					u8 mac_idx)
+{
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
+	u8 txsc20 = 0, txsc40 = 0;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_80:
+		txsc40 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_40);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_40:
+		txsc20 = rtw89_phy_get_txsc(rtwdev, chan, RTW89_CHANNEL_WIDTH_20);
+		break;
+	default:
+		break;
+	}
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(1));
+		rtw89_write32(rtwdev, sub_carr, txsc20 | (txsc40 << 4));
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_write8_mask(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK, BIT(0));
+		rtw89_write32(rtwdev, sub_carr, txsc20);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_write8_clr(rtwdev, rf_mod, B_AX_WMAC_RFMOD_MASK);
+		rtw89_write32(rtwdev, sub_carr, 0);
+		break;
+	default:
+		break;
+	}
+
+	if (chan->channel > 14) {
+		rtw89_write8_clr(rtwdev, chk_rate, B_AX_BAND_MODE);
+		rtw89_write8_set(rtwdev, chk_rate,
+				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
+	} else {
+		rtw89_write8_set(rtwdev, chk_rate, B_AX_BAND_MODE);
+		rtw89_write8_clr(rtwdev, chk_rate,
+				 B_AX_CHECK_CCK_EN | B_AX_RTS_LIMIT_IN_OFDM6);
+	}
+}
+
+static const u32 rtw8852bx_sco_barker_threshold[14] = {
+	0x1cfea, 0x1d0e1, 0x1d1d7, 0x1d2cd, 0x1d3c3, 0x1d4b9, 0x1d5b0, 0x1d6a6,
+	0x1d79c, 0x1d892, 0x1d988, 0x1da7f, 0x1db75, 0x1ddc4
+};
+
+static const u32 rtw8852bx_sco_cck_threshold[14] = {
+	0x27de3, 0x27f35, 0x28088, 0x281da, 0x2832d, 0x2847f, 0x285d2, 0x28724,
+	0x28877, 0x289c9, 0x28b1c, 0x28c6e, 0x28dc1, 0x290ed
+};
+
+static void rtw8852bx_ctrl_sco_cck(struct rtw89_dev *rtwdev, u8 primary_ch)
+{
+	u8 ch_element = primary_ch - 1;
+
+	rtw89_phy_write32_mask(rtwdev, R_RXSCOBC, B_RXSCOBC_TH,
+			       rtw8852bx_sco_barker_threshold[ch_element]);
+	rtw89_phy_write32_mask(rtwdev, R_RXSCOCCK, B_RXSCOCCK_TH,
+			       rtw8852bx_sco_cck_threshold[ch_element]);
+}
+
+static u8 rtw8852bx_sco_mapping(u8 central_ch)
+{
+	if (central_ch == 1)
+		return 109;
+	else if (central_ch >= 2 && central_ch <= 6)
+		return 108;
+	else if (central_ch >= 7 && central_ch <= 10)
+		return 107;
+	else if (central_ch >= 11 && central_ch <= 14)
+		return 106;
+	else if (central_ch == 36 || central_ch == 38)
+		return 51;
+	else if (central_ch >= 40 && central_ch <= 58)
+		return 50;
+	else if (central_ch >= 60 && central_ch <= 64)
+		return 49;
+	else if (central_ch == 100 || central_ch == 102)
+		return 48;
+	else if (central_ch >= 104 && central_ch <= 126)
+		return 47;
+	else if (central_ch >= 128 && central_ch <= 151)
+		return 46;
+	else if (central_ch >= 153 && central_ch <= 177)
+		return 45;
+	else
+		return 0;
+}
+
+struct rtw8852bx_bb_gain {
+	u32 gain_g[BB_PATH_NUM_8852BX];
+	u32 gain_a[BB_PATH_NUM_8852BX];
+	u32 gain_mask;
+};
+
+static const struct rtw8852bx_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x000000ff },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x0000ff00 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x000000ff },
+};
+
+static const struct rtw8852bx_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0xff000000 },
+};
+
+static void rtw8852bx_set_gain_error(struct rtw89_dev *rtwdev,
+				     enum rtw89_subband subband,
+				     enum rtw89_rf_path path)
+{
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
+	u8 gain_band = rtw89_subband_to_bb_gain_band(subband);
+	s32 val;
+	u32 reg;
+	u32 mask;
+	int i;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_lna[i].gain_g[path];
+		else
+			reg = bb_gain_lna[i].gain_a[path];
+
+		mask = bb_gain_lna[i].gain_mask;
+		val = gain->lna_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+
+	for (i = 0; i < TIA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_tia[i].gain_g[path];
+		else
+			reg = bb_gain_tia[i].gain_a[path];
+
+		mask = bb_gain_tia[i].gain_mask;
+		val = gain->tia_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+}
+
+static void rtw8852bx_set_gain_offset(struct rtw89_dev *rtwdev,
+				      enum rtw89_subband subband,
+				      enum rtw89_phy_idx phy_idx)
+{
+	static const u32 gain_err_addr[2] = {R_P0_AGC_RSVD, R_P1_AGC_RSVD};
+	static const u32 rssi_ofst_addr[2] = {R_PATH0_G_TIA1_LNA6_OP1DB_V1,
+					      R_PATH1_G_TIA1_LNA6_OP1DB_V1};
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_phy_efuse_gain *efuse_gain = &rtwdev->efuse_gain;
+	enum rtw89_gain_offset gain_ofdm_band;
+	s32 offset_a, offset_b;
+	s32 offset_ofdm, offset_cck;
+	s32 tmp;
+	u8 path;
+
+	if (!efuse_gain->comp_valid)
+		goto next;
+
+	for (path = RF_PATH_A; path < BB_PATH_NUM_8852BX; path++) {
+		tmp = efuse_gain->comp[path][subband];
+		tmp = clamp_t(s32, tmp << 2, S8_MIN, S8_MAX);
+		rtw89_phy_write32_mask(rtwdev, gain_err_addr[path], MASKBYTE0, tmp);
+	}
+
+next:
+	if (!efuse_gain->offset_valid)
+		return;
+
+	gain_ofdm_band = rtw89_subband_to_gain_offset_band_of_ofdm(subband);
+
+	offset_a = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
+	offset_b = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
+
+	tmp = -((offset_a << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_A], B_PATH0_R_G_OFST_MASK, tmp);
+
+	tmp = -((offset_b << 2) + (efuse_gain->offset_base[RTW89_PHY_0] >> 2));
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_mask(rtwdev, rssi_ofst_addr[RF_PATH_B], B_PATH0_R_G_OFST_MASK, tmp);
+
+	if (hal->antenna_rx == RF_B) {
+		offset_ofdm = -efuse_gain->offset[RF_PATH_B][gain_ofdm_band];
+		offset_cck = -efuse_gain->offset[RF_PATH_B][0];
+	} else {
+		offset_ofdm = -efuse_gain->offset[RF_PATH_A][gain_ofdm_band];
+		offset_cck = -efuse_gain->offset[RF_PATH_A][0];
+	}
+
+	tmp = (offset_ofdm << 4) + efuse_gain->offset_base[RTW89_PHY_0];
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
+
+	tmp = (offset_ofdm << 4) + efuse_gain->rssi_base[RTW89_PHY_0];
+	tmp = clamp_t(s32, tmp, S8_MIN, S8_MAX);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK, tmp, phy_idx);
+
+	if (subband == RTW89_CH_2G) {
+		tmp = (offset_cck << 3) + (efuse_gain->offset_base[RTW89_PHY_0] >> 1);
+		tmp = clamp_t(s32, tmp, S8_MIN >> 1, S8_MAX >> 1);
+		rtw89_phy_write32_mask(rtwdev, R_RX_RPL_OFST,
+				       B_RX_RPL_OFST_CCK_MASK, tmp);
+	}
+}
+
+static
+void rtw8852bx_set_rxsc_rpl_comp(struct rtw89_dev *rtwdev, enum rtw89_subband subband)
+{
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain.ax;
+	u8 band = rtw89_subband_to_bb_gain_band(subband);
+	u32 val;
+
+	val = u32_encode_bits((gain->rpl_ofst_20[band][RF_PATH_A] +
+			       gain->rpl_ofst_20[band][RF_PATH_B]) >> 1, B_P0_RPL1_20_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_40[band][RF_PATH_A][0] +
+			       gain->rpl_ofst_40[band][RF_PATH_B][0]) >> 1, B_P0_RPL1_40_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_40[band][RF_PATH_A][1] +
+			       gain->rpl_ofst_40[band][RF_PATH_B][1]) >> 1, B_P0_RPL1_41_MASK);
+	val >>= B_P0_RPL1_SHIFT;
+	rtw89_phy_write32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_MASK, val);
+	rtw89_phy_write32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_MASK, val);
+
+	val = u32_encode_bits((gain->rpl_ofst_40[band][RF_PATH_A][2] +
+			       gain->rpl_ofst_40[band][RF_PATH_B][2]) >> 1, B_P0_RTL2_42_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][0] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][0]) >> 1, B_P0_RTL2_80_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][1] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][1]) >> 1, B_P0_RTL2_81_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][10] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][10]) >> 1, B_P0_RTL2_8A_MASK);
+	rtw89_phy_write32(rtwdev, R_P0_RPL2, val);
+	rtw89_phy_write32(rtwdev, R_P1_RPL2, val);
+
+	val = u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][2] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][2]) >> 1, B_P0_RTL3_82_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][3] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][3]) >> 1, B_P0_RTL3_83_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][4] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][4]) >> 1, B_P0_RTL3_84_MASK) |
+	      u32_encode_bits((gain->rpl_ofst_80[band][RF_PATH_A][9] +
+			       gain->rpl_ofst_80[band][RF_PATH_B][9]) >> 1, B_P0_RTL3_89_MASK);
+	rtw89_phy_write32(rtwdev, R_P0_RPL3, val);
+	rtw89_phy_write32(rtwdev, R_P1_RPL3, val);
+}
+
+static void rtw8852bx_ctrl_ch(struct rtw89_dev *rtwdev,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_phy_idx phy_idx)
+{
+	u8 central_ch = chan->channel;
+	u8 subband = chan->subband_type;
+	u8 sco_comp;
+	bool is_2g = central_ch <= 14;
+
+	/* Path A */
+	if (is_2g)
+		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+				      B_PATH0_BAND_SEL_MSK_V1, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_PATH0_BAND_SEL_V1,
+				      B_PATH0_BAND_SEL_MSK_V1, 0, phy_idx);
+
+	/* Path B */
+	if (is_2g)
+		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+				      B_PATH1_BAND_SEL_MSK_V1, 1, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_PATH1_BAND_SEL_V1,
+				      B_PATH1_BAND_SEL_MSK_V1, 0, phy_idx);
+
+	/* SCO compensate FC setting */
+	sco_comp = rtw8852bx_sco_mapping(central_ch);
+	rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_INV, sco_comp, phy_idx);
+
+	if (chan->band_type == RTW89_BAND_6G)
+		return;
+
+	/* CCK parameters */
+	if (central_ch == 14) {
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3b13ff);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x1c42de);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfdb0ad);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xf60f6e);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xfd8f92);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0x2d011);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0x1c02c);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xfff00a);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR0, B_TXFIR_C01, 0x3d23ff);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR2, B_TXFIR_C23, 0x29b354);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR4, B_TXFIR_C45, 0xfc1c8);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR6, B_TXFIR_C67, 0xfdb053);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIR8, B_TXFIR_C89, 0xf86f9a);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRA, B_TXFIR_CAB, 0xfaef92);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRC, B_TXFIR_CCD, 0xfe5fcc);
+		rtw89_phy_write32_mask(rtwdev, R_TXFIRE, B_TXFIR_CEF, 0xffdff5);
+	}
+
+	rtw8852bx_set_gain_error(rtwdev, subband, RF_PATH_A);
+	rtw8852bx_set_gain_error(rtwdev, subband, RF_PATH_B);
+	rtw8852bx_set_gain_offset(rtwdev, subband, phy_idx);
+	rtw8852bx_set_rxsc_rpl_comp(rtwdev, subband);
+}
+
+static void rtw8852b_bw_setting(struct rtw89_dev *rtwdev, u8 bw, u8 path)
+{
+	static const u32 adc_sel[2] = {0xC0EC, 0xC1EC};
+	static const u32 wbadc_sel[2] = {0xC0E4, 0xC1E4};
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x1);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x0);
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x2);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x1);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_mask(rtwdev, adc_sel[path], 0x6000, 0x0);
+		rtw89_phy_write32_mask(rtwdev, wbadc_sel[path], 0x30, 0x2);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to set ADC\n");
+	}
+}
+
+static void rtw8852bx_ctrl_bw(struct rtw89_dev *rtwdev, u8 pri_ch, u8 bw,
+			      enum rtw89_phy_idx phy_idx)
+{
+	u32 rx_path_0;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_10:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH, 0x0, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x1, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
+				      pri_ch, phy_idx);
+
+		/*Set RF mode at 3 */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x333, phy_idx);
+		/*CCK primary channel */
+		if (pri_ch == RTW89_SC_20_UPPER)
+			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 1);
+		else
+			rtw89_phy_write32_mask(rtwdev, R_RXSC, B_RXSC_EN, 0);
+
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rtw89_phy_write32_idx(rtwdev, R_FC0_BW_V1, B_FC0_BW_SET, 0x2, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_SBW, 0x0, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_CHBW_MOD_PRICH,
+				      pri_ch, phy_idx);
+
+		/*Set RF mode at A */
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0xaaa, phy_idx);
+		break;
+	default:
+		rtw89_warn(rtwdev, "Fail to switch bw (bw:%d, pri ch:%d)\n", bw,
+			   pri_ch);
+	}
+
+	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_A);
+	rtw8852b_bw_setting(rtwdev, bw, RF_PATH_B);
+
+	rx_path_0 = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0,
+					 phy_idx);
+	if (rx_path_0 == 0x1)
+		rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_ORI_RX,
+				      B_P1_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
+	else if (rx_path_0 == 0x2)
+		rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_ORI_RX,
+				      B_P0_RFMODE_ORI_RX_ALL, 0x111, phy_idx);
+}
+
+static void rtw8852bx_ctrl_cck_en(struct rtw89_dev *rtwdev, bool cck_en)
+{
+	if (cck_en) {
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_UPD_CLK_ADC, B_ENABLE_CCK, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXCCA, B_RXCCA_DIS, 1);
+	}
+}
+
+static void rtw8852bx_5m_mask(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+			      enum rtw89_phy_idx phy_idx)
+{
+	u8 pri_ch = chan->pri_ch_idx;
+	bool mask_5m_low;
+	bool mask_5m_en;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_40:
+		/* Prich=1: Mask 5M High, Prich=2: Mask 5M Low */
+		mask_5m_en = true;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		/* Prich=3: Mask 5M High, Prich=4: Mask 5M Low, Else: Disable */
+		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
+			     pri_ch == RTW89_SC_20_LOWEST;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
+		break;
+	default:
+		mask_5m_en = false;
+		break;
+	}
+
+	if (!mask_5m_en) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x0);
+		rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
+				      B_ASSIGN_SBD_OPT_EN_V1, 0x0, phy_idx);
+		return;
+	}
+
+	if (mask_5m_low) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_5MDET_V1, B_PATH0_5MDET_SB0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_TH, 0x4);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_EN, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB2, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_5MDET_V1, B_PATH1_5MDET_SB0, 0x0);
+	}
+	rtw89_phy_write32_idx(rtwdev, R_ASSIGN_SBD_OPT_V1,
+			      B_ASSIGN_SBD_OPT_EN_V1, 0x1, phy_idx);
+}
+
+static void __rtw8852bx_bb_reset_all(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x7, phy_idx);
+	fsleep(1);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS, B_S0_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_S1_HW_SI_DIS, B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, phy_idx);
+}
+
+static void rtw8852bx_bb_macid_ctrl_init(struct rtw89_dev *rtwdev,
+					 enum rtw89_phy_idx phy_idx)
+{
+	u32 addr;
+
+	for (addr = R_AX_PWR_MACID_LMT_TABLE0;
+	     addr <= R_AX_PWR_MACID_LMT_TABLE127; addr += 4)
+		rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, 0);
+}
+
+static void __rtw8852bx_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
+	rtw89_phy_write32_clr(rtwdev, R_P0_EN_SOUND_WO_NDP, B_P0_EN_SOUND_WO_NDP);
+	rtw89_phy_write32_clr(rtwdev, R_P1_EN_SOUND_WO_NDP, B_P1_EN_SOUND_WO_NDP);
+
+	rtw8852bx_bb_macid_ctrl_init(rtwdev, RTW89_PHY_0);
+
+	/* read these registers after loading BB parameters */
+	gain->offset_base[RTW89_PHY_0] =
+		rtw89_phy_read32_mask(rtwdev, R_P0_RPL1, B_P0_RPL1_BIAS_MASK);
+	gain->rssi_base[RTW89_PHY_0] =
+		rtw89_phy_read32_mask(rtwdev, R_P1_RPL1, B_P0_RPL1_BIAS_MASK);
+}
+
+static void rtw8852bx_bb_set_pop(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR)
+		rtw89_phy_write32_clr(rtwdev, R_PKT_CTRL, B_PKT_POP_EN);
+}
+
+static
+void __rtw8852bx_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx)
+{
+	bool cck_en = chan->channel <= 14;
+	u8 pri_ch_idx = chan->pri_ch_idx;
+	u8 band = chan->band_type, chan_idx;
+
+	if (cck_en)
+		rtw8852bx_ctrl_sco_cck(rtwdev,  chan->primary_channel);
+
+	rtw8852bx_ctrl_ch(rtwdev, chan, phy_idx);
+	rtw8852bx_ctrl_bw(rtwdev, pri_ch_idx, chan->band_width, phy_idx);
+	rtw8852bx_ctrl_cck_en(rtwdev, cck_en);
+	if (chan->band_type == RTW89_BAND_5G) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
+	}
+	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
+	rtw89_phy_write32_mask(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0, chan_idx);
+	rtw8852bx_5m_mask(rtwdev, chan, phy_idx);
+	rtw8852bx_bb_set_pop(rtwdev);
+	__rtw8852bx_bb_reset_all(rtwdev, phy_idx);
+}
+
+static u32 rtw8852bx_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx, s16 ref)
+{
+	const u16 tssi_16dbm_cw = 0x12c;
+	const u8 base_cw_0db = 0x27;
+	const s8 ofst_int = 0;
+	s16 pwr_s10_3;
+	s16 rf_pwr_cw;
+	u16 bb_pwr_cw;
+	u32 pwr_cw;
+	u32 tssi_ofst_cw;
+
+	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
+	bb_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(2, 0));
+	rf_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(8, 3));
+	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
+	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
+
+	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
+		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
+
+	return u32_encode_bits(tssi_ofst_cw, B_DPD_TSSI_CW) |
+	       u32_encode_bits(pwr_cw, B_DPD_PWR_CW) |
+	       u32_encode_bits(ref, B_DPD_REF);
+}
+
+static void rtw8852bx_set_txpwr_ref(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
+{
+	static const u32 addr[RF_PATH_NUM_8852BX] = {0x5800, 0x7800};
+	const u32 mask = B_DPD_TSSI_CW | B_DPD_PWR_CW | B_DPD_REF;
+	const u8 ofst_ofdm = 0x4;
+	const u8 ofst_cck = 0x8;
+	const s16 ref_ofdm = 0;
+	const s16 ref_cck = 0;
+	u32 val;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
+				     B_AX_PWR_REF, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
+	val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
+				      phy_idx);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
+	val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
+
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
+				      phy_idx);
+}
+
+static void rtw8852bx_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
+					   const struct rtw89_chan *chan,
+					   u8 tx_shape_idx,
+					   enum rtw89_phy_idx phy_idx)
+{
+#define __DFIR_CFG_ADDR(i) (R_TXFIR0 + ((i) << 2))
+#define __DFIR_CFG_MASK 0xffffffff
+#define __DFIR_CFG_NR 8
+#define __DECL_DFIR_PARAM(_name, _val...) \
+	static const u32 param_ ## _name[] = {_val}; \
+	static_assert(ARRAY_SIZE(param_ ## _name) == __DFIR_CFG_NR)
+
+	__DECL_DFIR_PARAM(flat,
+			  0x023D23FF, 0x0029B354, 0x000FC1C8, 0x00FDB053,
+			  0x00F86F9A, 0x06FAEF92, 0x00FE5FCC, 0x00FFDFF5);
+	__DECL_DFIR_PARAM(sharp,
+			  0x023D83FF, 0x002C636A, 0x0013F204, 0x00008090,
+			  0x00F87FB0, 0x06F99F83, 0x00FDBFBA, 0x00003FF5);
+	__DECL_DFIR_PARAM(sharp_14,
+			  0x023B13FF, 0x001C42DE, 0x00FDB0AD, 0x00F60F6E,
+			  0x00FD8F92, 0x0602D011, 0x0001C02C, 0x00FFF00A);
+	u8 ch = chan->channel;
+	const u32 *param;
+	u32 addr;
+	int i;
+
+	if (ch > 14) {
+		rtw89_warn(rtwdev,
+			   "set tx shape dfir by unknown ch: %d on 2G\n", ch);
+		return;
+	}
+
+	if (ch == 14)
+		param = param_sharp_14;
+	else
+		param = tx_shape_idx == 0 ? param_flat : param_sharp;
+
+	for (i = 0; i < __DFIR_CFG_NR; i++) {
+		addr = __DFIR_CFG_ADDR(i);
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "set tx shape dfir: 0x%x: 0x%x\n", addr, param[i]);
+		rtw89_phy_write32_idx(rtwdev, addr, __DFIR_CFG_MASK, param[i],
+				      phy_idx);
+	}
+
+#undef __DECL_DFIR_PARAM
+#undef __DFIR_CFG_NR
+#undef __DFIR_CFG_MASK
+#undef __DECL_CFG_ADDR
+}
+
+static void rtw8852bx_set_tx_shape(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
+				   enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	u8 band = chan->band_type;
+	u8 regd = rtw89_regd_get(rtwdev, band);
+	u8 tx_shape_cck = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_OFDM][regd];
+
+	if (band == RTW89_BAND_2G)
+		rtw8852bx_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
+
+	rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG,
+			       tx_shape_ofdm);
+}
+
+static void __rtw8852bx_set_txpwr(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8852bx_set_tx_shape(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+}
+
+static void __rtw8852bx_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_set_txpwr_ref(rtwdev, phy_idx);
+}
+
+static
+void __rtw8852bx_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+					s8 pw_ofst, enum rtw89_mac_idx mac_idx)
+{
+	u32 reg;
+
+	if (pw_ofst < -16 || pw_ofst > 15) {
+		rtw89_warn(rtwdev, "[ULTB] Err pwr_offset=%d\n", pw_ofst);
+		return;
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_CTRL, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
+
+	pw_ofst = max_t(s8, pw_ofst - 3, -16);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, pw_ofst);
+}
+
+static int
+__rtw8852bx_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	int ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL2, 0x07763333);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_COEXT_CTRL, 0x01ebf000);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL0, 0x0002f8ff);
+	if (ret)
+		return ret;
+
+	rtw8852bx_set_txpwr_ul_tb_offset(rtwdev, 0, phy_idx == RTW89_PHY_1 ?
+						   RTW89_MAC_1 : RTW89_MAC_0);
+
+	return 0;
+}
+
+static
+void __rtw8852bx_bb_set_plcp_tx(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_reg3_def *def = rtw8852bx_pmac_ht20_mcs7_tbl;
+	u8 i;
+
+	for (i = 0; i < ARRAY_SIZE(rtw8852bx_pmac_ht20_mcs7_tbl); i++, def++)
+		rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void rtw8852bx_stop_pmac_tx(struct rtw89_dev *rtwdev,
+				   struct rtw8852bx_bb_pmac_info *tx_info,
+				   enum rtw89_phy_idx idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Stop Tx");
+	if (tx_info->mode == CONT_TX)
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 0, idx);
+	else if (tx_info->mode == PKTS_TX)
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 0, idx);
+}
+
+static void rtw8852bx_start_pmac_tx(struct rtw89_dev *rtwdev,
+				    struct rtw8852bx_bb_pmac_info *tx_info,
+				    enum rtw89_phy_idx idx)
+{
+	enum rtw8852bx_pmac_mode mode = tx_info->mode;
+	u32 pkt_cnt = tx_info->tx_cnt;
+	u16 period = tx_info->period;
+
+	if (mode == CONT_TX && !tx_info->is_cck) {
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 1, idx);
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CTx Start");
+	} else if (mode == PKTS_TX) {
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 1, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD,
+				      B_PMAC_TX_PRD_MSK, period, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CNT, B_PMAC_TX_CNT_MSK,
+				      pkt_cnt, idx);
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC PTx Start");
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 0, idx);
+}
+
+static
+void rtw8852bx_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
+			      struct rtw8852bx_bb_pmac_info *tx_info,
+			      enum rtw89_phy_idx idx)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	if (!tx_info->en_pmac_tx) {
+		rtw8852bx_stop_pmac_tx(rtwdev, tx_info, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
+		if (chan->band_type == RTW89_BAND_2G)
+			rtw89_phy_write32_clr(rtwdev, R_RXCCA, B_RXCCA_DIS);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Tx Enable");
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0x3f, idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 1, idx);
+	rtw89_phy_write32_set(rtwdev, R_RXCCA, B_RXCCA_DIS);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, idx);
+
+	rtw8852bx_start_pmac_tx(rtwdev, tx_info, idx);
+}
+
+static
+void __rtw8852bx_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
+				    u16 tx_cnt, u16 period, u16 tx_time,
+				    enum rtw89_phy_idx idx)
+{
+	struct rtw8852bx_bb_pmac_info tx_info = {0};
+
+	tx_info.en_pmac_tx = enable;
+	tx_info.is_cck = 0;
+	tx_info.mode = PKTS_TX;
+	tx_info.tx_cnt = tx_cnt;
+	tx_info.period = period;
+	tx_info.tx_time = tx_time;
+
+	rtw8852bx_bb_set_pmac_tx(rtwdev, &tx_info, idx);
+}
+
+static
+void __rtw8852bx_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
+			      enum rtw89_phy_idx idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx PWR = %d", pwr_dbm);
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, pwr_dbm, idx);
+}
+
+static
+void __rtw8852bx_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path)
+{
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 7, RTW89_PHY_0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx Path = %d", tx_path);
+
+	if (tx_path == RF_PATH_A) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 1);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
+	} else if (tx_path == RF_PATH_B) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 2);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
+	} else if (tx_path == RF_PATH_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 3);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 4);
+	} else {
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Error Tx Path");
+	}
+}
+
+static
+void __rtw8852bx_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
+				   enum rtw89_phy_idx idx, u8 mode)
+{
+	if (mode != 0)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Tx mode switch");
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RXMOD, B_PMAC_RXMOD_MSK, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_DPD_EN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 0, idx);
+}
+
+static
+void __rtw8852bx_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+				struct rtw8852bx_bb_tssi_bak *bak)
+{
+	s32 tmp;
+
+	bak->tx_path = rtw89_phy_read32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, idx);
+	bak->rx_path = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, idx);
+	bak->p0_rfmode = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, idx);
+	bak->p0_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, idx);
+	bak->p1_rfmode = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, idx);
+	bak->p1_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, idx);
+	tmp = rtw89_phy_read32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, idx);
+	bak->tx_pwr = sign_extend32(tmp, 8);
+}
+
+static
+void __rtw8852bx_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+				 const struct rtw8852bx_bb_tssi_bak *bak)
+{
+	rtw89_phy_write32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, bak->tx_path, idx);
+	if (bak->tx_path == RF_AB)
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x4);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x0);
+	rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, bak->rx_path, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, bak->p0_rfmode, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, bak->p0_rfmode_ftm, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, bak->p1_rfmode, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, bak->p1_rfmode_ftm, idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, bak->tx_pwr, idx);
+}
+
+static void __rtw8852bx_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+					enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8852bx_btc_preagc_en_defs_tbl :
+						 &rtw8852bx_btc_preagc_dis_defs_tbl);
+}
+
+static void __rtw8852bx_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				       enum rtw89_phy_idx phy_idx)
+{
+	if (en) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x20);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x30);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
+				       B_PATH0_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
+				       B_PATH0_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x1a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_SHARE_V1,
+				       B_PATH1_BT_SHARE_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG_PATH_V1,
+				       B_PATH1_BTG_PATH_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0xc);
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_BT_SHARE, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_BT_SEG0, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_BT_DYN_DC_EST_EN_V1,
+				       B_BT_DYN_DC_EST_EN_MSK, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_GNT_BT_WGT_EN, B_GNT_BT_WGT_EN, 0x0);
+	}
+}
+
+static
+void __rtw8852bx_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
+				 enum rtw89_rf_path_bit rx_path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u32 rst_mask0;
+	u32 rst_mask1;
+
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else if (rx_path == RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 2);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 2);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 2);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else if (rx_path == RF_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 3);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 3);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 3);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
+	}
+
+	rtw8852bx_set_gain_offset(rtwdev, chan->subband_type, RTW89_PHY_0);
+
+	if (chan->band_type == RTW89_BAND_2G &&
+	    (rx_path == RF_B || rx_path == RF_AB))
+		rtw8852bx_ctrl_btg_bt_rx(rtwdev, true, RTW89_PHY_0);
+	else
+		rtw8852bx_ctrl_btg_bt_rx(rtwdev, false, RTW89_PHY_0);
+
+	rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
+	rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 3);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 3);
+	}
+}
+
+static void rtw8852bx_bb_ctrl_rf_mode_rx_path(struct rtw89_dev *rtwdev,
+					      enum rtw89_rf_path_bit rx_path)
+{
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x333);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x111);
+	} else if (rx_path == RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x111);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x333);
+	} else if (rx_path == RF_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x333);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x333);
+	}
+}
+
+static void __rtw8852bx_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_rf_path_bit rx_path = hal->antenna_rx ? hal->antenna_rx : RF_AB;
+
+	rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+	rtw8852bx_bb_ctrl_rf_mode_rx_path(rtwdev, rx_path);
+
+	if (rtwdev->hal.rx_nss == 1) {
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0x0, RTW89_PHY_0);
+}
+
+static u8 __rtw8852bx_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
+{
+	if (rtwdev->is_tssi_mode[rf_path]) {
+		u32 addr = 0x1c10 + (rf_path << 13);
+
+		return rtw89_phy_read32_mask(rtwdev, addr, 0x3F000000);
+	}
+
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+
+	fsleep(200);
+
+	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
+}
+
+static void rtw8852bx_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					  struct rtw89_rx_phy_ppdu *phy_ppdu,
+					  struct ieee80211_rx_status *status)
+{
+	u16 chan = phy_ppdu->chan_idx;
+	enum nl80211_band band;
+	u8 ch;
+
+	if (chan == 0)
+		return;
+
+	rtw89_decode_chan_idx(rtwdev, chan, &ch, &band);
+	status->freq = ieee80211_channel_to_frequency(ch, band);
+	status->band = band;
+}
+
+static void __rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
+				   struct rtw89_rx_phy_ppdu *phy_ppdu,
+				   struct ieee80211_rx_status *status)
+{
+	u8 path;
+	u8 *rx_power = phy_ppdu->rssi;
+
+	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		status->chains |= BIT(path);
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
+	}
+	if (phy_ppdu->valid)
+		rtw8852bx_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
+}
+
+static int __rtw8852bx_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0, B_AX_REG_ZCDC_H_MASK, 0x1);
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write32_set(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, 0xC7,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, 0xC7,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	rtw89_write8(rtwdev, R_AX_PHYREG_SET, PHYREG_SET_XYN_CYCLE);
+
+	return 0;
+}
+
+static int __rtw8852bx_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	u8 wl_rfc_s0;
+	u8 wl_rfc_s1;
+	int ret;
+
+	rtw89_write32_clr(rtwdev, R_AX_WLRF_CTRL, B_AX_AFC_AFEDIG);
+	rtw89_write8_clr(rtwdev, R_AX_SYS_FUNC_EN,
+			 B_AX_FEN_BBRSTB | B_AX_FEN_BB_GLB_RSTN);
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, &wl_rfc_s0);
+	if (ret)
+		return ret;
+	wl_rfc_s0 &= ~XTAL_SI_RF00S_EN;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S0, wl_rfc_s0,
+				      FULL_BIT_MASK);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, &wl_rfc_s1);
+	if (ret)
+		return ret;
+	wl_rfc_s1 &= ~XTAL_SI_RF10S_EN;
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_WL_RFC_S1, wl_rfc_s1,
+				      FULL_BIT_MASK);
+	return ret;
+}
+
+const struct rtw8852bx_info rtw8852bx_info = {
+	.mac_enable_bb_rf = __rtw8852bx_mac_enable_bb_rf,
+	.mac_disable_bb_rf = __rtw8852bx_mac_disable_bb_rf,
+	.bb_sethw = __rtw8852bx_bb_sethw,
+	.bb_reset_all = __rtw8852bx_bb_reset_all,
+	.bb_cfg_txrx_path = __rtw8852bx_bb_cfg_txrx_path,
+	.bb_cfg_tx_path = __rtw8852bx_bb_cfg_tx_path,
+	.bb_ctrl_rx_path = __rtw8852bx_bb_ctrl_rx_path,
+	.bb_set_plcp_tx = __rtw8852bx_bb_set_plcp_tx,
+	.bb_set_power = __rtw8852bx_bb_set_power,
+	.bb_set_pmac_pkt_tx = __rtw8852bx_bb_set_pmac_pkt_tx,
+	.bb_backup_tssi = __rtw8852bx_bb_backup_tssi,
+	.bb_restore_tssi = __rtw8852bx_bb_restore_tssi,
+	.bb_tx_mode_switch = __rtw8852bx_bb_tx_mode_switch,
+	.set_channel_mac = __rtw8852bx_set_channel_mac,
+	.set_channel_bb = __rtw8852bx_set_channel_bb,
+	.ctrl_nbtg_bt_tx = __rtw8852bx_ctrl_nbtg_bt_tx,
+	.ctrl_btg_bt_rx = __rtw8852bx_ctrl_btg_bt_rx,
+	.query_ppdu = __rtw8852bx_query_ppdu,
+	.read_efuse = __rtw8852bx_read_efuse,
+	.read_phycap = __rtw8852bx_read_phycap,
+	.power_trim = __rtw8852bx_power_trim,
+	.set_txpwr = __rtw8852bx_set_txpwr,
+	.set_txpwr_ctrl = __rtw8852bx_set_txpwr_ctrl,
+	.init_txpwr_unit = __rtw8852bx_init_txpwr_unit,
+	.set_txpwr_ul_tb_offset = __rtw8852bx_set_txpwr_ul_tb_offset,
+	.get_thermal = __rtw8852bx_get_thermal,
+};
+EXPORT_SYMBOL(rtw8852bx_info);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852B common routines");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
new file mode 100644
index 000000000000..2348a13545ac
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2024  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852BX_H__
+#define __RTW89_8852BX_H__
+
+#include "core.h"
+
+#define RF_PATH_NUM_8852BX 2
+#define BB_PATH_NUM_8852BX 2
+
+enum rtw8852bx_pmac_mode {
+	NONE_TEST,
+	PKTS_TX,
+	PKTS_RX,
+	CONT_TX
+};
+
+struct rtw8852bx_u_efuse {
+	u8 rsvd[0x88];
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852bx_e_efuse {
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852bx_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+} __packed;
+
+struct rtw8852bx_efuse {
+	u8 rsvd[0x210];
+	struct rtw8852bx_tssi_offset path_a_tssi;
+	u8 rsvd1[10];
+	struct rtw8852bx_tssi_offset path_b_tssi;
+	u8 rsvd2[94];
+	u8 channel_plan;
+	u8 xtal_k;
+	u8 rsvd3;
+	u8 iqk_lck;
+	u8 rsvd4[5];
+	u8 reg_setting:2;
+	u8 tx_diversity:1;
+	u8 rx_diversity:2;
+	u8 ac_mode:1;
+	u8 module_type:2;
+	u8 rsvd5;
+	u8 shared_ant:1;
+	u8 coex_type:3;
+	u8 ant_iso:1;
+	u8 radio_on_off:1;
+	u8 rsvd6:2;
+	u8 eeprom_version;
+	u8 customer_id;
+	u8 tx_bb_swing_2g;
+	u8 tx_bb_swing_5g;
+	u8 tx_cali_pwr_trk_mode;
+	u8 trx_path_selection;
+	u8 rfe_type;
+	u8 country_code[2];
+	u8 rsvd7[3];
+	u8 path_a_therm;
+	u8 path_b_therm;
+	u8 rsvd8[2];
+	u8 rx_gain_2g_ofdm;
+	u8 rsvd9;
+	u8 rx_gain_2g_cck;
+	u8 rsvd10;
+	u8 rx_gain_5g_low;
+	u8 rsvd11;
+	u8 rx_gain_5g_mid;
+	u8 rsvd12;
+	u8 rx_gain_5g_high;
+	u8 rsvd13[35];
+	u8 path_a_cck_pwr_idx[6];
+	u8 path_a_bw40_1tx_pwr_idx[5];
+	u8 path_a_ofdm_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_2tx_pwr_idx_diff:4;
+	u8 path_a_bw40_2tx_pwr_idx_diff:4;
+	u8 path_a_cck_2tx_pwr_idx_diff:4;
+	u8 path_a_ofdm_2tx_pwr_idx_diff:4;
+	u8 rsvd14[0xf2];
+	union {
+		struct rtw8852bx_u_efuse u;
+		struct rtw8852bx_e_efuse e;
+	};
+} __packed;
+
+struct rtw8852bx_bb_pmac_info {
+	u8 en_pmac_tx:1;
+	u8 is_cck:1;
+	u8 mode:3;
+	u8 rsvd:3;
+	u16 tx_cnt;
+	u16 period;
+	u16 tx_time;
+	u8 duty_cycle;
+};
+
+struct rtw8852bx_bb_tssi_bak {
+	u8 tx_path;
+	u8 rx_path;
+	u32 p0_rfmode;
+	u32 p0_rfmode_ftm;
+	u32 p1_rfmode;
+	u32 p1_rfmode_ftm;
+	s16 tx_pwr; /* S9 */
+};
+
+struct rtw8852bx_info {
+	int (*mac_enable_bb_rf)(struct rtw89_dev *rtwdev);
+	int (*mac_disable_bb_rf)(struct rtw89_dev *rtwdev);
+	void (*bb_sethw)(struct rtw89_dev *rtwdev);
+	void (*bb_reset_all)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+	void (*bb_cfg_txrx_path)(struct rtw89_dev *rtwdev);
+	void (*bb_cfg_tx_path)(struct rtw89_dev *rtwdev, u8 tx_path);
+	void (*bb_ctrl_rx_path)(struct rtw89_dev *rtwdev,
+				enum rtw89_rf_path_bit rx_path);
+	void (*bb_set_plcp_tx)(struct rtw89_dev *rtwdev);
+	void (*bb_set_power)(struct rtw89_dev *rtwdev, s16 pwr_dbm,
+			     enum rtw89_phy_idx idx);
+	void (*bb_set_pmac_pkt_tx)(struct rtw89_dev *rtwdev, u8 enable,
+				   u16 tx_cnt, u16 period, u16 tx_time,
+				   enum rtw89_phy_idx idx);
+	void (*bb_backup_tssi)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			       struct rtw8852bx_bb_tssi_bak *bak);
+	void (*bb_restore_tssi)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+				const struct rtw8852bx_bb_tssi_bak *bak);
+	void (*bb_tx_mode_switch)(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx idx, u8 mode);
+	void (*set_channel_mac)(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan, u8 mac_idx);
+	void (*set_channel_bb)(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx);
+	void (*ctrl_nbtg_bt_tx)(struct rtw89_dev *rtwdev, bool en,
+				enum rtw89_phy_idx phy_idx);
+	void (*ctrl_btg_bt_rx)(struct rtw89_dev *rtwdev, bool en,
+			       enum rtw89_phy_idx phy_idx);
+	void (*query_ppdu)(struct rtw89_dev *rtwdev,
+			   struct rtw89_rx_phy_ppdu *phy_ppdu,
+			   struct ieee80211_rx_status *status);
+	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map,
+			  enum rtw89_efuse_block block);
+	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
+	void (*power_trim)(struct rtw89_dev *rtwdev);
+	void (*set_txpwr)(struct rtw89_dev *rtwdev,
+			  const struct rtw89_chan *chan,
+			  enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_ctrl)(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx);
+	int (*init_txpwr_unit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
+				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
+	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
+};
+
+extern const struct rtw8852bx_info rtw8852bx_info;
+
+static inline
+int rtw8852bx_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	return rtw8852bx_info.mac_enable_bb_rf(rtwdev);
+}
+
+static inline
+int rtw8852bx_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	return rtw8852bx_info.mac_disable_bb_rf(rtwdev);
+}
+
+static inline
+void rtw8852bx_bb_sethw(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.bb_sethw(rtwdev);
+}
+
+static inline
+void rtw8852bx_bb_reset_all(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.bb_reset_all(rtwdev, phy_idx);
+}
+
+static inline
+void rtw8852bx_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.bb_cfg_txrx_path(rtwdev);
+}
+
+static inline
+void rtw8852bx_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path)
+{
+	rtw8852bx_info.bb_cfg_tx_path(rtwdev, tx_path);
+}
+
+static inline
+void rtw8852bx_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
+			       enum rtw89_rf_path_bit rx_path)
+{
+	rtw8852bx_info.bb_ctrl_rx_path(rtwdev, rx_path);
+}
+
+static inline
+void rtw8852bx_bb_set_plcp_tx(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.bb_set_plcp_tx(rtwdev);
+}
+
+static inline
+void rtw8852bx_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
+			    enum rtw89_phy_idx idx)
+{
+	rtw8852bx_info.bb_set_power(rtwdev, pwr_dbm, idx);
+}
+
+static inline
+void rtw8852bx_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
+				  u16 tx_cnt, u16 period, u16 tx_time,
+				  enum rtw89_phy_idx idx)
+{
+	rtw8852bx_info.bb_set_pmac_pkt_tx(rtwdev, enable, tx_cnt, period, tx_time, idx);
+}
+
+static inline
+void rtw8852bx_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			      struct rtw8852bx_bb_tssi_bak *bak)
+{
+	rtw8852bx_info.bb_backup_tssi(rtwdev, idx, bak);
+}
+
+static inline
+void rtw8852bx_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			       const struct rtw8852bx_bb_tssi_bak *bak)
+{
+	rtw8852bx_info.bb_restore_tssi(rtwdev, idx, bak);
+}
+
+static inline
+void rtw8852bx_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx idx, u8 mode)
+{
+	rtw8852bx_info.bb_tx_mode_switch(rtwdev, idx, mode);
+}
+
+static inline
+void rtw8852bx_set_channel_mac(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan, u8 mac_idx)
+{
+	rtw8852bx_info.set_channel_mac(rtwdev, chan, mac_idx);
+}
+
+static inline
+void rtw8852bx_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.set_channel_bb(rtwdev, chan, phy_idx);
+}
+
+static inline
+void rtw8852bx_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.ctrl_nbtg_bt_tx(rtwdev, en, phy_idx);
+}
+
+static inline
+void rtw8852bx_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.ctrl_btg_bt_rx(rtwdev, en, phy_idx);
+}
+
+static inline
+void rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
+			  struct rtw89_rx_phy_ppdu *phy_ppdu,
+			  struct ieee80211_rx_status *status)
+{
+	rtw8852bx_info.query_ppdu(rtwdev, phy_ppdu, status);
+}
+
+static inline
+int rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			 enum rtw89_efuse_block block)
+{
+	return rtw8852bx_info.read_efuse(rtwdev, log_map, block);
+}
+
+static inline
+int rtw8852bx_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	return rtw8852bx_info.read_phycap(rtwdev, phycap_map);
+}
+
+static inline
+void rtw8852bx_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8852bx_info.power_trim(rtwdev);
+}
+
+static inline
+void rtw8852bx_set_txpwr(struct rtw89_dev *rtwdev,
+			 const struct rtw89_chan *chan,
+			 enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.set_txpwr(rtwdev, chan, phy_idx);
+}
+
+static inline
+void rtw8852bx_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852bx_info.set_txpwr_ctrl(rtwdev, phy_idx);
+}
+
+static inline
+int rtw8852bx_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	return rtw8852bx_info.init_txpwr_unit(rtwdev, phy_idx);
+}
+
+static inline
+void rtw8852bx_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				      s8 pw_ofst, enum rtw89_mac_idx mac_idx)
+{
+	rtw8852bx_info.set_txpwr_ul_tb_offset(rtwdev, pw_ofst, mac_idx);
+}
+
+static inline
+u8 rtw8852bx_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
+{
+	return rtw8852bx_info.get_thermal(rtwdev, rf_path);
+}
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 259df67836a0..7c90e98dc1d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b.h"
+#include "rtw8852b_common.h"
 #include "rtw8852b_rfk.h"
 #include "rtw8852b_rfk_table.h"
 #include "rtw8852b_table.h"
@@ -3433,13 +3434,13 @@ static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		rx_path = RF_ABCD; /* don't change path, but still set others */
 
 	if (enable) {
-		rtw8852b_bb_set_plcp_tx(rtwdev);
-		rtw8852b_bb_cfg_tx_path(rtwdev, path);
-		rtw8852b_bb_ctrl_rx_path(rtwdev, rx_path);
-		rtw8852b_bb_set_power(rtwdev, pwr_dbm, phy);
+		rtw8852bx_bb_set_plcp_tx(rtwdev);
+		rtw8852bx_bb_cfg_tx_path(rtwdev, path);
+		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+		rtw8852bx_bb_set_power(rtwdev, pwr_dbm, phy);
 	}
 
-	rtw8852b_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
+	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
 }
 
 static void _tssi_backup_bb_registers(struct rtw89_dev *rtwdev,
@@ -3578,7 +3579,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	u32 tssi_cw_rpt[RTW8852B_TSSI_PATH_NR] = {0};
 	u8 channel = chan->channel;
 	u8 ch_idx = _tssi_ch_to_idx(rtwdev, channel);
-	struct rtw8852b_bb_tssi_bak tssi_bak;
+	struct rtw8852bx_bb_tssi_bak tssi_bak;
 	s32 aliment_diff, tssi_cw_default;
 	u32 start_time, finish_time;
 	u32 bb_reg_backup[8] = {0};
@@ -3626,7 +3627,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	else
 		band = TSSI_ALIMK_2G;
 
-	rtw8852b_bb_backup_tssi(rtwdev, phy, &tssi_bak);
+	rtw8852bx_bb_backup_tssi(rtwdev, phy, &tssi_bak);
 	_tssi_backup_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup, ARRAY_SIZE(bb_reg_backup));
 
 	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_AVG, B_P0_TSSI_AVG, 0x8);
@@ -3730,8 +3731,8 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 out:
 	_tssi_reload_bb_registers(rtwdev, phy, bb_reg, bb_reg_backup, ARRAY_SIZE(bb_reg_backup));
-	rtw8852b_bb_restore_tssi(rtwdev, phy, &tssi_bak);
-	rtw8852b_bb_tx_mode_switch(rtwdev, phy, 0);
+	rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
+	rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
 
 	finish_time = ktime_get_ns();
 	tssi_info->tssi_alimk_time += finish_time - start_time;
-- 
2.25.1


