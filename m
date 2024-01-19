Return-Path: <linux-wireless+bounces-2229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7EE832584
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C542B23437
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA68328E01;
	Fri, 19 Jan 2024 08:15:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69E28E10
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652153; cv=none; b=Pte72xrdPq0JaLkK1LZEQmKREMr0btKZVyBFa5egjxSCq1MlEtoGEN942x6nzzG+oGyb0eeqhAm0HSB16WCFNTI1F6aUp/z5q28hNgBdfTXAacnIilo8tDbn/LT1jJQHE8Cg8InAKXxs24le8K2em00gShdHKItXEgFZPCihHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652153; c=relaxed/simple;
	bh=uOCcawkG5MQZLXHAyD3GoafqcPPzSxyW/9ctOUwFivo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz272ZpkyN90jfwYGUpBO2+6P7jJ1oUiJQI4DaX2Cpk29ySdZftZrWWUoty3vSmW7ZhaJcmEBlyemaJGB22bleboiKSIvwrlHkwe6WkOAJbDFNDm+99lX7A8I+BUZJs5Is/vdQfyiOYZtfDgV5EZWu3f4WqzIOgMzPU8zs4vTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FlJ022212464, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FlJ022212464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 19 Jan 2024 16:15:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: fix null pointer access when abort scan
Date: Fri, 19 Jan 2024 16:14:58 +0800
Message-ID: <20240119081501.25223-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

During cancel scan we might use vif that weren't scanning.
Fix this by using the actual scanning vif.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 21b42984fd8a..b61c5be8cae3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -441,7 +441,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			 * when disconnected by peer
 			 */
 			if (rtwdev->scanning)
-				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 		}
 	}
 
@@ -994,7 +994,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 	if (rtwdev->scanning)
-		rtw89_hw_scan_abort(rtwdev, vif);
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 
 	if (type == IEEE80211_ROC_TYPE_MGMT_TX)
 		roc->state = RTW89_ROC_MGMT;
-- 
2.25.1


