Return-Path: <linux-wireless+bounces-30705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33397D13CD4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74E5305D90A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F830498E;
	Mon, 12 Jan 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="daR1dITH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BF3126A3
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232838; cv=none; b=s0JUhe8H90e1EUIQIdwtrIAb5o6jfsbPlSWG1MjdF0jt/N0KAsBAUMS1Z0JvsxcPug79aH19d1dHko9YOI2w1adjBqZYbcce7+q591mrKXD9pee+TazNmO/urvKA5MimRvfvZESXL1vAVyG8BbolG1DswkGTmuHohM4Q2/9qHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232838; c=relaxed/simple;
	bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeXczG1q1nYPjWpFZJddA7IXvNEK6jsoEji2sFRWH6iicBsDzXaX2rOluolgR5Q1Pb3MCnGgQaLSVow7IGnxovsDxc+LnXGl0YsetI7/LOegZea7OX+QNWoe4WcR1AN3ki07ZliYK8WdHq5npPb+N7xX2viH+4EFhkRQkwLpjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=daR1dITH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so29679555e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768232835; x=1768837635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=daR1dITHXXAu7s62xAbAPxJZnsqtUWo3wZNQxGqs2obuvvynUtehiucvsizKbUqiSs
         P2QWgCnxSs3R2gyVr91nhBFXAtmfwDK3+dUozwNAA5JZ1YiX6U7GSO31F29JuwFAwI2/
         DntSBqY+bYBu3UqZb1VAy57UpPK+p4RkfOZ2KE4UpEpN9jdWJyHNqw0Ix0j8ZW1ab9lZ
         zKSOVT53m61s/XFC0mt75GoHKna3tDmdMHoUvZNR7lZ+svtG/7zQPUJH7oifW5DTGG4B
         9HE4vuUEd+xaIBGMmfN2nkJfhsHtXZHGr5l4Nfu78CtlMCrJSbDh/laM7rdp1qQma6jQ
         eY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232835; x=1768837635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=ry3MTDXSVuVWiKH404S4vcfPKIr4PULgos+iwGzXWdm8DKJLzJNZhnpxuGQAB9OYxB
         zIf8eD8b1D9MtPb8NfqfwGEfqayEZvvB4goVqQhfZSLs/CH+p4pRhcIqTg54uC2eOTdD
         eYnMEo/yzfHsnJG8ZMOM3z9ZtWWJUFPYpZV2JQvt+9CaUSwvUaGWuhhXld48o47IfGUd
         SGDeoLGUbpIPKj1zslMv6ODPKQHX8NNzx3WjcK1kLDdoMbk7J6vbR+xKETC98+secSQN
         jCrYXseDNO4VomgC/G4stkTtT9P9PAg77WuOh5MpKsnUGvvNJzMV8hzlP3MMrfzONlnv
         m6JA==
X-Gm-Message-State: AOJu0YyioIpSqpPPqRdwoUO68VfSf11uoByuZo0iIDluX5k4DwOmlWfX
	FgJnxA/3zceMmXDl6c+KoX3c45mEoDkjAogFh6IE4r5wzSl1eyPx/PTIkr6isFpKqI0=
X-Gm-Gg: AY/fxX6EEhbquUhF9oRCq5DmizPI7YxzU/6XEwzTH2XrRBT+1syihpn6uDBTk8JNzCJ
	xRfAOpUFaM3JnRQ594wWtP7R952TWYtliF8Bo9IzgKzdAKSctS5xImM70+j3xkGVCjsTkOhFAfW
	MxVNKJKh7V82FuPgNJeWq6hPpkIwOFs1AMfYgCEP+CLCJ82BkUpWRnC/60heJpNJEODA731oDoS
	YO2jSG8Aoro50aLIN5qLHXBz4sBO9nScF0jH1boyRlPMzTGcloKvz2SAOCTaT08NqW5N2d4CDD0
	JqzgHf91tvM+pb9mAnHfH0QHisPQLp452xYGQWIcTqdrgqbDzg9LruNprvxHxwrmWWwI7WFWzlv
	u5l+6tfMB3CMVhbyezrb100HyWa3jMF+08GciW7ThFkwN14kWsVJuA4/1qUHPyGYeuwziubSg/I
	vjqw/FuYM1fPvFZ/7ZigPt8TcIPNaRhCcYztLxYovfCGmfQj+2Ye716XILkPaUW2/CsL/l/oUH0
	uPtq1Fwxbk=
