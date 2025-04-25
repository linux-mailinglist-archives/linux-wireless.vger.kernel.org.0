Return-Path: <linux-wireless+bounces-22065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70341A9C6A5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDC91BC11D9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503823D2AA;
	Fri, 25 Apr 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="OKrrAkNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DC23BCEF;
	Fri, 25 Apr 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579098; cv=pass; b=NP6w9AVTZRLM4dt3HIU2KJbzcnP1X2lQwwJMwO3P+4BXxvWzWu6T8Kcsm0wPO4+pOto+owRjwg7ShbkBLQBtClI0oTrXy/XMBthj+pt2cBB2s8k5MskyzSohrIA3xhLsWkuvO231Kmg/G0pLvUhPloMW6gTpJDX3nnMIKdf22Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579098; c=relaxed/simple;
	bh=R5RaXLvDCvMqzJ58JAifIRcl8VCg0JtJ+rpcb5X3YP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vy4xS3iVtxWqZl1hPT3Y5CivsGCFxXYfe9nSPf7kb8/mooZsrSUkXSbcppQHLYwJRmoNhW8888yHz8H1qaLnUGoNFZY6ZwI23zKtLFnKnwHBAOg7ul1QkyJgGf+/NIbwDrlGQH9/VU0qcaT9ijlgP3l2c3LVK9lsgOTiFPeH294=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=OKrrAkNo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745579078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SDxugJswpvqGNeOltQ62andLbcYyYkk6tBkmbAEuHalmZghxA/ccO8uScVLIN/CcOWdhpxJ6q4b88nM4pUcpy9/305gGpVzCXBlZ6R0eBOUk5fp9cpesPVB3RVDKvw7F5Rmm8DgR3TNJdEZnCExltqlNQQK5+vnCt/tiaCgEeqg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745579078; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N1uwz7nrK036EroOS9mgvLkD2zXocDQ8jq3fui4KRxs=; 
	b=GdlPAqGHZE3Z8m6A9QEEzINpvp5anyFLblBfWIEev7GMXHGcDG8F8fBu8XkiNMS1nBKFJHd+5ASSXWLqnq47NWmUBXVNzUmrkezF5KtL3jLzh/SA4FcYYlm83LwruuIFoCSmplaw/yOFts5kzhwd876ehXk+vLD3dLDGvKQwZrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745579078;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=N1uwz7nrK036EroOS9mgvLkD2zXocDQ8jq3fui4KRxs=;
	b=OKrrAkNo96A8Okjd6LiZSUnjYvH+sOi9QWH4sifoa0/gNY6TSVPrHuAs1jS50c1Y
	v1AgRhREXsMvdJEBVliA8kNKiWbujXLpNtJy6HAEXAxpjdeJ6yqKQumlpouMxjEI6br
	KemfPyoazD+I3GlijPn2gxE7ZqBgaYPLXhKtxeQI=
Received: by mx.zohomail.com with SMTPS id 1745579075334246.23503787793652;
	Fri, 25 Apr 2025 04:04:35 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: quic_bqiang@quicinc.com,
	jeff.johnson@oss.qualcomm.com,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] wifi: ath11k: Fix MHI target memory reuse logic
Date: Fri, 25 Apr 2025 16:04:23 +0500
Message-ID: <20250425110424.2530460-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
---
Changes since v1:
- Update description

Changes since v2:
- Update description

Changes since v3:
- Update description
---
 drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 47b9d4126d3a9..2782f4723e413 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1993,6 +1993,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
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
2.43.0


