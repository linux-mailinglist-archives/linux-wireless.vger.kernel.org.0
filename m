Return-Path: <linux-wireless+bounces-29755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF19CBDCCC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF93030334C7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA831A256E;
	Mon, 15 Dec 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cLz7lVcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C618DB1E
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801264; cv=none; b=YIGYqWQd/Jjgso1Sr7qsG0F8JfAlrhFFjbt6a4+8yvZVQp+oIxNFECiwoBQ8A/Q4+JM+tp2LKqqqyDTsjZOp1/WSbJ2sU5+RQJ1Yifcm19TPuCgCpbtzIHp34HZ1l3h5SWicEZmAVuP/3XFJYxjz1vUbbzDXDLYAyH0Q5fwydL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801264; c=relaxed/simple;
	bh=tGtZFWJZWVieQAfbdvhspv4bnWH397mqfaAyuWKdKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7UvVIwqtxQvSvS6jXgutGejksNjAdK0cMTNlhae66dt1OMq+2gERP6YmznG2hbElfxwlWb+H+cj3gw8RDyHnmHzb5qVh9M4YkHM62tGWGz7c7va6hU0Hg1hB202IArgw+pP2dENY38dyjZAy932Jsc3QXOvXkXfzeroDKCC6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cLz7lVcn; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765801260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kuuh4h814MG9F8RlFOMcprDr38lqFWabL2fokFxEL8A=;
	b=cLz7lVcnpKV5OzwgZIxw0/aWGA02m/Y1GJ1M2JmgTwCdkRb6ErZd/DMyREsTRXPmavJXbv
	Sb7XpJCTdiIX6vniUBqse6R+QQGXNt4LZFAusW0/WFS9y60ScBzjlaT7UOBx5u/8zVUqxt
	Ig/9re6rPlt+aSRQN7rIddBKmL8Gq48=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: rfkill: Replace strcpy with memcpy to improve rfkill_alloc
Date: Mon, 15 Dec 2025 13:20:36 +0100
Message-ID: <20251215122036.379322-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated [1] and uses an additional strlen() internally;
use memcpy() directly since we already know the length of 'name' and
that it is guaranteed to be NUL-terminated.

Use struct_size(), which provides additional compile-time checks for
structures with flexible array members (e.g., __must_be_array()), to
determine the allocation size for a new 'struct rfkill'.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/rfkill/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 7d3e82e4c2fc..db1260acb182 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -986,6 +986,7 @@ struct rfkill * __must_check rfkill_alloc(const char *name,
 {
 	struct rfkill *rfkill;
 	struct device *dev;
+	size_t name_sz;
 
 	if (WARN_ON(!ops))
 		return NULL;
@@ -999,14 +1000,15 @@ struct rfkill * __must_check rfkill_alloc(const char *name,
 	if (WARN_ON(type == RFKILL_TYPE_ALL || type >= NUM_RFKILL_TYPES))
 		return NULL;
 
-	rfkill = kzalloc(sizeof(*rfkill) + strlen(name) + 1, GFP_KERNEL);
+	name_sz = strlen(name) + 1;
+	rfkill = kzalloc(struct_size(rfkill, name, name_sz), GFP_KERNEL);
 	if (!rfkill)
 		return NULL;
 
 	spin_lock_init(&rfkill->lock);
 	INIT_LIST_HEAD(&rfkill->node);
 	rfkill->type = type;
-	strcpy(rfkill->name, name);
+	memcpy(rfkill->name, name, name_sz);
 	rfkill->ops = ops;
 	rfkill->data = ops_data;
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


