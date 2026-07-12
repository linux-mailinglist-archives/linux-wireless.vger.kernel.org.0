Return-Path: <linux-wireless+bounces-38904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zUlWKxUOU2qCWQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99372743B77
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Dw3qJO57;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38904-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38904-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91B7A3001FA7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE42BDC26;
	Sun, 12 Jul 2026 03:46:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A9846A
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827984; cv=none; b=ub2EYOuO/YCzxTm6xLdDO7nsJZwQY0+LPvp9Ia5wqe+71h6sIkfzk1bmPbrJw/UQrPmvGEOgYuvr4IRo0zlBuxkZ7eGhG1GK/WqrfZUXm69PRMBGauaeyPAbCi2no26SmN1Aru6+l7TsatmvDzwHdsrMaL/hennpeQt9hqFbgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827984; c=relaxed/simple;
	bh=OmNuCC3kx5urapB4Rkx6j9WFJKfA6Sa0/IVQFvrjgIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjLIYMUzNlGzgnR+E+vwFopDbL8XNBNRDg/HY3IWU/Gf653Lfdyelq/WH4P/kh9ZbUPtFUhGsNGv4Ia92qiavnfHnP39rPht4USEtGnJ91JV/0fSM+ETm90arw6EJ9fRyxpooPyiyppLcNb7Y26Atm70nAt18k40/KMWeq148qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dw3qJO57; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3kK5F1535622, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783827980; bh=Bl+9TCjIutyMkT136bP3/VSyzT0XPnH5izuJCh/GrfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Dw3qJO57GGDZArWymZ8SzDB7yLggeF+sjj87NgCq5hvCUoSodqPIm5UVeLZSQTkO+
	 HUM6RcE8KY70QtJcVN2HgwM0JFibA51ZzVrECbf6NXPqLcFS+nWbTWqX5bTlYuprdV
	 Ji5i83wSpntqwRjcyLo2Yr9fO2NYKiC+uodjuZM4Jl9VkMxeSmjwC/cR+Cm36zcqrd
	 R5+oGcHQa2GqErlbfO5EWNKH8aELN7bL2/faHscCDoEyhpicCMpDfDdleamA5d4bX3
	 N9ZG+YOzmjnxykmbbgrQa9y8u5MfqED6IetnUQJHv+0+KMFxyDN2I1D5jay2qFo7E2
	 J/Sup5yw1R5dg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3kK5F1535622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/8] wifi: rtw89: 8922d: add TX time limit for 2GHz band
Date: Sun, 12 Jul 2026 11:45:01 +0800
Message-ID: <20260712034506.53209-4-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38904-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99372743B77

Fix 2.4GHz specific L-SIG length TX issue, causing interoperability problem
with certain APs. Limit the A-MPDU duration to be workaround.

For 8922DE, the MAC limit is 164 ticks, and BB limit is 4608 us. The
conversion is 32.768us / tick. Since smaller limit should be adopted,
BB limit is filled into newly added field.

The units of register and CCTL table are tick and us/512 respectively.
Convert to target unit when filling values.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 20 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  9 +++++++++
 9 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0f6d4ad66fe2..b7536288c084 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5012,6 +5012,7 @@ struct rtw89_chip_info {
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const struct rtw89_xtal_info *xtal_info;
 	unsigned long default_quirks; /* bitmap of rtw89_quirks */
+	u16 txtime_limit_2ghz;
 };
 
 struct rtw89_chip_variant {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b58d9439ee6d..a63f34440554 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7047,11 +7047,23 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 {
 #define MAC_AX_DFLT_TX_TIME 5280
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 max_tx_time = tx_time == 0 ? MAC_AX_DFLT_TX_TIME : tx_time;
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
 	u32 reg;
 	int ret = 0;
 
+	if (chip->txtime_limit_2ghz) {
+		rtw89_entity_get_conf(rtwdev, &conf);
+		chan = conf.chans[mac_idx];
+
+		if (chan->band_type == RTW89_BAND_2G)
+			max_tx_time = min_t(u32, max_tx_time,
+					    chip->txtime_limit_2ghz);
+	}
+
 	if (rtwsta_link->cctl_tx_time) {
 		rtwsta_link->ampdu_max_time = (max_tx_time - 512) >> 9;
 		ret = rtw89_chip_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
@@ -7062,9 +7074,13 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 			return ret;
 		}
 
+		if (chip->chip_gen == RTW89_CHIP_AX)
+			max_tx_time >>= 5;
+		else
+			max_tx_time = max_tx_time * 1000 >> 15;
+
 		reg = rtw89_mac_reg_by_idx(rtwdev, mac->agg_limit.addr, mac_idx);
-		rtw89_write32_mask(rtwdev, reg, mac->agg_limit.mask,
-				   max_tx_time >> 5);
+		rtw89_write32_mask(rtwdev, reg, mac->agg_limit.mask, max_tx_time);
 	}
 
 	return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 50480f72c96d..8dd909fc4754 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2779,6 +2779,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 #endif
 	.xtal_info		= &rtw8851b_xtal_info,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8851b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0c7794742650..66e8035703a6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2517,6 +2517,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 #endif
 	.xtal_info		= &rtw8852a_xtal_info,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 5904127cc836..19f35b87d42e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1115,6 +1115,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 #endif
 	.xtal_info		= NULL,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index e68f73827fa5..3da95beddc1f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -951,6 +951,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 #endif
 	.xtal_info		= NULL,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8852bt_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 968666280c89..54425d707bc6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3320,6 +3320,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 #endif
 	.xtal_info		= NULL,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index fe87b4929ddc..900aa20cf6ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3302,6 +3302,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 #endif
 	.xtal_info		= NULL,
 	.default_quirks		= 0,
+	.txtime_limit_2ghz	= 0,
 };
 EXPORT_SYMBOL(rtw8922a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 768434db14c6..27e148b4213a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -1173,8 +1173,10 @@ static void rtw8922d_set_channel_mac(struct rtw89_dev *rtwdev,
 	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_BE_TX_SUB_BAND_VALUE, mac_idx);
 	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_BE_TXRATE_CHK, mac_idx);
 	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_RFMOD, mac_idx);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 txsb20 = 0, txsb40 = 0, txsb80 = 0;
 	u8 rf_mod_val, chk_rate_mask, sifs;
+	u16 tx_time = AMPDU_MAX_TIME_V1;
 	u32 txsb;
 	u32 reg;
 
@@ -1255,6 +1257,12 @@ static void rtw8922d_set_channel_mac(struct rtw89_dev *rtwdev,
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MUEDCA_EN, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_TB_T1_DOT05US_MASK, sifs);
+
+	if (chan->band_type == RTW89_BAND_2G && chip->txtime_limit_2ghz)
+		tx_time = min_t(u32, tx_time, chip->txtime_limit_2ghz * 1000 >> 15);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AMPDU_AGG_LIMIT, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_AMPDU_MAX_TIME_MASK, tx_time);
 }
 
 static const u32 rtw8922d_sco_barker_threshold[14] = {
@@ -3591,6 +3599,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 #endif
 	.xtal_info		= NULL,
 	.default_quirks		= BIT(RTW89_QUIRK_THERMAL_PROT_120C),
+	.txtime_limit_2ghz	= 4608,
 };
 EXPORT_SYMBOL(rtw8922d_chip_info);
 
-- 
2.25.1


