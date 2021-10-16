Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D783E4305A7
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhJPXsU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 19:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbhJPXsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 19:48:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58EC061765
        for <linux-wireless@vger.kernel.org>; Sat, 16 Oct 2021 16:46:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m42so5346310wms.2
        for <linux-wireless@vger.kernel.org>; Sat, 16 Oct 2021 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvNTZLNOzLgLjC4+6eG/G/iNgfR6PdkPdBydtJNakHc=;
        b=eoOlDofeT6p4yzsDtCGTrsyK/n9M/HWVIfQBwNozC1HJwArLuemBuPcTkk4MEimZRr
         D8JOVh5IEtUk9DA+O104H4Lx+ZeswjP+fTSfg7IXk74HJ8AFJgj6A2/dq9HsKBPEKXP1
         0ZPHkY+bToo4R0us3MafQ2zLzvFgMJKgJA4rpBCodVtjtljG6MJgEuZUXY74OPdgZx6J
         rEZHDDc0Vl6bs71LXv0ZQp/DP+SsG07hlPm2NjLucVlGxOdhtx9XE9cJKpN7M1xkhfVv
         +LqkXcH2d6VKgznXAlX+C1n/yogJBp+JW+C3hOVIxJafTOakW0g5MpqjdW5CTFm3p2eV
         J4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvNTZLNOzLgLjC4+6eG/G/iNgfR6PdkPdBydtJNakHc=;
        b=E30T4T/I6EtcjKCVLhvSq974JAOk1lQfpwmBuShW3wWi/Rb+HckWKhxcgoXumzK4rt
         CW0y7VfLU4M1BL6H98s6FhTpK++YCdegKro01D7UQ9vxI/WW80yzgrJzdG618pJ0KQln
         ngxlw9tF91FQVhFzT3xoFpZ1mMKKrEMIdNPLLE+eoBCpCm1JKFOIgBIBjhY9E6vybnll
         gA6ehU/9c23V/SkBw8rhlj5mPtdmnH5gAWPUthNm30grImn7EsIlEbpOzyjg+zYQHxSd
         HwVwH06EKxS+CJBkX3QMNaF5rk5HtnesxsiIb2S0DHLIU9VihckmPwQxG9rgPdt8VtNB
         Gd5w==
X-Gm-Message-State: AOAM5333h32EQaxUBCqvYXd1ZaLtXCV+p+9R6aW0+U9EfbKlJ6ePDb5O
        xdAwY1nAWSFl8TFgqnT6KhL+Zb4D4kE=
X-Google-Smtp-Source: ABdhPJxrz7ieWrNWdOQq8ZgLN4yiznyLSXyALTpQwCNaZ72N07HCZGo2xWUGb4vj067U0TM8Nmsn4A==
X-Received: by 2002:a05:600c:3223:: with SMTP id r35mr21074717wmp.32.1634427970033;
        Sat, 16 Oct 2021 16:46:10 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff365c00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff36:5c00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id f18sm8385193wrg.3.2021.10.16.16.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 16:46:09 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mbtNR-006ZzY-5d;
        Sun, 17 Oct 2021 01:46:09 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
Date:   Sun, 17 Oct 2021 01:46:09 +0200
Message-Id: <20211016234609.1568317-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ATH10K chips are used it wide range of routers,
accesspoints, range extenders, network appliances.
On these embedded devices, calibration data is often
stored on the main system's flash and was out of reach
for the driver.

To bridge this gap, ath10k is getting extended to pull
the (pre-)calibration data through nvmem subsystem.
To do this, a nvmem-cell containing the information can
either be specified in the platform data or via device-tree.

Tested with:
        Netgear EX6150v2 (IPQ4018 - pre-calibration method)
        TP-Link Archer C7 v2 (QCA9880v2 - old calibration method)

Cc: Robert Marko <robimarko@gmail.com>
Cc: Thibaut VARÈNE <hacks@slashdirt.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---

v1 -> v2:
	- use %zu and %u in the format string for size_t
          and u32 types (catched by the "kernel test robot").
	- reworded commit message + successfully tested on QCA9880v2

I placed the nvmem code in front of the current "file" method
(firmware_request). Reason is that this makes it easier for me
to test it. If needed it can be moved to a different place.
---
 drivers/net/wireless/ath/ath10k/core.c | 64 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/core.h |  6 +++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index c21e05549f61..9f0e3f010620 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -12,6 +12,7 @@
 #include <linux/dmi.h>
 #include <linux/ctype.h>
 #include <linux/pm_qos.h>
+#include <linux/nvmem-consumer.h>
 #include <asm/byteorder.h>
 
 #include "core.h"
