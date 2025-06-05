Return-Path: <linux-wireless+bounces-23767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66571ACEEA7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A3A167FD1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABC211299;
	Thu,  5 Jun 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qet7w2IH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15621A454
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123761; cv=none; b=VYg1D2NZU9pVfq4EkL1jJI0b67gr8P8uXySP6o2LN+UygZ6a25gXnRy+5B7LAuCFJZfz1fLkr9SSFi3OTpyNaQ97cBdlUcab1OByr+t8ynNOhEY1mGm8Nv4O/6tCvq62QSM0dOLlxwS8tKGkfDOWmfyTX2jUH2+4h2bPyrB+p1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123761; c=relaxed/simple;
	bh=lRE2Jk1ExpWig++n1cN3WenEGgXgLarxyhS3pbbg5QY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcmNfeZVNASmfkL9IQihleqNORQgOwjk7P+mqah/gtIcEVx6g0QTGra9rNKnS/M0AEaATx7FJfpVWowuMcBfag4nWc4BDU9UyTLg3Z+GaSZNJRSBx3YOkYn6xI7Zb0qzAzSprYEA60/fZqjruAo7FcryygZb4wpKb8mLpvnpw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qet7w2IH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555Bgb8dB1471146, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123757; bh=l/quiBRLggPFt5CMto4aZ9R8iUCx/mFgqJMI6BDoS4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Qet7w2IH28Nk9ql6jBQVO/vV1RG5+6YtVCyk/BDyqFLtyfh7xxvwaBrZq0EyGd1UO
	 SU1kd+DIRnYGmfweJi0NXEGt3T2L5CrnqC9w+OBpfMdEskFUgfe8ROx5R+4jim61n2
	 8sYKtcHOaqBH6tDFhvFilCAi7eGHnuMSRvogddqlnAGlrHmqk+u69CgJxQXQyMsshG
	 2xyAjVUXoD/JIKEqJBkNeVHiAjyljmICWZQVaVML6sa4+vrFW6jgUNcglVhbqXl3Jp
	 DgKgx12gjkKIBWz6XVLiVZ9Evoa7ATabNmmPpqVa0E2qgeHjGH1TdjM5NXHo0qcgCJ
	 25JdgN3rJ6FdA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555Bgb8dB1471146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:37 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/5] wifi: rtw89: add EHT physts and adjust init flow accordingly
Date: Thu, 5 Jun 2025 19:42:06 +0800
Message-ID: <20250605114207.12381-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605114207.12381-1-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

Adding EHT physts and adjust IE bitmap initialization. This setting
is for PHY statistic gathering, won't effect functionality.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 75 ++++++++++++------------
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h |  1 +
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 76a2e26d4a10..158550485797 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5828,14 +5828,20 @@ void rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev)
 		__rtw89_phy_env_monitor_track(rtwdev, bb);
 }
 
-static bool rtw89_physts_ie_page_valid(enum rtw89_phy_status_bitmap *ie_page)
+static bool rtw89_physts_ie_page_valid(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_status_bitmap *ie_page)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
 	if (*ie_page >= RTW89_PHYSTS_BITMAP_NUM ||
 	    *ie_page == RTW89_RSVD_9)
 		return false;
-	else if (*ie_page > RTW89_RSVD_9)
+	else if (*ie_page > RTW89_RSVD_9 && *ie_page < RTW89_EHT_PKT)
 		*ie_page -= 1;
 
+	if (*ie_page == RTW89_EHT_PKT && chip->chip_gen == RTW89_CHIP_AX)
+		return false;
+
 	return true;
 }
 
@@ -5843,6 +5849,9 @@ static u32 rtw89_phy_get_ie_bitmap_addr(enum rtw89_phy_status_bitmap ie_page)
 {
 	static const u8 ie_page_shift = 2;
 
+	if (ie_page == RTW89_EHT_PKT)
+		return R_PHY_STS_BITMAP_EHT;
+
 	return R_PHY_STS_BITMAP_ADDR_START + (ie_page << ie_page_shift);
 }
 
@@ -5852,7 +5861,7 @@ static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
 {
 	u32 addr;
 
-	if (!rtw89_physts_ie_page_valid(&ie_page))
+	if (!rtw89_physts_ie_page_valid(rtwdev, &ie_page))
 		return 0;
 
 	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
@@ -5867,7 +5876,7 @@ static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 addr;
 
-	if (!rtw89_physts_ie_page_valid(&ie_page))
+	if (!rtw89_physts_ie_page_valid(rtwdev, &ie_page))
 		return;
 
 	if (chip->chip_id == RTL8852A)
@@ -5877,21 +5886,6 @@ static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
 }
 
