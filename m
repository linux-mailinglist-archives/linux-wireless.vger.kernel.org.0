Return-Path: <linux-wireless+bounces-38907-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P/tZESIOU2qDWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38907-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F4743B7C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="l2Aog/Al";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38907-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38907-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 910D73015890
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EF274670;
	Sun, 12 Jul 2026 03:46:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48874846A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827999; cv=none; b=ZbFcwHBYgVEJBXM9OD5xpKefvFtwc0mnlCUkaAcUig2RqvtlOZIEyqh/YYOBjLl6AB8o79TMyiQjtdvvf5TrVeXDsK9tAwLx2YkuIlD2pzJyg+3W7xgKiHv7FmTazncBPP8KI3TVVwtvn+97XWE2u8VQoNrgQMU0medhxa2QutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827999; c=relaxed/simple;
	bh=k1mHSkfQR/t9vCWA+h2Hfa717VE5tZJUWoHxAor+W7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEdrwPJtXzvhLU6/gTObhxw9sUmxR5bz2qu6OkYm5oFRq2vpDpdtqoZllVIbtmwJO+v4ZjIWbWJu1rAwP7+S9TwRunwFJU2W/LDy+8XjtKijp1NnBvPBCnPCmzI+D/3zzDPYXS1UghXEaL9TNfen7UVJ25Yet2j6SBjoMOhwzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=l2Aog/Al; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kacT7535684, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783827996; bh=4sSonfz5SgKhy4zxkkuBfTrWz5YBaFbvT0hFxOvJhMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=l2Aog/Aldvws7MqO0AIjhd7CD4ppLaRIvx5D3q/JIW/sISOlY+BKo5u5A6hc0xb94
	 X8D8riMeKVTZNi0ib5nJmWNFnotJQvVvC1u1XtilzJtyl1F3XAT2FYSnqifHWOUIyg
	 Hpfz0K6uV61P/1GCML3GEjj5uho+9OWL6pLbugHCmt0l+9eIXyqnkpyJg3QOFc1ia4
	 zGQw6TxEh/ZQWZvrj64zwp/bGXCbMV+mtJfTahT7PTfDB8TlL2tGf/3FwhQM49nGpu
	 ShRmt/7T13XgDdW20QX2FqjneklxbEnf8pum0RA3FV34Lu/TaHC2DTBhgWu6BotBym
	 kBLzgjE4kt0yg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kacT7535684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/8] wifi: rtw89: extend tx shape format for regulatory 6 GHz power type
Date: Sun, 12 Jul 2026 11:45:04 +0800
Message-ID: <20260712034506.53209-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712034506.53209-1-pkshih@realtek.com>
References: <20260712034506.53209-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38907-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A20F4743B7C

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Even under the same regulation, TX shape may need different settings for
different 6 GHz power types. So, add one more dimension for that. Because
TX shape parameters are not quite large, the 2/5/6 GHz sections are not
divided into different structures. So, the 2/5 GHz sections will also get
the new dimension. To 2/5 GHz sections, fill the TX shape settings with
RTW89_REG_6GHZ_POWER_DFLT (0) field.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 17 ++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.c   | 16 ++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h   |  2 ++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 94ba7e368880..4ba6452a7123 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4516,8 +4516,9 @@ struct rtw89_txpwr_rule_6ghz {
 };
 
 struct rtw89_tx_shape {
-	const u8 (*lmt)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
-	const u8 (*lmt_ru)[RTW89_BAND_NUM][RTW89_REGD_NUM];
+	const u8 (*lmt)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM]
+		       [NUM_OF_RTW89_REG_6GHZ_POWER];
+	const u8 (*lmt_ru)[RTW89_BAND_NUM][RTW89_REGD_NUM][NUM_OF_RTW89_REG_6GHZ_POWER];
 
 	const u8 (*lmt_v0)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
 	const u8 (*lmt_ru_v0)[RTW89_BAND_NUM][RTW89_REGD_NUM];
