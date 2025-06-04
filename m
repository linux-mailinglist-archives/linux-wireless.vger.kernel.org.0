Return-Path: <linux-wireless+bounces-23617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66138ACD28C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD8F3A28ED
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95BB2571BA;
	Wed,  4 Jun 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEgDwArt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0CE1C2DB2;
	Wed,  4 Jun 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998703; cv=none; b=iKsEtpjTqXdBWeCZmo5xsCGskR9J7NVdeDoe/jsUWNFIdFw3JRQ0oG/YJTL0Wvzj+YDbSDcEqobfoVA6mp96DVH9y4yYTa6Jc/BDsmFVgtYl1gKmYxxWBkG8eweaGBo524aiu4cBcwVhoqFHACOdUtDa6DDLdyDZ83lE31Vvd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998703; c=relaxed/simple;
	bh=8VlDHP8blotr+uc9d03vKYUBplK//RGd9K4tZBW8ziQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLRjzp+SgzSCl6piI7TkWbCYfFIHp3oZxwDVXzNWCEogB6Oza8v7k+8LXltab1gnWTZhZLsrng4Qycyh845yogku1AnJVZKPKaNxOhV0TSML7Jc15fm1ikXzIDwZ5x3JEnUr35qVbv0z/MUcVtb8byDkRQf13V6Znxo/Hd1edQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEgDwArt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FE9C4CEF1;
	Wed,  4 Jun 2025 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998703;
	bh=8VlDHP8blotr+uc9d03vKYUBplK//RGd9K4tZBW8ziQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEgDwArtg9OdjiEl/6LXp5bgLQhZCcmojfZeuqwwFoYsVL1RO8ZsO2ucl0GpyzDx3
	 H9mL/J1CqUVNhiP8An5gvtnkv1F1mvODN5EbljbM6Lm+W3eF7G76b5r/zJk3tsK1sA
	 c7FnUzDz4tGuJ0OUQLAi8gFtnl8s6CCkkbUSJkgwX0xDmS8qLJs8g+76PDTca/ltIM
	 p1P5XfMQXs1i0b59IAKy6XtFkBd6AyI7QcokZ0CeOIZ0R4sVJdN3vY7K0TVRnCRyUK
	 8KjClVeC7gtJPRz2dlRwolbdjN4m2KM7Gnw9u/kRSMSI3xl7VkcF/wLMu4xXSE3LL8
	 dLcbNp6kzBkfQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sarika Sharma <quic_sarishar@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 082/108] wifi: ath12k: correctly handle mcast packets for clients
Date: Tue,  3 Jun 2025 20:55:05 -0400
Message-Id: <20250604005531.4178547-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sarika Sharma <quic_sarishar@quicinc.com>

[ Upstream commit 4541b0c8c3c1b85564971d497224e57cf8076a02 ]

Currently, RX is_mcbc bit is set for packets sent from client as
destination address (DA) is multicast/broadcast address, but packets
are actually unicast as receiver address (RA) is not multicast address.
Hence, packets are not handled properly due to this is_mcbc bit.

Therefore, reset the is_mcbc bit if interface type is AP.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250411061523.859387-3-quic_sarishar@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Analysis **Root Cause**: The commit fixes
a critical packet handling issue where multicast/broadcast packets from
clients to an AP are incorrectly marked as multicast (is_mcbc=true)
based on the destination address (DA) being multicast, even though they
are actually unicast packets since the receiver address (RA) is not
multicast. **Impact**: This causes legitimate unicast packets to be
mishandled, potentially leading to: - Incorrect encryption handling
(using group keys instead of unicast keys) - Packet drops or processing
errors - Connectivity issues for clients connected to AP ## Code Changes
Analysis The fix involves three key changes: 1. **New peer field
(`peer.h:65`)**: Adds `bool ucast_ra_only` field to track when a peer
should only receive unicast packets 2. **Peer initialization
(`peer.c:386-387`)**: Sets `peer->ucast_ra_only = true` for AP interface
types, indicating that packets to/from AP clients should be treated as
unicast 3. **Runtime correction (`dp_rx.c:2328-2331`)**: Adds logic to
reset the is_mcbc bit when a peer has `ucast_ra_only=true`: ```c /bin
/bin.usr-is-merged /boot /dev /etc /home /init /lib /lib.usr-is-merged
/lib64 /lost+found /media /mnt /opt /proc /root /run /sbin /sbin.usr-is-
merged /snap /srv /sys /tmp /usr /var resetting mcbc bit because mcbc
packets are unicast capability_test capability_test.c
f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md mac80211_mlo_mbssid_analysis.md
pfcp_driver_historical_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
test_unaligned_diff test_unaligned_diff.c type_size_check
type_size_check.c veth_driver_analysis.md
wifi_mlo_mbssid_tx_link_id_analysis.md packets only for AP as STA sends
unicast packets. linux/ rxcb->is_mcbc = rxcb->is_mcbc &&
!peer->ucast_ra_only; ``` ## Backport Suitability Assessment **✅ Fixes
Important Bug**: This addresses a real packet handling issue that
affects AP functionality and client connectivity. **✅ Small and
Contained**: The fix is minimal - adds one field and a simple boolean
logic correction. Total change is ~10 lines. **✅ Low Regression Risk**:
- Only affects AP mode (`NL80211_IFTYPE_AP`) - Uses conservative
approach (resets mcbc bit only when appropriate) - No architectural
changes **✅ Clear Side Effects**: The change is isolated to
multicast/broadcast packet classification logic and doesn't touch other
subsystems. **✅ Subsystem Confined**: Changes are entirely within the
ath12k Wi-Fi driver's receive path. ## Comparison with Similar Commits
This commit closely matches **Similar Commit #1** and **Similar Commit
#3** (both marked YES for backporting): - Fixes multicast/broadcast
packet handling issues in ath12k - Small, targeted fixes with clear bug
descriptions - Hardware-specific corrections for packet classification -
Similar code patterns and impact scope The commit follows the same
pattern as other successful ath12k multicast fixes that were deemed
suitable for stable backporting. ## Conclusion This is a classic stable
tree candidate: it fixes a real user-impacting bug with a minimal, low-
risk change that's confined to a single driver subsystem. The fix
addresses incorrect packet classification that could cause connectivity
issues in AP mode.

 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c  | 5 ++++-
 drivers/net/wireless/ath/ath12k/peer.h  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ff6a709b5042c..cfa96c6216177 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2277,6 +2277,11 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer) {
+		/* resetting mcbc bit because mcbc packets are unicast
+		 * packets only for AP as STA sends unicast packets.
+		 */
+		rxcb->is_mcbc = rxcb->is_mcbc && !peer->ucast_ra_only;
+
 		if (rxcb->is_mcbc)
 			enctype = peer->sec_type_grp;
 		else
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 792cca8a3fb1b..ec7236bbccc0f 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -383,6 +383,9 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		arvif->ast_idx = peer->hw_peer_id;
 	}
 
+	if (vif->type == NL80211_IFTYPE_AP)
+		peer->ucast_ra_only = true;
+
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
 		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 5870ee11a8c7e..f3a5e054d2b55 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_PEER_H
@@ -62,6 +62,7 @@ struct ath12k_peer {
 
 	/* for reference to ath12k_link_sta */
 	u8 link_id;
+	bool ucast_ra_only;
 };
 
 struct ath12k_ml_peer {
-- 
2.39.5


