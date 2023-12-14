Return-Path: <linux-wireless+bounces-804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545E813609
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10A91C2031F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF545F1C1;
	Thu, 14 Dec 2023 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV6roAwc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F475EE94
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A57C433C8;
	Thu, 14 Dec 2023 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702570664;
	bh=HK2BDsbsHED2loV2Pn+V2u8GAyC11wNlFeiJkuRxH6U=;
	h=From:To:Cc:Subject:Date:From;
	b=LV6roAwc0lWjnq+YxsLp4q3/4VyNnCZ13UP7MKvqXOm//3zZvGKp4MnRCLuNdCwfS
	 UiLWF61E7BN2KwkduWgwY040wbmcULQawvK0bLsQmHX9392QFOtzbS7gvR8cews22G
	 almDKa1VZW7Agkt0KXhlkETgfVvyRsa5k7L29vSLSjJWXvUHn3khz4Rrpt3vwnIYrk
	 bNx79nVbr0V73gku6wv06RoQ5nCQPxQ3IfgExtui/zlaumIYdeVTScY8JtRzJ4CPV6
	 Q8ksQlgLPY0cGBgH4LEhrvixwOJpeptUocu+8Gd1yaEjpUt2/wBLYvUlpAlzjIGueq
	 uOKv9htCb36Fg==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: workaround too long expansion sparse warnings
Date: Thu, 14 Dec 2023 18:17:40 +0200
Message-Id: <20231214161740.1582340-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In v6.7-rc1 sparse warns:

drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
drivers/net/wireless/ath/ath11k/mac.c:4702:15: error: too long token expansion
drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion
drivers/net/wireless/ath/ath11k/mac.c:8393:23: error: too long token expansion

Workaround the warnings by refactoring the code to a new function, which also
reduces code duplication. And in the new function use max3() to make the code
more readable.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f7b39817773..db241589424d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4654,6 +4654,14 @@ static int ath11k_station_disassoc(struct ath11k *ar,
 	return 0;
 }
 
+static u32 ath11k_mac_max_nss(const u8 *ht_mcs_mask, const u16 *vht_mcs_mask,
+			      const u16 *he_mcs_mask)
+{
+	return max3(ath11k_mac_max_ht_nss(ht_mcs_mask),
+		    ath11k_mac_max_vht_nss(vht_mcs_mask),
+		    ath11k_mac_max_he_nss(he_mcs_mask));
+}
+
 static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 {
 	struct ath11k *ar;
@@ -4699,9 +4707,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	mutex_lock(&ar->conf_mutex);
 
 	nss = max_t(u32, 1, nss);
-	nss = min(nss, max(max(ath11k_mac_max_ht_nss(ht_mcs_mask),
-			       ath11k_mac_max_vht_nss(vht_mcs_mask)),
-			   ath11k_mac_max_he_nss(he_mcs_mask)));
+	nss = min(nss, ath11k_mac_max_nss(ht_mcs_mask, vht_mcs_mask, he_mcs_mask));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
 		/* Get the peer phymode */
@@ -8391,9 +8397,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			ath11k_warn(ar->ab,
 				    "could not update fixed rate settings to all peers due to mcs/nss incompatibility\n");
 		nss = min_t(u32, ar->num_tx_chains,
-			    max(max(ath11k_mac_max_ht_nss(ht_mcs_mask),
-				    ath11k_mac_max_vht_nss(vht_mcs_mask)),
-				ath11k_mac_max_he_nss(he_mcs_mask)));
+			    ath11k_mac_max_nss(ht_mcs_mask, vht_mcs_mask, he_mcs_mask));
 
 		/* If multiple rates across different preambles are given
 		 * we can reconfigure this info with all peers using PEER_ASSOC

base-commit: e0d94824fa388d81bb1f27e9486cb2d0f6fee3fb
-- 
2.39.2


