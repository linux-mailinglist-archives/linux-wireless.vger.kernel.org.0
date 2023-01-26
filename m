Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEFF67D889
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjAZWgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 17:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjAZWgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 17:36:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84029438
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674772594; x=1706308594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E47IzWP87sDlwcRDyKVLi8ccOcILUJNbHrJDqxdY5iM=;
  b=OY+PAixHtgw+quS9LYQ3nBqnLtvGwIu+uOnDOH133YDHeavClFvobkw0
   1CwpKVRUZMC/omg7BZxGbw8of+L/adNMVX2VDmkSRzPAmJGMrrT/JkqqQ
   u0vf6XPhEuDARrxTAOr8qBy81P7CRPOlTtsmiNTx20rF/ZsLrfAuTSTad
   KFthnvDt2G3/hywTMr3uEXeCXC2KUAkYdp2DJzHRHPjF8IgD4nV6EM/na
   YtbKGhxKaCIUWsSlZOARTkmkpj8icMqZAEVG/HW8h34pD7v/FTCWrzuiD
   NQxa26K1f/gA9j0r6Zz1t39InxV5HqLHanqsmZmb/PhvPPmWnc1Rumlg3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329098614"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329098614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612986227"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="612986227"
Received: from razgilad-mobl7.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.211.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:29:06 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/12] wifi: iwlwifi: improve tag handling in iwl_request_firmware
Date:   Fri, 27 Jan 2023 00:28:12 +0200
Message-Id: <20230127002430.175bfffdf2f5.I7ec7a29b2d93a977cb0a39dbcc7c875032eb14b7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230126222821.305122-1-gregory.greenman@intel.com>
References: <20230126222821.305122-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

We can remove the intermediary string conversion and use drv->fw_index
in the final snprintf directly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ab7065c93826..4c977ba9cd85 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -163,7 +163,6 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw,
 static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 {
 	const struct iwl_cfg *cfg = drv->trans->cfg;
-	char tag[8];
 
 	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (drv->trans->hw_rev_step != SILICON_B_STEP &&
@@ -174,13 +173,10 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -EINVAL;
 	}
 
-	if (first) {
+	if (first)
 		drv->fw_index = cfg->ucode_api_max;
-		sprintf(tag, "%d", drv->fw_index);
-	} else {
+	else
 		drv->fw_index--;
-		sprintf(tag, "%d", drv->fw_index);
-	}
 
 	if (drv->fw_index < cfg->ucode_api_min) {
 		IWL_ERR(drv, "no suitable firmware found!\n");
@@ -200,8 +196,8 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -ENOENT;
 	}
 
-	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s%s.ucode",
-		 cfg->fw_name_pre, tag);
+	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s%d.ucode",
+		 cfg->fw_name_pre, drv->fw_index);
 
 	IWL_DEBUG_FW_INFO(drv, "attempting to load firmware '%s'\n",
 			  drv->firmware_name);
-- 
2.38.1

