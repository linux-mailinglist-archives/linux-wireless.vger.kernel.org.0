Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5623072F994
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjFNJp0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbjFNJoo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74BC1FF9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735813; x=1718271813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYKrV3Ei0OiHHG99fjlvjcdu6yrfQw65jF4g95FJFRg=;
  b=T/PbmdbkfAHU++GPMgq8kNDkD0h7F5JHbrFQiyVBOZ7/iqVl9lRplZLt
   ILhqY3IXFIKuAvqZm0GhO0rXW3ni4ADrz3VReQg2tFvXO+oPIIYmM1m88
   lPEuQSAQowcZqYnF1IJYsTqJ+gpfXo9OEAjhAH09RTlz+09mIwme4w+F3
   24uteXE84+yJEmg5CAKiI1jSlCHZZYzCA9EXOaZ2B5aJvRNdD5RiUzYPj
   Q8J3ohaxTwwjYkgFKGu1BhaxQC9mZtfNe5QUrPA+pNdLv/DA9KwFlJ+e1
   DJQcdvooB+81U9z4/pkveoq9Qa47lUAg0ZWAvkRjy2sLxS5NUZLDVUc5F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049849"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989838"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989838"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ariel Malamud <ariel.malamud@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/20] wifi: iwlwifi: fw: Add new FSEQ defines to fw dump
Date:   Wed, 14 Jun 2023 12:41:24 +0300
Message-Id: <20230614123446.f40dc9c810a8.I26227900d0b7e9a71fefe5cbf57cf6b46ee44413@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ariel Malamud <ariel.malamud@intel.com>

On fw error dump, dmesg prints FSEQ register data. Add 4
additional prints in order to match those being dumped
by Windows driver. Allows fw infra to correctly detect
version mismatch.

Signed-off-by: Ariel Malamud <ariel.malamud@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 23388261e97f..5876f917e536 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -467,6 +467,10 @@ static void iwl_fwrt_dump_fseq_regs(struct iwl_fw_runtime *fwrt)
 		FSEQ_REG(CNVR_AUX_MISC_CHIP),
 		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
 		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
+		FSEQ_REG(FSEQ_PREV_CNVIO_INIT_VERSION),
+		FSEQ_REG(FSEQ_WIFI_FSEQ_VERSION),
+		FSEQ_REG(FSEQ_BT_FSEQ_VERSION),
+		FSEQ_REG(FSEQ_CLASS_TP_VERSION),
 	};
 
 	if (!iwl_trans_grab_nic_access(trans))
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 0dfe00eae05d..6dd381ff0f9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -486,6 +486,10 @@ enum {
 #define FSEQ_ALIVE_TOKEN		0xA340F0
 #define FSEQ_CNVI_ID			0xA3408C
 #define FSEQ_CNVR_ID			0xA34090
+#define FSEQ_PREV_CNVIO_INIT_VERSION	0xA34084
+#define FSEQ_WIFI_FSEQ_VERSION		0xA34040
+#define FSEQ_BT_FSEQ_VERSION		0xA34044
+#define FSEQ_CLASS_TP_VERSION		0xA34078
 
 #define IWL_D3_SLEEP_STATUS_SUSPEND	0xD3
 #define IWL_D3_SLEEP_STATUS_RESUME	0xD0
-- 
2.38.1

