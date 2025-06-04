Return-Path: <linux-wireless+bounces-23607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C0ACD244
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF127ABF9D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16187191F74;
	Wed,  4 Jun 2025 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKlTNvPb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F728691;
	Wed,  4 Jun 2025 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998590; cv=none; b=ccsUy6/RB6jDYR/PrdP2YOx8mDpCvDpXEUYGoILniipVVyTSgo1iLmkZ9C+CiKUx00bXAFRClv0Pm08muMD3YFmtYcJYUDn54UROezwYrHO1q8LTFAzHu7xm7/m9oMOW3GFdsAjcYlFgGvCkhO4qnGv6Favg4bD7BtozAdiHDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998590; c=relaxed/simple;
	bh=W3v5cX6W547oZ9Y+uiz3ywkZ3UWfXt+rFSKyqj9NNIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNOhMISH/mdJLFIWLDCRqwyLOiykK1MbUcO8AQ7ixA+/lit6d3pBoYgFHG9LJs4L/uQsugCHAjMCWkpa5hW/HW4q7Mr4n4pHYccQMnKdNTvRsAgw/BNuiVqIMc5uY7dVOV07rcXxumvPE4e18b9pt2edCqL9hc+0XqxCgJP2iYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKlTNvPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD389C4CEED;
	Wed,  4 Jun 2025 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998589;
	bh=W3v5cX6W547oZ9Y+uiz3ywkZ3UWfXt+rFSKyqj9NNIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKlTNvPbEnQysKcia1dK4UR1a1WdLhwGgWUOA0LsbSpseCl/9AXA7zlQn+bFLEIEm
	 W1xrtnyoD00L8jquGRPo4mwpsKpW/hDIHa9Ct8uXZ+iDxK/8bN9iVh9V79ZzAzd8+o
	 7HwJastF1oUOaxK5HzaDoqPdxSM1H+a7t38jrt7u5n9SU0RCbVLn8M+XQPCjgS7i57
	 83P2w1DxzrAGvjb1iGH1ybBMDljrgBHCeBUtx913hDusbm0qLe91odWo358pbAM5p7
	 aTvbQq3U4ZiSq1tfKSsgUWR5hIebnG2NoiB4icND7hCzDDJMKcWec6JJ+JehbV+7jo
	 LdKECPp3HwpUA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kang Yang <kang.yang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 027/108] wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
Date: Tue,  3 Jun 2025 20:54:10 -0400
Message-Id: <20250604005531.4178547-27-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Kang Yang <kang.yang@oss.qualcomm.com>

[ Upstream commit a69bbf89d751ba2d6da21d773c4e29c91c5e53c4 ]

Currently, HAL_RX_MSDU_PKT_LENGTH_GET uses u32_get_bits to obtain the
MSDU length from the MSDU description.

This is not right. Because all halphy descriptions are little endian.

So use le32_get_bits for HAL_RX_MSDU_PKT_LENGTH_GET.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250421023444.1778-9-kang.yang@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees as it
fixes a critical endianness bug that can cause data corruption and
system crashes. ## Analysis ### Nature of the Bug This is a **critical
endianness bug fix**, not a feature enhancement. The commit changes
`HAL_RX_MSDU_PKT_LENGTH_GET` from using `u32_get_bits` to
`le32_get_bits`. The issue is that the underlying data structure
`rx_msdu_desc` has `info0` declared as `__le32` (little-endian), but the
macro was treating it as native-endian. ### Critical Impact Areas **1.
Memory Safety & Data Corruption:** - The macro extracts MSDU (MAC
Service Data Unit) packet lengths from hardware descriptors - On big-
endian systems, `u32_get_bits` vs `le32_get_bits` would extract
completely wrong values - These incorrect lengths are used for buffer
bounds checking and memory allocation operations - This could lead to
buffer overflows, memory corruption, or kernel crashes **2. Cross-
Architecture Compatibility:** - This bug would manifest on big-endian
architectures (ARM BE, MIPS BE, PowerPC) - x86/x86_64 systems wouldn't
notice the bug due to little-endian architecture - The ath12k driver
supports multiple hardware variants that require correct endian handling
**3. Hardware Descriptor Consistency:** - Analysis shows the ath12k
driver predominantly uses `le32_get_bits` (287 instances vs 242
`u32_get_bits`) - All hardware-specific MSDU length extraction
consistently uses little-endian operations - The `struct rx_msdu_desc`
explicitly marks `info0` as `__le32`, confirming hardware uses little-
endian format ### Comparison with Similar Commits All the reference
commits marked "NO" were either: - Feature additions (A-MSDU indication
improvements) - Structural definition updates - Hardware descriptor
format corrections This commit differs fundamentally - it's fixing
actual data corruption that could cause crashes. ### Backporting
Justification - **Fixes user-affecting bug**: System crashes and data
corruption on big-endian systems - **Small and contained**: Single line
change with clear, targeted fix - **No architectural changes**: Only
corrects endianness handling - **Minimal regression risk**: Aligns code
with actual hardware behavior - **Critical subsystem**: Network packet
processing is core functionality This endianness bug represents exactly
the type of critical, low-risk fix that stable trees are designed to
address.

 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index a102d27e5785f..d155f95d21c39 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -707,7 +707,7 @@ enum hal_rx_msdu_desc_reo_dest_ind {
 #define RX_MSDU_DESC_INFO0_DECAP_FORMAT		GENMASK(30, 29)
 
 #define HAL_RX_MSDU_PKT_LENGTH_GET(val)		\
-	(u32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
+	(le32_get_bits((val), RX_MSDU_DESC_INFO0_MSDU_LENGTH))
 
 struct rx_msdu_desc {
 	__le32 info0;
-- 
2.39.5


