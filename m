Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8078D9C8
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH3SeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbjH3IcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:32:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0D1B1
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384323; x=1724920323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xlIni+sNE1xLxDhktWmbcYCwkrcCNwGzWHWcKRiBT/0=;
  b=VG4bdl/Sz0TybGIj7bZr8stWbQgJaKWp916Vv3mJ5Rum1g9r6KBEZDN+
   dK9Wa23pvt3lJzDbss4T+37Eak+s9DF1imgsMWy9f/4QmsmjGVmGMsnWx
   QVczh4qJThp/Ht6AwoqLAapn5bAH80WAO5o0nK8RfWB26/xY66qEnLhAc
   IoaGcKSPgmAvRbDIOgV0VChT0OrregDHBpFfJzcn+b7W7DfjtL7vxO3kQ
   nW0bj83sP8jDSH793IWVX660MmNv5Ki+0L/1Y0U109WHU8zGPcI/GLL9d
   rQpdPUeAaNz8007jZGQoVj0orxy0bEkVldnGbHx3ZnfG02saPu6jbq3gp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959107"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152584"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152584"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:32:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/16] wifi: iwlwifi: increase number of RX buffers for EHT devices
Date:   Wed, 30 Aug 2023 11:31:04 +0300
Message-Id: <20230830112059.824e522927f1.Ie5b4a2d3953072b9d76054ae67e2e45900d6bba4@changeid>
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

EHT devices can support 512 MPDUs in an A-MPDU, each of
which might be an A-MSDU and thus further contain multiple
MSDUs, which need their own buffer each. Increase the number
of buffers to avoid running out in high-throughput scenarios.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c |  8 +++-----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b9893b22e41d..3d223014cfe6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -134,12 +134,10 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.ht_params = &iwl_gl_a_ht_params
 
 /*
- * If the device doesn't support HE, no need to have that many buffers.
- * These sizes were picked according to 8 MSDUs inside 256 A-MSDUs in an
+ * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
  * A-MPDU, with additional overhead to account for processing time.
  */
-#define IWL_NUM_RBDS_NON_HE		512
-#define IWL_NUM_RBDS_BZ_HE		4096
+#define IWL_NUM_RBDS_BZ_EHT		(512 * 16)
 
 const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
@@ -161,7 +159,7 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
 const struct iwl_cfg iwl_cfg_gl = {
@@ -169,7 +167,7 @@ const struct iwl_cfg iwl_cfg_gl = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
+	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index ad283fd22e2a..d6243025993e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -127,12 +127,10 @@ static const struct iwl_base_params iwl_sc_base_params = {
 	.ht_params = &iwl_22000_ht_params
 
 /*
- * If the device doesn't support HE, no need to have that many buffers.
- * These sizes were picked according to 8 MSDUs inside 256 A-MSDUs in an
+ * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
  * A-MPDU, with additional overhead to account for processing time.
  */
-#define IWL_NUM_RBDS_NON_HE		512
-#define IWL_NUM_RBDS_SC_HE		4096
+#define IWL_NUM_RBDS_SC_EHT		(512 * 16)
 
 const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
@@ -154,7 +152,7 @@ const struct iwl_cfg iwl_cfg_sc = {
 	.uhb_supported = true,
 	IWL_DEVICE_SC,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
+	.num_rbds = IWL_NUM_RBDS_SC_EHT,
 };
 
 MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
-- 
2.38.1

