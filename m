Return-Path: <linux-wireless+bounces-36709-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCdmBqCtDWrW1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36709-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:48:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E506A58E2CE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00AF130427C4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2F3E1223;
	Wed, 20 May 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Vhi7MaaT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106F3DFC60
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280733; cv=none; b=okgpgXyKDpSvZKY/TtF0iJGcB6q2/TzmiuZ0jM/+pnq3HIls/QV4FaD8Igd+vjDKIvgbCpmjvsT216hR6tBonLJ57vQgf0Mq0EtPvB7+E2fHexlK5mzPxNnVRKdEACG8P20KijTzODEKOrglHvIFj+kGixY6YwuPjnUqTCXFrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280733; c=relaxed/simple;
	bh=V+KClfrkTx84NBLV9/ggoxjfOi+i6u9HJkYuVuvMGls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJYct0tAtfWgCKFHFCBfsw6SGFZwAY1tkKCsyUBrG/gtwSHftrOIDH5SnrBs7/ohJnDkW/nca4wnkWfN7T+VCPLzHn6ZfFi4FJCZzJWVrSChEBn92POywMKjalkXMSqYQxTn3Ct9AUR3SIA3l6OqXhuhNksAABHh0XqObPYEY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Vhi7MaaT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCcnCwB095583, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280729; bh=XeIarA+VLxrULb7NFKZIpX0nh20VWDcAciIv/SdLaWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Vhi7MaaTiK4+fZC6miOKRnkl94HX+J/HnZL9QppEcbr0LshQ0LmsHp7UH7yh73c0+
	 kuteQxN5GPUacytvjXv2EPTfmVHD6G5mcjrAJKnil8h+61TPj6qmHzVpPKRis/edKu
	 BJnonzVrxC66MFyt0aUDQNVN3lIKCLtQjrjD+MTKlNukil4KM7vaoMaoxV6jY2J74s
	 KuMHMsO5RcwbfW02quKEyHbmCuGMMLDOPbpo/h7cSUi6NZ4JgrKnZR5REJEHkbLpIC
	 QsjPZkIJYxbVkoTOJq/gnrqCi0XEwVqqoh2eYsQSfIUGr5FvmXymvuCQQvT8BDwuqP
	 5tcvcNLZgixfg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCcnCwB095583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:50 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:49 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:38:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 5/7] wifi: rtw89: Wi-Fi 7 configure TX power limit for large MRU
