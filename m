Return-Path: <linux-wireless+bounces-15709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0F9D94E1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9DCB24307
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA721BE23E;
	Tue, 26 Nov 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="b4JSrjOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB501BD9E4;
	Tue, 26 Nov 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613843; cv=none; b=hUI5BLQ93nE+nX/3Iy5VANsOcqKSU/QlzTy17a6zQXID64MmNPjA/n0tK8rPNDxrfha/5iKX6YcQBHD5+yhQ9wGgHOrkY+cAYSDWHczF22US1Y937s6haelwBgbrVjPUh9HNRQcLf08riRW5e6BoZZyFg2qJExUJkJCje5NIwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613843; c=relaxed/simple;
	bh=tbveivKbjBUlwd0ZIm4rNMYc5LDl6YnFN/B9E2H4n4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asyTbfd1DxPEDZRqZGQJ+abmZkSpLDf/u4ukRGygfGsypNf3m1XR3k+YCsN/9qtXcLhu/Hs7dp1amLv6QmQr3HUWmRhbjoeMpUfEHrD/hDyMkC+UmVImMJWgVHNdGYpSI0AtKCObIjoqOar0YilJC1A1DKHnrEZWPiSA4J+t9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=b4JSrjOU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pEIC/1sU0bmKvDPDkz1AyCvYOPTjdcdXDMTr4GlORKM=;
	t=1732613841; x=1733823441; b=b4JSrjOUhxhvfseeL4fQDGWThGfy7bw1gPsiY0j7/PQWV9r
	T/J6TpoCrGRR2KipsMgxAuEhlnt7e4IrE0E050hgCN4rdY5I1uv2URQvoiHNPpqzqUN0UHtklVsJ4
	UzI0ksbaiI4otVbhKDHQoDgRJOVNuegxw4xfg59pgO21dRi0TxyE1UitRYouR4mGBkos7q8ovpf5o
	ab/s7nGOs+7gDOuRWdwnVKFPy1ljF5q5YkdhkdBP8jWlsHZ7a4CczB7pd35u02l4Vm8PJ/i6anH1x
	fEm7HpjTye3DVNG66F9HwL2GKQnqmbyp/fOF97k6XLssKPndoNp+ujVfO44niwXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tFs0P-0000000FJLz-0VWR;
	Tue, 26 Nov 2024 10:37:13 +0100
Message-ID: <8221a4a01cb838159828961b6d8d99753ecc31b9.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
Date: Tue, 26 Nov 2024 10:37:12 +0100
In-Reply-To: <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com>
References: 
	<20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
	 <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
	 <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-11-26 at 09:38 +0100, Geert Uytterhoeven wrote:
> >=20
> > Thanks for your patch, which is now commit 8dc6d81c6b2acc43 ("debugfs:
> > add small file operations for most files") upstream.

Or rather "no thanks" ;-)

> > > +#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
> >=20
> > As the minimum alignment is 2 on m68k, you cannot use bit 1 in pointers
> > for your own private use.

D'oh. Sorry about that. Though honestly even if I _had_ seen such a
comment deep in maple tree code, on that struct I'd probably have
assumed it's because there's no pointer in it and thus no alignment
anyway...

But sounds like you're pointers don't need to be naturally aligned, and
so 2-byte alignment is sufficient.

I guess we _could_ solve that by __aligned(4) on the fops structs, but
... I'm not sure that makes sense.

> Reverting commit 8dc6d81c6b2acc43 fixes the issue,=C2=A0

Clearly. Though have to also revert the related patch in wireless :)

> and reduces the
> atari_defconfig kernel size by 447 bytes, according to bloat-o-meter.

Well, fair point, but if we care about size then we can win back more
than this by converting about a handful of debugfs files to short ops,
and if there are no debugfs files then we wouldn't need debugfs either,
I'd think.

So I think in a way the size argument goes the other way (with a little
bit of extra work), if that was meant to be an argument at all? :-)

Anyway, that doesn't help now ...

> If you want to support truncated debugfs_fops structures, I am
> afraid there is no other option than storing a flag, structure type,
> or structure size inside the structure. The latter would allow us
> to support not just full and short structures, but also arbitrary
> truncation, given even more opportunities for size reduction.
>=20
> E.g. something like
>=20
>     #define get_method(_ops, _op, _op_fallback) \
>             ((_ops->size > offsetof(struct debugfs_fops, _op)) ?
> _ops->_op : _op_fallback)

