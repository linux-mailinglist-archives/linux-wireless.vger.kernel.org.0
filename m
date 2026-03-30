Return-Path: <linux-wireless+bounces-34164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nMS8OGEgymlQ5gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:04:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813635631A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B27130293D2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91C24E4B4;
	Mon, 30 Mar 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZfeEPmPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47739526F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853948; cv=none; b=srfvwwMFgrKw7NljCwQ0a+9KZMQ51Sl7cCEwoH1C701cNwOuoOYW/zVMhU30UGV6c2TGPWOu9jo525XXjR6O5m6R5H84tevm4vvzkx32nAcPT6HNwDNVSYLfPE5Y3N8BZoJA7WfpSQh+t6rbb36u0wMal9gsMro03aptDOZbqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853948; c=relaxed/simple;
	bh=OTAgniUQ7ZTSJfNFfPkklpdzvwb2KU1JTBiFh9GCK7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBRDfa1YIZloCY41woKeeIycgtW9ZtA8lBRVA7cZHUqarE/JfhHLslxOra0I+o8QRoSwmekoeCqxgOPwmDqAPu66d1nGpgRXnIXiGT2J+0kMtuucunCw0Aq+hCHE+fRU5SggQ1i2PV0eGll5Xy4kCBEs/M8dp9IzaZOP/2AZ8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZfeEPmPg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6x49N1673820, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853944; bh=zgQSl/0QV3N3Y0rRndtafv3NCC75KiREEIQPUZTYdhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZfeEPmPgBqL5TQU/L9YtpISwHLhmECX0zVdj8l0ktZv/fr5QwZmbZn/uwJRIQRgs0
	 WRYkk/xmYMPLNR/pMHb2RMEuUgRvDI0WFrJd4rBQE7cd/0HecaBxSkLBxyXGVMxv6j
	 bbAPRgpz3Iu5dLwg+xrZb7P8QPV4KwVE0wFQL/fvE0YCF/TRSliT3DW44NYgSYDYLR
	 STnYsHzTWq73hzQzUizWZIFteMwa8tfs17vCjXQF0FYB0Gi96kQxcitV2DGPUNJ8/A
	 DGKEC64zsC2lzoeUt7XBrKtHwpeSHzqs/dkG6jrREdJ0rZ5NhIHDFMtfuI3dVsRtB4
	 n3sRDI96jpjCg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6x49N1673820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:04 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 3/9] wifi: rtw89: 8922d: add RF calibration ops
Date: Mon, 30 Mar 2026 14:58:41 +0800
Message-ID: <20260330065847.48946-4-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34164-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5813635631A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The chips ops related to RF calibration include init, init_late, channel,
band_change, scan, and track. The init_late is similar to init, but HCI
is ready, so receiving C2H event is possible. The ops channel is the main
function that do all RF calibration on operating channel.

The ops band_change and scan are to reset RF calibration because channel is
switching at these moment, we need to reset RF state. The ops track is to
monitor temperature to check if re-calibrate RF again.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 154 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c |  85 ++++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |   1 +
 4 files changed, 244 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 195d4806c4ef..1a5a5b30a28e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10531,6 +10531,10 @@
 #define B_TXPWR_RSTB0_BE4 BIT(16)
 #define R_TSSI_EN_P0_BE4 0x22510
 #define B_TSSI_EN_P0_BE4 GENMASK(3, 0)
+#define R_USED_TSSI_TRK_ON_P0_BE4 0x22534
+#define B_USED_TSSI_TRK_ON_P0_BE4 BIT(22)
+#define R_TSSI_DCK_MOV_AVG_LEN_P0_BE4 0x225CC
+#define B_TSSI_DCK_MOV_AVG_LEN_P0_BE4 GENMASK(8, 6)
 #define R_TXPWR_RSTB1_BE4 0x2260C
 #define B_TXPWR_RSTB1_BE4 BIT(16)
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a2dd504c99ed..2e6f4504caeb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -3,6 +3,7 @@
  */
 
 #include "chan.h"
+#include "coex.h"
 #include "debug.h"
 #include "efuse.h"
 #include "mac.h"
@@ -2168,6 +2169,159 @@ static void rtw8922d_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	}
 }
 
