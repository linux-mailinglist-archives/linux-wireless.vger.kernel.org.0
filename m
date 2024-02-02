Return-Path: <linux-wireless+bounces-2989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FB846663
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150D71F27E8F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF6F9E5;
	Fri,  2 Feb 2024 03:07:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD42F517
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843278; cv=none; b=MHNKv5PFvZjAhpZMXSfMIlinIXn2JPRJNRaaUGx7oecoec957E0eog7uNJUqWKemJso5fIMwpE8GjCv23zmWkjtFYBufIaRlj8Rj6HQqWeVVbXpJxgue6Lg/nBkL6emmK7XBT9fiGEuKuMczfWKAYkNOA0R3BWhK094Xc2Rs0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843278; c=relaxed/simple;
	bh=lVvGN+4V7bokmLSUHzup5TQllNLqCw78yOhXEiizsKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/P+eQv60yHqeKENj8E95POXjFk1xynMrAYHaxkECydQNb6ARGv9l/d+IDk46ggff0Or3aq/18pViGx8DTL6dFE1pWRKlI2DhMpeJL973T+drQdkGxsEiTqUlcoO6gm71wczEOQdkOWCuGkOc9T2ulJESjKYwYTyr7NHl+TVe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237n5F21863141, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237n5F21863141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/11] wifi: rtw89: rfk: add H2C command to trigger TSSI
Date: Fri, 2 Feb 2024 11:06:39 +0800
Message-ID: <20240202030642.108385-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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

TSSI is short for transmitter signal strength indication, which is a
close-loop hardware circuit to feedback actual transmitting power as a
reference to adjust power for next transmission.

When connecting and switching bands or channels, do TSSI calibration and
reset hardware status to output expected power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   6 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  48 ++
 drivers/net/wireless/realtek/rtw89/fw.h   |  32 ++
 drivers/net/wireless/realtek/rtw89/phy.c  | 607 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |   8 +
 5 files changed, 701 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e049f7b5168b..ccc9f96fc18b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -17,6 +17,7 @@ struct rtw89_pci_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
 struct rtw89_efuse_block_cfg;
+struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
 struct rtw89_phy_rfk_log_fmt;
 
@@ -4471,6 +4472,11 @@ struct rtw89_cfo_tracking_info {
 	u8 lock_cnt;
 };
 
+enum rtw89_tssi_mode {
+	RTW89_TSSI_NORMAL = 0,
+	RTW89_TSSI_SCAN = 1,
+};
+
 enum rtw89_tssi_alimk_band {
 	TSSI_ALIMK_2G = 0,
 	TSSI_ALIMK_5GL,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3f5e72209001..c3f0a79f3de4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4593,6 +4593,54 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			 enum rtw89_tssi_mode tssi_mode)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       RTW89_SUB_ENTITY_0);
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_h2c_rf_tssi *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF TSSI\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_tssi *)skb->data;
+
+	h2c->len = cpu_to_le16(len);
+	h2c->phy = phy_idx;
+	h2c->ch = chan->channel;
+	h2c->bw = chan->band_width;
+	h2c->band = chan->band_type;
+	h2c->hwtx_en = true;
+	h2c->cv = hal->cv;
+	h2c->tssi_mode = tssi_mode;
+
+	rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(rtwdev, phy_idx, chan, h2c);
+	rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(rtwdev, phy_idx, chan, h2c);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_TSSI_OFFLOAD, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_h2c_rf_iqk *h2c;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 666c3e7ec0d0..02a7c7b2c8be 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3935,6 +3935,7 @@ enum rtw89_mcc_h2c_func {
 #define H2C_CL_OUTSRC_RF_FW_RFK		0xb
 
 enum rtw89_rfk_offload_h2c_func {
+	H2C_FUNC_RFK_TSSI_OFFLOAD = 0x0,
 	H2C_FUNC_RFK_IQK_OFFLOAD = 0x1,
 	H2C_FUNC_RFK_DPK_OFFLOAD = 0x3,
 	H2C_FUNC_RFK_TXGAPK_OFFLOAD = 0x4,
@@ -3987,6 +3988,35 @@ struct rtw89_fw_h2c_rfk_pre_info {
 	} __packed mlo;
 } __packed;
 
+struct rtw89_h2c_rf_tssi {
+	__le16 len;
+	u8 phy;
+	u8 ch;
+	u8 bw;
+	u8 band;
+	u8 hwtx_en;
+	u8 cv;
+	s8 curr_tssi_cck_de[2];
+	s8 curr_tssi_cck_de_20m[2];
+	s8 curr_tssi_cck_de_40m[2];
+	s8 curr_tssi_efuse_cck_de[2];
+	s8 curr_tssi_ofdm_de[2];
+	s8 curr_tssi_ofdm_de_20m[2];
+	s8 curr_tssi_ofdm_de_40m[2];
+	s8 curr_tssi_ofdm_de_80m[2];
+	s8 curr_tssi_ofdm_de_160m[2];
+	s8 curr_tssi_ofdm_de_320m[2];
+	s8 curr_tssi_efuse_ofdm_de[2];
+	s8 curr_tssi_ofdm_de_diff_20m[2];
+	s8 curr_tssi_ofdm_de_diff_80m[2];
+	s8 curr_tssi_ofdm_de_diff_160m[2];
+	s8 curr_tssi_ofdm_de_diff_320m[2];
+	s8 curr_tssi_trim_de[2];
+	u8 pg_thermal[2];
+	u8 ftable[2][128];
+	u8 tssi_mode;
+} __packed;
+
 struct rtw89_h2c_rf_iqk {
 	__le32 phy_idx;
 	__le32 dbcc;
@@ -4218,6 +4248,8 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx);
+int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+			 enum rtw89_tssi_mode tssi_mode);
 int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3de61c0d7b03..77b3b233697b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2959,6 +2959,613 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	handler(rtwdev, skb, len);
 }
 
