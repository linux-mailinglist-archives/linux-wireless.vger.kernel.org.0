Return-Path: <linux-wireless+bounces-24136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F2ADAB79
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B127F3A8C98
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1D19D06A;
	Mon, 16 Jun 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sfpJecuy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E551A7253
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064823; cv=none; b=mnztG49uHqcgSoarWCKGYkCM2UjtmLYnb1V2Liy22xb4OwwxWSMK87G6MOmHW5QDZBJ0S1UewSsKXxvhnQJ5OMedW9QjnaFKAW0hPiKYO3J72s1S39Xurg+u0t7/88/lpNwdfYLTQDOuUWty4haeWhoW+85qpWC0Sia6j7rlv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064823; c=relaxed/simple;
	bh=BuO2zgrDrng6VMJhVLjbMwNngJ34zWOgh3ZgWgY3cb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEZVhlTfqSkwLLEgqF6H8U49W5V/RjWPaS2ZOOIJpoO8B9aC+vW9SF5E+0Hjoh8L8dIr5xgJJpmzgMcGFLG1dJsSgGvzMk0tOnHBhcLt/iiUJdFPeVlo42vunJWUjEtmlNUDkPO75VPNkWOdLLuvrpcxlPkHZkgW2S8YVCK41/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sfpJecuy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96xyH6178582, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064819; bh=Lc5XrtI1rK+v8x/ThKMCfBHrCBufH7SBaExsNB6OxOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sfpJecuyiKpJ9K2jaMrfZ2nwU7swdr6miYRqtyPZ+RqCoZOeuJdaUPtEO1hDT1rw0
	 qmS1r5ST2SVPnkP0zOnSchez/DVTa6Dqj2JTWe9GqQ6spXiG4Wgoq/Y/zti9bCOE9F
	 +ZJDwr+Jmh9xv7HWZpVHgKn+oKl4Ybq4kyEXPbQA7rsm0YWkJmD4UlmNcKJTCNDeSR
	 3N3HfymPKic38o0i8O046opxQSHUSXLwwS5MaKbZH5NtO2OTjDwUQElqjNVSTqap9v
	 tQ/OFkF7K8PswCxN5BnjsD71otp0Zu+XPWIBGAwBemK2ffEadSTdaguUnmCqDf+kxv
	 SDT9d8l9pUjpg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96xyH6178582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: coex: Assign priority table before entering power save
Date: Mon, 16 Jun 2025 17:02:48 +0800
Message-ID: <20250616090252.51098-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
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

When Wi-Fi firmware scan, it will update the priority tables, and if
stay at these priority tables then enter power saving will trigger
Bluetooth issues. So update the priority before entering power saving.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 399c86288d76..138b3559a37b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3996,6 +3996,15 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	u32 tbl_w1, tbl_b1, tbl_b4;
 	u16 dur_2;
 
+	if (wl->status.map.lps) {
+		_slot_set_le(btc, CXST_E2G, s_def[CXST_E2G].dur,
+			     s_def[CXST_E2G].cxtbl, s_def[CXST_E2G].cxtype);
+		_slot_set_le(btc, CXST_E5G, s_def[CXST_E5G].dur,
+			     s_def[CXST_E5G].cxtbl, s_def[CXST_E5G].cxtype);
+		_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+			     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+	}
+
 	type = FIELD_GET(BTC_CXP_MASK, policy_type);
 
 	if (btc->ant_type == BTC_ANT_SHARED) {
-- 
2.25.1


