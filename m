Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E497B7C47
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbjJDJhL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242052AbjJDJhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8123E5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412223; x=1727948223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asTR5MzVNnOyuC7tvBkgvpMtw4WjGXVi2Wb5u57oZ/c=;
  b=l/JUTMW1gikSKKqG5ynWsamMJ828cF5bxBm6y8mG1/IF4FPwKo4Uwn1j
   PQl9K0jO+OQTFihXGpcyjko8k44IeDNJZnlRDGcrDRmBvHQ8FPKtr+xlU
   gDli1EGUQztQ8h2i45DuCrin79xUPuyQfS1JP7yToOMcWVnQu+6bVxsGw
   D2X6PNJ/nR/xqw9QGq394XohN18h2gOx8PMxhaU3A304frljIAiHrkwld
   Bjn4eBTWexIsSskyq97d3wI87yk0ECa5S/SyiW26A4SuJFy2x50HSvkDj
   M1nfzMgHLwd+g9papf2Q+YsSKJ4Z8C4RiCW0q8t41BOzNGbB3auPGv7RC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611765"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415162"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415162"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: add a per-link debugfs
Date:   Wed,  4 Oct 2023 12:36:24 +0300
Message-Id: <20231004123422.6a161f021ae8.Ic8f40f2b4682270c94036e3c11c3996ae34266fa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add a per-link debugfs entry in iwlmvm level so we can read/write link
related parameters.
Do it by implementing the link_add_debugfs API introduced by mac80211.

Each entry will have a path like this:
.../netdev:wlan0/link-X/iwlmvm/<file_name>
for each link X.

For non-MLD vifs this callback is called when the original vif
debugfs dir is also created, so handle that case by not creating
the 'iwlmvm' directory again.

Note that we don't have to worry about the cleaning the iwlmvm/*
directory as it is already done by mac80211 when removing the link
(or netdev).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 46 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.h  |  1 +
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++
 4 files changed, 52 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 3a42fb38b32f..e8b881596baf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -761,3 +761,49 @@ void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	debugfs_remove(mvmvif->dbgfs_slink);
 	mvmvif->dbgfs_slink = NULL;
 }
+
+#define MVM_DEBUGFS_WRITE_LINK_FILE_OPS(name, bufsz)			\
+	_MVM_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz,			\
+				    struct ieee80211_bss_conf)
+#define MVM_DEBUGFS_READ_WRITE_LINK_FILE_OPS(name, bufsz)		\
+	_MVM_DEBUGFS_READ_WRITE_FILE_OPS(link_##name, bufsz,		\
+					 struct ieee80211_bss_conf)
+#define MVM_DEBUGFS_ADD_LINK_FILE(name, parent, mode)			\
+	debugfs_create_file(#name, mode, parent, link_conf,		\
+			    &iwl_dbgfs_link_##name##_ops)
+
+static void iwl_mvm_debugfs_add_link_files(struct ieee80211_vif *vif,
+					   struct ieee80211_bss_conf *link_conf,
+					   struct dentry *mvm_dir)
+{
+	/* Add per-link files here*/
+}
+
+void iwl_mvm_link_add_debugfs(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct dentry *dir)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
+	struct dentry *mvm_dir;
+
+	if (WARN_ON(!link_info) || !dir)
+		return;
+
+	if (dir == vif->debugfs_dir) {
+		WARN_ON(!mvmvif->dbgfs_dir);
+		mvm_dir = mvmvif->dbgfs_dir;
+	} else {
+		mvm_dir = debugfs_create_dir("iwlmvm", dir);
+		if (IS_ERR_OR_NULL(mvm_dir)) {
+			IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
+				dir);
+			return;
+		}
+	}
+
+	iwl_mvm_debugfs_add_link_files(vif, link_conf, mvm_dir);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
index 0711ab689c48..cc2c45b45ddc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
+ * Copyright (C) 2023 Intel Corporation
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 2a55ba01fc78..faec7ee17d9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1205,6 +1205,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.vif_add_debugfs = iwl_mvm_vif_add_debugfs,
+	.link_add_debugfs = iwl_mvm_link_add_debugfs,
 	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5ec79bea5af1..f8b95693bd98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2406,6 +2406,10 @@ void iwl_mvm_link_sta_add_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_link_sta *link_sta,
 				  struct dentry *dir);
+void iwl_mvm_link_add_debugfs(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct dentry *dir);
 #endif
 
 /* new MLD related APIs */
-- 
2.38.1

