Return-Path: <linux-wireless+bounces-23764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F123FACEEA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9ECE16405F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD8A215191;
	Thu,  5 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nQeUuVm6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF71C27
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123754; cv=none; b=KiIchB+x1+uhhViOC3+WkskRd54XOg739VKjlknVlsECE0kNRyZO2e9sQ29SIv4yGMsSAWtZ6BJZHuHFvDAIcNG33b5FyJOnIiRottdlpAc6w+XPwLVlJs3wde58HHqmQERsood462Uh7jop+h6OsNiEN3f0WM9JuO5V4jzhkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123754; c=relaxed/simple;
	bh=knMFQONoVYSe21D4DVJuRa3QC4tS/9vfu4m5tSyTd44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkXNQQKADTeaQN5/Jv+iK9sgFDPSEpzZlOzZtZlD0AvTgRBUyCzP1AlppDy4zT3jMgck+eqhQ5AsesX2vuvmOZxZoA6iwkX9vp/aStbKBPttoNWnZeN4NpOag9Pnw6+dhJkIfPI6kEPZ6dMwXxBt0grvQp+aOY45bvLT5bLL2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nQeUuVm6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 555BgTRn91470998, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749123749; bh=WcPeDGZZYH9M4ITMeoAMClV1jaDiWtIhSoaOCa5u0Tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nQeUuVm6iwiezCRWu2QaM/r0+LfFHRYlq1yhpqkAC4ZrXEB1H3WRiNCIRkTZjGvhK
	 cFs6i8xQ4IuYbGRSmL07KDgYBQfBno4E1TpWoT3oxcyRq/KIXumlCRKt6p+/WcC2Pn
	 CTyPSW0OlR4DtAdxo7B16eutOa5rUYGm2LJ4zmyzSItaotJmNSCFtLP6nj5IRWpEee
	 /4bLINdNUEivKPou6uYX9a1JvcsUL6H/jzgmkTE1RJAvrev7DIiwZkskFlneNipdJB
	 iiBfmul0jIJLNWCpKJUlJ6ARr1ZIF8RLP2i1/lUqCQ35eNBG14ARcz0iAOMjR7U/qf
	 IA1YugtQ9Os4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 555BgTRn91470998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Jun 2025 19:42:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Jun 2025 19:42:29 +0800
Received: from [127.0.1.1] (10.22.226.54) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Jun
 2025 19:42:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <damon.chen@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/5] wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
Date: Thu, 5 Jun 2025 19:42:03 +0800
Message-ID: <20250605114207.12381-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250605114207.12381-1-pkshih@realtek.com>
References: <20250605114207.12381-1-pkshih@realtek.com>
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

Originally, the logic for setting bits was wrapped inside the configuring
function. However, raw clearing bits, clear_bit, was called directly. To be
more paired and more understandable. Concentrate the logic of them into the
same function.

(don't change logic at all)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 806f42429a29..5e7f3c3bf1a6 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -170,22 +170,26 @@ int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
 
 static void __rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 					  enum rtw89_chanctx_idx idx,
-					  const struct cfg80211_chan_def *chandef,
-					  bool from_stack)
+					  const struct cfg80211_chan_def *chandef)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	hal->chanctx[idx].chandef = *chandef;
-
-	if (from_stack)
-		set_bit(idx, hal->entity_map);
 }
 
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
 				 enum rtw89_chanctx_idx idx,
 				 const struct cfg80211_chan_def *chandef)
 {
-	__rtw89_config_entity_chandef(rtwdev, idx, chandef, true);
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (!chandef) {
+		clear_bit(idx, hal->entity_map);
+		return;
+	}
+
+	__rtw89_config_entity_chandef(rtwdev, idx, chandef);
+	set_bit(idx, hal->entity_map);
 }
 
 void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
@@ -227,7 +231,7 @@ static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
 	struct cfg80211_chan_def chandef = {0};
 
 	rtw89_get_default_chandef(&chandef);
-	__rtw89_config_entity_chandef(rtwdev, RTW89_CHANCTX_0, &chandef, false);
+	__rtw89_config_entity_chandef(rtwdev, RTW89_CHANCTX_0, &chandef);
 }
 
 void rtw89_entity_init(struct rtw89_dev *rtwdev)
@@ -2782,10 +2786,9 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 			      struct ieee80211_chanctx_conf *ctx)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 
-	clear_bit(cfg->idx, hal->entity_map);
+	rtw89_config_entity_chandef(rtwdev, cfg->idx, NULL);
 }
 
 void rtw89_chanctx_ops_change(struct rtw89_dev *rtwdev,
-- 
2.25.1


