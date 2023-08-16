Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F577DBD6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbjHPILr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbjHPIL3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162094
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173489; x=1723709489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5UpsJJqbWWyphLeSF3g5U71aqVnUbCnEWkGl5GSQDPw=;
  b=QHcLbTXs9jg7jglBYs6GN0y9wL0xRc4p7r3docaI7NZyBX/MtqKOHr6p
   plLcbMC0K6IyNFHbrT9RnCHKvCDnrtBJErSrwxBZTSpRpTSM2uztwHnOJ
   HKj9Qc6h11EK+MYNGgvdoqrSBftoGB/6NPLAndlL3T10AA3MTG7CjszUD
   J3T7zVytV16xIKwLU7Xznv/7pkEj0LKjYkjuOKESs42KHnfXaCGam4IYX
   vwi1Hy6S47QhRn1QcvLCMwRer9ByKe+Rz0J18Nl3JR/BWsbaZTQOOoVqh
   T+mBRAnCnMsH6JN6zPZRISypXqvKJUnMfhmnwe4su0ca7vVQN1TGF5dXL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447866"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447866"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098846"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098846"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/12] wifi: iwlwifi: add Razer to ppag approved list
Date:   Wed, 16 Aug 2023 11:10:51 +0300
Message-Id: <20230816104355.f586a86fa644.I97408afb20bd7c46fcff8c3561ead8ed9c60b37e@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Add a new vendor (Razer) to PPAG approved list.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index dfe8357036eb..b26f90e52256 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -69,6 +69,11 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 		},
 	},
+	{ .ident = "RAZER",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+		},
+	},
 	{}
 };
 
-- 
2.38.1

