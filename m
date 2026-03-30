Return-Path: <linux-wireless+bounces-34163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKMCCkYgymlO5gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:03:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E56356310
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415F7301FF98
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873B24E4B4;
	Mon, 30 Mar 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AcJDVqAm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7C382399
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853943; cv=none; b=O8ALnX/mBpViLBM/qQzI9VxUqd3tn9FA/b+ZLjFp70HxNQiopZEfFbc/eS3iuopJ0WH+LdpEWsmaP4qOMYfxsUE9uKBMiInw9RloAmk+HKOuooDHgCnk99yNkkdveV1h7bsQw3bbDaA8dU0mn/pDWGcqb4dA02q8SD34iqpqhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853943; c=relaxed/simple;
	bh=CF5VF4kMThlb96qmY3PX8F8xJhBvS9g2t29sHB/fj2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBcLmuwfGCkg7t8UoBC1C23ZDufZ/nGB0yKGAFPHPKZgBKNghWpJjnzRGJqrveFTZjW9DwnZXZZKt3KPMRYxQGp6nwoK97BhSiyyoqM95ednIEGgz4UgsqvRoY2kHJtjhXLglkFJqpAa1Vykww6oXnKV/mrkOnsh8OyC0AJ7bws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AcJDVqAm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6wxiB7673797, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853939; bh=jyAqt3pR0bfbCFrByoZjpImBjIsj/s7IgPHH8D1i5ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AcJDVqAm7mUGbduQqmvzNb0Zu4Q3N9dxh3i7oqi+32qGYNJTTZBDzvISPIQKg+lww
	 FW6o6eN3DH4HWPW8J8at0vjBUJHzWA5zceRBZOqahFcEOFg7Pc+n0cNAsiTut+H0n8
	 oqHnoUJvErdijBKSll/AVx+ManHz6/oNTAbIQFJBU8BkTxE/jcuTW0Q+fmfFvn7Pxg
	 nvUz81Cds7yPrcWbBc/t3WBF+FKEkdd4T4okngUUxcwRTq0iIARf+bDxbNrYwRUwKJ
	 VScal6D0lIbtW1K6aRY2Qy92boKeKyO/GWlVhy5kEYNKLXxV8YIZ5gm9pUhJ+BBEwf
	 tavMnKUwBA4Fw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6wxiB7673797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:58:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:58:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 2/9] wifi: rtw89: 8922d: add set channel with pre-/post- helpers
Date: Mon, 30 Mar 2026 14:58:40 +0800
Message-ID: <20260330065847.48946-3-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34163-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 43E56356310
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The main set channel function calls MAC/BB/RF ones, and pre-/post- helpers
are called before/after the main function to backup/restore and
stop/restart circuits, including TX scheduler, PPDU status, DACK and TSSI.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  14 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 102 ++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c | 230 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |   4 +
 4 files changed, 350 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e64bd74db83a..195d4806c4ef 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8445,6 +8445,8 @@
 #define RR_MOD_M_RXBB GENMASK(9, 5)
 #define RR_MOD_LO_SEL BIT(1)
 #define RR_MODOPT 0x01
+#define RR_MODOPT_V1 0x10001
+#define RR_SW_SEL BIT(19)
 #define RR_TXG_SEL GENMASK(19, 17)
 #define RR_MODOPT_M_TXPWR GENMASK(5, 0)
 #define RR_WLSEL 0x02
@@ -10527,6 +10529,8 @@
 
 #define R_TXPWR_RSTB0_BE4 0x2250C
 #define B_TXPWR_RSTB0_BE4 BIT(16)
+#define R_TSSI_EN_P0_BE4 0x22510
+#define B_TSSI_EN_P0_BE4 GENMASK(3, 0)
 #define R_TXPWR_RSTB1_BE4 0x2260C
 #define B_TXPWR_RSTB1_BE4 BIT(16)
 
@@ -10640,6 +10644,16 @@
 #define R_RX_PATH0_TBL0_BE4 0x2E028
 #define R_RX_PATH1_TBL0_BE4 0x2E128
 
