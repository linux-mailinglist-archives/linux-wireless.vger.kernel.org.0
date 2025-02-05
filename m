Return-Path: <linux-wireless+bounces-18483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FBA28158
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DC21882D4D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE925A63B;
	Wed,  5 Feb 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HwWgM2ef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357A213E91
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719199; cv=none; b=kkqUk33QQp089uNr7f0L5CYiVz49vRSM/J9BBo8NAxJmb4AwdbhrvSrTUs6smjinITutOGXBQZa1yK6/nIewP/TZ+zefFwV+ob7C1QHgzG+fbKgae+I2nyZiJSKunU3yVgenEaCrgEw9wCjd81QgffckwLNlE1l7+Pi7eM7ODc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719199; c=relaxed/simple;
	bh=287TFufhOJ44nqug9HXu/nUOdoHf+C+P6zA8cP/TgBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xx1gKNRe5lb61P8hk/n0HFTm2ktsHJuui6vttD84qqcj0mF3GEGKk5UxCPb8htFfZeEHyPWU7isIWefrS7PWLUOumLXceJ6yaP68hpX/BlLxx3jLU62kWOp3V7LCFgPA2Eg75sT5mRGxwfZLhLTerwhIJA2Mj0C48uxFsyx3D9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HwWgM2ef; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5151XF2r8761257, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738719195; bh=287TFufhOJ44nqug9HXu/nUOdoHf+C+P6zA8cP/TgBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HwWgM2efB2yCFgrneNBZ8OtE178gt8k1rUe22/xEx4bQJXWOut5eQsR2diMgXre0w
	 4a8M5RKvo0OJbdKXptS+B+RJjEe83FW0X4FGCbg+cFdxdRuBN2WWpAlS8S38F43/fA
	 J2uAftmdpZtM+uqCxyzTstznzWuIWy5b7BKOlSnIk+ZOIYr3yF/qK0bpMADuXS9MJx
	 V9g3Vh829JcSpb5HcyyfWMt9uP7O+kDtTcBCgGE0JOv+alKrVGdjFeBP7UvVNgt9Oq
	 rrgp3Yp5Y6IVw/OFoAPu/x0oISGykA4p35F8yNQ5pnkj6FRrP8WnYHwb43aYFK0dJz
	 YFl4O+LQvpPEQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5151XF2r8761257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 09:33:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 09:33:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Feb
 2025 09:33:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 2/3] wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot arrangement
Date: Wed, 5 Feb 2025 09:32:32 +0800
Message-ID: <20250205013233.10945-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205013233.10945-1-pkshih@realtek.com>
References: <20250205013233.10945-1-pkshih@realtek.com>
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

The TWS(True wireless stereo) serials Bluetooth audio device need to keep
packet traffic not only with DUT, it also need to synchronize packet with
its assistant earbud. And all the BR/EDR Bluetooth device need to do page
scan to keep re-connect event sensitively between different DUT.
These behavior will make TWS Bluetooth device cost more time slot to keep
the good audio performance. This patch decrease half of Wi-Fi slot(from
40ms to 20ms) in a single cycle. Make the slot more flexible to prevent
audio lag. The single cycle will be shorter, then it will bring some slot
protection cost make Wi-Fi throughput decrease about 5%.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 806a51782467..28d29fa17316 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4583,17 +4583,11 @@ static void _action_bt_hid(struct rtw89_dev *rtwdev)
 static void _action_bt_a2dp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
-	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (a2dp.vendor_id == 0x4c || dm->leak_ap || bt_linfo->slave_role)
-		dm->slot_dur[CXST_W1] = 20;
-	else
-		dm->slot_dur[CXST_W1] = 40;
-
+	dm->slot_dur[CXST_W1] = 20;
 	dm->slot_dur[CXST_B1] = BTC_B1_MAX;
 
 	switch (btc->cx.state_map) {
@@ -4690,17 +4684,11 @@ static void _action_bt_pan(struct rtw89_dev *rtwdev)
 static void _action_bt_a2dp_hid(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
-	struct rtw89_btc_bt_a2dp_desc a2dp = bt_linfo->a2dp_desc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (a2dp.vendor_id == 0x4c || dm->leak_ap || bt_linfo->slave_role)
-		dm->slot_dur[CXST_W1] = 20;
-	else
-		dm->slot_dur[CXST_W1] = 40;
-
+	dm->slot_dur[CXST_W1] = 20;
 	dm->slot_dur[CXST_B1] = BTC_B1_MAX;
 
 	switch (btc->cx.state_map) {
-- 
2.25.1


