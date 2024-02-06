Return-Path: <linux-wireless+bounces-3193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E784ACAF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D07286553
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1881AB7FC;
	Tue,  6 Feb 2024 03:07:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB67316E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188861; cv=none; b=WTC3L3RcwZ2wMkG/Moh5cJfd9rOlKMqHtd35bfXGF9prlj2fEbMEwHvC5rDpLSoDhp2LZM5lg8J214fHC0qMCZJ+mTnErGYb7fY+KPkXv3FwmAb9mClVfGWAUBcmqKByhZkpne74jvGVtEeVRvI37cVNNT4wgCpfp8qnnsNYhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188861; c=relaxed/simple;
	bh=Q9A4y+oyqDEIxYRUWlO2vBlHjhAkNRQOX8QAFho/jfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhEnBey8YSGzmbL59oEvpL9SBp7E+VIDHF7/57FVUgblU3mvWwfghvIEvGiBHVGcBACywAZvOxgUcKsMzt2HnZXvEXl3ENuCZUUTbeqAWjyn6HC0Iw3X5oeqHg43MAfHV3LMDe4tAc8skj2yzBKDQPGIiiDJBUVd9gZe1tsMJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41637YvD43532560, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41637YvD43532560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 6 Feb 2024 11:07:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: chan: MCC take reconfig into account
Date: Tue, 6 Feb 2024 11:06:24 +0800
Message-ID: <20240206030624.23382-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206030624.23382-1-pkshih@realtek.com>
References: <20240206030624.23382-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

During mac80211 reconfig, chanctx ops of multiple channels might not
be called in order as normal cases. However, we expect the first active
chanctx always to be put at our sub entity index 0. So, if it does not,
we do a swap there. Besides, reconfig won't allocate a new chanctx object.
So, we should reset the reference count when ops add chanctx.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 71fe0d3ab3b0..7b9baf4db70f 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1980,6 +1980,7 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 
 	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
 	cfg->idx = idx;
+	cfg->ref_count = 0;
 	hal->sub[idx].cfg = cfg;
 	return 0;
 }
@@ -2011,11 +2012,23 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 				 struct ieee80211_chanctx_conf *ctx)
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	struct rtw89_entity_weight w = {};
 
 	rtwvif->sub_entity_idx = cfg->idx;
 	rtwvif->chanctx_assigned = true;
 	cfg->ref_count++;
 
+	if (cfg->idx == RTW89_SUB_ENTITY_0)
+		goto out;
+
+	rtw89_entity_calculate_weight(rtwdev, &w);
+	if (w.active_chanctxs != 1)
+		goto out;
+
+	/* put the first active chanctx at RTW89_SUB_ENTITY_0 */
+	rtw89_swap_sub_entity(rtwdev, cfg->idx, RTW89_SUB_ENTITY_0);
+
+out:
 	return rtw89_set_channel(rtwdev);
 }
 
-- 
2.25.1


