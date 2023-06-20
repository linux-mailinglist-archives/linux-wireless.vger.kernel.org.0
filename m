Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1A7368C2
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjFTKFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFTKEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DA130
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255485; x=1718791485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6zleulbu3g8glQJ8qWAhyXNPkWxuSFu4Yq0LnSBJm4=;
  b=DibIzF0+yIr9hLu6KcI6kAUVwKbPizyDKK0V3BSZnFeZb29zHVEBammC
   5qn7QFTJJF/LsqM7TYiN8KI7BwdLmmbnZUveEtvliJzlcXDKf1EOaSTiA
   5ico7aMmZe2HRf20s8UGIvcb3P8/DN1L/+ax0ukc0AXYVWJrftjAxY+ld
   gTeTaRVkO5lVBJheuaX+O4m9fUUFKHynF04wcS21Z3miuEzdgRmCfgSWD
   1HdLApI4GpZDelU5nshxTc6eV9o9HiVjrbhPW9mnWDCZgmnmHKbofrL9+
   GJauJ27zqDlcmACXlLQcN19aXbW6jNqDad8kkDqQigzBLK257YLFXBQBZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819623"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143537"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143537"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/19] wifi: iwlwifi: remove disable_dummy_notification
Date:   Tue, 20 Jun 2023 13:03:57 +0300
Message-Id: <20230620125813.e7c96d0aa805.I5b158ce15e48393d2896c0bff9f644d983f0e92d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This struct member is read-only, so can never change away
from the default value of zero. Remove the code that's in
an if on the value, since it's effectively dead code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c     | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 17c357634455..115ea8d9198a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -388,7 +388,6 @@ struct iwl_cfg {
 	    high_temp:1,
 	    mac_addr_from_csr:10,
 	    lp_xtal_workaround:1,
-	    disable_dummy_notification:1,
 	    apmg_not_supported:1,
 	    vht_mu_mimo_supported:1,
 	    cdb:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 98f330fcf678..30d4233595e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2013-2014, 2018-2019, 2022 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2019, 2022-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #include "mvm.h"
@@ -180,9 +180,6 @@ static int iwl_mvm_sf_config(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	};
 	int ret = 0;
 
-	if (mvm->cfg->disable_dummy_notification)
-		sf_cmd.state |= cpu_to_le32(SF_CFG_DUMMY_NOTIF_OFF);
-
 	/*
 	 * If an associated AP sta changed its antenna configuration, the state
 	 * will remain FULL_ON but SF parameters need to be reconsidered.
-- 
2.38.1