Yeah I thought about something like that originally, but first of all
I'd have to reorder the fields in struct file_operations I think (which
may or may not have a design to it), but also that doesn't really help
here since I'd still need a way to know the kind of struct that it was
for sizeof? And store that somewhere along the way.

But we can fix this differently, by just having different ops. We really
need to only have this bit of information for the very first open, after
that we've already allocated the structures. So duplicating the full
proxy struct (as as big as that may be, need to convert one more debugfs
file to win it back), we should be able to remove the need for the
pointer tag.

Below changes should fix the issue, but is only lightly tested so far
(with regular and short ops files). Perhaps you'd like to give it a
spin?

johannes


From: Johannes Berg <johannes.berg@intel.com>
Date: Tue, 26 Nov 2024 10:29:23 +0100
Subject: [PATCH] fs: debugfs: differentiate short fops with proxy ops

Geert reported that my previous short fops debugfs changes
broke m68k, because it only has mandatory alignement of two,
so we can't stash the "is it short" information into the
pointer (as we already did with the "is it real" bit.)

Instead, exploit the fact that debugfs_file_get() called on
an already open file will already find that the fsdata is
no longer the real fops but rather the allocated data that
already distinguishes full/short ops, so only open() needs
to be able to distinguish. We can achieve that by using two
different open functions.

Unfortunately this requires another set of full file ops,
increasing the size by 536 bytes (x86-64), but that's still
a reasonable trade-off given that only converting some of
the wireless stack gained over 28k. This brings the total
cost of this to around 1k, for wins of 28k (all x86-64).

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfa=
PWDKiQ@mail.gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     | 72 ++++++++++++++++++++++++++++++-------------
 fs/debugfs/inode.c    | 11 +++----
 fs/debugfs/internal.h |  6 +---
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 47dc96dfe386..bdb4f2ca0506 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -64,22 +64,13 @@ const struct file_operations *debugfs_real_fops(const s=
truct file *filp)
 }
 EXPORT_SYMBOL_GPL(debugfs_real_fops);
