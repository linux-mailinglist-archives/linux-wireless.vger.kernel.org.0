Return-Path: <linux-wireless+bounces-21389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F80A8472B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A53E7A50B2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78928A40B;
	Thu, 10 Apr 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="JC/nCX8H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4F1E22E9;
	Thu, 10 Apr 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297131; cv=pass; b=GGz9weLqA71ZTzJdxoIaYAfoAIBm0SXU2GFxV8uH4bSIxAuCCs77ii5YQcsKcS2g66r5pDi/16PaPQvFejA5VSpHO6ioG8K3Uz8cpdvTVwocBXPp16t580jjBlLY12GgxCfTjHmKG/pRrGa7yo91d3T5I+YTOTAellqBl3tOHq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297131; c=relaxed/simple;
	bh=sQdKcyOJjyFXyb7DMKGnoZRedKZ89xXboX5hfzQUXL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQiADn4xezjj/djsF87A2kZdfWpURg9vYlZ17pUVLZcbGIjoikAp+dWBC163ly3okyV+AYdjqjS+4lfD0Slb6mSV+gOJX4kNr8BG84wpf2+YjGdEBzeEqifUkaL3J0j0cXZSH3v55zq6k/p5Pupc1Jiegfjt6tDEnjaOOcrSKWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=JC/nCX8H; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744297097; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iOCahUm7PU80m8l7K8or5tfmRg47wqQ2hU7AlGOQ8GCiM0NNiPZaJCz9YYAlV2ntkCFXObAs0i7/9NhJVrz23pFRJYiCq+g/GV6AnqrDUcCj7MDTdeLUuir7ZbWrZD0NFpIfznEwRhGS6Bzf+A2tEEY5shmiukuTEusG2XNrIvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744297097; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j6KUxqpvhXLce/PJDd2pNOS0Y+D23pvQbY/jB6EG2Pg=; 
	b=GbeJIWlbmo9QK5pe3QMweg6xd+PxcAwiQ6Cfe6MJdH+j1Tb6F6vPQcUcp/ZZ0Q9c8xpNdDyHArOepDHCOvxYJP9vPJItVJTij4HK7utRHpfgHHwP8iWzO6SSGckEeG0+QZI4WJBAYGPaGplKcMuvs32Ulgr4bApiavoY3eMA/Ss=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744297097;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j6KUxqpvhXLce/PJDd2pNOS0Y+D23pvQbY/jB6EG2Pg=;
	b=JC/nCX8H1RxMZU+s68CVcHaKYh85XcvGjibq0WwguVW2RutQRDwCPXLmPQ9lXNdb
	bnA9tGkYBeu/+ynGhkPBk0W4ThqL2bFTfhnikD9ZVIBOaoEMSqVisDw6gSGuxHeWTEc
	lH35rnIKB5Yad/MR2IC4alQv2jbb7K/uK74MhoaY=
Received: by mx.zohomail.com with SMTPS id 1744297096527931.6945802394524;
	Thu, 10 Apr 2025 07:58:16 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH v2] bus: mhi: host: don't free bhie tables during suspend/hibernation
Date: Thu, 10 Apr 2025 19:56:54 +0500
Message-ID: <20250410145704.207969-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix dma_direct_alloc() failure at resume time during bhie_table
allocation. There is a crash report where at resume time, the memory
from the dma doesn't get allocated and MHI fails to re-initialize.
There may be fragmentation of some kind which fails the allocation
call.

To fix it, don't free the memory at power down during suspend /
hibernation. Instead, use the same allocated memory again after every
resume / hibernation. This patch has been tested with resume and
hibernation both.

The rddm is of constant size for a given hardware. While the fbc_image
size depends on the firmware. If the firmware changes, we'll free and
allocate new memory for it.

Here are the crash logs:

