Return-Path: <linux-wireless+bounces-29629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BACB1BA1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 496EB30076B1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A526E706;
	Wed, 10 Dec 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2wK17U7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F78C1F
	for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334444; cv=none; b=dT40QFYf9k+kkncGNHMCHv8WJdVSQdYnXjq3wtBGPGtZXYDGEfRGe7RWYhUe83maysjCreDZc9mPYrDhFTwEJT6YDlvnBzJ0Z38rg46e4JqovRXjqa6TfJu8UCORD481OnvZKqS4y9B3nFFqYvdAjHUIirvRHdw0lJVBy9xEdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334444; c=relaxed/simple;
	bh=RpxV1aWBEwhfyMLJ60+l8YHdkzx8zeVzT+r7IVzwIuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCgoupI9jCeNUFiJGu2Q8hu4erVWEschcjdkvTexetfZSwEiVH9PH3VJpbC/PzDOukoy3Kvwrrmiqtg1a7azTs3SqH9+j77QQLIrxGhdaF30astTPz9k7WOXwkLIoCWJYseUNQjf71uLf5UuGf0lWCow/o5UGIyLzV7S00dTQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2wK17U7; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6cc44ff62so5288246a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 18:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765334441; x=1765939241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amAH0gLSu+BYXGT+9BRc7QAr8FyrlPyo3lKeFD7HEcs=;
        b=d2wK17U76nelBCUJfRNcFKGAnXbFTV5tb8capaVdy5oj7A0zywxKxSu1CcbWyy2Ihd
         YS38ovwXg8UQZOEEVE1YqemI3wUJi7aYHM6Jt2uIxWid3PD/Q42qtwkGwAZLWjTpXmzh
         dQbZRLb9MYeMQF6FHMyR8Vh/ibJ+LjTGMeYQ441iBVzgtWvwo+hnctFHv7q1kyTo2RgR
         cSz/97aGQx1OLc0Ywok5UB+ekOKfOCaLlvV9lq7rQ5+yvSh1e3TtFYf8Mo3z5DVvpKLX
         Jp1TGMKeOAdV+1GKONrdmPblL+E59VIyjbv8uvxdY+BGDnqwFOStZSWwtD3M19DxpD+h
         VtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765334441; x=1765939241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amAH0gLSu+BYXGT+9BRc7QAr8FyrlPyo3lKeFD7HEcs=;
        b=WpLCNA4SzGX4HJeclgEiwpkphkCxUh9eKZfbRmVbhCKyVOHcAdldBzsnC8X2VUC9xL
         H41UaXmB9GGi7eGJsjc4idZiy6I4aTvyCBXQfOIqjlc1/2XzYt2DIA9b7oK8EyJRIInf
         Y5EsQiCCMtjgB+NzUK4AEsCNUMubBDnKT1q1cyYnM3r0FTkAp43Jf67uhggVrVJ101gQ
         sdK2lJscX/5ib7U7nruikhRACSEkgCR+QB1hDOrEQo0/HiqIqsHDzbJziUQY+zG1FI6i
         SjMG50MvIVeG+HYe8ibaY+7TqCdYNGQ5f6ZUdwGwaFYi7L9pSpD/ULTGk/Q/auCst9ZJ
         VKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1y74SBZEU+ooMpVFInqre7z0qrsAwQXwQ8Awo+C0+XjeLlrlQsBK6qm7Q8QztldeQsoIHwGYsxkKbrRlBqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk68iosRprlBj5l/LP2QxxQ04Uw2t7gVKyoIbmk2Q6f5Tbl0ji
	Qa9qfb0hzIEpKxLfMySJ5xveIPcdA5nEuJ+UT0BLw8FaqUNWwRmPxXof
X-Gm-Gg: ASbGncuYID0Q0XQDBJE/Y21KlYa87loEWmKwV5Hd1lBnM3spcjVT8LElcHCNlGaLT1l
	0lUjMnOEWRN0U7Ihp1xrnGLD4qMklwZRLL8zj1Pt3OSkDojWPHw5wT+I2K4r3OQwfew1iSmKHMn
	p8HFBoJdVZi/bFuFqb4Tj5oroV7nLLgr6f3WwnJUfLcargKKZ6pU3eDqpMX6AGpPYUPom3EhLnE
	f0Rn6Qk/lkufo+snJaYlJTWkrOqKoP6ZWG67HYSyQWmDN/fMvUEyuK+9CMjcfLWg29OyD141UVj
	TENmz6f5n87OtrkSr4dFNt3qloM3hNrGddCePEaGTI4VICkBaTE1PxDYyBaVSA8/MBRZk+oxYEh
	bKRefkcDWkyV0Rvn4W590ON9Tyg7QvDudC2IkSm7b3qcmM8UNs+0P4QrbkOnuw7OM1A64LbIgC7
	kBMnFXyTY1Wd+jlDKmMiKYQcTjzgRf43yqguam9Hwkxj9y+cZIRM6b/bBPNH+Dm/QlT+vFkCoOq
	S6Ehio/PIbRTWs6L3/oVeHDeUIe
