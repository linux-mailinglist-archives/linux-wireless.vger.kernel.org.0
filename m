Return-Path: <linux-wireless+bounces-30068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06467CD7F1C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BFA3080B42
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF42C3244;
	Tue, 23 Dec 2025 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qiCi3gj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B712C3252
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459291; cv=none; b=jcCRJqdIdCaW59taJEgT42nO5PjSi6vrMYiEhuwNoey+fTfXY5+5pWktwxub0EWZcvFUDMe5GCQC2NyVZR8h7IfEY1pH7np/c47ZNrJ+0L2G+Z7uKpvPjfqaaFm9pD+3B3xd7zwbpj9ENmxoUp8AGU9Bj55JzyhyejzhJbFgJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459291; c=relaxed/simple;
	bh=aOa8nd/i7jBp9IhYpLvQv6M+pCIcGFVAWUbTJ7/FqKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcXvOQSUIlltcVZrpt/MBAWKsBBNW2JdjO43s09BT7kK9jqWxSnH26blZOjAZkQ+ukgy+X4twaBdSvwBFJwok1Hxn+7zwMz1Q0sBVv03VHoV3oR0paFvKabPImsvGk6LMuuUcAQfShecbMs6kVltC7VZ0p0f3h3/XYGFim1UtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qiCi3gj5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN387IB0571301, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459287; bh=tMPw49I817dPQa6juiWlGw3C3EmXRjZuygZ2Ulj+0Jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qiCi3gj5VYYwHrF4oU8QtktLP1iSLvCSj8Q0b/ahyuY/4Cz6FyYWkJZ3iJxMqnF4n
	 GtXJO8QODmG8vf/TThgyODeB/iPZoNxh4eUlYlnosNpaBsVdhAsoDJEoTM136Bb9TR
	 EWjHQwXt72fUL3hN79tba0sDzA/BVvZSYd5Ayi2duYC7egk9itRXTulVb6tHjMm/So
	 KmfIUwqvvk/9gPHZkBwNgva0Xs6G7dB234Bg/Uto9E+r/rQc9M4WKEhqxU2SZihlZj
	 TQx2ZSdfZrVHEgCOFy2shm4zaMRY7Sn5RSRPYFgDGx0XyhV3Q1g6c8UBGrUFAe/qw2
	 WbJELa/H1JfwA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN387IB0571301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:08:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:08:07 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:08:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:08:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 11/12] wifi: rtw89: setting TBTT AGG number when mac port initialization
Date: Tue, 23 Dec 2025 11:06:50 +0800
Message-ID: <20251223030651.480633-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

When initializing mac port, needs to set TBTT AGG number to trigger TBTT
related interrupts. Otherwise, after sending join info H2C command with
disconnection mode, firmware will clear TBTT AGG number. Without the
setting from mac port initialization after that, this port will not be
able to transmit beacons.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7cbe3ffd5dc8..fae0527e50e8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4382,6 +4382,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev,
 #define BCN_HOLD_DEF 200
 #define BCN_MASK_DEF 0
 #define TBTT_ERLY_DEF 5
+#define TBTT_AGG_DEF 1
 #define BCN_SET_UNIT 32
 #define BCN_ERLY_SET_DLY (10 * 2)
 
@@ -4685,6 +4686,16 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_agg(struct rtw89_dev *rtwdev,
+					struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_agg,
+				B_AX_TBTT_AGG_NUM_MASK, TBTT_AGG_DEF);
+}
+
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif_link *rtwvif_link)
 {
@@ -4945,6 +4956,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_tbtt_agg(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
-- 
2.25.1


