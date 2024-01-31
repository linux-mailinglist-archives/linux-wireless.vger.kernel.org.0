Return-Path: <linux-wireless+bounces-2862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBD84376B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A791C23AAE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C254FB1;
	Wed, 31 Jan 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4gH3AKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2754F92
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685013; cv=none; b=DCGFTD1100fD6YcqyfmVRvIXeiq8UlqWd0YoyZakl5so8uM5/Pab8ExwAzOsE/c2novk3X5Fu50OxlM/2umV0MEts4zge2lZfwTHWKT7ZUXALz7soFGmnZp1MtJ0C2jaXvlSJ2y5YvHg8C243c1lDZUBEf6zWEHFJCtSFCcUuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685013; c=relaxed/simple;
	bh=N7Rb76xtAihOSGgHLIxPhp8qnHuyGM9SCr1+zt+seug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O/KeCiaC48V5/Nq0qnr8U5cecnq6qazRuufV7MQlPrWQqSikHQcgjS0J+n3s8M1X4SN0b31y7qFq8Knbz5vuMQJ4EUQrDpKtH7j8EWcCU0Sh93fwUOqapPsRAIRG0uV1liRF8PbH+l38vzgTWxsdxWXRe9HkxUORJFXzB2sHSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I4gH3AKn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso60394965e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706685010; x=1707289810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzUML6NehRjq09oGSxNuYEWmU/TVTg/6MOHGTd1ruRM=;
        b=I4gH3AKnp82W+TeZRs7LUY7owupBFxsM5AZgX1eBBONeKyj0xCZ/B+jzIKEZvyMDbJ
         P1h+7QvX6bQ2LJKpGJIltrdnvODq1Jq+ulP0lzfx6TIuPMbxzCMYtcg6hdYndwdYsmC2
         o2BNeU2x55XI9Yhlmc2RHS/ZHIBAZMKhK+26esbTFA3y3qKnrOPRv8UYLUyhkySqW0oJ
         /nrCeKbSEwlME6c5pQFnrHwAgW3Lj2fk/jvYM11YJZdOLHsjhp/1uDD/3k4DBBsspIYF
         dC0IF2A24QNfGMs7FkXs4Ri+cGDWD0qC1ZRxWaak1X/3EEG53BKF2OOMNuMVH9VbElLy
         AswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706685010; x=1707289810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzUML6NehRjq09oGSxNuYEWmU/TVTg/6MOHGTd1ruRM=;
        b=auutF+h/MP1uWSsf9qHokGkgU/o2O54rJwbbQQR6wgjTfmw51jCQZKhqk9BNlDVhTh
         bw9n1Q4sBpIJjVrkz/cLjoT7EcRc5yCD841J/LbXNdIXL+bRdFm7Kb1iRjj2Q+uXr+Ty
         s6EI+Ai8aMQZ9DUzEheW55ABhBbh4w7ymI3N2/ImByoQVu1EYa03Lgdyv+BSRhAIk2Dd
         xhs+tR59phj/mBgRwteaxBoiQVcxIubv5WiYoqqepbkLOmD87ARzw2H5mzhx71mjopuC
         XLQKcfpNA3M/AtpPYrnLJS2Kr9a55dFFIZbqiKrpipC/3C9x1As7kNWnAGnAcOvkOssw
         uuUQ==
X-Gm-Message-State: AOJu0Yw8wG5843yGL4BalmAc/QQne8U/GjUBptY+hWEnYqlBWHLja5qj
	HkPsclGOoc6tm+Yd+gMugZPSEvvgaZJ4rscJr4SvcuQdpD1HFslYhBy5LPqKdw0=
X-Google-Smtp-Source: AGHT+IGOAuMjabgFSTRl/iF1SMdls3jHR5/paMKe+B+jUUAkMSCYfYfWIthewE8vE+w6Sj6vwl1wcg==
X-Received: by 2002:a05:600c:45c6:b0:40e:d332:bb8f with SMTP id s6-20020a05600c45c600b0040ed332bb8fmr668333wmo.5.1706685010527;
        Tue, 30 Jan 2024 23:10:10 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c00cd00b0040f02114906sm650532wmm.16.2024.01.30.23.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:10:10 -0800 (PST)
Date: Wed, 31 Jan 2024 10:10:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: fix error messages
Message-ID: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The first parameter of WARN_ONCE() is a condition so this code will end
up printing the function name instead of the proper message.

Fixes: 3ff7a05996f9 ("wifi: rtl8xxxu: support setting bssid register for multiple interfaces")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3b954c2fe448..bd6fd3120562 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3593,7 +3593,7 @@ static int rtl8xxxu_set_mac(struct rtl8xxxu_priv *priv, int port_num)
 		reg = REG_MACID1;
 		break;
 	default:
-		WARN_ONCE("%s: invalid port_num\n", __func__);
+		WARN_ONCE(1, "%s: invalid port_num\n", __func__);
 		return -EINVAL;
 	}
 
@@ -3618,7 +3618,7 @@ static int rtl8xxxu_set_bssid(struct rtl8xxxu_priv *priv, const u8 *bssid, int p
 		reg = REG_BSSID1;
 		break;
 	default:
-		WARN_ONCE("%s: invalid port_num\n", __func__);
+		WARN_ONCE(1, "%s: invalid port_num\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.43.0


