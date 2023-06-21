Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B316738206
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFUKOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjFUKOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C941721
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342432; x=1718878432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YVF7bYTDGnIzEHa4eNQJIo5LiPjinjYM51KKs819J4I=;
  b=VKFFfmWj6wv7PEbSxRmOZzim9Ky37I7LMKmlTUJjsQdYKtvNuXjAfl2q
   3SYnt5HoUrbFo2LkZ4vhkpPq6xudfM0piv5uulvrtsM0vk8kERliWNu+v
   JRR36GEIgW67gZvLXQE10kp/LneYwvjsnLJGibL9+S+b88u4r+RK3l6/N
   al4qGcNRXAk/rP1uFtATEZoz/1H2Tdu6CYFokCuyM3Kdsv6oDq3CKdrjg
   Tn7DWuJbYkQmqHpJQK/huHif33KV2WfOnmbW6ZpI8bJ67wfaCBoa9PemS
   +db1FLIU17S1+sCMNWwGD2SY7IoW8wi3n1N2jsmdPfovBUOHHY1v68qLq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506489"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599287"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599287"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/18] wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants
Date:   Wed, 21 Jun 2023 13:12:18 +0300
Message-Id: <20230621130443.72240ca13b83.I1f4ed547f0964719ed98a3ef928080462d594491@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have the trailing dash here, but that complicates all
the code. Simplify this by removing the dashes, adding
them to the *_MODULE_FIRMWARE macros, and adjusting the
code using this accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c | 10 +--
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c | 18 ++---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 26 +++----
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c | 10 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c | 18 ++---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c | 22 +++---
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c | 10 +--
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 10 +--
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 60 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 70 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 28 ++++----
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  | 16 +----
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 12 ++--
 14 files changed, 150 insertions(+), 162 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
index 116defb15afb..f172ffd2a841 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/1000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -22,11 +22,11 @@
 #define EEPROM_1000_TX_POWER_VERSION	(4)
 #define EEPROM_1000_EEPROM_VERSION	(0x15C)
 
-#define IWL1000_FW_PRE "iwlwifi-1000-"
-#define IWL1000_MODULE_FIRMWARE(api) IWL1000_FW_PRE __stringify(api) ".ucode"
+#define IWL1000_FW_PRE "iwlwifi-1000"
+#define IWL1000_MODULE_FIRMWARE(api) IWL1000_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL100_FW_PRE "iwlwifi-100-"
-#define IWL100_MODULE_FIRMWARE(api) IWL100_FW_PRE __stringify(api) ".ucode"
+#define IWL100_FW_PRE "iwlwifi-100"
+#define IWL100_MODULE_FIRMWARE(api) IWL100_FW_PRE "-" __stringify(api) ".ucode"
 
 
 static const struct iwl_base_params iwl1000_base_params = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
index ab2038a3fbe2..6f3f26da0ad5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/2000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -28,17 +28,17 @@
 #define EEPROM_2000_EEPROM_VERSION	(0x805)
 
 
-#define IWL2030_FW_PRE "iwlwifi-2030-"
-#define IWL2030_MODULE_FIRMWARE(api) IWL2030_FW_PRE __stringify(api) ".ucode"
+#define IWL2030_FW_PRE "iwlwifi-2030"
+#define IWL2030_MODULE_FIRMWARE(api) IWL2030_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL2000_FW_PRE "iwlwifi-2000-"
-#define IWL2000_MODULE_FIRMWARE(api) IWL2000_FW_PRE __stringify(api) ".ucode"
+#define IWL2000_FW_PRE "iwlwifi-2000"
+#define IWL2000_MODULE_FIRMWARE(api) IWL2000_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL105_FW_PRE "iwlwifi-105-"
-#define IWL105_MODULE_FIRMWARE(api) IWL105_FW_PRE __stringify(api) ".ucode"
+#define IWL105_FW_PRE "iwlwifi-105"
+#define IWL105_MODULE_FIRMWARE(api) IWL105_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL135_FW_PRE "iwlwifi-135-"
-#define IWL135_MODULE_FIRMWARE(api) IWL135_FW_PRE __stringify(api) ".ucode"
+#define IWL135_FW_PRE "iwlwifi-135"
+#define IWL135_MODULE_FIRMWARE(api) IWL135_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl2000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 8acbbed6eb1f..aa4320ca4c30 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -26,26 +26,26 @@
 #define IWL_22000_SMEM_OFFSET		0x400000
 #define IWL_22000_SMEM_LEN		0xD0000
 
