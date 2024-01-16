Return-Path: <linux-wireless+bounces-1968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAB82EC20
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2521F2440B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D4134A0;
	Tue, 16 Jan 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JqqkiZcE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="psEAkt83"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D1134A3
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705398605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ztrJOD5K0I+FUu+Q41J4ZBV+Owrznk89UH7oNj0zBvc=;
	b=JqqkiZcEWtboMda0N2YB5Tkv7tNxCHrG57YWZng4ncWmgLHPqFonLwiskS3im4KjhTDWG3
	c3SaButcvYtePhV1RVZm2UFqBXNjfoWpRXg5ZobaqpNfj9h+8YTpAE4S4R/ggPlyF3kqjF
	Kpv7oSosiJ/9qSeWHwJ3LiWB6b/zKNcCwxEan4I4spYpu43KUkTFJQhOmFTepRkw1sTkZu
	ZaDUnLNTPnvk165TFsC9bVQAj9q7fueY0sPZH4vihhtY51hhHtz4g+q7VGjlUo4bBIutvr
	mlzm80kTMqlz8O34Y50shwbdvYbZwl+ahsIAdS+8ST6wNABHbZHYApd/SCU18A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705398605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ztrJOD5K0I+FUu+Q41J4ZBV+Owrznk89UH7oNj0zBvc=;
	b=psEAkt83HEYBekPJyFIMjyZ9i5caEBtLhzwKkZOqe156cQMrzWaygK3czN7KCqWHuTa4Z8
	eYw0Uj+LALLP4eCg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries for all variants
Date: Tue, 16 Jan 2024 10:50:01 +0100
Message-Id: <20240116095001.399500-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP
mode") introduced max_sec_cam_num as a member of rtl8xxxu_fileops.
It was missed to set this number for all variants except 8188f, which
caused rtl8xxxu_get_free_sec_cam() to always return 0.

Fix it by adding the numbers for all variants. The values are taken from
the vendor drivers and rtlwifi.

Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index cbeac9386ae51..afe9cc1b49dcf 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1882,6 +1882,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.has_tx_report = 1,
 	.init_reg_pkt_life_time = 1,
 	.gen2_thermal_meter = 1,
+	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
 	/*
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index b30a9a513cb8b..3ee7d8f87da6c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -613,6 +613,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
 	.adda_2t_path_on_a = 0x04db25a4,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 47bcaec6f2db4..63b73ace27ec7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1769,6 +1769,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.needs_full_init = 1,
 	.supports_ap = 1,
 	.max_macid_num = 128,
+	.max_sec_cam_num = 64,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 585b1a5eed69a..21e4204769d07 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -2095,6 +2095,7 @@ struct rtl8xxxu_fileops rtl8192fu_fops = {
 	.max_aggr_num = 0x1f1f,
 	.supports_ap = 1,
 	.max_macid_num = 128,
+	.max_sec_cam_num = 64,
 	.trxff_boundary = 0x3f3f,
 	.pbp_rx = PBP_PAGE_SIZE_256,
 	.pbp_tx = PBP_PAGE_SIZE_256,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index 871b8cca8a188..46d57510e9fc6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -1877,6 +1877,7 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
 	.max_macid_num = 16,
+	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x03c00016,
 	.adda_1t_path_on = 0x03c00016,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 15a30e496221b..ad1bb9377ca2e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -510,6 +510,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
 	.adda_2t_path_on_a = 0x04db25a4,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 954369ed6226c..9640c841d20a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1744,6 +1744,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
 	.max_macid_num = 128,
+	.max_sec_cam_num = 64,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
-- 
2.39.2


