Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9849077DBCE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjHPILg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjHPILO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261913E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173473; x=1723709473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQ9qtsMCVx5kzFQp69IR5ovf7Z9orMvptuOjMFW5wtw=;
  b=YgJZjUCtRuntvAsb/OZO+OdvVAtg+GctIfM3NGEHRM4a8eUzYJ6YP9xK
   Pn4UrFOHxu0GQmpHcuJYcxJJKK8SVUNQqof66mR9k1+OyYuNBrC7/6f/8
   IRB90dbBN+/pZaSD/YdqeotkcrLaPURG33HLat4Io2w7+aF8a6TTWXE/7
   Dnf0ClXU4a+yUZJdwFpwJy4skCoWMrPFy9kmoWO8iG1eUfDcftkvsX7Hn
   SzwCKNbqhrdw79U0wh2iiJ0OFho39WJAsTBtbDW3rvT5B6lndR2ctUDTV
   sGrjD+SEGndQBmRqLcV6nvyxE2yaiaOueET9lQUObnR9xeJqnXAbDS6GP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447786"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098737"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098737"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/12] wifi: iwlwifi: api: fix a small upper/lower-case typo
Date:   Wed, 16 Aug 2023 11:10:44 +0300
Message-Id: <20230816104355.c06f98055dbb.Ie9267108c57edcbb913f0d0f349eac85ca39409b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The structure name in the docs should be given in all
lower case matching the actual C declaration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 8fef38139bf6..48ffab22bb7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -377,7 +377,7 @@ struct iwl_buf_alloc_cmd {
 #define DRAM_INFO_SECOND_MAGIC_WORD 0x89ABCDEF
 
 /**
- * struct iwL_dram_info - DRAM fragments allocation struct
+ * struct iwl_dram_info - DRAM fragments allocation struct
  *
  * Driver will fill in the first 1K(+) of the pointed DRAM fragment
  *
-- 
2.38.1

