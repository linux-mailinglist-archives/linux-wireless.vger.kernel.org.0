Return-Path: <linux-wireless+bounces-12829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A393977933
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7438A28624C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FEC19F419;
	Fri, 13 Sep 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t6KsiQQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F21BCA19
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211678; cv=none; b=gB1UIXJVtlua29c+7rH+pXh5WQucZW+3rraykzp8wZySwovjch3hAJqncu+vyXro72iyF0wDUGzv2vazgPfnLy8C3a7cxLKstG9nLEcO7rvUzPrSupR82WW3xHQCYInPUKelHH7z9OWlys/4RmtAbgenqVwcC4MTE4Rg6av2tpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211678; c=relaxed/simple;
	bh=9AnAxz1IbxXjJ6dw12bPzG0mlzs6neAakNso/H07WjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoLmLx5aICx1A+nxgtTrr+2qF8Ti4iU+fHiwe5RanEsIE/sOaQyiHYcUB2XPRSGFdiDbcr7gV6Xj+kMTVlbanqk4JW0k2rfrZCl9cvsd7OG1Xu4V/VljtlMICHYKrGU1aLY/6srCSK/1VOmUwaN2h9o6rDMchGOD2aLN9o7kt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t6KsiQQM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7EXXr82542236, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211673; bh=9AnAxz1IbxXjJ6dw12bPzG0mlzs6neAakNso/H07WjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=t6KsiQQMBOGisGiSRuEolSN74tWuaz20/dYO+CuXcQT4OYv/5XemQLgPiTZ8PGV59
	 cWp/rH1mSENVo1Kf6+3SX3zffcLziftkV0asV9DIThBHU0UczKhWBdzaaudPKK7w4h
	 ZvRU6Mv/OI+c86cBVnucZF/Anj/nXHdRbvZbzeXIKFXRJtm/klYTaklzMm0UKtPbI1
	 IQTyLmdZwzS2JHsLS7kv+V0gjLRzT0/OMcxNIsdYhFBdoUtVTvPLmemj8GGLsF4M8l
	 35B5vD0XOe6UwfR12JUEPel2h5rZd0Hg1xCqB9WL5fMZqrDdqoncHRqAALyydsxQEh
	 9YhVIK11c7+ZQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7EXXr82542236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: rfk: update firmware debug log of DACK to v2
Date: Fri, 13 Sep 2024 15:13:40 +0800
Message-ID: <20240913071340.41822-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913071340.41822-1-pkshih@realtek.com>
References: <20240913071340.41822-1-pkshih@realtek.com>
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

Update DACK (digital-to-analog converters calibration) log to v2 by
firmware C2H events.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 12 +++--
 drivers/net/wireless/realtek/rtw89/phy.c | 64 +++++++++++++++++-------
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index bbf62950182a..5b8d83d90a4e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4375,19 +4375,25 @@ struct rtw89_c2h_rf_dpk_rpt_log {
 
 struct rtw89_c2h_rf_dack_rpt_log {
 	u8 fwdack_ver;
-	u8 fwdack_rpt_ver;
+	u8 fwdack_info_ver;
 	u8 msbk_d[2][2][16];
 	u8 dadck_d[2][2];
 	u8 cdack_d[2][2][2];
-	__le16 addck2_d[2][2][2];
+	u8 addck2_hd[2][2][2];
+	u8 addck2_ld[2][2][2];
 	u8 adgaink_d[2][2];
-	__le16 biask_d[2][2];
+	u8 biask_hd[2][2];
+	u8 biask_ld[2][2];
 	u8 addck_timeout;
 	u8 cdack_timeout;
 	u8 dadck_timeout;
 	u8 msbk_timeout;
 	u8 adgaink_timeout;
+	u8 wbadcdck_timeout;
+	u8 drck_timeout;
 	u8 dack_fail;
+	u8 wbdck_d[2];
+	u8 rck_d;
 } __packed;
 
 struct rtw89_c2h_rf_rxdck_rpt_log {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ae404ca4e2ee..87719b22381d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2792,8 +2792,23 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 
 		dack = content;
 
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]ver=0x%x 0x%x\n",
-			    dack->fwdack_ver, dack->fwdack_rpt_ver);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]FWDACK SUMMARY!!!!!\n");
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]FWDACK ver = 0x%x, FWDACK rpt_ver = 0x%x, driver rpt_ver = 0x%x\n",
+			    dack->fwdack_ver, dack->fwdack_info_ver, 0x2);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]timeout code = [0x%x 0x%x 0x%x 0x%x 0x%x]\n",
+			    dack->addck_timeout, dack->cdack_timeout, dack->dadck_timeout,
+			    dack->adgaink_timeout, dack->msbk_timeout);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]DACK fail = 0x%x\n", dack->dack_fail);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]S0 WBADCK = [0x%x]\n", dack->wbdck_d[0]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]S1 WBADCK = [0x%x]\n", dack->wbdck_d[1]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[DACK]DRCK = [0x%x]\n", dack->rck_d);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 CDACK ic = [0x%x, 0x%x]\n",
 			    dack->cdack_d[0][0][0], dack->cdack_d[0][0][1]);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 CDACK qc = [0x%x, 0x%x]\n",
