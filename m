Return-Path: <linux-wireless+bounces-23709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1512ACE09F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B88A16A585
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7B290DB9;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHv8Tzxa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDF32C85;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048349; cv=none; b=T03IIDVE1Pd1yhydhlCSWGJI9J5mnl5UcQe/YhAqcAYFnV7DnjtOEaG3Yz0Dh9iS6nmYePx5AJ15X/VVNQPtvqKI3yjCvpK0r5J1/M8Y+gBGNBt4f9QVXw8q4AyX3dR4wHKQtOKPfsQutHrC45zZoWZlQki7i/CSeJUXLMnMfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048349; c=relaxed/simple;
	bh=AahTbiL0j1lHqgp6tMq8JeHQ5K8h8e6zfnJJYbWsUc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcEMHvQ5TgjxBkZhS/41HSjePhOpBYtZ66UgPhso+GvDvmcVl7YaEIW1GBetKLXz9Wn9PdQsnuf4kaID6vOzW2b2rUwcvoUBBE4L89+7v1vwJWM0XcWuxNwZNlfQpvXbRXrG35D69oYa93HXFVG8uQaj7dGtivTMm2+fpKQrzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHv8Tzxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2ABC4CEF1;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749048349;
	bh=AahTbiL0j1lHqgp6tMq8JeHQ5K8h8e6zfnJJYbWsUc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHv8TzxaZHukiEWdht1QcuRlHO9xmK/M+5GLLPyEstC2Ehyn++Usz8tx2FV+mpjG2
	 pXjvObsHHKorU8W6CbN1kGvZUi1Z+7Ca+bqSJQBBF+ZuvwwgexQhA9wi/zoSn1Fq8l
	 Nw12m1EGo6aFwPdBtLI7LaAiPafjAgw6ihZo38dYkyH4aI3JjO2cseTSyDE3vujzBY
	 nK+s0LzaLKlEmdqBPKpsGp+8sgySANx3/FEhDOmslVL6MLYTR78ymUNI6IA57rTDXs
	 0sGtzvH5Ih1CroG5x+HEZUu5peIjVsE7P/i0C8XXeREs/rGW5etxoFbTHOdXkwNyWy
	 VRqWXddF2Qbbg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpND-000000007OY-0oJh;
	Wed, 04 Jun 2025 16:45:47 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
Date: Wed,  4 Jun 2025 16:45:06 +0200
Message-ID: <20250604144509.28374-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604144509.28374-1-johan+linaro@kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing memory barrier to make sure that destination ring
descriptors are read after the head pointers to avoid using stale data
on weakly ordered architectures like aarch64.

The barrier is added to the ath12k_hal_srng_access_begin() helper for
symmetry with follow-on fixes for source ring buffer corruption which
will add barriers to ath12k_hal_srng_access_end().

Note that this may fix the empty descriptor issue recently worked around
by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
monitor ring").

Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org	# 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/ce.c  |  3 ---
 drivers/net/wireless/ath/ath12k/hal.c | 17 ++++++++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index 740586fe49d1..b66d23d6b2bd 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 91d5126ca149..9eea13ed5565 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
 
 void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 {
+	u32 hp;
+
 	lockdep_assert_held(&srng->lock);
 
-	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
+	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
-	else
-		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+	} else {
+		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+
+		if (hp != srng->u.dst_ring.cached_hp) {
+			srng->u.dst_ring.cached_hp = hp;
+			/* Make sure descriptor is read after the head
+			 * pointer.
+			 */
+			dma_rmb();
+		}
+	}
 }
 
 /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()
-- 
2.49.0


