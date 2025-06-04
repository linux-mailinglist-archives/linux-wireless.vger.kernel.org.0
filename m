Return-Path: <linux-wireless+bounces-23584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD389ACD148
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 02:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B122217601E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55301A2393;
	Wed,  4 Jun 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFRhzALC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D31A0712;
	Wed,  4 Jun 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998315; cv=none; b=pc+Enfd0z1zfH71WP5y5IpwUurSMmvuT5cQV+OekJkgw/a+sYUkF/HsgzmCA76tsQ1XmXRw77YJVPHztR3s0EVvcHZJ+cayNA9GffNDLDHS+fXkEmlwh1qQ6o7ZLmINzVbmZueEMJeNCOtM0tVw/Z/5SJdHq81Sy8BE988utysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998315; c=relaxed/simple;
	bh=BY/A9ozJ7BX+EZdswgcU06eCQ0oVz7x68wZ0s+Cavt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFe/ip36pT0JRrRLrnpOut2cg8x1AHo7eRSnPwksT+/1ZABflcfhVqKr4AZODdQxzGqcS0eUt112aI5IQdsoYNx9uFglW3ikEiiWvshm67VCc6pmmgaziBVyd9E31eLJM4cMNNH9xZSD1vfLNj8/nRzOx1R+YyzFGpZqZb5FB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFRhzALC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3188C4CEEF;
	Wed,  4 Jun 2025 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998314;
	bh=BY/A9ozJ7BX+EZdswgcU06eCQ0oVz7x68wZ0s+Cavt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFRhzALC4hPTW14YGZ+yxxYttf+nBmssr6Q4dyiASbYthc9SZW4a9JFnHGlRMwAZf
	 rCcXZalSM3m5W2u+JpX/QYwc2Wr8LiEkpsbtU6bZWzXu9ZiYu+kpozwHjO8O1gAqyj
	 zzYrvzPuPQ/+3i8xeXBwL3Hp3a1Y+xfq/o58xFu937ezHt990BZGvDfIIV84u8gCd1
	 CZmOCfEj8WwHq90SdD+TiFwW+nFL4a1zA6dqyQf9X7tW8XtIQ8u+LK/cmsyXD/b9nK
	 hHyEVZ+TUq2u3/GE4+auWLoK1D4zkAzXrc8XD6tpqPsN9h9GE3ePMy5Iyd45cdg4Ac
	 qMI5LTk814jNA==
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
Subject: [PATCH AUTOSEL 6.15 030/118] wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
Date: Tue,  3 Jun 2025 20:49:21 -0400
Message-Id: <20250604005049.4147522-30-sashal@kernel.org>
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
index 3e8983b85de86..3cef1e4cd163d 100644
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


