Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632E0309EE3
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhAaUYq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:24:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43164 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231137AbhAaUNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:13:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMY-0041H2-C3; Sun, 31 Jan 2021 20:22:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:05 +0200
Message-Id: <iwlwifi.20210131201908.0db829694810.I001f39d34ae46c87870d9bd94a4baaa3250578d1@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: mvm: add debugfs entry to trigger a dump as any time-point
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This is used for different tests collecting different types of
debug data from fw (e.g latency issues, hw issues etc).

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 3834d7197e11..efc908231d74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1349,6 +1349,24 @@ static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_mvm *mvm,
 	return count;
 }
 
+static ssize_t iwl_dbgfs_dbg_time_point_write(struct iwl_mvm *mvm,
+					      char *buf, size_t count,
+					      loff_t *ppos)
+{
+	u32 timepoint;
+
+	if (kstrtou32(buf, 0, &timepoint))
+		return -EINVAL;
+
+	if (timepoint == IWL_FW_INI_TIME_POINT_INVALID ||
+	    timepoint >= IWL_FW_INI_TIME_POINT_NUM)
+		return -EINVAL;
+
+	iwl_dbg_tlv_time_point(&mvm->fwrt, timepoint, NULL);
+
+	return count;
+}
+
 #define ADD_TEXT(...) pos += scnprintf(buf + pos, bufsz - pos, __VA_ARGS__)
 #ifdef CONFIG_IWLWIFI_BCAST_FILTERING
 static ssize_t iwl_dbgfs_bcast_filters_read(struct file *file,
@@ -1786,6 +1804,7 @@ MVM_DEBUGFS_WRITE_FILE_OPS(bt_force_ant, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
+MVM_DEBUGFS_WRITE_FILE_OPS(dbg_time_point, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(indirection_tbl,
 			   (IWL_RSS_INDIRECTION_TABLE_SIZE * 2));
 MVM_DEBUGFS_WRITE_FILE_OPS(inject_packet, 512);
-- 
2.29.2

