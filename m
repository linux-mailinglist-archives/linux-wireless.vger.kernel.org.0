Return-Path: <linux-wireless+bounces-22431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCBAA8CF0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A98170F8B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AAB1DB13E;
	Mon,  5 May 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fsRPQxLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1391C8621
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429902; cv=none; b=YQzyjnr378xX6DRy6Da5NpnOpZZf39MGDDFe0goSqa6zcI1h0cWCkoeP1YMIKnGP5lOa8K1b8bTJGeg26pa0ZVA4oZ+b4/39HW02JTmfdK7r4Teksiyj9EPCopVj1QK5iqYjJ+ECrzB1KIowwgRnXH60zXUZzL6xXtFZ1pT/Cj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429902; c=relaxed/simple;
	bh=xiF5yfsvnXPovu1YkkvDPYochND5V/nk3HmG8cNk4uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nc5T6tSBS7CmDhmruEWwZdOlY0gLZDZCQep309K7PmBEtMP88HUUeZCnuIVN3YtnfLWn/EdQTuiqd5ve6wmxvqqi6wiZE5GyMHxK18T50jEbHdTT1Y4T30lbPD0eAaKaid+QImrCtxEzulzBdP1qMUTPTwKnIQ2DwyjjmMtdAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fsRPQxLa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457OtKJ23831118, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429895; bh=xiF5yfsvnXPovu1YkkvDPYochND5V/nk3HmG8cNk4uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fsRPQxLalkxN4HkoAYVD6R9KCb+nWDVOYJuRAgmx5lA1OTjRny6U8vqZx86LDsLae
	 ANGomOIxqW2HVPOXJbhlrH5/wSssV94av7R9o0zOndo3vS5AWAb2NQePg4uVeRPNSf
	 uKfA+lOI44CVYlGw7Rnf9CWubCoH1n1Om+J1sRkUUDtB378K67HN3kbqdrD9AfzoSU
	 NcaTRpyg5I948HDz0B/BRf3iG8p/W9DcQtp+bePnVgke5IOVNFYh1zL3yKl1e8K0VG
	 fO9gaf8fhIvPzOZRR7VZGoHJR+Oq/06LKHuO0vnzbzpcBTu3UpaysqriTHSNo/VD/M
	 dTX/GAsLSA/XA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457OtKJ23831118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:24:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:24:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:24:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: extract link part from core tx write function
Date: Mon, 5 May 2025 15:24:30 +0800
Message-ID: <20250505072440.45113-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

Extract core_tx_write_link from core_tx_write to accept given links as
parameters. To make the follow-up changes of TX description more clear,
tweak SW functions to split things ahead.

(don't change logic at all)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 58 ++++++++++++++---------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e681e8abc20d..0fd902eef05b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1123,32 +1123,17 @@ int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
+static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
+				    struct rtw89_vif_link *rtwvif_link,
+				    struct rtw89_sta_link *rtwsta_link,
+				    struct sk_buff *skb, int *qsel)
 {
-	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
-	struct rtw89_core_tx_request tx_req = {0};
-	struct rtw89_sta_link *rtwsta_link = NULL;
-	struct rtw89_vif_link *rtwvif_link;
+	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
+	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_core_tx_request tx_req = {};
 	int ret;
 
-	if (rtwsta) {
-		rtwsta_link = rtw89_get_designated_link(rtwsta);
-		if (unlikely(!rtwsta_link)) {
-			rtw89_err(rtwdev, "tx: find no sta designated link\n");
-			return -ENOLINK;
-		}
-
-		rtwvif_link = rtwsta_link->rtwvif_link;
-	} else {
-		rtwvif_link = rtw89_get_designated_link(rtwvif);
-		if (unlikely(!rtwvif_link)) {
-			rtw89_err(rtwdev, "tx: find no vif designated link\n");
-			return -ENOLINK;
-		}
-	}
-
 	tx_req.skb = skb;
 	tx_req.vif = vif;
 	tx_req.sta = sta;
@@ -1172,6 +1157,33 @@ int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	return 0;
 }
 
+int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel)
+{
+	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
+	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_sta_link *rtwsta_link = NULL;
+	struct rtw89_vif_link *rtwvif_link;
+
+	if (rtwsta) {
+		rtwsta_link = rtw89_get_designated_link(rtwsta);
+		if (unlikely(!rtwsta_link)) {
+			rtw89_err(rtwdev, "tx: find no sta designated link\n");
+			return -ENOLINK;
+		}
+
+		rtwvif_link = rtwsta_link->rtwvif_link;
+	} else {
+		rtwvif_link = rtw89_get_designated_link(rtwvif);
+		if (unlikely(!rtwvif_link)) {
+			rtw89_err(rtwdev, "tx: find no vif designated link\n");
+			return -ENOLINK;
+		}
+	}
+
+	return rtw89_core_tx_write_link(rtwdev, rtwvif_link, rtwsta_link, skb, qsel);
+}
+
 static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY0_WP_OFFSET, desc_info->wp_offset) |
-- 
2.25.1


