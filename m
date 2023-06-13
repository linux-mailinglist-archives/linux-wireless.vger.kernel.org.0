Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C04A72E383
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjFMM6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbjFMM6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF1E19B1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661101; x=1718197101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=piCT1rPiv7KKUUV48+ae6gkjo2YR4SXvQO9Lw7nrF1I=;
  b=UFfZt++kA6RikVJprWgoXwBIl7fSFlBVaKEKhQ5YIVeAvtNe61J3+i4B
   7MVc8QGEbUxpSK+7Av/A5gHA53m+XiHsTKI0KOn3ih7unmzq3KfBi1Xan
   Bga5sfg+bLWYF+0uopXwM8t9L+1iR4qFaGyGSbmz+83jqh82zjcG4ZjW0
   BS1MwIjZ344q7pNyD3U3BgNfDEzDObamYbwPRbX6A2PfUfAOCZhN7+o17
   B3c9zHmymz8eq6GYoR4T+M0uClKa48NEqYkSWC4slfi9KVbi2jTyPN0GT
   xocX+TrpbFmyPgw4LdEP3m+l7jzEA+Vtc2gTP83L0ggEqzpbGWOW0XRfR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973786"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880858"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880858"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:58:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: dbg-tlv: clear FW debug memory on init
Date:   Tue, 13 Jun 2023 15:57:27 +0300
Message-Id: <20230613155501.30b82881cfbf.I39520aff8ac95ee64d39dc5913525a1efd7995fa@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we restart the firmware, we shouldn't keep old debug data
around. Since the "allocate" function might not reallocate the
memory blocks (they're only freed when we unbind from the device),
clear the memory to have a clean slate for debug data.

This is a bit more complex since we normally don't enter into
the allocation function, but duplicating the logic didn't seem
enticing either, so rework the allocation a bit to always go
into the individual block allocation, but there clear if it's
already allocated, rather than allocating again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3f9d4670f6c6..ef5baee6c9c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -586,8 +586,14 @@ static int iwl_dbg_tlv_alloc_fragments(struct iwl_fw_runtime *fwrt,
 	fw_mon_cfg = &fwrt->trans->dbg.fw_mon_cfg[alloc_id];
 	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
 
-	if (fw_mon->num_frags ||
-	    fw_mon_cfg->buf_location !=
+	if (fw_mon->num_frags) {
+		for (i = 0; i < fw_mon->num_frags; i++)
+			memset(fw_mon->frags[i].block, 0,
+			       fw_mon->frags[i].size);
+		return 0;
+	}
+
+	if (fw_mon_cfg->buf_location !=
 	    cpu_to_le32(IWL_FW_INI_LOCATION_DRAM_PATH))
 		return 0;
 
@@ -1272,18 +1278,23 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 	int ret, i;
 	u32 failed_alloc = 0;
 
-	if (*ini_dest != IWL_FW_INI_LOCATION_INVALID)
-		return;
-
-	IWL_DEBUG_FW(fwrt,
-		     "WRT: Generating active triggers list, domain 0x%x\n",
-		     fwrt->trans->dbg.domains_bitmap);
+	if (*ini_dest == IWL_FW_INI_LOCATION_INVALID) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Generating active triggers list, domain 0x%x\n",
+			     fwrt->trans->dbg.domains_bitmap);
 
-	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.time_point); i++) {
-		struct iwl_dbg_tlv_time_point_data *tp =
-			&fwrt->trans->dbg.time_point[i];
+		for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.time_point); i++) {
+			struct iwl_dbg_tlv_time_point_data *tp =
+				&fwrt->trans->dbg.time_point[i];
 
-		iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
+			iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
+		}
+	} else if (*ini_dest != IWL_FW_INI_LOCATION_DRAM_PATH) {
+		/* For DRAM, go through the loop below to clear all the buffers
+		 * properly on restart, otherwise garbage may be left there and
+		 * leak into new debug dumps.
+		 */
+		return;
 	}
 
 	*ini_dest = IWL_FW_INI_LOCATION_INVALID;
-- 
2.38.1