Date: Wed, 20 May 2026 20:38:21 +0800
Message-ID: <20260520123823.1792954-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-36709-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E506A58E2CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Support of Large MRU (Multiple Resource Unit) starts from RTL8922D_CID7090,
i.e. RTL8922A and RTL8922D-VS variant do not support it. There are the new
corresponding control registers. So, configure them.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |   3 +
 drivers/net/wireless/realtek/rtw89/phy.h    |  10 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 163 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |   9 ++
 4 files changed, 185 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4666e3041ef3..17f9a61686b7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -998,6 +998,9 @@ enum rtw89_ru_bandwidth {
 	RTW89_RU106 = 2,
 	RTW89_RU52_26 = 3,
 	RTW89_RU106_26 = 4,
+	RTW89_RU484_242 = 5,
+	RTW89_RU996_484 = 6,
+	RTW89_RU996_484_242 = 7,
 	RTW89_RU_NUM,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5af66656d0b8..532232892831 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -568,6 +568,16 @@ struct rtw89_txpwr_limit_ru_be {
 	s8 ru106_26[RTW89_RU_SEC_NUM_BE];
 };
 
+#define RTW89_RU484_242_SEC_NUM_BE 4
+#define RTW89_RU996_484_SEC_NUM_BE 2
+#define RTW89_RU996_484_242_SEC_NUM_BE 2
+
+struct rtw89_txpwr_limit_large_mru_be {
+	s8 ru484_242[RTW89_NSS_NUM][RTW89_RU484_242_SEC_NUM_BE];
+	s8 ru996_484[RTW89_NSS_NUM][RTW89_RU996_484_SEC_NUM_BE];
+	s8 ru996_484_242[RTW89_NSS_NUM][RTW89_RU996_484_242_SEC_NUM_BE];
+};
+
 struct rtw89_phy_rfk_log_fmt {
 	const struct rtw89_fw_element_hdr *elm[RTW89_PHY_C2H_RFK_LOG_FUNC_NUM];
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index d0a6dfdbfea7..99263355e2f1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -1699,11 +1699,168 @@ static void rtw89_phy_fill_limit_ru_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static
+void rtw89_phy_fill_limit_ru484_242_be(struct rtw89_dev *rtwdev,
+				       s8 (*lmt)[RTW89_RU484_242_SEC_NUM_BE],
+				       u8 ntx, u8 band, u8 ch, u8 bw)
+{
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_80:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch - 8);
+		(*lmt)[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch + 8);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch - 24);
+		(*lmt)[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch - 8);
+		(*lmt)[2] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch + 8);
+		(*lmt)[3] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU484_242,
+							  ntx, ch + 24);
+		break;
+	}
+}
+
+static
+void rtw89_phy_fill_limit_ru996_484_be(struct rtw89_dev *rtwdev,
+				       s8 (*lmt)[RTW89_RU996_484_SEC_NUM_BE],
+				       u8 ntx, u8 band, u8 ch, u8 bw)
+{
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_160:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484,
+							  ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484,
+							  ntx, ch - 16);
+		(*lmt)[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484,
+							  ntx, ch + 16);
+		break;
+	}
+}
+
+static
+void rtw89_phy_fill_limit_ru996_484_242_be(struct rtw89_dev *rtwdev,
+					   s8 (*lmt)[RTW89_RU996_484_242_SEC_NUM_BE],
+					   u8 ntx, u8 band, u8 ch, u8 bw)
+{
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_160:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484_242,
+							  ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		(*lmt)[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484_242,
+							  ntx, ch - 16);
+		(*lmt)[1] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
+							  RTW89_RU996_484_242,
+							  ntx, ch + 16);
+		break;
+	}
+}
+
+static
+void rtw89_phy_fill_limit_large_mru_be(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan,
+				       struct rtw89_txpwr_limit_large_mru_be *lmt,
+				       bool has_bf)
+{
+	u8 band = chan->band_type;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
+	int i;
+
+	memset(lmt, 0, sizeof(*lmt));
+
+	if (has_bf)
+		return;
+
+	for (i = 0; i <= RTW89_NSS_2; i++) {
+		rtw89_phy_fill_limit_ru484_242_be(rtwdev, &lmt->ru484_242[i],
+						  i, band, ch, bw);
+		rtw89_phy_fill_limit_ru996_484_be(rtwdev, &lmt->ru996_484[i],
+						  i, band, ch, bw);
+		rtw89_phy_fill_limit_ru996_484_242_be(rtwdev, &lmt->ru996_484_242[i],
+						      i, band, ch, bw);
+	}
+}
+
+static
+void rtw89_phy_conf_limit_large_mru_be(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan,
+				       enum rtw89_phy_idx phy_idx,
+				       bool has_bf)
+{
+	struct rtw89_txpwr_limit_large_mru_be lmt_lmru;
+	u32 addr, val;
+
+	rtw89_phy_fill_limit_large_mru_be(rtwdev, chan, &lmt_lmru, has_bf);
+
+	addr = has_bf ? R_BE_TXAGC_MAX_1TX_BF_RU484_242_0 :
+			R_BE_TXAGC_MAX_1TX_RU484_242_0;
+
+	val = u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_1][0], GENMASK(7, 0)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_1][1], GENMASK(15, 8)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_1][2], GENMASK(23, 16)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_1][3], GENMASK(31, 24));
+
+	rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+
+	val = u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_2][0], GENMASK(7, 0)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_2][1], GENMASK(15, 8)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_2][2], GENMASK(23, 16)) |
+	      u32_encode_bits(lmt_lmru.ru484_242[RTW89_NSS_2][3], GENMASK(31, 24));
+
+	rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr + 4, val);
+
+	addr = has_bf ? R_BE_TXAGC_MAX_1TX_BF_RU996_484_0 :
+			R_BE_TXAGC_MAX_1TX_RU996_484_0;
+
+	val = u32_encode_bits(lmt_lmru.ru996_484[RTW89_NSS_1][0], GENMASK(7, 0)) |
+	      u32_encode_bits(lmt_lmru.ru996_484[RTW89_NSS_1][1], GENMASK(15, 8)) |
+	      u32_encode_bits(lmt_lmru.ru996_484[RTW89_NSS_2][0], GENMASK(23, 16)) |
+	      u32_encode_bits(lmt_lmru.ru996_484[RTW89_NSS_2][1], GENMASK(31, 24));
+
+	rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+
+	addr = has_bf ? R_BE_TXAGC_MAX_1TX_BF_RU996_484_242_0 :
+			R_BE_TXAGC_MAX_1TX_RU996_484_242_0;
+
+	val = u32_encode_bits(lmt_lmru.ru996_484_242[RTW89_NSS_1][0], GENMASK(7, 0)) |
+	      u32_encode_bits(lmt_lmru.ru996_484_242[RTW89_NSS_1][1], GENMASK(15, 8)) |
+	      u32_encode_bits(lmt_lmru.ru996_484_242[RTW89_NSS_2][0], GENMASK(23, 16)) |
+	      u32_encode_bits(lmt_lmru.ru996_484_242[RTW89_NSS_2][1], GENMASK(31, 24));
+
+	rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+}
+
 static void rtw89_phy_set_txpwr_limit_ru_be(struct rtw89_dev *rtwdev,
 					    const struct rtw89_chan *chan,
 					    enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_txpwr_limit_ru_be lmt_ru;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	const s8 *ptr;
 	u32 addr, val;
 	u8 i, j;
@@ -1730,6 +1887,12 @@ static void rtw89_phy_set_txpwr_limit_ru_be(struct rtw89_dev *rtwdev,
 			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
 		}
 	}
