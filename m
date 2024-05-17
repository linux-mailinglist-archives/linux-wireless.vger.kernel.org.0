Return-Path: <linux-wireless+bounces-7756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980A8C7F98
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 03:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AF2282EB7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 01:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E710F9;
	Fri, 17 May 2024 01:36:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9047E2
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909765; cv=none; b=i9fifbajdcpdDN5Dkuq0cfFyXqpd1G3BXXpby5TP6aYhCcBzw1v1RVsHUL5k0wyXor+cxsE4wndG5nPvHvSjZKaGvFYI4CdrZmfkUX4upxCkxdOtVHdRC15Wxb9OgfM+nlabWpZ+S2W6Mqs9oNs0fFmIzdGylR0zrOB4LUFuma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909765; c=relaxed/simple;
	bh=xabT62dYwSdB8WjsKQQ1r0Lhb+KLUFt3QDSLHtK2+kM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eraGA5MrkPIUys8CEF85i0+Pji0uARAxTOuRcUWocR1twz2HZsWkzjNSEcB8TSVfuPjaQCDcX1mqenwk42+gSEYW+oGa9UYzL3/ArXFK/Oo2JdEkKs/h291yB840Ywnh1IxDNqaie6Ae70GZlGopeiDmuLN6Uy7MN1n5VgaMnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H1ZxgwE1833836, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H1ZxgwE1833836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 09:35:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 09:36:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 09:35:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume
Date: Fri, 17 May 2024 09:35:43 +0800
Message-ID: <20240517013543.11533-1-pkshih@realtek.com>
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

The RFE type 5 set SPS analog parameters only once at probe stage, but the
setting is missing after suspend/resume, so remove restriction and set the
value when card power on/off.

Fixes: 3ef60f44830a ("wifi: rtw89: 8852b: update hardware parameters for RFE type 5")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 53ae00b5ab7c..517ad1a763fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -403,6 +403,8 @@ static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 	u32 val32;
 	u32 ret;
 
+	rtw8852b_pwr_sps_ana(rtwdev);
+
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
 						    B_AX_AFSM_PCIE_SUS_EN);
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_DIS_WLBT_PDNSUSEN_SOPC);
@@ -530,9 +532,7 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 	u32 val32;
 	u32 ret;
 
-	/* Only do once during probe stage after reading efuse */
-	if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
-		rtw8852b_pwr_sps_ana(rtwdev);
+	rtw8852b_pwr_sps_ana(rtwdev);
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
 				      XTAL_SI_RFC2RF);
-- 
2.25.1


