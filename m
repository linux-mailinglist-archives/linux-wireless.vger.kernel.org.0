Return-Path: <linux-wireless+bounces-29833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F9CC751E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 12:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A59F3014633
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB829B766;
	Wed, 17 Dec 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qz8Gu667"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63D299959
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970418; cv=none; b=qEFJ/kLtLjRl3uDGSVGwmsZMiA+k+mAzg+oRWh9+QwrLb4saM5OUWbJUk7i0u+5C3S5ZaZ0teogQrt7IEvEla5LA80KFBgEUf6Z/59cL4izVdH7VPJQrNt6pomInQZzp6RxPcKXARgZXuLIHZmU56b8X2qoIkL1UlVSCBuTuyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970418; c=relaxed/simple;
	bh=ZFfXbg2mJ7dHu19bR6c6FA6jSvjUPsMJNE+OX2pqUNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ui91vhTj2NUaR1v8XvSoal2kutH2skcpQEu0zs7i30iHMG1y0tfCXcnosnWhNZb3eVfAfD/7Pox4P6fDfYc6kfIk0ZC8zmOZvnowW5zMjrIfsmV2PsATmFGR436pWWptrb8QYShpnKAayPz2Egi5eEbCy6sYgkFIrOg7WHnpuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qz8Gu667; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6492e25cd7eso790245a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 03:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765970415; x=1766575215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7K/g3qWszkLj6rEGN9lZXfO8HVd2+Y5dHCAARK8V3c=;
        b=qz8Gu667kC1b++MEao4U7C7E4zuLOo2AIr9jjvzANQlzEfciOt/VH/6pG7V7ji8fUx
         y9dDAJnJKVVMWJ274AM+R4fEBhnwftogxyiodM/NBrEiXIPEoSZ3hfG4yfjLxm3k7ckP
         AEQcVpDRM+NmNJTFncza4KMRI51stcRtgOwiuO7c0PLrfut8foOf557AWFA4w0ruDTEN
         BmznVoelrXGIvt5792lKEF6KJRgrA3wcKdJ7enPw/cHXbJKz87UZvHENNAVzwom4Udqr
         M8b1PWoehAz8tvWA6au9WAJSAS9PYngDE4CqQDSM9kRFZl/REjBSIY7fvHvNFlHnGf+M
         0XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970415; x=1766575215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7K/g3qWszkLj6rEGN9lZXfO8HVd2+Y5dHCAARK8V3c=;
        b=NpWt+2kGqz4hI12q9gTHVwopGJjiKFaIKkQHpllUsCjAd207AvfUjp9u+JZgStaxe3
         FDdZwJBdLNyE8+nI82mDY1gmTYHT3hOKbQAcpmDWPQQtkiAMrdJF0w0KXJIII2T4Sr4Z
         p8L4HedaBGJtAuq6BCYE7o3n7X2IiwQR6axoshCTmcag603E8UHOQV73rQmNMwbNR5uI
         P8i8HXdcEvppB9ypKx/d6qUpVwUMKRNyx4WTODrmbOTzzcJ97IHyZpmjUCkevqqKfdC6
         iN9W5HZYAUR4fDeUdc6bpH6pwRruJv9ykvrPFIZek/9H0WF83YMlTbEc1CIB5b+I6DDz
         AqYg==
X-Gm-Message-State: AOJu0YyOi3vZ15HbWHOQvp8EyozWOtLWDapAfMMCYkeOq/IGJnJD+ID8
	T7t+411V41oUlARym4w3NImlePxFYqp8+GMxEWTFmRb62ESI/7rvqbY+AlKTuvBpiyA=
X-Gm-Gg: AY/fxX51o6BeM1typ5OAWQIZZzVPn7bIsN39DVLKeYQb840ury8EGUcY6z3LhWivmW1
	8z7DRYZ8L2IcoWro9FhQETM/S9cqKMs9MCp+oKMIZgrDUliCw1IHhSdBaBMXK7PhbdAK9V/4gkp
	I4vU6lYxvyv15WYUGfez+Ll4mmFPec6DpvtOgHsjRYxl6A/WhGOJ4UDLUXy2kXubJANfdzq4SZd
	wxj7gHt8k6Cv+wpK7QJ/6Jjy4GQl/66bq6kySdA4F8sFLeIMwia+ttUQBHuVVqLHQnebHp4i3Qz
	l/bEILmuuLRPSOc6HpTA/wgBWtA5ZabMcRkeVKkTK9AReJ0Gi7kmM46MMQjRvCdZMaGtxxiCSX5
	1p02fHQ57pxjIFfffe9zWE0y2bN8aRAJd2Voly22gs6jxHK3IMiSuNgfr55uSgEkvFHyKtTpkky
	dHO1OGZ/PUVNSVRI35
X-Google-Smtp-Source: AGHT+IGk/vMs0Y/8IAFkkYtyZQPYHoWx5S5OkIRm4mjVmZQgLfn2JdnDDE3YseixkDN8FQoAB80h0Q==
X-Received: by 2002:a17:907:3e9f:b0:b7c:f120:bb23 with SMTP id a640c23a62f3a-b7d218c741amr1939999266b.30.1765970414538;
        Wed, 17 Dec 2025 03:20:14 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa56c152sm1894606766b.56.2025.12.17.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:20:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead of #ifdef CONFIG_PM_SLEEP
Date: Wed, 17 Dec 2025 12:19:48 +0100
Message-ID: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ZFfXbg2mJ7dHu19bR6c6FA6jSvjUPsMJNE+OX2pqUNY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQpHXZMxaPmZctaXt6GmvbLp0X8QdL5c2erM0N FZ7hna3PE2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUKR1wAKCRCPgPtYfRL+ TvagCACsucvp3ue8FusEVS5/Oe0keuQSnti+nbsIvwoweqz/pm6E3tJaW6PGRfI93LoJKsyXArQ R0onltcOO037HhSFzIb0xMqSfbXrPShoo9eyHSwetnofbkEpBS2mywGhO86ECtOMOXxptzj8YSR e9NWzXtPM45rK3EURD2/WEXhfofOhHsW41wSvPeBKLJ1I/433h7ZFOo+eEqxK4gZHAAzk5l+Aik Xn39yGwdv3tVc/xqxc0NTLT3gVoMOx4IqKcxJle5ShcXOWG5zYfNE0A5KdS3NmjHBgxjBZKwvxZ 8CN+ctzhEWNr46Ju6E3Msd62YGVBxHt2GNVYTj3sQqjj58W4
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This increases build coverage and removes an ugly #ifdef block.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I found the patch opportunity while looking in this driver for a different
reason.

Best regards
Uwe

 drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index c06d50db40b8..3efe744c0c96 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
 #endif
 };
 
-#ifdef CONFIG_PM_SLEEP
-
 /* Empty handlers so that mmc subsystem doesn't remove us entirely during
  * suspend. We instead follow cfg80211 suspend/resume handlers.
  */
@@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device *device)
 static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
 			 ath10k_sdio_pm_resume);
 
-#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
-
-#else
-
-#define ATH10K_SDIO_PM_OPS NULL
-
-#endif /* CONFIG_PM_SLEEP */
-
 static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
 {
 	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
@@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
 	.probe = ath10k_sdio_probe,
 	.remove = ath10k_sdio_remove,
 	.drv = {
-		.pm = ATH10K_SDIO_PM_OPS,
+		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
 	},
 };
 module_sdio_driver(ath10k_sdio_driver);

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


