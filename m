Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8486424B7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiLEIgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiLEIgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0017047
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229393; x=1701765393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UT0DnXXiwbhkcmfGQ+hNHyz7+SYY1EjgP+Nu7YoH0Lw=;
  b=AtZ4rGV5k8DFNbGQGikLvUCNYaxUNRUc+K/rsr+7910i8rZaP37DU3Ov
   zVNevftTp/S7BORRGBB+ApEqHNIElTOsTDpm+k2Isa/JLJVwoSgLLArCv
   YGkAsCF2KNQu6YZKQ8bVp1swImIcKaBFG+94ugJ2/Xg/qZa0jMVxod2SD
   Trc9pjcFXgbfyzrF6CIkMi4tyjFJIHVi74cYQOsQgCL8AyvMvMHj1RAsu
   SZKAHI+njy2w0bEtDnrknrcrKTXUFHAs/OTxZ9O1JOjkRnGPexaBeVU6i
   9mszIoNpvkRx1CCsCzQ8E7/LZmOHkUSz/APc31ld9gmo7yZYWhC4iIaBu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323112"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323112"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100392"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100392"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:23 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: mvm: replace usage of found with dedicated list iterator variable
Date:   Mon,  5 Dec 2022 10:35:42 +0200
Message-Id: <20221205102808.e4882dc35543.I32b2b945ba234de72ee119fc20f5b8be02b6a3f2@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jakob Koschel <jakobkoschel@gmail.com>

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

While at it, stop using the unnecessary _safe() variant.

[1] https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
[change to not use _safe variant]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c   | 12 +++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c  |  7 +++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 8c5b97fb1941..6eee3d0b2157 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1010,11 +1010,10 @@ static int iwl_mvm_ftm_range_resp_valid(struct iwl_mvm *mvm, u8 request_id,
 static void iwl_mvm_ftm_rtt_smoothing(struct iwl_mvm *mvm,
 				      struct cfg80211_pmsr_result *res)
 {
-	struct iwl_mvm_smooth_entry *resp;
+	struct iwl_mvm_smooth_entry *resp = NULL, *iter;
 	s64 rtt_avg, rtt = res->ftm.rtt_avg;
 	u32 undershoot, overshoot;
 	u8 alpha;
-	bool found;
 
 	if (!IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH)
 		return;
@@ -1028,15 +1027,14 @@ static void iwl_mvm_ftm_rtt_smoothing(struct iwl_mvm *mvm,
 		return;
 	}
 
-	found = false;
-	list_for_each_entry(resp, &mvm->ftm_initiator.smooth.resp, list) {
-		if (!memcmp(res->addr, resp->addr, ETH_ALEN)) {
-			found = true;
+	list_for_each_entry(iter, &mvm->ftm_initiator.smooth.resp, list) {
+		if (!memcmp(res->addr, iter->addr, ETH_ALEN)) {
+			resp = iter;
 			break;
 		}
 	}
 
-	if (!found) {
+	if (!resp) {
 		resp = kzalloc(sizeof(*resp), GFP_KERNEL);
 		if (!resp)
 			return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index ed8ba81a6043..e403a240a82f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -376,12 +376,11 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 static int iwl_mvm_aux_roc_te_handle_notif(struct iwl_mvm *mvm,
 					   struct iwl_time_event_notif *notif)
 {
-	struct iwl_mvm_time_event_data *te_data, *tmp;
-	bool aux_roc_te = false;
+	struct iwl_mvm_time_event_data *aux_roc_te = NULL, *te_data;
 
-	list_for_each_entry_safe(te_data, tmp, &mvm->aux_roc_te_list, list) {
+	list_for_each_entry(te_data, &mvm->aux_roc_te_list, list) {
 		if (le32_to_cpu(notif->unique_id) == te_data->uid) {
-			aux_roc_te = true;
+			aux_roc_te = te_data;
 			break;
 		}
 	}
-- 
2.35.3

