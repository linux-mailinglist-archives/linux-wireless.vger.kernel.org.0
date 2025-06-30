Return-Path: <linux-wireless+bounces-24656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F0AAED5FD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA291896E04
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D02367C5;
	Mon, 30 Jun 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Qx96BV/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258531E5702;
	Mon, 30 Jun 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269527; cv=pass; b=Oi+8mz1ugBxwWJXoySQX/h1scYXSSu/xU+ZI+/8/IK5zGqkDE/ZEJE7UTnEqs3Uom0KwNEJuRCAieO6sMyHYAbHfZTreQsMIdFn7MY/diyMUKovDBEdSrqmMhJ8wMWovkTHPKX8iSEVpuCnAg09Ew4PyksJ/FzlLwrQVi5t29fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269527; c=relaxed/simple;
	bh=KrfEo5R5wsUbAuywkdIpBt1wyYoKkMp0zm0xhGVoBug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWaUjYxC4fazo5FI+Y4zVBnevFOpRoYCUG9mwGcPkw/3RolmZFrXdRM0LU5F2pd5Xmh+l/aYHtYKMpOAfPMQeuAooPzpa98dbEs51hObTtB8UpSd0OALyHzWzMYXvQucYZGm4zX9WvoLg0NRxZy55CeVGx1QQauSrIscdIODjEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Qx96BV/N; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751269467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WZBicWu+g/CGVxd9oWYUI4EXuo2BCGTBGvRxp6u/r9GRz+XCYSrSurj4C2xObAaRUlYrlkIzyMQr6V7eXxHO+Q6E+FpYL1czUzY44QV2Pt9lI4C0+efWBiV8VdS/n5qltfdXawQXmE39EJj3DiG/w4ffwkJGWzAAlmtNsDdG+fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751269467; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r2uS9vOKRUM85SaAedsnSD1TGZ3WjqGyuAFF0JxLZEw=; 
	b=YfHszdPEWwssW8k6BZPEKsOMSv1Tux/u9JSMnGbcaxHb+/2RXrVige8eYNsQPfFVAHcNqCKm3U5eGAPHtZa6ELvcOcV4uYdNxt7CYUbtAhQaarE4ASjVxvutL0ZPE/14RpwiYiAEPVlNT1+7+MGtoInVNajmWAUTxKba1QAv2WA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751269467;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=r2uS9vOKRUM85SaAedsnSD1TGZ3WjqGyuAFF0JxLZEw=;
	b=Qx96BV/NLGus1+vd1zCEDjA3TBY4i5kRMbkKz3F9WtxCHGo+nzi9AzZzW4DNCwqY
	9CH1+Yh+3+KA7LSRhgxt4KrclArCl/+R+xLe31eBfaTQ7tQ7g8JXAux77qHoqIirkKl
	lddWwKGJRLZnIyJro3pMPSqAFw2T2LPOjy4Qk6f0=
Received: by mx.zohomail.com with SMTPS id 1751269466259740.3275140294377;
	Mon, 30 Jun 2025 00:44:26 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Cc: kernel@collabora.com
Subject: [PATCH 1/3] bus: mhi: host: keep bhi buffer through suspend cycle
Date: Mon, 30 Jun 2025 12:43:28 +0500
Message-Id: <20250630074330.253867-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630074330.253867-1-usama.anjum@collabora.com>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When there is memory pressure, at resume time dma_alloc_coherent()
returns error which in turn fails the loading of firmware and hence
the driver crashes:

