Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588D7B7C4A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbjJDJhM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbjJDJhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD1CE6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412224; x=1727948224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFoP7IO7laD8OTBw8G180uv3S61BHByTz5OwF2se6sU=;
  b=PDn8snEeE0hbuuBE79L2379EW55/avwH7jiEnUPAJ/2dNl+j/uEmVsIm
   YK+zDHQv/I+U5BiSi5uKGAWEyOk6auCFLkMQR/snMg0N+BKoVM+jjRzZa
   ARqwZNs7T1eRnIKoAOxYs8ShIRPhHgEICzT7yZnrxAm4WZ1REgKU2cZ3i
   6yTk0NBHlJZGNIi4b61f1i5IgOQTfIEU98nNNvBPC9+WDUJyIIEoPsMIZ
   /BDguLg6J3bT2foCVzQuq5k5CgvG59Wh5ByfVQ7X4mh2I2MXg4pJvLyu/
   aOFzc6a/w4LVZ6/yN/f3oSlXXEOjEPQBo8hc1LpwOYeWfzdpfQB8aAkfK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611776"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611776"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415166"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415166"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: fix SB CFG check
Date:   Wed,  4 Oct 2023 12:36:25 +0300
Message-Id: <20231004123422.ab21c7d5e219.I4f9906ebc7ecf38fd276510a276280a9261c8f7f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
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

We shouldn't check the 0x10 bit here, since the register
holds different values (not just bit masks.). Check for
the exact value where this is needed only.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 7bd4ce149e04..c1a94b01ce14 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -382,7 +382,7 @@ enum {
 #define PREG_PRPH_WPROT_22000		0xA04D00
 
 #define SB_MODIFY_CFG_FLAG		0xA03088
-#define SB_CFG_RESIDES_IN_OTP_MASK	0x10
+#define SB_CFG_RESIDES_IN_ROM		0x80
 #define SB_CPU_1_STATUS			0xA01E30
 #define SB_CPU_2_STATUS			0xA01E34
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5c719636c9bd..d56c62b9c205 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -596,7 +596,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
 		sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
 		/* if needed, we'll reset this on our way out later */
-		mvm->pldr_sync = !(sb_cfg & SB_CFG_RESIDES_IN_OTP_MASK);
+		mvm->pldr_sync = sb_cfg == SB_CFG_RESIDES_IN_ROM;
 		if (mvm->pldr_sync && iwl_mei_pldr_req())
 			return -EBUSY;
 	}
-- 
2.38.1

