Return-Path: <linux-wireless+bounces-23707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14FACE076
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED723A6E72
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CE62900B7;
	Wed,  4 Jun 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWPkp9GI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C62291162;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047772; cv=none; b=tJSdz9oHogR9VHJVMyc86VO8zwvZgLA0oV/wsr3hspNApM6bU/xjAenhmb58mC0hLOt0NNnQSuDwd5azC2HLODL3hFHAk/ydz5Tldtcw1p5LL0fFrS/gkQnmO8cfdrfF3q/iUOflBJqnq0m+g5Pu3EngG9f+5Yyyzo9CE1XrmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047772; c=relaxed/simple;
	bh=57PGqZIr4MccX98/Q9s3avEIt4j4j+e1Z330hecZA8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgUNcHN8pd4GI2Lmxf9XVWMY8oBFq96AT0m1yaGf7TeWMVwEM/xDkE4KgEL9I25z4v94AcXHQRs0rfsiwNvloCPGpM314iHEPLkQXg00bVpZc2pQZWhs7pw2qA8P9miQ8E7BO93wCsIKKH7nhV3fyOlpBUDQ+k7uJspO6YAvcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWPkp9GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA9AC4CEE4;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047772;
	bh=57PGqZIr4MccX98/Q9s3avEIt4j4j+e1Z330hecZA8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWPkp9GIk6Tclt42p7KK/Qk0o++CraPChb3Lhx0BjWRxcV9ea3KG8TYrsT5s9wUmO
	 yYGkzR/9gDPYZaIRx9cYxGlGBSS5feyKj08Flsx6haFbRnZ7wPrn585ftDZkNVuN/X
	 nFtI3N512CiJURPD7pdOODbFzWESo99WEKK/DN4xr8wOXc+uGc3NEGcQvlukjK81Ji
	 wQuDutr3o7GoTvwHNwhyYux63/UNasbADPm9ZgJPMASFv54qZ+4ZuX0VdEibef1wT2
	 yT7/aX5SVWq3RlDNa7mrosS5ftbmrf2WIu4n4hOd01CfMZXsRb+01NapgT8vEWqGsf
	 RdEDX8/GdM/Yg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpDt-000000006nT-3w5U;
	Wed, 04 Jun 2025 16:36:09 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/5] wifi: ath11k: fix dest ring-buffer corruption when ring is full
Date: Wed,  4 Jun 2025 16:34:57 +0200
Message-ID: <20250604143457.26032-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604143457.26032-1-johan+linaro@kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing memory barriers to make sure that destination ring
descriptors are read before updating the tail pointer (and passing
ownership to the device) to avoid memory corruption on weakly ordered
architectures like aarch64 when the ring is full.

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org      # 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 927ed2bc3fbf..7eeffb36899e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -854,7 +854,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -869,7 +868,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			dma_mb();
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
@@ -885,6 +888,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
-- 
2.49.0


