Return-Path: <linux-wireless+bounces-22033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D7A9BE2D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAA3B641D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834F22A4F3;
	Fri, 25 Apr 2025 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="h66zxItY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111610957;
	Fri, 25 Apr 2025 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560345; cv=pass; b=tEQSHBvW4tbiDOqRrS8FLwa7+L4C9t3lDunmnYpRaYglvmm//+yV9isIk1Ws5K2BQiB3OPlRiQpNyKhc1x7z/pslpi7AnIsFFOtSdVhcEGYtRnj/AIDEWx0TFY16PWKgF59P5FhJw2d/MxDqtC1GW11Ul7Ly9bUIR4b7hJlwdfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560345; c=relaxed/simple;
	bh=1fA7YbdY6rcv7I4WLuk8CtpvgX9dwi2WMaUu+WiyfpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb2wMHyytIojs/u9PTVpwTJOUimdTitIFCv0BcyXQWok1DHTpGc35/gwQq7sH0seXQyEZII3ApuXglcd12QICBOf/cCEiNuVPAlk6pv3FgXeRQxxrce9bf8Q/Ml9LaUSa8HcY5J5fFSJ8g0r+HwJ4/UomScxArNjejqNbFag+7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=h66zxItY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745560321; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KTXucKr5RR5xKXlq5M9P1wpXubg0IMsyCKYkbc0rfeizZxRx7+ZM6YM1Y3rTFVVH61Pzs6TjAw8if4p5nnj6Idafu3Rej+A3DGMIFruYjKhjr4AIszaM4opYEhwZ5/9I4Ai3M6erPoYR6qDU56WfkwsrH8rc2bfnjzKPXVQ57DI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745560321; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o3l6CrpNH86FpEPGZLgURyPz2oQxBJvhawZgSLwDJCc=; 
	b=jf3V+CtLYmdqYnRaCNtQLVvtEBZnB7SWOLEELf/Xj4sZ/7foKnoCukMIQV4CP6if+a3u1K8Z0KN4khA7RqPO2XqsxOWGFCM/QmW73e89Lspq/rsLc1cHWc1xMCxDXcaQ8Y312DyJglhqZjJwf6TsSn5M8ozJXBQTdFFZqpX3YI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745560321;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=o3l6CrpNH86FpEPGZLgURyPz2oQxBJvhawZgSLwDJCc=;
	b=h66zxItYgoEDNK8fmWa7AAeR5XBFejpRlw6GzbnP4tO9vffO5W9p6Yu4slTvee4U
	70JGTZYuQVOEfRJm6muNYraiz0CjCiIHMZmuDP+IrmLOxPKXJxIHegFpMPU8BEzE0+X
	vJc1sSOPg96p5oKSyaxg1rnzKs743t8x6nNKrU0w=
Received: by mx.zohomail.com with SMTPS id 1745560318274237.55482610129525;
	Thu, 24 Apr 2025 22:51:58 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: quic_bqiang@quicinc.com,
	jeff.johnson@oss.qualcomm.com,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] wifi: ath11k: Fix MHI target memory reuse logic
Date: Fri, 25 Apr 2025 10:51:40 +0500
Message-ID: <20250425055141.2041712-1-usama.anjum@collabora.com>
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
same skip and success logic as used when dma_alloc_coherent() fails
without freeing the memory area. The following error are being fixed at
resume:

	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22

Those failures aren't because of the bigger chunk allocation failure as
they are skipped. Rather these failures are because of smaller chunk
allocation failures. This patch fixes freeing and allocation of 2 smaller
chunks.

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Update description

Changes since v2:
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


