Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D37A9BE0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjIUTEg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIUTEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7241B900C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318633; x=1726854633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3wYAlaqvKcESlmdTGDDKXMthjEYbZ/B/YJKPDqLykZA=;
  b=AwiKz1IVtlgFuFkNiSgSjv34uT5Z3cN+byYRd4X+Tm5+eHeAmgEIyfyn
   SlyqmMXIjJfkDyl8AlitwPM3hoLGjtujA843khEpmdAVROH+E/Ja89Koy
   y+fc8M41EmXRLosq5d7yaSAXGJ77uuDVB2+AqNMDEWlJkqMtBiMIzd3O7
   XP7DgjVil0BHJrW4A3GzWTCDTdBrIFc9kFYoyCb9BudrVUwUlKPHSeRWP
   vRBxtK0rtdll7/rlvUtz26ehyEFt6TDGB8zU7XnUpFqB3l4bZKIGnWBiX
   IaXq0jp2oVqARJNabze3KVu/ay2tr+/CKanoflJjnE2++RelaQcEJrFH0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305384"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545590"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545590"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/12] wifi: iwlwifi: mvm: make pldr_sync AX210 specific
Date:   Thu, 21 Sep 2023 11:58:06 +0300
Message-Id: <20230921110726.928901700ad8.I648efdc4400d9e537359915a9a8f363d5d255ead@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The register here is device specific, so we need to gate
the reading/checking to apply only on AX210 family.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6e5c0f81e041..5c719636c9bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -593,11 +593,13 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 
 	mvm->rfkill_safe_init_done = false;
 
-	sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
-	/* if needed, we'll reset this on our way out later */
-	mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
-	if (mvm->pldr_sync && iwl_mei_pldr_req())
-		return -EBUSY;
+	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+		sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
+		/* if needed, we'll reset this on our way out later */
+		mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
+		if (mvm->pldr_sync && iwl_mei_pldr_req())
+			return -EBUSY;
+	}
 
 	iwl_init_notification_wait(&mvm->notif_wait,
 				   &init_wait,
-- 
2.38.1

