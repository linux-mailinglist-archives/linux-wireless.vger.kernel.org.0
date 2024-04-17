Return-Path: <linux-wireless+bounces-6428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A178A7EF9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEA81C20D29
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDF127B40;
	Wed, 17 Apr 2024 09:01:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7756D1CE
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344463; cv=none; b=CkCO0+pZIJBrz5ufmlttyLi2BOrXrDIEN8bBKYrJ4S0+smkqWY3O5AnliDxt47RTuRDZL44enAAIzSNRaey3GsgDle0QKBWMa/q91bWe6mTlSeVovcJsPgACwM9jdBTpTKGFvw+N5nbTlmIuQUL1JDgNGa5GRcn72PTWd6I+HbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344463; c=relaxed/simple;
	bh=yVDLIxOyAqwzuc5YWvXb2Ps9RoSfIaonSNgmDa05tDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m6pJsKSkVvO1D6CFahrThIymd7JNmXUswkb2VCMPmqjnOf2xyZnpDo4wbtG9igIBH/N06ZnbUrGbu9ESoErZYHMkSP7m46DM5oklidbDzpwfo4zKqE++NEGwTb57lKWytiwlKQq7t8fzUFla0oUqDuX3FYPhVkdMQ99H0gmc+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H90tnqE3193376, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H90tnqE3193376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 17:00:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:00:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 17:00:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
Date: Wed, 17 Apr 2024 17:00:50 +0800
Message-ID: <20240417090050.42607-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We will support MLO on 802.11be chip, e.g. RTL8922A, in the future. At that
time being, we will set WIPHY_FLAG_SUPPORTS_MLO according to chip info and
FW features at runtime. But, with WIPHY_FLAG_SUPPORTS_MLO flag, cfg80211
will disable WEXT. In case inconsistent user experience, if 802.11be chip,
we disable WEXT uniformly from now on.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 52588f04155a..8c5081631d09 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4509,6 +4509,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	if (!chip->support_rnr)
 		hw->wiphy->flags |= WIPHY_FLAG_SPLIT_SCAN_6GHZ;
 
+	if (chip->chip_gen == RTW89_CHIP_BE)
+		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
+
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
-- 
2.25.1


