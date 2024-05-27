Return-Path: <linux-wireless+bounces-8096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 075558D030C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1765B2FA97
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E3816C864;
	Mon, 27 May 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxxBzwe4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C516C85E;
	Mon, 27 May 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819162; cv=none; b=D5K2kRN3i6tOZMZDYO2IqQRIAKXA+wA28yBrfWU6V0uas/zqxdrrpFztqa0JdQxWg79wwTd/Nd/1LAmD0tOdGrELOYZtQJVv9wgkVES2nW3OIlzl7ocP04b9QPaVnqTXJF1xvvlt0VEQHObX3YoGv/PNBiht6GVpx22nCft7ALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819162; c=relaxed/simple;
	bh=UxCmQlH0tjLybE8f7wAdmWzcYOVcm9y1eLC9puEBDxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUv1ek29i/ReL69k/BlFBTJPLcfI5KWY7gayVec1wEXIL2SoYWZQodA0M3jm4y/Ky4qmT9fvH8pfLknMyQtF3An8xumOiOPprAsSp95gJWSdwkMZIqgRe0xempyq3GJES85Kl+hQ/XoOhVL15MxjTeOQSdqZ3grbZ3BByi+bS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxxBzwe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF2C2BBFC;
	Mon, 27 May 2024 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819162;
	bh=UxCmQlH0tjLybE8f7wAdmWzcYOVcm9y1eLC9puEBDxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxxBzwe4sLYX2Z4oNwGJA7zGMA1A8gYKtSvVdrbQSOyF7K9IG5XCV+2XuG4sbLLL/
	 FUEORnavkxtyRmAUhjBU8kmH717klFAc6v65NMaUR9+SlHY4tdb+H160+WXuZxpWwR
	 4yBtc2YGfBB+spOKs+tJvTzaLhxQdFfxwpFaFqAZYRig2OikH/Fn1LSVRyJHmNVEx3
	 zivdH1dtHuc42BkyEvyxvcI9p5QdLfknTFJx0W8Kf1FTcuHnvSl6TYyap02BBfB6ub
	 +0UO1xKFQRe1uAZJFNZCR/16RCP1KKMxTerTSpsvfA6AraI0tcvv8ywAVU00nOfomZ
	 TzLiKVbQNe+9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 15/35] wifi: ath12k: fix kernel crash during resume
Date: Mon, 27 May 2024 10:11:20 -0400
Message-ID: <20240527141214.3844331-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 303c017821d88ebad887814114d4e5966d320b28 ]

Currently during resume, QMI target memory is not properly handled, resulting
in kernel crash in case DMA remap is not supported:

BUG: Bad page state in process kworker/u16:54  pfn:36e80
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e80
page dumped because: nonzero _refcount
Call Trace:
 bad_page
 free_page_is_bad_report
 __free_pages_ok
 __free_pages
 dma_direct_free
 dma_free_attrs
 ath12k_qmi_free_target_mem_chunk
 ath12k_qmi_msg_mem_request_cb

The reason is:
Once ath12k module is loaded, firmware sends memory request to host. In case
DMA remap not supported, ath12k refuses the first request due to failure in
allocating with large segment size:

ath12k_pci 0000:04:00.0: qmi firmware request memory request
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 7077888
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 8454144
ath12k_pci 0000:04:00.0: qmi dma allocation failed (7077888 B type 1), will try later with small size
ath12k_pci 0000:04:00.0: qmi delays mem_request 2
ath12k_pci 0000:04:00.0: qmi firmware request memory request

Later firmware comes back with more but small segments and allocation
succeeds:

ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 262144
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 65536
ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288

Now ath12k is working. If suspend is triggered, firmware will be reloaded
during resume. As same as before, firmware requests two large segments at
first. In ath12k_qmi_msg_mem_request_cb() segment count and size are
assigned:

	ab->qmi.mem_seg_count == 2
	ab->qmi.target_mem[0].size == 7077888
	ab->qmi.target_mem[1].size == 8454144

Then allocation failed like before and ath12k_qmi_free_target_mem_chunk()
is called to free all allocated segments. Note the first segment is skipped
because its v.addr is cleared due to allocation failure:

	chunk->v.addr = dma_alloc_coherent()

