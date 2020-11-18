Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8C2B825D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKRQxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 11:53:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:49852 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgKRQxj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 11:53:39 -0500
IronPort-SDR: QPoPv6djC+gC+pmlCTw95CoKNx4fKWN69DG9lOKWDKj3ZES33O7mj8jRzfp4YG0EGDk4eXEBXM
 AlukOMwjfpbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171244557"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="171244557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:36 -0800
IronPort-SDR: Ir4GhLDFjPyRr2+EJuG+icvj/Qai9dk1bNDzi1wAON8CBYdO7+8Z6SOXkjdr9DOd+yhZ1+KB1Y
 WxowBP8oPtUw==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="534380521"
Received: from dlmurray-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.82.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:32 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     jani.nikula@intel.com, intel-gfx@lists.freedesktop.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 1/6] relay: allow the use of const callback structs
Date:   Wed, 18 Nov 2020 18:53:15 +0200
Message-Id: <20201118165320.26829-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

None of the relay users require the use of mutable structs for
callbacks, however the relay code does. Instead of assigning default
callbacks when there is none, add callback wrappers to conditionally
call the client callbacks if available, and fall back to default
behaviour (typically no-op) otherwise.

This lets all relay users make their struct rchan_callbacks const data.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: ath11k@lists.infradead.org
Cc: ath10k@lists.infradead.org
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/relay.h |   4 +-
 kernel/relay.c        | 182 +++++++++++++++++++-----------------------
 2 files changed, 86 insertions(+), 100 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e13a333e7c37..7333909df65a 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -62,7 +62,7 @@ struct rchan
 	size_t subbuf_size;		/* sub-buffer size */
 	size_t n_subbufs;		/* number of sub-buffers per buffer */
 	size_t alloc_size;		/* total buffer size allocated */
-	struct rchan_callbacks *cb;	/* client callbacks */
+	const struct rchan_callbacks *cb; /* client callbacks, may be NULL */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
@@ -170,7 +170,7 @@ struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
-			 struct rchan_callbacks *cb,
+			 const struct rchan_callbacks *cb,
 			 void *private_data);
 extern int relay_late_setup_files(struct rchan *chan,
 				  const char *base_filename,
diff --git a/kernel/relay.c b/kernel/relay.c
index b08d936d5fa7..c53676f2d10f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -27,13 +27,86 @@
 static DEFINE_MUTEX(relay_channels_mutex);
 static LIST_HEAD(relay_channels);
 
+/*
+ * rchan_callback wrappers. Call the callbacks if available, otherwise fall back
+ * to default behaviour.
+ */
+
+/*
+ * subbuf_start() callback.
+ */
+static int cb_subbuf_start(const struct rchan_callbacks *cb,
+			   struct rchan_buf *buf,
+			   void *subbuf,
+			   void *prev_subbuf,
+			   size_t prev_padding)
+{
+	if (cb && cb->subbuf_start)
+		return cb->subbuf_start(buf, subbuf, prev_subbuf, prev_padding);
+
+	if (relay_buf_full(buf))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * buf_mapped() callback.
+ */
+static void cb_buf_mapped(const struct rchan_callbacks *cb,
+			  struct rchan_buf *buf,
+			  struct file *filp)
+{
+	if (cb && cb->buf_mapped)
+		cb->buf_mapped(buf, filp);
+}
+
+/*
+ * buf_unmapped() callback.
+ */
+static void cb_buf_unmapped(const struct rchan_callbacks *cb,
+			    struct rchan_buf *buf,
+			    struct file *filp)
+{
+	if (cb && cb->buf_unmapped)
+		cb->buf_unmapped(buf, filp);
+}
+
+/*
+ * create_buf_file_create() callback.
+ */
+static struct dentry *cb_create_buf_file(const struct rchan_callbacks *cb,
+					 const char *filename,
+					 struct dentry *parent,
+					 umode_t mode,
+					 struct rchan_buf *buf,
+					 int *is_global)
+{
+	if (cb && cb->create_buf_file)
+		return cb->create_buf_file(filename, parent, mode, buf, is_global);
+
+	return NULL;
+}
+
+/*
+ * remove_buf_file() callback.
+ */
+static int cb_remove_buf_file(const struct rchan_callbacks *cb,
+			      struct dentry *dentry)
+{
+	if (cb && cb->remove_buf_file)
+		return cb->remove_buf_file(dentry);
+
+	return -EINVAL;
+}
+
 /*
  * close() vm_op implementation for relay file mapping.
  */
 static void relay_file_mmap_close(struct vm_area_struct *vma)
 {
 	struct rchan_buf *buf = vma->vm_private_data;
-	buf->chan->cb->buf_unmapped(buf, vma->vm_file);
+	cb_buf_unmapped(buf->chan->cb, buf, vma->vm_file);
 }
 
 /*
@@ -107,7 +180,7 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
 	vma->vm_ops = &relay_file_mmap_ops;
 	vma->vm_flags |= VM_DONTEXPAND;
 	vma->vm_private_data = buf;
-	buf->chan->cb->buf_mapped(buf, filp);
+	cb_buf_mapped(buf->chan->cb, buf, filp);
 
 	return 0;
 }
@@ -264,70 +337,6 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
  * High-level relay kernel API and associated functions.
  */
 
-/*
- * rchan_callback implementations defining default channel behavior.  Used
- * in place of corresponding NULL values in client callback struct.
- */
-
-/*
- * subbuf_start() default callback.  Does nothing.
- */
-static int subbuf_start_default_callback (struct rchan_buf *buf,
-					  void *subbuf,
-					  void *prev_subbuf,
-					  size_t prev_padding)
-{
-	if (relay_buf_full(buf))
-		return 0;
-
-	return 1;
-}
-
-/*
- * buf_mapped() default callback.  Does nothing.
- */
-static void buf_mapped_default_callback(struct rchan_buf *buf,
-					struct file *filp)
-{
-}
-
-/*
- * buf_unmapped() default callback.  Does nothing.
- */
-static void buf_unmapped_default_callback(struct rchan_buf *buf,
-					  struct file *filp)
-{
-}
-
-/*
- * create_buf_file_create() default callback.  Does nothing.
- */
-static struct dentry *create_buf_file_default_callback(const char *filename,
-						       struct dentry *parent,
-						       umode_t mode,
-						       struct rchan_buf *buf,
-						       int *is_global)
-{
-	return NULL;
-}
-
-/*
- * remove_buf_file() default callback.  Does nothing.
- */
-static int remove_buf_file_default_callback(struct dentry *dentry)
-{
-	return -EINVAL;
-}
-
-/* relay channel default callbacks */
-static struct rchan_callbacks default_channel_callbacks = {
-	.subbuf_start = subbuf_start_default_callback,
-	.buf_mapped = buf_mapped_default_callback,
-	.buf_unmapped = buf_unmapped_default_callback,
-	.create_buf_file = create_buf_file_default_callback,
-	.remove_buf_file = remove_buf_file_default_callback,
-};
-
 /**
  *	wakeup_readers - wake up readers waiting on a channel
  *	@work: contains the channel buffer
@@ -371,7 +380,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
 
-	buf->chan->cb->subbuf_start(buf, buf->data, NULL, 0);
+	cb_subbuf_start(buf->chan->cb, buf, buf->data, NULL, 0);
 }
 
 /**
@@ -426,9 +435,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
 
 	/* Create file in fs */
-	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
-					   S_IRUSR, buf,
-					   &chan->is_global);
+	dentry = cb_create_buf_file(chan->cb, tmpname, chan->parent,
+				    S_IRUSR, buf, &chan->is_global);
 	if (IS_ERR(dentry))
 		dentry = NULL;
 
@@ -461,9 +469,8 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		relay_set_buf_dentry(buf, dentry);
 	} else {
 		/* Only retrieve global info, nothing more, nothing less */
-		dentry = chan->cb->create_buf_file(NULL, NULL,
-						   S_IRUSR, buf,
-						   &chan->is_global);
+		dentry = cb_create_buf_file(chan->cb, NULL, NULL,
+					    S_IRUSR, buf, &chan->is_global);
 		if (IS_ERR_OR_NULL(dentry))
 			goto free_buf;
 	}
