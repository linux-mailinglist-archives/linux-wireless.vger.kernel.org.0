Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7A70FD0A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjEXRqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjEXRqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:46:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099AD1A2
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950327; x=1716486327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rx7AGHsh+xDWyELx1uZJ71CFqZ4scgp9TqycFOj8rw4=;
  b=FGGh8l89P7o4Bd2w03DpPzj57GlyUyXi2RvRxTuYiVF+GOrzQKKRgkUA
   UVoVoiMRD3odg65YVm1LzBlB0lbdxTBcc357XA3tQlZ7fNsII4og6/KIE
   vOQ7VBqVNhwm/XmmYe1l0rsu8hk77S3b5bZineRTg+Quh2S9yjr80sD1l
   3ekvbYrPMmKsqRdqLSVbknWMKpKnktGiEA+ufYF/9l+HHJlB5NWAJURhH
   Ba5nfZb8xZDkZ8/uShbAUNODkqUpxFuX+PH21IVFGBmjKjZQMe6VA4yXM
   Tj8NvyM0kzCFS4FneC1Wncus3kOX0nlxRKQBebql+FmxDm+labF1sJWTG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000455"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548019"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548019"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:55 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ariel Malamud <ariel.malamud@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: fw: Add new ODM vendor to ppag approved list
Date:   Wed, 24 May 2023 20:42:07 +0300
Message-Id: <20230524203151.549a57a1cf11.I7392b1cd31f4f7ee60aafe2093f4e82b1d6fd3a7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ariel Malamud <ariel.malamud@intel.com>

Add new oem/odm pair to ppag approved vendors list
when specified by platform.

Signed-off-by: Ariel Malamud <ariel.malamud@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 5f4a51310add..9dfd2497d495 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -41,6 +41,12 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek COMPUTER INC."),
 		},
 	},
+	{ .ident = "GOOGLE-HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+		},
+	},
 	{}
 };
 
-- 
2.38.1