+#define R_KTBL0A_BE4 0x38104
+#define R_KTBL0B_BE4 0x38204
+#define B_KTBL0_IDX0 GENMASK(1, 0)
+#define B_KTBL0_IDX1 GENMASK(9, 8)
+#define B_KTBL0_RST BIT(31)
+#define R_KTBL1A_BE4 0x38154
+#define R_KTBL1B_BE4 0x38254
+#define B_KTBL1_TBL0 BIT(3)
+#define B_KTBL1_TBL1 BIT(5)
+
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
 #define B_AX_WDT_EN BIT(31)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 51b025d898ff..a2dd504c99ed 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2066,6 +2066,108 @@ static void rtw8922d_set_channel_bb(struct rtw89_dev *rtwdev,
 	rtw8922d_tssi_reset(rtwdev, RF_PATH_AB, phy_idx);
 }
 
+static void rtw8922d_pre_set_channel_bb(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy_idx)
+{
+	if (!rtwdev->dbcc_en)
+		return;
+
+	rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4, B_SYS_DBCC_BE4, 0x0);
+
+	if (phy_idx == RTW89_PHY_0) {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
+		fsleep(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEBAD);
+		fsleep(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEAAD);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
+		fsleep(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		fsleep(1);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEEFF);
+	}
+
+	fsleep(1);
+}
+
+static void rtw8922d_post_set_channel_bb(struct rtw89_dev *rtwdev,
+					 enum rtw89_mlo_dbcc_mode mode,
+					 enum rtw89_phy_idx phy_idx)
+{
+	if (!rtwdev->dbcc_en)
+		return;
+
+	rtw8922d_ctrl_mlo(rtwdev, mode, true);
+}
+
+static void rtw8922d_set_channel(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_mac_idx mac_idx,
+				 enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_set_channel_mac(rtwdev, chan, mac_idx);
+	rtw8922d_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8922d_set_channel_rf(rtwdev, chan, phy_idx);
+}
+
+static void __rtw8922d_dack_reset(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, 0x3c000 + (path << 8), BIT(17), 0x0);
+	rtw89_phy_write32_mask(rtwdev, 0x3c000 + (path << 8), BIT(17), 0x1);
+}
+
+static void rtw8922d_dack_reset(struct rtw89_dev *rtwdev)
+{
+	__rtw8922d_dack_reset(rtwdev, RF_PATH_A);
+	__rtw8922d_dack_reset(rtwdev, RF_PATH_B);
+}
+
+static
+void rtw8922d_hal_reset(struct rtw89_dev *rtwdev,
+			enum rtw89_phy_idx phy_idx, enum rtw89_mac_idx mac_idx,
+			enum rtw89_band band, u32 *tx_en, bool enter)
+{
+	if (enter) {
+		rtw89_chip_stop_sch_tx(rtwdev, mac_idx, tx_en, RTW89_SCH_TX_SEL_ALL);
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, false);
+		rtw8922d_dack_reset(rtwdev);
+		rtw8922d_tssi_cont_en_phyidx(rtwdev, false, phy_idx);
+		fsleep(40);
+		rtw8922d_bb_reset_en(rtwdev, band, false, phy_idx);
+	} else {
+		rtw89_mac_cfg_ppdu_status(rtwdev, mac_idx, true);
+		rtw8922d_tssi_cont_en_phyidx(rtwdev, true, phy_idx);
+		rtw8922d_bb_reset_en(rtwdev, band, true, phy_idx);
+		rtw89_chip_resume_sch_tx(rtwdev, mac_idx, *tx_en);
+	}
+}
+
+static void rtw8922d_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
+				      struct rtw89_channel_help_params *p,
+				      const struct rtw89_chan *chan,
+				      enum rtw89_mac_idx mac_idx,
+				      enum rtw89_phy_idx phy_idx)
+{
+	if (enter) {
+		rtw8922d_pre_set_channel_bb(rtwdev, phy_idx);
+		rtw8922d_pre_set_channel_rf(rtwdev, phy_idx);
+	}
+
+	rtw8922d_hal_reset(rtwdev, phy_idx, mac_idx, chan->band_type, &p->tx_en, enter);
+
+	if (!enter) {
+		rtw8922d_post_set_channel_bb(rtwdev, rtwdev->mlo_dbcc_mode, phy_idx);
+		rtw8922d_post_set_channel_rf(rtwdev, phy_idx);
+	}
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
index 6b35d196cb81..d1eda19a39a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
@@ -2,11 +2,40 @@
 /* Copyright(c) 2026  Realtek Corporation
  */
 
+#include "chan.h"
+#include "debug.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8922d.h"
 #include "rtw8922d_rfk.h"
 
+static void rtw8922d_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
+				  enum rtw89_rf_path path, u8 phy_idx)
+{
+	static const u32 tssi_trk_man[2] = {R_TSSI_EN_P0_BE4,
+					    R_TSSI_EN_P0_BE4 + 0x100};
+
+	if (en)
+		rtw89_phy_write32_idx(rtwdev, tssi_trk_man[path],
+				      B_TSSI_CONT_EN, 0, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, tssi_trk_man[path],
+				      B_TSSI_CONT_EN, 1, phy_idx);
+}
+
+void rtw8922d_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
+{
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0)
+			rtw8922d_tssi_cont_en(rtwdev, en, RF_PATH_A, phy_idx);
+		else
+			rtw8922d_tssi_cont_en(rtwdev, en, RF_PATH_B, phy_idx);
+	} else {
+		rtw8922d_tssi_cont_en(rtwdev, en, RF_PATH_A, phy_idx);
+		rtw8922d_tssi_cont_en(rtwdev, en, RF_PATH_B, phy_idx);
+	}
+}
+
 static
 void rtw8922d_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     const struct rtw89_chan *chan)
