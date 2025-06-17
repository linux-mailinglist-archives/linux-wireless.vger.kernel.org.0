Return-Path: <linux-wireless+bounces-24185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11BADC53F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1B17117F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80122900B2;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2KAgB8x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20028FFFB;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149890; cv=none; b=lk2QXmZli629scP4L4zJBzM79wSB6gsd7vKA5lA039cUNE5BEREE6q6D2n5s/ktXjbP1Wl9TCAlnDCPAiaFxzl+4b3M1AvEriDq4J/aUXndSM3BJUWIYEzDcyrthD+iACloSNQyrZwyxqvfrtU3rbkD3Xx79xrhUYdwTXla3Dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149890; c=relaxed/simple;
	bh=XlOa4Weus0mkUtfWT3aYaV9OXWVLYZr4aEDz/snbCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXa89hnLXUzU8KGhdFRl+5ik1grX/G2apCZ73EPd+ws54H7+Ai3oeqLQy5Csm6wRUwTFDfoVkI4B8zvllDoZxZnEMYphrAk1eqtnU8/DsdJSSb6K4R0kOYgQvQeUSpnKUnxwT5KKM62nATjoJyy7RtwU+xilMX5oq+bRZWauU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2KAgB8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1FC4CEF8;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149890;
	bh=XlOa4Weus0mkUtfWT3aYaV9OXWVLYZr4aEDz/snbCxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2KAgB8xCCpCAXskBTZ4pYd1aCutL+dYB9ERBVMeeojdtwDRyVQfnXwgd1R3OW6a5
	 O+i6+M09v3D+1mxRbPvdN0o0yBv6jF4uFgnIfRbQdq+Yj8tuYZyUQsSHAa6z9hNPv/
	 wP4gQTcXBRolYRKTP1iE/NVSRzWbL1M+SDgrNhlFnRQq9ihUDvOnUTouAKQRRdN3Ai
	 Grfuwa8AR6wJsNm/ycqU5RCSeDenNYYByn8FGupL2Qv7itxeF1TSaMhRviecHXh7nc
	 D2VLRJkRgTJfQxzF+FIE349OsouVsDmtikYt6vA2XGc73LnUNQmuqTYhyLXZ6myLcu
	 I3wT85r2nyWqw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uRRw0-000000003mv-1M6K;
	Tue, 17 Jun 2025 10:44:48 +0200
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
Subject: [PATCH v3 4/4] wifi: ath12k: fix dest ring-buffer corruption when ring is full
Date: Tue, 17 Jun 2025 10:44:02 +0200
Message-ID: <20250617084402.14475-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617084402.14475-1-johan+linaro@kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
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
index d8193d9577bb..6406fcf5d69f 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -2170,7 +2170,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -2185,7 +2184,11 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
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
@@ -2201,6 +2204,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
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


