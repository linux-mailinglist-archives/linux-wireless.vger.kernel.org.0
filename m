Return-Path: <linux-wireless+bounces-23601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDCBACD1D8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989707A84FB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6A1F3D58;
	Wed,  4 Jun 2025 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AijF7tpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC51F3BAC;
	Wed,  4 Jun 2025 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998510; cv=none; b=toYu5jEez0h/yj2ViNj4+ZfTgtObcqFqHDKnwmLBM7Ygy27FyrbIQPkt8ZmnWydXbhPOpdLgTxVFTX8y4Qm+u40B97lp5gAJD1pLDA7BAJHRxz3hHAcT2DGRCb1GWCjwYJKNuy99P0kaEOPdsVL8ckvVsKzJQRAB0/YzA8aeFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998510; c=relaxed/simple;
	bh=07fW1wem37NVtufrctH2RlYJ1s+trhbR6Xv3lx14wDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2K47PxY8xmUAVUxMpU/84uVEIPQY7o0V+SbPEzut4cswSN4hG4YvWBRaIwVtvoW0Sew3BNzobdr4/txbmb5y56+ExnzIDVbvLs/Ny4jweLQ1Mvx2kctLmLA2mvKKTBefdL1dTyfrJW2YBunauJeQokPwM3yxltr0u5/chQHU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AijF7tpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A0C4CEF1;
	Wed,  4 Jun 2025 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998509;
	bh=07fW1wem37NVtufrctH2RlYJ1s+trhbR6Xv3lx14wDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AijF7tpiRgjYqLVd9nn0LQjRU8Zkgze0b7HXmU4J/ktCSfFFxIwbOjY2U6p+Yma24
	 tkhmWaRr2+Ak+lSQtPcFcDpBBj0xmoQlLRm5iI+fUKkNR4Zt2/6mtcxomtlX0jORep
	 WxW5GRkYOQM25Am7JdW8iCSDgktUXC2xa9pMNuVmCfC9Mx7IL/HudgXxNbpHDUAsSH
	 ICC3EaxlsQbS0Z15g5LsDYg8raTScorod5iRPda3NqkC/YOC6DAJXdOt5N5FRDx7AG
	 Bc/zhB2WFQggONlUtTywtV6UlLGf42LV5+8I27OxW9PG6Ll7YoBIY3iD3gvfoGXPbj
	 9gAkOdcqiYszg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Mahendran P <quic_mahep@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 113/118] wifi: ath12k: Fix memory leak due to multiple rx_stats allocation
Date: Tue,  3 Jun 2025 20:50:44 -0400
Message-Id: <20250604005049.4147522-113-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>

[ Upstream commit c426497fa2055c8005196922e7d29c41d7e0948a ]

rx_stats for each arsta is allocated when adding a station.
arsta->rx_stats will be freed when a station is removed.

Redundant allocations are occurring when the same station is added
multiple times. This causes ath12k_mac_station_add() to be called
multiple times, and rx_stats is allocated each time. As a result there
is memory leaks.

Prevent multiple allocations of rx_stats when ath12k_mac_station_add()
is called repeatedly by checking if rx_stats is already allocated
before allocating again. Allocate arsta->rx_stats if arsta->rx_stats
is NULL respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Reviewed-by: Mahendran P <quic_mahep@quicinc.com>
Link: https://patch.msgid.link/20250326213538.2214194-1-muna.sinada@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Analysis of the Commit ### 1. Nature of the
Bug Fix This commit fixes a **memory leak** in the ath12k WiFi driver.
The specific issue is that `rx_stats` memory is allocated every time
`ath12k_mac_station_add()` is called, but when the same station is added
multiple times, it creates redundant allocations without freeing the
previous allocation, leading to memory leaks. ### 2. Code Changes
Analysis The fix is **minimal and surgical**: **Before the fix:** ```c
arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL); if
(!arsta->rx_stats) { ret = -ENOMEM; goto dec_num_station; } ``` **After
the fix:** ```c if (!arsta->rx_stats) { arsta->rx_stats =
kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL); if (!arsta->rx_stats) {
ret = -ENOMEM; goto dec_num_station; } } ``` The change simply adds a
NULL check before allocation, ensuring memory is only allocated if
`arsta->rx_stats` is NULL. ### 3. Risk Assessment - **Low Risk**: The
change is a simple conditional check that prevents redundant allocations
- **No Architectural Changes**: The fix doesn't alter any fundamental
driver behavior or data structures - **Contained**: The change is
localized to a single function and doesn't affect other subsystems -
**No New Features**: This is purely a bugfix with no new functionality
### 4. Comparison with Similar Commits Looking at the provided similar
commits, this follows the exact same pattern as **approved backport
candidates**: - **Similar Commit #2 (YES)**: "Fix memory leak in rx_desc
and tx_desc" - Similar memory leak fix - **Similar Commit #3 (YES)**:
"fix tx_stats memory leak" - Identical pattern fixing stats memory leak
in ath10k - **Similar Commit #4 (YES)**: "fix memory leak in WMI
firmware stats" - Memory leak fix in ath11k - **Similar Commit #5
(YES)**: "fix memory leak in ath12k_dp_rx_peer_frag_setup()" - Memory
leak fix in ath12k All these approved commits share the same
characteristics: - Fix memory leaks in wireless drivers - Make minimal,
surgical changes - Have low regression risk - Address real user-
affecting bugs ### 5. User Impact Memory leaks can cause: - System
memory exhaustion over time - Degraded system performance - Potential
system instability in resource-constrained environments - Affects users
with ath12k hardware (QCN9274, WCN7850 as mentioned in testing) ### 6.
Testing Evidence The commit includes comprehensive testing on real
hardware: - QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
- WCN7850 hw2.0 PCI
WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 ### 7. Stable Tree
Compliance This commit perfectly fits stable tree criteria: - ✅ Fixes an
important bug (memory leak) - ✅ No new features introduced - ✅ No
architectural changes - ✅ Minimal risk of regression - ✅ Confined to a
specific driver subsystem - ✅ Clear, well-documented fix ### 8. Code
Context Verification From examining the kernel tree, I confirmed: - The
function `ath12k_mac_station_add()` can indeed be called multiple times
(from state transitions and link assignment) - Proper error handling
exists with `kfree(arsta->rx_stats)` in the cleanup paths - The fix
addresses a real scenario where station addition can happen multiple
times This is a textbook example of a commit that should be backported:
it fixes a real memory leak bug with a minimal, low-risk change that
follows established patterns for successful backports in the wireless
subsystem.

 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 17415f7a1f51d..bcb5b049bba18 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5562,10 +5562,13 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 			    ar->max_num_stations);
 		goto exit;
 	}
-	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+
 	if (!arsta->rx_stats) {
-		ret = -ENOMEM;
-		goto dec_num_station;
+		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+		if (!arsta->rx_stats) {
+			ret = -ENOMEM;
+			goto dec_num_station;
+		}
 	}
 
 	peer_param.vdev_id = arvif->vdev_id;
-- 
2.39.5