@@ -2804,13 +2819,17 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 			    dack->cdack_d[1][1][0], dack->cdack_d[1][1][1]);
 
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_DCK ic = [0x%x, 0x%x]\n",
-			    dack->addck2_d[0][0][0], dack->addck2_d[0][0][1]);
+			    ((u32)dack->addck2_hd[0][0][0] << 8) | dack->addck2_ld[0][0][0],
+			    ((u32)dack->addck2_hd[0][0][1] << 8) | dack->addck2_ld[0][0][1]);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_DCK qc = [0x%x, 0x%x]\n",
-			    dack->addck2_d[0][1][0], dack->addck2_d[0][1][1]);
+			    ((u32)dack->addck2_hd[0][1][0] << 8) | dack->addck2_ld[0][1][0],
+			    ((u32)dack->addck2_hd[0][1][1] << 8) | dack->addck2_ld[0][1][1]);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADC_DCK ic = [0x%x, 0x%x]\n",
-			    dack->addck2_d[1][0][0], dack->addck2_d[1][0][1]);
+			    ((u32)dack->addck2_hd[1][0][0] << 8) | dack->addck2_ld[1][0][0],
+			    ((u32)dack->addck2_hd[1][0][1] << 8) | dack->addck2_ld[1][0][1]);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADC_DCK qc = [0x%x, 0x%x]\n",
-			    dack->addck2_d[1][1][0], dack->addck2_d[1][1][1]);
+			    ((u32)dack->addck2_hd[1][1][0] << 8) | dack->addck2_ld[1][1][0],
+			    ((u32)dack->addck2_hd[1][1][1] << 8) | dack->addck2_ld[1][1][1]);
 
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_GAINK ic = 0x%x, qc = 0x%x\n",
 			    dack->adgaink_d[0][0], dack->adgaink_d[0][1]);
@@ -2823,18 +2842,29 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 			    dack->dadck_d[1][0], dack->dadck_d[1][1]);
 
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 biask iqc = 0x%x\n",
-			    dack->biask_d[0][0]);
+			    ((u32)dack->biask_hd[0][0] << 8) | dack->biask_ld[0][0]);
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 biask iqc = 0x%x\n",
-			    dack->biask_d[1][0]);
-
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic: %*ph\n",
-			    (int)sizeof(dack->msbk_d[0][0]), dack->msbk_d[0][0]);
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc: %*ph\n",
-			    (int)sizeof(dack->msbk_d[0][1]), dack->msbk_d[0][1]);
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK ic: %*ph\n",
-			    (int)sizeof(dack->msbk_d[1][0]), dack->msbk_d[1][0]);
-		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK qc: %*ph\n",
-			    (int)sizeof(dack->msbk_d[1][1]), dack->msbk_d[1][1]);
+			    ((u32)dack->biask_hd[1][0] << 8) | dack->biask_ld[1][0]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic:\n");
+		for (i = 0; i < 0x10; i++)
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n",
+				    dack->msbk_d[0][0][i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc:\n");
+		for (i = 0; i < 0x10; i++)
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n",
+				    dack->msbk_d[0][1][i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK ic:\n");
+		for (i = 0; i < 0x10; i++)
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n",
+				    dack->msbk_d[1][0][i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK qc:\n");
+		for (i = 0; i < 0x10; i++)
+			rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n",
+				    dack->msbk_d[1][1][i]);
 		return;
 	case RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK:
 		if (len != sizeof(*rxdck))
-- 
2.25.1