=20
-/**
- * debugfs_file_get - mark the beginning of file data access
- * @dentry: the dentry object whose data is being accessed.
- *
- * Up to a matching call to debugfs_file_put(), any successive call
- * into the file removing functions debugfs_remove() and
- * debugfs_remove_recursive() will block. Since associated private
- * file data may only get freed after a successful return of any of
- * the removal functions, you may safely access it after a successful
- * call to debugfs_file_get() without worrying about lifetime issues.
- *
- * If -%EIO is returned, the file has already been removed and thus,
- * it is not safe to access any of its data. If, on the other hand,
- * it is allowed to access the file data, zero is returned.
- */
-int debugfs_file_get(struct dentry *dentry)
+enum dbgfs_get_mode {
+	DBGFS_GET_ALREADY,
+	DBGFS_GET_REGULAR,
+	DBGFS_GET_SHORT,
+};
+
+static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode m=
ode)
 {
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
@@ -96,15 +87,17 @@ int debugfs_file_get(struct dentry *dentry)
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd =3D d_fsd;
 	} else {
+		if (WARN_ON(mode =3D=3D DBGFS_GET_ALREADY))
+			return -EINVAL;
+
 		fsd =3D kmalloc(sizeof(*fsd), GFP_KERNEL);
 		if (!fsd)
 			return -ENOMEM;
=20
-		if ((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT) {
+		if (mode =3D=3D DBGFS_GET_SHORT) {
 			fsd->real_fops =3D NULL;
 			fsd->short_fops =3D (void *)((unsigned long)d_fsd &
-						~(DEBUGFS_FSDATA_IS_REAL_FOPS_BIT |
-						  DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
 		} else {
 			fsd->real_fops =3D (void *)((unsigned long)d_fsd &
 						~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -138,6 +131,26 @@ int debugfs_file_get(struct dentry *dentry)
=20
 	return 0;
 }
+
+/**
+ * debugfs_file_get - mark the beginning of file data access
+ * @dentry: the dentry object whose data is being accessed.
+ *
+ * Up to a matching call to debugfs_file_put(), any successive call
+ * into the file removing functions debugfs_remove() and
+ * debugfs_remove_recursive() will block. Since associated private
+ * file data may only get freed after a successful return of any of
+ * the removal functions, you may safely access it after a successful
+ * call to debugfs_file_get() without worrying about lifetime issues.
+ *
+ * If -%EIO is returned, the file has already been removed and thus,
+ * it is not safe to access any of its data. If, on the other hand,
+ * it is allowed to access the file data, zero is returned.
+ */
+int debugfs_file_get(struct dentry *dentry)
+{
+	return __debugfs_file_get(dentry, DBGFS_GET_ALREADY);
+}
 EXPORT_SYMBOL_GPL(debugfs_file_get);
=20
 /**
@@ -424,7 +437,8 @@ static void __full_proxy_fops_init(struct file_operatio=
ns *proxy_fops,
 		proxy_fops->unlocked_ioctl =3D full_proxy_unlocked_ioctl;
 }
=20
-static int full_proxy_open(struct inode *inode, struct file *filp)
+static int full_proxy_open(struct inode *inode, struct file *filp,
+			   enum dbgfs_get_mode mode)
 {
 	struct dentry *dentry =3D F_DENTRY(filp);
 	const struct file_operations *real_fops;
@@ -432,7 +446,7 @@ static int full_proxy_open(struct inode *inode, struct =
file *filp)
 	struct debugfs_fsdata *fsd;
 	int r;
=20
-	r =3D debugfs_file_get(dentry);
+	r =3D __debugfs_file_get(dentry, mode);
 	if (r)
 		return r =3D=3D -EIO ? -ENOENT : r;
=20
@@ -491,8 +505,22 @@ static int full_proxy_open(struct inode *inode, struct=
 file *filp)
 	return r;
 }
=20
+static int full_proxy_open_regular(struct inode *inode, struct file *filp)
+{
+	return full_proxy_open(inode, filp, DBGFS_GET_REGULAR);
+}
+
 const struct file_operations debugfs_full_proxy_file_operations =3D {
-	.open =3D full_proxy_open,
+	.open =3D full_proxy_open_regular,
+};
+
+static int full_proxy_open_short(struct inode *inode, struct file *filp)
+{
+	return full_proxy_open(inode, filp, DBGFS_GET_SHORT);
+}
+
+const struct file_operations debugfs_full_short_proxy_file_operations =3D =
{
+	.open =3D full_proxy_open_short,
 };
=20
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 38a9c7eb97e6..65e46c7b6bf1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -455,8 +455,7 @@ struct dentry *debugfs_create_file_full(const char *nam=
e, umode_t mode,
 					const struct file_operations *fops)
 {
 	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
 		return ERR_PTR(-EINVAL);
=20
 	return __debugfs_create_file(name, mode, parent, data,
@@ -471,15 +470,13 @@ struct dentry *debugfs_create_file_short(const char *=
name, umode_t mode,
 					 const struct debugfs_short_fops *fops)
 {
 	if (WARN_ON((unsigned long)fops &
-		    (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
-		     DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
 		return ERR_PTR(-EINVAL);
=20
 	return __debugfs_create_file(name, mode, parent, data,
-				fops ? &debugfs_full_proxy_file_operations :
+				fops ? &debugfs_full_short_proxy_file_operations :
 					&debugfs_noop_file_operations,
-				(const void *)((unsigned long)fops |
-					       DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT));
+				fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_short);
=20
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index a3edfa4f0d8e..bbae4a228ef4 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -15,6 +15,7 @@ struct file_operations;
 extern const struct file_operations debugfs_noop_file_operations;
 extern const struct file_operations debugfs_open_proxy_file_operations;
 extern const struct file_operations debugfs_full_proxy_file_operations;
+extern const struct file_operations debugfs_full_short_proxy_file_operatio=
ns;
=20
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
@@ -40,11 +41,6 @@ struct debugfs_fsdata {
  * pointer gets its lowest bit set.
  */
 #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
-/*
- * A dentry's ->d_fsdata, when pointing to real fops, is with
- * short fops instead of full fops.
- */
-#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
=20
 /* Access BITS */
 #define DEBUGFS_ALLOW_API	BIT(0)
--=20
2.47.0



