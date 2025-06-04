Return-Path: <linux-wireless+bounces-23646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A841ACD386
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AFB3A3E26
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA81265CAA;
	Wed,  4 Jun 2025 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTtE54gM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DB203710;
	Wed,  4 Jun 2025 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998969; cv=none; b=iN7qlSVQ2lt6N+6j/+Jlmo/MUwZdZCgz0xo4Gr1JcPgUrFaXgMF0Yy3Yhdc+WahEt2k0OJxDH6DK796LHtxtpa0TJUiQxQK+8KF3J8BseipxpnoxP5aPKZp3cMi+KfoKv6uQZyUCpRMPWOfqK53mhsVdoPQLuCJ+hWYfj8lnVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998969; c=relaxed/simple;
	bh=vFcEO3X8WOL8kki6aELZdr82vjfJ4FWx+ZhvFlVM8nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWuNBVUjQY5hWYAb2HdSI5dpQp6FFbag2lcKHlKjnZBaM9HzvJ9IIsjVo7jH5h9WkWSgsCXc/SHVefdnPIvvUqcA6t/yY5ghSPW8CyjmkR+mZLNEViaNB41PMy02+KaGGVPCkUf6HH6c/g/miSHnB0sVhiHaOGyR5uvtAL5eCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTtE54gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66FCC4CEF1;
	Wed,  4 Jun 2025 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998968;
	bh=vFcEO3X8WOL8kki6aELZdr82vjfJ4FWx+ZhvFlVM8nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTtE54gMGtoC1SRCPPWpIpfVhkIdMDT9h+12WoPE5WYgXN2Skc+hbHrcRjk28hEHX
	 S4MI2t7IjwSNYC6RuvDNKFvdUB7oXuMfAwKGeWG+WgCgvoHc4vTnP17eemDbj2JqhB
	 W6fqVfycSMR6jJ/pZbCUSj6JqheDHZGviadNjRKiatD7qLSTfKB8qEwEOLDYWd9XX9
	 JWA7lHbJwr9jW1VmfhsxgEE7p9GurDaZsWpSh+CwvdxSAq1DZoYX3tF1m2PMlVQiY5
	 vkr3jI6SvBNosdXWLs3x0YcztgiNSWsn3AS4t+fOrFzvkxgfpcpEWLCxRAkYSI5aSh
	 RMcVF8BmkkCUg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 18/62] wifi: ath11k: Fix QMI memory reuse logic
Date: Tue,  3 Jun 2025 21:01:29 -0400
Message-Id: <20250604010213.3462-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit cd2e7bae92bd7e65063ab8d04721d2b711ba4cbe ]

Firmware requests 2 segments at first. The first segment is of 6799360
whose allocation fails due to dma remapping not available. The success
is returned to firmware. Then firmware asks for 22 smaller segments
instead of 2 big ones. Those get allocated successfully. At suspend/
hibernation time, these segments aren't freed as they will be reused
by firmware after resuming.

After resuming, the firmware asks for the 2 segments again with the
first segment of 6799360 size. Since chunk->vaddr is not NULL, the
type and size are compared with the previous type and size to know if
it can be reused or not. Unfortunately, it is detected that it cannot
be reused and this first smaller segment is freed. Then we continue to
allocate 6799360 size memory which fails and ath11k_qmi_free_target_mem_chunk()
is called which frees the second smaller segment as well. Later success
is returned to firmware which asks for 22 smaller segments again. But
as we had freed 2 segments already, we'll allocate the first 2 new
smaller segments again and reuse the remaining 20. Hence 20 small
segments are being reused instead of 22.

Add skip logic when vaddr is set, but size/type don't match. Use the
same skip and success logic as used when dma_alloc_coherent() fails.
By skipping, the possibility of resume failure due to kernel failing to
allocate memory for QMI can be avoided.

	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250428080242.466901-1-usama.anjum@collabora.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of this commit and the Linux kernel ath11k QMI
