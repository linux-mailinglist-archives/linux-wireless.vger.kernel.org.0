Return-Path: <linux-wireless+bounces-22671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC51AAC8B0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C92C7A8785
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD5283155;
	Tue,  6 May 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="MY3xtd23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC3255E37;
	Tue,  6 May 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543098; cv=pass; b=kFDZSMK4PK75HnWcLsuB6d4Lrw5VdMeveFDFJtUIX+rUtPgfEyhaV99A1G0yFHvsyGnOhXajfNNCt0G81/G+ZHJmD7HH2ar0e7DzWl/iQ1WzIedw5VqrwKsqOR6K/PDZ3DpUl6rZwrKh7D/QMSj6OfxbipkwM3n/XqHSHFiwRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543098; c=relaxed/simple;
	bh=UYP07GBClAMU0pKc9jto39bAfvQmXjsbcF+MgijDaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4RCjCUi1tBVXEccRBav0bTH4x3r9zPFjRO2Cm26gev3EVd+WyWOJin3hA8EmrTny7P3gAZPj8YU+jOz1ZVYk/kJ6j6u6sVJfAEw5MOJGeKH5XdAkSnSckg8Pyb9ptNO8HOBjamJ4+OiiMe7LlouujUwFiy4+4++NqV75hXB2pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=MY3xtd23; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746543056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JlENvj1DtQ6vDPp1Tt5aSSXxs0r3fAzGHGo3h86pbX9rB1/W8lP24PEkqATdqQMNDBv0koWbBKsvQSeu9+OToP2qHihgUi+IjtqXNlpOJyG6/aq7wxceEnVPw1iG1oaIVgqiBxv4h+2AVisNANp9cMy5e27w6P48AunfIUmaDr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746543056; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hzNcysWgeznsB2udfNycSzXTF9lLlaxaY04PxZPeNe8=; 
	b=ILYVQRkwLMcQj7Xb4ASNjQ0z7k8kzkTogY8qspSFLcidbgQe56l1f6FmfTB3X9q/aVdgaBwSRHQ2L0n91i7GY4aH6PsAWXVd/qJCLZnf4Y/FrHH+GjX4FM4xUZtcbHc7Zix/bgzT+igFq2xYleCrIrQnkMbDWbcLcYHlMkBgaM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746543056;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hzNcysWgeznsB2udfNycSzXTF9lLlaxaY04PxZPeNe8=;
	b=MY3xtd23dXiQ8NsA89LyI/Gj2f6XOeOfOs6DvB2ilriH/COuyXYtOqlWCXPZEIHo
	BGjnHs4LMZBa+E5I3LUkLZQFddY67opZaRH0HSs7DOhcszH1s1nytY4qSzuP/Jpj0HT
	ngWvmDbdGrqAzhppfWB3x78kSd+z73ltlGDH9JC0=
Received: by mx.zohomail.com with SMTPS id 1746543054682438.2320888768767;
	Tue, 6 May 2025 07:50:54 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Troy Hanson <quic_thanson@quicinc.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kernel@collabora.com,
	sebastian.reichel@collabora.com,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Alex Elder <elder@kernel.org>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Subject: [PATCH v4] bus: mhi: host: don't free bhie tables during suspend/hibernation
Date: Tue,  6 May 2025 19:49:23 +0500
Message-ID: <20250506144941.2715345-1-usama.anjum@collabora.com>
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
allocation because of memory pressure. There is a report where at
resume time, the memory from the dma doesn't get allocated and MHI
fails to re-initialize.

To fix it, don't free the memory at power down during suspend /
hibernation. Instead, use the same allocated memory again after every
resume / hibernation. This patch has been tested with resume and
hibernation both.

The rddm is of constant size for a given hardware. While the fbc_image
size depends on the firmware. If the firmware changes, we'll free and
allocate new memory for it.

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

Changes since v3:
- Fix state machine of ath12k by setting ATH12K_MHI_DEINIT with
  ATH12K_MHI_POWER_OFF_KEEP_DEV state (Thanks Sebastian for testing and
  finding the problem)
- Use static with mhi_power_down_unprepare_keep_dev()
- Remove crash log as it was showing that kworker wasn't able to
  allocate memory.

This patch doesn't have fixes tag as we are avoiding error in case of
memory pressure. We are just making this driver more robust by not
freeing the memory and using the same after resuming.
---
 drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
 drivers/bus/mhi/host/init.c           |  5 +++--
 drivers/bus/mhi/host/pm.c             |  9 +++++++++
 drivers/net/wireless/ath/ath11k/mhi.c |  8 ++++----
 drivers/net/wireless/ath/ath12k/mhi.c | 14 ++++++++++----
 include/linux/mhi.h                   |  2 ++
 6 files changed, 39 insertions(+), 14 deletions(-)

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
index e6c3ff62bab1d..107d71b4cc51a 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -1259,10 +1259,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 }
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
+static void __mhi_power_down_unprepare_keep_dev(struct mhi_controller *mhi_cntrl)
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
+	__mhi_power_down_unprepare_keep_dev(mhi_cntrl);
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
index 08f44baf182a5..3af524ccf4a5a 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -601,6 +601,12 @@ static int ath12k_mhi_set_state(struct ath12k_pci *ab_pci,
 
 	ath12k_mhi_set_state_bit(ab_pci, mhi_state);
 
+	/* mhi_power_down_keep_dev() has been updated to DEINIT without
+	 * freeing bhie tables
+	 */
+	if (mhi_state == ATH12K_MHI_POWER_OFF_KEEP_DEV)
+		ath12k_mhi_set_state_bit(ab_pci, ATH12K_MHI_DEINIT);
+
 	return 0;
 
 out:
@@ -635,12 +641,12 @@ void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
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


