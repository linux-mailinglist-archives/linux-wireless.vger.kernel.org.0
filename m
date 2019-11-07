Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6704BF2BDA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfKGKJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 05:09:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGKJE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 05:09:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B5D660B6C; Thu,  7 Nov 2019 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573121342;
        bh=ckL6maps5nNQq2y5YQRotAySGsBjpVGC9gYT5RpaPCk=;
        h=From:To:Cc:Subject:Date:From;
        b=Yw9iOu/vyBbHI7FUzYepOOnuL8w8kL4tAnZxF4TKRC/GOO9MuAK6T/Q2qpMlfPFpF
         Gfp7lsIXjNo2ZGvM+bSas/8fs6lFPjlULfttrB5c2eyy3JBpfJDEFBBbFtI9qP1KjU
         YRzMW/IHNycyzXue/VYA4tkLd7C1pCVNuhNnP9LA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EEEA606FB;
        Thu,  7 Nov 2019 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573121340;
        bh=ckL6maps5nNQq2y5YQRotAySGsBjpVGC9gYT5RpaPCk=;
        h=From:To:Cc:Subject:Date:From;
        b=CdvMKGjG09WhQaQ4TTegj8X3/YT5Jz28KMIbrOrxdrtVsMcEaalO8EzxmyNHh5kb5
         X4VLrBigVm8ueeXowAIiIZ9Nsrj71gPvrZfxwN0IWe7x9+vfp4c4d/TB71uBUoZJGW
         wYGqZ+ZAHdgGiCCqcnW9jqt+4LMRKHzsDU0K29is=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EEEA606FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add large size for BMI download data for SDIO
Date:   Thu,  7 Nov 2019 18:08:09 +0800
Message-Id: <20191107100809.17982-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Download firmware time cost of SDIO is too long, it is about 480ms,
add large size 2048 bytes for BMI download for SDIO chip, its time
cost will reduced to 240ms.

This will optimize the download firmware time cost.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/bmi.c  | 52 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/bmi.h  | 11 ++++++
 drivers/net/wireless/ath/ath10k/core.c |  1 +
 drivers/net/wireless/ath/ath10k/hw.h   |  3 ++
 drivers/net/wireless/ath/ath10k/sdio.c |  2 +-
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/ath/ath10k/bmi.c
index 95dc4be82e5c..fb8a4f1cfaa8 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -346,6 +346,52 @@ int ath10k_bmi_execute(struct ath10k *ar, u32 address, u32 param, u32 *result)
 	return 0;
 }
 
+int ath10k_bmi_large_size_lz_data(struct ath10k *ar, const void *buffer, u32 length)
+{
+	struct bmi_cmd *cmd;
+	u32 hdrlen = sizeof(cmd->id) + sizeof(cmd->lz_data);
+	u32 txlen;
+	int ret;
+	size_t buf_len;
+
+	ath10k_dbg(ar, ATH10K_DBG_BMI, "large bmi lz data buffer 0x%pK length %d\n",
+		   buffer, length);
+
+	if (ar->bmi.done_sent) {
+		ath10k_warn(ar, "command disallowed\n");
+		return -EBUSY;
+	}
+
+	buf_len = sizeof(*cmd) + BMI_MAX_LARGE_DATA_SIZE - BMI_MAX_DATA_SIZE;
+	cmd = kzalloc(buf_len, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	while (length) {
+		txlen = min(length, BMI_MAX_LARGE_DATA_SIZE - hdrlen);
+
+		WARN_ON_ONCE(txlen & 3);
+
+		cmd->id          = __cpu_to_le32(BMI_LZ_DATA);
+		cmd->lz_data.len = __cpu_to_le32(txlen);
+		memcpy(cmd->lz_data.payload, buffer, txlen);
+
+		ret = ath10k_hif_exchange_bmi_msg(ar, cmd, hdrlen + txlen,
+						  NULL, NULL);
+		if (ret) {
+			ath10k_warn(ar, "unable to write to the device\n");
+			return ret;
+		}
+
+		buffer += txlen;
+		length -= txlen;
+	}
+
+	kfree(cmd);
+
+	return 0;
+}
+
 int ath10k_bmi_lz_data(struct ath10k *ar, const void *buffer, u32 length)
 {
 	struct bmi_cmd cmd;
@@ -430,7 +476,11 @@ int ath10k_bmi_fast_download(struct ath10k *ar,
 	if (trailer_len > 0)
 		memcpy(trailer, buffer + head_len, trailer_len);
 
-	ret = ath10k_bmi_lz_data(ar, buffer, head_len);
+	if (ar->hw_params.bmi_large_size_download)
+		ret = ath10k_bmi_large_size_lz_data(ar, buffer, head_len);
+	else
+		ret = ath10k_bmi_lz_data(ar, buffer, head_len);
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/ath/ath10k/bmi.h b/drivers/net/wireless/ath/ath10k/bmi.h
index ef3bdba43bed..f16655501bf2 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.h
+++ b/drivers/net/wireless/ath/ath10k/bmi.h
@@ -45,6 +45,15 @@
 			sizeof(u32) + \
 			sizeof(u32))
 
+/* Maximum data size used for large BMI transfers */
+#define BMI_MAX_LARGE_DATA_SIZE	2048
+
+/* len = cmd + addr + length */
+#define BMI_MAX_LARGE_CMDBUF_SIZE (BMI_MAX_LARGE_DATA_SIZE + \
+			sizeof(u32) + \
+			sizeof(u32) + \
+			sizeof(u32))
+
 /* BMI Commands */
 
 enum bmi_cmd_id {
@@ -258,6 +267,8 @@ int ath10k_bmi_write_memory(struct ath10k *ar, u32 address,
 int ath10k_bmi_execute(struct ath10k *ar, u32 address, u32 param, u32 *result);
 int ath10k_bmi_lz_stream_start(struct ath10k *ar, u32 address);
 int ath10k_bmi_lz_data(struct ath10k *ar, const void *buffer, u32 length);
+int ath10k_bmi_large_size_lz_data(struct ath10k *ar, const void *buffer, u32 length);
+
 int ath10k_bmi_fast_download(struct ath10k *ar, u32 address,
 			     const void *buffer, u32 length);
 int ath10k_bmi_read_soc_reg(struct ath10k *ar, u32 address, u32 *reg_val);
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 36c62d66c19e..5e33de24febf 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -188,6 +188,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.num_wds_entries = 0x20,
 		.uart_pin_workaround = true,
 		.tx_stats_over_pktlog = false,
+		.bmi_large_size_download = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 35a362329a4f..21b7a2a873b0 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -613,6 +613,9 @@ struct ath10k_hw_params {
 	/* target supporting fw download via diag ce */
 	bool fw_diag_ce_download;
 
+	/* target supporting fw download via large size BMI */
+	bool bmi_large_size_download;
+
 	/* need to set uart pin if disable uart print, workaround for a
 	 * firmware bug
 	 */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 120200a93bcc..0e19df85821a 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2028,7 +2028,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		goto err_core_destroy;
 	}
 
-	ar_sdio->bmi_buf = devm_kzalloc(ar->dev, BMI_MAX_CMDBUF_SIZE, GFP_KERNEL);
+	ar_sdio->bmi_buf = devm_kzalloc(ar->dev, BMI_MAX_LARGE_CMDBUF_SIZE, GFP_KERNEL);
 	if (!ar_sdio->bmi_buf) {
 		ret = -ENOMEM;
 		goto err_core_destroy;
-- 
2.23.0