@@ -31,3 +60,204 @@ void rtw8922d_set_channel_rf(struct rtw89_dev *rtwdev,
 {
 	rtw8922d_ctl_band_ch_bw(rtwdev, phy_idx, chan);
 }
+
+enum _rf_syn_pow {
+	RF_SYN_ON_OFF,
+	RF_SYN_OFF_ON,
+	RF_SYN_ALLON,
+	RF_SYN_ALLOFF,
+};
+
+static void rtw8922d_set_syn01(struct rtw89_dev *rtwdev, enum _rf_syn_pow syn)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "SYN config=%d\n", syn);
+
+	if (syn == RF_SYN_ALLON) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, BIT(1), 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MOD, BIT(1), 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, MASKDWORD, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, MASKDWORD, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, MASKDWORD, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, MASKDWORD, 0x1);
+	} else if (syn == RF_SYN_ON_OFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, BIT(1), 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, MASKDWORD, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, MASKDWORD, 0x1);
+	} else if (syn == RF_SYN_OFF_ON) {
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MOD, BIT(1), 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, MASKDWORD, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0xf);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, MASKDWORD, 0x1);
+	} else if (syn == RF_SYN_ALLOFF) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN_V1, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_POW, RR_POW_SYN_V1, 0x0);
+	}
+}
+
+static void rtw8922d_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
+{
+	bool mlo_linking = false;
+
+	if (idx > 2) {
+		rtw89_warn(rtwdev, "[DBCC][ERROR]indx is out of limit!! index(%d)", idx);
+		return;
+	}
+
+	if (mlo_linking) {
+		if (kpath & RF_A) {
+			rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_SW_SEL, 0x0);
+			rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_SW_SEL, 0x0);
+		}
+
+		if (kpath & RF_B) {
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_SW_SEL, 0x0);
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_SW_SEL, 0x0);
+		}
+
+		return;
+	}
+
+	if (kpath & RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_RST, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_IDX0, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_IDX1, idx);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_TXG_SEL, 0x4 | idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_TXG_SEL, 0x4 | idx);
+
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1A_BE4, B_KTBL1_TBL0, idx & BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1A_BE4, B_KTBL1_TBL1, (idx & BIT(1)) >> 1);
+	}
+
+	if (kpath & RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_RST, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_IDX0, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_IDX1, idx);
+
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_TXG_SEL, 0x4 | idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_TXG_SEL, 0x4 | idx);
+
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1B_BE4, B_KTBL1_TBL0, idx & BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1B_BE4, B_KTBL1_TBL1, (idx & BIT(1)) >> 1);
+	}
+}
+
+static u8 rtw8922d_chlk_reload_sel_tbl(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan, u8 path)
+{
+	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
+	u8 tbl_sel;
+
+	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
+		struct rtw89_rfk_chan_desc *p = &desc[tbl_sel];
+
+		p->ch = rfk_mcc->ch[tbl_sel];
+
+		p->has_band = true;
+		p->band = rfk_mcc->band[tbl_sel];
+
+		p->has_bw = true;
+		p->bw = rfk_mcc->bw[tbl_sel];
+	}
+
+	tbl_sel = rtw89_rfk_chan_lookup(rtwdev, desc, ARRAY_SIZE(desc), chan);
+
+	rfk_mcc->ch[tbl_sel] = chan->channel;
+	rfk_mcc->band[tbl_sel] = chan->band_type;
+	rfk_mcc->bw[tbl_sel] = chan->band_width;
+	rfk_mcc->rf18[tbl_sel] = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
+
+	/* shared table array, but tbl_sel can be independent by path */
+	rfk_mcc[path].table_idx = tbl_sel;
+
+	return tbl_sel;
+}
+
+static void rtw8922d_chlk_reload(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan0, *chan1;
+	u8 s0_tbl, s1_tbl;
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	default:
+	case MLO_2_PLUS_0_1RF:
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = chan0;
+		break;
+	case MLO_0_PLUS_2_1RF:
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		chan0 = chan1;
+		break;
+	case MLO_1_PLUS_1_1RF:
+		chan0 = rtw89_mgnt_chan_get(rtwdev, 0);
+		chan1 = rtw89_mgnt_chan_get(rtwdev, 1);
+		break;
+	}
+
+	s0_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, chan0, 0);
+	s1_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, chan1, 1);
+
+	rtw8922d_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
+	rtw8922d_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
+}
+
+static enum _rf_syn_pow rtw8922d_get_syn_pow(struct rtw89_dev *rtwdev)
+{
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_0_PLUS_2_1RF:
+		return RF_SYN_OFF_ON;
+	case MLO_0_PLUS_2_2RF:
+	case MLO_1_PLUS_1_2RF:
+	case MLO_2_PLUS_0_1RF:
+	case MLO_2_PLUS_0_2RF:
+	case MLO_2_PLUS_2_2RF:
+	case MLO_DBCC_NOT_SUPPORT:
+	default:
+		return RF_SYN_ON_OFF;
+	case MLO_1_PLUS_1_1RF:
+	case DBCC_LEGACY:
+		return RF_SYN_ALLON;
+	}
+}
+
+void rtw8922d_rfk_mlo_ctrl(struct rtw89_dev *rtwdev)
+{
+	enum _rf_syn_pow syn_pow = rtw8922d_get_syn_pow(rtwdev);
+
+	if (!rtwdev->dbcc_en)
+		goto set_rfk_reload;
+
+	rtw8922d_set_syn01(rtwdev, syn_pow);
+
+set_rfk_reload:
+	rtw8922d_chlk_reload(rtwdev);
+}
+
+void rtw8922d_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	bool mlo_1_1;
+
+	if (!rtwdev->dbcc_en)
+		return;
+
+	mlo_1_1 = rtw89_is_mlo_1_1(rtwdev);
+	if (mlo_1_1)
+		rtw8922d_set_syn01(rtwdev, RF_SYN_ALLON);
+	else if (phy_idx == RTW89_PHY_0)
+		rtw8922d_set_syn01(rtwdev, RF_SYN_ON_OFF);
+	else
+		rtw8922d_set_syn01(rtwdev, RF_SYN_OFF_ON);
+
+	fsleep(1000);
+}
+
+void rtw8922d_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_rfk_mlo_ctrl(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
index 03af1f0497ac..4c505ae24261 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
@@ -7,8 +7,12 @@
 
 #include "core.h"
 
+void rtw8922d_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
 void rtw8922d_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
+void rtw8922d_rfk_mlo_ctrl(struct rtw89_dev *rtwdev);
+void rtw8922d_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8922d_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 
 #endif
-- 
2.25.1