-#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0-"
-#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0-"
-#define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0-"
-#define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0-"
-#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0-"
-#define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0-"
-#define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0-"
+#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0"
+#define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0"
+#define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0"
+#define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0"
+#define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0"
+#define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0"
+#define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_QU_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QUZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_QUZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_QUZ_A_JF_B_FW_PRE __stringify(api) ".ucode"
+	IWL_QUZ_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QU_C_HR_B_MODULE_FIRMWARE(api) \
-	IWL_QU_C_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
-	IWL_QU_B_JF_B_FW_PRE __stringify(api) ".ucode"
+	IWL_QU_B_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
-	IWL_CC_A_FW_PRE __stringify(api) ".ucode"
+	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
index e2e23d2bc1fe..de7ede59a994 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -24,11 +24,11 @@
 #define EEPROM_5050_TX_POWER_VERSION	(4)
 #define EEPROM_5050_EEPROM_VERSION	(0x21E)
 
-#define IWL5000_FW_PRE "iwlwifi-5000-"
-#define IWL5000_MODULE_FIRMWARE(api) IWL5000_FW_PRE __stringify(api) ".ucode"
+#define IWL5000_FW_PRE "iwlwifi-5000"
+#define IWL5000_MODULE_FIRMWARE(api) IWL5000_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL5150_FW_PRE "iwlwifi-5150-"
-#define IWL5150_MODULE_FIRMWARE(api) IWL5150_FW_PRE __stringify(api) ".ucode"
+#define IWL5150_FW_PRE "iwlwifi-5150"
+#define IWL5150_MODULE_FIRMWARE(api) IWL5150_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl5000_base_params = {
 	.eeprom_size = IWLAGN_EEPROM_IMG_SIZE,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
index 20929e59c2f4..f013cf420569 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/6000.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2020 Intel Corporation
+ * Copyright(c) 2018 - 2020, 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/module.h>
@@ -37,17 +37,17 @@
 #define EEPROM_6035_TX_POWER_VERSION	(6)
 #define EEPROM_6035_EEPROM_VERSION	(0x753)
 
-#define IWL6000_FW_PRE "iwlwifi-6000-"
-#define IWL6000_MODULE_FIRMWARE(api) IWL6000_FW_PRE __stringify(api) ".ucode"
+#define IWL6000_FW_PRE "iwlwifi-6000"
+#define IWL6000_MODULE_FIRMWARE(api) IWL6000_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL6050_FW_PRE "iwlwifi-6050-"
-#define IWL6050_MODULE_FIRMWARE(api) IWL6050_FW_PRE __stringify(api) ".ucode"
+#define IWL6050_FW_PRE "iwlwifi-6050"
+#define IWL6050_MODULE_FIRMWARE(api) IWL6050_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL6005_FW_PRE "iwlwifi-6000g2a-"
-#define IWL6005_MODULE_FIRMWARE(api) IWL6005_FW_PRE __stringify(api) ".ucode"
+#define IWL6005_FW_PRE "iwlwifi-6000g2a"
+#define IWL6005_MODULE_FIRMWARE(api) IWL6005_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL6030_FW_PRE "iwlwifi-6000g2b-"
-#define IWL6030_MODULE_FIRMWARE(api) IWL6030_FW_PRE __stringify(api) ".ucode"
+#define IWL6030_FW_PRE "iwlwifi-6000g2b"
+#define IWL6030_MODULE_FIRMWARE(api) IWL6030_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl6000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_2K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index b24dc5523a52..4e2afdedf4c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -34,20 +34,20 @@
 #define IWL3160_DCCM_LEN		0x10000
 #define IWL7265_DCCM_LEN		0x17A00
 
