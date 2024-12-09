Return-Path: <linux-wireless+bounces-16109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135B9E9E81
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0604E165460
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C0198A06;
	Mon,  9 Dec 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0vcp4jj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6019883C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770470; cv=none; b=WxP4D+Jg3tXkkrhsouIxNvW9+MD6lcRR59DRSEi9MtmQ/YassfLevx5WldD2aI7COY89sZrbbHMnjqSkh792+9IRbtu4uuWzArDS/jzCv0Qh6As+uhedB8pe6+YticovY9p9ND7TdTfilgX2O9JSwaaCMWFduQXR+c4aMAiO1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770470; c=relaxed/simple;
	bh=gyJqLQAwil8oHFOPnP5sE3itwXs7LeLSqcr3lVubE9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0agiBf9/FmOflrRgeXc+G5Dgguc/+YQurW1Sqx+5oryE5Y3MdT7qTaxXMdXdQtth+af8zBVmoHyaNrOmIKYmGKZR0x0cbbBfbsrwnUHlis63+HaN8npTBsEvJa6rPL4ZQwIRfXO08J3v2xnM2O0N6hh4uiO7lSIFxTY1mvMvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0vcp4jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC03C4CEE0;
	Mon,  9 Dec 2024 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770469;
	bh=gyJqLQAwil8oHFOPnP5sE3itwXs7LeLSqcr3lVubE9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0vcp4jjsSqG8h3YOb+G8uXqFidIraLrwBlYNOfNBOMRIXjOjoMYUZqsAf+OdLTip
	 iwnhZoz+7Ku41FIkrILUDVnfOMYtYso5qCUjf/vqFReOwWY9K2iy7HnCTtlv6UPJph
	 KsdaMucxXcn6bNRPKUcZq65db2AgMV+O1e6mT2+p7xcINiO5nlxeag7f/7kVoZKLMG
	 WMQoaLXzIo4MmbCbSEDtdSNNffftazuk7XU0JCLLHnJqrGW7OBsEYSJEf0ljyrcyI5
	 fHZPAM/YcsjOXA6KgX2gHkSk2W9LkWKEOicsRQAC9fE2B4yb8tdyadF4W+wlgQAJZX
	 ltLoKXauhwUVw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 6/9] wifi: ath12k: advertise multi device interface combination
Date: Mon,  9 Dec 2024 20:54:18 +0200
Message-Id: <20241209185421.376381-7-kvalo@kernel.org>
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

The prerequisite for MLO support in cfg80211/mac80211 requires that all the
links participating in MLO belong to the same wiphy/struct ieee80211_hw. The
driver needs to group multiple discrete hardware components, each acting as a
link in MLO, under one wiphy. Consequently, the driver advertises
multi-hardware device interface combination capabilities specific to the radio,
including supported frequencies. The global interface combination represent the
combined interface capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 222 +++++++++++++++++++++-----
 1 file changed, 185 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bf89be1cccc..de2f55f4ea03 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10336,14 +10336,20 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 {
 	struct ath12k *ar;
 	int i;
-	u16 interface_modes, mode;
-	bool is_enable = true;
+	u16 interface_modes, mode = 0;
+	bool is_enable = false;
+
+	if (type == NL80211_IFTYPE_MESH_POINT) {
+		if (IS_ENABLED(CONFIG_MAC80211_MESH))
+			mode = BIT(type);
+	} else {
+		mode = BIT(type);
+	}
 
-	mode = BIT(type);
 	for_each_ar(ah, ar, i) {
 		interface_modes = ar->ab->hw_params->interface_modes;
-		if (!(interface_modes & mode)) {
-			is_enable = false;
+		if (interface_modes & mode) {
+			is_enable = true;
 			break;
 		}
 	}
@@ -10351,31 +10357,20 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 	return is_enable;
 }
 
-static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
+static int
+ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
+				  struct ieee80211_iface_combination *comb)
 {
-	struct wiphy *wiphy = ah->hw->wiphy;
-
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
-}
-
-static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
-{
-	struct wiphy *wiphy = ah->hw->wiphy;
-	struct ieee80211_iface_combination *combinations;
+	u16 interface_modes = ar->ab->hw_params->interface_modes;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
 	bool ap, mesh, p2p;
 
-	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
-	p2p = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_P2P_DEVICE);
+	ap = interface_modes & BIT(NL80211_IFTYPE_AP);
+	p2p = interface_modes & BIT(NL80211_IFTYPE_P2P_DEVICE);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
-		ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
-
-	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
-	if (!combinations)
-		return -ENOMEM;
+	       (interface_modes & BIT(NL80211_IFTYPE_MESH_POINT));
 
 	if ((ap || mesh) && !p2p) {
 		n_limits = 2;
@@ -10392,10 +10387,8 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	}
 
 	limits = kcalloc(n_limits, sizeof(*limits), GFP_KERNEL);
-	if (!limits) {
-		kfree(combinations);
+	if (!limits)
 		return -ENOMEM;
-	}
 
 	limits[0].max = 1;
 	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
@@ -10411,26 +10404,181 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 
 	if (p2p) {
 		limits[1].types |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				   BIT(NL80211_IFTYPE_P2P_GO);
+					BIT(NL80211_IFTYPE_P2P_GO);
 		limits[2].max = 1;
 		limits[2].types |= BIT(NL80211_IFTYPE_P2P_DEVICE);
 	}
 
