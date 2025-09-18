Return-Path: <linux-wireless+bounces-27334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F0B58D3C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 06:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F931BC60AE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E32DF3EC;
	Tue, 16 Sep 2025 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKyZvaPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FD21B9DB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998123; cv=none; b=eksmFtc9ics67jk1mHWpG/R/NbxTHZLvEDmmw9udXwPfowGQla23dfg+j8FjcLqoplDZpAOwSP6iDB4UhtuRUldDgjaEAtEeyeVvZbtu5Ce73rrPVhsrkbjaE6a+Z13Nym3efBg7ZVfRWA6veQk16dVJiJVFRZipdslDy6wULV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998123; c=relaxed/simple;
	bh=Hm4NLUtLCw7Wzvkssx4JW3u0p75F9SUYO1JV5MhRUUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcG80L/8uQk99kyS3+nDJd/3EWBVFBkm2bVZdCNQmqXeiPgRo+v4mB1PvmR2cW/bYo9HvO0mXnlE3kgy6ejNBm+2UhZG7mrdt8oL4N63VS1eni22bBc9994074w6j/vtG7yM8IA5ffr+s1Lr82JGi/KpL3vcQPqivZUd+MIHhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKyZvaPI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4d4881897cso3280104a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 21:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998121; x=1758602921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm+DpSE/kXVFYqhbqdQrPOPEWNbTRdYIBwHbzMQMXkY=;
        b=QKyZvaPIVDM/Vpv2T4hnaFkdhAmHbw+v0O1IpLFtzRuLX/FL65xWVUPIMC9ztxn2RA
         ozTswSrCVtPfLZmkfzBSMg2AduT72IAId2sTdAGHG4uhrBhNBCxXLxiF0SCKiwyDaPum
         gMup5ejYfjKSMIFdvMykdpeor8qpqiLOJrEUZToKaz14PngK3rA9KdO72myiL4D4E5Ib
         adSB/d/rVVOG4tWa3eIH98PaGav99JKZ9arAcseAJpw3rB58Chul1M6oYbO8ERgRkXbX
         Q1oT69QidZy+bxqCTehceAVz7Y8UZgOcHvVxBIfqODoqXkT0xSBFDPOn9iWj4TE/ZfGK
         AjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998121; x=1758602921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm+DpSE/kXVFYqhbqdQrPOPEWNbTRdYIBwHbzMQMXkY=;
        b=VdSXCMP2lvv+rxmfj1qwBQV9K2lDhMMrX6ipKNEdvPe/oigz8tNpprhnU2nYn8VGyw
         Il7u0/XH4VdhZb8hNlzcbHEShcjB6duj4hpWfMB5U3xxV9/Wv3ThP91hCb4ZTs52+3wd
         G7swMGbRPfOAl/QcFN/bN1ZrnT2BjZqjpZAMH9SuQw1VlxWXzq1CZ8bd38FIIcFcWFUV
         SRHGLb3p3Uu04dJUsooYBfqK4Wdv0RRHiVDiFFVV5EQeXpufIndg7j9ZqOU77uG8pKbh
         7bexe3CKrCvLSmCeYwH8+mfiCGiOTdERCY9s0++GP8PYDqf/GZWmgqYT+cgyb3ICMlCY
         09gg==
X-Forwarded-Encrypted: i=1; AJvYcCXOJodezbJ14x0QF9Iwo2qGFUW/vKbwc0YZHCBJ+dHHU218X1oWS6bYBEVgQY1zCSoTU6CieWuZH3GGAvAV/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE27vUJ7KEYHgMzEt8MZPoh1BqydUwTsPrSkS0YY8pva7zNa3
	nevw4Q4RX0T2kvKpwLaxi20ML9X6gNdNVCb8Lv4Hgigrj/QV38WLp1vrliqqFmSiRqQ=
X-Gm-Gg: ASbGncuW0z2thkMadjX9cJQ0N1oPkL6AWWCFW9VgYeXljU+/4c/H/22kcZ8l8y/NuGx
	FCtLnG0jae/6RnyEetwHOe0CRHJYnHQHyCGvOxRVVdI0wQORCYN62CfOcZcIdL/7YOhGh6P5S8C
	nQPYY2n8rcXpyZ6Ltusb8IeWOdwocdMY5N4ZkQn3TuVTnSF+iwzaR4msZAWqQjj0y6PcmX1fJ0L
	p1rR70JyoxHBgn0z4ngH0hjboqCoGs9gvVZh4yjt68y0pnUTgdsHacWECMN2VbCkT/4qzzBI7I7
	lh5XmF6JLrTURCmY3/3kmegkYibcMn2VR5OjZubnhn1KPErrypn2sZfZkvPVst9QQqCiBep/V82
	SLPZfyLjgCivEJZ/lHqqWl03unTgcV9DOEnsmGJDEsRj/vHjsxA==
