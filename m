Return-Path: <linux-wireless+bounces-16506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DF9F57B1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 21:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A1916F1F2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D5A1F9ED8;
	Tue, 17 Dec 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPe7YA12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F131F9ED4
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467184; cv=none; b=YqYyEdse1MiIrWS5j/S5/nHJteF1ZY5MQBQkSrjDZaZyJGrCOT/Mw28qn2PHpcc8DW3G8iMrszQWVXR1Eh0DnJR1FUtGccHDHbb1yZsWUeFmf8GYoEYSwWIXaqrMr9tWk7fsfMKqRPc4rfp1VMPm+oVBwp5EjBJ5FcBk3mYMN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467184; c=relaxed/simple;
	bh=szKv4c+yIO8qpqVrfikQ7GZl6LC2oSeWMMQ6QkdbdLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmQk45AL1DK59hnIa+X7y/qgTnl3Y0lm9iO2FbOzI0t9B70+IkIIwAj4+wUjYhm4wWT2bGVpVl181rVMTnEISfbGKPRDAKAdy3uJljqaEmwh72eh8J5vfutVTYW9WXV184qxPZ89bs3XigPsaFzWspjOks4HhdkY3uQEU9xoclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPe7YA12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A77C4CED7;
	Tue, 17 Dec 2024 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467183;
	bh=szKv4c+yIO8qpqVrfikQ7GZl6LC2oSeWMMQ6QkdbdLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPe7YA12IiP7UuVtrgt9k7bcZKqTM914yb2GhTqIREs9gWk62KjasVBtHx/BvVQGe
	 n7diYP2LJJPTAWXXsFKr7RelCB9MT0dghkNSiRY94n0Pz0JraN6eo3uOu6JPt7jvXT
	 BZbwYY23mIJzMmauR4wUtxdEVFTzPQXmczwOu1s7DLZ9WL9JawMiafj03olqYg1yrs
	 YA/HY6XuolzIFLnYjYqrsRwUbSd07hKsiERBwpfsj/pTTPz0xnybWhF9NScve5kDGT
	 FHIUjgdpfGCTHF+4otkj/PqOI+JyRmCAuv4DZsFt7D+BbP3uodgEWWoKt0MbUQhgDm
	 dBrRsWJ0mRXzA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
Date: Tue, 17 Dec 2024 22:26:17 +0200
Message-Id: <20241217202618.1329312-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217202618.1329312-1-kvalo@kernel.org>
References: <20241217202618.1329312-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Currently when building ath12k with llvm-18.1.7-x86_64 the following warning is
observed:

drivers/net/wireless/ath/ath12k/mac.c:4946:13: warning: stack frame size (1112) exceeds limit (1024) in 'ath12k_sta_rc_update_wk' [-Wframe-larger-than]

A major contributor to the stack usage in this function is:

        struct ath12k_wmi_peer_assoc_arg peer_arg;

Avoid the excess stack usage by dynamically allocating peer_arg
instead of declaring it on the stack.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2a30a11903c5..10293e9c1d49 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4956,7 +4956,6 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	u32 changed, bw, nss, smps, bw_prev;
 	int err, num_vht_rates;
 	const struct cfg80211_bitrate_mask *mask;
-	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
 	struct ath12k_link_sta *arsta;
 	struct ieee80211_vif *vif;
@@ -4992,9 +4991,14 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
 
+	struct ath12k_wmi_peer_assoc_arg *peer_arg __free(kfree) =
+					kzalloc(sizeof(*peer_arg), GFP_KERNEL);
+	if (!peer_arg)
+		return;
+
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		ath12k_peer_assoc_h_phymode(ar, arvif, arsta, &peer_arg);
-		peer_phymode = peer_arg.peer_phymode;
+		ath12k_peer_assoc_h_phymode(ar, arvif, arsta, peer_arg);
+		peer_phymode = peer_arg->peer_phymode;
 
 		if (bw > bw_prev) {
 			/* Phymode shows maximum supported channel width, if we
@@ -5096,9 +5100,9 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			 * other rates using peer_assoc command.
 			 */
 			ath12k_peer_assoc_prepare(ar, arvif, arsta,
-						  &peer_arg, true);
+						  peer_arg, true);
 
-			err = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
+			err = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 			if (err)
 				ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
 					    arsta->addr, arvif->vdev_id, err);
-- 
2.39.5


