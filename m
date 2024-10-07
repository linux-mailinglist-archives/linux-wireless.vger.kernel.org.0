Return-Path: <linux-wireless+bounces-13617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B965993447
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223FC284256
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871381DCB29;
	Mon,  7 Oct 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS9MF4wk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A811DC731
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320380; cv=none; b=bMflupVA9vSIASurjCtO6aKK7MI+GYNTisMmiJBGxQjkm3lSB/iQWgHCjl5Hagh3eKcTQZ80V2SXEr7wwlCmIChH2oRelwLAuQtj8VafsavADzseEksLvBIkSK88mSjnKsk9qkgXIkyZnJEzvspQpG+hOhAXMbx+51bvHabaY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320380; c=relaxed/simple;
	bh=2W6wdVzPNu8qasNaX+ZRraHrtjNheF4CRWeSR3gh1nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OayR6MHIDFgIru1cyxDSPwCsnLIkBdP6Oxge96Y3qbU243Dx7KPdEVL4Q4E88z6o+CcaGcS76N3KiAhBi1PsB3yDPg/EBlwhVsVnx3wVbjfFxufSBBAiAh8fkwGMGThEOpmEA81/Q8Etg+begZeUHiXSrBdOVaVergu52VTNalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS9MF4wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C87FC4CECF;
	Mon,  7 Oct 2024 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320380;
	bh=2W6wdVzPNu8qasNaX+ZRraHrtjNheF4CRWeSR3gh1nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KS9MF4wkc8gffTCOKcQk0TYYaqE20zUKEAEDULQ7ayTQ5gnYMM/7PbK8iE1xXYren
	 UnCgkYooG1KYDghEwFBXNclF+Djp0pwR1WlTSrsCMmLF+GaYpEm7Akv+hkU3QJqeK/
	 CVmue0mghAE/ixFGVFLEIGhb+tea4cTaQZ6r0XDcueCntRPxUkmS17RixAM1jH2ZP3
	 nVLc7ErSql5rlhtRGGPeFFU7KMpDnEhv8ge99ugQ7JdjjZgvLwyvYhNHzcXNJ4K/NC
	 jNH/SRa6NKpdS3rjDqQzvz9J7jNn7VjCdVcOlQw2xoXHsUy8rpSqHdZ9scvrD3ssyd
	 BLUBKk9MpNrFg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 5/6] wifi: ath12k: ath12k_mac_set_key(): remove exit label
Date: Mon,  7 Oct 2024 19:59:31 +0300
Message-Id: <20241007165932.78081-6-kvalo@kernel.org>
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

In ath12k_mac_set_key() removing the exit label was a bit more complex so do
it in a separate patch. Remove the else branch and remove now the uncessary ret
initialisation.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1d1e91b124ca..0c0b87a6e9fa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3945,7 +3945,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	struct ath12k_peer *peer;
 	struct ath12k_sta *arsta;
 	const u8 *peer_addr;
-	int ret = 0;
+	int ret;
 	u32 flags = 0;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -3973,14 +3973,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
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
@@ -3991,13 +3990,13 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
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
@@ -4043,8 +4042,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 
 	spin_unlock_bh(&ab->base_lock);
 
-exit:
-	return ret;
+	return 0;
 }
 
 static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-- 
2.39.5


