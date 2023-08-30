Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119A78D9E2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjH3SeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbjH3Ibx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5041A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384310; x=1724920310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXxmXNx/asHs7LcHT4t3OsYLl9LuBy4j4Dfc+GpA7GQ=;
  b=OgcNlxlnpnXw8d4Hu0XbWUcN1KcZcH5SHa6wEGXh4PM9gKn0oaLVDWu5
   EY0V4FOvVRqGjF/CquvCgNmXXdQXhakBv6yd/66s1XG5pqnRy2e+5VKgb
   nCBk2hB/jYEutVERrUXHqkjG0gXiQUKQebdmxmbsaNmSsR44SLWnBj/pB
   0VtIPhPJh3rVsCXT6WMstGCYQk3P3O6NlikRAZTxRZ6VPyWD5lREeYXco
   DK6qNai5Xw9c9RAFYbNOjsz8izEv6BT+3rSr6EgdvCvXwk5qjssbRwYJz
   bOFK4iFuXlruws2YeQJV1tSta/gLV3pKWzdWV9Iv8+CMG/jMqOKX5JRW4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959046"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959046"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152406"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152406"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/16] wifi: iwlwifi: fw: reconstruct the API/CAPA enum number
Date:   Wed, 30 Aug 2023 11:30:59 +0300
Message-Id: <20230830112059.44bdf6a5fa9e.I9f1ea129f89e53043d48676aed0a3b8f6c31ac08@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The last member of the enum is meant to count the items,
but sparse cannot increment the previous member due to
its bitwise type. Declaring the last entry with a value
doesn't work either (cannot mix bitwise/non-bitwise) and
declaring it with a bitwise value doesn't work due to
the way it gets used. This led to the current construct.

However, that construct the kernel-doc script doesn't
understand this construct due to the use of #ifdef/#else.

Find another solution that makes both tools happy, we
do now do declare it as the bitwise value but then just
redefine it so that doesn't get used, all still under
__CHECKER__ conditional.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 27 +++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b36e9613a52c..41841524f983 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -281,12 +281,16 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
 	IWL_UCODE_TLV_API_BAND_IN_RX_DATA	= (__force iwl_ucode_tlv_api_t)59,
 
-
-#ifdef __CHECKER__
-	/* sparse says it cannot increment the previous enum member */
-#define NUM_IWL_UCODE_TLV_API 128
-#else
 	NUM_IWL_UCODE_TLV_API
+/*
+ * This construction make both sparse (which cannot increment the previous
+ * member due to its bitwise type) and kernel-doc (which doesn't understand
+ * the ifdef/else properly) work.
+ */
+#ifdef __CHECKER__
+#define __CHECKER_NUM_IWL_UCODE_TLV_API	128
+		= (__force iwl_ucode_tlv_api_t)__CHECKER_NUM_IWL_UCODE_TLV_API,
+#define NUM_IWL_UCODE_TLV_API __CHECKER_NUM_IWL_UCODE_TLV_API
 #endif
 };
 
@@ -469,11 +473,16 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
 
-#ifdef __CHECKER__
-	/* sparse says it cannot increment the previous enum member */
-#define NUM_IWL_UCODE_TLV_CAPA 128
-#else
 	NUM_IWL_UCODE_TLV_CAPA
+/*
+ * This construction make both sparse (which cannot increment the previous
+ * member due to its bitwise type) and kernel-doc (which doesn't understand
+ * the ifdef/else properly) work.
+ */
+#ifdef __CHECKER__
+#define __CHECKER_NUM_IWL_UCODE_TLV_CAPA	128
+		= (__force iwl_ucode_tlv_capa_t)__CHECKER_NUM_IWL_UCODE_TLV_CAPA,
+#define NUM_IWL_UCODE_TLV_CAPA __CHECKER_NUM_IWL_UCODE_TLV_CAPA
 #endif
 };
 
-- 
2.38.1

