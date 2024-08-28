Return-Path: <linux-wireless+bounces-12113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED0961EED
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E1D1C235B0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAD14A4C7;
	Wed, 28 Aug 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dVHNO7/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F501534E9
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824365; cv=none; b=aHThHm0Sq+yNKUjLbKZQTMenGn5W6F4MZv8hrf8KiX6ZT6M+NMVxYnpQ/eI+Wclmrecjj3VHAVVEae1qdfqqKfXM6OQ8C/+GzaO+4cjtYdUIfc+AUaF04bMfmTj9WTwdMeAGP0tmtPNNAMyUBj+z76qniju6X1256fA9NmVOyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824365; c=relaxed/simple;
	bh=A247gLzl9mr20U+yvvbreSOk0gX0HUrr4u3zhUYWnvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8j/9i2UwjZXGlYJ2w/w9Yp1t/hsxUPwyIsCu51u7dprw0PwgSY5Ee0uLEpHrFecaKOfZ3LfBBBTqv4l18r26DCz3P6dMFtVeX3QqPzu+qTr5WRI3EZfdm5LH+F4pespjB5erbAFOHxFFqNrESN+SSFn+wo25sJQDq2qIzdRxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dVHNO7/x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47S5qejC71896002, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724824360; bh=A247gLzl9mr20U+yvvbreSOk0gX0HUrr4u3zhUYWnvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dVHNO7/xZbLFdH6nrQmJtBFrQSEQzbrOQVjdSrzpGIh04oQKtu7pn2O3Q/FOgQVJ7
	 CX0Kq94Ludcn1BZH4AqRHfmTdDTVMNFOHatpMXxkVHwUdJC5QckEePxgZXX6RxpvdN
	 857ZxnJlebbzb7wSQFQrHbKknYGGUHEeZkonI2tpTwqOcISQZHWBexoVRI0PWbz9k1
	 7NgJnH3T+xjYnj5fXHICPBDq9/7ag7ZGL6mLAJj/vxzQs8jonz8sooKepNxKnKqgwl
	 DsAIskt61pi5ogKQPui/kb9c+6DOsxm2w8LNzut4fbERtcRNAr8j/K67mnqirm69Wq
	 gjsF6grnjsGmw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47S5qejC71896002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 13:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 13:52:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Aug
 2024 13:52:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: adjust DIG threshold to reduce false alarm
Date: Wed, 28 Aug 2024 13:52:16 +0800
Message-ID: <20240828055217.10263-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828055217.10263-1-pkshih@realtek.com>
References: <20240828055217.10263-1-pkshih@realtek.com>
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

Use RSSI without subtracting offset as packet detection lower bound and
set an absolute minimal threshold. It's equivalent to setting a higher
noise floor, thereby reducing false alarm and improving interference
endurance.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 27 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 59b98aa876dd..c7165e757842 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5401,7 +5401,7 @@ static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev)
 	memcpy(dig->igi_rssi_th, igi_rssi_th, sizeof(dig->igi_rssi_th));
 }
 
-static const u8 pd_low_th_offset = 20, dynamic_igi_min = 0x20;
+static const u8 pd_low_th_offset = 16, dynamic_igi_min = 0x20;
 static const u8 igi_max_performance_mode = 0x5a;
 static const u8 dynamic_pd_threshold_max;
 
@@ -5699,38 +5699,47 @@ void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev)
 }
 
 #define IGI_RSSI_MIN 10
+#define ABS_IGI_MIN 0xc
 void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dig_info *dig = &rtwdev->dig;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
+	u8 igi_min;
 
 	if (unlikely(dig->bypass_dig)) {
 		dig->bypass_dig = false;
 		return;
 	}
 
+	rtw89_phy_dig_update_rssi_info(rtwdev);
+
 	if (!dig->is_linked_pre && is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First connected\n");
 		rtw89_phy_dig_update_para(rtwdev);
+		dig->igi_fa_rssi = dig->igi_rssi;
 	} else if (dig->is_linked_pre && !is_linked) {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG, "First disconnected\n");
 		rtw89_phy_dig_update_para(rtwdev);
+		dig->igi_fa_rssi = dig->igi_rssi;
 	}
 	dig->is_linked_pre = is_linked;
 
 	rtw89_phy_dig_igi_offset_by_env(rtwdev);
-	rtw89_phy_dig_update_rssi_info(rtwdev);
 
-	dig->dyn_igi_min = (dig->igi_rssi > IGI_RSSI_MIN) ?
-			    dig->igi_rssi - IGI_RSSI_MIN : 0;
-	dig->dyn_igi_max = dig->dyn_igi_min + IGI_OFFSET_MAX;
-	dig->igi_fa_rssi = dig->dyn_igi_min + dig->fa_rssi_ofst;
+	igi_min = max_t(int, dig->igi_rssi - IGI_RSSI_MIN, 0);
+	dig->dyn_igi_max = min(igi_min + IGI_OFFSET_MAX, igi_max_performance_mode);
+	dig->dyn_igi_min = max(igi_min, ABS_IGI_MIN);
 
-	dig->igi_fa_rssi = clamp(dig->igi_fa_rssi, dig->dyn_igi_min,
-				 dig->dyn_igi_max);
+	if (dig->dyn_igi_max >= dig->dyn_igi_min) {
+		dig->igi_fa_rssi += dig->fa_rssi_ofst;
+		dig->igi_fa_rssi = clamp(dig->igi_fa_rssi, dig->dyn_igi_min,
+					 dig->dyn_igi_max);
+	} else {
+		dig->igi_fa_rssi = dig->dyn_igi_max;
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG,
-		    "rssi=%03d, dyn(max,min)=(%d,%d), final_rssi=%d\n",
+		    "rssi=%03d, dyn_joint(max,min)=(%d,%d), final_rssi=%d\n",
 		    dig->igi_rssi, dig->dyn_igi_max, dig->dyn_igi_min,
 		    dig->igi_fa_rssi);
 
-- 
2.25.1


