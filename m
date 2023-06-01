Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECD719FA4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjFAOUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjFAOUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F43186
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629240; x=1717165240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MG27AioYmZ4a5jcSqZUjIQiQ30+n2Sd4v9OAf2Kr6GM=;
  b=Kv+GA6UN7f/aTtrgcZrv9K/xD6NdyfAB2Qhf4JgJlHPFozOUHK591gM8
   UhLP+MfsPBs/yuTtw6q1lWVzTVBtnygnr6btM+H//vkOvClGHOcJ6+HMC
   use7mhL84lJ7QckH28izVemNq/qn0IisR4cHU0YwT0eicCwItuiMlr3WA
   zbzHltXdUc3UM/H9ZUy6E9dohpd0wgdx3NdjaGndZ6g7ON6mj42aCUL4Q
   k9OEXqfHYFUxPYiXYQ7wr7KJFoCtNExbWXJxTS+IB4oGpUKdRC3yq+VVI
   ksbkojr/6NMd6DV8tbhRABhST4j5lVY53pSd7MITUnee7RM3v3g8KcubM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931839"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812821"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812821"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/6] wifi: iwlwifi: api: remove unused commands
Date:   Thu,  1 Jun 2023 17:20:05 +0300
Message-Id: <20230601171633.3dad4ad9b53e.I018abd02d6925950b8748dfb7a59db87255fc670@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some commands are no longer used and have broken kernel-doc links,
so just remove them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 11 -----------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c         |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 111d96cbde6f..78d3ccab279d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -138,11 +138,6 @@ enum iwl_legacy_cmds {
 	 */
 	REMOVE_STA = 0x19,
 
-	/**
-	 * @FW_GET_ITEM_CMD: uses &struct iwl_fw_get_item_cmd
-	 */
-	FW_GET_ITEM_CMD = 0x1a,
-
 	/**
 	 * @TX_CMD: uses &struct iwl_tx_cmd or &struct iwl_tx_cmd_gen2 or
 	 *	&struct iwl_tx_cmd_gen3,
@@ -533,12 +528,6 @@ enum iwl_legacy_cmds {
 	 */
 	PROT_OFFLOAD_CONFIG_CMD = 0xd4,
 
-	/**
-	 * @OFFLOADS_QUERY_CMD:
-	 * No data in command, response in &struct iwl_wowlan_status
-	 */
-	OFFLOADS_QUERY_CMD = 0xd5,
-
 	/**
 	 * @D0I3_END_CMD: End D0i3/D3 state, no command data
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 32625bfacaae..8cc2e2145cf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -449,7 +449,6 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(ADD_STA_KEY),
 	HCMD_NAME(ADD_STA),
 	HCMD_NAME(REMOVE_STA),
-	HCMD_NAME(FW_GET_ITEM_CMD),
 	HCMD_NAME(TX_CMD),
 	HCMD_NAME(SCD_QUEUE_CFG),
 	HCMD_NAME(TXPATH_FLUSH),
@@ -512,7 +511,6 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(REPLY_BEACON_FILTERING_CMD),
 	HCMD_NAME(D3_CONFIG_CMD),
 	HCMD_NAME(PROT_OFFLOAD_CONFIG_CMD),
-	HCMD_NAME(OFFLOADS_QUERY_CMD),
 	HCMD_NAME(MATCH_FOUND_NOTIFICATION),
 	HCMD_NAME(DTS_MEASUREMENT_NOTIFICATION),
 	HCMD_NAME(WOWLAN_PATTERNS),
-- 
2.38.1

