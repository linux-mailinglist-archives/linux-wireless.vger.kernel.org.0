Return-Path: <linux-wireless+bounces-30140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC111CE51C9
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BEE73009F88
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Dec 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32642D0C7B;
	Sun, 28 Dec 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGlMSQMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F32C21D3
	for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766934859; cv=none; b=CqXtn6Bn6KTjCKAB67aF5YwbPpXYwG+GtUTUnpIo2L5R6/yWsrCYRSKIVuH8bR8qmSvlXb7FIVqUFLYcjMDDu4YI0V137F/IuQuqElOVMCAz6depJWjxcxP31T2jdznlZkdD3U8aZVpiKeguEefk7ec6r4A/YTZzCiwTm44JFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766934859; c=relaxed/simple;
	bh=DPU/DvzNMItb5Qrx46MSTvFyvT5TKOJuCPMS5zGTXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyKNH/UbgBHpUzMyL6jT2O7i1GrNW1Ivm2Xofh+Hm+GnhR7kHsVOZXoAwEzAr6kGZkb7WKTtV6ncQzb5Uc6lWjArEIA751VUyVKsvVTfXDasSTEhZEYLWLLMaEWwVsrZB94Pc9PebOYXrKdWrbelIVhJixC8g6Xt/Srnd0Y1pMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGlMSQMy; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-3f584ab62c6so3570837fac.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766934856; x=1767539656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DhkrKrnhAYglYBvdgmFTu35O+fBVWrb0itD+SYPa6M=;
        b=XGlMSQMy89JkUx/ZckyO4+0BR1J+bX9l39FPZ7rf/fJJ0D/T+PwOBs7fbmoUXGxiqK
         M25aICzfDCmnnq1N9akDwzezf9ja+daKWJVeWeYuKqHR5cS4VN0DoGgMGynajjQaLZcU
         ExVhK5SBeLBzddeAKomoHGtj6pAidmxAIsSHQRCKThdKxo1X3GaT6LUB8OPlD2PtuLZV
         TnpMd5QdHErA4tzuWQ9NYK2hiHygYsSILC0Y6rhii4Y0LXnkyhaWS4ki7Q+i+wd5NEqW
         g2T0aCOVkDdWSPcHGIuFBx5DS90gcyUGXM1i3/TUcQeU4bru2bnwFelW8+F6bbeZCe94
         /s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766934856; x=1767539656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DhkrKrnhAYglYBvdgmFTu35O+fBVWrb0itD+SYPa6M=;
        b=PYfvDfFfT0AbD1aU08TWtGTaEQwlvvs0ppmFH1EQRuD+8miAjDbHA08g4+IF8g91eA
         KfLsN+pXkzLmslpaCFqCXD3c4AdMlFtirnl0x0IDPB/1nnHrN0d6eQEQX7DzzXnE4QyH
         1nMy2YkrLh/E4TCaZ7DQdrRKPyOs4Z9V+m/GOwSsFWY0RP6kTq4Ux9aGzoPbMMoWGWHb
         FcM4c/AmIiK2t588asoJ31ftx50TzUcb4aLgLssQzhRkw7escGdVyY8lg5uI8++HNQoB
         lw6YCnB7ONUjQSQvIJBGa5gFn7E73Z3dkcEf7MkjqHn69pAKtsKJsfV1dHJShfYdsZPq
         6lRg==
X-Forwarded-Encrypted: i=1; AJvYcCXYzwfHgPnsgp3QOwzmvu/iMowtpxyUh8X8yUN0fZF6D6/Yb2hRh4WdPFAJ8ZXdW5Cywc1EUJM/rjQM3LWhTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWp+wHcT6Mr4utDylxFOqDGVvV3AkJAySVZ3gg3aM+HGcehP7C
	W/i/IWBg3j3eg0ibhg+SQZWqfHohVJ7bmL72qsyKMPfctVp99+HjDzzQ
X-Gm-Gg: AY/fxX4a8CtqlReSen8b1qpQ81tczZs4Zolpr4mmb+HngbJc72rPLWgji2PUfdFyZFh
	0zqxb6Xr8UTdyNaYx6JEFAne0zjLkZylvuE9ansAuWfAlgteACusUvGbPuld/OlzNHa94ePw/cl
	cXjOqbr1Sx4OUk+G9ArP171ljKoZJ4k1RgFgUApJUStBi1pX4WBqxvcTpFSKX/pjj+tmXq+wsBM
	yFaz4xSIwR9hOM1ktXt0VBaHYzd62yEMmwhaZdhDiepiSeWFAI8Br4bUqijuyDOR0T097w08GFi
	l/6CHkHnt85nvpg/QbhSSnNh6DYXOMlC6jybdC/CnDCaEDVpDjv5RiV2YloePYE4MePai3nirg/
	tGNQp2DT28sHQOmfrWq/nCWwguZlD+iQrsxpxTfK1KvYU2ZcA8pEKB1XH6IzHyRiFIQNHO2ycTT
	+LmqVXtAKUUQ7D4QL40zHvM127dikZ1DxQ+5q6mkB+DSGk8n5RFQM4M8f1u7ukAEDgVbNMI9qMm
	UL5CxKR5p6X25t+Pdv9JWXZhFod
