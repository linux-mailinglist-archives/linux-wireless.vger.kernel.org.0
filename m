Return-Path: <linux-wireless+bounces-6429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95E8A7EFA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BB5281256
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF4127B40;
	Wed, 17 Apr 2024 09:01:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D46E613
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344471; cv=none; b=THCM56a52jN+Z44mQ/xmi+gScf6tEV8HIBH6Kb03aNQa4gxwH4u9sARovIL78dHrIRJTxc0VvVUEbhtTJ8ErWGSuHiMBsGGHFt6+/ijtd7hNd9JTwc3/3zmazmauKl1sZOkO2X2VQ6ag2RgjuFXreNioJVO7IHm5kAy2GsrPEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344471; c=relaxed/simple;
	bh=e9SSBma6jlKqvwC3OvKN5raP3ZdwsZuZ59ls0XCOua0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GB9nkyeGckyQJ4G5gYjs8AyhqOA7PbSJu/hHPhJK/F1b62Lrj5SMWKZdnA0CuR2X1GFyNoscHuhzrNriFoQ9UpENV+Y9GZEXxOPKXQRaVEktn+2WaG3/PTINFiA2/kTeZqj9Ff+3VMe3boqMbp3EeJqqs4kO+/ORjmnKHBjMJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H913EE03193486, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H913EE03193486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 17:01:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:01:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 17:01:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: 8922a: fix argument to hal_reset in bb_cfg_txrx_path
Date: Wed, 17 Apr 2024 17:00:58 +0800
Message-ID: <20240417090058.42663-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When hal_reset on MAC_1/PHY_1, we should pass tx_en1 instead of tx_en0.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1d0b6de0eeab..3b3ea3a7c19a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2126,7 +2126,7 @@ static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 	rtw8922a_hal_reset(rtwdev, RTW89_PHY_0, RTW89_MAC_0, band, &tx_en0, false);
 	if (rtwdev->dbcc_en)
 		rtw8922a_hal_reset(rtwdev, RTW89_PHY_1, RTW89_MAC_1, band,
-				   &tx_en0, false);
+				   &tx_en1, false);
 }
 
 static u8 rtw8922a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
-- 
2.25.1