kernel: kworker/u33:5: page allocation failure: order:7,
mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
kernel: CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted
6.11.11-valve17-1-neptune-611-g027868a0ac03 #1
3843143b92e9da0fa2d3d5f21f51beaed15c7d59
kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
kernel: Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x4e/0x70
kernel:  warn_alloc+0x164/0x190
kernel:  ? srso_return_thunk+0x5/0x5f
kernel:  ? __alloc_pages_direct_compact+0xaf/0x360
kernel:  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
kernel:  __alloc_pages_noprof+0x321/0x350
kernel:  __dma_direct_alloc_pages.isra.0+0x14a/0x290
kernel:  dma_direct_alloc+0x70/0x270
kernel:  mhi_fw_load_handler+0x126/0x340 [mhi
a96cb91daba500cc77f86bad60c1f332dc3babdf]
kernel:  mhi_pm_st_worker+0x5e8/0xac0 [mhi
a96cb91daba500cc77f86bad60c1f332dc3babdf]
kernel:  ? srso_return_thunk+0x5/0x5f
kernel:  process_one_work+0x17e/0x330
kernel:  worker_thread+0x2ce/0x3f0
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0xd2/0x100
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x34/0x50
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1a/0x30
kernel:  </TASK>
kernel: Mem-Info:
kernel: active_anon:513809 inactive_anon:152 isolated_anon:0
    active_file:359315 inactive_file:2487001 isolated_file:0
    unevictable:637 dirty:19 writeback:0
    slab_reclaimable:160391 slab_unreclaimable:39729
    mapped:175836 shmem:51039 pagetables:4415
    sec_pagetables:0 bounce:0
    kernel_misc_reclaimable:0
    free:125666 free_pcp:0 free_cma:0

In above example, if we sum all the consumed memory, it comes out
to be 15.5GB and free memory is ~ 500MB from a total of 16GB RAM.
Even though memory is present. But all of the dma memory has been
exhausted or fragmented.

Fix it by allocating it only once and then reuse the same allocated
memory. As we'll allocate this memory only once, this memory will stay
allocated.

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Reported here:
https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com

Still a lot of more fixes are required. Hence, I'm not adding closes tag.
---
 drivers/bus/mhi/host/boot.c     | 19 ++++++++++---------
 drivers/bus/mhi/host/init.c     |  5 +++++
 drivers/bus/mhi/host/internal.h |  2 ++
 include/linux/mhi.h             |  1 +
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index b3a85aa3c4768..11bb8c12ac597 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -302,8 +302,8 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
 	return -EIO;
 }
 
-static void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
-				struct image_info *image_info)
+void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info)
 {
 	struct mhi_buf *mhi_buf = image_info->mhi_buf;
 
@@ -455,18 +455,19 @@ static enum mhi_fw_load_type mhi_fw_load_type_get(const struct mhi_controller *m
 
 static int mhi_load_image_bhi(struct mhi_controller *mhi_cntrl, const u8 *fw_data, size_t size)
 {
-	struct image_info *image;
+	struct image_info *image = mhi_cntrl->bhi_image;
 	int ret;
 
-	ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
-	if (ret)
-		return ret;
+	if (!image) {
+		ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
+		if (ret)
+			return ret;
 
-	/* Load the firmware into BHI vec table */
-	memcpy(image->mhi_buf->buf, fw_data, size);
+		/* Load the firmware into BHI vec table */
+		memcpy(image->mhi_buf->buf, fw_data, size);
+	}
 
 	ret = mhi_fw_load_bhi(mhi_cntrl, &image->mhi_buf[image->entries - 1]);
-	mhi_free_bhi_buffer(mhi_cntrl, image);
 
 	return ret;
 }
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 6e06e4efec765..2e0f18c939e68 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1228,6 +1228,11 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 		mhi_cntrl->rddm_image = NULL;
 	}
 
+	if (mhi_cntrl->bhi_image) {
+		mhi_free_bhi_buffer(mhi_cntrl, mhi_cntrl->bhi_image);
+		mhi_cntrl->bhi_image = NULL;
+	}
+
 	mhi_deinit_dev_ctxt(mhi_cntrl);
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 1054e67bb450d..60b0699323375 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -324,6 +324,8 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 			 struct image_info **image_info, size_t alloc_size);
 void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
 			 struct image_info *image_info);
+void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info);
 
 /* Power management APIs */
 enum mhi_pm_state __must_check mhi_tryset_pm_state(
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 4c567907933a5..593012f779d97 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -391,6 +391,7 @@ struct mhi_controller {
 	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
+	struct image_info *bhi_image;
 	struct mhi_chan *mhi_chan;
 	struct list_head lpm_chans;
 	int *irq;
-- 
2.39.5


