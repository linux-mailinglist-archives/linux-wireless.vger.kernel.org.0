Return-Path: <linux-wireless+bounces-22195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83605AA0B89
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EFF1B63CA8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D082C374F;
	Tue, 29 Apr 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Al6aHHX6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354624C098;
	Tue, 29 Apr 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929495; cv=pass; b=fAqMwLhtKWrIPVM+Ek+HNE6RsQ95peIvDNuE2rbbNb0bg0vLnrrMxNKSkBwWSM+6WUFaEt2IzbCrzBIFgP8Y0s3pc/DzRKPJnDa4dx+fkQxJxSLWie6K4gmEcWt703xUVMtzA1TQgYDTJCFBCToGjwY8RYfq6RXHgySx3Lk7kA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929495; c=relaxed/simple;
	bh=Pl/8ZRqKjTYpfRjmRIC8F9O1eyoMR8WT/0aot7GmIc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKOjCO7qs9Hhg7zn69by+7TSRZQEYzSNU7gyJwcDAgVCsyB8q1nmvHW2WMwNXdq6tqBhwQm5tPoa0hBZqONGvceKByDkmk0uC8usGO1lpTPtZfNRb0URgF5wsfHgVMT9mfOb9rpVLl/szRJF3Gnw2m/NHUT0ib7zlY0RYv/GR6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Al6aHHX6; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745929453; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PYuHLCecog1qRMXuLCs6DMzTZriApuZa1/0MTnGhCpDeMvznSpJBFYBGBiVsP7yixP2Gcd/sOrRLY2rpCokAEGTSqsZ9ZxNLNgAACnhn6epLv5lfPsCmqU7uTlsUup5F68pMlGFQ2nzvLehVlzNEG9L+zxDyNuapGihTmsaMXzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745929453; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sKJ1pTVCX4dEVX1vrqZiREtxmyVR9vDTmkBb2JrH30s=; 
	b=mfMvA+8gSWP9YYwpptSa0BV+2kbL1f2ioRjnoCssYJ/DavYT5M+X0CmscN2MedYM2diER8RDICVnNPrGPESflQIbZiDhyvdR0RsZbLinmtFo+MVkBJ3BeQrmmYtep+eH6fdZP+vkfZh1cdp8dZB/MuTkC1Uj+xwgJbUZg2H61iQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745929453;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sKJ1pTVCX4dEVX1vrqZiREtxmyVR9vDTmkBb2JrH30s=;
	b=Al6aHHX6V7efoRHenD0J77Vq9s4COpOYOZueLi9j+wA1LPQOTl8/W0Iy28h2lIwD
	REH3shWKufnTwU2NgYOctT53XyfqoQHQpGHx0xAPucFSgil9a2Q8yCmRPTAfxGvGGkT
	d2FvDkXpyCuFec4dZKwIPK1SUKexzul+QFhhYNv4=
Received: by mx.zohomail.com with SMTPS id 1745929450569239.30908580364132;
	Tue, 29 Apr 2025 05:24:10 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Troy Hanson <quic_thanson@quicinc.com>
Cc: kernel@collabora.com,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Subject: [PATCH v3] bus: mhi: host: don't free bhie tables during suspend/hibernation
Date: Tue, 29 Apr 2025 17:23:35 +0500
Message-ID: <20250429122351.108684-1-usama.anjum@collabora.com>
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
There is fragmentation/memory pressure.

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

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Don't free bhie tables during suspend/hibernation only
- Handle fbc_image changed size correctly
- Remove fbc_image getting set to NULL in *free_bhie_table()

Changes since v2:
- Remove the new mhi_partial_unprepare_after_power_down() and instead
  update mhi_power_down_keep_dev() to use
  mhi_power_down_unprepare_keep_dev() as suggested by Mani
- Update all users of this API such as ath12k (previously only ath11k
  was updated)
- Define prev_fw_sz in docs
- Do better alignment of comments

Tested on ath11k.
---
 drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
 drivers/bus/mhi/host/init.c           |  5 +++--
 drivers/bus/mhi/host/pm.c             |  9 +++++++++
 drivers/net/wireless/ath/ath11k/mhi.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/mhi.c |  8 ++++----
 include/linux/mhi.h                   |  2 ++
 6 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index efa3b6dddf4d2..bc8459798bbee 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -584,10 +584,17 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	 * device transitioning into MHI READY state
 	 */
 	if (fw_load_type == MHI_FW_LOAD_FBC) {
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
index 13e7a55f54ff4..a7663ad16bfc6 100644
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
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index e6c3ff62bab1d..b726b000d8a5d 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 }
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
+void mhi_power_down_unprepare_keep_dev(struct mhi_controller *mhi_cntrl)
+{
+	mhi_cntrl->bhi = NULL;
+	mhi_cntrl->bhie = NULL;
+
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+}
+
 void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl,
 			       bool graceful)
 {
 	__mhi_power_down(mhi_cntrl, graceful, false);
+	mhi_power_down_unprepare_keep_dev(mhi_cntrl);
 }
 EXPORT_SYMBOL_GPL(mhi_power_down_keep_dev);
 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31..c5dc776b23643 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -460,12 +460,12 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci, bool is_suspend)
 	 * workaround, otherwise ath11k_core_resume() will timeout
 	 * during resume.
 	 */
-	if (is_suspend)
+	if (is_suspend) {
 		mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
-	else
+	} else {
 		mhi_power_down(ab_pci->mhi_ctrl, true);
-
-	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
+		mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
+	}
 }
 
 int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 08f44baf182a5..cb7f789d873f2 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -635,12 +635,12 @@ void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
 	 * workaround, otherwise ath12k_core_resume() will timeout
 	 * during resume.
 	 */
-	if (is_suspend)
+	if (is_suspend) {
 		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF_KEEP_DEV);
-	else
+	} else {
 		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
-
-	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
+		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
+	}
 }
 
 void ath12k_mhi_suspend(struct ath12k_pci *ab_pci)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index dd372b0123a6d..6fd218a877855 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -306,6 +306,7 @@ struct mhi_controller_config {
  *           if fw_image is NULL and fbc_download is true (optional)
  * @fw_sz: Firmware image data size for normal booting, used only if fw_image
  *         is NULL and fbc_download is true (optional)
+ * @prev_fw_sz: Previous firmware image data size, when fbc_download is true
  * @edl_image: Firmware image name for emergency download mode (optional)
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
@@ -382,6 +383,7 @@ struct mhi_controller {
 	const char *fw_image;
 	const u8 *fw_data;
 	size_t fw_sz;
+	size_t prev_fw_sz;
 	const char *edl_image;
 	size_t rddm_size;
 	size_t sbl_size;
-- 
2.43.0


