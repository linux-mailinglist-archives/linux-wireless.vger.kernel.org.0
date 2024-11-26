Return-Path: <linux-wireless+bounces-15721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82A9D9C29
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4144B26B3C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F601DACBF;
	Tue, 26 Nov 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4aIf/Ak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D311DACBB
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641104; cv=none; b=qyUImrkjGdiFupz3t130zStanGkdmSC4ZehSDfVgOZeLcB2PiyXvSE2MwFyo36/EPkRIqa4i0UOy2OHFU1b2RuMCMTR5CIAmkeYEzI/y4oKvG8C8aW5Ha80HhoEDb0veXf3z9ensJNSyobzDBZXiMTY9KS2tPrggcDeHrP6MM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641104; c=relaxed/simple;
	bh=85ww3C21SXpj87eUXy7pkC/ca42JLA4U6FeavlmaBxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKBI1EdSGnIXg7QxJWpVEbCkTrvMHtOoOoaWEfCPILCeIP0jt40/JhVHF2xrcBp2NvVzxFpv2h+WytAmHD9hVXpq3U+g0LX5ZTTqy8bcW1a+6vEDtc1TpT2tSFreX7cJf+ZuHC4Nw3sOmnKpnVbpbb/2hvSaqsdqDx0xcBRBcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4aIf/Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E628EC4CED0;
	Tue, 26 Nov 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641103;
	bh=85ww3C21SXpj87eUXy7pkC/ca42JLA4U6FeavlmaBxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4aIf/AkxR7mQjJmp8IqfVKasMkem93Jra6iABaSiweNhKKSYohkphTyztJ/YhiCL
	 9VzcBcGVLHrFdSHAJvTWFNJv8btoEWrNeMBpsM7fPPrzIpVmtPjjUlEQpz12r9gK+C
	 qZFRP3526Nv/KsbDgxJ1rqUC3Z8y2UaZ8Msd2FlKS2hWRTz6NiF/vnklfTl9cXHVvW
	 NshXOqTR/2tNKmrXV4GA6m0J9KDB/snyYWcD/hn7xjeyVr2LuDTsn/SvqR7CB47cVL
	 wMf6Bl0CjOgr+nL0FDNJF2FQtXnOhsaJoNMuYgchEJZCUDcgk01ro2RsJwHtQmwpm3
	 2/ranHMjTjlRQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 01/10] wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work
Date: Tue, 26 Nov 2024 19:11:30 +0200
Message-Id: <20241126171139.2350704-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

To simplify locking for the next patches convert struct
ath12k::wmi_mgmt_tx_work to use wiphy_work. After this
ath12k_mgmt_over_wmi_tx_work() is called with wiphy_lock() taken. In
ath12k_core_suspend() we need to take wiphy_lock() because
ath12k_mac_wait_tx_complete() requires it.

Also add lockdep_assert_wiphy() to document when wiphy_lock() is held.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  6 ++++++
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 20 ++++++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c57322221e1d..263a7c789122 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -79,11 +79,17 @@ int ath12k_core_suspend(struct ath12k_base *ab)
 		ar = ab->pdevs[i].ar;
 		if (!ar)
 			continue;
+
+		wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
+
 		ret = ath12k_mac_wait_tx_complete(ar);
 		if (ret) {
+			wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 			ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
 			return ret;
 		}
+
+		wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 	}
 
 	/* PM framework skips suspend_late/resume_early callbacks
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c1d5e93b679a..5be977008319 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -679,7 +679,7 @@ struct ath12k {
 
 	struct work_struct regd_update_work;
 
-	struct work_struct wmi_mgmt_tx_work;
+	struct wiphy_work wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
 
 	struct ath12k_wow wow;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 60702bf07141..a6fe998c177e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6726,6 +6726,8 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
 {
 	int num_mgmt;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	ieee80211_free_txskb(ath12k_ar_to_hw(ar), skb);
 
 	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
@@ -6787,6 +6789,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 	int buf_id;
 	int ret;
 
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	ATH12K_SKB_CB(skb)->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
@@ -6841,7 +6845,7 @@ static void ath12k_mgmt_over_wmi_tx_purge(struct ath12k *ar)
 		ath12k_mgmt_over_wmi_tx_drop(ar, skb);
 }
 
-static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
+static void ath12k_mgmt_over_wmi_tx_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ath12k *ar = container_of(work, struct ath12k, wmi_mgmt_tx_work);
 	struct ath12k_skb_cb *skb_cb;
@@ -6850,6 +6854,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 	int ret;
 
+	lockdep_assert_wiphy(wiphy);
+
 	while ((skb = skb_dequeue(&ar->wmi_mgmt_tx_queue)) != NULL) {
 		skb_cb = ATH12K_SKB_CB(skb);
 		if (!skb_cb->vif) {
@@ -6904,7 +6910,7 @@ static int ath12k_mac_mgmt_tx(struct ath12k *ar, struct sk_buff *skb,
 
 	skb_queue_tail(q, skb);
 	atomic_inc(&ar->num_pending_mgmt_tx);
-	ieee80211_queue_work(ath12k_ar_to_hw(ar), &ar->wmi_mgmt_tx_work);
+	wiphy_work_queue(ath12k_ar_to_hw(ar)->wiphy, &ar->wmi_mgmt_tx_work);
 
 	return 0;
 }
@@ -6981,10 +6987,12 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 void ath12k_mac_drain_tx(struct ath12k *ar)
 {
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 
-	cancel_work_sync(&ar->wmi_mgmt_tx_work);
+	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->wmi_mgmt_tx_work);
 	ath12k_mgmt_over_wmi_tx_purge(ar);
 }
 
@@ -7101,6 +7109,8 @@ static void ath12k_drain_tx(struct ath12k_hw *ah)
 	struct ath12k *ar;
 	int i;
 
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
 	for_each_ar(ah, ar, i)
 		ath12k_mac_drain_tx(ar);
 }
@@ -9134,6 +9144,8 @@ static int ath12k_mac_flush(struct ath12k *ar)
 
 int ath12k_mac_wait_tx_complete(struct ath12k *ar)
 {
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	ath12k_mac_drain_tx(ar);
 	return ath12k_mac_flush(ar);
 }
@@ -10604,7 +10616,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
 
-	INIT_WORK(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
+	wiphy_work_init(&ar->wmi_mgmt_tx_work, ath12k_mgmt_over_wmi_tx_work);
 	skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
 }
 
-- 
2.39.5