+static u32 phy_tssi_get_cck_group(u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 13:
+		return 4;
+	case 14:
+		return 5;
+	}
+
+	return 0;
+}
+
+#define PHY_TSSI_EXTRA_GROUP_BIT BIT(31)
+#define PHY_TSSI_EXTRA_GROUP(idx) (PHY_TSSI_EXTRA_GROUP_BIT | (idx))
+#define PHY_IS_TSSI_EXTRA_GROUP(group) ((group) & PHY_TSSI_EXTRA_GROUP_BIT)
+#define PHY_TSSI_EXTRA_GET_GROUP_IDX1(group) \
+	((group) & ~PHY_TSSI_EXTRA_GROUP_BIT)
+#define PHY_TSSI_EXTRA_GET_GROUP_IDX2(group) \
+	(PHY_TSSI_EXTRA_GET_GROUP_IDX1(group) + 1)
+
+static u32 phy_tssi_get_ofdm_group(u8 ch)
+{
+	switch (ch) {
+	case 1 ... 2:
+		return 0;
+	case 3 ... 5:
+		return 1;
+	case 6 ... 8:
+		return 2;
+	case 9 ... 11:
+		return 3;
+	case 12 ... 14:
+		return 4;
+	case 36 ... 40:
+		return 5;
+	case 41 ... 43:
+		return PHY_TSSI_EXTRA_GROUP(5);
+	case 44 ... 48:
+		return 6;
+	case 49 ... 51:
+		return PHY_TSSI_EXTRA_GROUP(6);
+	case 52 ... 56:
+		return 7;
+	case 57 ... 59:
+		return PHY_TSSI_EXTRA_GROUP(7);
+	case 60 ... 64:
+		return 8;
+	case 100 ... 104:
+		return 9;
+	case 105 ... 107:
+		return PHY_TSSI_EXTRA_GROUP(9);
+	case 108 ... 112:
+		return 10;
+	case 113 ... 115:
+		return PHY_TSSI_EXTRA_GROUP(10);
+	case 116 ... 120:
+		return 11;
+	case 121 ... 123:
+		return PHY_TSSI_EXTRA_GROUP(11);
+	case 124 ... 128:
+		return 12;
+	case 129 ... 131:
+		return PHY_TSSI_EXTRA_GROUP(12);
+	case 132 ... 136:
+		return 13;
+	case 137 ... 139:
+		return PHY_TSSI_EXTRA_GROUP(13);
+	case 140 ... 144:
+		return 14;
+	case 149 ... 153:
+		return 15;
+	case 154 ... 156:
+		return PHY_TSSI_EXTRA_GROUP(15);
+	case 157 ... 161:
+		return 16;
+	case 162 ... 164:
+		return PHY_TSSI_EXTRA_GROUP(16);
+	case 165 ... 169:
+		return 17;
+	case 170 ... 172:
+		return PHY_TSSI_EXTRA_GROUP(17);
+	case 173 ... 177:
+		return 18;
+	}
+
+	return 0;
+}
+
+static u32 phy_tssi_get_6g_ofdm_group(u8 ch)
+{
+	switch (ch) {
+	case 1 ... 5:
+		return 0;
+	case 6 ... 8:
+		return PHY_TSSI_EXTRA_GROUP(0);
+	case 9 ... 13:
+		return 1;
+	case 14 ... 16:
+		return PHY_TSSI_EXTRA_GROUP(1);
+	case 17 ... 21:
+		return 2;
+	case 22 ... 24:
+		return PHY_TSSI_EXTRA_GROUP(2);
+	case 25 ... 29:
+		return 3;
+	case 33 ... 37:
+		return 4;
+	case 38 ... 40:
+		return PHY_TSSI_EXTRA_GROUP(4);
+	case 41 ... 45:
+		return 5;
+	case 46 ... 48:
+		return PHY_TSSI_EXTRA_GROUP(5);
+	case 49 ... 53:
+		return 6;
+	case 54 ... 56:
+		return PHY_TSSI_EXTRA_GROUP(6);
+	case 57 ... 61:
+		return 7;
+	case 65 ... 69:
+		return 8;
+	case 70 ... 72:
+		return PHY_TSSI_EXTRA_GROUP(8);
+	case 73 ... 77:
+		return 9;
+	case 78 ... 80:
+		return PHY_TSSI_EXTRA_GROUP(9);
+	case 81 ... 85:
+		return 10;
+	case 86 ... 88:
+		return PHY_TSSI_EXTRA_GROUP(10);
+	case 89 ... 93:
+		return 11;
+	case 97 ... 101:
+		return 12;
+	case 102 ... 104:
+		return PHY_TSSI_EXTRA_GROUP(12);
+	case 105 ... 109:
+		return 13;
+	case 110 ... 112:
+		return PHY_TSSI_EXTRA_GROUP(13);
+	case 113 ... 117:
+		return 14;
+	case 118 ... 120:
+		return PHY_TSSI_EXTRA_GROUP(14);
+	case 121 ... 125:
+		return 15;
+	case 129 ... 133:
+		return 16;
+	case 134 ... 136:
+		return PHY_TSSI_EXTRA_GROUP(16);
+	case 137 ... 141:
+		return 17;
+	case 142 ... 144:
+		return PHY_TSSI_EXTRA_GROUP(17);
+	case 145 ... 149:
+		return 18;
+	case 150 ... 152:
+		return PHY_TSSI_EXTRA_GROUP(18);
+	case 153 ... 157:
+		return 19;
+	case 161 ... 165:
+		return 20;
+	case 166 ... 168:
+		return PHY_TSSI_EXTRA_GROUP(20);
+	case 169 ... 173:
+		return 21;
+	case 174 ... 176:
+		return PHY_TSSI_EXTRA_GROUP(21);
+	case 177 ... 181:
+		return 22;
+	case 182 ... 184:
+		return PHY_TSSI_EXTRA_GROUP(22);
+	case 185 ... 189:
+		return 23;
+	case 193 ... 197:
+		return 24;
+	case 198 ... 200:
+		return PHY_TSSI_EXTRA_GROUP(24);
+	case 201 ... 205:
+		return 25;
+	case 206 ... 208:
+		return PHY_TSSI_EXTRA_GROUP(25);
+	case 209 ... 213:
+		return 26;
+	case 214 ... 216:
+		return PHY_TSSI_EXTRA_GROUP(26);
+	case 217 ... 221:
+		return 27;
+	case 225 ... 229:
+		return 28;
+	case 230 ... 232:
+		return PHY_TSSI_EXTRA_GROUP(28);
+	case 233 ... 237:
+		return 29;
+	case 238 ... 240:
+		return PHY_TSSI_EXTRA_GROUP(29);
+	case 241 ... 245:
+		return 30;
+	case 246 ... 248:
+		return PHY_TSSI_EXTRA_GROUP(30);
+	case 249 ... 253:
+		return 31;
+	}
+
+	return 0;
+}
+
+static u32 phy_tssi_get_trim_group(u8 ch)
+{
+	switch (ch) {
+	case 1 ... 8:
+		return 0;
+	case 9 ... 14:
+		return 1;
+	case 36 ... 48:
+		return 2;
+	case 49 ... 51:
+		return PHY_TSSI_EXTRA_GROUP(2);
+	case 52 ... 64:
+		return 3;
+	case 100 ... 112:
+		return 4;
+	case 113 ... 115:
+		return PHY_TSSI_EXTRA_GROUP(4);
+	case 116 ... 128:
+		return 5;
+	case 132 ... 144:
+		return 6;
+	case 149 ... 177:
+		return 7;
+	}
+
+	return 0;
+}
+
+static u32 phy_tssi_get_6g_trim_group(u8 ch)
+{
+	switch (ch) {
+	case 1 ... 13:
+		return 0;
+	case 14 ... 16:
+		return PHY_TSSI_EXTRA_GROUP(0);
+	case 17 ... 29:
+		return 1;
+	case 33 ... 45:
+		return 2;
+	case 46 ... 48:
+		return PHY_TSSI_EXTRA_GROUP(2);
+	case 49 ... 61:
+		return 3;
+	case 65 ... 77:
+		return 4;
+	case 78 ... 80:
+		return PHY_TSSI_EXTRA_GROUP(4);
+	case 81 ... 93:
+		return 5;
+	case 97 ... 109:
+		return 6;
+	case 110 ... 112:
+		return PHY_TSSI_EXTRA_GROUP(6);
+	case 113 ... 125:
+		return 7;
+	case 129 ... 141:
+		return 8;
+	case 142 ... 144:
+		return PHY_TSSI_EXTRA_GROUP(8);
+	case 145 ... 157:
+		return 9;
+	case 161 ... 173:
+		return 10;
+	case 174 ... 176:
+		return PHY_TSSI_EXTRA_GROUP(10);
+	case 177 ... 189:
+		return 11;
+	case 193 ... 205:
+		return 12;
+	case 206 ... 208:
+		return PHY_TSSI_EXTRA_GROUP(12);
+	case 209 ... 221:
+		return 13;
+	case 225 ... 237:
+		return 14;
+	case 238 ... 240:
+		return PHY_TSSI_EXTRA_GROUP(14);
+	case 241 ... 253:
+		return 15;
+	}
+
+	return 0;
+}
+
+static s8 phy_tssi_get_ofdm_de(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	enum rtw89_band band = chan->band_type;
+	u8 ch = chan->channel;
+	u32 gidx_1st;
+	u32 gidx_2nd;
+	s8 de_1st;
+	s8 de_2nd;
+	u32 gidx;
+	s8 val;
+
+	if (band == RTW89_BAND_6G)
+		goto calc_6g;
+
+	gidx = phy_tssi_get_ofdm_group(ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n",
+		    path, gidx);
+
+	if (PHY_IS_TSSI_EXTRA_GROUP(gidx)) {
+		gidx_1st = PHY_TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+		gidx_2nd = PHY_TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+		de_1st = tssi_info->tssi_mcs[path][gidx_1st];
+		de_2nd = tssi_info->tssi_mcs[path][gidx_2nd];
+		val = (de_1st + de_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+			    path, val, de_1st, de_2nd);
+	} else {
+		val = tssi_info->tssi_mcs[path][gidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+	}
+
+	return val;
+
+calc_6g:
+	gidx = phy_tssi_get_6g_ofdm_group(ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs group_idx=0x%x\n",
+		    path, gidx);
+
+	if (PHY_IS_TSSI_EXTRA_GROUP(gidx)) {
+		gidx_1st = PHY_TSSI_EXTRA_GET_GROUP_IDX1(gidx);
+		gidx_2nd = PHY_TSSI_EXTRA_GET_GROUP_IDX2(gidx);
+		de_1st = tssi_info->tssi_6g_mcs[path][gidx_1st];
+		de_2nd = tssi_info->tssi_6g_mcs[path][gidx_2nd];
+		val = (de_1st + de_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d 1st=%d 2nd=%d\n",
+			    path, val, de_1st, de_2nd);
+	} else {
+		val = tssi_info->tssi_6g_mcs[path][gidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs de=%d\n", path, val);
+	}
+
+	return val;
+}
+
+static s8 phy_tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_rf_path path)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	enum rtw89_band band = chan->band_type;
+	u8 ch = chan->channel;
+	u32 tgidx_1st;
+	u32 tgidx_2nd;
+	s8 tde_1st;
+	s8 tde_2nd;
+	u32 tgidx;
+	s8 val;
+
+	if (band == RTW89_BAND_6G)
+		goto calc_6g;
+
+	tgidx = phy_tssi_get_trim_group(ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+		    path, tgidx);
+
+	if (PHY_IS_TSSI_EXTRA_GROUP(tgidx)) {
+		tgidx_1st = PHY_TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+		tgidx_2nd = PHY_TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+		tde_1st = tssi_info->tssi_trim[path][tgidx_1st];
+		tde_2nd = tssi_info->tssi_trim[path][tgidx_2nd];
+		val = (tde_1st + tde_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+			    path, val, tde_1st, tde_2nd);
+	} else {
+		val = tssi_info->tssi_trim[path][tgidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+			    path, val);
+	}
+
+	return val;
+
+calc_6g:
+	tgidx = phy_tssi_get_6g_trim_group(ch);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI][TRIM]: path=%d mcs trim_group_idx=0x%x\n",
+		    path, tgidx);
+
+	if (PHY_IS_TSSI_EXTRA_GROUP(tgidx)) {
+		tgidx_1st = PHY_TSSI_EXTRA_GET_GROUP_IDX1(tgidx);
+		tgidx_2nd = PHY_TSSI_EXTRA_GET_GROUP_IDX2(tgidx);
+		tde_1st = tssi_info->tssi_trim_6g[path][tgidx_1st];
+		tde_2nd = tssi_info->tssi_trim_6g[path][tgidx_2nd];
+		val = (tde_1st + tde_2nd) / 2;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d 1st=%d 2nd=%d\n",
+			    path, val, tde_1st, tde_2nd);
+	} else {
+		val = tssi_info->tssi_trim_6g[path][tgidx];
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d mcs trim_de=%d\n",
+			    path, val);
+	}
+
+	return val;
+}
+
+void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
+					       enum rtw89_phy_idx phy,
+					       const struct rtw89_chan *chan,
+					       struct rtw89_h2c_rf_tssi *h2c)
+{
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	u8 ch = chan->channel;
+	s8 trim_de;
+	s8 ofdm_de;
+	s8 cck_de;
+	u8 gidx;
+	s8 val;
+	int i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI][TRIM]: phy=%d ch=%d\n",
+		    phy, ch);
+
+	for (i = RF_PATH_A; i <= RF_PATH_B; i++) {
+		trim_de = phy_tssi_get_ofdm_trim_de(rtwdev, phy, chan, i);
+		h2c->curr_tssi_trim_de[i] = trim_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d trim_de=0x%x\n", i, trim_de);
+
+		gidx = phy_tssi_get_cck_group(ch);
+		cck_de = tssi_info->tssi_cck[i][gidx];
+		val = u32_get_bits(cck_de + trim_de, 0xff);
+
+		h2c->curr_tssi_cck_de[i] = 0x0;
+		h2c->curr_tssi_cck_de_20m[i] = val;
+		h2c->curr_tssi_cck_de_40m[i] = val;
+		h2c->curr_tssi_efuse_cck_de[i] = cck_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d cck_de=0x%x\n", i, cck_de);
+
+		ofdm_de = phy_tssi_get_ofdm_de(rtwdev, phy, chan, i);
+		val = u32_get_bits(ofdm_de + trim_de, 0xff);
+
+		h2c->curr_tssi_ofdm_de[i] = 0x0;
+		h2c->curr_tssi_ofdm_de_20m[i] = val;
+		h2c->curr_tssi_ofdm_de_40m[i] = val;
+		h2c->curr_tssi_ofdm_de_80m[i] = val;
+		h2c->curr_tssi_ofdm_de_160m[i] = val;
+		h2c->curr_tssi_ofdm_de_320m[i] = val;
+		h2c->curr_tssi_efuse_ofdm_de[i] = ofdm_de;
+
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM]: path=%d ofdm_de=0x%x\n", i, ofdm_de);
+	}
+}
+
+void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
+					      enum rtw89_phy_idx phy,
+					      const struct rtw89_chan *chan,
+					      struct rtw89_h2c_rf_tssi *h2c)
+{
+	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
+	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const s8 *thm_up[RF_PATH_B + 1] = {};
+	const s8 *thm_down[RF_PATH_B + 1] = {};
+	u8 subband = chan->subband_type;
+	s8 thm_ofst[128] = {0};
+	u8 thermal;
+	u8 path;
+	u8 i, j;
+
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0];
+		break;
+	case RTW89_CH_5G_BAND_1:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0];
+		break;
+	case RTW89_CH_5G_BAND_3:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1];
+		break;
+	case RTW89_CH_5G_BAND_4:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2];
+		break;
+	case RTW89_CH_6G_BAND_IDX0:
+	case RTW89_CH_6G_BAND_IDX1:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][0];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][0];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][0];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][0];
+		break;
+	case RTW89_CH_6G_BAND_IDX2:
+	case RTW89_CH_6G_BAND_IDX3:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][1];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][1];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][1];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][1];
+		break;
+	case RTW89_CH_6G_BAND_IDX4:
+	case RTW89_CH_6G_BAND_IDX5:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][2];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][2];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][2];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][2];
+		break;
+	case RTW89_CH_6G_BAND_IDX6:
+	case RTW89_CH_6G_BAND_IDX7:
+		thm_up[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][3];
+		thm_down[RF_PATH_A] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][3];
+		thm_up[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][3];
+		thm_down[RF_PATH_B] = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][3];
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+		    "[TSSI] tmeter tbl on subband: %u\n", subband);
+
+	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+		thermal = tssi_info->thermal[path];
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "path: %u, pg thermal: 0x%x\n", path, thermal);
+
+		if (thermal == 0xff) {
+			h2c->pg_thermal[path] = 0x38;
+			memset(h2c->ftable[path], 0, sizeof(h2c->ftable[path]));
+			continue;
+		}
+
+		h2c->pg_thermal[path] = thermal;
+
+		i = 0;
+		for (j = 0; j < 64; j++)
+			thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+				      thm_up[path][i++] :
+				      thm_up[path][DELTA_SWINGIDX_SIZE - 1];
+
+		i = 1;
+		for (j = 127; j >= 64; j--)
+			thm_ofst[j] = i < DELTA_SWINGIDX_SIZE ?
+				      -thm_down[path][i++] :
+				      -thm_down[path][DELTA_SWINGIDX_SIZE - 1];
+
+		for (i = 0; i < 128; i += 4) {
+			h2c->ftable[path][i + 0] = thm_ofst[i + 3];
+			h2c->ftable[path][i + 1] = thm_ofst[i + 2];
+			h2c->ftable[path][i + 2] = thm_ofst[i + 1];
+			h2c->ftable[path][i + 3] = thm_ofst[i + 0];
+
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "thm ofst [%x]: %02x %02x %02x %02x\n",
+				    i, thm_ofst[i], thm_ofst[i + 1],
+				    thm_ofst[i + 2], thm_ofst[i + 3]);
+		}
+	}
+}
+
 static u8 rtw89_phy_cfo_get_xcap_reg(struct rtw89_dev *rtwdev, bool sc_xo)
 {
 	const struct rtw89_xtal_info *xtal = rtwdev->chip->xtal_info;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index df915cb0833f..459e919ddd24 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -888,6 +888,14 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev);
 int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 			      unsigned int ms);
+void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
+					       enum rtw89_phy_idx phy,
+					       const struct rtw89_chan *chan,
+					       struct rtw89_h2c_rf_tssi *h2c);
+void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
+					      enum rtw89_phy_idx phy,
+					      const struct rtw89_chan *chan,
+					      struct rtw89_h2c_rf_tssi *h2c);
 void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_cfo_track_work(struct work_struct *work);
 void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
-- 
2.25.1


