Return-Path: <linux-wireless+bounces-15790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF149DBB86
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 17:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BFEB22A16
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1E1BD9FD;
	Thu, 28 Nov 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It8hPg64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B741AA1E4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812632; cv=none; b=FfkU4jZQhgZf73muwJlr+LFgqi0InNuhaSCuKQzbPR1/930gyzB4dx4wnfRUXARBfONCLJc8fxWG5etYx/1QYCro34g3XtBNJ5Fh/o6hVnJjT+l1zXp/kU0KY9NwURD7QAozbRce5tNCMbvGQ0eqwa9rix1rQmkU03jVa8+BI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812632; c=relaxed/simple;
	bh=vEh0qvVVLDemau2Z4sQp0eiz2HLCMuAfK1/h3EmQnpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm6E+zvBqYOKENhuTvXVXP0K1Kg756y1GRKDjxvLxP3g2pNdEO1LOT7zbI2B915+AEMI7FTrhO0mEp0LARCCEF1x4WJCqm7SsOO5/SPzYsUa9eoKyfFjrQOQYWf2PW6LjskhSMya3jcsJ5QYhHwx6uhkJJzvRPjGl2eYOMUNh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It8hPg64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E7AC4CED3;
	Thu, 28 Nov 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812631;
	bh=vEh0qvVVLDemau2Z4sQp0eiz2HLCMuAfK1/h3EmQnpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=It8hPg64Nd4dgXRTSzQa5Y3OMfX4wUYIrN66x6RsYRWsr5JYpZVLunYbkel5oDoOH
	 YRU/g6eGqE5Sa/hfSjP2x9N1EyOdxALrxCMMTHciixiY67vUVy8/hoPxeh79wqHshT
	 WwuQdhEvqgCXc6mKXSX1B/sunXe8TTh5RBIk5xWB7v9oi1XKSSXd0D5lSADBfCrSHl
	 XSFyAyZe9qkrbXG8WZAxcECAFYmNxxDXb3J3+eirdRumJh+GyT3SX3iWAlkKKI0HL3
	 C3amGheIChjlyirJGkEpAxALXdfW1hKgQJyQ53OsNFeCCOEIlmoMLOgIYbgFhIPX78
	 u7tyLIo9nssmQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
Date: Thu, 28 Nov 2024 18:50:24 +0200
Message-Id: <20241128165026.2618331-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128165026.2618331-1-kvalo@kernel.org>
References: <20241128165026.2618331-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, one or more ath12k_hw is part of a device (struct ath12k_base) but
in future, it would be part of device group abstraction (struct
ath12k_hw_group), i.e., when multiple radios (ar) across different devices can
be combined together in a device group (struct ath12k_hw_group).

In order to facilitate the above transition, introduce helpers
ath12k_ab_to_ah() and ath12k_ab_set_ah() to get and set values of ath12k_hw
respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/core.h | 11 +++++++++++
 drivers/net/wireless/ath/ath12k/mac.c  | 23 +++++++++++++----------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5313b0267307..14d0aa26d850 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -986,7 +986,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	spin_unlock_bh(&ab->base_lock);
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -1038,7 +1038,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1077,7 +1077,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	int i, j;
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
@@ -1131,7 +1131,7 @@ static void ath12k_core_restart(struct work_struct *work)
 
 	if (ab->is_reset) {
 		for (i = 0; i < ab->num_hw; i++) {
-			ah = ab->ah[i];
+			ah = ath12k_ab_to_ah(ab, i);
 			ieee80211_restart_hw(ah->hw);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f4a710d49584..ba52be1cfd0f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1160,4 +1160,15 @@ static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
 #define for_each_ar(ah, ar, index) \
 	for ((index) = 0; ((index) < (ah)->num_radio && \
 	     ((ar) = &(ah)->radio[(index)])); (index)++)
+
+static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
+{
+	return ab->ah[idx];
+}
+
+static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
+				    struct ath12k_hw *ah)
+{
+	ab->ah[idx] = ah;
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8d4207707867..8cafb67523c9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10832,7 +10832,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
 	for (i = 0; i < ab->num_hw; i++) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 
 		ret = ath12k_mac_hw_register(ah);
 		if (ret)
@@ -10843,7 +10843,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -10859,7 +10859,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	int i;
 
 	for (i = ab->num_hw - 1; i >= 0; i--) {
-		ah = ab->ah[i];
+		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
 
@@ -10917,6 +10917,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 void ath12k_mac_destroy(struct ath12k_base *ab)
 {
 	struct ath12k_pdev *pdev;
+	struct ath12k_hw *ah;
 	int i;
 
 	for (i = 0; i < ab->num_radios; i++) {
@@ -10928,11 +10929,12 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ab->num_hw; i++) {
-		if (!ab->ah[i])
+		ah = ath12k_ab_to_ah(ab, i);
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_destroy(ab->ah[i]);
-		ab->ah[i] = NULL;
+		ath12k_mac_hw_destroy(ah);
+		ath12k_ab_set_ah(ab, i, NULL);
 	}
 }
 
@@ -10965,7 +10967,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 
 		ah->dev = ab->dev;
 
-		ab->ah[i] = ah;
+		ath12k_ab_set_ah(ab, i, ah);
 	}
 
 	ath12k_dp_pdev_pre_alloc(ab);
@@ -10974,11 +10976,12 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 
 err:
 	for (i = i - 1; i >= 0; i--) {
-		if (!ab->ah[i])
+		ah = ath12k_ab_to_ah(ab, i);
+		if (!ah)
 			continue;
 
-		ath12k_mac_hw_destroy(ab->ah[i]);
-		ab->ah[i] = NULL;
+		ath12k_mac_hw_destroy(ah);
+		ath12k_ab_set_ah(ab, i, NULL);
 	}
 
 	return ret;
-- 
2.39.5


