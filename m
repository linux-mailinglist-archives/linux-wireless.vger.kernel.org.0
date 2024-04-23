Return-Path: <linux-wireless+bounces-6728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57418AE759
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E41F23293
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408C78C6E;
	Tue, 23 Apr 2024 13:05:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31B85938
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877552; cv=none; b=kHVa07QU5z8i4BDMVSyK5xynzhYhNw0HbPtQXJml/rj0nL5uJHcLnk+Rw4MF+atUdnVQVsCk0o4C4CszdO1mcJLQaXOhbAgG263KUc71PGf1HJUefuk+/cmsURhE1yAkv4w/l/xUEWEiYtGhkEXGb/YhO/OjDcLz4GpBvBLDgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877552; c=relaxed/simple;
	bh=CkEsrOWvm+qrfwExkJqZTsqBpvAMNhwM0w8u3OWC2us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyrGzSYmSVnKD/ftV7wpj5rfEVeszVwSmUtwJyj/0juVlQek87dkUuPiUN/ko3GbRjhzZC6tH4Vu1jXH1KkEPuEepJkROFo7V6uyxeoctRQaE9++5XnRACsFp1LoK6B2xXnLcWv06TFGxVE86skS9x+4t86LiMXkjldBbBP1Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5lYvA1251196, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5lYvA1251196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:48 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 5/8] wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
Date: Tue, 23 Apr 2024 21:04:59 +0800
Message-ID: <20240423130502.32682-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

It will assign wrong value to version 7 slot parameter setting, because
the structure member order has changed. Add a for-loop to assign variables
manually.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 15e04440888d..374bc5aad2e8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -827,8 +827,20 @@ static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
 		/* set the slot_now table to original */
 		btc->dm.tdma_now = t_def[CXTD_OFF];
 		btc->dm.tdma = t_def[CXTD_OFF];
-		memcpy(&btc->dm.slot_now, s_def, sizeof(btc->dm.slot_now));
-		memcpy(&btc->dm.slot, s_def, sizeof(btc->dm.slot));
+		if (ver->fcxslots >= 7) {
+			for (i = 0; i < ARRAY_SIZE(s_def); i++) {
+				btc->dm.slot.v7[i].dur = s_def[i].dur;
+				btc->dm.slot.v7[i].cxtype = s_def[i].cxtype;
+				btc->dm.slot.v7[i].cxtbl = s_def[i].cxtbl;
+			}
+			memcpy(&btc->dm.slot_now.v7, &btc->dm.slot.v7,
+			       sizeof(btc->dm.slot_now.v7));
+		} else {
+			memcpy(&btc->dm.slot_now.v1, s_def,
+			       sizeof(btc->dm.slot_now.v1));
+			memcpy(&btc->dm.slot.v1, s_def,
+			       sizeof(btc->dm.slot.v1));
+		}
 
 		btc->policy_len = 0;
 		btc->bt_req_len = 0;
@@ -2319,7 +2331,7 @@ static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev)
 
 		tlv_v7->type = SET_SLOT_TABLE;
 		tlv_v7->ver = ver->fcxslots;
-		tlv_v7->len = sizeof(dm->slot.v7);
+		tlv_v7->len = ARRAY_SIZE(dm->slot.v7);
 		memcpy(tlv_v7->val, dm->slot.v7, sizeof(dm->slot.v7));
 
 		_send_fw_cmd(rtwdev, BTFC_SET, SET_SLOT_TABLE, (u8 *)tlv_v7, len);
-- 
2.25.1


