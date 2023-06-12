Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54F272CAA8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjFLPvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjFLPvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:51:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF510CE
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585096; x=1718121096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D2Gh94pkpN8FJUR2yp0kV3KVimspFOfNZKYKGERWR+A=;
  b=d7iOKcg6043yuBq9fwSUlD1gBmbudcCQv7iw3WRNotETRLraaNcKd2vg
   T++OZUPohd5voGKqdra4+Dq1ErExJrwlIaQJpyt3xvByQiKss6oc1po6m
   1PTEXFVX3jzUmKtPTelBbJr8IVCwfYhXBFQ0qBmv/7giuLlk3c6UzrFaB
   hdvWwMBQSQD81iLEW+spATSUFPrVBkVCgr4MHRnGO1CYZsO8ilpFUlte4
   lhX4Mh69y4HtVQ09/Xwp461MoAqZdAOaD8iMht2V/vucfcptHqFdRTX+w
   yk408esT3NQoawhogiH6BUzsxrQsVtSOBer9fDUdJ130qOXGHAKXYP2iJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674184"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674184"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499261"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499261"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: Handle return value for iwl_mvm_sta_init
Date:   Mon, 12 Jun 2023 18:51:04 +0300
Message-Id: <20230612184434.1ecd293539e8.I5ec6aab387bb2fe743a7402581beaeb9c801d31f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

sta_init function can fail and if it returns an error then
driver should not send the request to fw to add a station.

Fixes: 69aef848052b ("wifi: iwlwifi: mvm: refactor iwl_mvm_add_sta(), iwl_mvm_rm_sta()")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index b9b9082676d4..5e11b101d02e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1859,6 +1859,8 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	ret = iwl_mvm_sta_init(mvm, vif, sta, sta_id,
 			       sta->tdls ? IWL_STA_TDLS_LINK : IWL_STA_LINK);
+	if (ret)
+		goto err;
 
 update_fw:
 	ret = iwl_mvm_sta_send_to_fw(mvm, sta, sta_update, sta_flags);
-- 
2.38.1

