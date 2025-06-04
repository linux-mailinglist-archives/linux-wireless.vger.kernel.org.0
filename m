Return-Path: <linux-wireless+bounces-23626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA265ACD2BE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BA9177EEB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C91C8621;
	Wed,  4 Jun 2025 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2xcmt41"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706B1C8612;
	Wed,  4 Jun 2025 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998745; cv=none; b=pvjJgYR+68M48KzHNjofHd9LTvCqgr60UpaQSXzJ1j82HDwY6I+QMhjv8Bb3BHfrhdjdJ29bpc0azhCkPkC8td24c3UT1js/8seyNF2g/nnfhbKoJvcl5HKBhfyGM02ahfPIdTLcDdyOL9XNuGlTWHjrS5G5pNNtYPPD/eXgkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998745; c=relaxed/simple;
	bh=EanskMLqP4uD36AYGAXSC9mpFv4vywrsCHgNk4iilsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brwbUfy6mqBP7wR9pF+l17fcY4DZonmKvfHvSUgY4+OhZXXLokE8PiLI53HJR4NIlxbMOKM0wx5CcHTi+UBp102iuSReA9ySwMRIjYFS5Enfw3vFUCnwXjot4HDVGPbdStzuAbDgsRPYBeq2VUr3kEFVg5O2Cn0KgSvIQG1hHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2xcmt41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102E2C4CEED;
	Wed,  4 Jun 2025 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998745;
	bh=EanskMLqP4uD36AYGAXSC9mpFv4vywrsCHgNk4iilsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2xcmt41ZBQP7AhIzzioWhSBEfsdldG7HBQ5xSnaeu4CP5cxfSgN0OgO/FhCSH2LV
	 SiNdVpvjIQU1t0qzFFnzNEMouW1Q/OU+6wv2zIrUSnc0eyB7WV1FXBBffS/kwuhXm1
	 vQGrLHs4YCAxJFUh6GO+nfHX/lV7pTf7UMLwkKlqTgtT3gb43vEfa9wRqPANM8TvgP
	 R0ez5iib1vhDuhLXrnllU1cJmq3drHAGLSRfnti9WXpFu5KsXkxG4xKb0drEtF5cKp
	 vwoHTLhZ+bODUK5Zo+ExAK4qDuoFWqtISoMoHR+dZFUjH5i9Yz+LFcpPyPeBOZa8Ro
	 Jt6Fll0qKlFWw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Balamurugan S <quic_bselvara@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 106/108] wifi: ath12k: fix incorrect CE addresses
Date: Tue,  3 Jun 2025 20:55:29 -0400
Message-Id: <20250604005531.4178547-106-sashal@kernel.org>
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

From: Balamurugan S <quic_bselvara@quicinc.com>

[ Upstream commit 60031d9c3589c7983fd1deb4a4c0bebf0929890e ]

In the current ath12k implementation, the CE addresses
CE_HOST_IE_ADDRESS and CE_HOST_IE_2_ADDRESS are incorrect. These
values were inherited from ath11k, but ath12k does not currently use
them.

However, the Ath12k AHB support relies on these addresses. Therefore,
correct the CE addresses for ath12k.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Link: https://patch.msgid.link/20250321-ath12k-ahb-v12-2-bb389ed76ae5@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** ## Analysis and Recommendation This commit should be backported
to stable kernel trees. Here's my detailed analysis: ### **Nature of the
Bug** This is a **critical hardware register address bug** in the ath12k
WiFi driver. The commit fixes two important Copy Engine (CE) register
addresses: - `CE_HOST_IE_ADDRESS`: Changed from `0x00A1803C` to
`0x75804C` - `CE_HOST_IE_2_ADDRESS`: Changed from `0x00A18040` to
`0x758050` ### **Impact and Severity** **1. Critical Hardware
Functionality** These CE addresses control interrupt enable/disable
operations for Copy Engine rings, which are fundamental to WiFi
communication between host and firmware. Incorrect addresses would
cause: - Failed interrupt enable/disable operations - Potential missed
interrupts leading to stuck CE rings - System hangs or communication
failures with firmware **2. Affects Real Hardware** The commit message
explicitly mentions testing on real hardware: - **IPQ5332 hw1.0 AHB**
(currently deployed) - **QCN9274 hw2.0 PCI** (reference testing) **3.
AHB Device Support** These addresses are specifically used by AHB (AMBA
High-performance Bus) devices in functions like
`ath12k_ahb_ce_irq_enable()` and `ath12k_ahb_ce_irq_disable()`. IPQ5332
is the primary AHB device currently supported. ### **Comparison with
Historical Patterns** Looking at the similar commits provided: -
**Similar Commits #1 & #2** (both marked YES): Fixed DMA address type
issues in ath12k/ath11k CE rings to prevent future 36-bit DMA addressing
problems - **Similar Commits #3 & #4** (both marked NO): Added new CE
configurations for new device support (feature additions) This commit
follows the pattern of commits #1 and #2 - fixing existing incorrect
definitions that could cause hardware functionality issues. ### **Stable
Tree Criteria Alignment** **✓ Fixes Important Bug**: Incorrect hardware
register addresses affecting real deployed devices **✓ Small and
Contained**: Only changes two #define values in a header file **✓
Minimal Risk**: Simple address corrections with no architectural changes
**✓ No New Features**: Pure bug fix, not adding functionality **✓ Clear
Side Effects**: Limited to CE interrupt handling, well-understood impact
### **Risk Assessment** **Very Low Risk**: - Changes only constant
definitions in a header file - No algorithm or logic changes - Well-
tested on actual hardware as mentioned in commit message - Fixes latent
but critical hardware addressing bug **High Benefit**: - Ensures correct
hardware register access for AHB devices - Prevents potential system
failures or communication issues - Critical for proper IPQ5332 (and
future AHB device) functionality ### **Conclusion** This is a textbook
example of a commit that should be backported: it fixes a critical
hardware addressing bug with minimal risk and clear benefit. The
incorrect CE addresses could cause serious functionality issues for AHB-
based ath12k devices, particularly the IPQ5332 which is already
deployed. The fix is small, contained, and has been tested on real
hardware.

 drivers/net/wireless/ath/ath12k/ce.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 1a14b9fb86b88..f85188af5de2f 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_CE_H
@@ -39,8 +39,8 @@
 #define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
 
 /* CE address/mask */
-#define CE_HOST_IE_ADDRESS	0x00A1803C
-#define CE_HOST_IE_2_ADDRESS	0x00A18040
+#define CE_HOST_IE_ADDRESS	0x75804C
+#define CE_HOST_IE_2_ADDRESS	0x758050
 #define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
 
 #define CE_HOST_IE_3_SHIFT	0xC
-- 
2.39.5