-	combinations[0].limits = limits;
-	combinations[0].n_limits = n_limits;
-	combinations[0].max_interfaces = max_interfaces;
-	combinations[0].num_different_channels = 1;
-	combinations[0].beacon_int_infra_match = true;
-	combinations[0].beacon_int_min_gcd = 100;
-	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-						BIT(NL80211_CHAN_WIDTH_20) |
-						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80);
+	comb[0].limits = limits;
+	comb[0].n_limits = n_limits;
+	comb[0].max_interfaces = max_interfaces;
+	comb[0].num_different_channels = 1;
+	comb[0].beacon_int_infra_match = true;
+	comb[0].beacon_int_min_gcd = 100;
+	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+					BIT(NL80211_CHAN_WIDTH_20) |
+					BIT(NL80211_CHAN_WIDTH_40) |
+					BIT(NL80211_CHAN_WIDTH_80);
 
+	return 0;
+}
+
+static int
+ath12k_mac_setup_global_iface_comb(struct ath12k_hw *ah,
+				   struct wiphy_radio *radio,
+				   u8 n_radio,
+				   struct ieee80211_iface_combination *comb)
+{
+	const struct ieee80211_iface_combination *iter_comb;
+	struct ieee80211_iface_limit *limits;
+	int i, j, n_limits;
+	bool ap, mesh, p2p;
+
+	if (!n_radio)
+		return 0;
+
+	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
+	p2p = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_P2P_DEVICE);
+	mesh = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
+
+	if ((ap || mesh) && !p2p)
+		n_limits = 2;
+	else if (p2p)
+		n_limits = 3;
+	else
+		n_limits = 1;
+
+	limits = kcalloc(n_limits, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	for (i = 0; i < n_radio; i++) {
+		iter_comb = radio[i].iface_combinations;
+		for (j = 0; j < iter_comb->n_limits && j < n_limits; j++) {
+			limits[j].types |= iter_comb->limits[j].types;
+			limits[j].max += iter_comb->limits[j].max;
+		}
+
+		comb->max_interfaces += iter_comb->max_interfaces;
+		comb->num_different_channels += iter_comb->num_different_channels;
+		comb->radar_detect_widths |= iter_comb->radar_detect_widths;
+	}
+
+	comb->limits = limits;
+	comb->n_limits = n_limits;
+	comb->beacon_int_infra_match = true;
+	comb->beacon_int_min_gcd = 100;
+
+	return 0;
+}
+
+static
+void ath12k_mac_cleanup_iface_comb(const struct ieee80211_iface_combination *iface_comb)
+{
+	kfree(iface_comb[0].limits);
+	kfree(iface_comb);
+}
+
+static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+	const struct wiphy_radio *radio;
+	int i;
+
+	if (wiphy->n_radio > 0) {
+		radio = wiphy->radio;
+		for (i = 0; i < wiphy->n_radio; i++)
+			ath12k_mac_cleanup_iface_comb(radio[i].iface_combinations);
+
+		kfree(wiphy->radio);
+	}
+
+	ath12k_mac_cleanup_iface_comb(wiphy->iface_combinations);
+}
+
+static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct ieee80211_iface_combination *combinations, *comb;
+	struct wiphy *wiphy = ah->hw->wiphy;
+	struct wiphy_radio *radio;
+	struct ath12k *ar;
+	int i, ret;
+
+	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
+	if (!combinations)
+		return -ENOMEM;
+
+	if (ah->num_radio == 1) {
+		ret = ath12k_mac_setup_radio_iface_comb(&ah->radio[0],
+							combinations);
+		if (ret) {
+			ath12k_hw_warn(ah, "failed to setup radio interface combinations for one radio: %d",
+				       ret);
+			goto err_free_combinations;
+		}
+
+		goto out;
+	}
+
+	/* there are multiple radios */
+
+	radio = kcalloc(ah->num_radio, sizeof(*radio), GFP_KERNEL);
+	if (!radio) {
+		ret = -ENOMEM;
+		goto err_free_combinations;
+	}
+
+	for_each_ar(ah, ar, i) {
+		comb = kzalloc(sizeof(*comb), GFP_KERNEL);
+		if (!comb) {
+			ret = -ENOMEM;
+			goto err_free_radios;
+		}
+
+		ret = ath12k_mac_setup_radio_iface_comb(ar, comb);
+		if (ret) {
+			ath12k_hw_warn(ah, "failed to setup radio interface combinations for radio %d: %d",
+				       i, ret);
+			kfree(comb);
+			goto err_free_radios;
+		}
+
+		radio[i].freq_range = &ar->freq_range;
+		radio[i].n_freq_range = 1;
+
+		radio[i].iface_combinations = comb;
+		radio[i].n_iface_combinations = 1;
+	}
+
+	ret = ath12k_mac_setup_global_iface_comb(ah, radio, ah->num_radio, combinations);
+	if (ret) {
+		ath12k_hw_warn(ah, "failed to setup global interface combinations: %d",
+			       ret);
+		goto err_free_all_radios;
+	}
+
+	wiphy->radio = radio;
+	wiphy->n_radio = ah->num_radio;
+
+out:
 	wiphy->iface_combinations = combinations;
 	wiphy->n_iface_combinations = 1;
 
 	return 0;
+
+err_free_all_radios:
+	i = ah->num_radio;
+
+err_free_radios:
+	while (i--)
+		ath12k_mac_cleanup_iface_comb(radio[i].iface_combinations);
+
+	kfree(radio);
+
+err_free_combinations:
+	kfree(combinations);
+
+	return ret;
 }
 
 static const u8 ath12k_if_types_ext_capa[] = {
-- 
2.39.5


