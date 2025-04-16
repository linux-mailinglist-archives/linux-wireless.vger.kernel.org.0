Return-Path: <linux-wireless+bounces-21595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA53A8B308
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A491904881
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DF22FE08;
	Wed, 16 Apr 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MhAW0UAG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090822F155
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791207; cv=none; b=MxKGtT1KsJcQvHYeOfQIuyloN0StpNdO8qPQbUwV+TwChmZD1sUC4H1tx0+IUBT+diCj6S6LJFDQnYvNkztsP4bIJ9pn35zZxv2h4nJD/1xPLQM40p88uT+Vy26YGpgo3FiwjnVWEtFJdns6IvTwtwpumdKbAl121o5oRw1O2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791207; c=relaxed/simple;
	bh=2ktkKv6m++HwjL8NJfOgVt2ZfVdgAJOpHkJ8e5hYw08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPe6niTDckMbLKXPVRpZvhJXjDFrnwABPoJ74kxeynZg4GPnFQqNdai/ck7Wy8H92vVHn6e7ISXYUNf4xcHst1r5Dy7KWU12SXB7TbwoRRJwhgDT8PBypTOOgA3EsbImI6dpU3uLt7qxtftSV7AlUiEZGKCe4QCskmemEQN1Is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MhAW0UAG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8DMVP02935264, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744791202; bh=2ktkKv6m++HwjL8NJfOgVt2ZfVdgAJOpHkJ8e5hYw08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MhAW0UAGZnyUDehZ6VRgDibfwAgrbIgaXzYKMQsQ+HVfFa7PK0qLqpo+DB/lIYrAV
	 7DcGjtPex4hI3wYodXVrI+WvMi1iV/h68FfG5hP4sRgrb4YsX54rQX0E6w5x1IvGCM
	 AOymZRCawFX/RdAbXbeQWQrJLxdzboPwM28L8Sjo0aZhbZD+vuW1xtxAdbd5OM+36Z
	 1Hll88PM4qsN9wT8Fe3KWluEVHqxWcKynkW4eivLVHQXxPAJD46s3jxTsUNVQt84EM
	 L9EA0BqWDiU2MWELIpPUK2IG/j3GroIdhPd9jR4msT8bWgRKN4FPvuIrFtD5qp0KLA
	 sXboZSa1Si5gw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8DMVP02935264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:13:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:13:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 16:13:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/4] wifi: rtw89: regd: indicate if regd_UK TX power settings follow regd_ETSI
Date: Wed, 16 Apr 2025 16:12:40 +0800
Message-ID: <20250416081241.36138-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250416081241.36138-1-pkshih@realtek.com>
References: <20250416081241.36138-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Before adopting regd_UK TX power settings, some certifications are needed
and might be platform-level. Without that, should adopt regd_ETSI TX power
settings. But for now, there is no way to inform driver of it yet. So, add
a flag first. But for now, comprehensively use regd_ETSI TX power settings
to restrict regd_UK.

Plan to define an ACPI DSM function to inform driver whether to use regd_UK
own TX power settings or not afterwards.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  | 11 +++++++++--
 drivers/net/wireless/realtek/rtw89/debug.c |  3 +++
 drivers/net/wireless/realtek/rtw89/regd.c  |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d49e06f81ba4..aea223940db3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5267,6 +5267,8 @@ struct rtw89_regulatory_info {
 	const struct rtw89_regd *regd;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
+	bool txpwr_uk_follow_etsi;
+
 	DECLARE_BITMAP(block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
@@ -6885,9 +6887,14 @@ static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 
 static inline u8 rtw89_regd_get(struct rtw89_dev *rtwdev, u8 band)
 {
-	const struct rtw89_regd *regd = rtwdev->regulatory.regd;
+	const struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
+	u8 txpwr_regd = regd->txpwr_regd[band];
+
+	if (regulatory->txpwr_uk_follow_etsi && txpwr_regd == RTW89_UK)
+		return RTW89_ETSI;
 
-	return regd->txpwr_regd[band];
+	return txpwr_regd;
 }
 
 static inline void rtw89_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index a7ef9cb9c6fe..10e011827379 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -857,11 +857,14 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 static int __print_regd(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 			const struct rtw89_chan *chan)
 {
+	const struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	char *p = buf, *end = buf + bufsz;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
 	p += scnprintf(p, end - p, "%s\n", rtw89_regd_get_string(regd));
+	p += scnprintf(p, end - p, "\t(txpwr UK follow ETSI: %s)\n",
+		       str_yes_no(regulatory->txpwr_uk_follow_etsi));
 
 	return p - buf;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 49e9540f2049..6dd37de59682 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -636,6 +636,7 @@ int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 	}
 
 	regulatory->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+	regulatory->txpwr_uk_follow_etsi = true;
 
 	if (!wiphy)
 		return -EINVAL;
-- 
2.25.1


