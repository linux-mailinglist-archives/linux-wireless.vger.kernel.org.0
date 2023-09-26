Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C37AE76F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjIZIH5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjIZIHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E537010A
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715668; x=1727251668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfZQ5Srpmrnx7HdS0D9tyy7H/6LupCQ5lmuwdBqc/0w=;
  b=ZuSlBcaCQ1bupzUl7U3jM8yAFPxK6+qDA8itz/v97UsSI4bJo9utCHuG
   dN/0Yn5ihayoq6ACbTm0FxF0KzkgK9Y+S6l1IrezGaRwcx0wosDQRspPA
   CnE391nOKVVqqG4zisR45RYKlIfZxzA2UtM2FHL3lHiBnpp2gv0dqaoy6
   KHLxTyCgx4PaL3DapwprcSvWwsq9xYGdEdEy0Srz7x0jMOsfy0USpdkSx
   HXIpB4AAZBDA/4C4MR6Pq2v97in689iZd72+TOALOVaCu3FOi5uKAYMkL
   nEDj6z/WMg44u5pZwqXcJn8PgzMk+CZYF5Gn6t/NknI3nACbt7Qh7JgtJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797269"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369291"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369291"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/9] wifi: iwlwifi: mvm: fix removing pasn station for responder
Date:   Tue, 26 Sep 2023 11:07:18 +0300
Message-Id: <20230926110319.7eb353abb95c.I2b30be09b99f5a2379956e010bafaa465ff053ba@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In case of MLD operation the station should be removed using the
mld api.

Fixes: fd940de72d49 ("wifi: iwlwifi: mvm: FTM responder MLO support")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index b49781d1a07a..10b9219b3bfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -302,7 +302,12 @@ static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
 				      struct iwl_mvm_pasn_sta *sta)
 {
 	list_del(&sta->list);
-	iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+
+	if (iwl_mvm_has_mld_api(mvm->fw))
+		iwl_mvm_mld_rm_sta_id(mvm, sta->int_sta.sta_id);
+	else
+		iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+
 	iwl_mvm_dealloc_int_sta(mvm, &sta->int_sta);
 	kfree(sta);
 }
-- 
2.38.1