-#define IWL7260_FW_PRE "iwlwifi-7260-"
-#define IWL7260_MODULE_FIRMWARE(api) IWL7260_FW_PRE __stringify(api) ".ucode"
+#define IWL7260_FW_PRE "iwlwifi-7260"
+#define IWL7260_MODULE_FIRMWARE(api) IWL7260_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL3160_FW_PRE "iwlwifi-3160-"
-#define IWL3160_MODULE_FIRMWARE(api) IWL3160_FW_PRE __stringify(api) ".ucode"
+#define IWL3160_FW_PRE "iwlwifi-3160"
+#define IWL3160_MODULE_FIRMWARE(api) IWL3160_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL3168_FW_PRE "iwlwifi-3168-"
-#define IWL3168_MODULE_FIRMWARE(api) IWL3168_FW_PRE __stringify(api) ".ucode"
+#define IWL3168_FW_PRE "iwlwifi-3168"
+#define IWL3168_MODULE_FIRMWARE(api) IWL3168_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL7265_FW_PRE "iwlwifi-7265-"
-#define IWL7265_MODULE_FIRMWARE(api) IWL7265_FW_PRE __stringify(api) ".ucode"
+#define IWL7265_FW_PRE "iwlwifi-7265"
+#define IWL7265_MODULE_FIRMWARE(api) IWL7265_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL7265D_FW_PRE "iwlwifi-7265D-"
-#define IWL7265D_MODULE_FIRMWARE(api) IWL7265D_FW_PRE __stringify(api) ".ucode"
+#define IWL7265D_FW_PRE "iwlwifi-7265D"
+#define IWL7265D_MODULE_FIRMWARE(api) IWL7265D_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl7000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_16K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index a6454287d506..d09cf8d7dc01 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2014, 2018-2020, 2023 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -27,13 +27,13 @@
 #define IWL8260_SMEM_OFFSET		0x400000
 #define IWL8260_SMEM_LEN		0x68000
 
-#define IWL8000_FW_PRE "iwlwifi-8000C-"
+#define IWL8000_FW_PRE "iwlwifi-8000C"
 #define IWL8000_MODULE_FIRMWARE(api) \
-	IWL8000_FW_PRE __stringify(api) ".ucode"
+	IWL8000_FW_PRE "-" __stringify(api) ".ucode"
 
-#define IWL8265_FW_PRE "iwlwifi-8265-"
+#define IWL8265_FW_PRE "iwlwifi-8265"
 #define IWL8265_MODULE_FIRMWARE(api) \
-	IWL8265_FW_PRE __stringify(api) ".ucode"
+	IWL8265_FW_PRE "-" __stringify(api) ".ucode"
 
 #define DEFAULT_NVM_FILE_FAMILY_8000C		"nvmData-8000C"
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 7a7ca06d46c1..0130d9a9b78b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2021, 2023 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -26,12 +26,12 @@
 #define IWL9000_SMEM_OFFSET		0x400000
 #define IWL9000_SMEM_LEN		0x68000
 
-#define  IWL9000_FW_PRE "iwlwifi-9000-pu-b0-jf-b0-"
-#define  IWL9260_FW_PRE "iwlwifi-9260-th-b0-jf-b0-"
+#define  IWL9000_FW_PRE "iwlwifi-9000-pu-b0-jf-b0"
+#define  IWL9260_FW_PRE "iwlwifi-9260-th-b0-jf-b0"
 #define IWL9000_MODULE_FIRMWARE(api) \
-	IWL9000_FW_PRE __stringify(api) ".ucode"
+	IWL9000_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL9260_MODULE_FIRMWARE(api) \
-	IWL9260_FW_PRE __stringify(api) ".ucode"
+	IWL9260_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl9000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index a484cae3f784..1821e569e9b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -26,51 +26,51 @@
 #define IWL_AX210_SMEM_OFFSET		0x400000
 #define IWL_AX210_SMEM_LEN		0xD0000
 
-#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0-"
-#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0-"
-#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0-"
-#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
-#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
-#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0-"
-#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0-"
-#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
-#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
-#define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
-#define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0-"
-#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0-"
-#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0-"
-#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0-"
-#define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0-"
-#define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0-"
+#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0"
+#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0"
+#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0"
+#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0"
+#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0"
+#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0"
+#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0"
+#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
+#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
+#define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0"
+#define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0"
+#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
+#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
+#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
+#define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0"
+#define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0"
 
 #define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
+	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_SO_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SO_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_SO_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_TY_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_A_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_B_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_B_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_B_MR_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_B_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_MA_B_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_ax210_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index fe6166d364cf..4f0bc6924111 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -26,59 +26,59 @@
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
-#define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
-#define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
-#define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0-"
-#define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
-#define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
-#define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
-#define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0-"
-#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0-"
-#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0-"
-#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0-"
-#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0-"
-#define IWL_BZ_B_GF4_A_FW_PRE		"iwlwifi-bz-b0-gf4-a0-"
-#define IWL_BZ_B_FM_B_FW_PRE		"iwlwifi-bz-b0-fm-b0-"
-#define IWL_BZ_B_FM4_B_FW_PRE		"iwlwifi-bz-b0-fm4-b0-"
-#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
-#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
-#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0-"
-#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
+#define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0"
+#define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
+#define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
+#define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
+#define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0"
+#define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0"
+#define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0"
+#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
+#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
+#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
+#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0"
+#define IWL_BZ_B_GF4_A_FW_PRE		"iwlwifi-bz-b0-gf4-a0"
+#define IWL_BZ_B_FM_B_FW_PRE		"iwlwifi-bz-b0-fm-b0"
+#define IWL_BZ_B_FM4_B_FW_PRE		"iwlwifi-bz-b0-fm4-b0"
+#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0"
+#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
+#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
+#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0"
 
 #define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM_C_FW_PRE __stringify(api) ".ucode"
