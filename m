Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1386CD29F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjC2HIo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC2HIm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5535B6
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073706; x=1711609706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOIK2LYOwsmrqLfCpdHjNxGfzJyQIijwX+x8hznW1dY=;
  b=SC08UHvZ+YFteRr7H++jaqXgbBEqru0QYDIoAZd0ckK5e308wmlPpZtC
   VerNo2yvCMfb6wYPvbJkJqzEgLwDGHdtZLhs5+NfFqNdOfAaLCOUz2+hQ
   9ArRE5ubnrrDoX0oaMPyL9yA1mBjHPqzOJHeu6guEZK2Vg3rbQS8YP3KW
   FnluWgUPcYYDFO1/yjuiAJE6QN2E1nWNCx8gDySWNvcZD+2IYC+SdLhVA
   fUP99phC1qqUsNM1HwgdRjJdaNkkZmFHbwKR+uVTsoyrk0Kd7XRueVExB
   NojwKn7mQeTZgugcvMr1RGO2FSE4YUk2uNu3R7H0THve04QWdpgUAaBfn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320451006"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320451006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111488"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111488"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 29/34] wifi: iwlwifi: mvm: send full STA during HW restart
Date:   Wed, 29 Mar 2023 10:05:35 +0300
Message-Id: <20230329100040.62d5371bb3c7.Ie25b62125a3a022f76a36bae5fed9796c18698aa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

By using the internal station add the station is installed in
firmware with zeroed MAC addresses, which is wrong. Use the
full installation function instead, to fill all data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 4d713c78b508..26686cc7ff4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -572,10 +572,9 @@ static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
-	struct iwl_mvm_int_sta tmp_sta = {
-		.type = mvm_sta->sta_type,
-	};
-	int sta_id, ret;
+	/* no active link found */
+	int ret = -EINVAL;
+	int sta_id;
 
 	/* First add an empty station since allocating a queue requires
 	 * a valid station. Since we need a link_id to allocate a station,
@@ -598,23 +597,19 @@ static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 			continue;
 
 		sta_id = mvm_link_sta->sta_id;
-		tmp_sta.sta_id = sta_id;
-		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, &tmp_sta,
-						    vif->bss_conf.bssid,
-						    mvm_link->fw_link_id);
+		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta,
+					  link_conf, mvm_link_sta);
 		if (ret)
 			return ret;
 
 		rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
 		rcu_assign_pointer(mvm->fw_id_to_link_sta[sta_id], link_sta);
-		iwl_mvm_realloc_queues_after_restart(mvm, sta);
-
-		/* since we need only one station, no need to continue */
-		return 0;
+		ret = 0;
 	}
 
-	/* no active link found */
-	return -EINVAL;
+	iwl_mvm_realloc_queues_after_restart(mvm, sta);
+
+	return ret;
 }
 
 int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-- 
2.38.1

