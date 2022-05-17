Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD5529D78
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiEQJIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D723171
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778404; x=1684314404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttOpXnLYQ6yRfaXL5Oy3O3S8eImL4Z4PjMNZ2xkhqFE=;
  b=WGGAHc2UNslVfsoJ5iSmnMyqPqNTE9u8J82bKw6A0A3eHiMNvLrkHO1Y
   Rp5f1tEO6tgDCq/ji+BmYYNOsPGkBcx1bYA8GVewgtH3dFu40YZ0DNHBf
   jvlY5PiqUgTz3G44EK+YGRK//QuA9uvGt1NY7h0Sdcqx5HPoC/F1irZfa
   iEqgpUKMx5FECFv1JKa4MWskRA12kaDuBNSG+SSnxS+qzaIsJDuRt1ee3
   y/iwxhYPLZ8nLho48ngRhU9TK2NPzWjG0ndySMEXMnJpRZnvZgLNVRudR
   rTa/8SA0dAprUl3xGemLfM33is/vTZqC0OfXzFVeREBa0DuGeYudu8eF4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064762"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064762"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679715"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:23 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/10] iwlwifi: fw: init SAR GEO table only if data is present
Date:   Tue, 17 May 2022 12:05:08 +0300
Message-Id: <20220517120044.bc45923b74e9.Id2b4362234b7f8ced82c591b95d4075dd2ec12f4@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When no table data was read from ACPI, then filling the data
and returning success here will fill zero values, which means
transmit power will be limited to 0 dBm. This is clearly not
intended.

Return an error from iwl_sar_geo_init() if there's no data to
fill into the command structure.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 78a19d5285d9 ("iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage")
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 33aae639ad37..e6d64152c81a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -937,6 +937,9 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 {
 	int i, j;
 
+	if (!fwrt->geo_enabled)
+		return -ENODATA;
+
 	if (!iwl_sar_geo_support(fwrt))
 		return -EOPNOTSUPP;
 
-- 
2.35.1

