Return-Path: <linux-wireless+bounces-11953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04E95ECA1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D362810E4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30713DDB6;
	Mon, 26 Aug 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LSUZOhef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763B7404B
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663100; cv=none; b=NwpgsSV6lSOrulmy4Wq28IKc/Ai5Zj/DFreNJ+NlQyULvBI96L48Ivn9sKXZSkhf1i6N3BX2BwD/xcuIpdfmADXQi9jZ+IdTm4nBrxnzqzMk4HZ/G2Yi0wcucBNEEh4yS6SgQ9iInhkURLJLkLh4QcAQOdmu5LRnUv0GHp8LebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663100; c=relaxed/simple;
	bh=gbdRIBBaVar0XNJiGceeWHFABnY+Yuhi3pM4GqZvq7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJi2vbxVXeo38mzMPnv1BPDK1ciNDQA7Yvw/F5ceQpJ/jNfSnPDLVfHbiL2392k0W6blUDKhMVXYD85eXEPTRNbtq7W98X9QC0X3QEuBvnOtWVad3M8/otKMAWqW8zhGSbn8Ov55Out5SwaKBCMMIyAnjiST4ZCSGG1n1Pw0UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LSUZOhef; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q94sDE23828658, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663094; bh=gbdRIBBaVar0XNJiGceeWHFABnY+Yuhi3pM4GqZvq7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LSUZOhefRgvX+gf5/CtV2Mh59UEwfACzqM5EwAbeLHiViz2fnucjPSjbl/Y/r4jQ4
	 k0dKc1Xy/plvu3elZhKONGacrme2EjReXTSaHuZeo1sa9N6EiG29YEHCgUXGrsw0IE
	 I69OLFhVcR48v/zSPii53lY1O71HL8q8ye7hF9pLsq6XDjEUZ2pP11yvsdjmuVuGZP
	 VHMZDp47z8EkDNGl9GJeP/imSbieonkXVtLycFvGOQZnyhtwSQeZEljSZRfIYZXFAi
	 V8BIRRQPr6eM4+T40bYVQqxX5iiZXqHWh2RIHgCVj/mmJLNComTUHNBky/FZSYY8Bd
	 mrxnz64ODxTbw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q94sDE23828658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:04:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:04:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Aug
 2024 17:04:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: wow: fix wait condition for AOAC report request
Date: Mon, 26 Aug 2024 17:04:36 +0800
Message-ID: <20240826090439.17242-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826090439.17242-1-pkshih@realtek.com>
References: <20240826090439.17242-1-pkshih@realtek.com>
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

Each condition binding to the same wait should be unique. AOAC code misused
the wait of FW offload series and broke the above rule. It added another
macro to generate wait condition of WoWLAN/AOAC, but the results conflict
to the ones of FW offload series. It means that we might be completed
wrongly in logic. We don't want things work/read like this and should
have avoided this.

Fix this by adding another wait which aims for WoWLAN functions.

Fixes: ff53fce5c78b ("wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 drivers/net/wireless/realtek/rtw89/fw.c   | 6 ++----
 drivers/net/wireless/realtek/rtw89/fw.h   | 7 +++++--
 drivers/net/wireless/realtek/rtw89/mac.c  | 6 ++----
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 885c759e694a..df34f613c736 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4315,6 +4315,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 
 	rtw89_init_wait(&rtwdev->mcc.wait);
 	rtw89_init_wait(&rtwdev->mac.fw_ofld_wait);
+	rtw89_init_wait(&rtwdev->wow.wait);
 
 	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0410f6d4bb65..a9c91f794139 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5365,6 +5365,9 @@ struct rtw89_wow_param {
 	u8 ptk_keyidx;
 	u8 akm;
 
+	/* see RTW89_WOW_WAIT_COND series for wait condition */
+	struct rtw89_wait_info wait;
+
 	bool pno_inited;
 	struct list_head pno_pkt_list;
 	struct cfg80211_sched_scan_request *nd_config;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 06b263550ef0..2638003e9f6e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7215,11 +7215,10 @@ int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_wait_info *wait = &rtwdev->wow.wait;
 	struct rtw89_h2c_wow_aoac *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
-	unsigned int cond;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -7238,8 +7237,7 @@ int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev)
 			      H2C_FUNC_AOAC_REPORT_REQ, 1, 0,
 			      len);
 
-	cond = RTW89_WOW_WAIT_COND(H2C_FUNC_AOAC_REPORT_REQ);
-	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, RTW89_WOW_WAIT_COND_AOAC);
 }
 
 /* Return < 0, if failures happen during waiting for the condition.
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cb0ecb9b4c11..147358772560 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4015,8 +4015,11 @@ enum rtw89_wow_h2c_func {
 	NUM_OF_RTW89_WOW_H2C_FUNC,
 };
 
-#define RTW89_WOW_WAIT_COND(func) \
-	(NUM_OF_RTW89_WOW_H2C_FUNC + (func))
+#define RTW89_WOW_WAIT_COND(tag, func) \
+	((tag) * NUM_OF_RTW89_WOW_H2C_FUNC + (func))
+
+#define RTW89_WOW_WAIT_COND_AOAC \
+	RTW89_WOW_WAIT_COND(0 /* don't care */, H2C_FUNC_AOAC_REPORT_REQ)
 
 /* CLASS 2 - PS */
 #define H2C_CL_MAC_PS			0x2
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a661c176100c..f336362ad45e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5165,11 +5165,10 @@ rtw89_mac_c2h_wow_aoac_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 le
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
-	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_wait_info *wait = &rtw_wow->wait;
 	const struct rtw89_c2h_wow_aoac_report *c2h =
 		(const struct rtw89_c2h_wow_aoac_report *)skb->data;
 	struct rtw89_completion_data data = {};
-	unsigned int cond;
 
 	aoac_rpt->rpt_ver = c2h->rpt_ver;
 	aoac_rpt->sec_type = c2h->sec_type;
@@ -5187,8 +5186,7 @@ rtw89_mac_c2h_wow_aoac_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb, u32 le
 	aoac_rpt->igtk_ipn = le64_to_cpu(c2h->igtk_ipn);
 	memcpy(aoac_rpt->igtk, c2h->igtk, sizeof(aoac_rpt->igtk));
 
-	cond = RTW89_WOW_WAIT_COND(H2C_FUNC_AOAC_REPORT_REQ);
-	rtw89_complete_cond(wait, cond, &data);
+	rtw89_complete_cond(wait, RTW89_WOW_WAIT_COND_AOAC, &data);
 }
 
 static void
-- 
2.25.1


