Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D473802C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjFUKO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFUKOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7F1FC6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342428; x=1718878428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05cBGEE1VjRiWtO/dxqXSQbhxZL7fsu9Q2EHWsMrpno=;
  b=Sy6lgrqhggDMbKNn34POBwvaxvxO4FY3zRfjmj6hMb6kBPuBeFYJ8zTk
   YdYl7Gq0CQY6C4Ns93tfWJqyHhubhWURB8P8vcO3JvDfWkdzQNyE6DEvH
   vIPdpjYNEy5m+OhxWoue0SQ7kemWAauqjK9hBQG35sYv1GC906NlWh9H2
   ITjmsQHrioKGLVmMvI1POnMyoJ46MDmFZ0xwM40zKy5SpN3hHdjCyOX9e
   bDIgkAHe8I8uL+fJF0QXSj1sCWvNWSxaeHZX4m4tvPShb0ZR6FZKpo64n
   RpnKeWgpoSy6H4dSUwQwJJJCFXXY+2SpitKq7f3Zjml8A+sEeezsUlGt+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506339"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599092"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599092"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/18] wifi: iwlwifi: split 22000.c into multiple files
Date:   Wed, 21 Jun 2023 13:12:07 +0300
Message-Id: <20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid>
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

Split the configuration list in 22000.c into four new files,
per new device family, so we don't have this huge unusable
file. Yes, this duplicates a few small things, but that's
still much better than what we have now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 939 +-----------------
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 452 +++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 523 ++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 214 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +
 7 files changed, 1206 insertions(+), 928 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 75a703eb1bdf..b983982aee45 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -11,6 +11,7 @@ iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
 iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 iwlwifi-objs		+= queue/tx.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a6fa57517188..12e809b715f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -10,8 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	81
-#define IWL_22500_UCODE_API_MAX	77
+#define IWL_22000_UCODE_API_MAX	77
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
@@ -36,66 +35,6 @@
 #define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0-"
 #define IWL_QNJ_B_JF_B_FW_PRE		"iwlwifi-QuQnj-b0-jf-b0-"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0-"
-#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0-"
-#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0-"
-#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0-"
-#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
-#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
-#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0-"
-#define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
-#define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
-#define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
-#define IWL_SNJ_A_JF_B_FW_PRE		"iwlwifi-SoSnj-a0-jf-b0-"
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
-#define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
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
-
-#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
-#define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
-#define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
-#define IWL_BNJ_B_FM4_B_FW_PRE		"iwlwifi-BzBnj-b0-fm4-b0-"
-#define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
-#define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
-#define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
-#define IWL_BNJ_B_GF4_A_FW_PRE		"iwlwifi-BzBnj-b0-gf4-a0-"
-#define IWL_BNJ_A_HR_A_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
-#define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
-#define IWL_BNJ_B_HR_A_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
-#define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
-#define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
-
-#define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0-"
-#define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0-"
-#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
-#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
-#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0-"
-#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0-"
-#define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -113,117 +52,6 @@
 	IWL_QNJ_B_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_SO_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SO_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_JF_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_MA_B_MR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM_C_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_B_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_B_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_B_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
-	IWL_GL_C_FM_C_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
-
-#define IWL_BNJ_A_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_FM_C_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
-	IWL_SC_A_WH_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -237,32 +65,13 @@ static const struct iwl_base_params iwl_22000_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-static const struct iwl_base_params iwl_ax210_base_params = {
-	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
-	.num_of_queues = 512,
-	.max_tfd_queue_size = 65536,
-	.shadow_ram_support = true,
-	.led_compensation = 57,
-	.wd_timeout = IWL_LONG_WD_TIMEOUT,
-	.max_event_log_size = 512,
-	.shadow_reg_enable = true,
-	.pcie_l1_allowed = true,
-};
-
-static const struct iwl_ht_params iwl_22000_ht_params = {
+const struct iwl_ht_params iwl_22000_ht_params = {
 	.stbc = true,
 	.ldpc = true,
 	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
 		      BIT(NL80211_BAND_6GHZ),
 };
 
-static const struct iwl_ht_params iwl_gl_a_ht_params = {
-	.stbc = false, /* we explicitly disable STBC for GL step A */
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
-		      BIT(NL80211_BAND_6GHZ),
-};
-
 #define IWL_DEVICE_22000_COMMON						\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
@@ -302,7 +111,7 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
-	.ucode_api_max = IWL_22500_UCODE_API_MAX,			\
+	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
 	.trans.base_params = &iwl_22000_base_params,			\
 	.gp2_reg_addr = 0xa02c68,					\
@@ -317,104 +126,6 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 		},							\
 	}
 
