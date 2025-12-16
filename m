Return-Path: <linux-wireless+bounces-29773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41171CC0E98
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 05:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3744F30215D7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E1332EA7;
	Tue, 16 Dec 2025 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNd9sYwQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552B331223
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859772; cv=none; b=Bi4gOcf1lTh+zxhQUlwdIW6+GCNxsoPDzTThtSAN7ziknkTTdACoyqybXqsl2GQuwdwWN5kgpzJjsDnYKS2PUQNQnwVc22d5KKB369ajIJ9mTAygX3Wp6qPAIoqExirQmlsd0b7Rsv1HHwkWcCyDYaC695mUlcLBR8y1IvO6sGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859772; c=relaxed/simple;
	bh=Hs1exUeSzwg2t2C/V9bP5kzbgTCR9I09qV2Wslv8HpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWTgqibBeNzMmvpudpc7baKjdtPMykIbe+u6SYqITQImvmCH7eCdHhjyaEM7NVim4+IiH7G6lHmnlfPlEkXKqPhmeo9vN/SO4UN313B0af/uWUuB3l0tEJhotgC4RQ6rTnxXfMVh4f0lz3rEZjG4BhRv3s0hTWKt6k5OBPcoKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNd9sYwQ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65b68c8c649so902776eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 20:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765859759; x=1766464559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7VGHKNtM1JC0CBVAGFFnYSWZgu9YXfXL47IE3gej6I=;
        b=GNd9sYwQut4XIbXU0KfSimOXexBPF0OJapfALj4PsUFImA0hFu8gtCXLqfMIf1M6+7
         hLmZ8uSQuV7x+LsxEFimMRGAvK/EbpOxgK6ylwk1Okh7u0bLwm2OemDYrLXoRtLsZgru
         VkOgvbApUYCVWkC66MQGiuCR+yf8Uc18+WVdh3wZZ9Fm6ZkofaG0BJy2Fn8L0AHRmQXf
         JhBskyatFRNJeiw1jTX6N86l23knL50fxA38vEHtweuhFxXWBnCD6jQCJtfwh0+JLLZL
         cyLUnd64PL1ROr75iI+rYGU9/AKQd+nAkxvLg6v7BjErze4ex5zqn6BTfE0YtplC1ypd
         DotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765859759; x=1766464559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7VGHKNtM1JC0CBVAGFFnYSWZgu9YXfXL47IE3gej6I=;
        b=Ky2sXCEC9MXhVnTtU7GJe3GDbYuLnka8KfPB7+QfkmW2kctVuMPQCiyJW95KDhoky2
         Xflvdb/ej9owBlF73NKWlkuVVKtxeCcmS+Rf8D2NZsPluv///5qOi/TF2H8MZoexZLZP
         S9K/CTHqOVkbtSl3s4v3ooUw7VWznJVO65LwyS6DXXMcHeoqDiXHkzS6/lPWCrFQK/7F
         S4JVnul8b74S8FJxxpOL5egcogTCKK/2g+IqUPOrge98cA0WSgED2PYWt0Tt6SYoJGqe
         O9AwE3sCYf13g59iXNqiC9XNqpNDx2CKH0zI1pxI6avCuRZdhiOU/zD+BC5nbyP5sRWH
         A0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3CLoWxeZ2IDRjHMoLuDGYuIGnkRvCGZbI9bzA9aJhzq/KlfRvX8r4xM0BRnhC+TD4rHwEfYKqdtzP98bkUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpC8x5WnfKWJIqm672EpzQMkk7qsZtX2jN1Arjhd3gMnDmXcX
	3/ldDWMrlOOfEJNbbl2XAIyru5qRo2UMzy5H7T/ul1uxvA6HyZ1GWZSY
X-Gm-Gg: AY/fxX5CttC8h0mz95OHcTb0JMpQHLlXyD2X/IhEWM6mDmxRu8wCvaxuE/iCK92Xd/t
	sdH12KIY+RumV78Ysh8dhFTXzl7PxCCECCN45I3ke/RIEPzppHwWOyzI7YChU484yfmJEwhwlYI
	nyOquAStu26d0aOT0xTev4Crnd2gadK4SGOX7OXrykEkRP219EuYm46s8LsKuKS21K6lJYnxjuV
	NDvCFiO5bF37FdDDoWuOb2FAKhg9/zQipLCIWrQJM/x7fW0bBJar/qAdXCuF/6ox1qP4Rcdi+qB
	UnWYMojw224Z64Sum8pYdTyNhhL3Z/4e1Im142GnpzQGlFCjdhg7359AiX3UtHAioXw/Yi4ipeZ
	cEZk4Wyd66BDM70q+p37eh/vvt8u5regon1W2PjghaRXVcxar/0nHZzDUJ9oWW6vjhs2zm07UOz
	qQcHm8YWr1x2nXdbg0LOhEQrhPxVavg6Jq6S8YGMOOnGnzKmp6rjZZcPooDhhWFagZ2b3RTxRCW
	IrFRCuo2jNGmNBJoXz1HyNsvRuP
X-Google-Smtp-Source: AGHT+IH+TqIPuUN/dMFCU97t7Q8gftaVx3eoTbjPNaDmHr9yxJL5QssQktaf3+BhVZjdlEzRjDOxmQ==
X-Received: by 2002:a05:6820:16a6:b0:659:9a49:8eda with SMTP id 006d021491bc7-65b451879f5mr5787893eaf.14.1765859759054;
        Mon, 15 Dec 2025 20:35:59 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f2b1e5sm8948353eaf.3.2025.12.15.20.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 20:35:57 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: ath11k@lists.infradead.org,
	Jeff Johnson <jjohnson@kernel.org>
Cc: baochen.qiang@oss.qualcomm.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Mon, 15 Dec 2025 22:35:52 -0600
Message-ID: <20251216043555.628296-1-mr.nuke.me@gmail.com>
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

Changes since v1:
 - use "num_tx_rings" name instead of "map_len"
 - make sure debugfs.c is correctly updated
 - add a static_assert for ath11k_hw_hal_params_qca6390 special case

 drivers/net/wireless/ath/ath11k/core.c    | 12 +-----------
 drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
 drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  9 +++++----
 drivers/net/wireless/ath/ath11k/hw.c      | 19 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h      |  3 ++-
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 7 files changed, 35 insertions(+), 24 deletions(-)

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
index caa6dc12a790b..bbaacdf76af0a 100644
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
@@ -2822,19 +2830,30 @@ const struct ath11k_hw_regs ipq5018_regs = {
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
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+	.num_tx_rings = DP_TCL_NUM_RING_MAX_QCA6390,
 };
 
+static_assert(ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074) >= DP_TCL_NUM_RING_MAX_QCA6390);
+
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


