Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D148178D9AD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjH3Sdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbjH3Ib4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49DA1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384313; x=1724920313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9AFkqEuLv0kuG0OasZPDrkpVge1utT516P8P3umLdhE=;
  b=g3xqFH/Dbtq8abS4+/L12/Hd34oUmgnwkEK7ohPTCymLzHWBXTVL8VqZ
   8TFrQ3VkT1kCFh5DDHNfM7MskBF2Y7RcgiasGjpVQ7NswbWJaPFMjMd+i
   vacZGCzhnBa2HhqpoQiOwv5nldWdLu2i1BgxcHMiQ/ojVu6WRkYxsoVCV
   gqgrpRs0I8mw0feIqR96hRvLhoTKs0yZ5WqrQx1tAkb6xXe4AppXwY5Ug
   pJDYkSBVGMaJUaybOamcFRi2AQ4tP4+BH/yIndQygmNCSeUFNsPjTwsbh
   MBEX2ufbdj1G29DIeRqYMfSQ68g/+UWG+FG+j/Iv1sp3cNQiv4KNRnMmN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959072"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152468"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152468"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Youhan Kim <youhank@qti.qualcomm.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/16] wifi: iwlwifi: mvm: move RU alloc B2 placement
Date:   Wed, 30 Aug 2023 11:31:00 +0300
Message-Id: <20230830112059.dec7f1e07ff8.I623fee2d710cc7b6f392d65b708883ed58632b45@changeid>
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

The firmware was trying to report the B2 RU allocation in
the place previously used here as well, but there's a HW
block that clears the lower 8 bits in this metadata word
even in sniffer mode. Thus, firmware moved B2 to another
place, follow that.

There's no need to detect the version since moving it to
the other place if firmware didn't just means that we'll
continue to report the (erroneous) zero value, and it's
not really something we can detect from the firmware now.

While debugging this we realized that the comments about
placement in the metadata dwords are wrong, update them.

Reported-by: Youhan Kim <youhank@qti.qualcomm.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 16 +++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 25e2e23dce3d..e71f29d0c694 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -371,7 +371,7 @@ enum iwl_rx_phy_eht_data1 {
 	IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B1_B7		= 0x0000fe00,
 };
 
-/* goes into Metadata DW 7 */
+/* goes into Metadata DW 7 (Qu) or 8 (So or higher) */
 enum iwl_rx_phy_he_data2 {
 	/* info type: HE MU-EXT */
 	/* the a1/a2/... is what the PHY/firmware calls the values */
@@ -387,7 +387,7 @@ enum iwl_rx_phy_he_data2 {
 	IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE4		= 0x0000f000,
 };
 
-/* goes into Metadata DW 8 */
+/* goes into Metadata DW 8 (Qu) or 7 (So or higher) */
 enum iwl_rx_phy_he_data3 {
 	/* info type: HE MU-EXT */
 	IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU1		= 0x000000ff, /* c1 */
@@ -408,10 +408,9 @@ enum iwl_rx_phy_he_he_data4 {
 	IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK	= 0x0600,
 };
 
-/* goes into Metadata DW 7 */
+/* goes into Metadata DW 8 (Qu has no EHT) */
 enum iwl_rx_phy_eht_data2 {
 	/* info type: EHT-MU-EXT */
-	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_0_OUT */
 	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A1	= 0x000001ff,
 	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_A2	= 0x0003fe00,
 	IWL_RX_PHY_DATA2_EHT_MU_EXT_RU_ALLOC_B1	= 0x07fc0000,
@@ -420,11 +419,10 @@ enum iwl_rx_phy_eht_data2 {
 	IWL_RX_PHY_DATA2_EHT_TB_EXT_TRIG_SIGA1	= 0xffffffff,
 };
 
-/* goes into Metadata DW 8 */
+/* goes into Metadata DW 7 (Qu has no EHT) */
 enum iwl_rx_phy_eht_data3 {
+	/* note: low 8 bits cannot be used */
 	/* info type: EHT-MU-EXT */
-	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_1_OUT */
-	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_B2	= 0x000001ff,
 	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_C1	= 0x0003fe00,
 	IWL_RX_PHY_DATA3_EHT_MU_EXT_RU_ALLOC_C2	= 0x07fc0000,
 };
@@ -432,10 +430,10 @@ enum iwl_rx_phy_eht_data3 {
 /* goes into Metadata DW 4 */
 enum iwl_rx_phy_eht_data4 {
 	/* info type: EHT-MU-EXT */
-	/* OFDM_RX_VECTOR_COMMON_RU_ALLOC_2_OUT */
 	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_D1	= 0x000001ff,
 	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_D2	= 0x0003fe00,
 	IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS	= 0x000c0000,
+	IWL_RX_PHY_DATA4_EHT_MU_EXT_RU_ALLOC_B2	= 0x1ff00000,
 };
 
 /* goes into Metadata DW 16 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8d1e44fd9de7..f0e0b91880a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1507,7 +1507,7 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 #define IWL_RX_RU_DATA_A1			2
 #define IWL_RX_RU_DATA_A2			2
 #define IWL_RX_RU_DATA_B1			2
-#define IWL_RX_RU_DATA_B2			3
+#define IWL_RX_RU_DATA_B2			4
 #define IWL_RX_RU_DATA_C1			3
 #define IWL_RX_RU_DATA_C2			3
 #define IWL_RX_RU_DATA_D1			4
-- 
2.38.1

