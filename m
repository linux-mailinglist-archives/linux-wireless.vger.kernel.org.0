Return-Path: <linux-wireless+bounces-29970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050FCCD128C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C483302D13C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33124A35;
	Fri, 19 Dec 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z8Omkiow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F1243954
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165549; cv=none; b=Stssa0i00Ako18TSnDI7I1woJ38rLcM3C/tLPphc+BzMngOEfw12SQpRIoqyp1Egm/yjMpMz4l7eXu+sr69ye7CUtyUBzJXbiPc30y05223pN/7wO4AW4we8xF7v7WOfVaueUrrP/L0FbJFqvl1kN8qCkO/KHonfkDZGqsSMgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165549; c=relaxed/simple;
	bh=rt0lFEmXebBaMS9sI6UDyRbyWki904m2XSOx26JxHEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qbeOrmC/GBykHQTlggJDu8HS1WofXcQb8svlyH/0sSyMoWaB1nMudBJr5oeC5eTJp7CNyjHbJyv84nVJWnX1ddHlRoJJfWjsDODezwF/QxLGoPNd5t7GURRFbkqjl9D0xgrndjZzhqHuWm9IBf4in6EhcMNOn0Tdhxmoh8oeQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z8Omkiow; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1417331f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766165545; x=1766770345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwHoRYN0ckLey3iJ1nZsSnX6RQ3ya+uPXkQh6TLApt0=;
        b=z8OmkiowqkAfgTbYi0SfuGuzSJ6pVWyUMH/LlukFkt2NRiXZ9wORlwd3ohF02fF+Um
         mrPGVhUYas1/1wcN09qq1xuA7m1Sy3FU81hYvl03bsbBLZdy4fHc0qjNS5BsgoBzb5/d
         tN2mgGyT1zGhpHK2eLRR8ZL92Uanq6nuIoJhbdZXtN/R2hTof3/7v/66fLshBs+AtL0F
         zp4bfozwPeauIf+UX/fOE6fjsy6E9PuFu8yS0e3wW9V2g8kNu/5SXq6IR2cFKIQte+Ah
         Un3I6hPSSQk915VvpuTY3HT+VrZ/GhMtUHhptvhViogO5PrEvNUKHDbdCoFWCxWR6812
         4WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165545; x=1766770345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwHoRYN0ckLey3iJ1nZsSnX6RQ3ya+uPXkQh6TLApt0=;
        b=hC0kB6pBFkm36SunL0JoaOT8Jxx9LRWOMNKUAbqOJnQe/Rdr3GdOkHUnnEwVlRkigz
         J+tMP6cA6qQkcJezhIm8XwghMIJgwSxDVMOWtXI9vs7NLRSNgTRndqkuRAYElobN4ceL
         Ccwc7iYrE5NRcOxTOkpPK8lW4Aqd2aLXI3A4xkTiEsLGMkcdVEFGAmO/z21dIFxXMI96
         muaSpVi/EBqULQgkrF6PS49mNr0mY5wcJzd1pAUEDEM7o6DbM3Xkv3/PBkKapCwDlRZm
         Iub7vXGljkbV9svPk+GNCxlQLDr7bjiQXLKtOo3WIu4IP7Wt+tUClW37BevPSbhIxfvX
         LWZg==
X-Gm-Message-State: AOJu0YzS7/52b+i1pkqZFqg9d8Ud4hi/rI7zcIdbABNSpCUCVkisnCv3
	EWg8dIe+L5CFVwHfAyIiCkx49lmSIwIvd8/5Wki5eAy+pZpCTDjTvZ64CBxOAWwCUXjXtICOq5k
	OEFpE
