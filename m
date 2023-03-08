Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E036B0C99
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCHPZg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCHPZb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 10:25:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4AC5616
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 07:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CB39B81C4D
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FFBC433D2;
        Wed,  8 Mar 2023 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678289126;
        bh=SrAq+DDewNQuaVVmmMK7PUrDAUggwmxqEZ7rN80AGB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmHjS0oIiOPyujluEn8Xug0isgdipJ4IuIuERhik4Yy6ZdzSGbgndhEIClphaWcXP
         WSVyZn7T1SsPq0lzOZw0atkDjNJsk06ywjipjHKLxiMuiEiylJtrBcQyxTHtLBpgc0
         mOHtHYRcUmLX0ShCxRS6y8Fp9CqXM6InpwbWnuVnyfiWlF8vORdjxYukXETH0boTpv
         9twG8gyVretuQ179pispswO8l5IpOGUzvzrcebGZo1I3HbQ+mBTntqC2e2NK0ULrLp
         UpJZjw+a5rsq/TZOyH4DR6k6ThYGlxkx39T3UZC8SLWaRZwmTkJy5CeN+yizk+baLu
         DSR7Gq1GsfJ5Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/3] mhi: allow MHI client drivers to provide the firmware via a pointer
Date:   Wed,  8 Mar 2023 17:25:20 +0200
Message-Id: <20230308152522.6728-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308152522.6728-1-kvalo@kernel.org>
References: <20230308152522.6728-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Currently MHI loads the firmware image from the path provided by client
devices. ath11k needs to support firmware image embedded along with meta data
(named as firmware-2.bin). So allow the client driver to request the firmware
file from user space on it's own and provide the firmware image data and size
to MHI via a pointer struct mhi_controller::fw_data.

This is an optional feature, if fw_data is NULL MHI load the firmware using the
name from struct mhi_controller::fw_image string as before.

Tested with ath11k and WCN6855 hw2.0.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 28 +++++++++++++++++++---------
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 1c69feee1703..5e6e1e340057 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -365,12 +365,10 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 }
 
 static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
-			      const struct firmware *firmware,
+			      const u8 *buf, size_t remainder,
 			      struct image_info *img_info)
 {
-	size_t remainder = firmware->size;
 	size_t to_cpy;
-	const u8 *buf = firmware->data;
 	struct mhi_buf *mhi_buf = img_info->mhi_buf;
 	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
 
@@ -392,9 +390,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	const char *fw_name;
+	const u8 *fw_data;
 	void *buf;
 	dma_addr_t dma_addr;
-	size_t size;
+	size_t size, fw_sz;
 	int i, ret;
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
@@ -424,6 +423,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
 		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
 
+	if (!fw_name && mhi_cntrl->fbc_download &&
+	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
+		size = mhi_cntrl->sbl_size;
+		fw_data = mhi_cntrl->fw_data;
+		fw_sz = mhi_cntrl->fw_sz;
+		goto skip_req_fw;
+	}
+
 	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
 						     !mhi_cntrl->seg_len))) {
 		dev_err(dev,
@@ -443,6 +450,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (size > firmware->size)
 		size = firmware->size;
 
+	fw_data = firmware->data;
+	fw_sz = firmware->size;
+
+skip_req_fw:
 	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
 				 GFP_KERNEL);
 	if (!buf) {
@@ -451,7 +462,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 	/* Download image using BHI */
-	memcpy(buf, firmware->data, size);
+	memcpy(buf, fw_data, size);
 	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
 	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
 
@@ -463,7 +474,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 	/* Wait for ready since EDL image was loaded */
-	if (fw_name == mhi_cntrl->edl_image) {
+	if (fw_name && fw_name == mhi_cntrl->edl_image) {
 		release_firmware(firmware);
 		goto fw_load_ready_state;
 	}
@@ -477,15 +488,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	 * device transitioning into MHI READY state
 	 */
 	if (mhi_cntrl->fbc_download) {
-		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
-					   firmware->size);
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
 		if (ret) {
 			release_firmware(firmware);
 			goto error_fw_load;
 		}
 
 		/* Load the firmware into BHIE vec table */
-		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+		mhi_firmware_copy(mhi_cntrl, fw_data, fw_sz, mhi_cntrl->fbc_image);
 	}
 
 	release_firmware(firmware);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index a5441ad33c74..72eef7309736 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -299,6 +299,10 @@ struct mhi_controller_config {
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
+ * @fw_data: Firmware image data content for normal booting, used only
+ *           if fw_image is NULL (optional)
+ * @fw_sz: Firmware image data size for normal booting, used only if fw_image
+ *         is NULL and fbc_download is true (optional)
  * @edl_image: Firmware image name for emergency download mode (optional)
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
@@ -384,6 +388,8 @@ struct mhi_controller {
 	dma_addr_t iova_start;
 	dma_addr_t iova_stop;
 	const char *fw_image;
+	const u8 *fw_data;
+	size_t fw_sz;
 	const char *edl_image;
 	size_t rddm_size;
 	size_t sbl_size;
-- 
2.30.2

