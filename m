Return-Path: <linux-wireless+bounces-34165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOIjK3ggymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:04:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E6356321
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AD7302EEAB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD73724E4B4;
	Mon, 30 Mar 2026 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SyMRNcyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82439526F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853953; cv=none; b=qao7vlu4WOnfBlnkY5m6BcoPHyY3S4vQ3YFoFImu20Jtxzlh3L6KvddX2Nkou3n+Zd7Uo1IqOUBQydl2HJZN4W/3nHeBVGtBKa3//y1OpXZavfaphAHhx3f/eaNvQabCpqhoAp+dKvPZ/ZMvvWhCLTgJH7TP4EQMQxgeEXuRLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853953; c=relaxed/simple;
	bh=BZ5hfoaphjDtvcxpEeC0p9CAV8/Pz/jfvruEztHokA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKhjQ1e7xIBYzo6XhgIgdLd3ncLjT65chj88iUtOksHY+rk3FlEC7XNaRw28cQ/D5aMU1D2hqygCucPm85B94SrbhO7nFF2BFl7q42jjk4eALzm975+SC6FnY1LjyPQle492StLhNaf30/sCesdn00AAbX/fncgC11quftoX9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SyMRNcyL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6x9Oz9673828, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853949; bh=QmFgt84PyRXwjZQ9xDjGxuOlPH9GtrZyr3YBcNG0RAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SyMRNcyL3vW+33nY+DVNBHuej1kSxiiQgGtnHZH29XWH/0prlj/EYfuKmpwwV8xNq
	 2rAGCxqfdEbw91FyYL1qkupU2ck8ZvxQ3XN3jOokrxY5aFrvTn5B1hye6BGt1ZhM1C
	 yS+p7Y/W56Xgr5ClC8O9QfaXmwYmOUOGXIcsUS8+EPAxnqRt8whhg2rbgd7Ao3gmBs
	 iE4NYxayCGTMccm02Xm2TfdeXWG2/ZJ/9OrOjhztlmAm1644hlq+wxqoFCvMPlRllK
	 7UxhVfqMvmw6TlAPTZb6a5KOd3Zuqs94th9nKtJdFtl85fRIpOpzB0ArRAV7C6qRgE
	 eNEdRjneEOAjQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6x9Oz9673828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 4/9] wifi: rtw89: 8922d: add set TX power callback
Date: Mon, 30 Mar 2026 14:58:42 +0800
Message-ID: <20260330065847.48946-5-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-34165-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D5E6356321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set TX power depends on operating channel. The Tx power factors are data
rate, channel, bandwidth and etc. Also, consider SAR as a factor of TX
power limit.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  13 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 115 ++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1a5a5b30a28e..37de1c827814 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10235,6 +10235,8 @@
 #define B_TSSI_CONT_EN BIT(3)
 #define R_P0_TXPWRB_BE 0xE61C
 #define R_P1_TXPWRB_BE 0xE71C
+#define R_P0_TXPWRB_BE4 0x2251C
+#define R_P1_TXPWRB_BE4 0x2261C
 #define B_TXPWRB_MAX_BE GENMASK(20, 12)
 #define R_TSSI_MAP_OFST_P0 0xE620
 #define R_TSSI_MAP_OFST_P1 0xE720
@@ -10531,13 +10533,24 @@
 #define B_TXPWR_RSTB0_BE4 BIT(16)
 #define R_TSSI_EN_P0_BE4 0x22510
 #define B_TSSI_EN_P0_BE4 GENMASK(3, 0)
+#define R_TXAGC_REF_DBM_PATH0_TBL0_BE4 0x22528
+#define B_TXAGC_OFDM_REF_DBM_PATH0_TBL0_BE4 GENMASK(8, 0)
+#define B_TXAGC_CCK_REF_DBM_PATH0_TBL0_BE4 GENMASK(17, 9)
 #define R_USED_TSSI_TRK_ON_P0_BE4 0x22534
 #define B_USED_TSSI_TRK_ON_P0_BE4 BIT(22)
+#define R_TSSI_K_OFDM_PATH0_TBL0_BE4 0x225A0
+#define B_TSSI_K_OFDM_PATH0_TBL0_BE4 GENMASK(29, 20)
 #define R_TSSI_DCK_MOV_AVG_LEN_P0_BE4 0x225CC
 #define B_TSSI_DCK_MOV_AVG_LEN_P0_BE4 GENMASK(8, 6)
 #define R_TXPWR_RSTB1_BE4 0x2260C
 #define B_TXPWR_RSTB1_BE4 BIT(16)
 
+#define R_TXAGC_REF_DBM_PATH0_TBL1_BE4 0x23528
+#define B_TXAGC_OFDM_REF_DBM_PATH0_TBL1_BE4 GENMASK(8, 0)
+#define B_TXAGC_CCK_REF_DBM_PATH0_TBL1_BE4 GENMASK(17, 9)
+#define R_TSSI_K_OFDM_PATH0_TBL1_BE4 0x235A0
+#define B_TSSI_K_OFDM_PATH0_TBL1_BE4 GENMASK(29, 20)
+
 #define R_OFDM_OFST_P0_BE4 0x240C8
 #define B_OFDM_OFST_P0_BE4 GENMASK(31, 24)
 #define R_PATH0_RXIDX_INIT_BE4 0x24108
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 2e6f4504caeb..9c62a5f12962 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -11,6 +11,7 @@
 #include "reg.h"
 #include "rtw8922d.h"
 #include "rtw8922d_rfk.h"
