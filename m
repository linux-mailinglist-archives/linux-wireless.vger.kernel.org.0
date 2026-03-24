Return-Path: <linux-wireless+bounces-33759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGR+Gxkuwml5ZwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B046302D19
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1352230391C7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074E242D62;
	Tue, 24 Mar 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TQwtW1p/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84552BD5B4
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333290; cv=none; b=u69S3w3fQmAB4ChyavPXNJ+buPhlOsXIyx050eMabCsha9ugTiDUFqSm42zRFu1fEY+eSMsROaA48kmjslmF5264Hhijoja6l7li0uC4ToExnSI8BeRjPeKhmEvUQ560PcMot08h+3ETJNdcxwqVMWvdmLBRLrlk6ArnWDZP2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333290; c=relaxed/simple;
	bh=A9/uIHge269wrzBN7qr9RrbOoBViyGQoaX7fNe1eVps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO9jl1XtRnFMYa8gYGaSxx9Y8eOi/q9Qo9qbPoAsgNpGib8x+z4x9LmdFjc5K3zVRQADdVMSF/8N2D9n4HCE6dUpdMQlzVo/qf1mDHm0i1Wqrzu58mq4YRbWDp4lGkI7n6o5hHfbjnKNJLqqGbrlwGiMnmXJfUnNelK+Lmmf7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TQwtW1p/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O6LQLd8557267, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774333286; bh=s2wlcK4Aa//DIZ3uMFLMqd57cf5sRAeqpYIjxzRlE0o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TQwtW1p/7V8acG4tyxkjSzCeutXg62JNrRKrjNjcba2+/JpJdD8v7MNfkIvfRMTdS
	 P3+M/W5/uCC5jDSU+z49WB66btEA3d4VNFz0lkBza/oUK6w6c2C9moK0aEL3FBk7JJ
	 8WaZDAQ0icXlRGyZHaK1QKtbHyOmGsYSze0nDctP5r0oMGdTqfcwDaMXH/qtwMk310
	 Q5yzTXOeylupzQ5LAvlUR+IpwPjAq3Mg2HL/h0C9OJFnX9lCni4njt/9cgN0IpIarL
	 sfYMkzWSlJmmWRK4H6bhZ4baQeSwaVf5Kmlgm8ZqQgJ4OTCiKkpZqw+TuWEsFvfuK6
	 kG4nt3S1NjfqA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O6LQLd8557267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:21:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 14:21:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 rtw-next 3/7] wifi: rtw89: 8922d: define efuse map and read necessary fields
