Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E388616578
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKBPAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKBPAw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2D2A978
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401251; x=1698937251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m40JF2x0IcWXRtfj0vv789mMRvkLMEdorFPLeLDxt6o=;
  b=Zst9OwVGCp0x3ZveL84HgLu7mP8yND8c3pKOJu1mpBXcnHsECo6HBUzh
   7eORiKqoGzJ0DtKXXyS7CUTfe4sSX9/oWu6R5/QZspg6ame+1oiYRaqXP
   oQEB6aTjCooRLHiG6YtjUT4B94R8i6e65RX1zltzC7h3sxAAGI1SaBMg6
   g8rlVu5wfkKF49U+vTl5bNL8CxWtURGS7BBG41TQchu1O2MjPpACMIXwb
   uROB/QEXO1Y8MziODyYe9Y39w27KVHiABrbyRnDNoK3UbXBh8idPeJIVs
   6sW/2dkrHg3MXk3OBSo40qGa9zQPE3s1bd9XW53DB11Kbq3xtN8NdrFEL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523446"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523446"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810471"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810471"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:39 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: mvm: print an error instead of a warning on invalid rate
Date:   Wed,  2 Nov 2022 16:59:51 +0200
Message-Id: <20221102165239.3d3673c70556.I13464b11d405fd6021618b0a32404cecb7e9ac51@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In some rare occasions, the firmware may let some frames with invalid
rates, such as CCK rates on the high band, come through.  This causes
the driver to issue a warning, but since this is a possible issue and
it's not really a bug in the driver, convert the warning into an
error.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1aadccd8841f..5f782ca1e254 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1747,10 +1747,12 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 
 		rx_status->rate_idx = rate;
 
-		if (WARN_ONCE(rate < 0 || rate > 0xFF,
-			      "Invalid rate flags 0x%x, band %d,\n",
-			      rate_n_flags, rx_status->band))
+		if ((rate < 0 || rate > 0xFF) && net_ratelimit()) {
+			IWL_ERR(mvm, "Invalid rate flags 0x%x, band %d,\n",
+				rate_n_flags, rx_status->band);
 			rx_status->rate_idx = 0;
+		}
+
 		break;
 		}
 	}
-- 
2.35.3

