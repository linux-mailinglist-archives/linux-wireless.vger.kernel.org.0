Return-Path: <linux-wireless+bounces-11651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E0C957CE6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939D21C23D37
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897DD1BF2B;
	Tue, 20 Aug 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e14lx41k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0D43AA8
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133170; cv=none; b=WcFbq4FvIrVA7Mh0/LZzt5xRHqfA1/edDDz4hrMnGa2sTRbfE5itGYQle+c/wI/DT5vOn8vMQArIoumlcomAZ5+3zbIedIrVuLFIIJ0kjAi1HbpSxgr6nLqwQwVE8duNfZ6e2KdeTEx0cSBrZkOEixKBOeXcVh3HXxurq28LCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133170; c=relaxed/simple;
	bh=SL/dfIfE6JH0bveSwBPyf81JRUS0RfU6utSzfurMUL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DymEqCKzauY/g4FU5xMZEv/sa9iL6UKkevybTUh/nM6ApN0+eBB1yf4pmEfW7J/fsG4DaNWykMRthh4EtjH4/3ZbR9EOOjQVswmF8yeO9jHiK2gR13V54ia2nJixMXs4/qUg2eCKibqERlqIHHrFOOoSV/52gjTam5MsoTcsCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e14lx41k; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso58337811fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724133167; x=1724737967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImGFt2Gi+I0ypmbzISgUAdIoA45BLjwmH46GUQBVtZI=;
        b=e14lx41kQhwRfz//WZalDZzGlm5ITOLvryKFXBJzZjetvWviPuEkVI525CQg6HQazP
         SvfsL19bdf6b4Soxs48Dt+nlh8TPkPq24S1vDSvund/NIefIBMjiIrMjNFab8Q63rZ31
         lm6sLrdrkLGw+f5Tee9c852WC16ZJMDJzSXewf8eaEF5qk2uDffE/6tf0ojQOxSEWB9L
         bxbyigdKrxfGwZNccbrBPZsyRVyWJVp/ly4q8t0o1CwLwtbBGUr9EWo2JoRNNg7QIWWm
         Rds8g71aC0SiQoNb8uDxqQx5r2YBPMjY87i2BP9W92F5qgZXZJWmVtdyh4isvFv0DIeP
         cHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133167; x=1724737967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImGFt2Gi+I0ypmbzISgUAdIoA45BLjwmH46GUQBVtZI=;
        b=K4tV6GErDMHXz9rMxg0hkGSiVALArM6e3zbmoGAEvVkyECo/B4TUBCDDN/tDgYHusG
         BrMi8YQTNQ9XjBO5vpOJ5jaOo6Adjt4sp34OYCJky5Ztt6rYpLOGtndvEhI+5gRLV6q+
         XjSCg/3TuqpUBpMkgeNrv7dKH2wKo1X0lqAMCmwX/jXL2WZ73AdwQ0HTcsTkVIHRG40r
         yWUvkn89g1ZS5VqQAbLLLbt7DixhtkkqsYUxjD8vUfBWxD+vrxOb/bpTnaSpQdoxfp4h
         KrwHpLdBE8AGk4Z+mfgGoj7eDlqfjdhABgNAVdg/qx3rtgObvpmopfTLMhLxAiao3F3G
         NWXg==
X-Gm-Message-State: AOJu0YwJXpYXwrj74em1ZCtGj3uv3qYxkan5TN3J4JL4eLJnF/u5u23a
	faS0cL8ALZC/4toyUf3brLb4Z04KgJWXdsNbp2t6qf4G0R326l19
X-Google-Smtp-Source: AGHT+IH/nnr+7VbZPKs33ulwVfLecx9+MuWYUNSdtqoKFjSIvAmTZoDEwJ9YNlFlqnYhPKfScgEHoQ==
X-Received: by 2002:a2e:a9a3:0:b0:2f3:ed84:9e66 with SMTP id 38308e7fff4ca-2f3ed84a16cmr3832891fa.13.1724133166196;
        Mon, 19 Aug 2024 22:52:46 -0700 (PDT)
Received: from THINKBOOK.inferitos.ru ([185.201.30.27])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3cc2f1173sm9854211fa.110.2024.08.19.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 22:52:45 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
Date: Tue, 20 Aug 2024 08:52:44 +0300
Message-ID: <20240820055244.128644-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtw_coex_run_coex', 'rf4ce_en' is hardcoded to false,
so 'rtw_coex_action_rf4ce(rtwdev)' is never executed.
Assuming that rf4ce was never fully implemented,
remove lookalike leftovers. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a9359faaa47d ("rtw88: coex: add the mechanism for RF4CE")
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 30 +----------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index de3332eb7a22..1fbcf701e7b7 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1591,31 +1591,6 @@ static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 	rtw_coex_tdma(rtwdev, false, 100);
 }
 
-static void rtw_coex_action_rf4ce(struct rtw_dev *rtwdev)
-{
-	const struct rtw_chip_info *chip = rtwdev->chip;
-	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u8 table_case, tdma_case;
-
-	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
-
-	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
-	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
-
-	if (efuse->share_ant) {
-		/* Shared-Ant */
-		table_case = 9;
-		tdma_case = 16;
-	} else {
-		/* Non-Shared-Ant */
-		table_case = 100;
-		tdma_case = 100;
-	}
-
-	rtw_coex_table(rtwdev, false, table_case);
-	rtw_coex_tdma(rtwdev, false, tdma_case);
-}
-
 static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
@@ -2531,7 +2506,6 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	bool rf4ce_en = false;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -2587,9 +2561,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	coex_stat->wl_coex_mode = COEX_WLINK_2G1PORT;
 
 	if (coex_stat->bt_disabled) {
-		if (coex_stat->wl_connected && rf4ce_en)
-			rtw_coex_action_rf4ce(rtwdev);
-		else if (!coex_stat->wl_connected)
+		if (!coex_stat->wl_connected)
 			rtw_coex_action_wl_not_connected(rtwdev);
 		else
 			rtw_coex_action_wl_only(rtwdev);
-- 
2.43.5