-static void rtw89_physts_enable_ie_bitmap(struct rtw89_dev *rtwdev,
-					  enum rtw89_phy_status_bitmap bitmap,
-					  enum rtw89_phy_status_ie_type ie,
-					  bool enable, enum rtw89_phy_idx phy_idx)
-{
-	u32 val = rtw89_physts_get_ie_bitmap(rtwdev, bitmap, phy_idx);
-
-	if (enable)
-		val |= BIT(ie);
-	else
-		val &= ~BIT(ie);
-
-	rtw89_physts_set_ie_bitmap(rtwdev, bitmap, val, phy_idx);
-}
-
 static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
 					    bool enable,
 					    enum rtw89_phy_idx phy_idx)
@@ -5915,30 +5909,37 @@ static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
 static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 val;
 	u8 i;
 
 	rtw89_physts_enable_fail_report(rtwdev, false, phy_idx);
 
 	for (i = 0; i < RTW89_PHYSTS_BITMAP_NUM; i++) {
-		if (i >= RTW89_CCK_PKT)
-			rtw89_physts_enable_ie_bitmap(rtwdev, i,
-						      RTW89_PHYSTS_IE09_FTR_0,
-						      true, phy_idx);
-		if ((i >= RTW89_CCK_BRK && i <= RTW89_VHT_MU) ||
-		    (i >= RTW89_RSVD_9 && i <= RTW89_CCK_PKT))
+		if (i == RTW89_RSVD_9 ||
+		    (i == RTW89_EHT_PKT && chip->chip_gen == RTW89_CHIP_AX))
 			continue;
-		rtw89_physts_enable_ie_bitmap(rtwdev, i,
-					      RTW89_PHYSTS_IE24_OFDM_TD_PATH_A,
-					      true, phy_idx);
-	}
-	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_VHT_PKT,
-				      RTW89_PHYSTS_IE13_DL_MU_DEF, true, phy_idx);
-	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_HE_PKT,
-				      RTW89_PHYSTS_IE13_DL_MU_DEF, true, phy_idx);
-
-	/* force IE01 for channel index, only channel field is valid */
-	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_CCK_PKT,
-				      RTW89_PHYSTS_IE01_CMN_OFDM, true, phy_idx);
+
+		val = rtw89_physts_get_ie_bitmap(rtwdev, i, phy_idx);
+		if (i == RTW89_HE_MU || i == RTW89_VHT_MU) {
+			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF);
+		} else if (i == RTW89_TRIG_BASE_PPDU) {
+			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF) |
+			       BIT(RTW89_PHYSTS_IE01_CMN_OFDM);
+		} else if (i >= RTW89_CCK_PKT) {
+			val |= BIT(RTW89_PHYSTS_IE09_FTR_0);
+
+			val &= ~(GENMASK(RTW89_PHYSTS_IE07_CMN_EXT_PATH_D,
+					 RTW89_PHYSTS_IE04_CMN_EXT_PATH_A));
+
+			if (i == RTW89_CCK_PKT)
+				val |= BIT(RTW89_PHYSTS_IE01_CMN_OFDM);
+			else if (i >= RTW89_HT_PKT)
+				val |= BIT(RTW89_PHYSTS_IE20_DBG_OFDM_FD_USER_SEG_0);
+		}
+
+		rtw89_physts_set_ie_bitmap(rtwdev, i, val, phy_idx);
+	}
 }
 
 static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5b451f1cfaac..63cc33c16c9a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -252,6 +252,7 @@ enum rtw89_phy_status_bitmap {
 	RTW89_HT_PKT          = 13,
 	RTW89_VHT_PKT         = 14,
 	RTW89_HE_PKT          = 15,
+	RTW89_EHT_PKT         = 16,
 
 	RTW89_PHYSTS_BITMAP_NUM
 };
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f05c81ae5869..255a8635b195 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8024,6 +8024,7 @@
 #define R_PHY_STS_BITMAP_HT 0x076C
 #define R_PHY_STS_BITMAP_VHT 0x0770
 #define R_PHY_STS_BITMAP_HE 0x0774
+#define R_PHY_STS_BITMAP_EHT 0x0788
 #define R_EDCCA_RPTREG_SEL_BE 0x078C
 #define B_EDCCA_RPTREG_SEL_BE_MSK GENMASK(22, 20)
 #define R_PMAC_GNT 0x0980
-- 
2.25.1


