Return-Path: <linux-wireless+bounces-4236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26C86C2CF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14346284033
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2CA482C3;
	Thu, 29 Feb 2024 07:46:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE063481AD
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192806; cv=none; b=DZwCfny1b4zVriP1FUUIcDYJ2CUR77j/+E+j2rbwbgh7O/fGxH/8qc8DXQ4ifmICtAkNnUr6eRLDuiGELPL/lVAaqsd7N2Ag4Qh50yehUcLBWAVV8z3VGBKjrokZ1Ot56JzF37+m4/ATdFeCeqWrC8OqIl5wXk6yqzmjRzKZsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192806; c=relaxed/simple;
	bh=YYdxuXtXqP4cWKVCkh0xqe/cZ5WuyD4CeKotnntjEjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8VxQywrNxg39n4OW3r/nCCyqRzDxr28GT6DVsXtENOcTaK+qDeUDlQzc7QyxhHTzOQQMFdX07Kn2NNKd5ujlkIPCW+EPyPCA/C85zvxQIYSDcB0XPjjWtjEIz4gaVOhvdjp2L3JomJA1gzG4DhUwPElVd4Gg6P9hTejXPwjSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kdLG31229918, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kdLG31229918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 15:46:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: coex: When Bluetooth not available don't set power/gain
Date: Thu, 29 Feb 2024 15:45:13 +0800
Message-ID: <20240229074514.219276-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229074514.219276-1-pkshih@realtek.com>
References: <20240229074514.219276-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

If Bluetooth is working, it will update their info regularly. And the code
will increase the counters while the info updating. Use this counter to
judge is Bluetooth working or not. Don't need to set Bluetooth power or
gain when it is not working.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c74b1b6be2d3..6a1f9a555ce7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2311,6 +2311,9 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 	int ret;
 	u8 buf;
 
+	if (btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE] == 0)
+		return;
+
 	if (bt->rf_para.tx_pwr_freerun == level)
 		return;
 
@@ -2333,6 +2336,9 @@ static void _set_bt_rx_gain(struct rtw89_dev *rtwdev, u8 level)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 
+	if (btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE] == 0)
+		return;
+
 	if ((bt->rf_para.rx_gain_freerun == level ||
 	     level > BTC_BT_RX_NORMAL_LVL) &&
 	    (!rtwdev->chip->scbd || bt->lna_constrain == level))
-- 
2.25.1


