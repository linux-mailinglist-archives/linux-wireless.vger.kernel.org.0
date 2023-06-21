Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C273819F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFUKOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjFUKOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20162172C
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342434; x=1718878434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkU+VW+BmS1ypF1tulJu1jol6uWoC6WbyYpDTBPJYVk=;
  b=MqjJPSBZ8GTScxdhZJsVpbdt10iGgyb/FtHqyqmDgDi2i7pwSRxPU+Qq
   nAHPjD3m+gJU18CVThHcnwhTWNYMq8B0QDFb+KV5aZEgDLvi1yx0Knp8a
   NG1zVNaVbLeImNMBigxdZ/qwFI6S8QB3VMNWwaA19SuKWMGYlYzaN+SU+
   52HmswJzcfXa17ULWMBto1y0sdeMOd5f/mD2zwWvDePkghikTnhoAWLEG
   aYGbQvnbATskVuDoo4Ff5uXoKUkowDPrm3CF8y4w2VvvVZRSTNonUKQB1
   n73NVTf6YjAfSDpryqVadWuee4VmPX3upcMw0QOW6FXvjGmRXxSn8+djT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506519"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506519"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599320"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599320"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/18] wifi: iwlwifi: cfg: clean up Bz module firmware lines
Date:   Wed, 21 Jun 2023 13:12:21 +0300
Message-Id: <20230621130444.b399b0072d72.Ie7ca1b3dcdebc929ce96a739e0d557fac2c8aeeb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove module firmware lines for images that don't exist
as well as some unused macros, and add gl-a-fm-a that
(still) exists.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 24 ++-------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 2feb47af8dda..c15dcd9bc323 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -26,35 +26,24 @@
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
 
-#define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0"
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
-#define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0"
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0"
 #define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0"
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
-#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0"
-#define IWL_BZ_B_GF4_A_FW_PRE		"iwlwifi-bz-b0-gf4-a0"
-#define IWL_BZ_B_FM_B_FW_PRE		"iwlwifi-bz-b0-fm-b0"
-#define IWL_BZ_B_FM4_B_FW_PRE		"iwlwifi-bz-b0-fm4-b0"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
-#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0"
 
-#define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_HR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_MR_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
@@ -65,14 +54,6 @@
 		IWL_BZ_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_B_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_B_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_B_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BZ_B_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_GL_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
@@ -216,16 +197,15 @@ const struct iwl_cfg iwl_cfg_gl = {
 };
 
 
-MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+
+MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-- 
2.38.1

