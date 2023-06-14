Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0B72F9AF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjFNJpx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjFNJoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FCA2695
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735824; x=1718271824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BAUMMwRzRIyIyHt69qxq4Ty6e2cDqBpe7qGybjuo7Ds=;
  b=I/G5E+UpUqm66XXBIoX8lN87a69gW32lnYL+nSZLsIAVUpNZEJK0kRYM
   ynh3mnfprewHkvtqNzTUJPTa7Ej5JeWLBDWmdJhRdD/8XIwmYi99PYj9z
   5GIWC4pIRXKDYL5tq5Hf8OOG0c1XVMvLUVIiH4+OapNpBrPdJCsrR23Lg
   Q6v8H6tKSJd7IPcxTJDH2PancrBVgP2XzskWWQn0ufFbVuHcbzrOARFyX
   EY9X9mqfdYzhZleooL7Oh63q3TS5IadTrg8UcwApod9DTjXW5OZHoj93g
   wy7tdqRNZD8+BFMJ7OjprPPHtBPCIrb24b+fYLJR4Ny1qJ3UhV0euxr3m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049853"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989848"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989848"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/20] wifi: iwlwifi: mvm: add a few NULL pointer checks
Date:   Wed, 14 Jun 2023 12:41:25 +0300
Message-Id: <20230614123446.e47b0192c78f.I67fa9f07cd1c8b3bdc8db25f5e31c1c680c49745@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

We've observed that in some botched firmware restart scenarios
when the firmware crashes again while we're reconfiguring, we
can hit NULL pointer crashes here. The underlying issue is the
botched restart which we need to fix separately, but until we
can do that, don't crash hard here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 6 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 059ede6f7b65..954ea9ac8e5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1111,6 +1111,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 	beacon_cmd.flags = cpu_to_le16(flags);
 	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
+
+	if (WARN_ON(!mvmvif->link[link_conf->link_id]))
+		return -EINVAL;
+
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD, 0) > 12)
 		beacon_cmd.link_id =
 			cpu_to_le32(mvmvif->link[link_conf->link_id]->fw_link_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index bb8868cd4396..524852cf5cd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include "mvm.h"
 #include "time-sync.h"
@@ -369,6 +369,9 @@ int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN_ON(!link))
+		return -EIO;
+
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_ADHOC:
@@ -398,6 +401,9 @@ int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN_ON(!link))
+		return -EIO;
+
 	return iwl_mvm_mld_rm_int_sta(mvm, &link->mcast_sta, true, 0,
 				      &link->cab_queue);
 }
-- 
2.38.1

