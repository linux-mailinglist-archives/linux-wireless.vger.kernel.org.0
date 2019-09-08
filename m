Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD0ACB9C
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfIHIjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:14 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:7549 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfIHIjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:13 -0400
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:04 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:33:00 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 03/11] wil6210: add debugfs to show PMC ring content
Date:   Sun,  8 Sep 2019 11:32:47 +0300
Message-Id: <1567931575-27984-4-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

PMC is a hardware debug mechanism which allows capturing real time
debug data and stream it to host memory. The driver allocates memory
buffers and set them inside PMC ring of descriptors.
Add pmcring debugfs that application can use to read the binary
content of descriptors inside the PMC ring (cat pmcring).

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 13 +++++++++++++
 drivers/net/wireless/ath/wil6210/pmc.c     | 26 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/pmc.h     |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index fd3b2b3..50dc30e 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -959,6 +959,18 @@ static ssize_t wil_read_pmccfg(struct file *file, char __user *user_buf,
 	.llseek		= wil_pmc_llseek,
 };
 
+static int wil_pmcring_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, wil_pmcring_read, inode->i_private);
+}
+
+static const struct file_operations fops_pmcring = {
+	.open		= wil_pmcring_seq_open,
+	.release	= single_release,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+};
+
 /*---tx_mgmt---*/
 /* Write mgmt frame to this file to send it */
 static ssize_t wil_write_file_txmgmt(struct file *file, const char __user *buf,
@@ -2371,6 +2383,7 @@ static void wil6210_debugfs_init_blobs(struct wil6210_priv *wil,
 	{"back",	0644,		&fops_back},
 	{"pmccfg",	0644,		&fops_pmccfg},
 	{"pmcdata",	0444,		&fops_pmcdata},
+	{"pmcring",	0444,		&fops_pmcring},
 	{"temp",	0444,		&temp_fops},
 	{"freq",	0444,		&freq_fops},
 	{"link",	0444,		&link_fops},
diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index c49f798..4b7ac14 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/seq_file.h>
 #include "wmi.h"
 #include "wil6210.h"
 #include "txrx.h"
@@ -431,3 +432,28 @@ loff_t wil_pmc_llseek(struct file *filp, loff_t off, int whence)
 
 	return newpos;
 }
+
+int wil_pmcring_read(struct seq_file *s, void *data)
+{
+	struct wil6210_priv *wil = s->private;
+	struct pmc_ctx *pmc = &wil->pmc;
+	size_t pmc_ring_size =
+		sizeof(struct vring_rx_desc) * pmc->num_descriptors;
+
+	mutex_lock(&pmc->lock);
+
+	if (!wil_is_pmc_allocated(pmc)) {
+		wil_err(wil, "error, pmc is not allocated!\n");
+		pmc->last_cmd_status = -EPERM;
+		mutex_unlock(&pmc->lock);
+		return -EPERM;
+	}
+
+	wil_dbg_misc(wil, "pmcring_read: size %zu\n", pmc_ring_size);
+
+	seq_write(s, pmc->pring_va, pmc_ring_size);
+
+	mutex_unlock(&pmc->lock);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/wil6210/pmc.h b/drivers/net/wireless/ath/wil6210/pmc.h
index bebc8d5..92b8c4d 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.h
+++ b/drivers/net/wireless/ath/wil6210/pmc.h
@@ -25,3 +25,4 @@ void wil_pmc_alloc(struct wil6210_priv *wil,
 int wil_pmc_last_cmd_status(struct wil6210_priv *wil);
 ssize_t wil_pmc_read(struct file *, char __user *, size_t, loff_t *);
 loff_t wil_pmc_llseek(struct file *filp, loff_t off, int whence);
+int wil_pmcring_read(struct seq_file *s, void *data);
-- 
1.9.1