-#define IWL_DEVICE_AX210						\
-	IWL_DEVICE_22000_COMMON,					\
-	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
-	.trans.base_params = &iwl_ax210_base_params,			\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,		\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	}
-
-#define IWL_DEVICE_BZ_COMMON						\
-	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
-	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.nvm_hw_section_num = 10,					\
-	.non_shared_ant = ANT_B,					\
-	.dccm_offset = IWL_22000_DCCM_OFFSET,				\
-	.dccm_len = IWL_22000_DCCM_LEN,					\
-	.dccm2_offset = IWL_22000_DCCM2_OFFSET,				\
-	.dccm2_len = IWL_22000_DCCM2_LEN,				\
-	.smem_offset = IWL_22000_SMEM_OFFSET,				\
-	.smem_len = IWL_22000_SMEM_LEN,					\
-	.apmg_not_supported = true,					\
-	.trans.mq_rx_supported = true,					\
-	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = 0x30,					\
-	.nvm_ver = IWL_22000_NVM_VERSION,				\
-	.trans.use_tfh = true,						\
-	.trans.rf_id = true,						\
-	.trans.gen2 = true,						\
-	.nvm_type = IWL_NVM_EXT,					\
-	.dbgc_supported = true,						\
-	.min_umac_error_event_table = 0xD0000,				\
-	.d3_debug_data_base_addr = 0x401000,				\
-	.d3_debug_data_length = 60 * 1024,				\
-	.mon_smem_regs = {						\
-		.write_ptr = {						\
-			.addr = LDBG_M2S_BUF_WPTR,			\
-			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
-	},								\
-		.cycle_cnt = {						\
-			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
-			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
-		},							\
-	},								\
-	.trans.umac_prph_offset = 0x300000,				\
-	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
-	.trans.base_params = &iwl_ax210_base_params,			\
-	.min_txq_size = 128,						\
-	.gp2_reg_addr = 0xd02c68,					\
-	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
-		},							\
-		.cycle_cnt = {						\
-			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
-			.mask = 0xffffffff,				\
-		},							\
-		.cur_frag = {						\
-			.addr = DBGC_CUR_DBGBUF_STATUS,			\
-			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
-		},							\
-	},								\
-	.mon_dbgi_regs = {						\
-		.write_ptr = {						\
-			.addr = DBGI_SRAM_FIFO_POINTERS,		\
-			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
-		},							\
-	}
-
-#define IWL_DEVICE_BZ							\
-	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_22000_ht_params
-
-#define IWL_DEVICE_GL_A							\
-	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_gl_a_ht_params
-
-#define IWL_DEVICE_SC							\
-	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_22000_ht_params
-
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -461,59 +172,6 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const struct iwl_cfg_trans_params iwl_snj_trans_cfg = {
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.umac_prph_offset = 0x300000,
-};
-
-const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.umac_prph_offset = 0x300000,
-	.integrated = true,
-	/* TODO: the following values need to be checked */
-	.xtal_latency = 500,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
-};
-
-const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.umac_prph_offset = 0x300000,
-	.integrated = true,
-	.low_latency_xtal = true,
-	.xtal_latency = 12000,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
-};
-
-const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.umac_prph_offset = 0x300000,
-	.integrated = true,
-	.low_latency_xtal = true,
-	.xtal_latency = 12000,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
-	.imr_enabled = true,
-};
-
 /*
  * If the device doesn't support HE, no need to have that many buffers.
  * 22000 devices can split multiple frames into a single RB, so fewer are
@@ -523,7 +181,6 @@ const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
  */
 #define IWL_NUM_RBDS_NON_HE		512
 #define IWL_NUM_RBDS_22000_HE		2048
