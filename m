Return-Path: <linux-wireless+bounces-11752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7E95A189
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81731C22687
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2F14EC7F;
	Wed, 21 Aug 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnEpLudF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85A14EC7C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254656; cv=none; b=HXBpjyDwEhnd2+j8dt4A4f/cuXao9qUt1gyq1772VxNivaJhzN/UyaO7gz4v5PjAB2H7N4Wx6swWeQQNBWv3jQxqMgYM+CPTDGwi6qglHQhhtwc7AxmRLviQH4XxGxUbzIUj4MhexM3zM921feWAbYrit8oBDt6PXEaMi9inVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254656; c=relaxed/simple;
	bh=hc1QliZ+Mc1C+sQ0pZCAmEAaGgIxjNk7WBgmSijLWD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOrQgJDaHz8CFh2exKS44as9tsxq2jaRz3Q6ELDGoZYlBd5oOI0TR2hHhLOy1RLihRthhsIpeL3BnB5udnBCfy6NdSwAJI3wBQipH0Q3MmpatmZI5NSOnEsd0Hkpg55XAp0i2h8xMO6d+mz0JZdkZrhzQZmlNoI7YO9gNY0P57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnEpLudF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E14CC32786;
	Wed, 21 Aug 2024 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724254655;
	bh=hc1QliZ+Mc1C+sQ0pZCAmEAaGgIxjNk7WBgmSijLWD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnEpLudFFkbuN8hJwwMT0nEkDpH5bQjmsj56rKIWk5QQa5GuFxeBs5nAfoPszaEsn
	 FQJTT7ZOGaTUFiWG8kzvCuhbPHqUxy6JclHetOCfaOqdw7R/S4jJWE37h/BolL7fPv
	 FacsIEy94EEwOYC2J4uGQpaXNGMQPX2CpyTu+Fszwc43LGaM/ZbrLVPYjy0XlXmoC2
	 SPd/hOvlxSHQDnPpcfVRulyPcxMkEH4/BFiSN6k2fHDX+98wJwzdPmbCKDjBVNFxpx
	 PyaMB3TA8bddX06yRafejjTFIv+SeuZ0b5OW/gT9z4J1us3SUypH0EISbkzZKam+zQ
	 ooTPSBCHDf0lw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC 4/4] wifi: ath12k: convert struct ath12k_sta::update_wk to use struct wiphy_work
Date: Wed, 21 Aug 2024 18:37:28 +0300
Message-Id: <20240821153728.2121600-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821153728.2121600-1-kvalo@kernel.org>
References: <20240821153728.2121600-1-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/mac.c  | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7fad2150d9bd..cc28185be650 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -445,7 +445,7 @@ struct ath12k_sta {
 	u32 smps;
 	enum hal_pn_type pn_type;
 
-	struct work_struct update_wk;
+	struct wiphy_work update_wk;
 	struct rate_info txrate;
 	struct rate_info last_txrate;
 	u64 rx_duration;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 80db9004cdd7..8bf7b026f8e4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4258,9 +4258,9 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 	return 0;
 }
 
-static void ath12k_sta_rc_update_wk(struct work_struct *wk)
+static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *work)
 {
-	struct ath12k *ar;
+	struct ath12k *ar = wiphy_priv(wiphy);
 	struct ath12k_vif *arvif;
 	struct ath12k_sta *arsta;
 	struct ieee80211_sta *sta;
@@ -4274,10 +4274,11 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
 
-	arsta = container_of(wk, struct ath12k_sta, update_wk);
+	lockdep_assert_wiphy(wiphy);
+
+	arsta = container_of(work, struct ath12k_sta, update_wk);
 	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
 	arvif = arsta->arvif;
-	ar = arvif->ar;
 
 	if (WARN_ON(ath12k_mac_vif_chan(arvif->vif, &def)))
 		return;
@@ -4571,7 +4572,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
 	     new_state == IEEE80211_STA_NOTEXIST))
-		cancel_work_sync(&arsta->update_wk);
+		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
 
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
@@ -4585,7 +4586,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
-		INIT_WORK(&arsta->update_wk, ath12k_sta_rc_update_wk);
+		wiphy_work_init(&arsta->update_wk, ath12k_sta_rc_update_wk);
 
 		ret = ath12k_mac_station_add(ar, vif, sta);
 		if (ret)
@@ -4792,7 +4793,7 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(hw, &arsta->update_wk);
+	wiphy_work_queue(hw->wiphy, &arsta->update_wk);
 }
 
 static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
@@ -8065,7 +8066,7 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
 
-	ieee80211_queue_work(ath12k_ar_to_hw(ar), &arsta->update_wk);
+	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &arsta->update_wk);
 }
 
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
-- 
2.39.2


