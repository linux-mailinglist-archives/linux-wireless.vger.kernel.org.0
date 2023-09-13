Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5079E760
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbjIML6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjIML6J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:58:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA711999
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606285; x=1726142285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YovdqokO0OVG5kO8q1IJBjGfaSLG+7U8NAL7bR7ldGU=;
  b=ZU/HqYiw/Cl4j7Rhw/TaQhjUVE78tYAZfTtCQmVgVe+5wC2uJ/wt1KWK
   bgcq1nmJemeHsayWmwhTgxr1WuYp450Bzsbn+6caNURp6iK7JzUWdjNWp
   RlXIIzchv7laUa9jJREfBiCZKTa/29EQ6LfSY/auIp4eFKZVFzVVLt/Zk
   Dh0uzO83r9B+Vds02ign336cwIRecV/1AZla7Ay24b661iraTptqTqI//
   qEvMXE750Bu9CEsPC5pdwEz1UvcCDgpiT4nOYJBeTRqJpk4+or0M4iQkh
   7WOzL4f0qLJN/FPZMuXyVvXqIiumvak9G3olZpe6lgJXdzJ/tDNq1AJBi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903091"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903091"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470978"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470978"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: no power save during transition to D3
Date:   Wed, 13 Sep 2023 14:56:48 +0300
Message-Id: <20230913145231.ced036106507.Ib5ed5a47ee35f624902bd8882dde3e559285965b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Transition to d3 is much faster if there is no power save during the
transition. Therefore a new flag was added to the device power cmd to
indicate the power save isn't allowed until the transition is completed.
Set this flag in _iwl_mvm_suspend, when the transition begins.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/power.c    | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 85d89f559f6c..040d83fa5424 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -144,6 +144,8 @@ struct iwl_powertable_cmd {
  *	receiver and transmitter. '0' - does not allow.
  * @DEVICE_POWER_FLAGS_ALLOW_MEM_RETENTION_MSK:
  *	Device Retention indication, '1' indicate retention is enabled.
+ * @DEVICE_POWER_FLAGS_NO_SLEEP_TILL_D3_MSK:
+ *	Prevent power save until entering d3 is completed.
  * @DEVICE_POWER_FLAGS_32K_CLK_VALID_MSK:
  *	32Khz external slow clock valid indication, '1' indicate cloack is
  *	valid.
@@ -151,6 +153,7 @@ struct iwl_powertable_cmd {
 enum iwl_device_power_flags {
 	DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK		= BIT(0),
 	DEVICE_POWER_FLAGS_ALLOW_MEM_RETENTION_MSK	= BIT(1),
+	DEVICE_POWER_FLAGS_NO_SLEEP_TILL_D3_MSK		= BIT(7),
 	DEVICE_POWER_FLAGS_32K_CLK_VALID_MSK		= BIT(12),
 };
 
@@ -162,7 +165,7 @@ enum iwl_device_power_flags {
  * @reserved: reserved (padding)
  */
 struct iwl_device_power_cmd {
-	/* PM_POWER_TABLE_CMD_API_S_VER_6 */
+	/* PM_POWER_TABLE_CMD_API_S_VER_7 */
 	__le16 flags;
 	__le16 reserved;
 } __packed;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 9131b5f1bc76..1b9b06e0443f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -489,6 +489,11 @@ int iwl_mvm_power_update_device(struct iwl_mvm *mvm)
 	if (mvm->ext_clock_valid)
 		cmd.flags |= cpu_to_le16(DEVICE_POWER_FLAGS_32K_CLK_VALID_MSK);
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, POWER_TABLE_CMD, 0) >= 7 &&
+	    test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))
+		cmd.flags |=
+			cpu_to_le16(DEVICE_POWER_FLAGS_NO_SLEEP_TILL_D3_MSK);
+
 	IWL_DEBUG_POWER(mvm,
 			"Sending device power command with flags = 0x%X\n",
 			cmd.flags);
-- 
2.38.1

