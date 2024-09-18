Return-Path: <linux-wireless+bounces-12976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18797C003
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F122832F8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AD1CA6B0;
	Wed, 18 Sep 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTCONex2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EE1CA6AB
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683049; cv=none; b=mJTr70KTuGhVk90bC42zuzAK4BH3wWdDNCLTyeOFgPB+TO6au/UjUOJuf0/AbsIzYhMc70r+Id7MZ0iltCkHSJwBrmQOuGCZS3PHYM/CWEVXAnNQQR1V88gIKOxoSWe/1yu09/zL2oRBUb9C5rCQOaAE5wlTgU9CSMq/g7Chp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683049; c=relaxed/simple;
	bh=qUczHlsEy8fEkQChpwjpyaXMav5RgCU0UhYt5rStH64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqNTWOHJ0qeNvE9jINuDz1GMjT5tOezuwuwANzTYGoGCldqzD01CWBe1ssqHT+L/7GI7jBRHLChpfInXX7sT63p/DIcTlKxIcW5CwUGOF+EGx5Y11LLYgT5Iorgb8xFbbaPl3FqflamayYfiHDVITaGVrW1MV/D6jCuGFp5IP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTCONex2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCFCC4CEC2;
	Wed, 18 Sep 2024 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726683049;
	bh=qUczHlsEy8fEkQChpwjpyaXMav5RgCU0UhYt5rStH64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTCONex2dRsmJt4SwrqfY/dnmYAS3Im+lomlfc2fMtqrPnPjRDFyBbiEDnVVWH0th
	 KJx6H3PrgbVPzV/ZVfskiOBi3TnHhEy8pVu5OadC0PzNc/83kktLCoRCQY6XoJ1x2z
	 NFf0NMlypSy22zzUDkbM/Yu9FMjAZOxDlhVvBbT7YHUdq4VmfJu/ivqER/vsNpZCia
	 0giG2fs4CL64Uef/uZvqHJ+dRFMVe0NiRIO72C3Ppk4T9Bvyqc613VQqoaDU86Ms+z
	 aF87/JtVh+CAFE9NpnGXR2ITYT9O9vCyVRw1vISlnyS/Q0g7sY12ov9VDm2fxiy81k
	 HDdPIVUMbstVg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 4/4] wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
Date: Wed, 18 Sep 2024 21:10:42 +0300
Message-Id: <20240918181042.91891-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918181042.91891-1-kvalo@kernel.org>
References: <20240918181042.91891-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

As ath12k is now converted to use wiphy lock we can convert
ath12k_sta_rc_update_wk() to use wiphy_work_queue(). This is just for
consistency.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7551494716b5..ebfc1e370acc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -451,7 +451,7 @@ struct ath12k_sta {
 	u32 smps;
 	enum hal_pn_type pn_type;
 
-	struct work_struct update_wk;
+	struct wiphy_work update_wk;
 	struct rate_info txrate;
 	struct rate_info last_txrate;
 	u64 rx_duration;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 80db9004cdd7..e70b4212ae80 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4258,7 +4258,7 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 	return 0;
 }
 
-static void ath12k_sta_rc_update_wk(struct work_struct *wk)
+static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif;
@@ -4274,7 +4274,9 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
 
-	arsta = container_of(wk, struct ath12k_sta, update_wk);
+	lockdep_assert_wiphy(wiphy);
+
+	arsta = container_of(work, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
 	arvif = arsta->arvif;
 	ar = arvif->ar;
@@ -4571,7 +4573,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
 	     new_state == IEEE80211_STA_NOTEXIST))
-		cancel_work_sync(&arsta->update_wk);
+		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
@@ -4585,7 +4587,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
-		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
+		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 		ret = ath12k_mac_station_add(ar, vif, sta);
 		if (ret)
@@ -4792,7 +4794,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(hw, &arsta->update_wk);
+	wiphy_work_queue(hw->wiphy, &arsta->update_wk);
 }
 
 static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
@@ -8065,7 +8067,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(ath12k_ar_to_hw(ar), &arsta->update_wk);
+	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arsta->update_wk);
 }
 
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
-- 
2.39.5


