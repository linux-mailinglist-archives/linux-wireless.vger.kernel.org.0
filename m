Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857C7B7C4D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbjJDJhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbjJDJhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0220B4
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412225; x=1727948225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYEJmlR2AzfIEBh4yL3TJzb3AENj2A3SEcPEWmzJinM=;
  b=VYZkrazsRgWpjorL5gB+sOi8QibcVzaPrEF6150M6BVYYJwmq/3dEK17
   nucuqUZesQi7hfOUTuPa7hKELlrX7Bh/MoJqk1T/Bf1kSD7bHnN1B2FrU
   ZBbklRg9D19d0RuDh2UBePsCukHcBEdBW2TNymvXN3tMdQtssKyqu+qxz
   8bHflzwgbNxDbYXn09uwAENrzrmMkazuXP5yi1mbIjNHrszZI9I/x8Ynw
   GqI8grXzFX4HFPqAV14nLUaodbyFLaMAQHnXOVPc6CgGMBOsehb8XBh8d
   P6456HVfuvDNYE9+yHsBNqaczi7ib9A0kwbCe6wIFmM9Z0GQbz4+B1wgQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611782"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611782"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415169"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415169"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mei: return error from register when not built
Date:   Wed,  4 Oct 2023 12:36:26 +0300
Message-Id: <20231004123422.d410a97cddfb.I7891544938d5edd5e6e7d2d99540b3637f2f1b1b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When MEI isn't built, it seems like successfully registering
would be wrong. Change this to an error so that in the rest
of the driver, mei_registered won't be true.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 655d95d3a068..1f3c885aeb65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2021 - 2022 Intel Corporation
+ * Copyright (C) 2021-2023 Intel Corporation
  */
 
 #ifndef __iwl_mei_h__
@@ -493,7 +493,7 @@ static inline void iwl_mei_set_power_limit(__le16 *power_limit)
 
 static inline int iwl_mei_register(void *priv,
 				   const struct iwl_mei_ops *ops)
-{ return 0; }
+{ return -EOPNOTSUPP; }
 
 static inline void iwl_mei_start_unregister(void)
 {}
-- 
2.38.1

