Return-Path: <linux-wireless+bounces-23618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA4ACD2DD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E63E7A7929
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46C1C2DB2;
	Wed,  4 Jun 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTk7Pv8P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026D2571D8;
	Wed,  4 Jun 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998704; cv=none; b=Vy2nu+iPYHflK49D2UiqNEzOXVNxPbxWYX9tPkZ0ZXtaHN7mJIZ3FiFzmC9odqzRQuyT6QntewfH5ExglDhsaGW6DS4wnuMM3yjmT+Io8EmSnZc2DfVwow2mioxf+IsinGfRfu1PHQ6Bb9uwvQdFqBCxQuUxKNm867ZLy7iTmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998704; c=relaxed/simple;
	bh=3J8L0Q40gmipmisNs5hullFuYFpPyGB12ZhWNN3xADM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OafTNfQA3h8s4Q7whif9jjkV1MUdl66Pb3J4dj+5gCPiu2io932MZeZvb0HVBff2ciS729K9Sxg3ipwg2FDae+RcBDAleHfLJI9XJahPMPlPPwnovHGeI9Q700thwUdx6RrwWQsrzfaaZsE/HBglAmpZhjupigXAeg55tSGWYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTk7Pv8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783A3C4CEED;
	Wed,  4 Jun 2025 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998704;
	bh=3J8L0Q40gmipmisNs5hullFuYFpPyGB12ZhWNN3xADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTk7Pv8PyTw/xID0RJZcWyYTAQ/byh++T2HbXwkJY94oZ1B2sgnhb0RYqHJ1JdD1+
	 0zy++j2LKoKHRd6gW3g6BD6/wPF3IB+3wnKRrubnDCo4Ue3a1H75ay7ot3vbT2qtUR
	 14wIzRWcB6BMG5N/eFFLGsogs9LzqDesiEoi9mub0DY34y9LKvae6Y2SpfCTABcKbc
	 0+Fyz51nDYWCRwSNx2u3YhrwZ5j5wgl43TuThuvbKjrBZuFby0l6UYUESkS/ssgyg8
	 B4L/sLSI4E3HJfXpsPh0QPjYFnB5NccEl+MhqkJcZPVBwncwhq+2kiLyFCfPa0CdlX
	 zWIBNNeYI1LJg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sarika Sharma <quic_sarishar@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 083/108] wifi: ath12k: using msdu end descriptor to check for rx multicast packets
Date: Tue,  3 Jun 2025 20:55:06 -0400
Message-Id: <20250604005531.4178547-83-sashal@kernel.org>
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

From: Sarika Sharma <quic_sarishar@quicinc.com>

[ Upstream commit cb7433cc5cd4d07175dbc41f5a19966e9fae48be ]

Currently, the RX multicast broadcast packet check is performed using
bit 15 from the info6 field of the MPDU start descriptor. This check
can also be done using bit 9 from the info5 field of the MSDU end
descriptor. However, in some scenarios multicast bit is not set when
fetched from MPDU start descriptor.
Therefore, checking the RX multicast broadcast packet from the MSDU
end descriptor is more reliable as it is per MSDU.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250411061523.859387-2-quic_sarishar@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

## Analysis and Recommendation **YES** - This commit should be
backported to stable kernel trees. ### Detailed Analysis: **1. Bug Fix
Nature:** The commit fixes a real bug where multicast/broadcast packet
detection is unreliable when using the MPDU start descriptor
(`RX_MPDU_START_INFO6_MCAST_BCAST` from `info6` field). The commit
message explicitly states "in some scenarios multicast bit is not set
when fetched from MPDU start descriptor." **2. Code Changes Analysis:**
The fix changes two functions in
`drivers/net/wireless/ath/ath12k/hal.c`: -
`ath12k_hw_qcn9274_rx_desc_is_da_mcbc()` -
`ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc()` Both change from
reading bit 15 of `mpdu_start.info6` to reading bit 9 of
`msdu_end.info5`, which is described as "more reliable as it is per
MSDU." **3. Impact Assessment:** - **User Impact**: Multicast/broadcast
packet misclassification can cause serious networking issues including
packet drops, incorrect routing, and potential security vulnerabilities
- **Scope**: Limited to ath12k QCN9274 hardware (a specific WiFi
chipset) - **Risk**: Very low risk - changes only the bit field being
read, using well-defined hardware descriptor fields **4. Backport
Suitability Criteria:** ✅ **Fixes important bug**: Incorrect
multicast/broadcast detection affects real user traffic ✅ **Small and
contained**: Only changes which bit field is read in two functions ✅
**No architectural changes**: Simple hardware register access change ✅
**Minimal regression risk**: Well-defined hardware fields with clear
semantics ✅ **Critical subsystem**: Network packet classification is
fundamental functionality ✅ **Clear side effects**: No complex side
effects beyond fixing the core issue **5. Comparison with Historical
Examples:** This is very similar to "Similar Commit #1" which was marked
"YES" for backporting. Both commits: - Fix incorrect multicast/broadcast
packet detection - Change which hardware descriptor field is used - Are
small, contained fixes - Have minimal regression risk **6. Technical
Justification:** The MSDU end descriptor is indeed more reliable for
per-MSDU information as stated in the commit message. The MPDU start
descriptor contains MPDU-level information which may not accurately
reflect the multicast/broadcast status of individual MSDUs within an
aggregated frame. **7. Testing and Validation:** The commit includes
"Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1"
showing it has been validated on the target hardware. This is a clear,
well-justified bug fix that meets all criteria for stable tree
backporting with minimal risk and clear benefit to users with affected
hardware.

 drivers/net/wireless/ath/ath12k/hal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index cd59ff8e6c7b0..42dd4cab7f258 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -908,8 +908,8 @@ static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-- 
2.39.5


