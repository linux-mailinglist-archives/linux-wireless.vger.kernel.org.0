Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE982783B00
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjHVHdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjHVHdq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 03:33:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245B116
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689625; x=1724225625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gji1PxgrICfMKQDKodZUKQhikp1aYIErIL66+6KOZo=;
  b=ajCWd3MFLguFsiXTkiXcK7BNKzLqVqxAb6OwsdtSrsZ+heQmLnrWgQY9
   XJbxI3MMVnalU+7dEyBJtHVyo7Po9AcXcGr6GK6q+rFd7JbdOMblbZmYS
   enmjaF8y46ZM5MupcABa9ZmNgPxd0vgV8llTgCkOmXExtokOop38X3Rvd
   jlPwYkKmC+ICrjyyjiRnMBkw1B9MBTuVSzS1jVplMaV6rAl+xjkKPTg8b
   I7mFMBZjgSUIURDy2eiRQXm8qybzgDFI015CUgmdIJvT15gTFoauzRqos
   px2BeDhS1HSDD/b8vjPDqHEIAma2xIO1NxpgEBPvdLRA9e7FBGV84teCz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363968776"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="363968776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826229619"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="826229619"
Received: from msharshe-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.209.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:33:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/5] wifi: iwlmei: don't send nic info with invalid mac address
Date:   Tue, 22 Aug 2023 10:33:19 +0300
Message-Id: <20230822103048.a49436bed387.I0ca88d72456e6e9f939bbc2e0c52ffb173fbc97e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230822073319.466640-1-gregory.greenman@intel.com>
References: <20230822073319.466640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

In case the SAP connection is established before the interface is
added, the mac address is still not set. Don't send the nic info
SAP message in this case since it will result in sending an invalid
mac address. The nic info message will be sent with a valid mac
address when the interface is added.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 78b78a772f54..1dd9106c6513 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -774,9 +774,13 @@ static void iwl_mei_set_init_conf(struct iwl_mei *mei)
 		iwl_mei_send_sap_msg_payload(mei->cldev, &sar_msg.hdr);
 	}
 
-	ether_addr_copy(nic_info_msg.mac_address, iwl_mei_cache.mac_address);
-	ether_addr_copy(nic_info_msg.nvm_address, iwl_mei_cache.nvm_address);
-	iwl_mei_send_sap_msg_payload(mei->cldev, &nic_info_msg.hdr);
+	if (is_valid_ether_addr(iwl_mei_cache.mac_address)) {
+		ether_addr_copy(nic_info_msg.mac_address,
+				iwl_mei_cache.mac_address);
+		ether_addr_copy(nic_info_msg.nvm_address,
+				iwl_mei_cache.nvm_address);
+		iwl_mei_send_sap_msg_payload(mei->cldev, &nic_info_msg.hdr);
+	}
 
 	iwl_mei_send_sap_msg_payload(mei->cldev, &rfkill_msg.hdr);
 }
-- 
2.38.1

