Return-Path: <linux-wireless+bounces-4503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA81876E10
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 01:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4601F22E95
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1D188;
	Sat,  9 Mar 2024 00:14:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7B36E
	for <linux-wireless@vger.kernel.org>; Sat,  9 Mar 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943295; cv=none; b=rNd30/I+3/ZwXI2S2LOM2rBYXBixh4cEsq1yPrwnvcygIXvR8Uv4KhalUBREgEnS76GYZP3Rd1Up7rAf4vP2x2y+hb9i/veOW177hXoSTQoo9RrmsN798YzDd8sMrgQ0xhwXsybToUVMhGKfttW3Mn13k8uqjAMQ3XAz565gQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943295; c=relaxed/simple;
	bh=Ibp79Cs1kCxk3qRg4r9rlcQt2Z41H6jWOhbKCQ8gUhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvHRw4huT/6V8St9PyYuq3Jz9RtBM9WftjZIMeg4jqowvX2h4+QWlmZgfJ7FxxEDDjyz3GZPgk37f736kwJ44drweaS48lciUjgF1MtzxaohrnY1IDO74TZM3cr3hS1CZpmZc8a5AnZv20+LJ/Refg/XHLMy+bNc1rjZ2/3IgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4290EiJA22355724, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4290EiJA22355724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 Mar 2024 08:14:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 08:14:44 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 9 Mar
 2024 08:14:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless] wifi: rtw89: coex: fix configuration for shared antenna for 8922A
Date: Sat, 9 Mar 2024 08:13:48 +0800
Message-ID: <20240309001348.9906-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

WiFi 2x2 + BT combo cards can be two or three physical antenna. For two
antenna case, one antenna is shared by WiFi and BT, and different
configuration should be applied. Fix the typo.

This problem was found by Coccicheck, and actually that is a typo instead:
  drivers/net/wireless/realtek/rtw89/rtw8922a.c:2235:2-4:
    WARNING: possible condition with no effect (if == else)

Fixes: 652c9642eda6 ("wifi: rtw89: coex: add init_info H2C command format version 7")
Closes: https://lore.kernel.org/linux-wireless/170992024446.15593.2682606960737891240.git-patchwork-notify@kernel.org/T/#m074885bdbd91071c7d1771f08917831d9f89d95a
Cc: Ching-Te Ku <ku920601@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 367459bd1345..708132d5be2a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2233,7 +2233,7 @@ static void rtw8922a_btc_init_cfg(struct rtw89_dev *rtwdev)
 		 * Shared-Ant && BTG-path:WL mask(0x55f), others:WL THRU(0x5ff)
 		 */
 		if (btc->ant_type == BTC_ANT_SHARED && btc->btg_pos == path)
-			rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x5ff);
+			rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x55f);
 		else
 			rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x5ff);
 
-- 
2.25.1


