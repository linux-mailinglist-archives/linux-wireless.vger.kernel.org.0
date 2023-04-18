Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4E6E5D58
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjDRJ2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDRJ2f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB955BA
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810115; x=1713346115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOHVg9jCKXv2tysO5X3cSkUQYQOpu/kVBGIK+QQ2l0M=;
  b=LfCtFX6JzLouPAaE/B8G9xxdKbuIYO/2Po0EXOqnk5r9gaTI0Z2RWmEj
   /paczRRfiZKfRZb3XHAFMK68tolYO5hTr1Avhzoq8slUWUm83ZKIm5r41
   DI3PVRL3uiJ/oUszYydHvr1Zi0Q9EeMa1z9UU4XhqgkilxENX6ffhRyBG
   Kwu/zsOM9PZsJq7Wm+wytg6FSD77mVnN6FdjZeMLC0NENdhY0bDJG5AJp
   R9+/WgfxgKP3y5u6JRGWO1S3SbXjq7fhFYmtU2PuVmGmj140/X0tEDO3F
   05VSb6QaO0WdPzdyfFealWPu/Nsc5PispKyx03qc1/mQ6rGH18OibU4A4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341170"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511216"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511216"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: fw: fix argument to efi.get_variable
Date:   Tue, 18 Apr 2023 12:28:07 +0300
Message-Id: <20230418122405.aaa6d8874442.I734841c71aad9564cb22c50f2737aaff489fadaf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

We should pass the newly allocated data to fill.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 0b6f694cf30d..01afea33c38c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -222,7 +222,7 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 		return ERR_PTR(-ENOMEM);
 
 	status = efi.get_variable(IWL_UEFI_REDUCED_POWER_NAME, &IWL_EFI_VAR_GUID,
-				  NULL, &package_size, data);
+				  NULL, &package_size, package);
 	if (status != EFI_SUCCESS) {
 		IWL_DEBUG_FW(trans,
 			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
-- 
2.38.1