+
+	if (!(chip->chip_id == RTL8922D && hal->cid == RTL8922D_CID7090))
+		return;
+
+	rtw89_phy_conf_limit_large_mru_be(rtwdev, chan, phy_idx, false);
+	rtw89_phy_conf_limit_large_mru_be(rtwdev, chan, phy_idx, true);
 }
 
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c9bfb163c32e..c0279e9e9bed 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8358,6 +8358,11 @@
 #define R_BE_PWR_LISTEN_PATH 0x11988
 #define B_BE_PWR_LISTEN_PATH_EN GENMASK(31, 28)
 
+#define R_BE_TXAGC_MAX_1TX_RU484_242_0 0x11990
+#define R_BE_TXAGC_MAX_1TX_RU996_484_0 0x119A4
+#define R_BE_TXAGC_MAX_1TX_RU996_484_242_0 0x119AC
+#define R_BE_TXAGC_MAX_1TX_BF_RU484_242_0 0x119DC
+
 #define R_BE_PWR_REF_CTRL 0x11A20
 #define B_BE_PWR_REF_CTRL_OFDM GENMASK(9, 1)
 #define B_BE_PWR_REF_CTRL_CCK GENMASK(18, 10)
@@ -8395,6 +8400,8 @@
 	 B_BE_PWR_FORCE_MACID_EN_VAL | \
 	 B_BE_PWR_FORCE_MACID_EN_ON)
 
+#define R_BE_TXAGC_MAX_1TX_BF_RU996_484_0 0x11A4C
+
 #define R_BE_PWR_REG_CTRL 0x11A50
 #define B_BE_PWR_BT_EN BIT(23)
 
@@ -8408,6 +8415,8 @@
 #define R_BE_PWR_TH 0x11A78
 #define R_BE_PWR_RSSI_TARGET_LMT 0x11A84
 
+#define R_BE_TXAGC_MAX_1TX_BF_RU996_484_242_0 0x11ADC
+
 #define R_BE_PWR_OFST_SW 0x11AE8
 #define B_BE_PWR_OFST_SW_DB GENMASK(27, 24)
 
-- 
2.25.1


