Return-Path: <linux-wireless+bounces-395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ADF803F82
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA731C20B39
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05342583;
	Mon,  4 Dec 2023 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjzHPUl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD928364AB;
	Mon,  4 Dec 2023 20:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F2C433CB;
	Mon,  4 Dec 2023 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722039;
	bh=kx3wwKw4TEMZOhuFFRzAObBwhjisOjlvcLRbnKs/AbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjzHPUl1osIP1gK6Akis35uRToP7bLZGr2g1Yil78vncE0ktdwlInX3dpKiD/Ugo1
	 KdzwKY+RRyQPkaGEd27KhQ+U21G3i3RvtU7THS6Q2Qj7jeq1U4EevGszPrkknbWRUk
	 weYZRv6+/1b0A44SUPgLFgaiYVR7u0UN6qvr6hPeyQPJX1qOanKQp9bwzyA7jB4n8d
	 wCC6V9MC9sly3wM/A+hs/tcX/ZQECay4VFPdV8MMdon/Ezvolijc8qocrAKCahehxK
	 qzd+UD+UCjkLDuirod2fjdWDqk/UcQYyBvutrV7MLKXIaXTThozgQQ4jlG75LDARBp
	 pF1v90uyATzNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/32] wifi: cfg80211: add locked debugfs wrappers
Date: Mon,  4 Dec 2023 15:32:37 -0500
Message-ID: <20231204203317.2092321-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit b590b9ae1efc30e52f81d95cdb2519a4c248b965 ]

Add wrappers for debugfs files that should be called with
the wiphy mutex held, while the file is also to be removed
under the wiphy mutex. This could otherwise deadlock when
a file is trying to acquire the wiphy mutex while the code
removing it holds the mutex but waits for the removal.

This actually works by pushing the execution of the read
or write handler to a wiphy work that can be cancelled
using the debugfs cancellation API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h |  46 ++++++++++++
 net/wireless/debugfs.c | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 153a8c3e7213d..459ef0cb774ca 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9245,4 +9245,50 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
  */
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+#ifdef CONFIG_CFG80211_DEBUGFS
+/**
+ * wiphy_locked_debugfs_read - do a locked read in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being read
+ * @buf: the buffer to fill and then read from
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy to
+ * @count: read count
+ * @ppos: read position
+ * @handler: the read handler to call (under wiphy lock)
+ * @data: additional data to pass to the read handler
+ */
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data);
+
+/**
+ * wiphy_locked_debugfs_write - do a locked write in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being written to
+ * @buf: the buffer to copy the user data to
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy from
+ * @count: read count
+ * @handler: the write handler to call (under wiphy lock)
+ * @data: additional data to pass to the write handler
+ */
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
+				   char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data);
+#endif
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 0878b162890af..40e49074e2eeb 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2009	Luis R. Rodriguez <lrodriguez@atheros.com>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2023 Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -109,3 +110,162 @@ void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 	DEBUGFS_ADD(long_retry_limit);
 	DEBUGFS_ADD(ht40allow_map);
 }
+
+struct debugfs_read_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t bufsize;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_read_work(struct wiphy *wiphy,
+					   struct wiphy_work *work)
+{
+	struct debugfs_read_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->bufsize, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_read_cancel(struct dentry *dentry,
+					     void *data)
+{
+	struct debugfs_read_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data)
+{
+	struct debugfs_read_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.bufsize = bufsize,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_read_cancel,
+		.cancel_data = &work,
+	};
+
+	/* don't leak stack data or whatever */
+	memset(buf, 0, bufsize);
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	if (work.ret < 0)
+		return work.ret;
+
+	if (WARN_ON(work.ret > bufsize))
+		return -EINVAL;
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, work.ret);
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_read);
+
+struct debugfs_write_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t count;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_write_work(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct debugfs_write_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->count, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_write_cancel(struct dentry *dentry,
+					      void *data)
+{
+	struct debugfs_write_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
+				   struct file *file, char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data)
+{
+	struct debugfs_write_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.count = count,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_write_cancel,
+		.cancel_data = &work,
+	};
+
+	/* mostly used for strings so enforce NUL-termination for safety */
+	if (count >= bufsize)
+		return -EINVAL;
+
+	memset(buf, 0, bufsize);
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_write_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	return work.ret;
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_write);
-- 
2.42.0