code, here's my assessment: **YES** This commit should be backported to
stable kernel trees. Here's my extensive analysis: ## Critical Bug Fix
for Resume/Hibernation Failures ### Problem Description The commit fixes
a critical logic flaw in QMI memory reuse during firmware reload
scenarios, particularly affecting suspend/resume and hibernation cycles.
The bug causes resume failures with errors like: ``` kernel: ath11k_pci
0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22 ```
### Code Analysis of the Fix **The core issue (lines 1996-2003 in the
diff):** ```c + if (ab->qmi.mem_seg_count <=
ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) { + ath11k_dbg(ab, ATH11K_DBG_QMI, +
"size/type mismatch (current %d %u) (prev %d %u), try later with small
size\n", + chunk->size, chunk->type, + chunk->prev_size,
chunk->prev_type); + ab->qmi.target_mem_delayed = true; + return 0; + }
``` **Before the fix:** When firmware requests different memory segment
sizes/types than previously allocated (common during resume), the driver
would: 1. Free the existing memory chunks with `dma_free_coherent()` 2.
Try to allocate the new larger size (often 6+ MB) 3. Fail due to memory
fragmentation after hibernation 4. Free remaining chunks, causing loss
of successfully allocated smaller segments **After the fix:** When
size/type mismatch occurs and segment count ≤ 5
(`ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT`), the driver: 1. Sets
`target_mem_delayed = true` 2. Returns success immediately (skipping
allocation) 3. Allows firmware to fall back to requesting smaller chunks
4. Preserves existing memory allocations for reuse ### Why This
Qualifies for Stable Backporting 1. **Fixes Important User-Affecting
Bug**: Resume/hibernation failures directly impact user experience and
system reliability 2. **Minimal and Contained Change**: The fix adds
only 8 lines of code with a simple conditional check using existing
mechanisms (`target_mem_delayed` flag and
`ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT` constant) 3. **Low Regression
Risk**: - Uses existing, well-tested delayed allocation mechanism - Only
affects the specific error path for size/type mismatches - Maintains
backward compatibility with all existing behavior 4. **Critical
Subsystem**: WiFi connectivity is essential functionality, and resume
failures can render systems unusable 5. **Clear Root Cause**: The commit
message and code changes clearly identify and fix a specific logic error
in memory management 6. **Follows Stable Rules**: - Important bugfix
(resume failures) - Small and self-contained - No architectural changes
- Confined to ath11k subsystem ### Validation Against Similar Commits
Looking at the historical examples: - **Similar Commit #1 (YES)**: Also
fixes QMI memory allocation warnings/failures, uses similar logic with
`prev_size` fields - **Similar Commit #4 (YES)**: Implements the
`target_mem_delayed` mechanism this fix builds upon This commit follows
the same pattern as previously backported QMI memory fixes, addressing a
critical failure scenario with minimal risk. ### Technical Validation
The fix leverages the existing delayed allocation negotiation mechanism
between driver and firmware, which has been proven stable since its
introduction. By using `target_mem_delayed = true`, it allows firmware
to adaptively request smaller, more allocation-friendly memory segments
rather than failing outright. The `ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT =
5` threshold ensures this optimization only applies to initial firmware
memory requests (≤5 segments), not to scenarios where firmware has
already adapted to smaller chunks (>5 segments). **Conclusion**: This is
a well-contained, low-risk fix for a critical user-facing issue that
should definitely be backported to stable kernels.

 drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index fa46e645009cf..91e31f30d2c80 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1989,6 +1989,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 			    chunk->prev_size == chunk->size)
 				continue;
 
+			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
+					    chunk->size, chunk->type,
+					    chunk->prev_size, chunk->prev_type);
+				ab->qmi.target_mem_delayed = true;
+				return 0;
+			}
+
 			/* cannot reuse the existing chunk */
 			dma_free_coherent(ab->dev, chunk->prev_size,
 					  chunk->vaddr, chunk->paddr);
-- 
2.39.5


