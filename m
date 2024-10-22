Return-Path: <linux-wireless+bounces-14322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1329AA2E3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A52A1F21D72
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D919DFA2;
	Tue, 22 Oct 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h1og87ef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223A199FC1;
	Tue, 22 Oct 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603127; cv=none; b=V/sQNTGcz9q66h33+aWx6E4mjJ+IJNh65nuyOVMJFJfmDOUL3oXK9bEci3U5VoO31OxpKeK/mpElnQOTdcRx9ze3zTx93/GL2qn9NLSAqXsc1UCt4/Lr5RWZkc5H6NwsvzZWOjbvqUrCzLG9LPm3kbzAvXLpbNQS8S2QnoTBMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603127; c=relaxed/simple;
	bh=JXeA9f9ZU8fzBG5Ks9xIi8Hy9pIFb1RjeB8CIKY2wFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsTMb08R0GqWoemPKoPxMt3ako67f5+LXI87dY34OSgP1cSN3iOg/xisFIWdwRTH0NTrBn/kz9n90Zb9FQvWBUjSSUfHcSf53Q6ZMwINwYMbGIVUjZ42roJWLrij4ItxhaAufOqdmRq7ipiXH3rtY1glEp6P+1XstyEcVdn7GKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h1og87ef; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UlHPtrVDT+8KvtGV3nqOQUJWrAbnJHpMCx5doe0bv8s=; t=1729603125; x=1730812725; 
	b=h1og87ef6RPmR7RP/uJ8T1z2xzx9S6kkKs5MjcnOBBCGjFHx2noCZGDE11NvM93OyHDp95YZPTn
	JqucfiLGWNfLmo3TJSCvVmc9BZ6UAV2BXcckS6/p5/EWK1+We1mpAcDfW/6tBahvvy6/ogr7a5XjF
	t8YQ9z6/PkCqwf5gf7MRZ+LRB4uZxMaY9F4+c7+P+r01IdUVOsyg82uxa/DaYczhPSNuWzVy3kOGS
	Fal7YXbB0QgtkhzvgRevyR9bthFtAgNdMN/t+flW6kWDUkCx1RFiBMku2jTpJFlxN2DP6YjuA67k6
	jH+yTRjzpOqiGr1dferM7R1Gbi+sJciz7JPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3EmW-00000001kNb-3ZGx;
	Tue, 22 Oct 2024 15:18:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] debugfs: add small file operations for most files
Date: Tue, 22 Oct 2024 15:18:34 +0200
Message-ID: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As struct file_operations is really big, but (most) debugfs
files only use simple_open, read, write and perhaps seek, and
don't need anything else, this wastes a lot of space for NULL
pointers.

Add a struct debugfs_short_fops and some bookkeeping code in
debugfs so that users can use that with debugfs_create_file()
using _Generic to figure out which function to use.

Converting mac80211 to use it where possible saves quite a
bit of space:

1010127  205064    1220 1216411  128f9b net/mac80211/mac80211.ko (before)
 981199  205064    1220 1187483  121e9b net/mac80211/mac80211.ko (after)
-------
 -28928 = ~28KiB

With a marginal space cost in debugfs:

   8701	    550	     16	   9267	   2433	fs/debugfs/inode.o (before)
  25233	    325	     32	  25590	   63f6	fs/debugfs/file.o  (before)
   8914	    558	     16	   9488	   2510	fs/debugfs/inode.o (after)
  25380	    325	     32	  25737	   6489	fs/debugfs/file.o  (after)
---------------
   +360      +8

(All on x86-64)

A simple spatch suggests there are more than 300 instances,
not even counting the ones hidden in macros like in mac80211,
that could be trivially converted, for additional savings of
about 240 bytes for each.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c       | 100 ++++++++++++++++++++++++++++------------
 fs/debugfs/inode.c      |  63 +++++++++++--------------
 fs/debugfs/internal.h   |   6 +++
 include/linux/debugfs.h |  62 +++++++++++++++++++++++--
 4 files changed, 160 insertions(+), 71 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 67299e8b734e..47dc96dfe386 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -100,8 +100,16 @@ int debugfs_file_get(struct dentry *dentry)
 		if (!fsd)
 			return -ENOMEM;
 
