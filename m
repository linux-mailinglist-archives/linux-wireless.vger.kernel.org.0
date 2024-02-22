Return-Path: <linux-wireless+bounces-3898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19285F193
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB9CB23A7D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12E17583;
	Thu, 22 Feb 2024 06:44:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA090DDB0
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584242; cv=none; b=lXmzvDwd2k3Np0MXEgdnZCE+/sWIpBBknng2aWvRiT9jlUtMwfkRdKR34liSgm0FuPvtOMYsevYesL0D3z03WC3QC2Qn9DkgbK/BCNj5jUqMUaRYXJVaJY9inhJJlX7rpff0IFhTc5xNbUhXhJS9lLgv8U9xFPrBKxeHnLN03CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584242; c=relaxed/simple;
	bh=Uey7LoITZzWqqD2Gxx6C5DZ/fYCEXuSTyw3Y8quOjTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fizSvpo5QBXcEuD8dwZODU7xegXb1RF2WSQeMimOg4FxKr0JNeMCmKGXhTRTJbi0/1V6AcNVQPabPVU+0GV5craw13DSGalbVB+x1Xc5jfYuympyvsuOHj4em7e0cGTR7Oo9cCSq2wEfqwlB/yrLpK1Y/XGl5ycmwcftxoY2mKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41M6hmsV71486321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41M6hmsV71486321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 14:43:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 22 Feb 2024 14:43:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Feb
 2024 14:43:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: advertise missing extended scan feature
Date: Thu, 22 Feb 2024 14:42:56 +0800
Message-ID: <20240222064258.59782-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222064258.59782-1-pkshih@realtek.com>
References: <20240222064258.59782-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add support for random serial number in probe request and
configure channel dwell time. Advertise corresponding feature flag
NL80211_EXT_FEATURE_SCAN_RANDOM_SN and NL80211_EXT_FEATURE_SET_SCAN_DWELL.
Use the scan request duration as channel dwell time when it is
non-zero, otherwise use the default value.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f697e3d898e6..d4bca8cd08f2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4505,6 +4505,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->max_remain_on_channel_duration = 1000;
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_SCAN_RANDOM_SN);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
 
 	ret = rtw89_core_set_supported_band(rtwdev);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 63897351ca15..f654ad4c2546 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5739,7 +5739,7 @@ int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		if (req->duration_mandatory)
+		if (req->duration)
 			ch_info->period = req->duration;
 		else if (channel->band == NL80211_BAND_6GHZ)
 			ch_info->period = RTW89_CHANNEL_TIME_6G +
@@ -5817,7 +5817,7 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		if (req->duration_mandatory)
+		if (req->duration)
 			ch_info->period = req->duration;
 		else if (channel->band == NL80211_BAND_6GHZ)
 			ch_info->period = RTW89_CHANNEL_TIME_6G + RTW89_DWELL_TIME_6G;
-- 
2.25.1