[ 3029.338587] mhi mhi0: Requested to power ON
[ 3029.338621] mhi mhi0: Power on setup success
[ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
[ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
[ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
[ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
[ 3029.668717] Call Trace:
[ 3029.668722]  <TASK>
[ 3029.668728]  dump_stack_lvl+0x4e/0x70
[ 3029.668738]  warn_alloc+0x164/0x190
[ 3029.668747]  ? srso_return_thunk+0x5/0x5f
[ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
[ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
[ 3029.668774]  __alloc_pages_noprof+0x321/0x350
[ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
[ 3029.668790]  dma_direct_alloc+0x70/0x270
[ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
[ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
[ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
[ 3029.668844]  ? srso_return_thunk+0x5/0x5f
[ 3029.668853]  process_one_work+0x17e/0x330
[ 3029.668861]  worker_thread+0x2ce/0x3f0
[ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
[ 3029.668873]  kthread+0xd2/0x100
[ 3029.668879]  ? __pfx_kthread+0x10/0x10
[ 3029.668885]  ret_from_fork+0x34/0x50
[ 3029.668892]  ? __pfx_kthread+0x10/0x10
[ 3029.668898]  ret_from_fork_asm+0x1a/0x30
[ 3029.668910]  </TASK>

Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes sice v1:
- Don't free bhie tables during suspend/hibernation only
- Handle fbc_image changed size correctly
- Remove fbc_image getting set to NULL in *free_bhie_table()
---
 drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
 drivers/bus/mhi/host/init.c           | 13 ++++++++++---
 drivers/net/wireless/ath/ath11k/mhi.c |  9 +++++----
 include/linux/mhi.h                   |  7 +++++++
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 9dcc7184817d5..0df26100c8f9c 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -487,10 +487,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	 * device transitioning into MHI READY state
 	 */
 	if (mhi_cntrl->fbc_download) {
-		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
-		if (ret) {
-			release_firmware(firmware);
-			goto error_fw_load;
+		if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
+			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+			mhi_cntrl->fbc_image = NULL;
+		}
+		if (!mhi_cntrl->fbc_image) {
+			ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
+			if (ret) {
+				release_firmware(firmware);
+				goto error_fw_load;
+			}
+			mhi_cntrl->prev_fw_sz = fw_sz;
 		}
 
 		/* Load the firmware into BHIE vec table */
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a9b1f8beee7bc..09b946b86ac46 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1173,8 +1173,9 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 		/*
 		 * Allocate RDDM table for debugging purpose if specified
 		 */
-		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
-				     mhi_cntrl->rddm_size);
+		if (!mhi_cntrl->rddm_image)
+			mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+					     mhi_cntrl->rddm_size);
 		if (mhi_cntrl->rddm_image) {
 			ret = mhi_rddm_prepare(mhi_cntrl,
 					       mhi_cntrl->rddm_image);
@@ -1212,12 +1213,18 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 		mhi_cntrl->rddm_image = NULL;
 	}
 
+	mhi_partial_unprepare_after_power_down(mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
+
+void mhi_partial_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
+{
 	mhi_cntrl->bhi = NULL;
 	mhi_cntrl->bhie = NULL;
 
 	mhi_deinit_dev_ctxt(mhi_cntrl);
 }
-EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
+EXPORT_SYMBOL_GPL(mhi_partial_unprepare_after_power_down);
 
 static void mhi_release_device(struct device *dev)
 {
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31..f77cec79b5b80 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -460,12 +460,13 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
 	 * workaround, otherwise ath11k_core_resume() will timeout
 	 * during resume.
 	 */
-	if (is_suspend)
+	if (is_suspend) {
 		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
-	else
+		mhi_partial_unprepare_after_power_down(ab_pci->mhi_ctrl);
+	} else {
 		mhi_power_down(ab_pci->mhi_ctrl, true);
-
-	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
+		mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
+	}
 }
 
 int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 059dc94d20bb6..65a47c712b3a0 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -382,6 +382,7 @@ struct mhi_controller {
 	const char *fw_image;
 	const u8 *fw_data;
 	size_t fw_sz;
+	size_t prev_fw_sz;
 	const char *edl_image;
 	size_t rddm_size;
 	size_t sbl_size;
@@ -662,6 +663,12 @@ void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl, bool graceful);
  */
 void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
 
+/**
+ * mhi_partial_unprepare_after_power_down - Free any allocated memory after power down partially
+ * @mhi_cntrl: MHI controller
+ */
+void mhi_partial_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
+
 /**
  * mhi_pm_suspend - Move MHI into a suspended state
  * @mhi_cntrl: MHI controller
-- 
2.43.0