@@ -935,7 +936,8 @@ static int ath10k_core_get_board_id_from_otp(struct ath10k *ar)
 	}
 
 	if (ar->cal_mode == ATH10K_PRE_CAL_MODE_DT ||
-	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE)
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE ||
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_NVMEM)
 		bmi_board_id_param = BMI_PARAM_GET_FLASH_BOARD_ID;
 	else
 		bmi_board_id_param = BMI_PARAM_GET_EEPROM_BOARD_ID;
@@ -1726,7 +1728,8 @@ static int ath10k_download_and_run_otp(struct ath10k *ar)
 
 	/* As of now pre-cal is valid for 10_4 variants */
 	if (ar->cal_mode == ATH10K_PRE_CAL_MODE_DT ||
-	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE)
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_FILE ||
+	    ar->cal_mode == ATH10K_PRE_CAL_MODE_NVMEM)
 		bmi_otp_exe_param = BMI_PARAM_FLASH_SECTION_ALL;
 
 	ret = ath10k_bmi_execute(ar, address, bmi_otp_exe_param, &result);
@@ -1853,6 +1856,39 @@ static int ath10k_download_cal_eeprom(struct ath10k *ar)
 	return ret;
 }
 
+static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+	int ret;
+
+	cell = devm_nvmem_cell_get(ar->dev, cell_name);
+	if (IS_ERR(cell)) {
+		ret = PTR_ERR(cell);
+		return ret;
+	}
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (ar->hw_params.cal_data_len != len) {
+		kfree(buf);
+		ath10k_warn(ar, "invalid calibration data length in nvmem-cell '%s': %zu != %u\n",
+			    cell_name, len, ar->hw_params.cal_data_len);
+		return -EMSGSIZE;
+	}
+
+	ret = ath10k_download_board_data(ar, buf, len);
+	kfree(buf);
+	if (ret)
+		ath10k_warn(ar, "failed to download calibration data from nvmem-cell '%s': %d\n",
+			    cell_name, ret);
+
+	return ret;
+}
+
 int ath10k_core_fetch_firmware_api_n(struct ath10k *ar, const char *name,
 				     struct ath10k_fw_file *fw_file)
 {
@@ -2087,6 +2123,18 @@ static int ath10k_core_pre_cal_download(struct ath10k *ar)
 {
 	int ret;
 
+	ret = ath10k_download_cal_nvmem(ar, "pre-calibration");
+	if (ret == 0) {
+		ar->cal_mode = ATH10K_PRE_CAL_MODE_NVMEM;
+		goto success;
+	} else if (ret == -EPROBE_DEFER) {
+		return ret;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_BOOT,
+		   "boot did not find a pre-calibration nvmem-cell, try file next: %d\n",
+		   ret);
+
 	ret = ath10k_download_cal_file(ar, ar->pre_cal_file);
 	if (ret == 0) {
 		ar->cal_mode = ATH10K_PRE_CAL_MODE_FILE;
@@ -2153,6 +2201,18 @@ static int ath10k_download_cal_data(struct ath10k *ar)
 		   "pre cal download procedure failed, try cal file: %d\n",
 		   ret);
 
+	ret = ath10k_download_cal_nvmem(ar, "calibration");
+	if (ret == 0) {
+		ar->cal_mode = ATH10K_CAL_MODE_NVMEM;
+		goto done;
+	} else if (ret == -EPROBE_DEFER) {
+		return ret;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_BOOT,
+		   "boot did not find a calibration nvmem-cell, try file next: %d\n",
+		   ret);
+
 	ret = ath10k_download_cal_file(ar, ar->cal_file);
 	if (ret == 0) {
 		ar->cal_mode = ATH10K_CAL_MODE_FILE;
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5aeff2d9f6cf..9f6680b3be0a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -877,8 +877,10 @@ enum ath10k_cal_mode {
 	ATH10K_CAL_MODE_FILE,
 	ATH10K_CAL_MODE_OTP,
 	ATH10K_CAL_MODE_DT,
+	ATH10K_CAL_MODE_NVMEM,
 	ATH10K_PRE_CAL_MODE_FILE,
 	ATH10K_PRE_CAL_MODE_DT,
+	ATH10K_PRE_CAL_MODE_NVMEM,
 	ATH10K_CAL_MODE_EEPROM,
 };
 
@@ -898,10 +900,14 @@ static inline const char *ath10k_cal_mode_str(enum ath10k_cal_mode mode)
 		return "otp";
 	case ATH10K_CAL_MODE_DT:
 		return "dt";
+	case ATH10K_CAL_MODE_NVMEM:
+		return "nvmem";
 	case ATH10K_PRE_CAL_MODE_FILE:
 		return "pre-cal-file";
 	case ATH10K_PRE_CAL_MODE_DT:
 		return "pre-cal-dt";
+	case ATH10K_PRE_CAL_MODE_NVMEM:
+		return "pre-cal-nvmem";
 	case ATH10K_CAL_MODE_EEPROM:
 		return "eeprom";
 	}
-- 
2.33.0

