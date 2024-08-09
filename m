Return-Path: <linux-wireless+bounces-11174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0394CCBC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7922835E5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F418FC8D;
	Fri,  9 Aug 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM7SSo87"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F18129E9C
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193596; cv=none; b=Veb0eKO27G7iMXOIdP95olVE83vzh5LdhnYG+on4YAIV0dnrbHCTYj9fou59lv39+ObDD+8fgdUNoUTtzT+v2jggkE5QYzHGAgvhBPqpw55OY0+qgU5JHx6eFXtsnLjFnd1yXGIgIh92s8wqPcUx/mGY974cOOZs6IQnLBfspWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193596; c=relaxed/simple;
	bh=b6qnzjvZnolpwJuvpjYjYMSOhObEAY5gNBMzcqzn3rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOZ6wY+1yRp6tWs6GGpHJT2N10RbIjTjdxZXhdGg6o9fd7gePPmq4x5lyY/3a9FfglPhmXSDsGGNHd7J6pzvw0G+MozQAokGCx88x0hLLlAzkXyKwmXXPuNN1zPFgMByTpZwuJjILmz6sYAAswZXGrUjYQDSRqW8u8cPOQGxHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM7SSo87; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f00ad303aso2302465e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 Aug 2024 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723193593; x=1723798393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGzMLZkOgMoCuRCTWKYqGXGD6gPYA63aDopo+0CakLQ=;
        b=BM7SSo87fqxJWst+yet93mPBbhUrCv3/f7xenE8gwqGJaFsyP32W/YE6yxOLHvgr/8
         CInMpNGRfw9NSJKuErEJxgJ/LXdNN1bYTtsg4ncCeXQztk+c49a/PzKBZf2HZrsxbywH
         q14jU0utgs4UoQp7mhKeuglSDPBtjnX4Lih832FbNHV+2lyPr+Fa9GW0dZ4bqRZAmxtM
         yTHhC1+YsPSTX5N+sUU4RlppeVjot0wTysGVBXXPzY/7kktpSZSKSsqURFyJiIeCL7ZL
         Vm/SL85Wi1Qej33YUvJnT5ozukCc70tdR7fu28fSFkT6+TCGlZpv8YBnYDcfiQc68uKC
         GJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723193593; x=1723798393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGzMLZkOgMoCuRCTWKYqGXGD6gPYA63aDopo+0CakLQ=;
        b=gO2iNCADEsKr6mHq6OpaU84YLxOdzP7YXWrTMO3R85qPyC0Pl6/H4bU2fln/+qR1gt
         qXyPcCB3mCl+XvSVTWITf+gjIf40ZxosueEYZq4dJOWiqwqCPbqdHQESCabd0fLo9BBv
         dOW/wp4DU8R9V+Hpu05UsqUuPMtlQT7u6viQ4xMSYSWBFOL/d5uiUDp3/jL0GNA3Vp0I
         AD0wrjrwKWzObsnqnjftC/x244FJsaDtJgQhROCFiRupM9uZVONM0xfq3CJw9J6SYkxz
         TKXjqtjhP/EnUEvl7FmF+ZJN0uxBGETz2D7NR3qU+HOebHwUxTlj3ZWB8T0nVCcCbYHq
         xbNA==
X-Gm-Message-State: AOJu0YwVa+qL8A7jNB1XSEal5waocHDRc+ZKqk8/EBiyHXIYeX1azuvk
	Z3EuRPsZSDpl9nNPTnnjsLVP0lq+rrSpt0emoDpViklH3lJ+guiT6b2mlr7BRzI=
X-Google-Smtp-Source: AGHT+IHakeGS8LoW3xVmLgsy5InKYFj6uh8fnFXS02sM9nM54QsoeldWLy60R0t6TFX0HwY0L7Ew6Q==
X-Received: by 2002:a05:6512:308c:b0:52e:d0f8:2d30 with SMTP id 2adb3069b0e04-530eea05fd6mr687516e87.59.1723193592502;
        Fri, 09 Aug 2024 01:53:12 -0700 (PDT)
Received: from localhost.localdomain ([185.201.30.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de465c52sm912887e87.201.2024.08.09.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:53:12 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw88: remove CPT execution branch never used
Date: Fri,  9 Aug 2024 11:53:10 +0300
Message-ID: <20240809085310.10512-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtw_coex_action_bt_a2dp_pan', 'wl_cpt_test' and 'bt_cpt_test' are
hardcoded to false, so corresponding 'table_case' and 'tdma_case'
assignments are never met.
Also 'rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[1])' is never
executed. Assuming that CPT was never fully implemented, remove
lookalike leftovers. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 76f631cb401f ("rtw88: coex: update the mechanism for A2DP + PAN")

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 38 ++++++-----------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index de3332eb7a22..a99776af56c2 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2194,7 +2194,6 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 table_case, tdma_case;
-	bool wl_cpt_test = false, bt_cpt_test = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -2202,29 +2201,16 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		if (wl_cpt_test) {
-			if (coex_stat->wl_gl_busy) {
-				table_case = 20;
-				tdma_case = 17;
-			} else {
-				table_case = 10;
-				tdma_case = 15;
-			}
-		} else if (bt_cpt_test) {
-			table_case = 26;
-			tdma_case = 26;
-		} else {
-			if (coex_stat->wl_gl_busy &&
-			    coex_stat->wl_noisy_level == 0)
-				table_case = 14;
-			else
-				table_case = 10;
+		if (coex_stat->wl_gl_busy &&
+		    coex_stat->wl_noisy_level == 0)
+			table_case = 14;
+		else
+			table_case = 10;
 
-			if (coex_stat->wl_gl_busy)
-				tdma_case = 15;
-			else
-				tdma_case = 20;
-		}
+		if (coex_stat->wl_gl_busy)
+			tdma_case = 15;
+		else
+			tdma_case = 20;
 	} else {
 		/* Non-Shared-Ant */
 		table_case = 112;
@@ -2235,11 +2221,7 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
-	if (wl_cpt_test)
-		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[1]);
-	else
-		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
-
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
-- 
2.43.5


