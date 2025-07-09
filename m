Return-Path: <linux-wireless+bounces-25074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CAAFE085
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B74E5843B7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEF2701C3;
	Wed,  9 Jul 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="L/lmEOdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38882270557
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043841; cv=none; b=IZwbPlkX/SJoY1Ev8CTm+PCpalgNIZpnlF09kDIJZAHy9uraKG+J1JEzZrNpBg3WkU3lXqPq4SiSJYNNg+P6dCsxdmFtFQ2ox4LP3mAHoxt2AOqzMXv929Qi81zwyNATFZ+u/3RNq9BUmdgOP9nWlIxWSBfRNHnzVn4y6r+l8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043841; c=relaxed/simple;
	bh=AF3Vy0VI9dkXeYy+DDynSEsKnLeFvwS5sl7rA1MpeDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn7YQPumRUev+uE0I/q3i7OJDzmFEIkl64IgocX2kQDd6TqK4j99x60jl4M+CsUqqud4RipBNTDMWjgPNumoDz4ijO66uHeykEoCxJeymPKghXd34CAVdoX0ykTvEQEa3B1F2cnqdVoJMY/F45WXs/9tgIPpqAzu4Fg/jlRRkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L/lmEOdd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696oZgN5863791, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752043835; bh=hcmbV+F1qvgduQeQL1VRMQzPMFO1aZdASjjLFSUs9Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=L/lmEOddjR6IGL6smH7rN/lU6ZqYwwhewXAi/gVPBlOBJmjSJ4qDRKDQKlt1er811
	 07KmK069wblmSeApzuLGNebeUb/DNEGm8HMp0eywwjVWP2gQ1kmemyItJK4kPF0Ltd
	 Dw0EKE5s5r1MsPmVXYaRhCuAfKSsSqr/vg3M6vfN2Uv/us2ToJqTwaOWFRT+Y4HJgg
	 mh9I2KibRErYE1mzx5otfUKZSgigvA7xNLCsrmrnB2uGUjXqM+anBTN0VkvNB8+QRX
	 p4aH/fhLnje1qTCBfgC7+Oz+uYZ4UjmMzsmDQAHVanYJwlWPC90FRzKi13INQGz4Rc
	 IU0OiSXIJVuRg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696oZgN5863791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 14:50:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:51:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Jul
 2025 14:51:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/4] wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
Date: Wed, 9 Jul 2025 14:50:03 +0800
Message-ID: <20250709065006.32028-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709065006.32028-1-pkshih@realtek.com>
References: <20250709065006.32028-1-pkshih@realtek.com>
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

ACPI DSM function 7 is used to decide whether 6 GHz Standard Power
(SP) is allowed on given countries. Now, add BIT(1) for country CA.
Besides, for searching country index, replace for-loop with index
getter function.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.h |  1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 8c918ee02d2e..8217cdfbbc49 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -56,6 +56,7 @@ struct rtw89_acpi_policy_6ghz {
 
 enum rtw89_acpi_conf_6ghz_sp {
 	RTW89_ACPI_CONF_6GHZ_SP_US = BIT(0),
+	RTW89_ACPI_CONF_6GHZ_SP_CA = BIT(1),
 };
 
 struct rtw89_acpi_policy_6ghz_sp {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 3ad14cab1f58..c91a86332b17 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -490,12 +490,11 @@ static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
-	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
 	const struct rtw89_acpi_policy_6ghz_sp *ptr;
 	struct rtw89_acpi_dsm_result res = {};
-	bool enable_by_us;
+	bool enable;
+	u8 index;
 	int ret;
-	int i;
 
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP, &res);
 	if (ret) {
@@ -520,14 +519,15 @@ static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 
 	bitmap_fill(regulatory->block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
 
-	enable_by_us = u8_get_bits(ptr->conf, RTW89_ACPI_CONF_6GHZ_SP_US);
+	index = rtw89_regd_get_index_by_name(rtwdev, "US");
+	enable = u8_get_bits(ptr->conf, RTW89_ACPI_CONF_6GHZ_SP_US);
+	if (enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		clear_bit(index, regulatory->block_6ghz_sp);
 
-	for (i = 0; i < regd_ctrl->nr; i++) {
-		const struct rtw89_regd *tmp = &regd_ctrl->map[i];
-
-		if (enable_by_us && memcmp(tmp->alpha2, "US", 2) == 0)
-			clear_bit(i, regulatory->block_6ghz_sp);
-	}
+	index = rtw89_regd_get_index_by_name(rtwdev, "CA");
+	enable = u8_get_bits(ptr->conf, RTW89_ACPI_CONF_6GHZ_SP_CA);
+	if (enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		clear_bit(index, regulatory->block_6ghz_sp);
 
 out:
 	kfree(ptr);
-- 
2.25.1


