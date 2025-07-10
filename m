Return-Path: <linux-wireless+bounces-25152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C322AFF800
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150AD3AFAE0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308EB2F3E;
	Thu, 10 Jul 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xicm0Usn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D24280A3B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121501; cv=none; b=lzKr2XaJ3cahLXas8BgUXSBygRduhQAwR8lQkXN/7s46Cb1abOw5GgKwXfpVWkxVEmLqUe283RMcUc/+EQXCT9EcT9IWVdOPEG0lLCxeGOHPmrgRdM0JjHim+fGCSzpjBdhPdDrFXc5SEa0aUfM1KYgWDocOIDRJMrQ92IkbQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121501; c=relaxed/simple;
	bh=5g6mkTl4nDU/0rk9jy8rvuXhBzgcWMAxh2GlTBNHCNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVIaBmmpOOI2QtOA0X648ReYVvheJCqIaZKonRB1FkrLmIczpoBNib4S/Wbx5U71y0xB2ZGOHp37Vgksp5e0MW4ImjgrqWISjR6hwSLNvQiHrX8I1TiY5I4eAKz8fiAqPpP/L93a81001kL/Nma9fJwLrT/hTPcr1ZNSgr8qpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xicm0Usn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4OvFhA2455776, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121497; bh=BR4Vky5eYUjWfzmloQRtTCwR2nD7aloDw3D6dPJz+5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Xicm0UsnrWTfb37G240Huve/VjkctnC1NlzOPZq4KrlzViGptSBXBUe2/u79Vj1QU
	 6v5WM4m1U87vbQ7nMzLw0PdftguaHFKzfhPk9jmbx77YO3sP9Tloa8m+7ZdslO5WFa
	 l4SonizYViJ2UyQ58ebhXcnM/0BRWIwBv7wG5arv6JLIQZmJAbuwgU1p2Kuni9A3Ea
	 JdFf5JfGuuZx6LxIKi4KOICp0h1XkCka5tvUNUUTqj+lRJaE5D5Byta+ePROsiTHCE
	 rxflk92s+Iz7HxhrRt/8Po1j+v1idbrznu3JbmtrPAMmdesHLRiK8oDYcfZICLCNvm
	 raSw6OgzVe5Qg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4OvFhA2455776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:24:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:24:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:24:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/14] wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching time
Date: Thu, 10 Jul 2025 12:24:12 +0800
Message-ID: <20250710042423.73617-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

MCC require time to switch channel when changing timeslot. If GC TX
nulldata 0 while GO is switching channel, GO can't receive it. Therefore,
enlarge the GO NoA duration to cover the channel switching time.

However, the enlarged NoA duration might cause GC's timeslot less than
minimum of RX beacon time. Therefore, adjust strict and anchor pattern
condition to avoid it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 7 ++++---
 drivers/net/wireless/realtek/rtw89/chan.h | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 1277b1af2a4c..e5ef4f6ab5ca 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1116,7 +1116,7 @@ static int __rtw89_mcc_calc_pattern_strict(struct rtw89_dev *rtwdev,
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
 	struct rtw89_mcc_role *aux = &mcc->role_aux;
 	struct rtw89_mcc_config *config = &mcc->config;
-	u16 min_tob = RTW89_MCC_EARLY_RX_BCN_TIME;
+	u16 min_tob = RTW89_MCC_EARLY_RX_BCN_TIME + RTW89_MCC_SWITCH_CH_TIME;
 	u16 min_toa = RTW89_MCC_MIN_RX_BCN_TIME;
 	u16 bcn_ofst = config->beacon_offset;
 	s16 upper_toa_ref, lower_toa_ref;
@@ -1272,11 +1272,11 @@ static int __rtw89_mcc_calc_pattern_anchor(struct rtw89_dev *rtwdev,
 	u16 bcn_ofst = config->beacon_offset;
 	bool small_bcn_ofst;
 
-	if (bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
+	if (bcn_ofst < RTW89_MCC_MIN_RX_BCN_WITH_SWITCH_CH_TIME)
 		small_bcn_ofst = true;
 	else if (bcn_ofst < aux->duration - aux->limit.max_toa)
 		small_bcn_ofst = true;
-	else if (mcc_intvl - bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
+	else if (mcc_intvl - bcn_ofst < RTW89_MCC_MIN_RX_BCN_WITH_SWITCH_CH_TIME)
 		small_bcn_ofst = false;
 	else
 		return -EPERM;
@@ -2171,6 +2171,7 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 	rtw89_p2p_noa_renew(rtwvif_go);
 
 	if (enable) {
+		duration += RTW89_MCC_SWITCH_CH_TIME;
 		noa_desc.start_time = cpu_to_le32(start_time);
 		noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(interval));
 		noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(duration));
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 0e2ffb920455..9a62b7c98b83 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -18,6 +18,7 @@
 #define RTW89_MCC_EARLY_RX_BCN_TIME 5
 #define RTW89_MCC_MIN_RX_BCN_TIME 10
 #define RTW89_MCC_DFLT_BCN_OFST_TIME 40
+#define RTW89_MCC_SWITCH_CH_TIME 3
 
 #define RTW89_MCC_PROBE_TIMEOUT 100
 #define RTW89_MCC_PROBE_MAX_TRIES 3
@@ -28,6 +29,9 @@
 #define RTW89_MCC_MIN_STA_DURATION \
 	(RTW89_MCC_EARLY_RX_BCN_TIME + RTW89_MCC_MIN_RX_BCN_TIME)
 
+#define RTW89_MCC_MIN_RX_BCN_WITH_SWITCH_CH_TIME \
+	(RTW89_MCC_MIN_RX_BCN_TIME + RTW89_MCC_SWITCH_CH_TIME)
+
 #define RTW89_MCC_DFLT_GROUP 0
 #define RTW89_MCC_NEXT_GROUP(cur) (((cur) + 1) % 4)
 
-- 
2.25.1