@@ -4614,12 +4615,13 @@ struct rtw89_txpwr_lmt_ru_6ghz_data {
 
 struct rtw89_tx_shape_lmt_data {
 	struct rtw89_txpwr_conf conf;
-	u8 v[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
+	u8 v[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM]
+	    [NUM_OF_RTW89_REG_6GHZ_POWER];
 };
 
 struct rtw89_tx_shape_lmt_ru_data {
 	struct rtw89_txpwr_conf conf;
-	u8 v[RTW89_BAND_NUM][RTW89_REGD_NUM];
+	u8 v[RTW89_BAND_NUM][RTW89_REGD_NUM][NUM_OF_RTW89_REG_6GHZ_POWER];
 };
 
 struct rtw89_rfe_data {
@@ -8048,8 +8050,10 @@ static inline u8 rtw89_regd_get(struct rtw89_dev *rtwdev, u8 band)
 static inline u8 rtw89_get_tx_shape_idx(struct rtw89_dev *rtwdev, u8 band,
 					enum rtw89_rate_section rs)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	const struct rtw89_tx_shape *tx_shape = &rfe_parms->tx_shape;
+	u8 reg6_pwr = regulatory->reg_6ghz_power;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
 	if (unlikely(rs >= RTW89_RS_TX_SHAPE_NUM))
@@ -8058,7 +8062,10 @@ static inline u8 rtw89_get_tx_shape_idx(struct rtw89_dev *rtwdev, u8 band,
 	if (!tx_shape->lmt)
 		goto v0;
 
-	return (*tx_shape->lmt)[band][rs][regd];
+	if (band != RTW89_BAND_6G)
+		reg6_pwr = RTW89_REG_6GHZ_POWER_DFLT;
+
+	return (*tx_shape->lmt)[band][rs][regd][reg6_pwr];
 
 v0:
 	return (*tx_shape->lmt_v0)[band][rs][regd];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 01770a6a1f6f..95acf7caf08e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -11626,6 +11626,12 @@ fw_tx_shape_lmt_entry_valid(const struct rtw89_fw_tx_shape_lmt_entry *e,
 	if (e->regd >= RTW89_REGD_NUM)
 		return false;
 
+	/* ensure compatibility work with 2/5 GHz */
+	static_assert(RTW89_REG_6GHZ_POWER_DFLT == 0);
+
+	if (e->reg6_pwr >= NUM_OF_RTW89_REG_6GHZ_POWER)
+		return false;
+
 	return true;
 }
 
@@ -11640,7 +11646,7 @@ void rtw89_fw_load_tx_shape_lmt(struct rtw89_tx_shape_lmt_data *data)
 		if (!fw_tx_shape_lmt_entry_valid(&entry, cursor, conf))
 			continue;
 
-		data->v[entry.band][entry.tx_shape_rs][entry.regd] = entry.v;
+		data->v[entry.band][entry.tx_shape_rs][entry.regd][entry.reg6_pwr] = entry.v;
 	}
 }
 
@@ -11657,6 +11663,12 @@ fw_tx_shape_lmt_ru_entry_valid(const struct rtw89_fw_tx_shape_lmt_ru_entry *e,
 	if (e->regd >= RTW89_REGD_NUM)
 		return false;
 
+	/* ensure compatibility work with 2/5 GHz */
+	static_assert(RTW89_REG_6GHZ_POWER_DFLT == 0);
+
+	if (e->reg6_pwr >= NUM_OF_RTW89_REG_6GHZ_POWER)
+		return false;
+
 	return true;
 }
 
@@ -11671,7 +11683,7 @@ void rtw89_fw_load_tx_shape_lmt_ru(struct rtw89_tx_shape_lmt_ru_data *data)
 		if (!fw_tx_shape_lmt_ru_entry_valid(&entry, cursor, conf))
 			continue;
 
-		data->v[entry.band][entry.regd] = entry.v;
+		data->v[entry.band][entry.regd][entry.reg6_pwr] = entry.v;
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index af126d15a1fb..5efa75f8c392 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5834,6 +5834,7 @@ struct rtw89_fw_tx_shape_lmt_entry {
 	u8 tx_shape_rs;
 	u8 regd;
 	u8 v;
+	u8 reg6_pwr;
 } __packed;
 
 /* must consider compatibility; don't insert new in the mid */
@@ -5841,6 +5842,7 @@ struct rtw89_fw_tx_shape_lmt_ru_entry {
 	u8 band;
 	u8 regd;
 	u8 v;
+	u8 reg6_pwr;
 } __packed;
 
 const struct rtw89_rfe_parms *
-- 
2.25.1