Also note that this leaks that segment because it has not been freed.

While freeing the second segment, a size of 8454144 is passed to
dma_free_coherent(). However remember that this segment is allocated at
the first time firmware is loaded, before suspend. So its real size is
524288, much smaller than 8454144. As a result kernel found we are freeing
some memory which is in use and thus crashed.

So one possible fix would be to free those segments during suspend. This
works because with them freed, ath12k_qmi_free_target_mem_chunk() does
nothing: all segment addresses are NULL so dma_free_coherent() is not called.

But note that ath11k has similar logic but never hits this issue. Reviewing
code there shows the luck comes from QMI memory reuse logic. So the decision
is to port it to ath12k. Like in ath11k, the crash is avoided by adding
prev_size to target_mem_chunk structure and caching real segment size in it,
then prev_size instead of current size is passed to dma_free_coherent(),
no unexpected memory is freed now.

Also reuse m3 buffer.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240419034034.2842-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c |  1 -
 drivers/net/wireless/ath/ath12k/qmi.c  | 29 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/qmi.h  |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 391b6fb2bd426..bff4598de4035 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1132,7 +1132,6 @@ static void ath12k_core_reset(struct work_struct *work)
 						ATH12K_RECOVER_START_TIMEOUT_HZ);
 
 	ath12k_hif_power_down(ab);
-	ath12k_qmi_free_resource(ab);
 	ath12k_hif_power_up(ab);
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset started\n");
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 92845ffff44ad..4964fd7e4cd72 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2325,8 +2325,9 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
+
 		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].size,
+				  ab->qmi.target_mem[i].prev_size,
 				  ab->qmi.target_mem[i].v.addr,
 				  ab->qmi.target_mem[i].paddr);
 		ab->qmi.target_mem[i].v.addr = NULL;
@@ -2352,6 +2353,20 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case M3_DUMP_REGION_TYPE:
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
+			/* Firmware reloads in recovery/resume.
+			 * In such cases, no need to allocate memory for FW again.
+			 */
+			if (chunk->v.addr) {
+				if (chunk->prev_type == chunk->type &&
+				    chunk->prev_size == chunk->size)
+					goto this_chunk_done;
+
+				/* cannot reuse the existing chunk */
+				dma_free_coherent(ab->dev, chunk->prev_size,
+						  chunk->v.addr, chunk->paddr);
+				chunk->v.addr = NULL;
+			}
+
 			chunk->v.addr = dma_alloc_coherent(ab->dev,
 							   chunk->size,
 							   &chunk->paddr,
@@ -2370,6 +2385,10 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 					    chunk->type, chunk->size);
 				return -ENOMEM;
 			}
+
+			chunk->prev_type = chunk->type;
+			chunk->prev_size = chunk->size;
+this_chunk_done:
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
@@ -2675,10 +2694,6 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	size_t m3_len;
 	int ret;
 
-	if (m3_mem->vaddr)
-		/* m3 firmware buffer is already available in the DMA buffer */
-		return 0;
-
 	if (ab->fw.m3_data && ab->fw.m3_len > 0) {
 		/* firmware-N.bin had a m3 firmware file so use that */
 		m3_data = ab->fw.m3_data;
@@ -2700,6 +2715,9 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		m3_len = fw->size;
 	}
 
+	if (m3_mem->vaddr)
+		goto skip_m3_alloc;
+
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   m3_len, &m3_mem->paddr,
 					   GFP_KERNEL);
@@ -2710,6 +2728,7 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		goto out;
 	}
 
+skip_m3_alloc:
 	memcpy(m3_mem->vaddr, m3_data, m3_len);
 	m3_mem->size = m3_len;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 6ee33c9851c6b..f34263d4bee88 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -96,6 +96,8 @@ struct ath12k_qmi_event_msg {
 struct target_mem_chunk {
 	u32 size;
 	u32 type;
+	u32 prev_size;
+	u32 prev_type;
 	dma_addr_t paddr;
 	union {
 		void __iomem *ioaddr;
-- 
2.43.0


