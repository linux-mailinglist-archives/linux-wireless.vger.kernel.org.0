Return-Path: <linux-wireless+bounces-7757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9D8C7F9C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6518282ECD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E94748E;
	Fri, 17 May 2024 01:36:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CD63A5
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909819; cv=none; b=Nte1l7BD3HJCqgEmoW4GkJ1yBz+ftpGQOSNHAqeG1nl6FmYvwQTRP2IdIjz1nwalZQ2NjD4ffQC7NM3QFfZ9Ee3QeJOXyjez2uOd/1eSSa0fcABR/HNWYjB78+q7erDMPZO4oLTmuXEvl2bmLHgKmOH95SxIss1Sqt42UXkHvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909819; c=relaxed/simple;
	bh=WObsh1BOQh5x29qbr0Bmig5xfiW75uoNLagf6/a7ahU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z78mPoNThwEdyeS39cFPOLg8D00A+55tkIByeG3DDV7ya4nTwYSPSOR+aEGkpkb08rVlk/xyCvE3gaNVqzUzH21Cyeg9T2XWjQ+j/lgbHhSmwa7PbdIjBSvnhtQEqwCES8AUub8ggfqJRLBLN6Lm2ysklFYFFSts1lrhU/TgUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44H1asQ431835601, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44H1asQ431835601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 09:36:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 09:36:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 09:36:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips
Date: Fri, 17 May 2024 09:36:39 +0800
Message-ID: <20240517013639.11643-1-pkshih@realtek.com>
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

The hardware value of 3 for WiFi 7 chips is padding 16 or 20us selected
by hardware automatically. Correct the value to resolve interoperability
problem. Also define enum to be more readable.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  7 +++++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 12 ++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c0f2afb4888a..523ea9f5e6b1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -884,6 +884,13 @@ enum rtw89_ps_mode {
 #define RTW89_BYR_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
 #define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
 
+enum rtw89_pe_duration {
+	RTW89_PE_DURATION_0 = 0,
+	RTW89_PE_DURATION_8 = 1,
+	RTW89_PE_DURATION_16 = 2,
+	RTW89_PE_DURATION_16_20 = 3,
+};
+
 enum rtw89_ru_bandwidth {
 	RTW89_RU26 = 0,
 	RTW89_RU52 = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f5cd06c35982..1ea2b662fc89 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2752,11 +2752,11 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
 
 		if (ppe16 != 7 && ppe8 == 7)
-			pads[i] = 2;
+			pads[i] = RTW89_PE_DURATION_16;
 		else if (ppe8 != 7)
-			pads[i] = 1;
+			pads[i] = RTW89_PE_DURATION_8;
 		else
-			pads[i] = 0;
+			pads[i] = RTW89_PE_DURATION_0;
 	}
 }
 
@@ -2889,11 +2889,11 @@ static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
 
 		if (ppe16 != 7 && ppe8 == 7)
-			pads[i] = 2;
+			pads[i] = RTW89_PE_DURATION_16_20;
 		else if (ppe8 != 7)
-			pads[i] = 1;
+			pads[i] = RTW89_PE_DURATION_8;
 		else
-			pads[i] = 0;
+			pads[i] = RTW89_PE_DURATION_0;
 	}
 }
 
-- 
2.25.1


