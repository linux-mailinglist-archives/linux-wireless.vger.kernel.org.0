Return-Path: <linux-wireless+bounces-17945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE0A1CA60
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD8166A7E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20E15E5B8;
	Sun, 26 Jan 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8kuyeLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E315D5C4;
	Sun, 26 Jan 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903634; cv=none; b=qHYfYc0lZ7QEc/voVnt2HIFpY8x0g5Y05nUxYMh4xlK4og1Un9zse8DQ0TDquuHiDkQn3W8M5ivbeYVQ3N1kPt+VQFUyb6Zt734Ma0Kzdmetnte3wnMUv9YzTEC2GSykDQYgMduKIwgpzaxkBTCm9q5ueXA6QJ8jUXr6JQKtfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903634; c=relaxed/simple;
	bh=etJYQKH9IMjbZbn+KKak13KlQlys5HDLkMgYkdbQ+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5xES4jVYmUhoOSlRBG5seF+jMLH8RaDb3vuFEIYPMDQikh4jETcpUoa5epo75mxhAc1++d8r5e0mNIaLLDc2oP/8M0uc1yPFD26SyBN7LGWyKsgCys+YRqPTl3aMy33C5WGdirmIANLp7GioVHkSwjXjmG/R8+r9wT8BYdlock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8kuyeLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A74AC4CEE3;
	Sun, 26 Jan 2025 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903633;
	bh=etJYQKH9IMjbZbn+KKak13KlQlys5HDLkMgYkdbQ+NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8kuyeLSh1YTk2MxF+pi8hpVmjnx5uiBk+ZZPD6imCuFvrKUPgVKXUsvnQkVFhnRv
	 1fdJT5vsuv3Qp+hvgvLlcNAYcqgDgRlgSvALnzuzJlMQfnFfHZqcBcl8jEPXP+XOqq
	 X2CF2o4Os02Q/IiMcL/wdhtyyuUV8VI0XEcPNDTjYjcBaEUz5piRWP/lwTae3OIeP4
	 5Xvfyv7b2CFEQ4/Xg8RU8iDF0vbVSyLhMX9jmOUSH6BLqO3y3o88Lym9+Avq7bQ7qA
	 Q58149qkNIROp9ryZqkDMmuWD6tAcgqD2TNVpgBieeQRSwxNN6Qe8d72DHlgMhy5Z4
	 lBbSf+DQlyrzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kalle Valo <quic_kvalo@quicinc.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 02/35] wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
Date: Sun, 26 Jan 2025 09:59:56 -0500
Message-Id: <20250126150029.953021-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

[ Upstream commit ad969bc9ee73fa9eda6223be2a7c0c6caf937d71 ]

Dan reported that in some cases the ret variable could be uninitialized. Fix
that by removing the out label entirely and returning zero explicitly on
succesful cases.

Also remove the unnecessary else branches to follow more the style used in
ath12k and now it's easier to see the error handling.

No functional changes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/7e7afd00-ad84-4744-8d94-416bab7e7dd9@stanley.mountain/
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20241126171139.2350704-10-kvalo@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 57 +++++++++++++++------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d493ec812055f..b1f0a5e9d6577 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4372,6 +4372,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
+
 		/* For an ML STA Pairwise key is same for all associated link Stations,
 		 * hence do set key for all link STAs which are active.
 		 */
@@ -4394,41 +4395,47 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				if (ret)
 					break;
 			}
-		} else {
-			arsta = &ahsta->deflink;
-			arvif = arsta->arvif;
-			if (WARN_ON(!arvif)) {
-				ret = -EINVAL;
-				goto out;
-			}
 
-			ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, arsta, key);
-		}
-	} else {
-		if (key->link_id >= 0 && key->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
-			link_id = key->link_id;
-			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-		} else {
-			link_id = 0;
-			arvif = &ahvif->deflink;
+			return 0;
 		}
 
-		if (!arvif || !arvif->is_created) {
-			cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
-			if (!cache)
-				return -ENOSPC;
+		arsta = &ahsta->deflink;
+		arvif = arsta->arvif;
+		if (WARN_ON(!arvif))
+			return -EINVAL;
 
-			ret = ath12k_mac_update_key_cache(cache, cmd, sta, key);
+		ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, arsta, key);
+		if (ret)
+			return ret;
 
+		return 0;
+	}
+
+	if (key->link_id >= 0 && key->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_id = key->link_id;
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	} else {
+		link_id = 0;
+		arvif = &ahvif->deflink;
+	}
+
+	if (!arvif || !arvif->is_created) {
+		cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
+		if (!cache)
+			return -ENOSPC;
+
+		ret = ath12k_mac_update_key_cache(cache, cmd, sta, key);
+		if (ret)
 			return ret;
-		}
 
-		ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, NULL, key);
+		return 0;
 	}
 
-out:
+	ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, NULL, key);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.39.5