X-Google-Smtp-Source: AGHT+IFbP5oW/JB21vgOx2UKSKkyBkk9ayiRKjfoMXlXSkjwHyRMPYuhooj+NrHaf1R90PXfsoYraQ==
X-Received: by 2002:a05:600c:45c7:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-47d84b2cf22mr213320955e9.11.1768232834762;
        Mon, 12 Jan 2026 07:47:14 -0800 (PST)
Received: from localhost (p200300f65f20eb047d7efe6100b35af4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7d7e:fe61:b3:5af4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d7f4184e1sm349956355e9.4.2026.01.12.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:47:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: rtw88: sdio: Migrate to use sdio specific shutdown function
Date: Mon, 12 Jan 2026 16:46:59 +0100
Message-ID:  <5a328658c20613068bbbfabd3d0e721b69b3d474.1768232321.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4923; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZRd5ys/DMMtkhQ0/XITB/f7vUDN8rbaiOQhTD wb8ALA0oi2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWUXeQAKCRCPgPtYfRL+ Tgo+CACqYWP8EmIQslr12Uar0vd3QRIiK8h1Bf5stYibqZd61jKGlqAtmTSgb70e6VA1R6XLkrX /W4LyagZdQh7dbXHXlbl+Dxo0Cflss6w1Yq46VnpD+45eFrpgGO9Ax2PuzBVmvGPdCKEAt/E51n iBIgLQt4TCiEfke2titUzVBBv2Lq0BmhSf5aL67EhdzGtakKTVJ5z77HbHhu49Yhjn+v4StM2Sv /u+f3G9O3A3d+sdFmTqkpW8RrohMG+OB7isyFgPrJQler7ucob4K1FSgThQOZQnNRgf2riySV80 b4mLMlKFkQ14MDhE3pVj95ZWL1a6mNH6BoppkPwfMEVHMyUt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in rsi_driver.drv to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c      | 3 +--
 drivers/net/wireless/realtek/rtw88/sdio.h      | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
index 1f98d35a8dd1..2018c9d76dd1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
@@ -23,9 +23,9 @@ static struct sdio_driver rtw_8723cs_driver = {
 	.id_table = rtw_8723cs_id_table,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown
 	}};
 module_sdio_driver(rtw_8723cs_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
index 206b77e5b98e..e38c90b769a2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -28,10 +28,10 @@ static struct sdio_driver rtw_8723ds_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8723ds_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8723ds_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
index 6d94162213c6..58e0ef219cdc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8821cs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8821cs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8821cs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
index 744781dcb419..2de9b11540c5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8822bs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8822bs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8822bs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
index 322281e07eb8..b00ef4173962 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
@@ -23,10 +23,10 @@ static struct sdio_driver rtw_8822cs_driver = {
 	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
+	.shutdown = rtw_sdio_shutdown,
 	.id_table = rtw_8822cs_id_table,
 	.drv = {
 		.pm = &rtw_sdio_pm_ops,
-		.shutdown = rtw_sdio_shutdown,
 	}
 };
 module_sdio_driver(rtw_8822cs_driver);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 99d7c629eac6..ebd7636e2408 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1412,9 +1412,8 @@ void rtw_sdio_remove(struct sdio_func *sdio_func)
 }
 EXPORT_SYMBOL(rtw_sdio_remove);
 
-void rtw_sdio_shutdown(struct device *dev)
+void rtw_sdio_shutdown(struct sdio_func *sdio_func)
 {
-	struct sdio_func *sdio_func = dev_to_sdio_func(dev);
 	const struct rtw_chip_info *chip;
 	struct ieee80211_hw *hw;
 	struct rtw_dev *rtwdev;
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 3c659ed180f0..457e8b02380e 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -166,7 +166,7 @@ extern const struct dev_pm_ops rtw_sdio_pm_ops;
 int rtw_sdio_probe(struct sdio_func *sdio_func,
 		   const struct sdio_device_id *id);
 void rtw_sdio_remove(struct sdio_func *sdio_func);
-void rtw_sdio_shutdown(struct device *dev);
+void rtw_sdio_shutdown(struct sdio_func *sdio_func);
 
 static inline bool rtw_sdio_is_sdio30_supported(struct rtw_dev *rtwdev)
 {
-- 
2.47.3


