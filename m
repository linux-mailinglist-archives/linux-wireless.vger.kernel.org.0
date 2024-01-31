Return-Path: <linux-wireless+bounces-2920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E86844B20
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 23:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B335FB275C2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70823B290;
	Wed, 31 Jan 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xK41zBb/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFFA3A1DD
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740653; cv=none; b=Iw4jqqXy8sOo8HE+kDn70d+NnM0h2Jdbm0GRH2sRuXQzUqBDDZBzKj4zWypP9ynOIp6kJkX99Jev8LHRaK14qEh92hRpcik37nnpPBYOM9fdyjuhceDQ/Zx7P+Qc12+Ou4w+auSyygNcA+ltV4jA115A251CqRH6MwV86An3ESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740653; c=relaxed/simple;
	bh=LPemJiJDNeh1UetE8kKmrKuqS+5AJjwLvDRlUyR+Sac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfnTFchqCH5LSQhPRiR8eu6cdfD8TWyREQdLN88vOXUlVbXCSqv6zWMKydBpdhtXFlSA5COnYUVC2VDI3BXSRO6MqMvuwzPV191yUuFIfCSHpJOZh1/iUnob+aosB2oTw68toH6V1+qpAKsANiXnSOb6+uDEkkeASQg4lS7mX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xK41zBb/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d066b532f0so4896281fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706740649; x=1707345449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ugdn3z0/uQcbatROe8KemahKg/7jjvyhRHQgV89WdMo=;
        b=xK41zBb/Lj1h91UQ8DKnG2IT/SiD0N5spF5QLZZ/SQ7h8F4J3uzdRh1KRsrtPkX2HH
         W+k9mn8r46yuDQySDv01qsb+3gStMFt5EDnapwsCaBIzKdCtzFkY37TxxDO370nIXYlu
         R/MerCWNhhHDl9pLFr5z7e2029SwFr3CDjnPHJwoMKBDoz5tohUFQiFymkiP3ABahN+C
         1QfIo7+ZOZciys6lVQtwmh0GSJkitsMsdYjpwzFnE91uSJ/HAZj4djVR1z9fok7ND53r
         MRVRhutbPREJ3oL/fx0OCRX3PDoatWOAa/+s6vBA0uQY9lO9ueVDjUxH37G00JyW2++w
         ZGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740649; x=1707345449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugdn3z0/uQcbatROe8KemahKg/7jjvyhRHQgV89WdMo=;
        b=PrLtqB47nGe/Y9AYbqQIVqtMfZxzSiyM8SpDjL3SURf5Xkmsrpxr6dEQmVJ+DOZHBW
         uzN0/dMLJGHBHFV3QQnYQj6usrTUo4b68WHY0ylQO/KKNjyDI6iCmCZfjDhONIolxtFh
         C3rClE7pBpCLm/uapBbUKfgt5JFzJOLfG/tGRGerT226kd4AgtTmKhUN5sSCiovaBAPs
         Q6dmDW4AlwQFyHeaJDLN2lmUAnCpsrapYtDjwlg9OrS8Ae/lJU7iUhRgrwhsAfE9y79a
         0RMnqTiyWflvVuHp23C/pb9kpwaFqrQlDd/6MPQvkABxGPAAA/oRbtFUO2vvx9jyn1HT
         8mCg==
X-Gm-Message-State: AOJu0YzaPERyx/PoEOZqMo1JXvQfKvdvBw8U14DxVH5OVHcYG2nexJei
	guof0jLduigdTkYUQ2gXUzrpR9K4LbQIxXAfq6fruWsbb7zvQet65earYNAJc8A=
X-Google-Smtp-Source: AGHT+IHpMnm1d8vLLtzUTLq39bCw1dZD+PGE4OO35/C+h81CWbe7/xfuSysDp+9/iHlIPVPxtuq6YA==
X-Received: by 2002:a05:6512:3692:b0:50e:7fc8:f40c with SMTP id d18-20020a056512369200b0050e7fc8f40cmr615587lfs.54.1706740649659;
        Wed, 31 Jan 2024 14:37:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1n2xLa5N2sdxGgFM2Mp6PPCu5n7ZYPla/ItamJtmzai0Ja480F4WO/7J69GEWvh2m5OQTNI2nCHqd6axJIyZ/qk7kRIeei9WHnKXHga3EMElD/lgPCxBQD7ORw3ltBA4DMFAmYFwIcz3sBS9FQYpVsVuiTaLdJNoK/NdQ28W03SDcX46ptn8r8OjNUf/I8ZUvQgigK/jUO6A0YPx4uLtLdn8Jp1vCYPHHBJolVXJM6yamXBuhFrLq+WlFVDJgYIc6/nz7TOM8A6KYcW5k3U/HLPtfR7Ccj5ODsE8bCLXV6jQIJ+RFCmk1MybpiiqRHxXuPAC0oRRNnXFa+Dn6HrcJ1CBQuccG22xhNN0vaj8d4vvQcjIhf3BQnU+ri/pSt5UjliEk36j1DG3P9fQZKteoMoG2oU4lH4OaVJ6+CeJDKdDnoKz4UCbfP035vk/QA0AJb+2SuPNbOs0KOA==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b0051023149df3sm1976021lfp.248.2024.01.31.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:37:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 23:37:23 +0100
Subject: [PATCH 4/6] wifi: mwifiex: Drop unused headers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-descriptors-wireless-v1-4-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
 Franky Lin <franky.lin@broadcom.com>, 
 Hante Meuleman <hante.meuleman@broadcom.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Srinivasan Raju <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The mwifiex driver include two legacy GPIO headers but does
not use symbols from any of them.

The driver does contain some "gpio" handling code, but this
is some custom GPIO interface, not the Linux GPIO.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 318b42b1896f..175882485a19 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -28,11 +28,9 @@
 #include <linux/inetdevice.h>
 #include <linux/devcoredump.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>

-- 
2.34.1


