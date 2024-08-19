Return-Path: <linux-wireless+bounces-11611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AC9566BD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E0D2849A2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52C15B96E;
	Mon, 19 Aug 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uMeux8eA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E315C125
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059092; cv=none; b=Uoz0Jekq+/G3hT+340pwJLySffdMMAQyY9owKl41cqSR+ZsUpymO9m3Zpneqq8SgEPftXPiWlwq02BbIOlYZnGqxQlEct9FgXesosUVpw7niv+L8jOhTxbaraxDUd08zp5PTyivlyDkzgDkYTkjPbSaxhr8Gjmjtw6NeYeMj5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059092; c=relaxed/simple;
	bh=HuAW1LOPFIt202lD6LfyGXWNVwQAUnBWrJ1vS4TvK/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSwIzDf19JCUiX0HYrdLDPGD5VtdxwEEc/Y6wW8fUpFUKLivemeLZ8VAqeIi5hNeGlNWKp/XuaHefgG+RRbZ7oVggSr24FJjBeFit0jININqGHP3FUjuwXHKmAjUFDf++jyVrtCvB5dkDUMGbcLKD0VUKLVtIP1w249/b0ND4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uMeux8eA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9I7vD44126181, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059088; bh=HuAW1LOPFIt202lD6LfyGXWNVwQAUnBWrJ1vS4TvK/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uMeux8eAvr/l0/qjcw5p/33LOa3WVQSvawjHe1uceMmheB7o94/b0vvdnrGK3jdWf
	 p9f/eDE0+Yi+4rKYe358nLXID1xLRTNYvxVxdxkXCcgImT7DafeDnnej19lP6l/dTs
	 RgFCtgqPMChiyNtpNwXNRtfCnhE3CPjllVTFNBCpk3Zo/VjwpfSdxaDxZy8x1eG3Sn
	 VQ7Jvwvcel8LMZo95hHVFLYMOhOIY0fPnawtg179ZnV5pl7lFTwl/lDix0P52DI813
	 mxsnporau/hf8cgAJjlhtbRljKpvHy/6cPSLxBptll8HNQzHsnhNkH6hexwdgM2zBr
	 IiWLMnW+o2cgQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9I7vD44126181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:18:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:18:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:18:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 7/8] wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
Date: Mon, 19 Aug 2024 17:17:23 +0800
Message-ID: <20240819091724.33730-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

The target enum has been renamed to rtw89_"chanctx"_idx. So for
readability, rename roc_entity_idx to roc_"chanctx"_idx to align.

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 12 ++++++------
 drivers/net/wireless/realtek/rtw89/core.c |  4 ++--
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index a67e16ded91d..7070c85e2c28 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -191,7 +191,7 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 	enum rtw89_chanctx_idx cur;
 
 	if (chandef) {
-		cur = atomic_cmpxchg(&hal->roc_entity_idx,
+		cur = atomic_cmpxchg(&hal->roc_chanctx_idx,
 				     RTW89_CHANCTX_IDLE, idx);
 		if (cur != RTW89_CHANCTX_IDLE) {
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
@@ -201,7 +201,7 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 
 		hal->roc_chandef = *chandef;
 	} else {
-		cur = atomic_cmpxchg(&hal->roc_entity_idx, idx,
+		cur = atomic_cmpxchg(&hal->roc_chanctx_idx, idx,
 				     RTW89_CHANCTX_IDLE);
 		if (cur == idx)
 			return;
@@ -230,7 +230,7 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	hal->entity_pause = false;
 	bitmap_zero(hal->entity_map, NUM_OF_RTW89_CHANCTX);
 	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
-	atomic_set(&hal->roc_entity_idx, RTW89_CHANCTX_IDLE);
+	atomic_set(&hal->roc_chanctx_idx, RTW89_CHANCTX_IDLE);
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -2395,11 +2395,11 @@ static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
 			rtwvif->chanctx_idx = idx1;
 	}
 
-	cur = atomic_read(&hal->roc_entity_idx);
+	cur = atomic_read(&hal->roc_chanctx_idx);
 	if (cur == idx1)
-		atomic_set(&hal->roc_entity_idx, idx2);
+		atomic_set(&hal->roc_chanctx_idx, idx2);
 	else if (cur == idx2)
-		atomic_set(&hal->roc_entity_idx, idx1);
+		atomic_set(&hal->roc_chanctx_idx, idx1);
 }
 
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e3b72a2b619f..9aa64ce85678 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -370,7 +370,7 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 		return;
 	}
 
-	roc_idx = atomic_read(&hal->roc_entity_idx);
+	roc_idx = atomic_read(&hal->roc_chanctx_idx);
 	if (roc_idx != RTW89_CHANCTX_IDLE)
 		chanctx_idx = roc_idx;
 
@@ -409,7 +409,7 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 		return -EINVAL;
 	}
 
-	roc_idx = atomic_read(&hal->roc_entity_idx);
+	roc_idx = atomic_read(&hal->roc_chanctx_idx);
 	if (roc_idx != RTW89_CHANCTX_IDLE)
 		chanctx_idx = roc_idx;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index da39c24d1660..0ac77376e130 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4597,7 +4597,7 @@ struct rtw89_hal {
 	bool ant_diversity_fixed;
 	bool support_cckpd;
 	bool support_igi;
-	atomic_t roc_entity_idx;
+	atomic_t roc_chanctx_idx;
 
 	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
 	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_CHANCTX);
@@ -6056,7 +6056,7 @@ const struct cfg80211_chan_def *rtw89_chandef_get(struct rtw89_dev *rtwdev,
 						  enum rtw89_chanctx_idx idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_chanctx_idx roc_idx = atomic_read(&hal->roc_entity_idx);
+	enum rtw89_chanctx_idx roc_idx = atomic_read(&hal->roc_chanctx_idx);
 
 	if (roc_idx == idx)
 		return &hal->roc_chandef;
-- 
2.25.1


