Return-Path: <linux-wireless+bounces-15791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE469DBB85
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837F280601
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAB1C07C6;
	Thu, 28 Nov 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/yDM+H4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1B19923C
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812632; cv=none; b=Ljkxj+Tu6flISddYiOuW2fOlYjom7c1ljJXgzlaFizRygRPl5oiKaRhmwxCBlQsRlgjYhAclIgozUE6EjTvICURIPYMZ6KT1KwPnCQLBIXcQkwf3CFBIDt6KqHHFZl9L8WBCngrC0CasXZ9T4FfKMMUu2Jf1mzXRzXaFyftXoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812632; c=relaxed/simple;
	bh=GMGrNm1ldjem0hdAyKTco128pQZGP1uaF4Ua/I8xfsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFrgOEt0xpDYtzRgdcDZZhkqa+lvC63Ee9JNJKFa1UOA/ri8clU7+g3/xXln5YXPzRwwidBvjqiwVbM2lkOUzkzTC1Fi1wD1gwqk53baMaqXgeOmPnQUsVtB8De24wdSgzFUk22Wt1unkq9MbpyNZ164g7t21TptQh3xQb2TCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/yDM+H4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD8FC4CECE;
	Thu, 28 Nov 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812632;
	bh=GMGrNm1ldjem0hdAyKTco128pQZGP1uaF4Ua/I8xfsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/yDM+H4WPfa+jvVZxwFAmrAUNTi47wZ3KRAh766uB4ATrTyMJLNAJKIad1o+SIg1
	 0yfVbgsVR9QgbxdWkI06lqFsICQ3FclY4hmkPFdPho6CMesygnhOX/Q4prXAULeN6K
	 bVm11afsqZZulSgm8KjhNErEHrLkmbMP2P0fVVtPWIo3vZwo5uDzx7qOk2rUgVmSsD
	 GMcB+J+Bb5LPlTvtITbpJsoPSq8KMMFqf7L/+xz+ZMq3ijK+siB0w4M8EY4oXeqHST
	 Q3g9XDlzoZSrmyYO8cCJUc5ocPowPkAmDhoPFq27FuWaS0GK+5V3e+qPMxUSxTtpKf
	 24f7vqewWKQ1g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] wifi: ath12k: add ath12k_get_num_hw()
Date: Thu, 28 Nov 2024 18:50:25 +0200
Message-Id: <20241128165026.2618331-4-kvalo@kernel.org>
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

Currently, one or more struct ath12k_hw is part of device (struct ath12k_base)
but in future, ath12k_hw would be part of device group (struct
ath12k_hw_group).  Hence, num_hw under device would be moved to device group.

To facilitate above transition, add helper ath12k_get_num_hw() to get the
number of radios per device. In future, this helper will return the number of
radios in a device group.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 8 ++++----
 drivers/net/wireless/ath/ath12k/core.h | 5 +++++
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 14d0aa26d850..386d42db29ac 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -985,7 +985,7 @@ static void ath12k_rfkill_work(struct work_struct *work)
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -1037,7 +1037,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 	if (ab->is_reset)
 		set_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1076,7 +1076,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 	struct ath12k *ar;
 	int i, j;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
@@ -1130,7 +1130,7 @@ static void ath12k_core_restart(struct work_struct *work)
 	}
 
 	if (ab->is_reset) {
-		for (i = 0; i < ab->num_hw; i++) {
+		for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 			ah = ath12k_ab_to_ah(ab, i);
 			ieee80211_restart_hw(ah->hw);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ba52be1cfd0f..4bfc7a7cc894 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1171,4 +1171,9 @@ static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
 {
 	ab->ah[idx] = ah;
 }
+
+static inline int ath12k_get_num_hw(struct ath12k_base *ab)
+{
+	return ab->num_hw;
+}
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8cafb67523c9..129607ac6c1a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10831,7 +10831,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 	ab->cc_freq_hz = 320000;
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 
 		ret = ath12k_mac_hw_register(ah);
@@ -10858,7 +10858,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
-	for (i = ab->num_hw - 1; i >= 0; i--) {
+	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -10928,7 +10928,7 @@ void ath12k_mac_destroy(struct ath12k_base *ab)
 		pdev->ar = NULL;
 	}
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
 			continue;
@@ -10951,7 +10951,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 	ab->num_hw = ab->num_radios;
 	radio_per_hw = 1;
 
-	for (i = 0; i < ab->num_hw; i++) {
+	for (i = 0; i < ath12k_get_num_hw(ab); i++) {
 		for (j = 0; j < radio_per_hw; j++) {
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = (i * radio_per_hw) + j;
-- 
2.39.5


