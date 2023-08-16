Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361EC77DBDC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbjHPIMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbjHPILg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F5AB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173495; x=1723709495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4oiDeWzlYXMPNyeUFldUFsgr5xfDMHCf3/3GDBlsUoU=;
  b=bQEneyQZg8vrRBb3xzbR2uwJV+qkNHhjXrY/J3UUQTFkiGhuyfmCPDVi
   WV4qJKXRwM5B9fLUMbOJ3aMU4FsPqZr2c5syjIXuHOakO266HRAyMlXxl
   OjnRMhtvs36z/ON678Jz/BkpeU+QTtLYwe8BXS1NkRV9E10gESy8UTOKV
   Q7KIEgrgQjrz4I9GpPiIcE8ug1ftxqoR9UH3uCXA11xiPL9hIAJfkKOHn
   XY+rw1ryw7NZMkkPyzP3LIKQTWmWTxXPKn0iWEH0Cd92BaffTYLIuHtnU
   RHU1WA6ArqZlT8p/7cPVq+n3p2iVMRMF4JiSeMzLmd9MXe+EqjSQgzTVd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447886"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447886"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098873"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098873"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/12] wifi: iwlwifi: remove memory check for LMAC error address
Date:   Wed, 16 Aug 2023 11:10:54 +0300
Message-Id: <20230816104355.08ab1497904d.I270d4c5bcc23c5ecd0b7db475501032c450852ad@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

LMAC error table address was checked against UMAC
error table minimum address defined. Because of that,
the LMAC error table was not read, since both addresses
belong to different ranges. As addresses are updated from
FW alive message and should be correct, this check is not
needed.

Still keep the check for address 0 to avoid NULL address read.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 5876f917e536..8f107ceec407 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -182,8 +182,7 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 			base = fwrt->fw->inst_errlog_ptr;
 	}
 
-	if ((fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ && !base) ||
-	    (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ && base < 0x400000)) {
+	if (!base) {
 		IWL_ERR(fwrt,
 			"Not valid error log pointer 0x%08X for %s uCode\n",
 			base,
-- 
2.38.1

