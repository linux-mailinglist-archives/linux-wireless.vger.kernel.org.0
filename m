Return-Path: <linux-wireless+bounces-29832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC04CC748C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E2713107D1E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCF349B02;
	Wed, 17 Dec 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QmQtolJU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8A343D9D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969791; cv=none; b=TN2B41Vc+h4+doo7Qp61VEkXmedgNVyO79win2h7wXKZWIqTBKkZJhycJ6X6JDWodnXyE5zwUMtMyb5uKRyBrjlD3oUH6RsjP0nVq9LCYQPJKKg1mdDaTqCGYxeQujc01nfHVWzv6DLQXK+kfVnjej1SQCzNHaIpyXdod64I1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969791; c=relaxed/simple;
	bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQEZyBlQAA4wnRklgPaTS12XEPppwNKRLH9OHgXh0giSI2sHK5JxA6/QjmFOUeq36S29/KpLgKr4v0oOep0/bSH5cTbVYOvW5CMItpL/X4hXHAfcfutm3G/CeRWps8jBYpYM2dIlNgUJFN0bSXRYyYxdH+MhLIFKFF6KyAWC624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QmQtolJU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so203942066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765969787; x=1766574587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=QmQtolJUuW/qCucTk88jQSAs+EewoXKM64Eir2LcHEslPF9RvPYviN8PVwvt9pP1r9
         3et2hEc4Hwjf/KokfTF60BPnymf4y1N6ZSYyRqJktnsBW5E0v+exMuqzspgXWtHccaWd
         aEQXixQ88FwiUHeLaI78Cu8Ti1v/VW2+m72EuvJRQH2+u38j+ghPkDhLDqwnrPukQ9LS
         NawMoa58rPKeb9DyC8KuJ2tAr/5KgvvP2BYI5ni+ezFsqlK8UpmaHg+8aWKEkV8v/nOn
         d+t5kJGwhXmjyqzlZ5gVtOuar4SgvIlKI35yDvN6USz3a+lfnFK1a3oSP6XNJFyc9y81
         bYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969787; x=1766574587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ5P43t34Lz1EY6AFSYYgZN1NN5lPCazHIAbk5Krusg=;
        b=rsXq62XBslWiQxJTEOSHH9WK8mXzJ9A5D5DhP3OZkSuV9qtBIuMk9374hJZP9Q2kvE
         xw/tgt+sPSzW7hTAMOJ/QnNZwm6TJ9xgmevG5EBGHginTqzI6UdrQ0FiAVODjdgZfz3q
         Tquf8HUUeco9TX3dnyBTOplkGfn3aHXFL+FR6dXcyx7kGvi0t8+fTO27y1G5Ze0XYF/Z
         aam0bUm9hT7c8A27wgp+MoQPTNPdeDCD2li+PqWgX5I1LTn2YH3ZSgSMNQojUsEfpDI8
         /GfgVR6GNuCmeujV+tbnHX6r5yqsOki/yzgFBkx4QZFUFl11Gg/EPxPYtNkVMR1xZ+0I
         xFSw==
X-Forwarded-Encrypted: i=1; AJvYcCWGL53hFfpuYiT5Wz7/Wf9eTVQoVkMd4/9rBqy8fo1hS/6uAjXkW3KpgCfXkKjoiYBhznagpJl+u32wYQW1MA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvn6FMCU5gDeyOWaY9HNbhg3RbYYANdpsGs4n4mtBj9FkfTY2x
	5hGSB/h9dOj5WQ/1nAWO7Cx+dpKfUJ1DJ85m9AJWOcJKj+tHZAvZkbAADkLgmTbIR+k=
X-Gm-Gg: AY/fxX4B4VU9yC+QhSe5jqbkS6fK9AArRMmStUSVV2mYzy0r0wRnOqd3yfC1NacSsW3
	rua0Ivs9KwaRqtT5q+bFd/1cDbcGHNu8Ou93HDcvjCyVSL0DgQdoz4i9avy19GRfx5biE4hg2Hj
	WF6vYcTeEsQzISR2KwzY+aznoi7RTbc6WMKC/gGgyDADUiG1JnG6g6e/si+iPNQc/7d98H9w5FK
	NNXBJdqh27T6AnbYR2fiYq2jAVYuo6f2ROHKwENRz68bFidvp57uu2FyfcjyhKfra8uQIdZrZtk
	IX3anBA4QzreW90lIfQLFj8FuGlc/d0XaueU/ZV+GYV94bNVSCNJN+LT3lChZCajdbmqArT6bHR
	e5NaTj0DT8IMK3jn7Byo6u6O1g5O8JhZzpTqn8se44a1Q1plrS3k5KhuwrG3MEfZr0cOWDztLCt
	hjHr4e+58oUcMiHuel
X-Google-Smtp-Source: AGHT+IFvzs7gbTYqNv/IrH+Io0Hb2O1HvOFutj73wppNa2IfoOa9tOxTbg/zFDsIuwFGVu6mAhmfDA==
X-Received: by 2002:a17:907:3e08:b0:b7c:e758:a79d with SMTP id a640c23a62f3a-b7d238fa0cemr1785176866b.37.1765969786896;
        Wed, 17 Dec 2025 03:09:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5c8e59sm1971004466b.62.2025.12.17.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:09:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] wifi: rtw88: sdio: Migrate to use sdio specific shutdown function
Date: Wed, 17 Dec 2025 12:09:26 +0100
Message-ID:  <fc0282fa38f4c62fdadecc5622d7388c3d12657f.1765968841.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765968841.git.ukleinek@kernel.org>
References: <cover.1765968841.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4923; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SkcAEzo7i/6i/n+AriKV4xHUsY6KE3N6pRVzU1yP/iM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQo9sOPlvqvTSgB0Q3DAfkaqL3uclOe0t2At8i JEhuGlvagCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKPbAAKCRCPgPtYfRL+ Tv8hB/93CYUMggD8g4pqmoGjAUQVzbPT4ksM0WDss7kaMLvVS0XImkhyFkgEbWW6KFn2F2FQanb QmUjimhEXuk5lYyJzHZ0k5cYaVHr1/RuqItYa9ApNf0Jypi9px3vIuimCyc2W4BS5VL8kktRgSP 0U2CLhl63nX6Mb141tWWp83k2SY8fquzEY96jXtq7/mM2yGVf1gx9whJLhjBmKJpaqwShFh0zFU WIvZ7HzM9pUDmSvs4f6KHIXrIs+YSPU6XJinKn3sQu76t9LYN5aKbzgQXjJ+EV8x71O296GnuV7 HIAiHU/uy8Vt73PfImZRzg4o7zYiBdYGMecyOE/2AIJn80xd
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


