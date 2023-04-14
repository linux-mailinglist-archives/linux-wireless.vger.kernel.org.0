Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E96E2080
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNKPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDNKPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:15:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D47EF7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467284; x=1713003284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKUAhYuwGXOZwa88YMhqaI8z5wL1DUakhtT7A0ydxyo=;
  b=NmTpHs3UbG/ZSs7mkTXvLVvXtKxQb6XnOFqQ3YzOD6PT0O4S0+ub/4k4
   gCN/ysHMPXP5MdccvXjQIi6RNz42bTT16Yx+jsstLtXijhVWgxX39qz8A
   VSGtAUiiaFp2cQgao14uMJJV4BOzU9I4C2iopJfq67hqt1FdrjwzTEEOK
   +QlKlnCqvyFCyuxw4VW4WWAOA6zCAyC0nH0L2Yc6c/RwJx1pRDdTrT370
   dR8k+ULoYiwtQi2ckLcWGC88bcfNRA3j0tfhGaHbX24seJX0LNS7jpX8F
   GOj+Kty65GM/lMtv8w7aXT8MThh8WoagAW7ZuNOc+0VKKOso6D/WQbe1D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263655"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351783"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351783"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: make iwl_mvm_mac_ctxt_send_beacon() static
Date:   Fri, 14 Apr 2023 13:12:01 +0300
Message-Id: <20230414130637.3c018c15f948.I87fd1aee288f33312a7206492608002d4e8e213e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We never needed this to be non-static, that was just an
artifact of the development process. Make it static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 82fad042a281..962d8c286fd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1102,10 +1102,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 						sizeof(beacon_cmd));
 }
 
-int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 struct sk_buff *beacon,
-				 struct ieee80211_bss_conf *link_conf)
+static int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct sk_buff *beacon,
+					struct ieee80211_bss_conf *link_conf)
 {
 	if (WARN_ON(!beacon))
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f435260af519..a4f8b5a04c64 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1780,10 +1780,6 @@ int iwl_mvm_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mac_ctxt_beacon_changed(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *link_conf);
-int iwl_mvm_mac_ctxt_send_beacon(struct iwl_mvm *mvm,
-				 struct ieee80211_vif *vif,
-				 struct sk_buff *beacon,
-				 struct ieee80211_bss_conf *link_conf);
 int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
 				     struct sk_buff *beacon,
 				     void *data, int len);
-- 
2.38.1

