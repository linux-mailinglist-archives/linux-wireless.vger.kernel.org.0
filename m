Return-Path: <linux-wireless+bounces-3379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4839384F076
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA661C22195
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E638657DD;
	Fri,  9 Feb 2024 06:54:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9C657CA
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461648; cv=none; b=L4p0jGNZIcdRTkXMREQNSZkXQmrccoYQc0YqePIoQiY4Cr5uvxcDN+CNdMquhTq9iJYefcArxlpmgP3Ws4WzRdnvhljZE4KttTsOU43/GwYEq7l8ab3w3TMa8VAqClef5+bgeZkRWAnOxsC0BQsZyliPY7GmRiB9OudSFulPtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461648; c=relaxed/simple;
	bh=/aLcYv5SaWRp5DwEd0pGRpAS1JIHIRTGJfEV4cA/Vno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFerIhJ2QOvTezXwTNJUlak9DXea9LM83Fs+te6a8/SW69ANQaac1Mapii4+E2lu/A0fMX2WNJc4shthJIrK3+tvk1kmOanIvLCGagbjYz0XNEu3QpAssdhCny66qiG25vIoM5sAP8a6bZVJEXc9QNrMks8POuqc30IoZmRH1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196s11R1548442, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196s11R1548442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 9 Feb 2024 14:54:02 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:54:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 10/11] wifi: rtw89: reference quota mode when setting Tx power
Date: Fri, 9 Feb 2024 14:52:28 +0800
Message-ID: <20240209065229.34515-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Reference the current quota mode to avoid misleading warnings.
This patch is required after supporting DBCC quota mode.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 3 +--
 drivers/net/wireless/realtek/rtw89/mac_be.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 33cc2ce4bb74..917bbc482560 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5221,8 +5221,7 @@ bool rtw89_mac_get_txpwr_cr_ax(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx,
 			       u32 reg_base, u32 *cr)
 {
-	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
-	enum rtw89_qta_mode mode = dle_mem->mode;
+	enum rtw89_qta_mode mode = rtwdev->mac.qta_mode;
 	u32 addr = rtw89_mac_reg_by_idx(rtwdev, reg_base, phy_idx);
 
 	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR_AX) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 6447353d35d3..320e88229971 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1896,8 +1896,7 @@ static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      u32 reg_base, u32 *cr)
 {
-	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
-	enum rtw89_qta_mode mode = dle_mem->mode;
+	enum rtw89_qta_mode mode = rtwdev->mac.qta_mode;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, (enum rtw89_mac_idx)phy_idx,
-- 
2.25.1


