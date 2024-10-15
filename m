Return-Path: <linux-wireless+bounces-13977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF099F3CA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68375B22D27
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F91FC7CF;
	Tue, 15 Oct 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcKcQnAu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896401FC7C2
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012469; cv=none; b=uUm+Y23TvxcMm93cdvJH2MycxXc7NhavCVthosEdYGpkBJAAS88nznOg670Dcv6qnxu8Udc5IrHvUK9FJS6hLlQOk4fJy9AA1a9Es7p6I9+y98spfa3+rSoQMRXrJol7vhPvfP76amGr2UJPdgyQQHz0/nE3TJrAfGGepL7aF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012469; c=relaxed/simple;
	bh=05KhMOzaooeluGWi94e/pW5onMxTOfbE+WujlvKgDHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGZhBMZHWrERmPbZQZfheacQpO8Dmy1TIsIyZgZeDSpRLz/FjfM03gWnVsuYJciUqPOuJUY1+T1JQBGUJvCpi8lbxAqB8SWVTeWkTB9Zqvy16tcK6sQS67ohq1OF2kQOigKo7CbrRx5vpTwRqqAqX9k5mFpzRS0ultMWkQGX0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcKcQnAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2133C4CECD;
	Tue, 15 Oct 2024 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012469;
	bh=05KhMOzaooeluGWi94e/pW5onMxTOfbE+WujlvKgDHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcKcQnAusF4c7qqPmqu08iFQxE7Sx1bcJoYRg4wBXb+MY/IHBIpkbQm1MR+1pFoxZ
	 OjR/p9fMOI6oUjwDuPxis3E9WRvwuooVjWzFvArK5olKv03kZVNCJq/Anqvu0pMTsu
	 +cGfWw/wvUK2h7zPFVOQhfedWPepmYKtWeULnPDJnNI4wgKNQyVeeRPd5rs8ow/Hcj
	 OrTBf1Smz+cAao+5d/L+dnM6AP1p1ATNEsA5dGOmH9bg+dEeNjK82rkFw6W6pKsYIc
	 RPE8sWRuh2Tm/vWTHhaTU3cqskG/g1OsFxgxCgPpil7oAEed3H0A3ATj+dmcudF7Vg
	 mtEOEZfg/ml+g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/11] wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
Date: Tue, 15 Oct 2024 20:14:14 +0300
Message-Id: <20241015171416.518022-10-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Refactor ath12k_mac_op_conf_tx() to apply and cache the TX parameters based on
the link id provided by mac80211.

While at it, the link id argument of ath12k_mac_conf_tx() is not used so remove
it.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7185cffe7dd4..8771d9738ffb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5127,8 +5127,7 @@ static int ath12k_conf_tx_uapsd(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static int ath12k_mac_conf_tx(struct ath12k_link_vif *arvif,
-			      unsigned int link_id, u16 ac,
+static int ath12k_mac_conf_tx(struct ath12k_link_vif *arvif, u16 ac,
 			      const struct ieee80211_tx_queue_params *params)
 {
 	struct wmi_wmm_params_arg *p = NULL;
@@ -5188,16 +5187,16 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif;
 	struct ath12k_vif_cache *cache;
-	struct ath12k *ar;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-	ar = ath12k_get_ar_by_vif(hw, vif);
-	if (!ar) {
-		/* cache the info and apply after vdev is created */
-		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return -EINVAL;
+
+	arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	if (!arvif || !arvif->is_created) {
+		cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
 		if (!cache)
 			return -ENOSPC;
 
@@ -5208,7 +5207,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 		return 0;
 	}
 
-	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
+	ret = ath12k_mac_conf_tx(arvif, ac, params);
 
 	return ret;
 }
@@ -6962,7 +6961,7 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif
 		return;
 
 	if (cache->tx_conf.changed) {
-		ret = ath12k_mac_conf_tx(arvif, 0, cache->tx_conf.ac,
+		ret = ath12k_mac_conf_tx(arvif, cache->tx_conf.ac,
 					 &cache->tx_conf.tx_queue_params);
 		if (ret)
 			ath12k_warn(ab,
-- 
2.39.5


