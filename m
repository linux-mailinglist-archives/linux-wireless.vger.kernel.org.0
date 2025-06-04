Return-Path: <linux-wireless+bounces-23713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3732AACE0A5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015F4167C42
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DC291884;
	Wed,  4 Jun 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkrLm8Ky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD529186E;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048349; cv=none; b=VSCdfsVtOgtcWJfpwedXX1mkRFf6/D8PUaV++nCva93RmLW91MgFFFz4ByopT1TnW7nB0Z6McJr/EhqEwrv3DO8S0G7/LAM/oGFSDfdWZBY421UmMBxdlqehyxOQFehsYTaPJ4KSgxD03+nZGRU2MfWB7uNko8EmpQbHaTPfUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048349; c=relaxed/simple;
	bh=w++DUul6WcS0rSeeNY1gMqZO7ksu6qS8oACYN9qdE9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwiYjGMqfFCHi9ypkQnQEcpaLO4yXnA5RhPRpwLlHzwHY7erut5oVt8hG+HF6WQbeKXpbv0JNgGbpgpvQq8UwqF/7kXxPMrDA3WDsmpjDXgxX2zSqF/PQNow2ltBGqqh7xzAKWqAAgFfj+Tz5C/MQtQmjlaaG/xlmnQLJwY7yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkrLm8Ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5051CC4CEF2;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749048349;
	bh=w++DUul6WcS0rSeeNY1gMqZO7ksu6qS8oACYN9qdE9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkrLm8KyEgBIdcnPkUh6cZBTFEjtbBHQX++sOEqB/pzXthf3AHJqb/zAXTT8E/Lgd
	 pI8TfaFYm3T8ElVMgZ+DWjX87LuF0790VA9kIVn3+e8RtTP4zIl0jtjkd03W5jWIEB
	 ikt5zblFvelL8rd8/sBkuOitWX/M4BN5nLHA5Z8y3ep1RKTiG3GihM54cF/6FSdpRG
	 ugPZbiMhztgLJJnqY6WlD2rimfEAQqGwDOpQk3ucXncIcrtprdkqFaeLQwi9a4Z0Q5
	 zBiyfpShGcoreRT+lkGwjIkn6gGTZ2Ila/eL8apzfzrsZWmsO7AojJMPd0KTyUf6l9
	 6071CGX5zPpLw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpND-000000007Of-1tJZ;
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
Subject: [PATCH v2 4/4] wifi: ath12k: fix dest ring-buffer corruption when ring is full
Date: Wed,  4 Jun 2025 16:45:09 +0200
Message-ID: <20250604144509.28374-5-johan+linaro@kernel.org>
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

Add the missing memory barriers to make sure that destination ring
descriptors are read before updating the tail pointer (and passing
ownership to the device) to avoid memory corruption on weakly ordered
architectures like aarch64 when the ring is full.

Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org      # 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 1e2d13cc2d19..4da354e86a75 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -2153,7 +2153,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -2168,7 +2167,11 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
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
@@ -2184,6 +2187,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath12k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
-- 
2.49.0