-		fsd->real_fops = (void *)((unsigned long)d_fsd &
-					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+		if ((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT) {
+			fsd->real_fops = NULL;
+			fsd->short_fops = (void *)((unsigned long)d_fsd &
+						~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
+						  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+		} else {
+			fsd->real_fops = (void *)((unsigned long)d_fsd &
+						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+			fsd->short_fops = NULL;
+		}
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);
 		INIT_LIST_HEAD(&fsd->cancellations);
@@ -241,9 +249,10 @@ static int debugfs_locked_down(struct inode *inode,
 {
 	if ((inode->i_mode & 07777 & ~0444) == 0 &&
 	    !(filp->f_mode & FMODE_WRITE) &&
-	    !real_fops->unlocked_ioctl &&
-	    !real_fops->compat_ioctl &&
-	    !real_fops->mmap)
+	    (!real_fops ||
+	     (!real_fops->unlocked_ioctl &&
+	      !real_fops->compat_ioctl &&
+	      !real_fops->mmap)))
 		return 0;
 
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
@@ -316,19 +325,38 @@ static ret_type full_proxy_ ## name(proto)				\
 	return r;							\
 }
 
-FULL_PROXY_FUNC(llseek, loff_t, filp,
-		PROTO(struct file *filp, loff_t offset, int whence),
-		ARGS(filp, offset, whence));
+#define FULL_PROXY_FUNC_BOTH(name, ret_type, filp, proto, args)		\
+static ret_type full_proxy_ ## name(proto)				\
+{									\
+	struct dentry *dentry = F_DENTRY(filp);				\
+	struct debugfs_fsdata *fsd;					\
+	ret_type r;							\
+									\
+	r = debugfs_file_get(dentry);					\
+	if (unlikely(r))						\
+		return r;						\
+	fsd = dentry->d_fsdata;						\
+	if (fsd->real_fops)						\
+		r = fsd->real_fops->name(args);				\
+	else								\
+		r = fsd->short_fops->name(args);			\
+	debugfs_file_put(dentry);					\
+	return r;							\
+}
 
-FULL_PROXY_FUNC(read, ssize_t, filp,
-		PROTO(struct file *filp, char __user *buf, size_t size,
-			loff_t *ppos),
-		ARGS(filp, buf, size, ppos));
+FULL_PROXY_FUNC_BOTH(llseek, loff_t, filp,
+		     PROTO(struct file *filp, loff_t offset, int whence),
+		     ARGS(filp, offset, whence));
 
-FULL_PROXY_FUNC(write, ssize_t, filp,
-		PROTO(struct file *filp, const char __user *buf, size_t size,
-			loff_t *ppos),
-		ARGS(filp, buf, size, ppos));
+FULL_PROXY_FUNC_BOTH(read, ssize_t, filp,
+		     PROTO(struct file *filp, char __user *buf, size_t size,
+			   loff_t *ppos),
+		     ARGS(filp, buf, size, ppos));
+
+FULL_PROXY_FUNC_BOTH(write, ssize_t, filp,
+		     PROTO(struct file *filp, const char __user *buf,
+			   size_t size, loff_t *ppos),
+		     ARGS(filp, buf, size, ppos));
 
 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
@@ -363,7 +391,7 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 	 * not to leak any resources. Releasers must not assume that
 	 * ->i_private is still being meaningful here.
 	 */
-	if (real_fops->release)
+	if (real_fops && real_fops->release)
 		r = real_fops->release(inode, filp);
 
 	replace_fops(filp, d_inode(dentry)->i_fop);
@@ -373,39 +401,48 @@ static int full_proxy_release(struct inode *inode, struct file *filp)
 }
 
 static void __full_proxy_fops_init(struct file_operations *proxy_fops,
-				const struct file_operations *real_fops)
+				   struct debugfs_fsdata *fsd)
 {
 	proxy_fops->release = full_proxy_release;
-	if (real_fops->llseek)
+
+	if ((fsd->real_fops && fsd->real_fops->llseek) ||
+	    (fsd->short_fops && fsd->short_fops->llseek))
 		proxy_fops->llseek = full_proxy_llseek;
-	if (real_fops->read)
+
+	if ((fsd->real_fops && fsd->real_fops->read) ||
+	    (fsd->short_fops && fsd->short_fops->read))
 		proxy_fops->read = full_proxy_read;
-	if (real_fops->write)
+
+	if ((fsd->real_fops && fsd->real_fops->write) ||
+	    (fsd->short_fops && fsd->short_fops->write))
 		proxy_fops->write = full_proxy_write;
-	if (real_fops->poll)
+
+	if (fsd->real_fops && fsd->real_fops->poll)
 		proxy_fops->poll = full_proxy_poll;
-	if (real_fops->unlocked_ioctl)
+
+	if (fsd->real_fops && fsd->real_fops->unlocked_ioctl)
 		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
 }
 
 static int full_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
-	const struct file_operations *real_fops = NULL;
+	const struct file_operations *real_fops;
 	struct file_operations *proxy_fops = NULL;
+	struct debugfs_fsdata *fsd;
 	int r;
 
 	r = debugfs_file_get(dentry);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
 
-	real_fops = debugfs_real_fops(filp);
-
+	fsd = dentry->d_fsdata;
+	real_fops = fsd->real_fops;
 	r = debugfs_locked_down(inode, filp, real_fops);
 	if (r)
 		goto out;
 
-	if (!fops_get(real_fops)) {
+	if (real_fops && !fops_get(real_fops)) {
 #ifdef CONFIG_MODULES
 		if (real_fops->owner &&
 		    real_fops->owner->state == MODULE_STATE_GOING) {
@@ -426,11 +463,14 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		r = -ENOMEM;
 		goto free_proxy;
 	}
-	__full_proxy_fops_init(proxy_fops, real_fops);
+	__full_proxy_fops_init(proxy_fops, fsd);
 	replace_fops(filp, proxy_fops);
 
-	if (real_fops->open) {
-		r = real_fops->open(inode, filp);
+	if (!real_fops || real_fops->open) {
+		if (real_fops)
+			r = real_fops->open(inode, filp);
+		else
+			r = simple_open(inode, filp);
 		if (r) {
 			replace_fops(filp, d_inode(dentry)->i_fop);
 			goto free_proxy;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 66d9b3b4c588..38a9c7eb97e6 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -412,7 +412,7 @@ static struct dentry *end_creating(struct dentry *dentry)
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 				struct dentry *parent, void *data,
 				const struct file_operations *proxy_fops,
-				const struct file_operations *real_fops)
+				const void *real_fops)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -450,49 +450,38 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	return end_creating(dentry);
 }
 
-/**
- * debugfs_create_file - create a file in the debugfs filesystem
- * @name: a pointer to a string containing the name of the file to create.
- * @mode: the permission that the file should have.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is NULL, then the
- *          file will be created in the root of the debugfs filesystem.
- * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.i_private pointer will point to this value on
- *        the open() call.
- * @fops: a pointer to a struct file_operations that should be used for
- *        this file.
- *
- * This is the basic "create a file" function for debugfs.  It allows for a
- * wide range of flexibility in creating a file, or a directory (if you want
- * to create a directory, the debugfs_create_dir() function is
- * recommended to be used instead.)
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value -%ENODEV will be
- * returned.
- *
- * NOTE: it's expected that most callers should _ignore_ the errors returned
- * by this function. Other debugfs functions handle the fact that the "dentry"
- * passed to them could be an error and they don't crash in that case.
- * Drivers should generally work fine even if debugfs fails to init anyway.
- */
-struct dentry *debugfs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
-				   const struct file_operations *fops)
+struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
+					struct dentry *parent, void *data,
+					const struct file_operations *fops)
 {
+	if (WARN_ON((unsigned long)fops &
+		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
+		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return ERR_PTR(-EINVAL);
 
 	return __debugfs_create_file(name, mode, parent, data,
 				fops ? &debugfs_full_proxy_file_operations :
 					&debugfs_noop_file_operations,
 				fops);
 }
-EXPORT_SYMBOL_GPL(debugfs_create_file);
+EXPORT_SYMBOL_GPL(debugfs_create_file_full);
+
+struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
+					 struct dentry *parent, void *data,
+					 const struct debugfs_short_fops *fops)
+{
+	if (WARN_ON((unsigned long)fops &
+		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
+		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return ERR_PTR(-EINVAL);
+
+	return __debugfs_create_file(name, mode, parent, data,
+				fops ? &debugfs_full_proxy_file_operations :
+					&debugfs_noop_file_operations,
+				(const void *)((unsigned long)fops |
+					       DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+}
+EXPORT_SYMBOL_GPL(debugfs_create_file_short);
 
 /**
  * debugfs_create_file_unsafe - create a file in the debugfs filesystem
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index dae80c2a469e..a3edfa4f0d8e 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -18,6 +18,7 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
+	const struct debugfs_short_fops *short_fops;
 	union {
 		/* automount_fn is used when real_fops is NULL */
 		debugfs_automount_t automount;
@@ -39,6 +40,11 @@ struct debugfs_fsdata {
  * pointer gets its lowest bit set.
  */
 #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
+/*
+ * A dentry's ->d_fsdata, when pointing to real fops, is with
+ * short fops instead of full fops.
+ */
+#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
 
 /* Access BITS */
 #define DEBUGFS_ALLOW_API	BIT(0)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 0928a6c8ae1e..59444b495d49 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -71,9 +71,63 @@ typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 
 struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
 
-struct dentry *debugfs_create_file(const char *name, umode_t mode,
-				   struct dentry *parent, void *data,
-				   const struct file_operations *fops);
+struct debugfs_short_fops {
+	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
+	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
+	loff_t (*llseek) (struct file *, loff_t, int);
+};
+
+struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
+					struct dentry *parent, void *data,
+					const struct file_operations *fops);
+struct dentry *debugfs_create_file_short(const char *name, umode_t mode,
+					 struct dentry *parent, void *data,
+					 const struct debugfs_short_fops *fops);
+
+/**
+ * debugfs_create_file - create a file in the debugfs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations or struct debugfs_short_fops that
+ *        should be used for this file.
+ *
+ * This is the basic "create a file" function for debugfs.  It allows for a
+ * wide range of flexibility in creating a file, or a directory (if you want
+ * to create a directory, the debugfs_create_dir() function is
+ * recommended to be used instead.)
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ *
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ *
+ * If fops points to a struct debugfs_short_fops, then simple_open() will be
+ * used for the open, and only read/write/llseek are supported and are proxied,
+ * so no module reference or release are needed.
+ *
+ * NOTE: it's expected that most callers should _ignore_ the errors returned
+ * by this function. Other debugfs functions handle the fact that the "dentry"
+ * passed to them could be an error and they don't crash in that case.
+ * Drivers should generally work fine even if debugfs fails to init anyway.
+ */
+#define debugfs_create_file(name, mode, parent, data, fops)			\
+	_Generic(fops,								\
+		 const struct file_operations *: debugfs_create_file_full,	\
+		 const struct debugfs_short_fops *: debugfs_create_file_short,	\
+		 struct file_operations *: debugfs_create_file_full,		\
+		 struct debugfs_short_fops *: debugfs_create_file_short)	\
+		(name, mode, parent, data, fops)
+
 struct dentry *debugfs_create_file_unsafe(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
@@ -207,7 +261,7 @@ static inline struct dentry *debugfs_lookup(const char *name,
 
 static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
-					const struct file_operations *fops)
+					const void *fops)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.47.0