+#include "sar.h"
 #include "util.h"
 
 #define RTW8922D_FW_FORMAT_MAX 0
@@ -2322,6 +2323,120 @@ static void rtw8922d_rfk_track(struct rtw89_dev *rtwdev)
 	rtw8922d_lck_track(rtwdev);
 }
 
+static const struct rtw89_reg_def rtw8922d_txpwr_ref[][3] = {
+	{{ .addr = R_TXAGC_REF_DBM_PATH0_TBL0_BE4,
+	   .mask = B_TXAGC_OFDM_REF_DBM_PATH0_TBL0_BE4 },
+	 { .addr = R_TXAGC_REF_DBM_PATH0_TBL0_BE4,
+	   .mask = B_TXAGC_CCK_REF_DBM_PATH0_TBL0_BE4 },
+	 { .addr = R_TSSI_K_OFDM_PATH0_TBL0_BE4,
+	   .mask = B_TSSI_K_OFDM_PATH0_TBL0_BE4 }
+	},
+	{{ .addr = R_TXAGC_REF_DBM_PATH0_TBL1_BE4,
+	   .mask = B_TXAGC_OFDM_REF_DBM_PATH0_TBL1_BE4 },
+	 { .addr = R_TXAGC_REF_DBM_PATH0_TBL1_BE4,
+	   .mask = B_TXAGC_CCK_REF_DBM_PATH0_TBL1_BE4 },
+	 { .addr = R_TSSI_K_OFDM_PATH0_TBL1_BE4,
+	   .mask = B_TSSI_K_OFDM_PATH0_TBL1_BE4 }
+	},
+};
+
+static void rtw8922d_set_txpwr_diff(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	s16 pwr_ofst = rtw89_phy_ant_gain_pwr_offset(rtwdev, chan);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	static const u32 path_ofst[] = {0x0, 0x100};
+	const struct rtw89_reg_def *txpwr_ref;
+	s16 tssi_k_ofst = abs(pwr_ofst);
+	s16 ofst_dec[RF_PATH_NUM_8922D];
+	s16 tssi_k[RF_PATH_NUM_8922D];
+	s16 pwr_ref_ofst;
+	s16 pwr_ref = 16;
+	u8 i;
+
+	pwr_ref <<= chip->txpwr_factor_rf;
+	pwr_ref_ofst = pwr_ref - rtw89_phy_txpwr_bb_to_rf(rtwdev, abs(pwr_ofst));
+
+	ofst_dec[RF_PATH_A] = pwr_ofst > 0 ? pwr_ref : pwr_ref_ofst;
+	ofst_dec[RF_PATH_B] = pwr_ofst > 0 ? pwr_ref_ofst : pwr_ref;
+	tssi_k[RF_PATH_A] = pwr_ofst > 0 ? 0 : tssi_k_ofst;
+	tssi_k[RF_PATH_B] = pwr_ofst > 0 ? tssi_k_ofst : 0;
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		txpwr_ref = rtw8922d_txpwr_ref[phy_idx];
+
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[0].addr + path_ofst[i],
+				       txpwr_ref[0].mask, ofst_dec[i]);
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[1].addr + path_ofst[i],
+				       txpwr_ref[1].mask, ofst_dec[i]);
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[2].addr + path_ofst[i],
+				       txpwr_ref[2].mask, tssi_k[i]);
+	}
+}
+
+static void rtw8922d_set_txpwr_ref(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
+				   enum rtw89_phy_idx phy_idx)
+{
+	s16 ref_ofdm = 0;
+	s16 ref_cck = 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
+
+	rtw8922d_set_txpwr_diff(rtwdev, chan, phy_idx);
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_BE_PWR_REF_CTRL,
+				     B_BE_PWR_REF_CTRL_OFDM, ref_ofdm);
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_BE_PWR_REF_CTRL,
+				     B_BE_PWR_REF_CTRL_CCK, ref_cck);
+}
+
+static void rtw8922d_set_txpwr_sar_diff(struct rtw89_dev *rtwdev,
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
+	rtw89_phy_write32_mask(rtwdev, R_P0_TXPWRB_BE4, B_TXPWRB_MAX_BE, sar_rf);
+
+	sar_parm.path = RF_PATH_B;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_rf = rtw89_phy_txpwr_mac_to_rf(rtwdev, sar_mac);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPWRB_BE4, B_TXPWRB_MAX_BE, sar_rf);
+}
+
+static void rtw8922d_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw8922d_set_txpwr_ref(rtwdev, chan, phy_idx);
+	rtw8922d_set_txpwr_sar_diff(rtwdev, chan, phy_idx);
+}
+
+static void rtw8922d_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan = rtw89_mgnt_chan_get(rtwdev, phy_idx);
+
+	rtw8922d_set_txpwr_ref(rtwdev, chan, phy_idx);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


