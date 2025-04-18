Return-Path: <linux-wireless+bounces-21718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1558A936E3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0103B177925
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EF26FDA0;
	Fri, 18 Apr 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="KiJ7sxTm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D05204C0D;
	Fri, 18 Apr 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978285; cv=pass; b=T9Qgs3M3l/dG+x1nDbCQAExlaj4g0rjQx7p3THHnfEE4ZEJNsv35A9sO8/qs2g/yuu7JC+jZZumLycjK8yurq2CkD9UFo9ddgA9pZcZI/0nHhply1XmdIj9JG/k53Kqn+uGqJPdM6O+Zc6nSofHanKl0qcQvEhtL312putB+tRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978285; c=relaxed/simple;
	bh=jeZr8tSqEQhaCa7OWyCs8cOm8kEEIRjP8eRhzzBylHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZ5x0j22JxvNTeAGTT/JmjFxfGYwwO1t16lknKiZhm1obqquSmJuolHdfCw/8rBraENASlf8wXe4/v5eBLZFRMsHaSfHZvT/y0KRODM00kZPXcTl+V+eg5JVac3AGAygcPm+/M5VyAArv13BZ+eI85kNV9saZSL9dLi96PjVlsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=KiJ7sxTm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744978269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D/bp8S6xvCdEYWsJT4M6DjgpyuN88OYRIywjuq0VmLRV8Dticx28hzFVNYOgtOlCo9bEGko8pbbWKpNQ9hyPG4NGwrs5nfwUa1suwkYIgFA/4EZY7usBHmEye4hrH63WxVr/pAD3vIgZiWrUVZ+WcUG9mo/RwPvK1kPV7LKM90Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744978269; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mi8vXc8DxcW9FWP0G/l6AjzB+2wOqQ640y7om4KkGvQ=; 
	b=a1N+i9Pmm2ZHv7A3aQriVneS/gdFdLasPz6DeXHdMyEgavmEBz+2Tp6ShYN7sCJO0ekJXqAl6O4d8wVSn0xn8QqAxic1CLHyuWcalh9/ccJ4kwFwgbMIML1PrsY8uu+pm5cp/xBjtxPpIiERRA76k7XPvW+OZJvBbCdOdHuKIYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744978269;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Mi8vXc8DxcW9FWP0G/l6AjzB+2wOqQ640y7om4KkGvQ=;
	b=KiJ7sxTm7oyxP6XYj8P7zPbb5bGgJLXjsfj3441usy1yYI9bb1jLxEgZFHRkVoUB
	VBfjTtKDBsnJAPOnn2IR6PGVo1FvA7Re6KPY5kVy5AjuggTVt37KeAyHZQyIww+CKbN
	kTErEFxqZX9su2NvmDeyQ15pumgZawvTETr+58Rw=
Received: by mx.zohomail.com with SMTPS id 174497826635671.96429046428307;
	Fri, 18 Apr 2025 05:11:06 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Anilkumar Kolli <quic_akolli@quicinc.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: Fix memory reuse logic
Date: Fri, 18 Apr 2025 17:09:51 +0500
Message-ID: <20250418120951.94021-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Firmware requests 2 segments at first. 1st segment is of 6799360 whose
allocation fails and we return success to firmware. Then firmware asks
for 22 smaller segments. Those get allocated. At suspend/hibernation
time, these segments aren't freed as they are reused by firmware.

After resume the firmware asks for 2 segments again with first segment
of 6799360 and with same vaddr of the first smaller segment which we had
allocated. Hence vaddr isn't NULL and we compare the type and size if it
can be reused. Unfornately, we detect that we cannot reuse it and this
first smaller segment is freed. Then we continue to allocate 6799360 size
memory from dma which fails and we call ath11k_qmi_free_target_mem_chunk()
which frees the second smaller segment as well. Later success is returned
to firmware which asks for 22 smaller segments again. But as we had freed
2 segments already, we'll allocate the first 2 new segments again and
reuse the remaining 20.

This patch is correctiong the skip logic when vaddr is set, but size/type
don't match. In this case, we should use the same skip and success logic
as used when dma_alloc_coherent fails without freeing the memory area.

We had got reports that memory allocation in this function failed at
resume which made us debug why the reuse logic is wrong. Those failures
weren't because of the bigger chunk allocation failure as they are
skipped. Rather these failures were because of smaller chunk allocation
failures. This patch fixes freeing and allocation of 2 smaller chunks.

Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 47b9d4126d3a9..3c26f4dcf5d29 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 		 */
 		if (chunk->vaddr) {
 			if (chunk->prev_type == chunk->type &&
-			    chunk->prev_size == chunk->size)
+			    chunk->prev_size == chunk->size) {
 				continue;
+			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
+					    chunk->size, chunk->type,
+					    chunk->prev_size, chunk->prev_type);
+				ab->qmi.target_mem_delayed = true;
+				return 0;
+			}
 
 			/* cannot reuse the existing chunk */
 			dma_free_coherent(ab->dev, chunk->prev_size,
-- 
2.43.0


