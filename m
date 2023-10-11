Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA67C4FAF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbjJKKJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJKKIs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E41BEA
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018872; x=1728554872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eixZhpWDxXlfnuXS1a9QZcxXzWExnGFqTagJa6IP60E=;
  b=GIiLT43iOPzTWgzROt9GJtkN3epgXm20UWNXtJcfrx5fsNGugLQUWDML
   0Q9m/dIQpCs+7pqEFdsajWdK7NJjJcju4DL+LfaJ0aYAXRUKPP2BYjZsb
   r92MCERjyYtk3IjJAe9iD/jasl0P9/+yQP51KdTWy0va72RlW5kLkRfw/
   I0WgK2yRDRCyDHozr91qlfCnJqcLNtVbfLdHNSRfnocRWuTzAebowbgeo
   pHCOvW1vWy6mXyunVfpRN7kbJ2HqkAcH+ZfbbzJH844ZH3cvOevAjUAct
   aJXsRo73xYfMe341r1KLGrX7Hpr1JiLANQaMdaMaV7obnSkVXXMgVW+jQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670576"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670576"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050260"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050260"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Matt Chen <matt.chen@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/16] wifi: iwlmvm: fw: Add new OEM vendor to tas approved list
Date:   Wed, 11 Oct 2023 13:07:19 +0300
Message-Id: <20231011130030.a6f10aaae473.I65c3321535674bbc08d96200961a78fab5e7a09f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
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

From: Matt Chen <matt.chen@intel.com>

Add new oem/odm pair to tas approved vendors list when specified by platform.

Signed-off-by: Matt Chen <matt.chen@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 073cb3189077..e9710e6e2efa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1101,6 +1101,12 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		},
 	},
+	{ .ident = "GOOGLE-HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+		},
+	},
 	{ .ident = "MSI",
 	  .matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
-- 
2.38.1