+		IWL_BZ_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_B_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_B_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_B_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_B_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_B_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_B_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_B_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_GL_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_GL_B_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
-	IWL_GL_C_FM_C_FW_PRE __stringify(api) ".ucode"
+	IWL_GL_C_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_bz_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 679cb53ae18a..6e487a83ee24 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -26,28 +26,28 @@
 #define IWL_SC_SMEM_OFFSET		0x400000
 #define IWL_SC_SMEM_LEN			0xD0000
 
-#define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0-"
-#define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0-"
-#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
-#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
-#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0-"
-#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0-"
-#define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0-"
+#define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0"
+#define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0"
+#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0"
+#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0"
+#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
+#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
+#define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
 
 #define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_C_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_A_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_B_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF_A_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_WH_A_FW_PRE __stringify(api) ".ucode"
+	IWL_SC_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_sc_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 32fba08b7db1..1bac3466154c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -21,21 +21,9 @@ void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
 			  u8 *pnvm_name, size_t max_len)
 {
 	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
-	const char *fw_name_pre;
-	int pre_len;
 
-	fw_name_pre = iwl_drv_get_fwname_pre(trans, _fw_name_pre);
-
-	/*
-	 * The prefix unfortunately includes a hyphen at the end, so
-	 * don't add the dot here...
-	 */
-	snprintf(pnvm_name, max_len, "%spnvm", fw_name_pre);
-
-	/* ...but replace the hyphen with the dot here. */
-	pre_len = strlen(fw_name_pre);
-	if (pre_len < max_len && pre_len > 0)
-		pnvm_name[pre_len - 1] = '.';
+	snprintf(pnvm_name, max_len, "%s.pnvm",
+		 iwl_drv_get_fwname_pre(trans, _fw_name_pre));
 }
 
 #endif /* __IWL_PNVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 4cc0285f287e..1c0cfbb6c427 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -309,7 +309,7 @@ struct iwl_fw_mon_regs {
  * @name: Official name of the device
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
- *	filename is constructed as fw_name_pre<api>.ucode.
+ *	filename is constructed as <fw_name_pre>-<api>.ucode.
  * @fw_name_mac: MAC name for this config, the remaining pieces of the
  *	name will be generated dynamically
  * @ucode_api_max: Highest version of uCode API supported by driver.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a7cf73d67371..3d87d26845e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -174,7 +174,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		return trans->cfg->fw_name_pre;
 
 	if (WARN_ON(!trans->cfg->fw_name_mac))
-		return "unconfigured-";
+		return "unconfigured";
 
 	mac_step = iwl_drv_get_step(trans->hw_rev_step);
 
@@ -199,7 +199,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		rf = "wh";
 		break;
 	default:
-		return "unknown-rf-";
+		return "unknown-rf";
 	}
 
 	cdb = CSR_HW_RFID_IS_CDB(trans->hw_rf_id) ? "4" : "";
@@ -244,12 +244,12 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		IWL_ERR(drv, "no suitable firmware found!\n");
 
 		if (cfg->ucode_api_min == cfg->ucode_api_max) {
-			IWL_ERR(drv, "%s%d is required\n", fw_name_pre,
+			IWL_ERR(drv, "%s-%d is required\n", fw_name_pre,
 				cfg->ucode_api_max);
 		} else {
-			IWL_ERR(drv, "minimum version required: %s%d\n",
+			IWL_ERR(drv, "minimum version required: %s-%d\n",
 				fw_name_pre, cfg->ucode_api_min);
-			IWL_ERR(drv, "maximum version supported: %s%d\n",
+			IWL_ERR(drv, "maximum version supported: %s-%d\n",
 				fw_name_pre, cfg->ucode_api_max);
 		}
 
@@ -258,7 +258,7 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -ENOENT;
 	}
 
-	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s%d.ucode",
+	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s-%d.ucode",
 		 fw_name_pre, drv->fw_index);
 
 	IWL_DEBUG_FW_INFO(drv, "attempting to load firmware '%s'\n",
-- 
2.38.1

