Return-Path: <linux-wireless+bounces-3317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84684D7CB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA73286F43
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C041BDE2;
	Thu,  8 Feb 2024 02:30:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620919470
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359412; cv=none; b=YNNaTHVfSOlRM6UD5RRc4DrstiS2TMOodI4KO1ZZNGLMYnL6khM5IfrBurXFEq/09TIZDpcRdKTSDvTZ3SQnT1VenUeWh5IJF/GLK/x2ACuCntGvFMgTMmM2Mc9M49FzPh1TYUZWTXECaYnpIlxb4nHjJL3r0P8vcEl05aGtVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359412; c=relaxed/simple;
	bh=8pGvmfwUQthgVaat8/Dz+7LloEvIPB6wdcKqYxaXbew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVut85zIi6YKth3FscRBUg6UXLlPt8/09NweP04fmYvFEF+AQX+j1MldGE5Q7Caw788nte86TNxWtTi19eUBJ4oNtu+k3bCW7PHHAL6tQeE+gIK+RtPO+ql+vg+9gv9oPWSSIMS9ska4wb1zUL3YcM0K2vMmoWFp7FcJ+05t9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182U5lnC191992, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182U5lnC191992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:30:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 8 Feb 2024 10:30:05 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:30:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/11] wifi: rtw89: mac: reset PHY-1 hardware when going to enable/disable
Date: Thu, 8 Feb 2024 10:28:51 +0800
Message-ID: <20240208022857.14379-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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

When going to use PHY-1, reset the hardware to make it work properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index fdbfb76f97ee..f3c82751993c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1546,6 +1546,13 @@ static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 
 static int dbcc_bb_ctrl_be(struct rtw89_dev *rtwdev, bool bb1_en)
 {
+	u32 set = B_BE_FEN_BB1PLAT_RSTB | B_BE_FEN_BB1_IP_RSTN;
+
+	if (bb1_en)
+		rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, set);
+	else
+		rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE, set);
+
 	return 0;
 }
 
-- 
2.25.1