X-Google-Smtp-Source: AGHT+IE/mi93bEIS6R0Cu/rhdqxwGtJefv5ZPIAO0tvdrlgx4QVGUUbORXorj8qoVmnmzBm4xRqffQ==
X-Received: by 2002:a05:6830:918:b0:78a:8b0d:cd54 with SMTP id 46e09a7af769-7cacebfadd9mr696324a34.34.1765334441165;
        Tue, 09 Dec 2025 18:40:41 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95a8f8e37sm13351472a34.3.2025.12.09.18.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 18:40:40 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: ath11k@lists.infradead.org,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Tue,  9 Dec 2025 20:40:34 -0600
Message-ID: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
is initialized in, core.c, a different file than the array init. This
spaghetti-like relation is fragile and not obvious. Accidentally
setting ".max_tx_ring" too high leads to a hard to track out-of-
bounds access and memory corruption.

Clarify this dependency by moving ".max_tx_ring" adjacent to the array
".tcl2wbm_rbm_map". Use ARRAY_SIZE() instead of #defines to initialize
the length field. Remove DP_TCL_NUM_RING_MAX_QCA6390, as it is no
longer required.

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


 drivers/net/wireless/ath/ath11k/core.c  | 12 +-----------
 drivers/net/wireless/ath/ath11k/dp.c    | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp.h    |  1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c |  9 +++++----
 drivers/net/wireless/ath/ath11k/hw.c    | 17 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  3 ++-
 drivers/net/wireless/ath/ath11k/mac.c   |  2 +-
 7 files changed, 32 insertions(+), 24 deletions(-)

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
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 56b1a657e0b0f..bd6778d357275 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -344,7 +344,7 @@ void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
 	if (!ab->hw_params.supports_shadow_regs)
 		return;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++)
 		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
 
 	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
@@ -359,7 +359,7 @@ static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
 	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
 	}
@@ -400,7 +400,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 		goto err;
 	}
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
 		tcl_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].tcl_ring_num;
 		wbm_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num;
 
@@ -782,7 +782,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	int i, j;
 	int tot_work_done = 0;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
 		if (BIT(ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num) &
 		    ab->hw_params.ring_mask->tx[grp_id])
 			ath11k_dp_tx_completion_handler(ab, i);
@@ -1035,7 +1035,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 
 	ath11k_dp_reo_cmd_list_cleanup(ab);
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
 		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
 		idr_for_each(&dp->tx_ring[i].txbuf_idr,
 			     ath11k_dp_tx_pending_cleanup, ab);
@@ -1086,7 +1086,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
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
index 562aba66582f3..53e34a2bea54e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -91,6 +91,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct dp_tx_ring *tx_ring;
+	size_t max_tx_ring = ab->hw_params.hal_params->map_len;
 	void *hal_tcl_desc;
 	u8 pool_id;
 	u8 hal_ring_id;
@@ -113,7 +114,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 tcl_ring_sel:
 	tcl_ring_retry = false;
 
-	ti.ring_id = ring_selector % ab->hw_params.max_tx_ring;
+	ti.ring_id = ring_selector % max_tx_ring;
 	ti.rbm_id = ab->hw_params.hal_params->tcl2wbm_rbm_map[ti.ring_id].rbm_id;
 
 	ring_map |= BIT(ti.ring_id);
@@ -126,7 +127,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (unlikely(ret < 0)) {
-		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1) ||
+		if (ring_map == (BIT(max_tx_ring) - 1) ||
 		    !ab->hw_params.tcl_ring_retry) {
 			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
@@ -244,8 +245,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (unlikely(ring_map != (BIT(ab->hw_params.max_tx_ring)) - 1) &&
-		    ab->hw_params.tcl_ring_retry && ab->hw_params.max_tx_ring > 1) {
+		if (unlikely(ring_map != (BIT(max_tx_ring)) - 1) &&
+		    ab->hw_params.tcl_ring_retry && max_tx_ring > 1) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index caa6dc12a790b..8b1aef7a536ec 100644
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
+	.map_len = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
+};
+
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+	.map_len = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074),
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+	.map_len = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074),
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_wcn6750,
+	.map_len = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_wcn6750),
 };
 
 static const struct cfg80211_sar_freq_ranges ath11k_hw_sar_freq_ranges_wcn6855[] = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 52d9f4c13b136..e311c3541eb78 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -134,6 +134,7 @@ struct ath11k_hw_tcl2wbm_rbm_map {
 struct ath11k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
 	const struct ath11k_hw_tcl2wbm_rbm_map *tcl2wbm_rbm_map;
+	size_t map_len;
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
index 3276fe443502f..1c972e7bada8f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7392,7 +7392,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	idr_for_each(&ar->txmgmt_idr,
 		     ath11k_mac_vif_txmgmt_idr_remove, vif);
 
-	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+	for (i = 0; i < ab->hw_params.hal_params->map_len; i++) {
 		spin_lock_bh(&ab->dp.tx_ring[i].tx_idr_lock);
 		idr_for_each(&ab->dp.tx_ring[i].txbuf_idr,
 			     ath11k_mac_vif_unref, vif);
-- 
2.45.1


