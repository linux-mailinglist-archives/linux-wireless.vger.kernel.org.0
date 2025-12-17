Return-Path: <linux-wireless+bounces-29834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE69CC7545
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 12:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A2B310540A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E853288C26;
	Wed, 17 Dec 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MEEjgU0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4481DF273
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970468; cv=none; b=OeMaL/6LVN+1uwgDN2djyG1FaQZcFdbkdMfG2iwErv/kez6/leryaPjZd57/0OJHf8JB6T79KrsPRfHAXpmz03xkQERDmxYpzPIwd9TSDuB29hiUfGIX8bYCrqrA4nU3CHZz+K79yF8HUL1jb0dQPBqCQtMquTzfbXFKIQO369Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970468; c=relaxed/simple;
	bh=iofObE93/phOu0/oEYr5A9LDgvj0fNnpYOw5yx2SC/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XFBD2sDq0bNhBRc/8wJREl+Ps98O64BqSarUxsVjv9wjjUu5kObvRnvsRnV9h72UnuxZ4OHPXzXlsfwElwiviOP1lt+jiws0eLuXYRBeRJOBUdPAcjZWXnVIVtEFaAlXXXSwW7c6DG9o9rKxn9Vsuv6z/7P55HpImDmN0xNzVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MEEjgU0c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so11213613a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 03:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765970464; x=1766575264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fEu92M2ic/70BObqgwVjA2LrINN9oLz6T1quAAebS4=;
        b=MEEjgU0cwPovvggk/zyfXGMZAnWLJVDlQVNL9MeH/YPm9Tdg7b41zI/+N9uzN7nngy
         TAu98b0eo90iWYZdI/S40UonwMr7BEY1K+gpNi/n54TuvR3K2hOzlIe9T7iS/KNNz629
         yBDZVo7R7EnWJC6AV3cp2NulQv+gwqIuqfdfZyD0U5w3v3LXiSEraUcKGYCzI5xBslnv
         Az3+x4sGsBx6BKBbjkJ5kbNua8m91AHHjlVbmoRRXURuP1vpV51hOeejLbtP27DJAdpL
         uRcV9PEFQhkWPGmXWP1hhWfHdSr7Dfa/72E3zgAfcbmn+vhYOPaDUWRSndhQF6e1h2Jh
         sxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970464; x=1766575264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fEu92M2ic/70BObqgwVjA2LrINN9oLz6T1quAAebS4=;
        b=CEbpWOp1Bhz3a4Ne9Y+YOyVvjfg+d+Puxe1d/8BrzflriNSq40eP9BodiHcav/jr33
         +H+K3XM48rmL7Czbn1GH/A+XFewPeqsw5u/Rs+TTGeEfUPHSrHnvS7FY8kBAuQvIdwaq
         N1To1g6gj5YkmDfOKJsfhY2atiqMeTTCC2krrlbdGiLCaJIe5W/Qb7rGoFyzi304T8sQ
         wxPShfcRZWJlCFtmGBX6Ri6pET4HF21dF2t8evQHhZBIS4J2AcF44J4NaFDGeSbQ/C9I
         My6f+to4H8lYJOkIHpzAmlTtamAbxrKqlNleuq/HxYbx3N5gbtOR7UJs98nryUpIsLFo
         Iihw==
X-Gm-Message-State: AOJu0Yy4aN46qMDW0o2ORYdzbpSufoIJzhfNWXEtKmmWiOJIzB4oMv2w
	/SwwnL1+xEmJNRGKZjE1XzXcWFFlBR5sbsgUmwZ6LxZ1QNub8Zz2CEmr5nJTI2bCMDgjSZ/nCNV
	nISZD