X-Google-Smtp-Source: AGHT+IFZafMscSK5thkkO6qp1JFhXaEzM4XqUKCSOF7a0iBvVAfuiUQIiiPw+R0HXGd/Rlng97VAjQ==
X-Received: by 2002:a17:903:1a07:b0:267:a20c:fec0 with SMTP id d9443c01a7336-267a20d0722mr60340985ad.1.1757998120540;
        Mon, 15 Sep 2025 21:48:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:39 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 04/14] nfs: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:25 +0800
Message-Id: <20250916044735.2316171-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/nfs/callback_proc.c |  2 --
 fs/nfs/nfs4state.c     |  2 --
 fs/nfs/pnfs.c          | 12 +-----------
 fs/nfs/pnfs_dev.c      |  4 ----
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..16144db39335 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -721,7 +721,6 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 		return cpu_to_be32(NFS4ERR_DELAY);
 
 	spin_lock(&cps->clp->cl_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(server, &cps->clp->cl_superblocks,
 				client_link) {
 		list_for_each_entry(tmp_copy, &server->ss_copies, copies) {
@@ -736,7 +735,6 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
 		}
 	}
 out:
-	rcu_read_unlock();
 	if (!found) {
 		memcpy(&copy->stateid, &args->coa_stateid, NFS4_STATEID_SIZE);
 		nfs4_copy_cb_args(copy, args);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7612e977e80b..598229fc07ed 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -241,13 +241,11 @@ const struct cred *nfs4_get_renew_cred(struct nfs_client *clp)
 		goto out;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		cred = nfs4_get_renew_cred_server_locked(server);
 		if (cred != NULL)
 			break;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
 out:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..650f86fa144a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -838,13 +838,12 @@ pnfs_layout_add_bulk_destroy_list(struct inode *inode,
 	return ret;
 }
 
-/* Caller must hold rcu_read_lock and clp->cl_lock */
+/* Caller must hold clp->cl_lock (implies rcu_read_lock) */
 static int
 pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 		struct nfs_server *server,
 		struct list_head *layout_list)
 	__must_hold(&clp->cl_lock)
-	__must_hold(RCU)
 {
 	struct pnfs_layout_hdr *lo, *next;
 	struct inode *inode;
@@ -862,16 +861,13 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 			if (pnfs_layout_add_bulk_destroy_list(inode,
 						layout_list))
 				continue;
-			rcu_read_unlock();
 			spin_unlock(&clp->cl_lock);
 			iput(inode);
 		} else {
-			rcu_read_unlock();
 			spin_unlock(&clp->cl_lock);
 		}
 		nfs_sb_deactive(server->super);
 		spin_lock(&clp->cl_lock);
-		rcu_read_lock();
 		return -EAGAIN;
 	}
 	return 0;
@@ -922,7 +918,6 @@ int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
 	LIST_HEAD(layout_list);
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (memcmp(&server->fsid, fsid, sizeof(*fsid)) != 0)
@@ -932,7 +927,6 @@ int pnfs_layout_destroy_byfsid(struct nfs_client *clp, struct nfs_fsid *fsid,
 				&layout_list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 
 	return pnfs_layout_free_bulk_destroy_list(&layout_list, mode);
@@ -944,14 +938,12 @@ static void pnfs_layout_build_destroy_list_byclient(struct nfs_client *clp,
 	struct nfs_server *server;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (pnfs_layout_bulk_destroy_byserver_locked(clp, server,
 							     list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 }
 
@@ -990,7 +982,6 @@ static void pnfs_layout_build_recover_list_byclient(struct nfs_client *clp,
 	struct nfs_server *server;
 
 	spin_lock(&clp->cl_lock);
-	rcu_read_lock();
 restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		if (!(server->caps & NFS_CAP_REBOOT_LAYOUTRETURN))
@@ -999,7 +990,6 @@ static void pnfs_layout_build_recover_list_byclient(struct nfs_client *clp,
 							     list) != 0)
 			goto restart;
 	}
-	rcu_read_unlock();
 	spin_unlock(&clp->cl_lock);
 }
 
diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index bf0f2d67e96c..d19752ec1a95 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -231,9 +231,7 @@ nfs4_delete_deviceid(const struct pnfs_layoutdriver_type *ld,
 	struct nfs4_deviceid_node *d;
 
 	spin_lock(&nfs4_deviceid_lock);
-	rcu_read_lock();
 	d = _lookup_deviceid(ld, clp, id, nfs4_deviceid_hash(id));
-	rcu_read_unlock();
 	if (!d) {
 		spin_unlock(&nfs4_deviceid_lock);
 		return;
@@ -331,14 +329,12 @@ _deviceid_purge_client(const struct nfs_client *clp, long hash)
 	HLIST_HEAD(tmp);
 
 	spin_lock(&nfs4_deviceid_lock);
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(d, &nfs4_deviceid_cache[hash], node)
 		if (d->nfs_client == clp && atomic_read(&d->ref)) {
 			hlist_del_init_rcu(&d->node);
 			hlist_add_head(&d->tmpnode, &tmp);
 			clear_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 		}
-	rcu_read_unlock();
 	spin_unlock(&nfs4_deviceid_lock);
 
 	if (hlist_empty(&tmp))
-- 
2.34.1


