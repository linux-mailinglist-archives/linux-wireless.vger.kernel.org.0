Return-Path: <linux-wireless+bounces-29374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AABFC8D5A5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 09:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA5E74E3B1E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3322609DC;
	Thu, 27 Nov 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EqPlyIxj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA392356A4
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232369; cv=none; b=bWRnyfg+kc/Sr9Pnlv66N2+K2kYbW80Lc7ZtqXtQouTC2i3WYxt6ie7nZsb2JsUXBgWuzs/2HA9L3HRpVSpfm24Y0B6uyW2fs4HAQ+gBG1o5TrPFjEaHSxsVlmjfN+HZ5Jhwvm7xTmL5+ueEosC0KAC6bv/elZ20A+sxO9zC5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232369; c=relaxed/simple;
	bh=qMTGkEdWXpv5Wxu6+ZBc0b6IRWfINNxZwrQEwkZEPGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpfokGZPI2j5m4cHSRWHyoy1utFO1//S3KKZmB921r2vVhhTtSuBj1NVpdRTrYWhULyzU50FnjtFI7tHpMUwfJqZg8NB+YNNJl+NyVb2uiNBUPoIkQhikk8m59fxiuVxbHJug76IlMIGjfHCr/V4yWFVHtOGBOHlw5Fng/jVXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EqPlyIxj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AR8WheN62529243, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764232363; bh=OKbs8KJgS4PybFK7fBdbHfwJRMxX5OGlhqzCA2Ea73w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EqPlyIxjqipekbIY7d2xgiy3JjOzOqk35XcRhOq0yMebgW8jZT6fAdTxbFUqAZa41
	 J4jG6t5oMLxtOPS4Vy/ppxFuHddayCfj5X72mNKfCXA2H2FjYs/si1jDBWQPDgthq6
	 X4U6040vGvnH10XRjlNaTKVKpGAWHfzjsGBSrgDDUlwuLWAoJiKNfjN2XDpCD2a7XQ
	 9Xe/3TmUMejTobZiizYjdxoG5Yj+G2LIzyxj7nlS+VzUBWxKCidMVOTqEbTonz34+v
	 8TIcfrvV+lm7AjO4/WaG7V4lTmijYWDFjaWQN/0JKQ1JJUZrBU3QNuVwB/uOMnUUf3
	 o3nUSX9MAJ9Dw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AR8WheN62529243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 16:32:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 16:32:43 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 27 Nov 2025 16:32:42 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 27 Nov 2025 16:32:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <alexbestoso@gmail.com>
Subject: [PATCH rtw] wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()
Date: Thu, 27 Nov 2025 16:37:08 +0800
Message-ID: <1764232628-13625-1-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Morning Star <alexbestoso@gmail.com>

TID getting from ieee80211_get_tid() might be out of range of array size
of sta_entry->tids[], so check TID is less than MAX_TID_COUNT. Othwerwise,
UBSAN warn:

 UBSAN: array-index-out-of-bounds in drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:514:30
 index 10 is out of range for type 'rtl_tid_data [9]'

Fixes: 8ca4cdef9329 ("wifi: rtlwifi: rtl8192cu: Fix TX aggregation")
Signed-off-by: Morning Star <alexbestoso@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index aa702ba7c9f5..d6c35e8d02a5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -511,7 +511,8 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	if (sta) {
 		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 		tid = ieee80211_get_tid(hdr);
-		agg_state = sta_entry->tids[tid].agg.agg_state;
+		if (tid < MAX_TID_COUNT)
+			agg_state = sta_entry->tids[tid].agg.agg_state;
 		ampdu_density = sta->deflink.ht_cap.ampdu_density;
 	}
 
-- 
2.25.1


