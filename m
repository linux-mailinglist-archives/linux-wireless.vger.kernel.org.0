Return-Path: <linux-wireless+bounces-17727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA1A165A7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0797A34CA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D291494CC;
	Mon, 20 Jan 2025 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PZ4VEoJY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8A137C35
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343688; cv=none; b=kIHPNB/te9K4zNWWTYebhavisOxTpPQGi97p0vw1iEIBTSyvUjgUehw1sMP/+7szRV/l6+2lbvG+n53I4lSFx71fvzm3tnIgMEz8ZSI/Fw7nXtKl5iPkg2DPESVbCdquYPXJvYnjHnsmBr/bjUH8EZt10pzdwg8T6yLVWHjsoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343688; c=relaxed/simple;
	bh=8RMUXC43rrkh1FyZ6pRTUeAXD2ppX60fNtyLjrUxyhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e14O0R/4i/FGeHEm5iTXvOx5DpQH5BpXsd78dJv1akoxvhSuJBORAnQ8jFjCeE1AtkMBsTF0TsNm5cqr6064cVV4pZobYrrj4yp6F1Vo0OXHzeBb7fYg7swAX2rF3NCW70GuP+TeCwR2k81EOUltcOagzO0Yk8KCoFV6mdqu/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PZ4VEoJY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K3S3H202654484, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737343683; bh=8RMUXC43rrkh1FyZ6pRTUeAXD2ppX60fNtyLjrUxyhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PZ4VEoJYHR7am9RjFr37ePtT1sRPRdH9YcwoBozucTYpR3mFDVC7u/X2l6K5ajfwt
	 reD3Vy0AClVj6P2FJYejiP7pBmZcgC74liS2jlR44I0VSU+nfyM35gW6AZLGK4xNYS
	 LzfQR7g0xDAAr3ZZBeGqG2MYg046brz309YfHm1/4xoAHgkzrO6Vs5PHa9Vemz7Lb7
	 l2RpQFCho6YjAoM9Lqn6s8sQilMJL2BULMeNc4tX2IG54X7u6vJNwIaj+ych7oDKDJ
	 zfXGzrLhFlzvxOvZxh88uhDdkbGau25s1S8eX4Jcoh4a8ubjGICMOQahSnqKvhNCzW
	 K7ee6YB7kSTpA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K3S3H202654484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:28:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 11:28:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 11:28:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/3] wifi: rtw89: regd: refactor init/setup flow and prototype
Date: Mon, 20 Jan 2025 11:27:23 +0800
Message-ID: <20250120032723.19042-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250120032723.19042-1-pkshih@realtek.com>
References: <20250120032723.19042-1-pkshih@realtek.com>
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

The regulatory and wiphy setup should be done in rtw89_regd_setup(). And,
what rtw89_regd_init() should do is to initialize target regulatory domain
(regd), if and only if one is programmed in efuse. Since HW is registered
after rtw89_regd_setup() and before rtw89_regd_init(), do not fill fields
of regulatory in rtw89_regd_init(). So, move the regulatory->reg_6ghz_power
assignment into rtw89_regd_setup().

Besides, rtw89_regd_notifier is assigned in rtw89_regd_setup() instead of
rtw89_regd_init(). To reduce confusion, stop passing rtw89_regd_notifier to
rtw89_regd_init(). And, rename rtw89_regd_init() to rtw89_regd_init_hint().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h |  4 +---
 drivers/net/wireless/realtek/rtw89/regd.c | 13 +++++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 85f739f1173d..8b322581ba4f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5296,7 +5296,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 		goto err_free_supported_band;
 	}
 
-	ret = rtw89_regd_init(rtwdev, rtw89_regd_notifier);
+	ret = rtw89_regd_init_hint(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to init regd\n");
 		goto err_unregister_hw;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7417dcd68f3d..73f0fe6bb934 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7115,9 +7115,7 @@ void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
 int rtw89_regd_setup(struct rtw89_dev *rtwdev);
-int rtw89_regd_init(struct rtw89_dev *rtwdev,
-		    void (*reg_notifier)(struct wiphy *wiphy, struct regulatory_request *request));
-void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+int rtw89_regd_init_hint(struct rtw89_dev *rtwdev);
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats);
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond);
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 50a7f6ff4b5b..5b9d3b78c24e 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -7,6 +7,9 @@
 #include "ps.h"
 #include "util.h"
 
+static
+void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+
 #define COUNTRY_REGD(_alpha2, _rule_2ghz, _rule_5ghz, _rule_6ghz, _fmap) \
 	{							\
 		.alpha2 = _alpha2,				\
@@ -598,6 +601,8 @@ int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 		regulatory->ctrl.map = rtw89_regd_map;
 	}
 
+	regulatory->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+
 	if (!wiphy)
 		return -EINVAL;
 
@@ -608,17 +613,12 @@ int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-int rtw89_regd_init(struct rtw89_dev *rtwdev,
-		    void (*reg_notifier)(struct wiphy *wiphy,
-					 struct regulatory_request *request))
+int rtw89_regd_init_hint(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_regd *chip_regd;
 	struct wiphy *wiphy = rtwdev->hw->wiphy;
 	int ret;
 
-	regulatory->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
-
 	if (!wiphy)
 		return -EINVAL;
 
@@ -738,6 +738,7 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
 }
 
+static
 void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-- 
2.25.1


