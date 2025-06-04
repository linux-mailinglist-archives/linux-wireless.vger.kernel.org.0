Return-Path: <linux-wireless+bounces-23702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C298CACE068
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7673A7E43
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DBF290D95;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7BBpsxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFF28FABD;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047772; cv=none; b=d2mdjn8RvPv42LheeaLHFrzTK3wylrtRH6VZhIHZM8z6tOnAARGmugxEk1NnHG87RMUvWAgklu1HJARztN9MfK8qvHYWsaYx+on5inFZb4vNMUBubbIoyyClP2b8i0e0YPJQe9QPMNnd5Vm0AueymdSty86Qao4zDOirrCldDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047772; c=relaxed/simple;
	bh=iInHrdEOEAauKbKtOoFyyL5VvQglkhpPuAxPB+SSYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/i+mLv6f242f4gT3dgYLpUK3Yi6lQTX7hJ/IHsVCBMzsWxL9CrE6otidtUM/Zdq7BJnfyu5rpJ5xIg9nq+2hB6jQtFhEIiqxUYC84PRyJVL/bbxsscLBc/mTU7Unbev/w1pzHjPPBKdynLREkqC69v0s5k++86QNUn8uDgSnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7BBpsxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A39C4CEF0;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047771;
	bh=iInHrdEOEAauKbKtOoFyyL5VvQglkhpPuAxPB+SSYRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7BBpsxBFbfZopvrATcBzQ6LEpTB3Ytqoa4O7+fND8JRpXi75bW/rkuia0QVNfYYT
	 COPnyyO7obEnPzcFZ8VAfRx313MarloovuChc5bgnXwNchWxDYVB/bLeDZn6iVegYK
	 LoCAwP6TYLcogkHvJgC/TU2kfoqyPAmTfC4CljmK/scFgNeJ/WwPyIxkdpkt0xePKU
	 OcrDFEBBJLWPxWOn2rDyqy31kMcSi6Wt9FlS+CXnd+QhWfsurl9RbPLcjsQRJB8/6U
	 wGw71xQ+TMRGSGq4hReLvRiTFUeJCebkBktCI5TB0RUkbRBV4J+4zrgbhn3zYoBG+x
	 XtcxxJ3lMXkmg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpDt-000000006nO-3W0M;
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
Subject: [PATCH v2 4/5] wifi: ath11k: fix source ring-buffer corruption
Date: Wed,  4 Jun 2025 16:34:56 +0200
Message-ID: <20250604143457.26032-5-johan+linaro@kernel.org>
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

Add the missing memory barrier to make sure that LMAC source ring
descriptors are written before updating the head pointer to avoid
passing stale data to the firmware on weakly ordered architectures like
aarch64.

Note that non-LMAC rings use MMIO write accessors which have the
required write memory barrier.

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org      # 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index b1f5a927dddd..927ed2bc3fbf 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -862,7 +862,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
-			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
+			/* Make sure descriptor is written before updating the
+			 * head pointer.
+			 */
+			dma_wmb();
+			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
 			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
@@ -871,6 +875,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			/* Assume implementation use an MMIO write accessor
+			 * which has the required wmb() so that the descriptor
+			 * is written before the updating the head pointer.
+			 */
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
-- 
2.49.0


