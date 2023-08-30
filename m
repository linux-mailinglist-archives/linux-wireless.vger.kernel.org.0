Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8B78D9D4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjH3SeN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbjH3IcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:32:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB61A6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384321; x=1724920321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZqjTlERv+/Uj0XSbLXivqm3d3bf0v09QB/YqheD9to=;
  b=QhRkj/ZTq7cnFxw+ZRcHD9zBpfu2+TOd28MOHQV1swFWvqWKp/uagB58
   I13dHX04govQV1as7rsFiB4xXi0nRNa0Ge7v1VKhTu6xLfEjpC73xObjL
   NhnwwecMX7P0R719YC6rck4dXiNLmLeapCErQEX8SF10BoAryoPWeyI1n
   aXyYZKBacor/Tve9GpOZptKAUHUAk47ewQcLPlwXYDgY7VjNgjGmNQykp
   D9quxradVS3EXYIvoMq2YZ6KSlsPQ90Dmx+zz4VlgKx5sVdBZOgNtW9cA
   5LKXpghpCV1uL9ecpQeSvQAidBbSl/G1TbBRzAvPNz/sEiXMFN6I+v7rC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959091"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959091"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152539"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152539"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/16] wifi: iwlwifi: mvm: reduce maximum RX A-MPDU size
Date:   Wed, 30 Aug 2023 11:31:02 +0300
Message-Id: <20230830112059.6e80366716ad.I19022084ac978b9960b12b205c052a83ab141203@changeid>
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

Since 1024 isn't being tested right now, allow only 512
for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
index e018946310d1..9c69d3674384 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2019-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2019-2021, 2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -76,7 +76,7 @@ enum iwl_tx_queue_cfg_actions {
 	TX_QUEUE_CFG_TFD_SHORT_FORMAT		= BIT(1),
 };
 
-#define IWL_DEFAULT_QUEUE_SIZE_EHT (1024 * 4)
+#define IWL_DEFAULT_QUEUE_SIZE_EHT (512 * 4)
 #define IWL_DEFAULT_QUEUE_SIZE_HE 1024
 #define IWL_DEFAULT_QUEUE_SIZE 256
 #define IWL_MGMT_QUEUE_SIZE 16
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5336a4afde4d..d4983abd9f97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1136,7 +1136,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		return NULL;
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		max_agg = IEEE80211_MAX_AMPDU_BUF_EHT;
+		max_agg = 512;
 	else
 		max_agg = IEEE80211_MAX_AMPDU_BUF_HE;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3b9a343d4f67..51ca99bd5117 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -827,7 +827,7 @@ static int iwl_mvm_get_queue_size(struct ieee80211_sta *sta)
 		if (!link)
 			continue;
 
-		/* support for 1k ba size */
+		/* support for 512 ba size */
 		if (link->eht_cap.has_eht &&
 		    max_size < IWL_DEFAULT_QUEUE_SIZE_EHT)
 			max_size = IWL_DEFAULT_QUEUE_SIZE_EHT;
-- 
2.38.1

