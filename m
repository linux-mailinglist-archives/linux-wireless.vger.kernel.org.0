Return-Path: <linux-wireless+bounces-3370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95B84F069
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E6A1C22B18
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFD657B6;
	Fri,  9 Feb 2024 06:53:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54655657AB
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461612; cv=none; b=HD7ol25CMPPyYEUttQYir2K/fszpQLJzuB1o9FDb7FfMvmmRUcAOESszDQAzZ+sVnSzpj0T0glmhVppHLdQQA5K8ioca8mxvRCSMC8AmsapQRcpBNabfSz7TkfHbIyDD+gIoK7h6HnUbd/ObWmlkmS/dy0AgRZTzjG4hepHBBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461612; c=relaxed/simple;
	bh=TdMaJnHfDsXOfhL7EKyvqJctD9cA94oDNKKE1o2VCzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO6Ynqud2d6wlBz5m78l1rvdjmLgglLcjAI35xOjVe7sKFY0GmooAG28a7sjagE9Jwm/AHj97EePGGQ91twvhTqw+vyEL/Fo2SJk7ppiEDa9yeups6A6NPeDIpJh0cAX3yuFie0ov+pIioYz6uL+nOddIpkrw8cMOZLt4I3ijUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196rNTp9548389, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196rNTp9548389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 9 Feb 2024 14:53:23 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 02/11] wifi: rtw89: load BB parameters to PHY-1
Date: Fri, 9 Feb 2024 14:52:20 +0800
Message-ID: <20240209065229.34515-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

We are going to support MLO/DBCC, so need to load parameter table to
PHY-1 as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - use 'uintptr_t' to avoid clang warning on casting from common
   argument with type void*
---
 drivers/net/wireless/realtek/rtw89/phy.c | 29 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7c2f0ba996b1..81f73821e3fc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1025,22 +1025,30 @@ static void rtw89_phy_config_bb_reg(struct rtw89_dev *rtwdev,
 				    enum rtw89_rf_path rf_path,
 				    void *extra_data)
 {
-	if (reg->addr == 0xfe)
+	u32 addr;
+
+	if (reg->addr == 0xfe) {
 		mdelay(50);
-	else if (reg->addr == 0xfd)
+	} else if (reg->addr == 0xfd) {
 		mdelay(5);
-	else if (reg->addr == 0xfc)
+	} else if (reg->addr == 0xfc) {
 		mdelay(1);
-	else if (reg->addr == 0xfb)
+	} else if (reg->addr == 0xfb) {
 		udelay(50);
-	else if (reg->addr == 0xfa)
+	} else if (reg->addr == 0xfa) {
 		udelay(5);
-	else if (reg->addr == 0xf9)
+	} else if (reg->addr == 0xf9) {
 		udelay(1);
-	else if (reg->data == BYPASS_CR_DATA)
+	} else if (reg->data == BYPASS_CR_DATA) {
 		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "Bypass CR 0x%x\n", reg->addr);
-	else
-		rtw89_phy_write32(rtwdev, reg->addr, reg->data);
+	} else {
+		addr = reg->addr;
+
+		if ((uintptr_t)extra_data == RTW89_PHY_1)
+			addr += rtw89_phy0_phy1_offset(rtwdev, reg->addr);
+
+		rtw89_phy_write32(rtwdev, addr, reg->data);
+	}
 }
 
 union rtw89_phy_bb_gain_arg {
@@ -1554,6 +1562,9 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 
 	bb_table = elm_info->bb_tbl ? elm_info->bb_tbl : chip->bb_table;
 	rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg, NULL);
+	if (rtwdev->dbcc_en)
+		rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg,
+				   (void *)RTW89_PHY_1);
 	rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_0);
 
 	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
-- 
2.25.1


