Return-Path: <linux-wireless+bounces-13763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81799607A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC3F2846CE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6080E17C21E;
	Wed,  9 Oct 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FpdVp2/q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C91514CC
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458192; cv=none; b=MCjskJIO5vBa/ZCcRBPTq8wHqc+6A/WC6DG2lTRdZkt2K00xtRD8HsKaZEYSs93CAUJ72CxnVm/SJAYuoBJX5foe0kReqa7+OfyPFzUIiAdToJn03nr2YpEyU3BwjqEB+gF3SUKNzE6z+ztTONLEMlIufq4866lJX8BMXMQjSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458192; c=relaxed/simple;
	bh=IaVWT/kNrX4biGVvv3NdaxAOxCxL648BcatsgmzFJHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OyTzQVM2XohIcve0/EEawBWdgzbxxNitBz1pNzV95L7/XybTSBlBn4t3pVscfd2u5k+WxNp+PRAFTVWgDrXXMY0RT4/zQxl9V3aFd1dUc8J8CZ3NBmAVyz4hRSaGbk28ZVdnGRx+byWjm9lUaoWd7bK163xSZDVV8hS75SvzB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FpdVp2/q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4997GPIs8411396, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728458185; bh=IaVWT/kNrX4biGVvv3NdaxAOxCxL648BcatsgmzFJHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FpdVp2/qxDzzIAqGe7n7Qem49UBIdJ/CwYhvEqWWV+hQeAHayXf+5rNKu/tOdcPJ2
	 759X4zjV62YZxzyvFSppdC2I5zikeDepx+MPZpBE/gvjRUMg0yX7I0PfYRGFlcTseM
	 ri/54/INH+MkTTMR7AkKijYl9QezdPDOHeN+uVIT5v3/Q9O2hA+Q8TJH0SvlAyiHbQ
	 8Y+VYnNnX1N8sie2zkuv2JIrYDVLkVWmA0kPQbXQiJ+IwysT9iZ2ahgIksmMVzuJus
	 vp0mvVyKAPMPmwmsc2zBFIX5Wpv1xcWjehaW/NEEif804Wr1xEOtV4kVrUzCspszsr
	 OWIS7IZsW/UQQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4997GPIs8411396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 15:16:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 15:16:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 15:16:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband
Date: Wed, 9 Oct 2024 15:16:19 +0800
Message-ID: <20241009071619.16841-1-pkshih@realtek.com>
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

The UNII-4 uses the same SAR value of UNII-3, so add UNII-4 frequency
range and change the enum name to represent UNII-3 and UNII-4.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 2 +-
 drivers/net/wireless/realtek/rtw89/sar.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d9cf39cc4cec..829bccb64706 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4558,7 +4558,7 @@ enum rtw89_sar_subband {
 	RTW89_SAR_2GHZ_SUBBAND,
 	RTW89_SAR_5GHZ_SUBBAND_1_2, /* U-NII-1 and U-NII-2 */
 	RTW89_SAR_5GHZ_SUBBAND_2_E, /* U-NII-2-Extended */
-	RTW89_SAR_5GHZ_SUBBAND_3,   /* U-NII-3 */
+	RTW89_SAR_5GHZ_SUBBAND_3_4, /* U-NII-3 and U-NII-4 */
 	RTW89_SAR_6GHZ_SUBBAND_5_L, /* U-NII-5 lower part */
 	RTW89_SAR_6GHZ_SUBBAND_5_H, /* U-NII-5 higher part */
 	RTW89_SAR_6GHZ_SUBBAND_6,   /* U-NII-6 */
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 27826d909785..bcc287771b2a 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -27,8 +27,8 @@ static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 		return RTW89_SAR_5GHZ_SUBBAND_1_2;
 	case 5500 ... 5720:
 		return RTW89_SAR_5GHZ_SUBBAND_2_E;
-	case 5745 ... 5825:
-		return RTW89_SAR_5GHZ_SUBBAND_3;
+	case 5745 ... 5885:
+		return RTW89_SAR_5GHZ_SUBBAND_3_4;
 	case 5955 ... 6155:
 		return RTW89_SAR_6GHZ_SUBBAND_5_L;
 	case 6175 ... 6415:
@@ -295,7 +295,7 @@ static const struct cfg80211_sar_freq_ranges rtw89_common_sar_freq_ranges[] = {
 	{ .start_freq = 2412, .end_freq = 2484, },
 	{ .start_freq = 5180, .end_freq = 5320, },
 	{ .start_freq = 5500, .end_freq = 5720, },
-	{ .start_freq = 5745, .end_freq = 5825, },
+	{ .start_freq = 5745, .end_freq = 5885, },
 	{ .start_freq = 5955, .end_freq = 6155, },
 	{ .start_freq = 6175, .end_freq = 6415, },
 	{ .start_freq = 6435, .end_freq = 6515, },
-- 
2.25.1


