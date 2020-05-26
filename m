Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D01ADAE1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgDQKV5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56594 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729038AbgDQKV4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:56 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO89-000Kba-Me; Fri, 17 Apr 2020 13:21:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:38 +0300
Message-Id: <iwlwifi.20200417131727.491cf8224c49.I7f154d81e5becef3b5ff22d7c6e36170bde0d7d5@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/10] iwlwifi: pcie: use seq_file for tx_queue debugfs file
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On newer hardware, the tx_queue debugfs file would need to
allocate 37.5kib data since there are 512 queues, which is
too much. Rather than resorting to kludges like kvmalloc(),
use the seq_file API to print out the data.

While at it, also fix a NULL pointer dereference here, the
txq pointer from trans_pcie->txqs[] may be NULL if that
queue hasn't been allocated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 121 +++++++++++++-----
 1 file changed, 89 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e4cbd8daa7c6..3c33c01cda60 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -70,6 +70,7 @@
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/wait.h>
+#include <linux/seq_file.h>
 
 #include "iwl-drv.h"
 #include "iwl-trans.h"
@@ -2544,44 +2545,94 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 	.llseek = generic_file_llseek,					\
 };
 
-static ssize_t iwl_dbgfs_tx_queue_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+struct iwl_dbgfs_tx_queue_priv {
+	struct iwl_trans *trans;
+};
+
+struct iwl_dbgfs_tx_queue_state {
+	loff_t pos;
+};
+
+static void *iwl_dbgfs_tx_queue_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state;
+
+	if (*pos >= priv->trans->trans_cfg->base_params->num_of_queues)
+		return NULL;
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+	state->pos = *pos;
+	return state;
+}
+
+static void *iwl_dbgfs_tx_queue_seq_next(struct seq_file *seq,
+					 void *v, loff_t *pos)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state = v;
+
+	*pos = ++state->pos;
+
+	if (*pos >= priv->trans->trans_cfg->base_params->num_of_queues)
+		return NULL;
+
+	return state;
+}
+
+static void iwl_dbgfs_tx_queue_seq_stop(struct seq_file *seq, void *v)
+{
+	kfree(v);
+}
+
+static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state = v;
+	struct iwl_trans *trans = priv->trans;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq;
-	char *buf;
-	int pos = 0;
-	int cnt;
-	int ret;
-	size_t bufsz;
+	struct iwl_txq *txq = trans_pcie->txq[state->pos];
+
+	seq_printf(seq, "hwq %.3u: used=%d stopped=%d ",
+		   (unsigned int)state->pos,
+		   !!test_bit(state->pos, trans_pcie->queue_used),
+		   !!test_bit(state->pos, trans_pcie->queue_stopped));
+	if (txq)
+		seq_printf(seq,
+			   "read=%u write=%u need_update=%d frozen=%d",
+			   txq->read_ptr, txq->write_ptr,
+			   txq->need_update, txq->frozen);
+	else
+		seq_puts(seq, "(unallocated)");
 
-	bufsz = sizeof(char) * 75 *
-		trans->trans_cfg->base_params->num_of_queues;
+	if (state->pos == trans_pcie->cmd_queue)
+		seq_puts(seq, " (HCMD)");
+	seq_puts(seq, "\n");
 
-	if (!trans_pcie->txq_memory)
-		return -EAGAIN;
+	return 0;
+}
 
-	buf = kzalloc(bufsz, GFP_KERNEL);
-	if (!buf)
+static const struct seq_operations iwl_dbgfs_tx_queue_seq_ops = {
+	.start = iwl_dbgfs_tx_queue_seq_start,
+	.next = iwl_dbgfs_tx_queue_seq_next,
+	.stop = iwl_dbgfs_tx_queue_seq_stop,
+	.show = iwl_dbgfs_tx_queue_seq_show,
+};
+
+static int iwl_dbgfs_tx_queue_open(struct inode *inode, struct file *filp)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv;
+
+	priv = __seq_open_private(filp, &iwl_dbgfs_tx_queue_seq_ops,
+				  sizeof(*priv));
+
+	if (!priv)
 		return -ENOMEM;
 
-	for (cnt = 0;
-	     cnt < trans->trans_cfg->base_params->num_of_queues;
-	     cnt++) {
-		txq = trans_pcie->txq[cnt];
-		pos += scnprintf(buf + pos, bufsz - pos,
-				"hwq %.2d: read=%u write=%u use=%d stop=%d need_update=%d frozen=%d%s\n",
-				cnt, txq->read_ptr, txq->write_ptr,
-				!!test_bit(cnt, trans_pcie->queue_used),
-				 !!test_bit(cnt, trans_pcie->queue_stopped),
-				 txq->need_update, txq->frozen,
-				 (cnt == trans_pcie->cmd_queue ? " HCMD" : ""));
-	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-	kfree(buf);
-	return ret;
+	priv->trans = inode->i_private;
+	return 0;
 }
 
 static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
@@ -2914,9 +2965,15 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
 DEBUGFS_READ_FILE_OPS(fh_reg);
 DEBUGFS_READ_FILE_OPS(rx_queue);
-DEBUGFS_READ_FILE_OPS(tx_queue);
 DEBUGFS_WRITE_FILE_OPS(csr);
 DEBUGFS_READ_WRITE_FILE_OPS(rfkill);
+static const struct file_operations iwl_dbgfs_tx_queue_ops = {
+	.owner = THIS_MODULE,
+	.open = iwl_dbgfs_tx_queue_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
 
 static const struct file_operations iwl_dbgfs_monitor_data_ops = {
 	.read = iwl_dbgfs_monitor_data_read,
-- 
2.25.1

