Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94F37AE76E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjIZIHz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjIZIHx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE23410A
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715666; x=1727251666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGZXoAFs5byDF6XtERdJN3nPSiISI8zIjpTvU84ILmY=;
  b=ajhFZx4WpbxnV0FaDp2O+0moXaoezuAaQpH2pU/rOau1KGrgcmQM+v4n
   5TrBmhVH7iZVj2FPB1CR3BKGrgOC4YpcYT6hzavYpDr/PbIJWvtdViSSf
   LfFlm19ioWgaq3xuOdsGmAFoDGEtKGBeOlQWkeXBhYytf3CrZvxoshdDh
   +C3JI3g9VMSgE1JWsNJBwDdClN0zuRUjH1gZspAS8CT32r5SVYloBXx2K
   uxqeHhAJEiJhO6IR8IXCPFhCJtBSPV/Odm9QoEIXmccJzcok2RYx9fMip
   aRGyYlOZS3oeZ4rnRGj1aMLclopQ/TAwjVdzPJisuKfd4a2iketlnGV+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797266"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797266"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369284"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369284"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/9] wifi: iwlwifi: pcie: clean up WFPM control bits
Date:   Tue, 26 Sep 2023 11:07:17 +0300
Message-Id: <20230926110319.82d2744690b3.I90c08a27dca26a181dacb069184f39ece77849b5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We define the same bit twice, remove the less precise
definition and use the better one instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 6fad5b65a836..06d467068ff4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -365,7 +365,6 @@
 #define DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK		0x00000FFF
 
 enum {
-	ENABLE_WFPM = BIT(31),
 	WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK	= 0x80000000,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e8687683ff29..26a0953603ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1134,7 +1134,7 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 
 	/* Enable access to peripheral registers */
 	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
-	val |= ENABLE_WFPM;
+	val |= WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK;
 	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
 
 	/* Read crf info */
-- 
2.38.1

