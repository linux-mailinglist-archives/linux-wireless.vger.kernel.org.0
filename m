Return-Path: <linux-wireless+bounces-19832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308FA5405F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9373A4ADB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD76EEA9;
	Thu,  6 Mar 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XjCvsKED"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB40BE46
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227137; cv=none; b=KXFwDdTbB9ZFkBNDTlh7mtASAuXQ6RzlSw61RN7UJvuNUyUVgpL7fq35SfcTsZb3LT0J1ilO5T5q+5F2QoZWhq/VTzRL0BhQSrHeS+RqahxMKClFE4r/nY3cokY12/erThiq3lnUrB8xjrnFCCZE5MY1Zyniz3tPPrAUixrTfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227137; c=relaxed/simple;
	bh=bgN43kR6Ygy5RQzo6nArZD5f0T9kevcCPIwAGwzaRz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq+dp7lOROzeAWWOTpUY9Rd4Z4cYY6HpazGzIMsMqJqLdHVuXn+4M7SQSwdOfNHHPMdEaZ2IYcvVvB11j5a2mJX5mgalDgO2m/x5vlnQmxoNe3Od/Se2pL2aXGfIsoO5uGB+Td7a0sZjY5CXQfgwiGwlaFegXU7bW1Nh7Jss2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XjCvsKED; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262CBy742495410, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227132; bh=bgN43kR6Ygy5RQzo6nArZD5f0T9kevcCPIwAGwzaRz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XjCvsKEDHsq165xtGtJudlwUZmfudyGbCQF8IByZZLy25lnOc2ITVKRGeNix9lSMh
	 OVw8X9HQLBAWnun4qQHbmgOF70MhWgbw3n3EbtZtaCb4IcRNVOG2LqELXhTFXUddU7
	 goy9qpfrkUdFzRo4Io623Rh4w9AeexiBjjMW4C5KbKgDfm8TTSeXsaMecESfcqcqJB
	 /UAijVWDCz4sevss48R3NX3pDKa8KEbCzNyLVRTywZEcQBM0lX+TFvRy9eOBUerkLq
	 9uVr0BQg+ywJ6ouStN6H9tNkkirS6d7jLJaSKXBE3ZYgljAbpFgD8i6tHur57EfQP5
	 3iFJv2RPDRtOg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262CBy742495410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:12:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:12:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:12:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 3/5] wifi: rtw89: enable dynamic antenna gain based on country
Date: Thu, 6 Mar 2025 10:11:42 +0800
Message-ID: <20250306021144.12854-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306021144.12854-1-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

The dynamic antenna gain (DAG) considers the country, meaning DAG can
be activated only when countries and regulatory domains allow it.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/regd.c | 14 ++++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 074c865e6d03..b8f46207141e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4666,6 +4666,7 @@ enum rtw89_ant_gain_domain_type {
 struct rtw89_ant_gain_info {
 	s8 offset[RTW89_ANT_GAIN_CHAIN_NUM][RTW89_ANT_GAIN_SUBBAND_NR];
 	u32 regd_enabled;
+	bool block_country;
 };
 
 struct rtw89_6ghz_span {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index abc2a7e989eb..bd736417f467 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2044,7 +2044,7 @@ static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 cente
 	if (!chip->support_ant_gain)
 		return 0;
 
-	if (!(ant_gain->regd_enabled & BIT(regd)))
+	if (ant_gain->block_country || !(ant_gain->regd_enabled & BIT(regd)))
 		return 0;
 
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, center_freq);
@@ -2057,10 +2057,14 @@ s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan)
 {
 	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
 	s8 offset_patha, offset_pathb;
 
-	if (!(ant_gain->regd_enabled & BIT(regd)))
+	if (!chip->support_ant_gain)
+		return 0;
+
+	if (ant_gain->block_country || !(ant_gain->regd_enabled & BIT(regd)))
 		return 0;
 
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
@@ -2079,7 +2083,8 @@ int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	char *p = buf, *end = buf + bufsz;
 	s8 offset_patha, offset_pathb;
 
-	if (!chip->support_ant_gain || !(ant_gain->regd_enabled & BIT(regd))) {
+	if (!(chip->support_ant_gain && (ant_gain->regd_enabled & BIT(regd))) ||
+	    ant_gain->block_country) {
 		p += scnprintf(p, end - p, "no DAG is applied\n");
 		goto out;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index d31403f9009e..655323a79608 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -733,6 +733,19 @@ static void rtw89_regd_apply_policy_tas(struct rtw89_dev *rtwdev)
 	tas->block_regd = !test_bit(RTW89_REGD_FUNC_TAS, regd->func_bitmap);
 }
 
+static void rtw89_regd_apply_policy_ant_gain(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_regd *regd = regulatory->regd;
+
+	if (!chip->support_ant_gain)
+		return;
+
+	ant_gain->block_country = !test_bit(RTW89_REGD_FUNC_DAG, regd->func_bitmap);
+}
+
 static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
@@ -751,6 +764,7 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 	rtw89_regd_apply_policy_unii4(rtwdev, wiphy);
 	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
 	rtw89_regd_apply_policy_tas(rtwdev);
+	rtw89_regd_apply_policy_ant_gain(rtwdev);
 }
 
 static
-- 
2.25.1


