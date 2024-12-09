Return-Path: <linux-wireless+bounces-16107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2469E9E7E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2291672CA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60487198A08;
	Mon,  9 Dec 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbj6LwXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CD19883C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770469; cv=none; b=bPY3/CoG+Lt9VtY/cNfldAQjsMjbeTclALCV5+FYIN7cu7NYN6b17zkM1yRYDMcIIiQwnzEbreXemF+a/M2UUYqyuEbI4R+r+gEOXjPVriZoDuj2kuMYX/a4NoBSpD1vHk1gcBAAA4HVBdkUtILHZBBFufo0rltZp7LZ/zuEcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770469; c=relaxed/simple;
	bh=hsXLb+QVjti8J3fnkWsLaJoZiRryxwvTmmZEee+NO4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnvpSMIWP+vG6heLrNQxSMoTnTLqoeGlWoso38qiF6Zbor4AtmwtVVQ7KrR3pxB5acQ6eKY9pmET8U39dt5Fv1Di1ayfM+8r6S+5j6jldNPSYLzYDq5jXrD/96HoWdu9MiA2hBFNlrMqpiWLA/RqpXtHErpgCAFQvvPzdXQbtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbj6LwXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345D5C4CED1;
	Mon,  9 Dec 2024 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770467;
	bh=hsXLb+QVjti8J3fnkWsLaJoZiRryxwvTmmZEee+NO4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nbj6LwXjErUwO00np+V48ahiIOYB8YqG3eUyxGrbX9u9JriIlSN/2YdzD/HnoAluG
	 izLTVWme2XFrpHdFvVoFfX+UqU7CT7xzL5b9pb1s67BDFwKQRgu7n6jr/NHrRMO7+E
	 UQW5Slc6Jp9wPoqEKe1zmb1J3N5L1MkMR1vdvHDQk2MbRn0KrByhGeQvj4WJIHRbtd
	 B1v4L1IKeu4hwd/Bpxcn3KZGPxg2YxZ+NQI+OJ6UKqjYFCspCpV3m3Q84o9ZK1Egxl
	 mPCbU2RrogUWCym1BzuJVUA6z6DJ4dDSjayPe4tWRzo3UUddM/WjVHcgwfvnN5MS1I
	 ZB802wntUJgvA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/9] wifi: ath12k: introduce interface combination cleanup helper
Date: Mon,  9 Dec 2024 20:54:16 +0200
Message-Id: <20241209185421.376381-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Introduce a cleanup helper function to avoid redundant code for interface
combination cleanup. Remove the cleanup code from ath12k_mac_hw_unregister()
and ath12k_mac_hw_register() and replace it with a new cleanup helper function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7e8eb0feb871..dc61fe761090 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10351,6 +10351,14 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 	return is_enable;
 }
 
+static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+
+	kfree(wiphy->iface_combinations[0].limits);
+	kfree(wiphy->iface_combinations);
+}
+
 static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 {
 	struct wiphy *wiphy = ah->hw->wiphy;
@@ -10479,7 +10487,6 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
-	struct wiphy *wiphy = hw->wiphy;
 	struct ath12k *ar;
 	int i;
 
@@ -10493,8 +10500,7 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 	for_each_ar(ah, ar, i)
 		ath12k_mac_cleanup_unregister(ar);
 
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 	SET_IEEE80211_DEV(hw, NULL);
 }
@@ -10724,13 +10730,13 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ret = ath12k_wow_init(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to init wow: %d\n", ret);
-		goto err_free_if_combs;
+		goto err_cleanup_if_combs;
 	}
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
-		goto err_free_if_combs;
+		goto err_cleanup_if_combs;
 	}
 
 	if (is_monitor_disable)
@@ -10760,9 +10766,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	ieee80211_unregister_hw(hw);
 
-err_free_if_combs:
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+err_cleanup_if_combs:
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 err_complete_cleanup_unregister:
 	i = ah->num_radio;
-- 
2.39.5


