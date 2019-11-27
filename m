Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B837810B382
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0Qg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 11:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0Qg3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 11:36:29 -0500
Received: from localhost.localdomain (unknown [151.66.39.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29CC206E0;
        Wed, 27 Nov 2019 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574872589;
        bh=3VLJqxCQjFvxAyrOFl2IE9KQg3hKgSQNKDerByq8aJg=;
        h=From:To:Cc:Subject:Date:From;
        b=sBOBD7dqjQbCliCEjJE5m4NgPa99JHh69iSGw9vQFqFIhcE/J57dKeph1o86VKOqv
         jL8K6Hk7DVPrpiWkLPSQQ/z3Ts7G+XFCxBNz11UYEXx6azcxiSsox/EEGPA1yXm6Yx
         7nIdSLjwXK/nRptcn+PFMAzhluNQgW3yvoMOyBJo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        toke@redhat.com, kyan@google.com
Subject: [PATCH] mac80211: debugfs: improve airtime_flags handler readability
Date:   Wed, 27 Nov 2019 17:36:15 +0100
Message-Id: <9df7e40b45e95bb0b320317831455beaed1ee3ee.1574872357.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve airtime_flags debugfs handler readability reporting configured
airtime flags in both numeric and human readable manner

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/debugfs.c | 59 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index ad41d74530c6..f90d136bc1e0 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -150,6 +150,62 @@ static const struct file_operations aqm_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t airtime_flags_read(struct file *file,
+				  char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[128] = {}, *pos, *end;
+
+	pos = buf;
+	end = pos + sizeof(buf) - 1;
+
+	if (local->airtime_flags & AIRTIME_USE_TX)
+		pos += scnprintf(pos, end - pos, "AIRTIME_TX\t(%lx)\n",
+				 AIRTIME_USE_TX);
+	if (local->airtime_flags & AIRTIME_USE_RX)
+		pos += scnprintf(pos, end - pos, "AIRTIME_RX\t(%lx)\n",
+				 AIRTIME_USE_RX);
+	if (local->airtime_flags & AIRTIME_USE_AQL)
+		pos += scnprintf(pos, end - pos, "AIRTIME_AQL\t(%lx)\n",
+				 AIRTIME_USE_AQL);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf,
+				       strlen(buf));
+}
+
+static ssize_t airtime_flags_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[16];
+	size_t len;
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = 0;
+	len = strlen(buf);
+	if (len > 0 && buf[len - 1] == '\n')
+		buf[len - 1] = 0;
+
+	if (kstrtou16(buf, 0, &local->airtime_flags))
+		return -EINVAL;
+
+	return count;
+}
+
+static const struct file_operations airtime_flags_ops = {
+	.write = airtime_flags_write,
+	.read = airtime_flags_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static ssize_t aql_txq_limit_read(struct file *file,
 				  char __user *user_buf,
 				  size_t count,
@@ -522,8 +578,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
 
-	debugfs_create_u16("airtime_flags", 0600,
-			   phyd, &local->airtime_flags);
+	DEBUGFS_ADD_MODE(airtime_flags, 0600);
 
 	DEBUGFS_ADD(aql_txq_limit);
 	debugfs_create_u32("aql_threshold", 0600,
-- 
2.21.0