@@ -495,31 +502,10 @@ static void relay_close_buf(struct rchan_buf *buf)
 {
 	buf->finalized = 1;
 	irq_work_sync(&buf->wakeup_work);
-	buf->chan->cb->remove_buf_file(buf->dentry);
+	cb_remove_buf_file(buf->chan->cb, buf->dentry);
 	kref_put(&buf->kref, relay_remove_buf);
 }
 
-static void setup_callbacks(struct rchan *chan,
-				   struct rchan_callbacks *cb)
-{
-	if (!cb) {
-		chan->cb = &default_channel_callbacks;
-		return;
-	}
-
-	if (!cb->subbuf_start)
-		cb->subbuf_start = subbuf_start_default_callback;
-	if (!cb->buf_mapped)
-		cb->buf_mapped = buf_mapped_default_callback;
-	if (!cb->buf_unmapped)
-		cb->buf_unmapped = buf_unmapped_default_callback;
-	if (!cb->create_buf_file)
-		cb->create_buf_file = create_buf_file_default_callback;
-	if (!cb->remove_buf_file)
-		cb->remove_buf_file = remove_buf_file_default_callback;
-	chan->cb = cb;
-}
-
 int relay_prepare_cpu(unsigned int cpu)
 {
 	struct rchan *chan;
@@ -565,7 +551,7 @@ struct rchan *relay_open(const char *base_filename,
 			 struct dentry *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
-			 struct rchan_callbacks *cb,
+			 const struct rchan_callbacks *cb,
 			 void *private_data)
 {
 	unsigned int i;
@@ -597,7 +583,7 @@ struct rchan *relay_open(const char *base_filename,
 		chan->has_base_filename = 1;
 		strlcpy(chan->base_filename, base_filename, NAME_MAX);
 	}
-	setup_callbacks(chan, cb);
+	chan->cb = cb;
 	kref_init(&chan->kref);
 
 	mutex_lock(&relay_channels_mutex);
@@ -780,7 +766,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 	new_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 	new = buf->start + new_subbuf * buf->chan->subbuf_size;
 	buf->offset = 0;
-	if (!buf->chan->cb->subbuf_start(buf, new, old, buf->prev_padding)) {
+	if (!cb_subbuf_start(buf->chan->cb, buf, new, old, buf->prev_padding)) {
 		buf->offset = buf->chan->subbuf_size + 1;
 		return 0;
 	}
-- 
2.20.1

