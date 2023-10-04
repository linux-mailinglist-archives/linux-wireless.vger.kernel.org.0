Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C97B7C4E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbjJDJhQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242043AbjJDJhL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F57C6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412228; x=1727948228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZdTY93OEOk8wFMSO8IRFK1mVyw77RyMySaUVFNglYA=;
  b=I59HpyBseYJgMkBRJSeGDauTrMZ9+zgzQ7ibEKmFxTvMt8EqAncPLT5l
   TjohBsfsEQDuYHSSzwKz6oDC0RMUYkyHaBDlDRDlYY8lhOVQe3332mkvL
   PAJqzEZvDK0xnVVhMv4ltes37XX1wwxdWOKSgBrpDUsF+Pae0xgDCS+IG
   0nB/UkRojLYWiyaY+MYmHw1M8NnNnFAONavM/HqcSEIuscCtjxX9GyYZh
   fam1Ej2ZBeuYkVy9lcO83VedSm8B8zTLm8npBLQ8AuSM7yNuNu57hl74I
   hAtruvOj2Yv+NXcISdCR557CSw0WkAB4mJnphi0NQl3IU/LdocE0P091A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611836"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415184"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415184"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, iallouch <itai.allouche@intel.com>,
        Nitsan Bar <nitsan.bar@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: add start mac ctdp sum calculation debugfs handler
Date:   Wed,  4 Oct 2023 12:36:29 +0300
Message-Id: <20231004123422.024d75df9e03.I69fdc826f2931a6e1435b450f0602ea060704697@changeid>
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

From: iallouch <itai.allouche@intel.com>

mac_ctdp_sum contains the power consumption, appears in power save
report, and is used for debugging and collection of statistics.

Add a debugfs handler to start this calculation, iff ctdp
command is supported in the firmware.

While on it, add an option to force start/stop this calculation,
which is safe from the firmware API side.

Signed-off-by: iallouch <itai.allouche@intel.com>
Signed-off-by: Nitsan Bar <nitsan.bar@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index cf27f106d4d5..2c93b5a442c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -50,8 +50,18 @@ static ssize_t iwl_dbgfs_stop_ctdp_write(struct iwl_mvm *mvm, char *buf,
 					 size_t count, loff_t *ppos)
 {
 	int ret;
+	bool force;
 
-	if (!iwl_mvm_is_ctdp_supported(mvm))
+	if (!kstrtobool(buf, &force))
+		IWL_DEBUG_INFO(mvm,
+			       "force start is %d [0=disabled, 1=enabled]\n",
+			       force);
+
+	/* we allow skipping cap support check and force stop ctdp
+	 * statistics collection and with guerantee that it is
+	 * safe to use.
+	 */
+	if (!force && !iwl_mvm_is_ctdp_supported(mvm))
 		return -EOPNOTSUPP;
 
 	if (!iwl_mvm_firmware_running(mvm) ||
@@ -65,6 +75,36 @@ static ssize_t iwl_dbgfs_stop_ctdp_write(struct iwl_mvm *mvm, char *buf,
 	return ret ?: count;
 }
 
+static ssize_t iwl_dbgfs_start_ctdp_write(struct iwl_mvm *mvm,
+					  char *buf, size_t count,
+					  loff_t *ppos)
+{
+	int ret;
+	bool force;
+
+	if (!kstrtobool(buf, &force))
+		IWL_DEBUG_INFO(mvm,
+			       "force start is %d [0=disabled, 1=enabled]\n",
+			       force);
+
+	/* we allow skipping cap support check and force enable ctdp
+	 * for statistics collection and with guerantee that it is
+	 * safe to use.
+	 */
+	if (!force && !iwl_mvm_is_ctdp_supported(mvm))
+		return -EOPNOTSUPP;
+
+	if (!iwl_mvm_firmware_running(mvm) ||
+	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
+		return -EIO;
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_ctdp_command(mvm, CTDP_CMD_OPERATION_START, 0);
+	mutex_unlock(&mvm->mutex);
+
+	return ret ?: count;
+}
+
 static ssize_t iwl_dbgfs_force_ctkill_write(struct iwl_mvm *mvm, char *buf,
 					    size_t count, loff_t *ppos)
 {
@@ -1998,6 +2038,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(prph_reg, 64);
 /* Device wide debugfs entries */
 MVM_DEBUGFS_READ_FILE_OPS(ctdp_budget);
 MVM_DEBUGFS_WRITE_FILE_OPS(stop_ctdp, 8);
+MVM_DEBUGFS_WRITE_FILE_OPS(start_ctdp, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(force_ctkill, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(tx_flush, 16);
 MVM_DEBUGFS_WRITE_FILE_OPS(sta_drain, 8);
@@ -2210,6 +2251,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(nic_temp, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(ctdp_budget, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(stop_ctdp, mvm->debugfs_dir, 0200);
+	MVM_DEBUGFS_ADD_FILE(start_ctdp, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(force_ctkill, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(stations, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(bt_notif, mvm->debugfs_dir, 0400);
-- 
2.38.1

