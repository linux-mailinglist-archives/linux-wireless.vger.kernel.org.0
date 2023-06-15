Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86F730FAC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbjFOGtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbjFOGtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA9297A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811660; x=1718347660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=maUps9EuPk3i9vmcZ465mRTYe8lQKvD7Y42QduKC/Ws=;
  b=Ahi0q9YxfrZCaRPW3PgatP4fQU17ravvZWsVd9itPRY5ar4Tx8FMzJ5O
   9bP1Ekeinxdu0z3g7SwHHTWYO/pRVylVh78YuzhOMXtgoGMZJDSJ/Krxr
   K7nnu+i7pw1b3fbZmt4X7dHr0EYfkI3Y4t+LqM1xjrlo0t1D+lG+SDI/+
   A8/LyKJrRSVpl5g6zxZbWyaOOqy2pjPUQbiBJDauAHCIyu68rSktMXEDr
   WdLGnH+Piz/k3jlGTF6uIhq2bji2Ux0A2gmesDoaVQaRNxF1yUExCahIq
   k3KmBE4kGFk1vD6aWoqI8l4WHbYObglYZE3hdDot9VE7iYwGemqdq+Mf6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212245"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395958"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395958"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/5] wifi: iwlwifi: mvm: Don't access vif valid links directly
Date:   Thu, 15 Jun 2023 09:47:18 +0300
Message-Id: <20230615094410.61ca688cbbf1.Ic1b4049cf156238ff16e6c57959004da911cb5c8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230615064720.459645-1-gregory.greenman@intel.com>
References: <20230615064720.459645-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

And instead use the vif getter functions, as a preparation for
supporting disabled/dormant links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a2583d045525..b8143ae8b403 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -893,7 +893,7 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 	u8 rate;
 	u32 i;
 
-	if (link_id == IEEE80211_LINK_UNSPECIFIED && vif->valid_links) {
+	if (link_id == IEEE80211_LINK_UNSPECIFIED && ieee80211_vif_is_mld(vif)) {
 		for (i = 0; i < ARRAY_SIZE(mvmvif->link); i++) {
 			if (!mvmvif->link[i])
 				continue;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index b27f6a70f8d1..2c9f2f71b083 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -42,7 +42,7 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	 * Of course the same can be done during add as well, but we must do
 	 * it during remove, since we don't have the mvmvif->ap_sta pointer.
 	 */
-	if (!sta && (keyconf->link_id >= 0 || !vif->valid_links))
+	if (!sta && (keyconf->link_id >= 0 || !ieee80211_vif_is_mld(vif)))
 		return BIT(link_info->ap_sta_id);
 
 	/* STA should be non-NULL now, but iwl_mvm_sta_fw_id_mask() checks */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 0ff99deb0ae7..f313a8d771e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include "mvm.h"
 
@@ -50,7 +50,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	 * the association response successfully, so just skip all that
 	 * and enable both when we have MLO.
 	 */
-	if (vif->valid_links) {
+	if (ieee80211_vif_is_mld(vif)) {
 		iwl_mvm_mld_set_he_support(mvm, vif, cmd);
 		cmd->eht_support = cpu_to_le32(1);
 		return;
-- 
2.38.1

