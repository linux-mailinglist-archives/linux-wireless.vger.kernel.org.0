Return-Path: <linux-wireless+bounces-24138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72073ADAB7A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8C3188A424
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224DE2737F5;
	Mon, 16 Jun 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wWLH1Bnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71E2356BD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064824; cv=none; b=W8yzOrehKOswMi7N42F4Ljo5DH6c4P4QsZy8qMsNlgLucRYVxaxDxvQ39FjTI6TBXzvvuMBz3aNnum3Vp96BkjfFuRh8CIUkKSmM7eSCa2D7me0EiTF0bkKM3zsTLLCIMZSW515WWfSh+5SeE+ViaWT99h8Lpz6O562j4Pkwz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064824; c=relaxed/simple;
	bh=RS3NJl/Z+SauC1b3HxD9rtAgjJYW1ErpB+oBjNcfz6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+4ooadK3aAffJwz+bwG3bVaqmO03kSK5lHibMWhmwqwCkvWSPIAi0dh9qiefT97/h2I2UgRkG8kAMZA2aStHnr++4TpGEI7W6zilcd8pUZ/LqgUZOMd3ZwqzXkV4aB0lGcccBB2bo/I7JIIS6bnsAcl8Q07BY1mvEXXubq2Uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wWLH1Bnq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96xyK6178582, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064819; bh=MlohTZfMDuWip7QUecpbYcXNBbKNu260Zf4o4rtu3OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wWLH1BnqmIJK9KVdKj3aC26OM5BfMWTHP6gk6n5Lygc1W5Nbn6yJNbElD9mItmt4c
	 Yf/AkmaeNZQn7beWFs3SWozTmDkvar2/N1wcgA8UvrW+bf7guyyG51Wy/45ifJe6U/
	 D2m+ZOcNPFMR3ET3X0FqaohzrGAcsEXiPOAdO+DlpSocEc84hk3tcsGLInsRLDzSXs
	 V9KGwUR8yAMLSTKDLDOAHfdf5+KtDfDkVeEH0Lac6F7p1EnGdLjfwIqzGrR0wLJMLI
	 dsob1WWoefLz2Xuve8hZ+1OVrW51rgV4ilVAu88bqby2jFWwyfS+vuZ6sPK0yZgfY9
	 VXOQxM2eizARw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96xyK6178582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue
Date: Mon, 16 Jun 2025 17:02:49 +0800
Message-ID: <20250616090252.51098-9-pkshih@realtek.com>
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

If the duration set to zero, Wi-Fi firmware will trigger some unexpected
issue when firmware try to enable timer.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 138b3559a37b..60760512e93d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4125,13 +4125,13 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 
 		switch (policy_type) {
 		case BTC_CXP_OFFE_2GBWISOB: /* for normal-case */
-			_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_ISO);
+			_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_ISO);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_2GISOB: /* for bt no-link */
-			_slot_set(btc, CXST_E2G, 0, cxtbl[1], SLOT_ISO);
+			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_ISO);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_dur(btc, CXST_EBT, dur_2);
@@ -4157,15 +4157,15 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
 			if (a2dp->exist)
-				_slot_set(btc, CXST_E2G, 0, cxtbl[2], SLOT_MIX);
+				_slot_set(btc, CXST_E2G, 5, cxtbl[2], SLOT_MIX);
 			else
-				_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_MIX);
+				_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
-			_slot_set(btc, CXST_E2G, 0, cxtbl[1], SLOT_MIX);
-			_slot_set(btc, CXST_EBT, 0, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_EBT, 5, cxtbl[1], SLOT_MIX);
 			break;
 		default:
 			break;
-- 
2.25.1


