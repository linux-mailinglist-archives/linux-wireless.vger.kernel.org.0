Return-Path: <linux-wireless+bounces-32830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HZGDrcHsGlregIAu9opvQ
	(envelope-from <linux-wireless+bounces-32830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:59:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C682E24BF93
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D5F30D2D6B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EA42314E;
	Tue, 10 Mar 2026 11:55:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23B38B7CB;
	Tue, 10 Mar 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143736; cv=none; b=m9dicdfWq14Dc9NwbAUqq/Y7TyMlXDreMdWulaxQVTdMIy/wrSRP3f+jMR9c/JX3EXaAfyOaIxSgmNnRGYR4ueCBTzxJXnMIw/Iijp1OhkieAMYBRGZPVaI0ecBiU+Usr7pg+LQz0R8y1joA0MEYCB0+1u82vNf6nUQ8slKqBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143736; c=relaxed/simple;
	bh=DGbCaZBy1FpfvXwgzKpSCwa07WA8CY/Qb4IJHso0Te4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQXjYbv0Mil2/t6m8ByvI92uE442QM8Uck7YwSckD0DNNqAFUGPXh+YQ8Hiw8Q5nKM5S+x7sQ+vucs8BlXt9jII10mVwm0gIf+hf+F3RWENB823nSXJ6SXLp9JHKV5L2L5JmzQrE+Vo4HVbTKtnVJ2fDg4rvKOXbXAV26YmqVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-e21d-7f0000032729-7f000001d980-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:28 +0100
Subject: [PATCH 02/61] btrfs: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-2-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=DGbCaZBy1FpfvXwgzKpSCwa07WA8CY/Qb4IJHso0Te4=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXVP8rQiO4oClcWoVpEQy4tTT6UufgJ8AjmW
 meFZ085mAaJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF1QAKCRA0LQZT0ays
 26ZTCACM3Mi9LEMEAWgAR6v8SxUVk3um+/46scAm+wvRfrMWEFwlnMkQBbCGIGZUNkKB1Pk7uvR
 q9d3fZ689cKMySmmjPCYjQ/WgGDVLcywEn6In35Jwnklhlj4dYJLSL6WxXsza+vlAV93TQDvaTs
 OFlLEsZ2j+XY+f2mrUOcVwOk+301k/goYUacbLoVSw0YZnroo7kAB2acRVGhOGAOOiJoiVAdHNU
 Yf8QURa2qrPqHMwGd4SQRV57t+Grw+zEItF3L0eYw7mf41TaJcLeP7Vo+0nFp2D9QdrMND4nUec
 WhX0remRDcBywCJPWh7SmqRiZyiXDaIfp9JkUkUr5yx6Wacb
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-94678F2F-813F0BAA/0/0
X-purgate-type: clean
X-purgate-size: 3019
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: C682E24BF93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32830-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,avm.de:mid,avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Change generated with coccinelle.

To: Chris Mason <clm@fb.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/btrfs/inode.c       | 2 +-
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/tree-log.c    | 2 +-
 fs/btrfs/uuid-tree.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a11fcc9e9f502c559148cf33679014fb83b0d3b0..7c26a0bf56bf7309e2ce8256854d760b2d64b16a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4683,7 +4683,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
 				   dir_id, &name, 0);
-	if (di && !IS_ERR(di)) {
+	if (!IS_ERR_OR_NULL(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == btrfs_root_id(root)) {
 			ret = -EPERM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7ef8c9b7dfc17a5133b6d2dc134e288975ed98d1..40b83037725033d3178dc3fc2c1e347ad2c597f7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1737,7 +1737,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
 					 btrfs_ino(parent_inode),
 					 &fname.disk_name, 0);
-	if (unlikely(dir_item != NULL && !IS_ERR(dir_item))) {
+	if (!IS_ERR_OR_NULL(dir_item)) {
 		pending->error = -EEXIST;
 		goto dir_item_existed;
 	} else if (IS_ERR(dir_item)) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 780a06d592409b05fb42dc8079b019d23fe0cdfa..2e07ae393cf9d16f562047dd4cbfd7b4b9f2952e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5750,7 +5750,7 @@ static int btrfs_check_ref_name_override(struct extent_buffer *eb,
 		name_str.len = this_name_len;
 		di = btrfs_lookup_dir_item(NULL, inode->root, search_path,
 				parent, &name_str, 0);
-		if (di && !IS_ERR(di)) {
+		if (!IS_ERR_OR_NULL(di)) {
 			struct btrfs_key di_key;
 
 			btrfs_dir_item_key_to_cpu(search_path->nodes[0],
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index f24c14b9bb2fd7420b06263a5a0c4b889a859bc6..c497b287f3418933e532903b326b969416ae22cb 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -478,7 +478,7 @@ int btrfs_uuid_scan_kthread(void *data)
 
 out:
 	btrfs_free_path(path);
-	if (trans && !IS_ERR(trans))
+	if (!IS_ERR_OR_NULL(trans))
 		btrfs_end_transaction(trans);
 	if (ret)
 		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);

-- 
2.43.0


