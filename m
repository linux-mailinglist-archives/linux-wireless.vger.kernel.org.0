Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC54D6AAF64
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCEMRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCEMRQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C804412F39
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018632; x=1709554632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6E1Y8rewjFarfPFubGAhdkbtet7J6rn4xcm2D+JsGw=;
  b=Z8U0QTCzlvJtBdeLdJi2qYE7nSBRac1DeZw65S9ZSaqzBb+98o7iuzLj
   0GePmDQmj2ckqcgxdaZ8Dqzv+825ZMdeQZHUKC1jvzv+adkx8bjGvNpwq
   rB3ldrZOL/0zE/nBjU3eNMA+81MWbg/TaJ1T9YVhKJ/SRE9bJsfk9FnWp
   oALOjWmgesb7PmR/LO2vDjEg6iFrc1NWfeOi9F6Ec2KZR6yT5bFRglNjQ
   zWpkMRMUfj25MvKe4Q2+TDIn92IVdQrN9VH7VIMZN+hPCjo6u3wWfQ31T
   1ggiYrcqXGphueCqyavRJqtOo50KCElVI+8Tz3LJ/kM6EflRUg0m/AVM8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193196"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193196"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355084"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355084"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:10 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/21] wifi: iwlwifi: mvm: allow new vendor to use TAS
Date:   Sun,  5 Mar 2023 14:16:22 +0200
Message-Id: <20230305124407.662967fec1cc.Icb30cddc049cb5402fd5ab2ce7f95033e478b1b9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Add Microsoft to the list of OEMs which allowed to use TAS.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0c6b49fcb00d..45981e22b2db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1084,6 +1084,11 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		},
 	},
+	{ .ident = "MSFT",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+		},
+	},
 
 	/* keep last */
 	{}
-- 
2.38.1

