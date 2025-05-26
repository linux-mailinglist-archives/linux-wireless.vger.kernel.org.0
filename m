Return-Path: <linux-wireless+bounces-23428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96269AC3EF5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08ED18874BC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB71F9F70;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdRUSMXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC611F7904;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260336; cv=none; b=CafvVxSKKOL5opjhRGnnG4N10rQE4OieBH9oJGj3viPbzoqxFbo6CnpP+Yk9aiRfRNUmzTvqSmDfj1QKC4r2vQlsSTmbvrJr5C82fudYTx+e+nf25C7IiJOdhO8irsYvT3b3gPMwwdlXPqhicC6Ovjuqca0ZVCiN8U3RTFEdvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260336; c=relaxed/simple;
	bh=PerCT+iLxD5zsw5LMxLFNaQeXnIW4oHIuRshGvuczYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdIY8AMKwHZKFVAasqRM1jwaW29gPwtfdRFk3fyCbqkB0n57DnxTKbRACC+Sp+Gh0jpeK9pg4QsTmGK11LxWM2zMmDusGmSjBDwE9/Cl+edU0KgIx9eBeBeQ3ie7YbFvDLbqB/bnfnPBIt+fCYVXeMixF80diqHmlTikX5esDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdRUSMXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5701AC4CEEF;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260336;
	bh=PerCT+iLxD5zsw5LMxLFNaQeXnIW4oHIuRshGvuczYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdRUSMXv6KQLm9B35acLeX2FNOh3q2aBIQYLdcSP9kM0HRmMdLdcPLev302MCgbea
	 XY0dPc9kuLMHPDIg0MxLjyVurTAdwG81Wn8NId9xd6as8/NZZIq7x359PIzHiJJsBB
	 4oPxmlKiM8zOwnNwiz8Gkgba5Ufj3t/WlpiNxTzk+v/UK2f7UJOPjiGqfs6hsX7qbl
	 TqIKzeskWILxkW0MxIHzOUA+9bGuT35AY1bzHRG5l87TX5hpweGSAe0TpRHTnuyYG9
	 LyAJ7sMducBK9TV8anKItVGYHDLuNXGyk3YxAlhXNs5qJNVL4G6m/eoKy1amWMBvmz
	 CFYLg+uozcg6Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWNN-000000000fG-3sio;
	Mon, 26 May 2025 13:52:17 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath12k: fix dest ring-buffer corruption
Date: Mon, 26 May 2025 13:51:36 +0200
Message-ID: <20250526115137.2490-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526115137.2490-1-johan+linaro@kernel.org>
References: <20250526115137.2490-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing memory barriers to make sure that destination ring
descriptors are read after the head pointers to avoid using stale data
on weakly ordered architectures like aarch64.

Note that this may fix the empty descriptor issue recently worked around
by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
monitor ring").

Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org	# 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c |  3 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..90a7763502c8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3258,6 +3258,9 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	spin_lock_bh(&srng->lock);
 	ath12k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (likely(*budget)) {
 		*budget -= 1;
 		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75bf4211ad42..68fceb4201d7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2753,6 +2753,9 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 try_again:
 	ath12k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
 		struct rx_mpdu_desc *mpdu_info;
 		struct rx_msdu_desc *msdu_info;
@@ -3599,6 +3602,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	ath12k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (budget &&
 	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
 		drop = false;
@@ -3941,6 +3947,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 	ath12k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (budget) {
 		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
 		if (!rx_desc)
@@ -4122,6 +4131,9 @@ void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 
 	ath12k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
 		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index ced232bf4aed..3124eafa0201 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -853,6 +853,9 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 
 	ath12k_hal_srng_access_begin(ab, status_ring);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (ATH12K_TX_COMPL_NEXT(tx_ring->tx_status_head) != tx_ring->tx_status_tail) {
 		desc = ath12k_hal_srng_dst_get_next_entry(ab, status_ring);
 		if (!desc)
-- 
2.49.0


