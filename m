Return-Path: <linux-wireless+bounces-18576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A4A2A31B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1051620D0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77FC22540A;
	Thu,  6 Feb 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNyqhgtp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB321CFE8;
	Thu,  6 Feb 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830306; cv=none; b=WZ7CwwrPi4KMBiRtAkDQFCqP1hZodzpaDs/hSg8AmT6GE1hXJXfKmi3U5zcUG2UecSOfDJgwf9dKgpaSqcw8fO3HBZgF5EYDe6U7qH1rax1rhp+2DYpjKx/9Q7UaIajDe88nVXtxz2CUpMMHnnawZ7NARUiVx7aG3kRKLm3Jxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830306; c=relaxed/simple;
	bh=ySVaukHavwMH59PZ1fdsFaHe3vmhRU6DIaV6J7dV46c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jH+pPcLW06NEnL6H+nlsV4Zzr3+c+GTIgH+5gtPltNxiPDq1Nh6P/o2UWtehU46Vsx2UfMPchKJGNyVCerEGGZGLWN8uoDFZQTFqTXmyFEw0Zcz7hJoaAjuj4AdmC1OpcieGS8X1BpS0wtjoa4y4vHCxJjPDiwdh0SyK4+2Hopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNyqhgtp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dced61e5a3so1041612a12.0;
        Thu, 06 Feb 2025 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738830303; x=1739435103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BF0kK7yHV3Y9vU7NQPyMhU1k5/+XykjSlEXscAENlAw=;
        b=lNyqhgtpGXFAfgEafSZRam+LntMx4Ad87o5ON8G0DBnpZTyNyeA0IXDLOjpxrXZWgq
         MVqMIti8klEGJTtqpyR4JZ3uIwpzMt2FWxkwsMpigNYX6p4Bf8kCJATywqSY4GuCltlG
         sc21v68n5Nm8HWI9oIDZ94d1dPnx7TduYLMJz3KWBYu1H8wbDmuo4wfQbEtvRHf8JKJM
         GfC3cG5SwX/IbQwJQN7SvP79FxQi5OQVUszlDbJw4b745vegXYro/gAkZl9/Tf4Ox+dg
         xpNy0CQYSam1sQel3zmhklb9bfdzlDi3MZy5X1MbR6paNNKX15HoitfpkjWYIDPldDp0
         YAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830303; x=1739435103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF0kK7yHV3Y9vU7NQPyMhU1k5/+XykjSlEXscAENlAw=;
        b=XKWD573EV/i5izJh1NNoxmDYaYEjgMeZpN8OebnHF4sZa9YmWx8haX3QJrfw4PHFkU
         AbZPFRvn45MGRKLrDdkPyF3/TXs6Nt+h3Qa2iLYbmKUvHacF5ByeRyjnOut0Ghtg04NL
         rQub3aTB3erU5LYP9WU1SpXV13fTt2YTC3UcI64EXPwEWFNVYHzYKYB1upZwjssdeeki
         DdBzTsJL4Jw1xpLJkxhs7L/Wu1FgohiAEf4hDTX0mQij44nv5obvaKVhHyXZki+VZf6S
         SWQlVoOp8apDWxhyYvKvWCMMr4302bEIezmLYIhq0HYuuVU/qAtzTtvsAQJB7j/wxitq
         ew7A==
X-Forwarded-Encrypted: i=1; AJvYcCVbw6HslJSY7kkB8Ie+jhpr4w54MU8hEvMNCzgPQ/YlceGKUax/GA2dwjw1Va1MhQCDK0exYDKON8xtCiTkRxQ=@vger.kernel.org, AJvYcCXE7sC+XcISYgjHpa/cjtyYwb8YdP2GZnkiJiolCGCO3eh7NaNuZE2icQH1RkejJYGUHIQ2IY9s75d5l54D@vger.kernel.org
X-Gm-Message-State: AOJu0YzXImjbhJ+OIIX8KVDn1E8Z6IPUWLlX0lFnXVLTXwTihZvgeQzw
	T1K8pQgEHuHAPo9u4FDdmMc2As6blYTqFfzsXhYHA8n/JAf3IuUo
X-Gm-Gg: ASbGncuRnWjbgZtCMhVxnbPdm+nVFbJgO6O+6vGwKB0JtLs21PTNKx2QmB6HkMBkDPo
	mVeKcDPXDcis2A5Gdiv6eml/BW0m5Pje4GuU1eh+BW4+vf87F+tuXp1G4gI+dB7migQn5YPdifx
	dpWkFxr30a3RcMLHXXih8sHr7dwpRMby7mR9sBRtP4o3wd++7fDnigQeEUVUAR94AYXASuZMbmV
	uVNyH1yWiClk0jjnbOMryQeoDVN/+8LTlZNYShOTrTiBsW6yTonh7FiUvOYOF/UBJI/H+tveaSJ
	m9ktME2TO9LR+j+J
X-Google-Smtp-Source: AGHT+IFU62aLjMmlDdSKTxRhCJyaarrv0BEa6Co4kNhymiutzIpO6lA2+J1QTbJS/FygEuSR1gkIvg==
X-Received: by 2002:a17:907:7ba3:b0:aae:ee49:e000 with SMTP id a640c23a62f3a-ab75e27f2dbmr546468166b.18.1738830303031;
        Thu, 06 Feb 2025 00:25:03 -0800 (PST)
Received: from void.cudy.net ([46.210.137.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7008sm60675966b.113.2025.02.06.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:25:02 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] wifi: rtlwifi: rtl8192de: Fix typos
Date: Thu,  6 Feb 2025 10:24:12 +0200
Message-ID: <20250206082457.9148-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.220.gbc204b7427
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in comments/messages:
 - althougth -> although
 - asume -> assume

Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d429560009bb..e07402e73ba3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -484,7 +484,7 @@ bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 	 * pathA or mac1 has to set phy0&phy1 pathA */
 	if ((content == radiob_txt) && (rfpath == RF90_PATH_A)) {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			" ===> althougth Path A, we load radiob.txt\n");
+			" ===> although Path A, we load radiob.txt\n");
 		radioa_arraylen = radiob_arraylen;
 		radioa_array_table = radiob_array_table;
 	}
@@ -750,7 +750,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 		    && rtlhal->interfaceindex == 1) {
 			need_pwr_down = rtl92d_phy_enable_anotherphy(hw, false);
 			rtlhal->during_mac1init_radioa = true;
-			/* asume no this case */
+			/* assume no this case */
 			if (need_pwr_down)
 				rtl92d_phy_enable_rf_env(hw, path,
 							 &u4regvalue);
@@ -1885,7 +1885,7 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 			bneed_powerdown_radio =
 				rtl92d_phy_enable_anotherphy(hw, false);
 			rtlpriv->rtlhal.during_mac1init_radioa = true;
-			/* asume no this case */
+			/* assume no this case */
 			if (bneed_powerdown_radio)
 				rtl92d_phy_enable_rf_env(hw, erfpath,
 							 &u4regvalue);
-- 
2.48.1.220.gbc204b7427


