Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43F42FCC4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhJOUMh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhJOUMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 16:12:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B24C061570
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 13:10:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r10so28238808wra.12
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Esh9b0JkPszPu1iwVejd7mQ5HUIRjQSBV+k5HzyT5I=;
        b=HbTTH3AAyvht+fTaqVrx4PmoJTEWy095JVCu8cj1mTtJauMteh8v4XvVSKIp+IhO51
         bs7O3RjsBJswUjoTeO5ezxCD3rj+QqpdoE46JomsyScgq3wZBZ2jcgRsqc6wkTC9VmCS
         G57D7Brn4LfrKbUqNPxtRxfSRyGwq6sCi7TFfYo5pSBIABuloKNgYNYsHlVphwwN0h/f
         dXGMdNhQhQkjjsrf6z7Ub6+BJUfOk3K11AZqQNeGyK28IkKkt/iFnPGuRvSL66d5aEAT
         X0o++cIPOEpOYm0vcwEsdGJRqBNiSCZD4wVCdqsWP/rKbOLBiUajwpujJPBaJEcY4GwG
         D6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Esh9b0JkPszPu1iwVejd7mQ5HUIRjQSBV+k5HzyT5I=;
        b=Nu/R6C4EMdElsuQs6qiI/svc14tL2vfdBk+C8wHELadanuPZ9RZaAWzwr9gmBVq9Sb
         OtRac+/nMbeeNJpdmPlVoVb8BbJskVUYoCmxcl/pErqfAzXxPhGlzbStiJJC8fxh1CJH
         Z7MA8Mep8AKE5NEytILdZFI7iy7EK1VaAMZNwj/Ea0rgax1FJADtZValo/jXn+uC5LWF
         BMTkBldtb48RyKaeXTBQ0KEKuXA9/+6YE88FWVxSPUlqGKtILsrp+RmRUSr4pBTy9g+N
         egK4O9A5/h7KkleY9I3ksC2mbAx9mY95pptvaVPDVSKX0f+mwnoOFlKkrM6eqRGZezJN
         iGyA==
X-Gm-Message-State: AOAM5305p/RBDauiAYkJ/mvrhLZ9kyEbDbayh4f9Syqd+JVlns3OXcpY
        hU6U3qp3HHqzRie42JV1ut92wK3hZWo=
X-Google-Smtp-Source: ABdhPJx/3UqxwklKTR3dl/8w/4nJ/1JKP+dQtnimKERj1kMYXKxLTUl6g/7uHKo3iMUgxSZtH+YuDA==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr16657953wrt.149.1634328628679;
        Fri, 15 Oct 2021 13:10:28 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff0d3900d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff0d:3900:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id k10sm11132005wmr.32.2021.10.15.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:10:28 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mbTX9-0054cb-Sm;
        Fri, 15 Oct 2021 22:10:27 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Robert Marko <robimarko@gmail.com>,
        =?UTF-8?q?Thibaut=20Var=C3=A8ne?= <hacks@slashdirt.org>
Subject: [PATCH v1] ath10k: fetch (pre-)calibration data via nvmem subsystem
Date:   Fri, 15 Oct 2021 22:10:27 +0200
Message-Id: <20211015201027.1209402-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On most embedded ath10k devices (like range extenders,
routers, accesspoints, ...) the calibration data is
stored in a easily accessible MTD partitions named
"ART", "caldata", "calibration", etc...

Since commit 4b361cfa8624 ("mtd: core: add OTP nvmem provider support"):
MTD partitions and portions of them can be specified
as potential nvmem-cells which are accessible through
the nvmem subsystem.

This feature - together with an nvmem cell definition either
in the platform data or via device-tree allows drivers to get
the (pre-)calibration data which is required for initializing
the WIFI.

Tested with Netgear EX6150v2 (IPQ4018)

Cc: Robert Marko <robimarko@gmail.com>
Cc: Thibaut Varène <hacks@slashdirt.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---

This idea came up during the discussion of:
"ath10k: support bus and device specific API 1 BDF selection"

I do not have a device which has the boardfile data stored
by the manufracturer in flash. So this patch only deals with
the (pre-)calibration data. I'll see if I can get hold of a
suitable QCA9880 device to test it as well.

I placed the new nvmem code in front of the current "file" method
(firmware_request) because it made it easier for me to test it.
If needed I can be moved to a different place as well.
---
 drivers/net/wireless/ath/ath10k/core.c | 64 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/core.h |  6 +++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index c21e05549f61..3454d791ce76 100644
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
+		ath10k_warn(ar, "invalid calibration data length in nvmem-cell '%s': %ld != %d\n",
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

