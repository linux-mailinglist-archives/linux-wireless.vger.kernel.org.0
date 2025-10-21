Return-Path: <linux-wireless+bounces-28142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95070BF6CD0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F019A5F70
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C42DC353;
	Tue, 21 Oct 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OoPw/OVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6123F26A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053667; cv=none; b=aeRtLU86MZ8L/1Bjp5NJzQN1dBt2eT1h/sBqx36AdtytljE50pftKD/F5buk63NlzHzCiG7181v3SIeOE51U4aAci3ggkJdR0jXRf1+0OLZoYO0E9TTTcVsPpxDaZBWNuKv2LxPJ5anlmeMLgBmcAKzfFD7o3rP3vJ7H5wybamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053667; c=relaxed/simple;
	bh=P1CY97wfVdHI1PkkcHT2A2eaOrMKzEZ0S9t763RjlIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YABgx9MsEfIE6hZxswTlEZWZ1WcAizKdnDVfLcT0Q3KEnsTeIFYK+4OZvyxly59c4iW/PKl7ssGSy/SY5lmre0ws4oag45qTTSlpvH170bMTuEF+PPUPXdMdu06UkOpyKlF1R4g3GmGBm7fvZ8/eAIoza3yII2l2LRNqPUeoBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OoPw/OVe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYK6h83088095, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053660; bh=m7BtEqewQ+8fp8jC0snEmFsHp2W3RGFutvWZ+TSrLyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OoPw/OVeuylHKMQC92Dk4Vric0hgquw/4fuVBqhDYHdb49JE8PbJ66Q0w9qg6BogH
	 0UwJ9rkNveRS4B/q6P65TaNhkmxL3i97ed12pLUl9BtBoYUScwEt8+12IkSohoDWMs
	 4jKK6ccbCwYtSMZQB9j1W8WzOm1rSgTDg5Kr4NPr8JTqhhNFVOmNR8vkcS5rJUBHFF
	 UZ0yv/Pgk+nnhqwrXQCGyk0jlz9LJH1fGPiU9YqR5gQd/fdCC855pYu/46b6JJ+0G8
	 seNnyx02lnanCvZ+pKnNgk6MwwRGDVgsmmFU3UZazrnOd/mA4FwRSuamYMY/QGulUQ
	 m1Q1Ylceyk5DQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYK6h83088095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:20 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:19 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 2/8] wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent racing
Date: Tue, 21 Oct 2025 21:33:56 +0800
Message-ID: <20251021133402.15467-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

TX task can enqueue ROC skb, but other tasks dequeue the skb. Using
skb_queue_walk_safe() without locking will cause potential racing.
Use skb_dequeue() with lock instead.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 917b2adede61..8b40cada4149 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3632,12 +3632,10 @@ void rtw89_core_free_sta_pending_roc_tx(struct rtw89_dev *rtwdev,
 					struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
-	struct sk_buff *skb, *tmp;
+	struct sk_buff *skb;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
+	while ((skb = skb_dequeue(&rtwsta->roc_queue)))
 		dev_kfree_skb_any(skb);
-	}
 }
 
 static void rtw89_core_stop_tx_ba_session(struct rtw89_dev *rtwdev,
@@ -3881,8 +3879,8 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_vif_link *target = data;
 	struct rtw89_vif_link *rtwvif_link;
-	struct sk_buff *skb, *tmp;
 	unsigned int link_id;
+	struct sk_buff *skb;
 	int qsel, ret;
 
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
@@ -3895,9 +3893,7 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	if (skb_queue_len(&rtwsta->roc_queue) == 0)
 		return;
 
-	skb_queue_walk_safe(&rtwsta->roc_queue, skb, tmp) {
-		skb_unlink(skb, &rtwsta->roc_queue);
-
+	while ((skb = skb_dequeue(&rtwsta->roc_queue))) {
 		ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
 		if (ret) {
 			rtw89_warn(rtwdev, "pending tx failed with %d\n", ret);
-- 
2.25.1


