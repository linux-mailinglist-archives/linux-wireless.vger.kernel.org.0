Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F372E379
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbjFMM5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbjFMM5u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3695A6
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661069; x=1718197069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pvvxh0MvDUzXpyMmgIpH6ctl/5Z+32sGT01Pgp/EE1E=;
  b=DO0gD5DodWIvytK4Ms4h+TPwhzn/C1IT5WoJhnMZNMCYCszS8WENEK8B
   e5BJvZaAYmX1ST2soxpO6E1SeCEP2bFVC7H7dhs291O4LeOrOFyVkJ5AE
   0mVkcswsHaz0ZwCNvJ6ZwBNJnS1zO/l/t1u+jHlHPeGGDXyUw7S5uo0z8
   B8xPx7KNlGgf5G1ijzYIXkvo38I38giKjsFsrETYhIkO8QzL/AOrOuKjl
   0uU2KZn9jMkgOTP8dtmjbFMpaVq9pjKIsUk2F9BlAzxnldiSmdubXYTmK
   xkuzo+yszIKtYUmMZQO8aoJcx6yOPiNOLGmjtSyjeuZSwJxpAC/19mFd5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973723"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973723"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880789"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880789"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: improve debug prints in iwl_read_ppag_table()
Date:   Tue, 13 Jun 2023 15:57:17 +0300
Message-Id: <20230613155501.4ee455ec1ee8.I6f1a4b7dfa5cfd9b4f4a4b5bb5567849e629ae96@changeid>
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

From: Alon Giladi <alon.giladi@intel.com>

Add prints of ETSI and China bits.
Check if need to mask the China bit (when the firmware doesn't
support it) in a separate flow, so it will be easier to follow
the conditions. Add a separate message for the command version.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 37 ++++++++++++--------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 018d820ae231..4e4048310f0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1169,41 +1169,48 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
          */
         cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
 
+	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
 	if (cmd_ver == 1) {
                 num_sub_bands = IWL_NUM_SUB_BANDS_V1;
                 gain = cmd->v1.gain[0];
                 *cmd_size = sizeof(cmd->v1);
                 if (fwrt->ppag_ver == 1 || fwrt->ppag_ver == 2) {
+			/* in this case FW supports revision 0 */
                         IWL_DEBUG_RADIO(fwrt,
-                                        "PPAG table rev is %d but FW supports v1, sending truncated table\n",
+					"PPAG table rev is %d, send truncated table\n",
                                         fwrt->ppag_ver);
-			if (!fw_has_capa(&fwrt->fw->ucode_capa,
-					 IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) {
-				cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
-				IWL_DEBUG_RADIO(fwrt,
-						"FW doesn't support ppag China bit\n");
-			} else {
-				IWL_DEBUG_RADIO(fwrt,
-						"FW supports ppag China bit\n");
-			}
 		}
 	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
                 num_sub_bands = IWL_NUM_SUB_BANDS_V2;
                 gain = cmd->v2.gain[0];
                 *cmd_size = sizeof(cmd->v2);
                 if (fwrt->ppag_ver == 0) {
+			/* in this case FW supports revisions 1 or 2 */
                         IWL_DEBUG_RADIO(fwrt,
-                                        "PPAG table is v1 but FW supports v2, sending padded table\n");
-                } else if (cmd_ver == 2 && fwrt->ppag_ver == 2) {
-                        IWL_DEBUG_RADIO(fwrt,
-                                        "PPAG table is v3 but FW supports v2, sending partial bitmap.\n");
-                        cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+					"PPAG table rev is 0, send padded table\n");
                 }
         } else {
                 IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
                 return -EINVAL;
         }
 
+	/* ppag mode */
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits were read from bios: %d\n",
+			cmd->v1.flags & cpu_to_le32(ACPI_PPAG_MASK));
+	if ((cmd_ver == 1 && !fw_has_capa(&fwrt->fw->ucode_capa,
+					  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
+	    (cmd_ver == 2 && fwrt->ppag_ver == 2)) {
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
+	} else {
+		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
+	}
+
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits going to be sent: %d\n",
+			cmd->v1.flags & cpu_to_le32(ACPI_PPAG_MASK));
+
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
                 for (j = 0; j < num_sub_bands; j++) {
                         gain[i * num_sub_bands + j] =
-- 
2.38.1

