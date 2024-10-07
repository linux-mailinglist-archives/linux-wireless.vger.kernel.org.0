Return-Path: <linux-wireless+bounces-13614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BC993444
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74529280E6C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06A1DCB10;
	Mon,  7 Oct 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd+5cnUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334171DBB3F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320377; cv=none; b=IoDoa8qXRqwGFttKDM8qPW4GSOKhKybPpuKG9Uj0ZL+tMfsh0/vjmTuxrKokxQ1AJpaLsUZcMHjaVHsN3ZabaEsLQtvdy5PBeVnBnyiWwBLWfkdBMR492aLQn8fiilkQAwZYJJTwqxX7k8QJOM2VjDHWBtPqY694Cla0g3Vin7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320377; c=relaxed/simple;
	bh=4D0NbqWJHWF8fm96FKs/VR5B6JhWGiEMEUytta2exx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V36fe4wDoJ/KlDlcwt9/+S+v6koYZg/94jOEQ+J9A7Rk+eUQwE+jJEj9qNU708c+EA1DEZvuyMlVLD9Si5HtS42HjltWj6JeeSaeDWKXOwTVFJyrE/SB9DH10TdX3UOATufmPhePhEvnRV4Ummiwxyi9muyi8sg9eBzMxchCb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd+5cnUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BA5C4CEC6;
	Mon,  7 Oct 2024 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320376;
	bh=4D0NbqWJHWF8fm96FKs/VR5B6JhWGiEMEUytta2exx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qd+5cnUw5yYWZ4Goz4Rf4AZ1/2HI2n5TWJTIeylz+8U6EU+Xj8Z4pcp8Bs1498b/i
	 mJgtbEfuvcJ0Of7mHXICQX0F2vTY+slhjcqgwLJOaxr2Jb6SnJEkADNhADXda7r2iy
	 mdS08PJ4yhToMGtS3h9aT7ymPLdAv6+wlNFBIXCtrPrHEnLrNjO89SNTBVA08oCGPv
	 6vxUsRv0O0StHGCGQqMOAci+2BxMQuLWlEQVXaj65HpQVgUNlXs46AV6071fw89nY+
	 BqLR27G20Bth/iocZ19tTZ2tdCT4o74cV7BSluW+xZ88GnsFruVJ6293Wz3rI0Av5Q
	 cMNLuMD0g76cA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 2/6] wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
Date: Mon,  7 Oct 2024 19:59:28 +0300
Message-Id: <20241007165932.78081-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007165932.78081-1-kvalo@kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

For preparation to switch ath12k to use wiphy_lock() we can convert
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
index 8946141aa0dc..34b6caaaf33c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4273,7 +4273,7 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 	return 0;
 }
 
-static void ath12k_sta_rc_update_wk(struct work_struct *wk)
+static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 {
 	struct ath12k *ar;
 	struct ath12k_vif *arvif;
@@ -4289,6 +4289,8 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
 
+	lockdep_assert_wiphy(wiphy);
+
 	arsta = container_of(wk, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
 	arvif = arsta->arvif;
@@ -4586,7 +4588,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
 	     new_state == IEEE80211_STA_NOTEXIST))
-		cancel_work_sync(&arsta->update_wk);
+		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
@@ -4600,7 +4602,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
-		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
+		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 		ret = ath12k_mac_station_add(ar, vif, sta);
 		if (ret)
@@ -4811,7 +4813,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(hw, &arsta->update_wk);
+	wiphy_work_queue(hw->wiphy, &arsta->update_wk);
 }
 
 static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
@@ -8113,7 +8115,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(ath12k_ar_to_hw(ar), &arsta->update_wk);
+	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arsta->update_wk);
 }
 
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
-- 
2.39.5


