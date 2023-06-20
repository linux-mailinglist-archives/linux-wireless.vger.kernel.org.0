Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE97368C3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjFTKFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFTKEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C464135
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255487; x=1718791487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zCq8DJcrGAEFJ7kcqg1GtzSzwaz0gndPR58OI2eSRA0=;
  b=K1I5zHR58AjfAyZ5VhKJfHP4BIz0JCKH9Nl7yzv+mmHCZ+qb3MgzB1YO
   EOTXiUPJflDoPMBe3o4LFuES/O4j1q8v0Y3uYmXFY4RUyMv+V+yNEzpb7
   /+A7D4ALkHqFla4q3c8wHY8y72iNMP4NIJiqIZ+WZVrZ8Lu6GVtN9mLN4
   gXlASSqrkmoEf9NmB4myKfc5cwON0WVRVh72Zhe3oxw4q7+7qFzGrrVlg
   ZgQ5ouiPEHoP/yqaM23Bj3e4JUB/WqJzHNBHXEFFtvLAowVS9WUor4wpQ
   kSeTx1Q23cMA0GsX+LmJoOyo892Mp+2qrMQIZiIDerpbi65OVLhfILSOP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819631"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819631"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143546"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143546"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/19] wifi: iwlwifi: mvm: send LARI configuration earlier
Date:   Tue, 20 Jun 2023 13:03:58 +0300
Message-Id: <20230620125813.80742497eb3f.I3e599a796290082e6d331ea495a5591d55de4726@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Sending the LARI configuration may trigger calibration, which can have
undesired side effects. Move the command to be send earlier (before the
phy contexts are registered) to avoid unintended side effects.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 77cdfb4a5ba3..1f5db65a088d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1566,6 +1566,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			goto error;
 	}
 
+	iwl_mvm_lari_cfg(mvm);
+
 	/* Init RSS configuration */
 	ret = iwl_configure_rxq(&mvm->fwrt);
 	if (ret)
@@ -1676,7 +1678,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		goto error;
 
-	iwl_mvm_lari_cfg(mvm);
 	/*
 	 * RTNL is not taken during Ct-kill, but we don't need to scan/Tx
 	 * anyway, so don't init MCC.
-- 
2.38.1