X-Google-Smtp-Source: AGHT+IECc+U3TVNXp3czTIzSO9Z76x2G0HYELfxJXcOGQhylpsHroDwr7oZCfOdlfaVh0fuMa8pTKA==
X-Received: by 2002:a05:6871:546:b0:3c9:415b:a282 with SMTP id 586e51a60fabf-3fda55f32fbmr13567686fac.1.1766934856314;
        Sun, 28 Dec 2025 07:14:16 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaabbadacsm17461426fac.15.2025.12.28.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:14:14 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: jjohnson@kernel.org,
	ath11k@lists.infradead.org
Cc: baochen.qiang@oss.qualcomm.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Sun, 28 Dec 2025 09:14:05 -0600
Message-ID: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
is initialized in, core.c, a different file than the array. This
spaghetti-like relation is fragile and not obvious. Accidentally
setting ".max_tx_ring" too high leads to a hard to track out-of-
bounds access and memory corruption.

There is a small ambiguity on the meaning of "max_tx_ring":
 - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
 - The highest number to use for array indexing (there are 3 rings)

Clarify this dependency by moving ".max_tx_ring" adjacent to the array
".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
instead of #defines to initialize the length field.

The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
so use a constant to express the correct value. Add a static_assert()
to fail compilation if the constant is accidentally set too high.

The intent is to make the code easier to understand rather than fix
an existing bug.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

I am trying to make ath11k work on IPQ9574. My device uses a IPQ9570
with a QCN5024 as the 2.4 GHz wifi.

I spent a few days tracking a memory corruption bug caused by
erroneously setting ".max_tx_ring" too high. I think I would not have
made this mistake if the initializations of .max_tx_ring and
.tcl2wbm_rbm_map were right next to each other.

Changes since v2:
 - Use ipq5018 rbm_map for ath11k_hw_hal_params_qca6390
 - Drop unecessarry static_assert

Changes since v1:
 - use "num_tx_rings" name instead of "map_len"
 - make sure debugfs.c is correctly updated
 - add a static_assert for ath11k_hw_hal_params_qca6390 special case
---
 drivers/net/wireless/ath/ath11k/core.c    | 12 +-----------
 drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
 drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp.h      |  1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  9 +++++----
 drivers/net/wireless/ath/ath11k/hw.c      | 19 ++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.h      |  3 ++-
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 8 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 812686173ac8a..07199ceecbeb4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -100,7 +100,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
@@ -184,7 +183,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
@@ -271,7 +269,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = false,
 		.fix_l1ss = true,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -358,7 +355,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = false,
 		.fix_l1ss = true,
 		.credit_flow = false,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.supports_dynamic_smps_6ghz = true,
 		.alloc_cacheable_memory = true,
@@ -445,7 +441,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -533,7 +528,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -619,7 +613,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_wcn6750,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -662,7 +655,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
 		.credit_flow = false,
-		.max_tx_ring = 1,
 		.spectral = {
 			.fft_sz = 2,
 			.fft_pad_sz = 0,
@@ -698,7 +690,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = false,
 		.idle_ps = false,
 		.supports_suspend = false,
-		.hal_params = &ath11k_hw_hal_params_ipq8074,
+		.hal_params = &ath11k_hw_hal_params_ipq5018,
 		.single_pdev_only = false,
 		.coldboot_cal_mm = true,
 		.coldboot_cal_ftm = true,
@@ -789,7 +781,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -876,7 +867,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 977f945b6e669..50f344803e8fd 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -707,7 +707,7 @@ static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
 	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
 	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
 		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
 				 i, soc_stats->tx_err.desc_na[i]);
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 56b1a657e0b0f..c940de285276d 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -344,7 +344,7 @@ void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
 	if (!ab->hw_params.supports_shadow_regs)
 		return;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
 		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
 
 	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
@@ -359,7 +359,7 @@ static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
 	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
 	}
@@ -400,7 +400,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 		goto err;
 	}
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		tcl_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].tcl_ring_num;
 		wbm_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num;
 
