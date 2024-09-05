Return-Path: <linux-wireless+bounces-12547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F296E19A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C7B1C23D33
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86E1C2E;
	Thu,  5 Sep 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg+djfX/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E717BEA5
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559777; cv=none; b=A0dxPzKVPtoWDpUKH87TesS8H3eJolRk/th6WiTwYnu8QeEmdngXwzOeyuoMReVNu8YZG6Bx3bbU7hbwFjB1uGNu1mpaC/AqLaR9wAmZbFI46hS9h1TV/l/D1TiILo+8uZWQXTAJeZKK5fEsEmszYy+8NpGZKP5YxZD8gCKeHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559777; c=relaxed/simple;
	bh=dG0wU+ELooHhl9kop/9dQyFss5A+Lg7jzeXqR4UOovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlEiblKlvALG/S/7BERWVhK0zCVsGuw5LV1iknb/d5K1rksfJzpanwtUhTvOG2YyMnDDu+M3TRPHuRvKD6iDVgswd5DR9yDKTIDU+WeRypZ1+TFQPqnXTdbbAA+7hNIjHEZGI9gMu5p3IiSzwx+ExtTrpkxIigJnDYOKs1Z0Kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg+djfX/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7176645e440so780039b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559775; x=1726164575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnaZJziqDKdiONAxSzGup/wlqumDXm6layBdbBHOfg4=;
        b=Pg+djfX/SWi0b3f/JPRJl9DZQSjnh5SCyH27YRKWbVIccXrAp7Dl81wwcZCsMhGuok
         MhRKaKWCu+qyKBpw7FmBKYh5kqWmZrAH5cze6H3qIESs/qCDE93dLt4fmTO6MZYQds8C
         mwIHY4nWCSgyd95Gih/9SqwYM88hlgVHZziBgqWwmLtN1dhqw5XpgjQ1NoFM8vEyWwdF
         4pwd4CEOV9NmrPCnIhz+TmUVAIx5VRq6vOsm7QdOd823/YMD08ZM4AQcO5J0DNMeT4NA
         7uM7EaeCn30ct7xO/see6VXPdNirxoYu2uwpmyHKLux+tUkquv5NqceYqBJD3mJn8ovx
         nvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559775; x=1726164575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnaZJziqDKdiONAxSzGup/wlqumDXm6layBdbBHOfg4=;
        b=eSzwX20qFc6ouOkhWY6nlhANSDfjsiZLgAlIqSABlmX+c1etOOmOgUSv+mBzQXMBg2
         eRWNK4UvrZJIYXydN2skLmCpy3osQISdpQVsY4Lpj+tdPmkIre/jYHBPBAowcoZXk03X
         qesovu+BjEYheaZy0+W07s2Yw+sEe+ytMxegw7bs/HW/ibrZ1xz1iS19SJfxSwGe3Feb
         YdPhbP1o7zSLHNyqGHSpjfa2Sr4qtbq2TXytNX83cNoGM7ALdhf/Hixeh/e69WYN2ze9
         5EDeGul0XiLr/Ihe03w23tcGp45uu+mJ6qBURilnvoAYgbYSl7KVyJfUe/Kf9qkqNNbA
         WLHQ==
X-Gm-Message-State: AOJu0YwfV/SfsQQWk/UHuH5WRC7DhuMGylQFxU3GdtNx9g+hfA/W/+r3
	4ETJpxmIKj2ODwD75+AJHIXYDpMBh2ZUg8xOIJ0hePrpbkPSDiRpDUTWCYjx
X-Google-Smtp-Source: AGHT+IEIO74+Wz3f6PdylZLzlZJ8EuB9zCC6GfoxK27rqxkk0R2OTOhNTaqXzyPCjuJQNGAs35GoVQ==
X-Received: by 2002:a05:6a00:816:b0:70e:aa7f:2cb3 with SMTP id d2e1a72fcca58-718d52dc4d1mr325002b3a.2.1725559774873;
        Thu, 05 Sep 2024 11:09:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 2/5] wifi: ath9k: btcoex: remove platform_data
Date: Thu,  5 Sep 2024 11:09:25 -0700
Message-ID: <20240905180928.382090-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905180928.382090-1-rosenp@gmail.com>
References: <20240905180928.382090-1-rosenp@gmail.com>
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


