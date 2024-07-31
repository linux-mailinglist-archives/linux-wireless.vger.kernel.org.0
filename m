Return-Path: <linux-wireless+bounces-10770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B2294377F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 23:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61351F214B6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC16EB5C;
	Wed, 31 Jul 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WewRtKBH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0F1BC40
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459796; cv=none; b=m6sMo0EQeOr4eEnBo9xqCLUoOxbNsADRCmB3+sHTPFaIOHo4At64ZgZdOJ5z3+nO/BcV2zO7ie+OCftEKQkpgYejJW6Su00EkTE2t/QBYyEgIWhITQVotrxVk3XtX+/GRoAVSg1BTS9lKsXUB+clJNVwkhOG+lJsr8NaSd9W30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459796; c=relaxed/simple;
	bh=rL4aYxJAksAlSkFK9iccAjjDh8j3GfU4Olq7/8IE3iA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KcH/TarrfScEVqOV/Y5liB8df3biz/gUlbSL+SfVv+oDsYQJdUkOsOEqH0Ylkeun9LB5N7uDs+HTXGFM62ZsMc2MX5+pRGAv3vv6+zSSC02Wl2TrQofwa+MMvOWuPlYkwyac0ADWNRF7BqO9mU3ofFIES/mUu8NDyNBgYKSHxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WewRtKBH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so4488961b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722459794; x=1723064594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=heA5fGeiUXQUV80txRPOrwakMWk5sMqZPg61Yuac1ZA=;
        b=WewRtKBHG819+lFbxMbB5NkRN7A7mqr54dJJ+0s0RWBImDJgupPggOrNeTZBMUyrYL
         7/rPrHLgP2tMmMGShXeoc+vxCNwpvtj1DxcrgNNzcrJfEE8Crgle/EUny3Eb9mzvbxmE
         gZZFRvAWvuDDweYsoQx/tYzOuBtykhPx+vlBRfQ0tmyQX003KyhuY3F2Sc25ZNGbr1+i
         n7GYlINPTha+0BGZpGEiYsSN7Bjw6/0p/WUHjE65nyzN/6DYvexPl9lKUn7AGPbD+7J8
         zDf1XXuk2dPUKMcBU5uIy3M76C4gl+6ci07neKEZlXvLTedjuq3zM9+APNETaBIXLLxY
         Wl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459794; x=1723064594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heA5fGeiUXQUV80txRPOrwakMWk5sMqZPg61Yuac1ZA=;
        b=Q0ZnAWU1uVY9k7c17mFSk0c/83mq05rG6EBSoc+IBciBAw+9JyJ2pRPTg6xhnJBpP3
         7lI1CZNO6Wl/gHKNIYdDOA1bg0aNrhuyDeEZIcppvL5iHgzY2Bwto6DUtZlOVLUw/Mcv
         8rbyYmZUjBiRtKhk8PHHPmJd1PQ53k0oEgFZBRc1dRT6//EQtea0CwviGTEp+bPy122x
         e8JM+mq7bChmpPzvnQeSiTjBDAI3zO4RCaf/UCi2mZJUuHAbVykve+S9Gq0YAnYx1i/g
         ZWQrujldAymG2/hPwyeKA7XqI99Fj1gSEJWuP3um6cMqorm0YrDRra6Sch4kZvw5+C2U
         CmvA==
X-Gm-Message-State: AOJu0Yz5WBKwZ7Em/SyMY6L6LHh8hgn/QcojQXQuWuk1Qh6iuPTVZAbc
	SZuIQ5UWMletjl7SnQGqBa3TBUpJ3huqvg+9cwSucIXLJ7DU0pt2roPs/A==
X-Google-Smtp-Source: AGHT+IHaP0rPOD8RscSHyy3+EzWhg7TiV3vbA8J7/CwvQGlsmvPKpjUBZl05bZRTe7parg2pLJWJOw==
X-Received: by 2002:a05:6a20:d81a:b0:1c0:f1c9:6835 with SMTP id adf61e73a8af0-1c68d25f8c6mr746153637.51.1722459793772;
        Wed, 31 Jul 2024 14:03:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e13f9sm10368946b3a.21.2024.07.31.14.03.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:03:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] net: ath9k: use devm for gpio_request_one
Date: Wed, 31 Jul 2024 14:03:08 -0700
Message-ID: <20240731210312.7622-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5982e0db45f9..04a4b9ea61c3 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2732,7 +2732,7 @@ static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
 	if (ah->caps.gpio_requested & BIT(gpio))
 		return;
 
-	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
+	err = devm_gpio_request_one(ah->dev, gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
 	if (err) {
 		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
 			gpio, err);
@@ -2801,10 +2801,8 @@ void ath9k_hw_gpio_free(struct ath_hw *ah, u32 gpio)
 
 	WARN_ON(gpio >= ah->caps.num_gpio_pins);
 
-	if (ah->caps.gpio_requested & BIT(gpio)) {
-		gpio_free(gpio);
+	if (ah->caps.gpio_requested & BIT(gpio))
 		ah->caps.gpio_requested &= ~BIT(gpio);
-	}
 }
 EXPORT_SYMBOL(ath9k_hw_gpio_free);
 
-- 
2.45.2


