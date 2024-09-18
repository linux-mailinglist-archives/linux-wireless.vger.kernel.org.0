Return-Path: <linux-wireless+bounces-12975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304FF97C002
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA862833A6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897E1CA697;
	Wed, 18 Sep 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJCIKWvc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D21CA6A5
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683048; cv=none; b=MfwoJ/DA8FDVkXUGRsrxPumpolokeb/BPinbuP/Mv7ZGPRbA8u3R+4Oc63OiXKBGVdPWOCYJMsKdT7FY0572pwYy1zl6ZxjSdZL7YxtxG1E50PMiEW53er4hHs6Dx+kXrUfRTM0r1w6hn2rB5DkNc+YWEPV/hxrK9jAiA5d+lGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683048; c=relaxed/simple;
	bh=MWVesHo1qywTujYrfE4SGg4HnpXQDUExxEOEBYByavc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKrqmybCntga3euVWTppJan8vvyxfi4zHL8tK4FA4rqccysTc7jLpGH7Avf8AiDn7R2Ndl7GoxJ3nTl5z+r+0IfQlBtAg4UcGOTxNTB5DGxATjFZGtYrRTIXM5mo6IkODcUuFn9uKMhBQT772BLuEOArf3ijQB5W6T3polcUrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJCIKWvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFD3C4CEC6;
	Wed, 18 Sep 2024 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726683048;
	bh=MWVesHo1qywTujYrfE4SGg4HnpXQDUExxEOEBYByavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJCIKWvcW63HN8ENuaZciZcgnB8gzZYDjnAkN26w2SBoJAe2GFnE6XhCNhNXyehAd
	 4Yl4sUOo4+Mp4hYaAGXsX8heSQD+ceNid2fcO3VYO5tqD4wehWnqWqjPIB6MFJJyZK
	 hKjq90kxPX5TvnkghSd0aMROSlNJvAKRP8afE0fT5drm80EAvVHOmWXXJWQy1qE63c
	 CxsRhSZ+sjOb8P7nJPYsedK6cPTx8kIxuB6M35W/HVrfnD2XGFisQG9j2ihrTmV+Ns
	 AtQ1MSpvrlE5oVajIVVDyorIRib+kTJYvhHGjNAAdWVH960doxFef9IgoIZYL3Zlqw
	 39w8mvSevY/DA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 3/4] wifi: ath12k: ath12k_mac_op_set_key(): remove exit label
Date: Wed, 18 Sep 2024 21:10:41 +0300
Message-Id: <20240918181042.91891-4-kvalo@kernel.org>
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

In ath12k_mac_op_set_key() removing the exit label was a bit more complex as
checkpatch complained about the unnecessary else branch after a return. So
remove the else branch and remove now the unncessary ret initialisation.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a9d37a59a8c2..80db9004cdd7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3942,7 +3942,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
 	const u8 *peer_addr;
-	int ret = 0;
+	int ret;
 	u32 flags = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3970,14 +3970,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		if (cmd == SET_KEY) {
 			ath12k_warn(ab, "cannot install key for non-existent peer %pM\n",
 				    peer_addr);
-			ret = -EOPNOTSUPP;
-			goto exit;
-		} else {
-			/* if the peer doesn't exist there is no key to disable
-			 * anymore
-			 */
-			goto exit;
+			return -EOPNOTSUPP;
 		}
+
+		/* if the peer doesn't exist there is no key to disable
+		 * anymore
+		 */
+		return 0;
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
@@ -3988,13 +3987,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	ret = ath12k_install_key(arvif, key, cmd, peer_addr, flags);
 	if (ret) {
 		ath12k_warn(ab, "ath12k_install_key failed (%d)\n", ret);
-		goto exit;
+		return ret;
 	}
 
 	ret = ath12k_dp_rx_peer_pn_replay_config(arvif, peer_addr, cmd, key);
 	if (ret) {
 		ath12k_warn(ab, "failed to offload PN replay detection %d\n", ret);
-		goto exit;
+		return ret;
 	}
 
 	spin_lock_bh(&ab->base_lock);
@@ -4040,8 +4039,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 
 	spin_unlock_bh(&ab->base_lock);
 
-exit:
-	return ret;
+	return 0;
 }
 
 static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-- 
2.39.5


