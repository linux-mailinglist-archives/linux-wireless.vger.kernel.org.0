Return-Path: <linux-wireless+bounces-1369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E66820F97
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Dec 2023 23:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013021C21934
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Dec 2023 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F93C12B;
	Sun, 31 Dec 2023 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP51pGsa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5263C127
	for <linux-wireless@vger.kernel.org>; Sun, 31 Dec 2023 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5d898162so32287385e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 31 Dec 2023 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704061149; x=1704665949; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KGQJ5FjhFFbfVsaHO4jI6fv2Pw4FD+n/rv+CPlsicA=;
        b=gP51pGsaQuiB/4cBXseNfW0+jQHr3+WBvpTs9kxBo5Lo4uCHXLyk+GzMQZpiopnVF8
         LJFDO3DJ4BFy9bgX8Z/Ox0NTyxiL9CbTWQgyKwv9V+rjjvnL4ZadNEYBtLwuVXlpC9NB
         rdepyXEZgU+aG/JIxwU7VpSU5tawecz9pisw/AZ76EOC6nQlozPnM59ElRjT50pRP6Zp
         TES5TP/TZp+9OJnuY++mOkJ6MUBGFmjTHkxMZaI8vcgvnXuhrFu+T/mwhTZcKCq2wLdm
         Tw2Di7BYX9CVyUrGEvsSS98CRFxzrKhcVn20Nwd1H+s7ypksf5wBQvMimiP/NnTTJXJu
         ZXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704061149; x=1704665949;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KGQJ5FjhFFbfVsaHO4jI6fv2Pw4FD+n/rv+CPlsicA=;
        b=YBMbbrQ2byvFm+Aak5HLBI7/bJyKvAxWyBu1SvA3hLLef7Ue8+ooYiypXTgdoOxCwi
         h7y/USxaHN7rHH0z+ks7McVL3uOCeJnRDY9iVZjEx8MoRRJ6nK+DVLpfXqoZkIfjwN0Z
         kLc5UHDX7wPQmA2jfM+SZA4YZNz7nvEzfBHtK/aI3FXwCoOk8IYDxmguQfcet70RKola
         LLQcydeiGB5XklrhYZA/GpL2xy0eW1n+9V4UcdVneKN7zuigcJek9+YeV1sD7mCE2Bke
         qIif9kSScki7twt/HnreaCfMWYUxuujRvlDa7AkXfkc/GPYZva/w5k+emE2Pqzc6jxuB
         xIfw==
X-Gm-Message-State: AOJu0YwMB/RYgG5WKPlwl6vD2/+YGo5TQ7wX9eT9vMuv98zFJFuj0IyR
	r1eQixNxYUnA44yxX6X9gWZ0D1dj9L8=
X-Google-Smtp-Source: AGHT+IEhPx9/rS348MKvtRlp76+B1bH4e78uMN4wiv/C+2chAsK0oGgzqLerhzL0Tk8nxyw/8idl2Q==
X-Received: by 2002:a05:600c:3f97:b0:40d:8996:9d51 with SMTP id fs23-20020a05600c3f9700b0040d89969d51mr32716wmb.13.1704061148742;
        Sun, 31 Dec 2023 14:19:08 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm46844386wmr.34.2023.12.31.14.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 14:19:08 -0800 (PST)
Message-ID: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
Date: Mon, 1 Jan 2024 00:19:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8xxxu_set_basic_rates() sets the wrong initial RTS rate. It sets the
next higher rate than the one it should set, e.g. 36M instead of 24M.

The while loop is supposed to find the index of the most significant
bit which is 1.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 180907319e8c..b9f3382bd67c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4839,7 +4839,7 @@ static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 
 	dev_dbg(&priv->udev->dev, "%s: rates %08x\n", __func__,	rate_cfg);
 
-	while (rate_cfg) {
+	while (rate_cfg > 1) {
 		rate_cfg = (rate_cfg >> 1);
 		rate_idx++;
 	}
-- 
2.43.0

