Return-Path: <linux-wireless+bounces-31796-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLsHMODBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31796-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA113335D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907B230180AA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D718239E6F;
	Fri, 13 Feb 2026 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JVIbPA4/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D426D4E5
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963421; cv=none; b=fx1SJpktMaWBxpmEDUves/sQgx5QWi8r3FanPOgUEDFjp70Bo9t1kYGHGNgjLk2T4E8SeX249KKGPfFIpcQYIDfi/WRF/bHgtPwOa9Hc2iRjSU/Fb84lGBrh2krhUQ/wOhA7kLHUgnCCz+AU/YtKCWogKljSP4JlQihJ1CuKbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963421; c=relaxed/simple;
	bh=HDI6za7BtjRLqQB6HwHA4n+hnSwqp3QuVbYzTXtfCf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDwTephM2NwrpP6Kb0U9NRdQrVmUGCPBNqOkGpZ9qjQD6zWhlgDwSzNVqNneYx6EkPNByhv+VgzDzyF5O843NRlc4CVPWdFYxCD1DLr1K5Iicd+55HOGJxGddawoVHZVyctkRFTJy2c/zuuDgLgQxkxYr8b5+nDMk+m28N7a9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JVIbPA4/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6GusJ61418818, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963416; bh=RGi9cfztTI3+Q+B1QIBukLWEdesY9ZQ6hgG/NwIgL5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JVIbPA4/pWsF7WPY2ACOT8jBy02J5VFYuWvgHbzbec8zR1jP4XFtw3G2J1bL9EwZ9
	 0W5jysQjz3KSwS6G/P+Stou6DdOYzobqxM18I2neyvHYwdmAt+WBcwWQuOBLvP+LrI
	 mK2GmewBr4RHbfJ+uZqV9AiQRRYFUDpGKUreGkpDe1REkdkJAtdXC1bO1sDlxXn1Kt
	 XzIEgisZZbauoI6wzunMXFmznJW17YK98v6ZgV5JJzEeq2OZjMW8LgnnLKbZXPcYcR
	 Rm9FzlJWtmteCqv98xighF0N72yY2mJSYkRyuZEptucA9EW0P/7aw3bhVsMEk3OZ9x
	 +f+WVTlfy10ow==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6GusJ61418818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:16:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:16:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:16:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: fw: recognize firmware type B by AID
Date: Fri, 13 Feb 2026 14:15:42 +0800
Message-ID: <20260213061552.29997-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_FROM(0.00)[bounces-31796-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AAA113335D
X-Rspamd-Action: no action

Select a firmware suit including normal and WoWLAN firmware by chip AID
from multiple firmware, because coming RTL8922D has variant hardware with
different chip AID.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      |  4 ++++
 drivers/net/wireless/realtek/rtw89/fw.c        | 13 +++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  1 +
 8 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5cb8aacf7644..d1f58bf953a9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4155,6 +4155,7 @@ struct rtw89_reg_imr {
 struct rtw89_fw_def {
 	const char *fw_basename;
 	u8 fw_format_max;
+	u16 fw_b_aid;
 };
 
 struct rtw89_phy_table {
@@ -4729,6 +4730,8 @@ enum rtw89_fw_type {
 	RTW89_FW_NORMAL = 1,
 	RTW89_FW_WOWLAN = 3,
 	RTW89_FW_NORMAL_CE = 5,
+	RTW89_FW_NORMAL_B = 14,
+	RTW89_FW_WOWLAN_B = 15,
 	RTW89_FW_BBMCU0 = 64,
 	RTW89_FW_BBMCU1 = 65,
 	RTW89_FW_LOGFMT = 255,
@@ -7562,6 +7565,7 @@ static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 
 	switch (type) {
 	case RTW89_FW_WOWLAN:
+	case RTW89_FW_WOWLAN_B:
 		return &fw_info->wowlan;
 	case RTW89_FW_LOGFMT:
 		return &fw_info->log.suit;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 638af4ebf628..ff27f00ec6d2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1027,16 +1027,25 @@ static int rtw89_fw_validate_ver_required(struct rtw89_dev *rtwdev)
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_fw_def *fw_def = rtw89_chip_get_fw_def(rtwdev);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_fw_type normal_fw_type = RTW89_FW_NORMAL;
+	enum rtw89_fw_type wowlan_fw_type = RTW89_FW_WOWLAN;
 	int ret;
 
+	if (fw_def->fw_b_aid && fw_def->fw_b_aid == hal->aid) {
+		normal_fw_type = RTW89_FW_NORMAL_B;
+		wowlan_fw_type = RTW89_FW_WOWLAN_B;
+	}
+
 	if (chip->try_ce_fw) {
 		ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL_CE, true);
 		if (!ret)
 			goto normal_done;
 	}
 
-	ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL, false);
+	ret = __rtw89_fw_recognize(rtwdev, normal_fw_type, false);
 	if (ret)
 		return ret;
 
@@ -1046,7 +1055,7 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 		return ret;
 
 	/* It still works if wowlan firmware isn't existing. */
-	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN, false);
+	__rtw89_fw_recognize(rtwdev, wowlan_fw_type, false);
 
 	/* It still works if log format file isn't existing. */
 	__rtw89_fw_recognize(rtwdev, RTW89_FW_LOGFMT, true);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 171749f5002d..89c759a2b5f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2583,6 +2583,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8851B_FW_BASENAME,
 		.fw_format_max	= RTW8851B_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 36d66f4e2dd0..32644c40ae28 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2268,6 +2268,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8852A_FW_BASENAME,
 		.fw_format_max	= RTW8852A_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 602432c47ea3..c2e14a9dfc73 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -914,6 +914,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8852B_FW_BASENAME,
 		.fw_format_max	= RTW8852B_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 514861e48c25..0acdf64395f0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -760,6 +760,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8852BT_FW_BASENAME,
 		.fw_format_max	= RTW8852BT_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 70ca8c3950d9..9f0dd6a3956f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3109,6 +3109,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8852C_FW_BASENAME,
 		.fw_format_max	= RTW8852C_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index fd1b171b106c..1c9db283cff9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2919,6 +2919,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.fw_def			= {
 		.fw_basename	= RTW8922A_FW_BASENAME,
 		.fw_format_max	= RTW8922A_FW_FORMAT_MAX,
+		.fw_b_aid	= 0,
 	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 1,
-- 
2.25.1


