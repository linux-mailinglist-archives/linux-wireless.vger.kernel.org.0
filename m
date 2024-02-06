Return-Path: <linux-wireless+bounces-3189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14184ACA8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26116B2282E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF84BAAA;
	Tue,  6 Feb 2024 03:07:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40313482FC
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188839; cv=none; b=SD1iN4e9fx7LMi5revpnEP3XzGFomXHznE2xggO+42u3brbP3IoNVxT6bwgptS+aQ36souyXiDQltQokD0Ny/wZtxoT+QhLdgDfbbDJV+hN0i1QtVBfjSSDlJeJwmicPJKSM2NOx7yAvhW5WmjfhHAMp+2VVHuzNCx9hg74QMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188839; c=relaxed/simple;
	bh=SavqJWX4luqdL/iz3Izmb1PIyZjBKQxGY4rvRIVhlQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U++F/kW7wB75SqgjAO1KfEv1uijoq9Qs1mm5O2jvXJCqGQDPhnmNIQrCr+mdq/vwbr+rLx/ovptJBsdnWV75NH1Nmuqoc89CP8pqlMMZsQZV5iuSdTqVsf6zrRLVq4AX+dGCH3mqHo9dEQlU4/EHDymYm422j5siLzKsqPqrBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41637ANH03532480, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41637ANH03532480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 6 Feb 2024 11:07:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: chan: add sub-entity swap function to cover replacing
Date: Tue, 6 Feb 2024 11:06:20 +0800
Message-ID: <20240206030624.23382-3-pkshih@realtek.com>
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

Originally, we replaced sub-entity of index 0 with another one in some
cases. However, we will need a swap here in following implementations.
So, we introduce it ahead and change code from replacing to swapping.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 47 +++++++++++++++++------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2a95f9db83f9..11d46878f51e 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1893,6 +1893,41 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_work(rtwdev);
 }
 
+static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
+				  enum rtw89_sub_entity_idx idx1,
+				  enum rtw89_sub_entity_idx idx2)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_sub_entity tmp;
+	struct rtw89_vif *rtwvif;
+	u8 cur;
+
+	if (idx1 == idx2)
+		return;
+
+	hal->sub[idx1].cfg->idx = idx2;
+	hal->sub[idx2].cfg->idx = idx1;
+
+	tmp = hal->sub[idx1];
+	hal->sub[idx1] = hal->sub[idx2];
+	hal->sub[idx2] = tmp;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (!rtwvif->chanctx_assigned)
+			continue;
+		if (rtwvif->sub_entity_idx == idx1)
+			rtwvif->sub_entity_idx = idx2;
+		else if (rtwvif->sub_entity_idx == idx2)
+			rtwvif->sub_entity_idx = idx1;
+	}
+
+	cur = atomic_read(&hal->roc_entity_idx);
+	if (cur == idx1)
+		atomic_set(&hal->roc_entity_idx, idx2);
+	else if (cur == idx2)
+		atomic_set(&hal->roc_entity_idx, idx1);
+}
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx)
 {
@@ -1918,7 +1953,6 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 	enum rtw89_entity_mode mode;
-	struct rtw89_vif *rtwvif;
 	u8 drop, roll;
 
 	drop = cfg->idx;
@@ -1934,16 +1968,7 @@ void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
 	/* RTW89_SUB_ENTITY_0 is going to release, and another exists.
 	 * Make another roll down to RTW89_SUB_ENTITY_0 to replace.
 	 */
-	hal->sub[roll].cfg->idx = RTW89_SUB_ENTITY_0;
-	hal->sub[RTW89_SUB_ENTITY_0] = hal->sub[roll];
-
-	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		if (rtwvif->sub_entity_idx == roll)
-			rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
-	}
-
-	atomic_cmpxchg(&hal->roc_entity_idx, roll, RTW89_SUB_ENTITY_0);
-
+	rtw89_swap_sub_entity(rtwdev, RTW89_SUB_ENTITY_0, roll);
 	drop = roll;
 
 out:
-- 
2.25.1