X-Gm-Gg: AY/fxX5Rs5Pb67hSVNfh0MC3x5Air0/GD5OTeWFoRPG364CMNS206e/7aTcAQM2v1b6
	Gzo9yNF/DItwsn5egT5IGK59KsOkfsPfhgKLmaFx2IOK/XktRTR0x4NycKQMD2oEApi7bdhJVJz
	vJTyp57hcqCAUmqZhoYeyxxhokx4sHycn0vffL8MA3bAxTQmv4/SjJUB5cobV8Yn9bhT9CPD1eN
	3tXddix9+4vczbzvsame9T4PB2CFLqUvEuS4RKjL+ydt8IkoiQC8layCAqlrZVzq1H28iXqjVVw
	V7pG2Rkt99mc8leM/MJAGm20oOb7+81rECVcx7EoLaKUD0rSf2IBNHEsqNlcdujmid1YDnliNWx
	wotFSQva+EMfsI+V8BQtQbWzNM8ByNNTt+kLcsb2nrzkFQC9PtDnexdWH7wFUsJGuHuo8nx/a6D
	hVjz4dSlb05XT8VosLxXqbe3xviKpAxpg09t6Eqhzoc7AePLrspYzXFQnlA7YHszMEozE0BuoiX
	TI=
X-Google-Smtp-Source: AGHT+IEg4pPUc8/Q170AaZf7FYqcz8uROUOSAycDgkICbrJRTuPymfOwn98l5/ziSfJUCccINtj5Xg==
X-Received: by 2002:a5d:5f96:0:b0:430:f1e8:ed98 with SMTP id ffacd0b85a97d-4324e4cb8efmr4074083f8f.17.1766165544689;
        Fri, 19 Dec 2025 09:32:24 -0800 (PST)
Received: from localhost (p200300f65f006608b2d9668c60491dc9.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b2d9:668c:6049:1dc9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4324ea227casm6129410f8f.15.2025.12.19.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:32:24 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH v2] wifi: ath10k: sdio: Use pm_sleep_ptr instead of #ifdef CONFIG_PM_SLEEP
Date: Fri, 19 Dec 2025 18:32:18 +0100
Message-ID: <20251219173217.768713-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=rt0lFEmXebBaMS9sI6UDyRbyWki904m2XSOx26JxHEI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpRYwhcJLnvpIJtU0AMygZlE7lT2uiPwCN+n6tn MRr/ee4e4qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUWMIQAKCRCPgPtYfRL+ TnIlCACDhfva2bnNvWGJqTs+RYgiGpn0toEFs+gQ1UlKiMDN8PStPMVR3+5oS77nVCBWSItIeQ6 iS0B9Z209X6nlZaX+ZRJ65cJuNPQzvwuogR0gjtTGlx2EkQ4Nz3RdDxWgl4MbpKk2pIoCjHGvYQ Ol8tPBOnUIgV1Y9prpQnrvkzvo6E2gugxsd1Fl5wsNKHg4H89TvQbS4vIaBJ+pK3dbuwrBq+bXt Sy61GVjTAzn0TKtypqyJhcU8uLrYofEIeuB/X2d15SHsG+pEiRGBaMLTHdUa0dpsg9AmMlzimOp tcdaC2oVfT3DxFQoE4KeUPgmdKhcOHApbytw3myjOXtWQPXJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This increases build coverage and removes an ugly #ifdef block.

To prevent "defined but not used" warnings use
DEFINE_SIMPLE_DEV_PM_OPS() instead of the deprecated
SIMPLE_DEV_PM_OPS().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Changes since (implicit) v1: Switch to DEFINE_SIMPLE_DEV_PM_OPS() to
prevent warnings. Thanks to Baochen Qiang for the hint.

 drivers/net/wireless/ath/ath10k/sdio.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index c06d50db40b8..2e58fb1d2ca3 100644
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
@@ -2172,16 +2170,8 @@ static int ath10k_sdio_pm_resume(struct device *device)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
-			 ath10k_sdio_pm_resume);
-
-#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
-
-#else
-
-#define ATH10K_SDIO_PM_OPS NULL
-
-#endif /* CONFIG_PM_SLEEP */
+static DEFINE_SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
+				ath10k_sdio_pm_resume);
 
 static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
 {
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


