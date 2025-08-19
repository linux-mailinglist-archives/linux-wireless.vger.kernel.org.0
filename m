Return-Path: <linux-wireless+bounces-26447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E15B2B7E9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 05:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D049F175B23
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46F23741;
	Tue, 19 Aug 2025 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MUs0Lock"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BE2AD3E
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575149; cv=none; b=BQ5zBDVxm3dDOMOjcCafEdQf2HQcml4gESJRc8H0toAMoA+YOoJV17BECAoQDHG94uYr3OkFdBJLdZrpT8d01o3uCcJ0BS5USqCTXNl1WvDt6nlXjrqD/pUdbyA7Hee/9CJ30/WrH1vRrFlyUZ4iPE3maazGvHTK/ShU8fUFDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575149; c=relaxed/simple;
	bh=mcI05iVILUNbfm+DKgfhnO5cQwChC9MH0Fm9CwczqMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho1UZs2bAbk2A+R41Pj5nVIdj+aHd3oJHF4wqyJ1jIGTMHDbtfdt+IInr2hDKhadcU1Yk+vCrTc7VMazh/z/ASZWgkAictzS4/lLEe2/c/rqJ9hwADe6/ZoOcx7erdmHGmB2wng7WZvlgMr+/W+ILHF7r6Lw1fLcoHwMgdwXvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MUs0Lock; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J3jjtlF2064834, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755575145; bh=ABxQDROgB7WkDjwEihmw/Vj64RHx7Gwyh3Dqn+/SZmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MUs0Locki3i0a8oQy5HhNnMFxz7lcaow90r5jeps1+vH6yOgflEVv9th9HGKIUD2H
	 EJUf+AO5Rhl0yMqqG/CDAY5ZIqK/Ov82bXaQhxXd3J5GDGZJ6gH0QW0AFzmcGzg9nJ
	 FC21fNnduFJm/zZ0tHkzNZcKrEA8gqhNbr/b4mOTCleui3DcyI9V7CiujDmkDAMlj0
	 rwGfdxHQBleShfeaW1cyuIJbcCBHrY2jjTJjg4nAiHQNH+++/m4ztbXXzA+S1kYl6F
	 m2M2v0VUeWeOxYbcA0Ju1iGtvAjITZp585fCR9LMn07ZXsUD5mC/8RdRiwyxip9uLc
	 bKqsj9Or4lz8Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J3jjtlF2064834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:45:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 11:45:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 11:45:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 4/4] wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch
Date: Tue, 19 Aug 2025 11:44:28 +0800
Message-ID: <20250819034428.26307-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250819034428.26307-1-pkshih@realtek.com>
References: <20250819034428.26307-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Ching-Te Ku <ku920601@realtek.com>

When Wi-Fi is scanning at 2.4GHz, PTA will abort almost all the BT request.
Once the Wi-Fi slot stay too long, BT audio device can not get enough data,
audio glitch will happened. This patch limit 2.4Ghz Wi-Fi slot to 80ms
while Wi-Fi is scanning to avoid audio glitch.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e4e6daf51a1b..0f7ae572ef91 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -93,7 +93,7 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_E2G]	= __DEF_FBTC_SLOT(5,   0xea5a5a5a, SLOT_MIX),
 	[CXST_E5G]	= __DEF_FBTC_SLOT(5,   0xffffffff, SLOT_ISO),
 	[CXST_EBT]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
-	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0xaaaaaaaa, SLOT_ISO),
+	[CXST_ENULL]	= __DEF_FBTC_SLOT(5,   0x55555555, SLOT_MIX),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
 	[CXST_B1FDD]	= __DEF_FBTC_SLOT(50,  0xffffdfff, SLOT_ISO),
@@ -4153,6 +4153,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_DEF2:
 			_slot_set(btc, CXST_E2G, 20, cxtbl[1], SLOT_ISO);
@@ -4162,6 +4163,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
 			if (a2dp->exist)
@@ -4170,6 +4172,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, cpu_to_le16(40),
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
 			_slot_set(btc, CXST_E2G, 5, cxtbl[1], SLOT_MIX);
-- 
2.25.1