+static void rtw8922d_rfk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
+	memset(lck, 0, sizeof(*lck));
+}
+
+static void __rtw8922d_rfk_init_late(struct rtw89_dev *rtwdev,
+				     enum rtw89_phy_idx phy_idx,
+				     const struct rtw89_chan *chan)
+{
+	rtw8922d_rfk_mlo_ctrl(rtwdev);
+
+	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
+	if (!test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+		rtw89_phy_rfk_rxdck_and_wait(rtwdev, phy_idx, chan, false, 128);
+	if (phy_idx == RTW89_PHY_0)
+		rtw89_phy_rfk_dack_and_wait(rtwdev, phy_idx, chan, 58);
+}
+
+static void rtw8922d_rfk_init_late(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+
+	__rtw8922d_rfk_init_late(rtwdev, RTW89_PHY_0, chan);
+	if (rtwdev->dbcc_en)
+		__rtw8922d_rfk_init_late(rtwdev, RTW89_PHY_1, chan);
+}
+
+static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
+{
+	u32 rf_mode;
+	u8 path;
+	int ret;
+
+	for (path = 0; path < RF_PATH_NUM_8922D; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, rf_mode, rf_mode != 2,
+					       2, 5000, false, rtwdev, path, 0x00,
+					       RR_MOD_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK] Wait S%d to Rx mode!! (ret = %d)\n",
+			    path, ret);
+	}
+}
+
+static void __rtw8922d_tssi_enable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 path;
+
+	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+		u32 addr_ofst = (phy_idx << 12) + (path << 8);
+
+		rtw89_phy_write32_mask(rtwdev, R_TSSI_DCK_MOV_AVG_LEN_P0_BE4 + addr_ofst,
+				       B_TSSI_DCK_MOV_AVG_LEN_P0_BE4, 0x4);
+		rtw89_phy_write32_clr(rtwdev, R_USED_TSSI_TRK_ON_P0_BE4 + addr_ofst,
+				      B_USED_TSSI_TRK_ON_P0_BE4);
+		rtw89_phy_write32_set(rtwdev, R_USED_TSSI_TRK_ON_P0_BE4 + addr_ofst,
+				      B_USED_TSSI_TRK_ON_P0_BE4);
+		rtw89_phy_write32_clr(rtwdev, R_TSSI_EN_P0_BE4 + addr_ofst,
+				      B_TSSI_EN_P0_BE4);
+		rtw89_phy_write32_mask(rtwdev, R_TSSI_EN_P0_BE4 + addr_ofst,
+				       B_TSSI_EN_P0_BE4, 0x3);
+	}
+}
+
+static void __rtw8922d_tssi_disable(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 path;
+
+	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+		u32 addr_ofst = (phy_idx << 12) + (path << 8);
+
+		rtw89_phy_write32_clr(rtwdev, R_TSSI_DCK_MOV_AVG_LEN_P0_BE4 + addr_ofst,
+				      B_TSSI_DCK_MOV_AVG_LEN_P0_BE4);
+		rtw89_phy_write32_clr(rtwdev, R_USED_TSSI_TRK_ON_P0_BE4 + addr_ofst,
+				      B_USED_TSSI_TRK_ON_P0_BE4);
+		rtw89_phy_write32_clr(rtwdev, R_TSSI_EN_P0_BE4 + addr_ofst,
+				      B_TSSI_EN_P0_BE4);
+	}
+}
+
+static void rtw8922d_rfk_tssi(struct rtw89_dev *rtwdev,
+			      enum rtw89_phy_idx phy_idx,
+			      const struct rtw89_chan *chan,
+			      enum rtw89_tssi_mode tssi_mode,
+			      unsigned int ms)
+{
+	int ret;
+
+	ret = rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, chan, tssi_mode, ms);
+	if (ret) {
+		rtwdev->is_tssi_mode[RF_PATH_A] = false;
+		rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	} else {
+		rtwdev->is_tssi_mode[RF_PATH_A] = true;
+		rtwdev->is_tssi_mode[RF_PATH_B] = true;
+	}
+}
+
+static void rtw8922d_rfk_channel(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif_link *rtwvif_link)
+{
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, RF_AB);
+
+	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
+	rtw89_phy_rfk_txgapk_and_wait(rtwdev, phy_idx, chan, 54);
+	rtw89_phy_rfk_txiqk_and_wait(rtwdev, phy_idx, chan, 45);
+	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, chan, 84);
+	rtw8922d_rfk_tssi(rtwdev, phy_idx, chan, RTW89_TSSI_NORMAL, 20);
+	rtw89_phy_rfk_cim3k_and_wait(rtwdev, phy_idx, chan, 44);
+	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, chan, 68);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, true, 32);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_STOP);
+}
+
+static void rtw8922d_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx,
+				      const struct rtw89_chan *chan)
+{
+}
+
+static void rtw8922d_rfk_scan(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif_link *rtwvif_link,
+			      bool start)
+{
+	if (start)
+		__rtw8922d_tssi_disable(rtwdev, rtwvif_link->phy_idx);
+	else
+		__rtw8922d_tssi_enable(rtwdev, rtwvif_link->phy_idx);
+}
+
+static void rtw8922d_rfk_track(struct rtw89_dev *rtwdev)
+{
+	rtw8922d_lck_track(rtwdev);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
index d1eda19a39a9..147cf91d2cb0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
@@ -261,3 +261,88 @@ void rtw8922d_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 {
 	rtw8922d_rfk_mlo_ctrl(rtwdev);
 }
+
+static u8 _get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_TM, RR_TM_TRI, 0x1);
+
+	fsleep(200);
+
+	return rtw89_read_rf(rtwdev, path, RR_TM, RR_TM_VAL_V1);
+}
+
+static void _lck_keep_thermal(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+	int path;
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		lck->thermal[path] = _get_thermal(rtwdev, path);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[LCK] path=%d thermal=0x%x", path, lck->thermal[path]);
+	}
+}
+
+static void _lck(struct rtw89_dev *rtwdev)
+{
+	enum _rf_syn_pow syn_pow = rtw8922d_get_syn_pow(rtwdev);
+	u8 path_mask = 0;
+	u32 tmp18, tmp5;
+	int path;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK, "[LCK] DO LCK\n");
+
+	if (syn_pow == RF_SYN_ALLON)
+		path_mask = BIT(RF_PATH_A) | BIT(RF_PATH_B);
+	else if (syn_pow == RF_SYN_ON_OFF)
+		path_mask = BIT(RF_PATH_A);
+	else if (syn_pow == RF_SYN_OFF_ON)
+		path_mask = BIT(RF_PATH_B);
+	else
+		return;
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		if (!(path_mask & BIT(path)))
+			continue;
+
+		tmp18 = rtw89_read_rf(rtwdev, path, RR_CFGCH, MASKDWORD);
+		tmp5 = rtw89_read_rf(rtwdev, path, RR_RSV1, MASKDWORD);
+
+		rtw89_write_rf(rtwdev, path, RR_MOD, MASKDWORD, 0x10000);
+		rtw89_write_rf(rtwdev, path, RR_RSV1, MASKDWORD, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_CFGCH, MASKDWORD, tmp18);
+		rtw89_write_rf(rtwdev, path, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+
+		fsleep(400);
+
+		rtw89_write_rf(rtwdev, path, RR_RSV1, MASKDWORD, tmp5);
+	}
+
+	_lck_keep_thermal(rtwdev);
+}
+
+#define RTW8922D_LCK_TH 16
+void rtw8922d_lck_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+	u8 cur_thermal;
+	int delta;
+	int path;
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		cur_thermal = _get_thermal(rtwdev, path);
+		delta = abs((int)cur_thermal - lck->thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[LCK] path=%d current thermal=0x%x delta=0x%x\n",
+			    path, cur_thermal, delta);
+
+		if (delta >= RTW8922D_LCK_TH) {
+			_lck(rtwdev);
+			return;
+		}
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
index 4c505ae24261..8a5f4b56b8ce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
@@ -14,5 +14,6 @@ void rtw8922d_set_channel_rf(struct rtw89_dev *rtwdev,
 void rtw8922d_rfk_mlo_ctrl(struct rtw89_dev *rtwdev);
 void rtw8922d_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8922d_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8922d_lck_track(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1


