Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F02F9312
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbhAQOxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40742 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728893AbhAQOx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:26 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Pz-003sgA-8c; Sun, 17 Jan 2021 16:52:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:29 +0200
Message-Id: <iwlwifi.20210117164916.f5127d919656.Ib714f444390b39cbbf7eb143c5440cc890385981@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 4/9] iwlwifi: mvm: debugfs for phy-integration-ver
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dror Moshe <drorx.moshe@intel.com>

Add debugfs file to print the PHY integration version.
File name is: phy_integration_ver

Signed-off-by: Dror Moshe <drorx.moshe@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index e8e94bcef3b4..231c3489cc31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -712,6 +712,30 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	return ret;
 }
 
+static ssize_t iwl_dbgfs_phy_integration_ver_read(struct file *file,
+						  char __user *user_buf,
+						  size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	char *buf;
+	size_t bufsz;
+	int pos;
+	ssize_t ret;
+
+	bufsz = mvm->fw->phy_integration_ver_len + 2;
+	buf = kmalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos = scnprintf(buf, bufsz, "%.*s\n", mvm->fw->phy_integration_ver_len,
+			mvm->fw->phy_integration_ver);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+
+	kfree(buf);
+	return ret;
+}
+
 #define PRINT_STATS_LE32(_struct, _memb)				\
 			 pos += scnprintf(buf + pos, bufsz - pos,	\
 					  fmt_table, #_memb,		\
@@ -1754,6 +1778,7 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(disable_power_off, 64);
 MVM_DEBUGFS_READ_FILE_OPS(fw_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(drv_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(fw_ver);
+MVM_DEBUGFS_READ_FILE_OPS(phy_integration_ver);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_restart, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_nmi, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(bt_tx_prio, 10);
@@ -1966,6 +1991,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	MVM_DEBUGFS_ADD_FILE(inject_packet, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(inject_beacon_ie, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(inject_beacon_ie_restore, mvm->debugfs_dir, 0200);
+
+	if (mvm->fw->phy_integration_ver)
+		MVM_DEBUGFS_ADD_FILE(phy_integration_ver, mvm->debugfs_dir, 0400);
 #ifdef CONFIG_ACPI
 	MVM_DEBUGFS_ADD_FILE(sar_geo_profile, dbgfs_dir, 0400);
 #endif
-- 
2.29.2

