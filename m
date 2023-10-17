Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031737CBEC3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjJQJR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjJQJRZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E166102
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534242; x=1729070242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZ9JYoD7m1kKkUUuh7WagtJe5jacEAGtQMmsEQ+4IwE=;
  b=e6tu8m0yinznJgyf/xNQlCJ7a44k+GxbasJCTD5Jet+d8HWfaYS+FV+s
   2dmMbB+5yWVG9UGJaud70CDygoKzhD6YhzUeP30kgo+U3ZODsXfUi0w0S
   k0/a2k70BImROdZy6vTL+PpxaXsHFnJYyrO9Qt++xbMh8fnUN4K67yW6t
   EO3Ue8Hr5VWb1UieHQMAK+6JNJAEzJBPUI0bZZItcKDW4m6Vpx4M3RL6e
   NvESLktxuxUHCiRxWrw0R19jukCtitURzXYsuQgOVVyDqbyeLmvb4e4ak
   oDRBeov5cABSfIbCHMZUhdXfkd68MSTqAZ9IQX/Qdf4UTuzKaJkKHgmhD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808554"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731934"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731934"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: fix size check for fw_link_id
Date:   Tue, 17 Oct 2023 12:16:44 +0300
Message-Id: <20231017115047.3385bd11f423.I2d30fdb464f951c648217553c47901857a0046c7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Check that fw_link_id does not exceed the size of link_id_to_link_conf
array. There's no any codepath that can cause that, but it's still
safer to verify in case fw_link_id gets corrupted.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index d0d5ebc03d53..c3831440a019 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -60,7 +60,7 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
 		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
 								    mvmvif);
-		if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+		if (link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf))
 			return -EINVAL;
 
 		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
@@ -243,7 +243,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	int ret;
 
 	if (WARN_ON(!link_info ||
-		    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		    link_info->fw_link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
 		return -EINVAL;
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
-- 
2.38.1

