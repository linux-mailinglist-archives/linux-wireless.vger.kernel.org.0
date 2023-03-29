Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078776CD299
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjC2HIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC2HIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D0213A
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073682; x=1711609682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJ+ywQx4b92MwxtvKvAOsg3h/Qf1952rBdS2hX00baM=;
  b=He+NcAkIrMgbXXR7EaTBxErkLSSjvN4MDeI2gBQGpQVhQpOaKCMZVJH7
   Z50mAAaytdb8xTW5ktTNgCftdOfxPCHF6WkZZWVtKDsyptuIpwwPFwDX9
   urbvTSLCik29Brhrcp4rV+OJeehjgh1guhZ6PBDzw3rPfY8p07j/LJVbi
   8XcGEsm5/sUZY1EqoP0B9BoYnqFIQyORUALFAW/Ug+kewzG1AbOOMFdXh
   fLtBWpIQ8s+nMEvYsehN2GeAQAk64B7F1WYBJdTMsEhYAZ7XoITQmHIXX
   SVPSQFLdmiHqfftwksOhI3/AtGzMZdrVR2VX4V1+NkYuLUK67v06JolA7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450910"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111389"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111389"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 23/34] wifi: iwlwifi: mvm: initialize max_rc_amsdu_len per-link
Date:   Wed, 29 Mar 2023 10:05:29 +0300
Message-Id: <20230329100039.5bf521fe58b8.I73fe585f0ff75d41b5afd32077e3d6e48c90db2a@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Initialize max_rc_amsdu_len per-link both on state change and when a new
link is added.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 34b85a9a27af..5e382981bfa2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -998,6 +998,9 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 		if (WARN_ON(ret))
 			goto err;
 
+		link_sta->agg.max_rc_amsdu_len = 1;
+		ieee80211_sta_recalc_aggregates(sta);
+
 		mvm_sta_link =
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
-- 
2.38.1

