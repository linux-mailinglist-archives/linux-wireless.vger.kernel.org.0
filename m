Return-Path: <linux-wireless+bounces-37044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Nn0EPOIF2riIQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:14:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF905EB30B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101823011C5C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241764;
	Thu, 28 May 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRWqEeaK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34487800
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927070; cv=none; b=D0YdAxa9nRVp2WmZHfuSZkiiCS2zVEIHdpzCFeIm+T0mRH6x3L6jNTYZXY1d3aKAAhuIqmoxdJ8/7u0R9Tw7dD45SrtN3Utu6mr+yiEOX3nWNYkv8fZp5Uf3nArj+Z6Q+vdBLeLwR6ULD+nKNE+5lYCXIwkKve8uf21HidbjppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927070; c=relaxed/simple;
	bh=hS8Aj5I7+u02wEAI3pvjngOEdO+xr7qVgY08w4e0qLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSiABl3XFS+uBlbBGli72Db92VrsfIY3PoTiKtutemIqGSkS6ZZsF7DKfTKFE9R0AqgLRZok8nDr4j1wDEoPjgWR9GxK0f2KuhbqyM6+tHXxE/Coyau12T812iADWKsAFJaJxbuUEV5wxaIx0W2KxWHkDTf94PL6Iiqy+J9B2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRWqEeaK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779927066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xJ1ZSFYUyavUg+WsSY7Gf2N+XJVJEyVHltwuSxXOk/o=;
	b=CRWqEeaKHpsywxms0xekv76tUK6vIkBxJkiMgPcNoyngfIyr3IALM+KEzKjJ8cbHubwDoT
	H0cGBR2+fYzrp8pfLG65JSwF1UmQT8mDXo05lmHlc6yzPst+ucyYXZPfoerAZkK2Si6x46
	JIJ2ow7+dod3tLOyeHF7BklKVSZRaZo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next] wifi: cfg80211: use strscpy in cfg80211_wext_giwname
Date: Thu, 28 May 2026 02:10:50 +0200
Message-ID: <20260528001049.1394078-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=thorsten.blum@linux.dev; h=from:subject; bh=hS8Aj5I7+u02wEAI3pvjngOEdO+xr7qVgY08w4e0qLA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFniHZyHPe+a/F6oIK+fd+Sy8Za9l+eeWb7u9rF1nIynu TO7Yw1mdJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEzkYw/I/KNLB8dfFdSeI/ H56ldr/Dj9uwH3pb0Dg52deBfeoWW1eGfwqLd9RfP/Y2zPqymGTm/ESXlxe2+10JP28sHKtc81W /hxEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-37044-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9DF905EB30B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows.

While the current code works correctly, replace strcpy() with the safer
strscpy() to follow secure coding best practices.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/wireless/wext-compat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 1241fda78a68..1d6c60d3ad5b 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -16,6 +16,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <net/iw_handler.h>
 #include <net/cfg80211.h>
 #include <net/cfg80211-wext.h>
@@ -27,7 +28,7 @@ int cfg80211_wext_giwname(struct net_device *dev,
 			  struct iw_request_info *info,
 			  union iwreq_data *wrqu, char *extra)
 {
-	strcpy(wrqu->name, "IEEE 802.11");
+	strscpy(wrqu->name, "IEEE 802.11");
 	return 0;
 }
 

