Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB56CD29B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjC2HIa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjC2HI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A12D55
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073687; x=1711609687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xh9xp0WnvQR60DF5DQbDh+WIsRecYyDSZMoR45IdGa4=;
  b=LQ8JdUeZu9giOv/Fitt2t/rFqFCk5NxR0hMFWriAy/VQQchGjODf9A0r
   bkSZghT7GlNvMbq7JmMc0jKSNv6uUg9EaeLS1LTjuIVBPJJXeOdaRleSd
   tErppL+eq8KgqK7ezEMLozNp/47ypkPCJ78NcC4Z4TkOdRO4M7bt7Tkl+
   TSuVOJXCg/yq7+9yis2wM+GLaJszMng0eMmsZFLTrFOlkQIIjdJACJULT
   EhJXU8PDbF8I+Vk7SerOhg56M+P2/bn7OFWt5lbmNBrDUAhyUk5sPPXPx
   Ot4gwlncZnLuAUQ2znmATF0RbxVmR77P2lg6F9PEwfdzZ2jTsYpuzbec7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450952"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450952"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111421"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111421"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 25/34] wifi: iwlwifi: mvm: clean up mac_id vs. link_id in MLD sta
Date:   Wed, 29 Mar 2023 10:05:31 +0300
Message-Id: <20230329100040.3def62de34b5.I10c9cf5dbfd1fc1e9c9c7d6d4cefcf0c08f1f2da@changeid>
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

Here we always have a link ID, not MAC ID, so clean up the
naming.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index b3377b4d7924..4d713c78b508 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -21,8 +21,7 @@ static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 					 struct iwl_mvm_int_sta *sta,
-					 const u8 *addr,
-					 u16 mac_id)
+					 const u8 *addr, int link_id)
 {
 	struct iwl_mvm_sta_cfg_cmd cmd;
 
@@ -31,7 +30,7 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.sta_id = cpu_to_le32((u8)sta->sta_id);
 
-	cmd.link_id = cpu_to_le32(mac_id);
+	cmd.link_id = cpu_to_le32(link_id);
 
 	cmd.station_type = cpu_to_le32(sta->type);
 
@@ -94,7 +93,7 @@ static int iwl_mvm_add_aux_sta_to_fw(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 					      struct iwl_mvm_int_sta *sta,
-					      const u8 *addr, int mac_id,
+					      const u8 *addr, int link_id,
 					      u16 *queue, u8 tid,
 					      unsigned int *_wdg_timeout)
 {
@@ -106,9 +105,9 @@ static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 		return -ENOSPC;
 
 	if (sta->type == STATION_TYPE_AUX)
-		ret = iwl_mvm_add_aux_sta_to_fw(mvm, sta, mac_id);
+		ret = iwl_mvm_add_aux_sta_to_fw(mvm, sta, link_id);
 	else
-		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, mac_id);
+		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, link_id);
 	if (ret)
 		return ret;
 
@@ -135,7 +134,7 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
 				   struct iwl_mvm_int_sta *int_sta, u16 *queue,
 				   enum nl80211_iftype iftype,
 				   enum iwl_fw_sta_type sta_type,
-				   int mac_id, const u8 *addr, u8 tid,
+				   int link_id, const u8 *addr, u8 tid,
 				   unsigned int *wdg_timeout)
 {
 	int ret;
@@ -148,7 +147,7 @@ static int iwl_mvm_mld_add_int_sta(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, int_sta, addr, mac_id,
+	ret = iwl_mvm_mld_add_int_sta_with_queue(mvm, int_sta, addr, link_id,
 						 queue, tid, wdg_timeout);
 	if (ret) {
 		iwl_mvm_dealloc_int_sta(mvm, int_sta);
@@ -254,8 +253,8 @@ int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 {
 	lockdep_assert_held(&mvm->mutex);
 
-	/* In CDB NICs we need to specify which lmac to use for aux activity
-	 * using the mac_id argument place to send lmac_id to the function
+	/* In CDB NICs we need to specify which lmac to use for aux activity;
+	 * use the link_id argument place to send lmac_id to the function.
 	 */
 	return iwl_mvm_mld_add_int_sta(mvm, &mvm->aux_sta, &mvm->aux_queue,
 				       NL80211_IFTYPE_UNSPECIFIED,
-- 
2.38.1

