Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212CF765084
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjG0KEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjG0KEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 06:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC24128
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 03:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0597261E09
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AADC433C9;
        Thu, 27 Jul 2023 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690452274;
        bh=AxoQk5Kd5912Pk3U5d9T6/Fe+8XDXH31qlrvzQ7wtmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkNifVCBqentnAmdvUvqjlaU6XxENRrcKXRrZRtGi1n7TP1S9TGDZuiP+iRus7l8Z
         faiylqb2r9nC/iFo2DrIDz3iyS/e6Odi59DkMLc9lSH/UFM+8Ric56HTQcowR6reqB
         DIg0/gjU26N2fp062bCw0QkmguEJVKa+ru9PtxcWBkLvsd1NtkM2+DHvis6xgcMdI1
         Vm4JbHDCwejo1LjvawT9zJPptijc8ds3VMIWWN2LEuF4EUSo5oa//C1ArpgktLZk0D
         wA8iVbJTTN6Xa393hNjzevGu1YcMfO7OCF0yuszpmh6qD6ruFrtVoGpN1jvzHJrPPF
         qZzI6NCMzDbiA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH v4 1/3] bus: mhi: host: allow MHI client drivers to provide the firmware via a pointer
Date:   Thu, 27 Jul 2023 13:04:28 +0300
Message-Id: <20230727100430.3603551-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727100430.3603551-1-kvalo@kernel.org>
References: <20230727100430.3603551-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/bus/mhi/host/boot.c | 34 +++++++++++++++++++++++++---------
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index d2a19b07ccb8..edc0ec5a0933 100644
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
 
@@ -393,9 +391,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	enum mhi_pm_state new_state;
 	const char *fw_name;
+	const u8 *fw_data;
 	void *buf;
 	dma_addr_t dma_addr;
-	size_t size;
+	size_t size, fw_sz;
 	int i, ret;
 
 	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
@@ -425,6 +424,20 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
 		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
 
+	/* check if the driver has already provided the firmware data */
+	if (!fw_name && mhi_cntrl->fbc_download &&
+	    mhi_cntrl->fw_data && mhi_cntrl->fw_sz) {
+		if (!mhi_cntrl->sbl_size) {
+			dev_err(dev, "fw_data provided but no sbl_size\n");
+			goto error_fw_load;
+		}
+
+		size = mhi_cntrl->sbl_size;
+		fw_data = mhi_cntrl->fw_data;
+		fw_sz = mhi_cntrl->fw_sz;
+		goto skip_req_fw;
+	}
+
 	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
 						     !mhi_cntrl->seg_len))) {
 		dev_err(dev,
@@ -444,6 +457,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	if (size > firmware->size)
 		size = firmware->size;
 
+	fw_data = firmware->data;
+	fw_sz = firmware->size;
+
+skip_req_fw:
 	buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, &dma_addr,
 				 GFP_KERNEL);
 	if (!buf) {
@@ -452,7 +469,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 	/* Download image using BHI */
-	memcpy(buf, firmware->data, size);
+	memcpy(buf, fw_data, size);
 	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
 	dma_free_coherent(mhi_cntrl->cntrl_dev, size, buf, dma_addr);
 
@@ -464,7 +481,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 	/* Wait for ready since EDL image was loaded */
-	if (fw_name == mhi_cntrl->edl_image) {
+	if (fw_name && fw_name == mhi_cntrl->edl_image) {
 		release_firmware(firmware);
 		goto fw_load_ready_state;
 	}
@@ -478,15 +495,14 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
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
index f6de4b6ecfc7..039943ec4d4e 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -299,6 +299,10 @@ struct mhi_controller_config {
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
+ * @fw_data: Firmware image data content for normal booting, used only
+ *           if fw_image is NULL and fbc_download is true (optional)
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
2.39.2

