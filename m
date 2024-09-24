Return-Path: <linux-wireless+bounces-13108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E698420C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F921F23DAE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E6155314;
	Tue, 24 Sep 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMEeERpO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39694178363
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169920; cv=none; b=cHiY/IgF3eZtWGrDod0N9DrHFQ98psGzB1p+ORFy3TTQJNC2bxM+C9xDMj448OfS/lDwPRTqGqOp9ECxnbiFHQq0UxIujcHY3+xfnpcpb3NsnU9PtYv0ULEbhoWPgY2BsPgTRSxpZXVTxxkf4RxLEvrQgLUY9IXRXSBeuaX2H04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169920; c=relaxed/simple;
	bh=uVEuk4z1AjTh7zKmOvX0roFUKb/cHdKRCDNed73eFw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFc1QC2RU7dcqVKigqs8nAEgrN2pumR68SrioIVurbFI4WnJdUrtWlR/aOHpC0whhTZ3yCrl++6FmRI0SYvny8U5aaMlsTUH2SN+SxYj1ecWrWa07sFOB1l0yjLpKXr/Yz9GNnzwTzut5Hv7jnd0P1ETkL48OjNm6RMuZUpBEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMEeERpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F47C4CEC6;
	Tue, 24 Sep 2024 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169919;
	bh=uVEuk4z1AjTh7zKmOvX0roFUKb/cHdKRCDNed73eFw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMEeERpOPnSQ8yCdS28z4wxm5Jiez/C6tAzahxE1KiBdZDkAoGUjZMOdIwt5YOk0B
	 msrPHJh446XMM1anFtk/YA9xLHA0/heD+HiXzcydVAU4D/7tifiDXX4w7B4966Ub54
	 WrJG4bw4At4aiWasaGkNVqTRNnLQiRZxolxrQ+zzNWIeQ4htDmKwLVu3/cyOHjd5xY
	 m18P4m/FfPtNOXtNlddukAy2p5sDFEQYVpCLeReP+fQk3rOSu119QpWAVsfP7XdsSh
	 guPpJXGy+czvthb8eD8QqN8SNqMLGUMNiEHhjzq8uJYLxQAkI0O3yA3ZgY1lqf7F8j
	 6Np4zdPJTJNXw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 2/6] wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
Date: Tue, 24 Sep 2024 12:25:11 +0300
Message-Id: <20240924092515.1049885-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924092515.1049885-1-kvalo@kernel.org>
References: <20240924092515.1049885-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

For praparation to switch ath12k to use wiphy_lock() we can convert
ath12k_sta_rc_update_wk() to use wiphy_work_queue() for consistency. To avoid
any deadlocks do the struct ath12k_sta::update_wk conversion before switching
to using wiphy_lock() throughout the driver.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7f2e9a9b4097..5163b5b07376 100644
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
index 47f9a936b697..22c4bbf47f9c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4270,7 +4270,7 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 	return 0;
 }
 
-static void ath12k_sta_rc_update_wk(struct work_struct *wk)
+static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif;
@@ -4286,6 +4286,8 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
 
+	lockdep_assert_wiphy(wiphy);
+
 	arsta = container_of(wk, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
 	arvif = arsta->arvif;
@@ -4583,7 +4585,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
 	     new_state == IEEE80211_STA_NOTEXIST))
-		cancel_work_sync(&arsta->update_wk);
+		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
@@ -4597,7 +4599,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
-		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
+		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 		ret = ath12k_mac_station_add(ar, vif, sta);
 		if (ret)
@@ -4808,7 +4810,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(hw, &arsta->update_wk);
+	wiphy_work_queue(hw->wiphy, &arsta->update_wk);
 }
 
 static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
@@ -8110,7 +8112,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(ath12k_ar_to_hw(ar), &arsta->update_wk);
+	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arsta->update_wk);
 }
 
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
-- 
2.39.5


