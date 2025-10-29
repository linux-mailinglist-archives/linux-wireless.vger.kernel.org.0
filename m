Return-Path: <linux-wireless+bounces-28361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606AC1B56E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 15:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444A7626AF2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A42C3277;
	Wed, 29 Oct 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKymL+7v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42392BEC32;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748000; cv=none; b=m50G7ST1aJVx1sIZLyWllq1OPsLKPDhxUzpS41pS0cr59IfVaPY2Rrn3lQyxZznS/QCpc2cWJ1QSe/LeJAchWKr9E6I4HkvoQQQNRgZ9Jy3Xih9UryZ3J2lvs2vFlvE8CWApeWfBOclvK/Hqhq6hLvjb/ckwQ66axIT9QtaT4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748000; c=relaxed/simple;
	bh=AtjMxj2RJkTu7x047fEmpxwycKxJKu/Y4UgyPp4JT2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnDJ6nVtUmJoxaq8qe4SCv4cP/35GpjuGH8g5YFUFy3Yo9UIBRoLElur/lepqLMxflqsFz2uvq8Lx9sDHcQ/EGf1xGl5YpHkcl0u21BS+hNobLFYNlSpcpwJIa1ZLlgJ87pc10CaN7S2Wmx3a3vFRtWubQ4UBA45ylxWk0XRpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKymL+7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A181C116B1;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748000;
	bh=AtjMxj2RJkTu7x047fEmpxwycKxJKu/Y4UgyPp4JT2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UKymL+7vf4ctJnVjcsZtRD3JGJ/buIRHl51/x4BGUHIqB70HY4tBVqbrnlH+L3QKh
	 eqD1N16AZzDyGT8054ODSxCLFEX7I8AKZnxmJ9jIYN7fOpkUHwXCQRNZZaYIu8wLiV
	 sbHWmXjn/7v7UChbMY0tm9pBbeSXu6NMOLemsUmDUjPBhVCSkXKKwFwm/TCA/54VXI
	 bMdk/OJWAx/ZEXdy7rKTk7Y7VHyJ3wmeQK8xCYyIRm48XU5z3Fc0SX4FGwjox4GwZf
	 7mE+IIXl/RBE6+pv/e9UT7EoN657dP/1qOspCLUCTVOMU1vHw+tJ9OrIwxA/ClacHX
	 CmzImP+ZhlXCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B341CCF9F7;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 18:26:24 +0400
Subject: [PATCH 3/6] wifi: ath11k: add hw ring mask for QCN6122
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ath11k-qcn6122-v1-3-58ed68eba333@outlook.com>
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
In-Reply-To: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747997; l=3140;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=F4MQL1JaTu6P90bDVdrVejjoMM5YwIv+d0BERrhNqeI=;
 b=jJQlYmAbR/J3UObt+0UXmeqgU+6hjMtwkUdTs/DKqfZdNPaHuzOYmCKW57tGq64BUlBkeNTMm
 4liXEqZ3NfRB5ulQxmBEo5LcNaVE5wvzBQmE2ruW6iKRd93jTqdujOM
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add ring mask for QCN6122 and register them in hw params.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/hw.c   | 37 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 401b843402c6cca0e7fdd61e68b57fa6d5a6ae7e..b8ed8b673516855e6596d519c8234f4e230b6a2f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -919,6 +919,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_radios = MAX_RADIOS_5018,
 		.bdf_addr = 0x4D200000,
 		.hw_ops = &ipq5018_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qcn6122,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN6122,
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index caa6dc12a790b5072d5453ac123a604cf440a20a..56e7f86f2878f87aab42ae6abe504949b44297cc 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2070,6 +2070,43 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750 = {
 	},
 };
 
+const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn6122 = {
+	.tx  = {
+		ATH11K_TX_RING_MASK_0,
+		ATH11K_TX_RING_MASK_1,
+		ATH11K_TX_RING_MASK_2,
+	},
+	.rx_mon_status = {
+		0, 0, 0,
+		ATH11K_RX_MON_STATUS_RING_MASK_0,
+	},
+	.rx = {
+		0, 0, 0, 0,
+		ATH11K_RX_RING_MASK_0,
+		ATH11K_RX_RING_MASK_1,
+		ATH11K_RX_RING_MASK_2,
+		ATH11K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		0, 0, 0, 0, 0, 0, 0, 0,
+		ATH11K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		0, 0, 0, 0, 0, 0, 0, 0, 0,
+		ATH11K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		0, 0, 0,
+		ATH11K_REO_STATUS_RING_MASK_0,
+	},
+	.rxdma2host = {
+		ATH11K_RXDMA2HOST_RING_MASK_0,
+	},
+	.host2rxdma = {
+		ATH11K_HOST2RXDMA_RING_MASK_0,
+	},
+};
+
 /* Target firmware's Copy Engine configuration for IPQ5018 */
 const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq5018[] = {
 	/* CE0: host->target HTC control and raw streams */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 52d9f4c13b1366f2339b8900cf9db91e6ff1bcff..e7220c46de10c378ea5b452d78f921054ff54e54 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -285,6 +285,7 @@ extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750;
+extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn6122;
 
 extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq8074;
 extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018;

-- 
2.51.1



