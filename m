Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88ED6E5D5F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDRJ2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjDRJ2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2D6E9A
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810125; x=1713346125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZeCQ9QZjI44bA+BZ/AJPTyel4EyruHRc09GSs4Xi1D0=;
  b=Atrnt9E43G7VbsqeohPM7GSa9nOmo8pdPbIb2u0b/qDIjl47kse7pIby
   9nuE867eiQhUC0hxRMY1WepyRaImZZvU+mToP4QB+/NYZi/LJujG9R3vK
   ICp5nYW6tBVrVU+1uAsHkLbYT9JE2Ivq4oJc/Shp5rPI91D0zmcF2/udz
   4aRNpe9glmPEmjZGipOkePjXXyKn+7Ee8cuAFoglz7X+XklTYkuGiVSfL
   +qoun+824HWrzRcTNb99Iaf3aML0mspx7b/ZwKpJBbK6H/ZATU2YgH35D
   8emc0ksSg6ZAreIBTglOmyNhazZUhW1b86wSmxans6Cl9FMZIN90xT6IM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341192"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511249"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511249"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: mei: make mei filtered scan more aggressive
Date:   Tue, 18 Apr 2023 12:28:12 +0300
Message-Id: <20230418122405.47e383b10b18.I14340a118acdb19ecb7214e7ff413054c77bd99c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When mei filtered scan is performed, it must find the AP on the first
scan, otherwise CSME will take the ownership of the NIC.
Make this scan more aggressive by scanning the channel the AP is
supposed to be on (as reported by CSME) several times.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index fe7cb33d5593..175615755d9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -45,6 +45,9 @@
 /* minimal number of 2GHz and 5GHz channels in the regular scan request */
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_MIN_CHANS 4
 
+/* Number of iterations on the channel for mei filtered scan */
+#define IWL_MEI_SCAN_NUM_ITER	5U
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -2665,6 +2668,7 @@ static void iwl_mvm_mei_limited_scan(struct iwl_mvm *mvm,
 	struct iwl_mvm_csme_conn_info *info = iwl_mvm_get_csme_conn_info(mvm);
 	struct iwl_mei_conn_info *conn_info;
 	struct ieee80211_channel *chan;
+	int scan_iters, i;
 
 	if (!info) {
 		IWL_DEBUG_SCAN(mvm, "mei_limited_scan: no connection info\n");
@@ -2690,8 +2694,16 @@ static void iwl_mvm_mei_limited_scan(struct iwl_mvm *mvm,
 		return;
 	}
 
-	params->n_channels = 1;
-	params->channels[0] = chan;
+	/* The mei filtered scan must find the AP, otherwise CSME will
+	 * take the NIC ownership. Add several iterations on the channel to
+	 * make the scan more robust.
+	 */
+	scan_iters = min(IWL_MEI_SCAN_NUM_ITER, params->n_channels);
+	params->n_channels = scan_iters;
+	for (i = 0; i < scan_iters; i++)
+		params->channels[i] = chan;
+
+	IWL_DEBUG_SCAN(mvm, "Mei scan: num iterations=%u\n", scan_iters);
 
 	params->n_ssids = 1;
 	params->ssids[0].ssid_len = conn_info->ssid_len;
-- 
2.38.1

