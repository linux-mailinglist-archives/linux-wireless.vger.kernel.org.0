Return-Path: <linux-wireless+bounces-12616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C390E96FC5F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0041F21281
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8C1D6DDD;
	Fri,  6 Sep 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrEoQyig"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED51D5CF2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652445; cv=none; b=usanG9de1aSPL0WnIZsgM4wzdjF5x/9meQYeOSEssGt0R6Igt9VrgOAmv/K+tiX0+v7tx4CqNflDXA+DpaQPWXl+v4FQu5lGbSZmTqRk5iAyBlmqtd9M6oyToez9d7GWCfRSZFI5O2SiHN6Z4mqw2FbAw8GH3L+GNvw3F5ySrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652445; c=relaxed/simple;
	bh=dG0wU+ELooHhl9kop/9dQyFss5A+Lg7jzeXqR4UOovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibe7fwDQXHWQTc41QQwIqiV3cVHP9fretjrgxWp2rT1fjES6Iei0+aha/WlLVoIqfx348h9b171liaKaLMlIMvdB42+DIkkONHNpTeklRS4WWxppakDG3S0XJby0WecEcWkDkqOdqWG/p7hkkm3HAKYBj2ehIuDebvDVBoZS29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrEoQyig; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so1773094a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2024 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652444; x=1726257244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnaZJziqDKdiONAxSzGup/wlqumDXm6layBdbBHOfg4=;
        b=BrEoQyigM4tQXfT5NWCWntzDGPA1xXCJ9Hanaa7Dxzk1Z4MZFd+TVK3ZZhTzVxXvDU
         fYSQ5xZxTJN6KhM7EAjLGd7NS29kFWY6b7dEVo0+J6D2MdlVPPZztA+Lj4ewkj+PujLT
         ABTsO/4Pi3pos3LvQhmzRuoWr+MxydLLHc6V5w2pLCnhcwKvuhh2oqDveTH6SbNBpXJw
         M8QypCVZQPQNurWzLwH3USGnCm8DdVOERrnEPnJMwqfb4AINTNR1lLaoEeG/gLiqT7fH
         oIFwPHlpAu/jmbhMY5R+dzP1OYjLEzEr4Eoh/dpVAMYcEgAT/j+9VuMElMQnRITsJZDv
         nwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652444; x=1726257244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnaZJziqDKdiONAxSzGup/wlqumDXm6layBdbBHOfg4=;
        b=pOgtaGiBby+3ou+oI6dFXw2o31/e+RmXzQuYHJDr0ytsDi1N1h8uXQ0LU9LdrOjBDK
         0iuNaDyLU+jqnmMvn/Do7YUpSs4KTU3oD6zhJ56niyKLHcEbYr0RedquY1hMMhaMnGtD
         qPUsmESMKfUZSXSkHZ9jwmXyeXmNY1yP0jR81iehgrmpoxun2/Qr2ZOdJAdkNsvaiDcx
         kj7kRNSP6QqERlxC9Ru43nDz377o5rlHmRgAEtCh+FVbN3qkt+whFg/Q7v/dICUAB4Pt
         CEHd+RDFAmGri9HV5MvsWCc62sRslDuK/DkspRWCxvUxm9iWmyUliy4ied//OnZon9jR
         vGVA==
X-Gm-Message-State: AOJu0YxRMin9o74PZaZxszXOX4AFpFMc6QIe/26o0u+kSNf/4Br+v1ZD
	Y+8o38VkJTLDUvJJm/GAATIKnGuQNVh283+QIJtB/bnDqkRMVip6hkGepA6b
X-Google-Smtp-Source: AGHT+IEHl/2mlmZkKhyPyZuYy2lTmUWE19w04MwDWE7cKEJeOlSua8Yzli7SaDJ9XX5HnMHnmf+n7A==
X-Received: by 2002:a17:90a:c086:b0:2d8:816a:69c5 with SMTP id 98e67ed59e1d1-2dad501ba04mr4551820a91.23.1725652443644;
        Fri, 06 Sep 2024 12:54:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm2015954a91.34.2024.09.06.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:54:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de
Subject: [PATCHv2 2/3] wifi: ath9k: btcoex: remove platform_data
Date: Fri,  6 Sep 2024 12:53:58 -0700
Message-ID: <20240906195359.6982-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906195359.6982-1-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is completely unused as platform files are no longer used anywhere.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/btcoex.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/btcoex.c b/drivers/net/wireless/ath/ath9k/btcoex.c
index 9b393a8f7c3a..ad3a3fda1b9c 100644
--- a/drivers/net/wireless/ath/ath9k/btcoex.c
+++ b/drivers/net/wireless/ath/ath9k/btcoex.c
@@ -16,7 +16,6 @@
 
 #include <linux/export.h>
 #include <linux/types.h>
-#include <linux/ath9k_platform.h>
 #include "hw.h"
 
 enum ath_bt_mode {
@@ -115,23 +114,14 @@ static void ath9k_hw_btcoex_pin_init(struct ath_hw *ah, u8 wlanactive_gpio,
 				     u8 btactive_gpio, u8 btpriority_gpio)
 {
 	struct ath_btcoex_hw *btcoex_hw = &ah->btcoex_hw;
-	struct ath9k_platform_data *pdata = ah->dev->platform_data;
 
 	if (btcoex_hw->scheme != ATH_BTCOEX_CFG_2WIRE &&
 	    btcoex_hw->scheme != ATH_BTCOEX_CFG_3WIRE)
 		return;
 
-	/* bt priority GPIO will be ignored by 2 wire scheme */
-	if (pdata && (pdata->bt_active_pin || pdata->bt_priority_pin ||
-		      pdata->wlan_active_pin)) {
-		btcoex_hw->btactive_gpio = pdata->bt_active_pin;
-		btcoex_hw->wlanactive_gpio = pdata->wlan_active_pin;
-		btcoex_hw->btpriority_gpio = pdata->bt_priority_pin;
-	} else {
-		btcoex_hw->btactive_gpio = btactive_gpio;
-		btcoex_hw->wlanactive_gpio = wlanactive_gpio;
-		btcoex_hw->btpriority_gpio = btpriority_gpio;
-	}
+	btcoex_hw->btactive_gpio = btactive_gpio;
+	btcoex_hw->wlanactive_gpio = wlanactive_gpio;
+	btcoex_hw->btpriority_gpio = btpriority_gpio;
 }
 
 void ath9k_hw_btcoex_init_scheme(struct ath_hw *ah)
-- 
2.46.0