Date: Tue, 24 Mar 2026 14:20:45 +0800
Message-ID: <20260324062049.52266-4-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-33759-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B046302D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Define specific efuse map for RTL8922D, including TSSI, RX gain, MAC
address, RFE type and etc. The additional fields comparing to existing
chips are BT setting (define BT switch GPIO, antenna number and etc) and
gain offset2 (define more fields like existing RX gain offset).

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.h     |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 162 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h |  70 ++++++++
 3 files changed, 235 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 94e4faf70e12..d0ae3e15253b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3562,6 +3562,8 @@ struct rtw89_efuse {
 	u8 rfe_type;
 	char country_code[2];
 	u8 adc_td;
+	u8 bt_setting_2;
+	u8 bt_setting_3;
 };
 
 struct rtw89_phy_rate_pattern {
@@ -5926,6 +5928,7 @@ struct rtw89_phy_efuse_gain {
 	bool offset_valid;
 	bool comp_valid;
 	s8 offset[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
+	s8 offset2[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
 	s8 offset_base[RTW89_PHY_NUM]; /* S(8, 4) */
 	s8 rssi_base[RTW89_PHY_NUM]; /* S(8, 4) */
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 194e2901232b..0ae34a4f8d79 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2026  Realtek Corporation
  */
 
+#include "debug.h"
 #include "efuse.h"
 #include "mac.h"
 #include "reg.h"
@@ -468,6 +469,167 @@ static int rtw8922d_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8922d_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					struct rtw8922d_efuse *map)
+{
+	const struct rtw8922d_tssi_offset_6g * const ofst_6g[] = {
+		&map->path_a_tssi_6g,
+		&map->path_b_tssi_6g,
+	};
+	const struct rtw8922d_tssi_offset * const ofst[] = {
+		&map->path_a_tssi,
+		&map->path_b_tssi,
+	};
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+	tssi->thermal[RF_PATH_B] = map->path_b_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		memcpy(tssi->tssi_cck[i], ofst[i]->cck_tssi, TSSI_CCK_CH_GROUP_NUM);
+
+		for (j = 0; j < TSSI_CCK_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d cck[%d]=0x%x\n",
+				    i, j, tssi->tssi_cck[i][j]);
+
+		memcpy(tssi->tssi_mcs[i], ofst[i]->bw40_tssi,
+		       TSSI_MCS_2G_CH_GROUP_NUM);
+		memcpy(tssi->tssi_mcs[i] + TSSI_MCS_2G_CH_GROUP_NUM,
+		       ofst[i]->bw40_1s_tssi_5g, TSSI_MCS_5G_CH_GROUP_NUM);
+		memcpy(tssi->tssi_6g_mcs[i], ofst_6g[i]->bw40_1s_tssi_6g,
+		       TSSI_MCS_6G_CH_GROUP_NUM);
+
+		for (j = 0; j < TSSI_MCS_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d mcs[%d]=0x%x\n",
+				    i, j, tssi->tssi_mcs[i][j]);
+
+		for (j = 0; j < TSSI_MCS_6G_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d mcs_6g[%d]=0x%x\n",
+				    i, j, tssi->tssi_6g_mcs[i][j]);
+	}
+}
+
+static void
+__rtw8922d_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+				     s8 offset[RTW89_GAIN_OFFSET_NR],
+				     const s8 *offset_default,
+				     const struct rtw8922d_rx_gain *rx_gain,
+				     const struct rtw8922d_rx_gain_6g *rx_gain_6g)
+{
+	int i;
+	u8 t;
+
+	offset[RTW89_GAIN_OFFSET_2G_CCK] = rx_gain->_2g_cck;
+	offset[RTW89_GAIN_OFFSET_2G_OFDM] = rx_gain->_2g_ofdm;
+	offset[RTW89_GAIN_OFFSET_5G_LOW] = rx_gain->_5g_low;
+	offset[RTW89_GAIN_OFFSET_5G_MID] = rx_gain->_5g_mid;
+	offset[RTW89_GAIN_OFFSET_5G_HIGH] = rx_gain->_5g_high;
+	offset[RTW89_GAIN_OFFSET_6G_L0] = rx_gain_6g->_6g_l0;
+	offset[RTW89_GAIN_OFFSET_6G_L1] = rx_gain_6g->_6g_l1;
+	offset[RTW89_GAIN_OFFSET_6G_M0] = rx_gain_6g->_6g_m0;
+	offset[RTW89_GAIN_OFFSET_6G_M1] = rx_gain_6g->_6g_m1;
+	offset[RTW89_GAIN_OFFSET_6G_H0] = rx_gain_6g->_6g_h0;
+	offset[RTW89_GAIN_OFFSET_6G_H1] = rx_gain_6g->_6g_h1;
+	offset[RTW89_GAIN_OFFSET_6G_UH0] = rx_gain_6g->_6g_uh0;
+	offset[RTW89_GAIN_OFFSET_6G_UH1] = rx_gain_6g->_6g_uh1;
+
+	for (i = 0; i < RTW89_GAIN_OFFSET_NR; i++) {
+		t = offset[i];
+		if (t == 0xff) {
+			if (offset_default) {
+				offset[i] = offset_default[i];
+				continue;
+			}
+			t = 0;
+		}
+
+		/* transform: sign-bit + U(7,2) to S(8,2) */
+		if (t & 0x80)
+			offset[i] = (t ^ 0x7f) + 1;
+		else
+			offset[i] = t;
+	}
+}
+
+static void rtw8922d_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+					       struct rtw8922d_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+
+	__rtw8922d_efuse_parsing_gain_offset(rtwdev, gain->offset[RF_PATH_A],
+					     NULL,
+					     &map->rx_gain_a, &map->rx_gain_6g_a);
+	__rtw8922d_efuse_parsing_gain_offset(rtwdev, gain->offset[RF_PATH_B],
+					     NULL,
+					     &map->rx_gain_b, &map->rx_gain_6g_b);
+
+	__rtw8922d_efuse_parsing_gain_offset(rtwdev, gain->offset2[RF_PATH_A],
+					     gain->offset[RF_PATH_A],
+					     &map->rx_gain_a_2, &map->rx_gain_6g_a_2);
+	__rtw8922d_efuse_parsing_gain_offset(rtwdev, gain->offset2[RF_PATH_B],
+					     gain->offset[RF_PATH_B],
+					     &map->rx_gain_b_2, &map->rx_gain_6g_b_2);
+
+	gain->offset_valid = true;
+}
+
+static int rtw8922d_read_efuse_pci_sdio(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		ether_addr_copy(efuse->addr, log_map + 0x4104);
+	else
+		ether_addr_copy(efuse->addr, log_map + 0x001A);
+
+	return 0;
+}
+
+static int rtw8922d_read_efuse_usb(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	ether_addr_copy(efuse->addr, log_map + 0x0078);
+
+	return 0;
+}
+
+static int rtw8922d_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw8922d_efuse *map = (struct rtw8922d_efuse *)log_map;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	efuse->bt_setting_2 = map->bt_setting_2;
+	efuse->bt_setting_3 = map->bt_setting_3;
+	rtw8922d_efuse_parsing_tssi(rtwdev, map);
+	rtw8922d_efuse_parsing_gain_offset(rtwdev, map);
+
+	return 0;
+}
+
+static int rtw8922d_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
+{
+	switch (block) {
+	case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
+		return rtw8922d_read_efuse_pci_sdio(rtwdev, log_map);
+	case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
+		return rtw8922d_read_efuse_usb(rtwdev, log_map);
+	case RTW89_EFUSE_BLOCK_RF:
+		return rtw8922d_read_efuse_rf(rtwdev, log_map);
+	default:
+		return 0;
+	}
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.h b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
index 7ef3f263274e..a3b98ad6636c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
@@ -7,4 +7,74 @@
 
 #include "core.h"
 
+#define RF_PATH_NUM_8922D 2
+#define BB_PATH_NUM_8922D 2
+
+struct rtw8922d_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+	u8 bw_diff_5g[10];
+} __packed;
+
+struct rtw8922d_tssi_offset_6g {
+	u8 bw40_1s_tssi_6g[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd[0xa];
+} __packed;
+
+struct rtw8922d_rx_gain {
+	u8 _2g_ofdm;
+	u8 _2g_cck;
+	u8 _5g_low;
+	u8 _5g_mid;
+	u8 _5g_high;
+} __packed;
+
+struct rtw8922d_rx_gain_6g {
+	u8 _6g_l0;
+	u8 _6g_l1;
+	u8 _6g_m0;
+	u8 _6g_m1;
+	u8 _6g_h0;
+	u8 _6g_h1;
+	u8 _6g_uh0;
+	u8 _6g_uh1;
+} __packed;
+
+struct rtw8922d_efuse {
+	u8 country_code[2];
+	u8 rsvd[0xe];
+	struct rtw8922d_tssi_offset path_a_tssi;
+	struct rtw8922d_tssi_offset path_b_tssi;
+	u8 rsvd1[0x54];
+	u8 channel_plan;
+	u8 xtal_k;
+	u8 rsvd2[0x7];
+	u8 board_info;
+	u8 rsvd3[0x8];
+	u8 rfe_type;
+	u8 rsvd4[2];
+	u8 bt_setting_2;
+	u8 bt_setting_3;
+	u8 rsvd4_2;
+	u8 path_a_therm;
+	u8 path_b_therm;
+	u8 rsvd5[0x2];
+	struct rtw8922d_rx_gain rx_gain_a;
+	struct rtw8922d_rx_gain rx_gain_b;
+	u8 rsvd6[0x18];
+	struct rtw8922d_rx_gain rx_gain_a_2;
+	struct rtw8922d_rx_gain rx_gain_b_2;
+	struct rtw8922d_tssi_offset_6g path_a_tssi_6g;
+	struct rtw8922d_tssi_offset_6g path_b_tssi_6g;
+	struct rtw8922d_tssi_offset_6g path_c_tssi_6g;
+	struct rtw8922d_tssi_offset_6g path_d_tssi_6g;
+	struct rtw8922d_rx_gain_6g rx_gain_6g_a;
+	struct rtw8922d_rx_gain_6g rx_gain_6g_b;
+	u8 rsvd7[0x5a];
+	struct rtw8922d_rx_gain_6g rx_gain_6g_a_2;
+	struct rtw8922d_rx_gain_6g rx_gain_6g_b_2;
+} __packed;
+
 #endif
-- 
2.25.1