-#define IWL_NUM_RBDS_AX210_HE		4096
 
 /*
  * All JF radio modules are part of the 9000 series, but the MAC part
@@ -576,42 +233,11 @@ const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.bisr_workaround = 1,
 };
 
-const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.integrated = true,
-	.umac_prph_offset = 0x300000
-};
-
-const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
-	.device_family = IWL_DEVICE_FAMILY_BZ,
-	.base_params = &iwl_ax210_base_params,
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.integrated = true,
-	.umac_prph_offset = 0x300000,
-	.xtal_latency = 12000,
-	.low_latency_xtal = true,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
-};
-
 const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
 const char iwl_ax204_name[] = "Intel(R) Wi-Fi 6 AX204 160MHz";
-const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
-const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
-const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
-const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
-const char iwl_bz_name[] = "Intel(R) TBD Bz device";
-const char iwl_sc_name[] = "Intel(R) TBD Sc device";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
@@ -621,18 +247,6 @@ const char iwl_ax201_killer_1650s_name[] =
 	"Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)";
 const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
-const char iwl_ax210_killer_1675w_name[] =
-	"Killer(R) Wi-Fi 6E AX1675w 160MHz Wireless Network Adapter (210D2W)";
-const char iwl_ax210_killer_1675x_name[] =
-	"Killer(R) Wi-Fi 6E AX1675x 160MHz Wireless Network Adapter (210NGW)";
-const char iwl_ax211_killer_1675s_name[] =
-	"Killer(R) Wi-Fi 6E AX1675s 160MHz Wireless Network Adapter (211NGW)";
-const char iwl_ax211_killer_1675i_name[] =
-	"Killer(R) Wi-Fi 6E AX1675i 160MHz Wireless Network Adapter (211NGW)";
-const char iwl_ax411_killer_1690s_name[] =
-	"Killer(R) Wi-Fi 6E AX1690s 160MHz Wireless Network Adapter (411D2W)";
-const char iwl_ax411_killer_1690i_name[] =
-	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
 
 const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
@@ -838,191 +452,6 @@ const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
-	.name = iwl_ax211_name,
-	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
-	.name = iwl_ax211_name,
-	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-	.trans.xtal_latency = 12000,
-	.trans.low_latency_xtal = true,
-};
-
-const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
-	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
-	.name = iwl_ax411_name,
-	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
-	.name = iwl_ax411_name,
-	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-	.trans.xtal_latency = 12000,
-	.trans.low_latency_xtal = true,
-};
-
-const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
-	.name = iwl_ax411_name,
-	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
-	.name = iwl_ax211_name,
-	.fw_name_pre = IWL_SNJ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_hr_b0 = {
-	.fw_name_pre = IWL_SNJ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_a0_jf_b0 = {
-	.fw_name_pre = IWL_SNJ_A_JF_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_hr_b0 = {
-	.fw_name_pre = IWL_MA_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
-	.fw_name_pre = IWL_MA_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0 = {
-	.fw_name_pre = IWL_MA_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
-	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_ms_a0 = {
-	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_fm_a0 = {
-	.fw_name_pre = IWL_MA_B_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_hr_b0 = {
-	.fw_name_pre = IWL_MA_B_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_gf_a0 = {
-	.fw_name_pre = IWL_MA_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0 = {
-	.fw_name_pre = IWL_MA_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_mr_a0 = {
-	.fw_name_pre = IWL_MA_B_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
-	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
-	.fw_name_pre = IWL_MA_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
-	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_a0_ms_a0 = {
-	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
-	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
@@ -1035,357 +464,11 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_cfg_bz_a0_hr_a0 = {
-	.fw_name_pre = IWL_BZ_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
-	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
-	.fw_name_pre = IWL_BZ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0 = {
-	.fw_name_pre = IWL_BZ_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
-	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
-	.fw_name_pre = IWL_BZ_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
-	.fw_name_pre = IWL_BZ_A_FM4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_b0 = {
-	.fw_name_pre = IWL_BZ_A_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_c0 = {
-	.fw_name_pre = IWL_BZ_A_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
-	.fw_name_pre = IWL_BZ_A_FM4_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_fm_b0 = {
-	.fw_name_pre = IWL_BZ_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0 = {
-	.fw_name_pre = IWL_BZ_B_FM4_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
-	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_GL_A,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
-	.fw_name_pre = IWL_GL_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_gl_c0_fm_c0 = {
-	.fw_name_pre = IWL_GL_C_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0 = {
-	.fw_name_pre = IWL_BNJ_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
-	.fw_name_pre = IWL_BNJ_A_FM4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0 = {
-	.fw_name_pre = IWL_BNJ_B_FM4_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
-	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0 = {
-	.fw_name_pre = IWL_BNJ_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
-	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0 = {
-	.fw_name_pre = IWL_BNJ_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0 = {
-	.fw_name_pre = IWL_BNJ_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
-	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0 = {
-	.fw_name_pre = IWL_BNJ_B_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0 = {
-	.fw_name_pre = IWL_BNJ_B_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
-	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_fm_b0 = {
-	.fw_name_pre = IWL_SC_A_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_fm_c0 = {
-	.fw_name_pre = IWL_SC_A_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_hr_a0 = {
-	.fw_name_pre = IWL_SC_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_hr_b0 = {
-	.fw_name_pre = IWL_SC_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_gf_a0 = {
-	.fw_name_pre = IWL_SC_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0 = {
-	.fw_name_pre = IWL_SC_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_wh_a0 = {
-	.fw_name_pre = IWL_SC_A_WH_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_HR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
new file mode 100644
index 000000000000..cc6761e46bee
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2023 Intel Corporation
+ */
+#include <linux/module.h>
+#include <linux/stringify.h>
+#include "iwl-config.h"
+#include "iwl-prph.h"
+#include "fw/api/txq.h"
+
+/* Highest firmware API version supported */
+#define IWL_AX210_UCODE_API_MAX	82
+
+/* Lowest firmware API version supported */
+#define IWL_AX210_UCODE_API_MIN	39
+
+/* NVM versions */
+#define IWL_AX210_NVM_VERSION		0x0a1d
+
+/* Memory offsets and lengths */
+#define IWL_AX210_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_AX210_DCCM_LEN		0x10000 /* LMAC1 */
+#define IWL_AX210_DCCM2_OFFSET		0x880000
+#define IWL_AX210_DCCM2_LEN		0x8000
+#define IWL_AX210_SMEM_OFFSET		0x400000
+#define IWL_AX210_SMEM_LEN		0xD0000
+
+#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0-"
+#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0-"
+#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0-"
+#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
+#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
+#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0-"
+#define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
+#define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
+#define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
+#define IWL_SNJ_A_JF_B_FW_PRE		"iwlwifi-SoSnj-a0-jf-b0-"
+#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0-"
+#define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
+#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
+#define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
+#define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0-"
+#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0-"
+#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0-"
+#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0-"
+#define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0-"
+#define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0-"
+#define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
+
+#define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_SO_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SO_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_JF_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_MA_B_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
+
+static const struct iwl_base_params iwl_ax210_base_params = {
+	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
+	.num_of_queues = 512,
+	.max_tfd_queue_size = 65536,
+	.shadow_ram_support = true,
+	.led_compensation = 57,
+	.wd_timeout = IWL_LONG_WD_TIMEOUT,
+	.max_event_log_size = 512,
+	.shadow_reg_enable = true,
+	.pcie_l1_allowed = true,
+};
+
+#define IWL_DEVICE_AX210_COMMON						\
+	.ucode_api_min = IWL_AX210_UCODE_API_MIN,			\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.nvm_hw_section_num = 10,					\
+	.non_shared_ant = ANT_B,					\
+	.dccm_offset = IWL_AX210_DCCM_OFFSET,				\
+	.dccm_len = IWL_AX210_DCCM_LEN,					\
+	.dccm2_offset = IWL_AX210_DCCM2_OFFSET,				\
+	.dccm2_len = IWL_AX210_DCCM2_LEN,				\
+	.smem_offset = IWL_AX210_SMEM_OFFSET,				\
+	.smem_len = IWL_AX210_SMEM_LEN,					\
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.apmg_not_supported = true,					\
+	.trans.mq_rx_supported = true,					\
+	.vht_mu_mimo_supported = true,					\
+	.mac_addr_from_csr = 0x380,					\
+	.ht_params = &iwl_22000_ht_params,				\
+	.nvm_ver = IWL_AX210_NVM_VERSION,				\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
+	.nvm_type = IWL_NVM_EXT,					\
+	.dbgc_supported = true,						\
+	.min_umac_error_event_table = 0x400000,				\
+	.d3_debug_data_base_addr = 0x401000,				\
+	.d3_debug_data_length = 60 * 1024,				\
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	}
+
+#define IWL_DEVICE_AX210						\
+	IWL_DEVICE_AX210_COMMON,					\
+	.ucode_api_max = IWL_AX210_UCODE_API_MAX,			\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
+	.trans.base_params = &iwl_ax210_base_params,			\
+	.min_txq_size = 128,						\
+	.gp2_reg_addr = 0xd02c68,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,		\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	}
+
+const struct iwl_cfg_trans_params iwl_snj_trans_cfg = {
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+};
+
+const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	/* TODO: the following values need to be checked */
+	.xtal_latency = 500,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_200US,
+};
+
+const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg = {
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	.low_latency_xtal = true,
+	.xtal_latency = 12000,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
+const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg = {
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.umac_prph_offset = 0x300000,
+	.integrated = true,
+	.low_latency_xtal = true,
+	.xtal_latency = 12000,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+	.imr_enabled = true,
+};
+
+/*
+ * If the device doesn't support HE, no need to have that many buffers.
+ * AX210 devices can split multiple frames into a single RB, so fewer are
+ * needed; AX210 cannot (but use smaller RBs by default) - these sizes
+ * were picked according to 8 MSDUs inside 256 A-MSDUs in an A-MPDU, with
+ * additional overhead to account for processing time.
+ */
+#define IWL_NUM_RBDS_NON_HE		512
+#define IWL_NUM_RBDS_AX210_HE		4096
+
+const struct iwl_cfg_trans_params iwl_ma_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_AX210,
+	.base_params = &iwl_ax210_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000
+};
+
+const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
+const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
+const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
+const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
+
+const char iwl_ax210_killer_1675w_name[] =
+	"Killer(R) Wi-Fi 6E AX1675w 160MHz Wireless Network Adapter (210D2W)";
+const char iwl_ax210_killer_1675x_name[] =
+	"Killer(R) Wi-Fi 6E AX1675x 160MHz Wireless Network Adapter (210NGW)";
+const char iwl_ax211_killer_1675s_name[] =
+	"Killer(R) Wi-Fi 6E AX1675s 160MHz Wireless Network Adapter (211NGW)";
+const char iwl_ax211_killer_1675i_name[] =
+	"Killer(R) Wi-Fi 6E AX1675i 160MHz Wireless Network Adapter (211NGW)";
+const char iwl_ax411_killer_1690s_name[] =
+	"Killer(R) Wi-Fi 6E AX1690s 160MHz Wireless Network Adapter (411D2W)";
+const char iwl_ax411_killer_1690i_name[] =
+	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
+
+const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
+	.name = "Intel(R) Wireless-AC 9560 160MHz",
+	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+};
+
+const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
+	.name = iwl_ax211_name,
+	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
+	.name = iwl_ax211_name,
+	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.trans.xtal_latency = 12000,
+	.trans.low_latency_xtal = true,
+};
+
+const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
+	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
+	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
+	.name = iwl_ax411_name,
+	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
+	.name = iwl_ax411_name,
+	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.trans.xtal_latency = 12000,
+	.trans.low_latency_xtal = true,
+};
+
+const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
+	.name = iwl_ax411_name,
+	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
+	.name = iwl_ax211_name,
+	.fw_name_pre = IWL_SNJ_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_snj_hr_b0 = {
+	.fw_name_pre = IWL_SNJ_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_snj_a0_jf_b0 = {
+	.fw_name_pre = IWL_SNJ_A_JF_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_hr_b0 = {
+	.fw_name_pre = IWL_MA_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
+	.fw_name_pre = IWL_MA_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0 = {
+	.fw_name_pre = IWL_MA_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
+	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_ms_a0 = {
+	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_fm_a0 = {
+	.fw_name_pre = IWL_MA_B_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_hr_b0 = {
+	.fw_name_pre = IWL_MA_B_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_gf_a0 = {
+	.fw_name_pre = IWL_MA_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0 = {
+	.fw_name_pre = IWL_MA_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_mr_a0 = {
+	.fw_name_pre = IWL_MA_B_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
+	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
+	.fw_name_pre = IWL_MA_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
+	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_snj_a0_ms_a0 = {
+	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
+	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
new file mode 100644
index 000000000000..dd0270181018
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2023 Intel Corporation
+ */
+#include <linux/module.h>
+#include <linux/stringify.h>
+#include "iwl-config.h"
+#include "iwl-prph.h"
+#include "fw/api/txq.h"
+
+/* Highest firmware API version supported */
+#define IWL_BZ_UCODE_API_MAX	82
+
+/* Lowest firmware API version supported */
+#define IWL_BZ_UCODE_API_MIN	39
+
+/* NVM versions */
+#define IWL_BZ_NVM_VERSION		0x0a1d
+
+/* Memory offsets and lengths */
+#define IWL_BZ_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_BZ_DCCM_LEN			0x10000 /* LMAC1 */
+#define IWL_BZ_DCCM2_OFFSET		0x880000
+#define IWL_BZ_DCCM2_LEN		0x8000
+#define IWL_BZ_SMEM_OFFSET		0x400000
+#define IWL_BZ_SMEM_LEN			0xD0000
+
+#define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
+#define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
+#define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0-"
+#define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
+#define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
+#define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
+#define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0-"
+#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0-"
+#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0-"
+#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0-"
+#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0-"
+#define IWL_BZ_B_GF4_A_FW_PRE		"iwlwifi-bz-b0-gf4-a0-"
+#define IWL_BZ_B_FM_B_FW_PRE		"iwlwifi-bz-b0-fm-b0-"
+#define IWL_BZ_B_FM4_B_FW_PRE		"iwlwifi-bz-b0-fm4-b0-"
+#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
+#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
+#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0-"
+#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
+#define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
+#define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
+#define IWL_BNJ_B_FM4_B_FW_PRE		"iwlwifi-BzBnj-b0-fm4-b0-"
+#define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
+#define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
+#define IWL_BNJ_C_GF_A_FW_PRE		"iwlwifi-BzBnj-c0-gf-a0-"
+#define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
+#define IWL_BNJ_B_GF4_A_FW_PRE		"iwlwifi-BzBnj-b0-gf4-a0-"
+#define IWL_BNJ_C_GF4_A_FW_PRE		"iwlwifi-BzBnj-c0-gf4-a0-"
+#define IWL_BNJ_A_HR_A_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
+#define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
+#define IWL_BNJ_B_HR_A_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
+#define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
+#define IWL_BNJ_C_HR_B_FW_PRE		"iwlwifi-BzBnj-c0-hr-b0-"
+#define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
+#define IWL_BNJ_C_FM_C_FW_PRE		"iwlwifi-BzBnj-c0-fm-c0-"
+#define IWL_BNJ_A_WH_A_FW_PRE		"iwlwifi-BzBnj-a0-wh-a0-"
+#define IWL_BNJ_B_WH_A_FW_PRE		"iwlwifi-BzBnj-b0-wh-a0-"
+#define IWL_BNJ_C_WH_A_FW_PRE		"iwlwifi-BzBnj-c0-wh-a0-"
+
+#define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_HR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM_C_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_FM_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_FM4_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
+	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
+	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
+	IWL_GL_C_FM_C_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_C_GF_A_MODULE_FIRMWARE(api) \
+		IWL_BNJ_C_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_C_GF4_A_MODULE_FIRMWARE(api) \
+		IWL_BNJ_C_GF4_A_FW_PRE __stringify(api) ".ucode"
+
+#define IWL_BNJ_A_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_HR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_HR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_C_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_C_FM_C_MODULE_FIRMWARE(api) \
+	IWL_BNJ_C_FM_C_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_WH_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_WH_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_WH_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_WH_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_C_WH_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_C_WH_A_FW_PRE __stringify(api) ".ucode"
+
+static const struct iwl_base_params iwl_bz_base_params = {
+	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
+	.num_of_queues = 512,
+	.max_tfd_queue_size = 65536,
+	.shadow_ram_support = true,
+	.led_compensation = 57,
+	.wd_timeout = IWL_LONG_WD_TIMEOUT,
+	.max_event_log_size = 512,
+	.shadow_reg_enable = true,
+	.pcie_l1_allowed = true,
+};
+
+static const struct iwl_ht_params iwl_gl_a_ht_params = {
+	.stbc = false, /* we explicitly disable STBC for GL step A */
+	.ldpc = true,
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
+		      BIT(NL80211_BAND_6GHZ),
+};
+
+#define IWL_DEVICE_BZ_COMMON						\
+	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
+	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.nvm_hw_section_num = 10,					\
+	.non_shared_ant = ANT_B,					\
+	.dccm_offset = IWL_BZ_DCCM_OFFSET,				\
+	.dccm_len = IWL_BZ_DCCM_LEN,					\
+	.dccm2_offset = IWL_BZ_DCCM2_OFFSET,				\
+	.dccm2_len = IWL_BZ_DCCM2_LEN,				\
+	.smem_offset = IWL_BZ_SMEM_OFFSET,				\
+	.smem_len = IWL_BZ_SMEM_LEN,					\
+	.apmg_not_supported = true,					\
+	.trans.mq_rx_supported = true,					\
+	.vht_mu_mimo_supported = true,					\
+	.mac_addr_from_csr = 0x30,					\
+	.nvm_ver = IWL_BZ_NVM_VERSION,				\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
+	.nvm_type = IWL_NVM_EXT,					\
+	.dbgc_supported = true,						\
+	.min_umac_error_event_table = 0xD0000,				\
+	.d3_debug_data_base_addr = 0x401000,				\
+	.d3_debug_data_length = 60 * 1024,				\
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	},								\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
+	.trans.base_params = &iwl_bz_base_params,			\
+	.min_txq_size = 128,						\
+	.gp2_reg_addr = 0xd02c68,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	},								\
+	.mon_dbgi_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGI_SRAM_FIFO_POINTERS,		\
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
+		},							\
+	}
+
+#define IWL_DEVICE_BZ							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_22000_ht_params
+
+#define IWL_DEVICE_GL_A							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_gl_a_ht_params
+
+/*
+ * If the device doesn't support HE, no need to have that many buffers.
+ * These sizes were picked according to 8 MSDUs inside 256 A-MSDUs in an
+ * A-MPDU, with additional overhead to account for processing time.
+ */
+#define IWL_NUM_RBDS_NON_HE		512
+#define IWL_NUM_RBDS_BZ_HE		4096
+
+const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_BZ,
+	.base_params = &iwl_bz_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
+const char iwl_bz_name[] = "Intel(R) TBD Bz device";
+
+const struct iwl_cfg iwl_cfg_bz_a0_hr_a0 = {
+	.fw_name_pre = IWL_BZ_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
+	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_gf_a0 = {
+	.fw_name_pre = IWL_BZ_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
+	.fw_name_pre = IWL_BZ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_gf_a0 = {
+	.fw_name_pre = IWL_BZ_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0 = {
+	.fw_name_pre = IWL_BZ_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
+	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
+	.fw_name_pre = IWL_BZ_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
+	.fw_name_pre = IWL_BZ_A_FM4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm_b0 = {
+	.fw_name_pre = IWL_BZ_A_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm_c0 = {
+	.fw_name_pre = IWL_BZ_A_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
+	.fw_name_pre = IWL_BZ_A_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_fm_b0 = {
+	.fw_name_pre = IWL_BZ_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0 = {
+	.fw_name_pre = IWL_BZ_B_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
+	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_GL_A,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
+	.fw_name_pre = IWL_GL_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_gl_c0_fm_c0 = {
+	.fw_name_pre = IWL_GL_C_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
+	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0 = {
+	.fw_name_pre = IWL_BNJ_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
+	.fw_name_pre = IWL_BNJ_A_FM4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0 = {
+	.fw_name_pre = IWL_BNJ_B_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
+	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0 = {
+	.fw_name_pre = IWL_BNJ_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
+	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0 = {
+	.fw_name_pre = IWL_BNJ_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0 = {
+	.fw_name_pre = IWL_BNJ_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
+	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0 = {
+	.fw_name_pre = IWL_BNJ_B_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0 = {
+	.fw_name_pre = IWL_BNJ_B_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
+	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+};
+
+
+MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_C_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_C_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_HR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_C_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_C_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
new file mode 100644
index 000000000000..a294c88e6a65
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2023 Intel Corporation
+ */
+#include <linux/module.h>
+#include <linux/stringify.h>
+#include "iwl-config.h"
+#include "iwl-prph.h"
+#include "fw/api/txq.h"
+
+/* Highest firmware API version supported */
+#define IWL_SC_UCODE_API_MAX	82
+
+/* Lowest firmware API version supported */
+#define IWL_SC_UCODE_API_MIN	39
+
+/* NVM versions */
+#define IWL_SC_NVM_VERSION		0x0a1d
+
+/* Memory offsets and lengths */
+#define IWL_SC_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_SC_DCCM_LEN			0x10000 /* LMAC1 */
+#define IWL_SC_DCCM2_OFFSET		0x880000
+#define IWL_SC_DCCM2_LEN		0x8000
+#define IWL_SC_SMEM_OFFSET		0x400000
+#define IWL_SC_SMEM_LEN			0xD0000
+
+#define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0-"
+#define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0-"
+#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
+#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
+#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0-"
+#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0-"
+#define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0-"
+
+#define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_FM_C_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_HR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_WH_A_FW_PRE __stringify(api) ".ucode"
+
+static const struct iwl_base_params iwl_sc_base_params = {
+	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
+	.num_of_queues = 512,
+	.max_tfd_queue_size = 65536,
+	.shadow_ram_support = true,
+	.led_compensation = 57,
+	.wd_timeout = IWL_LONG_WD_TIMEOUT,
+	.max_event_log_size = 512,
+	.shadow_reg_enable = true,
+	.pcie_l1_allowed = true,
+};
+
+#define IWL_DEVICE_BZ_COMMON						\
+	.ucode_api_max = IWL_SC_UCODE_API_MAX,			\
+	.ucode_api_min = IWL_SC_UCODE_API_MIN,			\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.nvm_hw_section_num = 10,					\
+	.non_shared_ant = ANT_B,					\
+	.dccm_offset = IWL_SC_DCCM_OFFSET,				\
+	.dccm_len = IWL_SC_DCCM_LEN,					\
+	.dccm2_offset = IWL_SC_DCCM2_OFFSET,				\
+	.dccm2_len = IWL_SC_DCCM2_LEN,				\
+	.smem_offset = IWL_SC_SMEM_OFFSET,				\
+	.smem_len = IWL_SC_SMEM_LEN,					\
+	.apmg_not_supported = true,					\
+	.trans.mq_rx_supported = true,					\
+	.vht_mu_mimo_supported = true,					\
+	.mac_addr_from_csr = 0x30,					\
+	.nvm_ver = IWL_SC_NVM_VERSION,				\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
+	.nvm_type = IWL_NVM_EXT,					\
+	.dbgc_supported = true,						\
+	.min_umac_error_event_table = 0xD0000,				\
+	.d3_debug_data_base_addr = 0x401000,				\
+	.d3_debug_data_length = 60 * 1024,				\
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	},								\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
+	.trans.base_params = &iwl_sc_base_params,			\
+	.min_txq_size = 128,						\
+	.gp2_reg_addr = 0xd02c68,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	},								\
+	.mon_dbgi_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGI_SRAM_FIFO_POINTERS,		\
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
+		},							\
+	}
+
+#define IWL_DEVICE_SC							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_22000_ht_params
+
+/*
+ * If the device doesn't support HE, no need to have that many buffers.
+ * These sizes were picked according to 8 MSDUs inside 256 A-MSDUs in an
+ * A-MPDU, with additional overhead to account for processing time.
+ */
+#define IWL_NUM_RBDS_NON_HE		512
+#define IWL_NUM_RBDS_SC_HE		4096
+
+const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_BZ,
+	.base_params = &iwl_sc_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
+const char iwl_sc_name[] = "Intel(R) TBD Sc device";
+
+const struct iwl_cfg iwl_cfg_sc_a0_fm_b0 = {
+	.fw_name_pre = IWL_SC_A_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_fm_c0 = {
+	.fw_name_pre = IWL_SC_A_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_hr_a0 = {
+	.fw_name_pre = IWL_SC_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_hr_b0 = {
+	.fw_name_pre = IWL_SC_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_gf_a0 = {
+	.fw_name_pre = IWL_SC_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0 = {
+	.fw_name_pre = IWL_SC_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_wh_a0 = {
+	.fw_name_pre = IWL_SC_A_WH_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_SC_HE,
+};
+
+MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 37ae57adf950..5c6ab5b9930b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -499,6 +499,7 @@ extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
@@ -583,6 +584,7 @@ extern const struct iwl_cfg iwl105_bgn_d_cfg;
 extern const struct iwl_cfg iwl135_bgn_cfg;
 #endif /* CONFIG_IWLDVM */
 #if IS_ENABLED(CONFIG_IWLMVM)
+extern const struct iwl_ht_params iwl_22000_ht_params;
 extern const struct iwl_cfg iwl7260_2ac_cfg;
 extern const struct iwl_cfg iwl7260_2ac_cfg_high_temp;
 extern const struct iwl_cfg iwl7260_2n_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3f303ca13412..2b342e832f22 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -508,6 +508,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
+
+/* Sc devices */
+	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
 
 	{0}
-- 
2.38.1

