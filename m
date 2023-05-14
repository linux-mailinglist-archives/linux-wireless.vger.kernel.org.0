Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F15701C76
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjENJQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENJQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D91FDC
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055781; x=1715591781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JkSkfvkv1cXhhzvR1efj36ToSOCv287MVFFsp3NKOQ=;
  b=kgf2WzbNpNGjce5krO0cySj8rijAwLGqPFNTd64znQvTMTbjdKdMV4lg
   HgCKMjxtlWgdC7xm8AnMcV7fkTq4h20txvvDGUJJiNa3NZGoXfeBVQ/sY
   CkVP59fHVM2QPE2M45WzeFit3rSTPtxKCNS1ZTa36lLtLP6089XVDlvDG
   m6p3xPT3K1kafor1nIY0GdjgocremE2L/Z+9ZyqQ7sVsfzfsyJ7PymwVX
   brSEtuDUeEInh09qwpHV+pO55GzMi4nED212ygpUiNWm9/r4nKr3UAGdL
   oC2jVLb8JNuDWLe/94RBGEcNt1abc8wAypQBU3TurKSJyOmmR7V6WT0Bq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366830"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300325"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300325"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 02/12] wifi: iwlwifi: mvm: don't double-init spinlock
Date:   Sun, 14 May 2023 12:15:45 +0300
Message-Id: <20230514120631.221c22cfdf4e.I2e30113ef4bd8cb5bd9e1a69e52a95671914961c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
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

We don't need to (and shouldn't) initialize the spinlock
during HW restart that was already initialized, so move
that into the correct if block. Since then we have two
consecutive if statements with the same (though inverted)
condition, unify those as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index f877be850589..19f1545b3c7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -667,15 +667,15 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		ret = iwl_mvm_mld_alloc_sta_links(mvm, vif, sta);
 		if (ret)
 			return ret;
-	}
 
-	spin_lock_init(&mvm_sta->lock);
+		spin_lock_init(&mvm_sta->lock);
 
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
-	else
 		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_MVM_INVALID_STA,
 				       STATION_TYPE_PEER);
+	} else {
+		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
+	}
+
 	if (ret)
 		goto err;
 
-- 
2.38.1

