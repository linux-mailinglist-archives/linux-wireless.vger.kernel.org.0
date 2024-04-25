Return-Path: <linux-wireless+bounces-6836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4EC8B202F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0609A1F227DD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67A12A16C;
	Thu, 25 Apr 2024 11:28:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFE83CCD
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044537; cv=none; b=sy9OeWL/8WWSNwSfJOdwk0+mtX9RXsUm8+aDpuJiCUd//aFtnt262rm8di0dRwqhZXF0kn4kwEj39oxc+d+J6M0D79qszkwcYBqeEoee7zAyB356CKmi01pL5htiqBrRKDCA477TIjFVKM8avrfNmEeuoKPeNCb9LcwHlQ8MB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044537; c=relaxed/simple;
	bh=DuEpIJEjZuAvjoQEqq7CEIlmPAeM0uAxweGeMT5OzYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLdd4QkDAJla+bHNhZqsfs2YcBXt4Dp4Oc6oZYDtwJ50Y37BEy/PfP69LV7bpj5L9cjMv1v53g83harlG7VEnE4Nlr4n7l6IAybmih1r29GSDFQlruuf6ZwHfvQ9xA4V52ykw1AoJsxIduxu9OGUu1upDDvzhdmyPbZZ89m5j1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBSqC423482263, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBSqC423482263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:28:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:28:52 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:28:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 03/12] wifi: rtw89: wow: parsing Auth Key Management from associate request
Date: Thu, 25 Apr 2024 19:28:07 +0800
Message-ID: <20240425112816.26431-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
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

Need Auth Key Management(AKM) to let firmware to generate appropriate
EAPoL packet for GTK rekey. The AKM is present in the association request
RSN IE to indicate which cipher that station selected.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  3 +++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c  | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.h  | 17 +++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index dda69e8d114d..ce5126ed876e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -18,6 +18,7 @@
 #include "ser.h"
 #include "txrx.h"
 #include "util.h"
+#include "wow.h"
 
 static bool rtw89_disable_ps_mode;
 module_param_named(disable_ps_mode, rtw89_disable_ps_mode, bool, 0644);
@@ -254,6 +255,8 @@ static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
 				     struct sk_buff *skb, bool tx)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	if (tx && ieee80211_is_assoc_req(hdr->frame_control))
+		rtw89_wow_parse_akm(rtwdev, skb);
 
 	if (!ieee80211_is_data(hdr->frame_control))
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9da8be9927d3..834e19c533ae 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5161,6 +5161,7 @@ struct rtw89_wow_param {
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	u8 pattern_cnt;
+	u8 akm;
 };
 
 struct rtw89_mcc_limit {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index ea555f29442d..dcae75128c71 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -12,6 +12,21 @@
 #include "util.h"
 #include "wow.h"
 
+void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	const u8 *rsn, *ies = mgmt->u.assoc_req.variable;
+	struct rtw89_rsn_ie *rsn_ie;
+
+	rsn = cfg80211_find_ie(WLAN_EID_RSN, ies, skb->len);
+	if (!rsn)
+		return;
+
+	rsn_ie = (struct rtw89_rsn_ie *)rsn;
+	rtw_wow->akm = rsn_ie->akm_cipher_suite.type;
+}
+
 static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 {
 	__rtw89_leave_ps_mode(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index a2f7b2e3cdb4..1fbb112c4c1a 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -15,7 +15,24 @@ enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_NLO = 0x55,
 };
 
+struct rtw89_cipher_suite {
+	u8 oui[3];
+	u8 type;
+} __packed;
+
+struct rtw89_rsn_ie {
+	u8 tag_number;
+	u8 tag_length;
+	__le16 rsn_version;
+	struct rtw89_cipher_suite group_cipher_suite;
+	__le16 pairwise_cipher_suite_cnt;
+	struct rtw89_cipher_suite pairwise_cipher_suite;
+	__le16 akm_cipher_suite_cnt;
+	struct rtw89_cipher_suite akm_cipher_suite;
+} __packed;
+
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
+void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
 
 #endif
-- 
2.25.1


