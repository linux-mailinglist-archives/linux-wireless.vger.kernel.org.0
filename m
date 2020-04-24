Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07E1B7C20
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgDXQru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58058 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728822AbgDXQrt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U8-000OcH-BV; Fri, 24 Apr 2020 19:47:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:07 +0300
Message-Id: <iwlwifi.20200424194456.18bf540ab8e0.I6217488f1740f0e6accd0cecd09dfd46bad88426@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/11] iwlwifi: dump api version in yaml format
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Used for debugging what FW API we are using to understand misalignment
with API changes.

The output looks like this as a yaml format

fw_api_ver:
  0x0001:
    name: MVM_ALIVE
    cmd_ver: 99
    notif_ver: 4
  0x0108:
    name: PHY_CONTEXT_CMD
    cmd_ver: 2
    notif_ver: 0
...

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 104 +++++++++++++++++-
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 89f74116569d..6e72c27f527b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -64,6 +62,7 @@
 #include "api/commands.h"
 #include "debugfs.h"
 #include "dbg.h"
+#include <linux/seq_file.h>
 
 #define FWRT_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)		\
 struct dbgfs_##name##_data {						\
@@ -329,11 +328,108 @@ static ssize_t iwl_dbgfs_fw_dbg_domain_read(struct iwl_fw_runtime *fwrt,
 
 FWRT_DEBUGFS_READ_FILE_OPS(fw_dbg_domain, 20);
 
+struct iwl_dbgfs_fw_info_priv {
+	struct iwl_fw_runtime *fwrt;
+};
+
+struct iwl_dbgfs_fw_info_state {
+	loff_t pos;
+};
+
+static void *iwl_dbgfs_fw_info_seq_next(struct seq_file *seq,
+					void *v, loff_t *pos)
+{
+	struct iwl_dbgfs_fw_info_state *state = v;
+	struct iwl_dbgfs_fw_info_priv *priv = seq->private;
+	const struct iwl_fw *fw = priv->fwrt->fw;
+
+	*pos = ++state->pos;
+	if (*pos >= fw->ucode_capa.n_cmd_versions)
+		return NULL;
+
+	return state;
+}
+
+static void iwl_dbgfs_fw_info_seq_stop(struct seq_file *seq,
+				       void *v)
+{
+	kfree(v);
+}
+
+static void *iwl_dbgfs_fw_info_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct iwl_dbgfs_fw_info_priv *priv = seq->private;
+	const struct iwl_fw *fw = priv->fwrt->fw;
+	struct iwl_dbgfs_fw_info_state *state;
+
+	if (*pos >= fw->ucode_capa.n_cmd_versions)
+		return NULL;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+	state->pos = *pos;
+	return state;
+};
+
+static int iwl_dbgfs_fw_info_seq_show(struct seq_file *seq, void *v)
+{
+	struct iwl_dbgfs_fw_info_state *state = v;
+	struct iwl_dbgfs_fw_info_priv *priv = seq->private;
+	const struct iwl_fw *fw = priv->fwrt->fw;
+	const struct iwl_fw_cmd_version *ver;
+	u32 cmd_id;
+
+	if (!state->pos)
+		seq_puts(seq, "fw_api_ver:\n");
+
+	ver = &fw->ucode_capa.cmd_versions[state->pos];
+
+	cmd_id = iwl_cmd_id(ver->cmd, ver->group, 0);
+
+	seq_printf(seq, "  0x%04x:\n", cmd_id);
+	seq_printf(seq, "    name: %s\n",
+		   iwl_get_cmd_string(priv->fwrt->trans, cmd_id));
+	seq_printf(seq, "    cmd_ver: %d\n", ver->cmd_ver);
+	seq_printf(seq, "    notif_ver: %d\n", ver->notif_ver);
+	return 0;
+}
+
+static const struct seq_operations iwl_dbgfs_info_seq_ops = {
+	.start = iwl_dbgfs_fw_info_seq_start,
+	.next = iwl_dbgfs_fw_info_seq_next,
+	.stop = iwl_dbgfs_fw_info_seq_stop,
+	.show = iwl_dbgfs_fw_info_seq_show,
+};
+
+static int iwl_dbgfs_fw_info_open(struct inode *inode, struct file *filp)
+{
+	struct iwl_dbgfs_fw_info_priv *priv;
+
+	priv = __seq_open_private(filp, &iwl_dbgfs_info_seq_ops,
+				  sizeof(*priv));
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->fwrt = inode->i_private;
+	return 0;
+}
+
+static const struct file_operations iwl_dbgfs_fw_info_ops = {
+	.owner = THIS_MODULE,
+	.open = iwl_dbgfs_fw_info_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
 void iwl_fwrt_dbgfs_register(struct iwl_fw_runtime *fwrt,
 			    struct dentry *dbgfs_dir)
 {
 	INIT_DELAYED_WORK(&fwrt->timestamp.wk, iwl_fw_timestamp_marker_wk);
 	FWRT_DEBUGFS_ADD_FILE(timestamp_marker, dbgfs_dir, 0200);
+	FWRT_DEBUGFS_ADD_FILE(fw_info, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(send_hcmd, dbgfs_dir, 0200);
 	FWRT_DEBUGFS_ADD_FILE(fw_dbg_domain, dbgfs_dir, 0400);
 }
-- 
2.26.2

