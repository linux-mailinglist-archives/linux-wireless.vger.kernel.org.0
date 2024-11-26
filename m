Return-Path: <linux-wireless+bounces-15729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740409D9C28
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3487D28296F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659A1DDA09;
	Tue, 26 Nov 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmfvHdp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1B1DD9D1
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641112; cv=none; b=MvhUDeI4ru9hMwonxNyGp6qpWYfwJBn7ZZ5TuovQr8gLptJIZahQy1kohqVzrxAEiaHUnJ0hlympA95uq/jEUn5hgzW/dlfIbOhjy8nsUhHQWB/7FiFyjSNMLWVjRtGjwdPFxLMwQmNQQiNIqV4QbfqlTUiE+VyePqLIHeSIrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641112; c=relaxed/simple;
	bh=hQjedzDvhSnv4P35mhnpee32q6txbwbayatXB510sAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdyYOUUakYLWS8Mnp6g2M8lU2gasEFuDKjJ8xp1I57t0r03YnMdVyz9AECLpdgSWClaU9CzBHF3PBx7ROs8DOitHNk7C2m1/gO1YmryFvICs/o0RWr4Nc9c/IA52510G1LKHR9C77hPaV3rRj/WESI2p8M6CWhXRahF9owTAdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmfvHdp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D9CC4CED0;
	Tue, 26 Nov 2024 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641111;
	bh=hQjedzDvhSnv4P35mhnpee32q6txbwbayatXB510sAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmfvHdp+9TNBrlrTmJ+KrT1juzzy4mtam7dTsFZGlZscj58dPpFpFW6hxqyYnF3bU
	 59Fbd+FXcInGKHZVbVHVbXfcz+GvJOHlsfn1OHpaYIHmW0Z52EcW/201gs6emP/2Ty
	 bv6+JCQq5NN3GCEhFlCKuqZTPV/MgNnTogBX+a7QxV9zoRtoEoBzBBWCS235WHQJMj
	 0PcYu/vjVQuK+Kq1tDpRsSgdWAZSuM6wgqyAzP/uNl4XjVzBrjAL6ChqXSoIIjosP/
	 Wq1W0IdEb3adN/wfbBx0s8iVUgd4tZPR0DmBP6JZbZ7n61rze/ezXZHr4aPNAGa+48
	 dDLr3FXVHf++A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/10] wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
Date: Tue, 26 Nov 2024 19:11:38 +0200
Message-Id: <20241126171139.2350704-10-kvalo@kernel.org>
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
---
 drivers/net/wireless/ath/ath12k/mac.c | 59 +++++++++++++++------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f85661534d9e..f6c3128a675a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4657,6 +4657,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
+
 		/* For an ML STA Pairwise key is same for all associated link Stations,
 		 * hence do set key for all link STAs which are active.
 		 */
@@ -4679,41 +4680,47 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
-
-			ret = ath12k_mac_update_key_cache(cache, cmd, sta, key);
+		arsta = &ahsta->deflink;
+		arvif = arsta->arvif;
+		if (WARN_ON(!arvif))
+			return -EINVAL;
 
+		ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, arsta, key);
+		if (ret)
 			return ret;
-		}
 
-		ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, NULL, key);
+		return 0;
 	}
 
-out:
+	if (key->link_id >= 0 && key->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_id = key->link_id;
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+	} else {
+		link_id = 0;
+		arvif = &ahvif->deflink;
+	}
 
-	return ret;
+	if (!arvif || !arvif->is_created) {
+		cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
+		if (!cache)
+			return -ENOSPC;
+
+		ret = ath12k_mac_update_key_cache(cache, cmd, sta, key);
+		if (ret)
+			return ret;
+
+		return 0;
+	}
+
+	ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, NULL, key);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int
-- 
2.39.5