@@ -782,7 +782,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	int i, j;
 	int tot_work_done = 0;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		if (BIT(ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num) &
 		    ab->hw_params.ring_mask->tx[grp_id])
 			ath11k_dp_tx_completion_handler(ab, i);
@@ -1035,7 +1035,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 
 	ath11k_dp_reo_cmd_list_cleanup(ab);
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
 		idr_for_each(&dp->tx_ring[i].txbuf_idr,
 			     ath11k_dp_tx_pending_cleanup, ab);
@@ -1086,7 +1086,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		idr_init(&dp->tx_ring[i].txbuf_idr);
 		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
 		dp->tx_ring[i].tcl_data_ring_id = i;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 7a55afd33be82..1bd513f68a3c3 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -199,7 +199,6 @@ struct ath11k_pdev_dp {
 #define DP_BA_WIN_SZ_MAX	256
 
 #define DP_TCL_NUM_RING_MAX	3
-#define DP_TCL_NUM_RING_MAX_QCA6390	1
 
 #define DP_IDLE_SCATTER_BUFS_MAX 16
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 562aba66582f3..86e1e6c27b36c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -91,6 +91,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct dp_tx_ring *tx_ring;
+	size_t num_tx_rings = ab->hw_params.hal_params->num_tx_rings;
 	void *hal_tcl_desc;
 	u8 pool_id;
 	u8 hal_ring_id;
@@ -113,7 +114,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 tcl_ring_sel:
 	tcl_ring_retry = false;
 
-	ti.ring_id = ring_selector % ab->hw_params.max_tx_ring;
+	ti.ring_id = ring_selector % num_tx_rings;
 	ti.rbm_id = ab->hw_params.hal_params->tcl2wbm_rbm_map[ti.ring_id].rbm_id;
 
 	ring_map |= BIT(ti.ring_id);
@@ -126,7 +127,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (unlikely(ret < 0)) {
-		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1) ||
+		if (ring_map == (BIT(num_tx_rings) - 1) ||
 		    !ab->hw_params.tcl_ring_retry) {
 			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
@@ -244,8 +245,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (unlikely(ring_map != (BIT(ab->hw_params.max_tx_ring)) - 1) &&
-		    ab->hw_params.tcl_ring_retry && ab->hw_params.max_tx_ring > 1) {
+		if (unlikely(ring_map != (BIT(num_tx_rings)) - 1) &&
+		    ab->hw_params.tcl_ring_retry && num_tx_rings > 1) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index caa6dc12a790b..d19c4b372a2aa 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2707,6 +2707,14 @@ const struct ath11k_hw_regs wcn6750_regs = {
 	.hal_reo1_misc_ctl = 0x000005d8,
 };
 
+static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_ipq5018[] = {
+	{
+		.tcl_ring_num = 0,
+		.wbm_ring_num = 0,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
+	},
+};
+
 static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_ipq8074[] = {
 	{
 		.tcl_ring_num = 0,
@@ -2822,19 +2830,28 @@ const struct ath11k_hw_regs ipq5018_regs = {
 	.hal_wbm1_release_ring_base_lsb = 0x0000097c,
 };
 
+const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq5018,
+	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
+};
+
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074),
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
-	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq5018,
+	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_wcn6750,
+	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_wcn6750),
 };
 
 static const struct cfg80211_sar_freq_ranges ath11k_hw_sar_freq_ranges_wcn6855[] = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 52d9f4c13b136..9db984ac4321c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -134,6 +134,7 @@ struct ath11k_hw_tcl2wbm_rbm_map {
 struct ath11k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
 	const struct ath11k_hw_tcl2wbm_rbm_map *tcl2wbm_rbm_map;
+	size_t num_tx_rings;
 };
 
 struct ath11k_hw_params {
@@ -198,7 +199,6 @@ struct ath11k_hw_params {
 	bool supports_regdb;
 	bool fix_l1ss;
 	bool credit_flow;
-	u8 max_tx_ring;
 	const struct ath11k_hw_hal_params *hal_params;
 	bool supports_dynamic_smps_6ghz;
 	bool alloc_cacheable_memory;
@@ -291,6 +291,7 @@ extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018;
 
 extern const struct ce_remap ath11k_ce_remap_ipq5018;
 
+extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3276fe443502f..33ebe03380114 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7392,7 +7392,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	idr_for_each(&ar->txmgmt_idr,
 		     ath11k_mac_vif_txmgmt_idr_remove, vif);
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		spin_lock_bh(&ab->dp.tx_ring[i].tx_idr_lock);
 		idr_for_each(&ab->dp.tx_ring[i].txbuf_idr,
 			     ath11k_mac_vif_unref, vif);
-- 
2.45.1


