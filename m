Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8376424B6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiLEIgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLEIgd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F8165AF
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229392; x=1701765392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/n2eusvGUn2WExxgNySCimZdbPTJ8w4dnt/oLY5yoMo=;
  b=lZl5bnfCCix1//8nXB2+i74WyRg6jd/TSI4npVLBtHXK8CXp8fDfh4w2
   G7Mxz8VrBYPnxcVz97msEOetikf0np+3DlOhTSVDbOjOHREWb0+J2MliP
   dfVSjSgi+KfNpouzjecXmuXKNRk/8BRP/UKPLTXH0ysRxl0rrFjf5hx8P
   Q/MXowI+nrCYKl8HRBlQU3E28aok8JRcMeDIfa/TLYsyKlKWbbgwqBvUa
   wDKfxeOsDsJgwa5GzOd8vyMZRgeHGq52f8zcyUHwcB0JyVh9+qKoGAjA6
   1OCmfJ58UPJdlzbuEOpVv2iqWdlRSRHZ/oTSowOiolvR2cuzrUgH2nky/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323096"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100385"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100385"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:20 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/11] wifi: iwlwifi: dump: Update check for valid FW address
Date:   Mon,  5 Dec 2022 10:35:41 +0200
Message-Id: <20221205102808.a521691632e9.Ic15fa65107c0d4d0b555a1fb3a2a20ab2725b683@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The error dump base address need an update based
on current hardware.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index b90f1e9ce691..03b1b2428b5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -157,7 +157,8 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 			base = fwrt->fw->inst_errlog_ptr;
 	}
 
-	if (base < 0x400000) {
+	if ((fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ && !base) ||
+	    (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ && base < 0x400000)) {
 		IWL_ERR(fwrt,
 			"Not valid error log pointer 0x%08X for %s uCode\n",
 			base,
-- 
2.35.3