X-Gm-Gg: AY/fxX6J+mfkhZRm7/4jzvGn4m01ItHGxFbDPUR5lgKBlGd9pYDrGhboh+c2DRW7ZeB
	jQvMHMoXzT9zlaa7Uyb+NBBMxVsNjUksMc6K4+OrDI1gLl80tVJ8YH3Kv/6xk2uniQdFOwBA9Gh
	C1LJIJai6XB5ABnU6cz5k2wNfkASailp2wXN2eZV9HZ35CJ70L6QwgD0mSe/yT5BSqyPSDC49Cs
	H62P31xF9FFsqVfbVvxgPQad0b00nnKOwJpZXuzI+KUwH0BNq3BmcEmv1abDFo7GPHqgSbd99BF
	v/+7JK8mL2e/7SneeV0CnTOCzKRRfOxDT8QWCY3+FB3zBNUanVnGxRjaIRntdZVtRNNAAPuCcXu
	OLERXaUb+ieGE+JizYr+4Tur9RRkxX4LxbrH2At3ebFk5H8+R6QhMmKCQEQbNx/pEEsiUSBV/Rl
	JwPBotU/pXkKh/vS6I
X-Google-Smtp-Source: AGHT+IF/7G/Z7cJn8VN+D5O9GVscLU01Wvf1vpAEgyMC8zd7lLK/NKOV46RlU1elBCLbIVCJVqs+Fw==
X-Received: by 2002:a05:6402:350a:b0:649:9284:cde3 with SMTP id 4fb4d7f45d1cf-6499b30ff9bmr16052722a12.26.1765970464420;
        Wed, 17 Dec 2025 03:21:04 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b3f56b00csm2142796a12.23.2025.12.17.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:21:03 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wifi-next] wifi: wlcore: sdio: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Wed, 17 Dec 2025 12:20:34 +0100
Message-ID: <20251217112033.3309281-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=iofObE93/phOu0/oEYr5A9LDgvj0fNnpYOw5yx2SC/8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQpIEJ6jTGcHpEhhLnrQ9fjnqVZ/Gc8bWbTWUU WIDnflAI4aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKSBAAKCRCPgPtYfRL+ TvOXB/9plXPwE2lkS7XVgmHUpplgfU4iug7WrdKaO+RJjpnUVhhDbRkrQ7vidBqIy5sz4INfkML 3Ff76YwQFCVZqw5A92Rc09IdgBaCmAhKAk8p42nsWLyABfuT2/HsY2Pyr6EQ9OYBWvg+aAj43Dl K9GCv5QiwkBblLpt7kif0o2e9Bv+mfi9TXODRzZsHU925GT/OPV/BpJyGuA/hFSyXnxc443xeYZ 4GjSWgQaDMcpAgMBrsrXXK/mOhKoFxXUnrd2M3IvZAjXSXHRIpsPKpCbRjO4HW2XSZSXpZQdHxq roRCcTfZZhLkYBrl2OvpH28iJoe8kdnkJupX6+abLN+utHlD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This increases build coverage and removes two ugly #ifdefs.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I found the patch opportunity while looking in this driver for a different
reason.

Best regards
Uwe

 drivers/net/wireless/ti/wlcore/sdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index a73207bbe5d7..421d688ae58b 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -370,7 +370,6 @@ static void wl1271_remove(struct sdio_func *func)
 	platform_device_unregister(glue->core);
 }
 
-#ifdef CONFIG_PM
 static int wl1271_suspend(struct device *dev)
 {
 	/* Tell MMC/SDIO core it's OK to power down the card
@@ -422,18 +421,15 @@ static const struct dev_pm_ops wl1271_sdio_pm_ops = {
 	.suspend	= wl1271_suspend,
 	.resume		= wl1271_resume,
 };
-#endif
 
 static struct sdio_driver wl1271_sdio_driver = {
 	.name		= "wl1271_sdio",
 	.id_table	= wl1271_devices,
 	.probe		= wl1271_probe,
 	.remove		= wl1271_remove,
-#ifdef CONFIG_PM
 	.drv = {
-		.pm = &wl1271_sdio_pm_ops,
+		.pm = pm_ptr(&wl1271_sdio_pm_ops),
 	},
-#endif
 };
 
 module_sdio_driver(wl1271_sdio_driver);

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


