Return-Path: <linux-wireless+bounces-30638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832DD0EFE7
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A90300BBA4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7233D6E1;
	Sun, 11 Jan 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XB7Bq1aX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56A33AD9E
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768138999; cv=none; b=o7dPjcZbTL8t5nWRpVfs13KzBKHeTWoY1elcAk9pxsbGiV87KQ3aq0/8LPAiVi0YLSqs5sOnPJFKIllqDToq1ouNNkKCmqj463f4L8Wt5l4Iu+O0dvN7yQN+3954x6uJUmN39ykI4raiNFJPvCCdrzlI0bQ13gXpdkn4o5TkfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768138999; c=relaxed/simple;
	bh=8sqz7lDkCd9wkk33legYLChJ3Zus4NX4Dfqug8Mh55s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYdV7oe6uHUN5GKIL8I9u8fdauGPsVcOZ/5/WYiU+LNbSHjyDq/5F8yYTySkC3Kf/vxR7KUsAg2gLyTMIx8kyJYLPmuzMf+2tNbiEvuL5ewBS7Xs4D87BspCPYrJBcmo4wjA+5LAlfUnPnHb+GlmgduXTbvm8k5+MS7M/h0t7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XB7Bq1aX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768138995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ZBp+XBIX4GCD5QHH/GPkSyOGA9veuKGDEDyFEqqAfQ=;
	b=XB7Bq1aXG1KlupNuYrSqatlXHVNA0Md3LvXnuPqVS5FBT4/x9V7S+gP6EQZ7UxCvoZzlNe
	my/52ivMROY7fzkiOe3Z0tYekebAOhCI92NZDiTbfYDmC+kCKi9aLGq4D3BaSQZHL/HkfD
	LIPKDIoJ0Fvs9BJd4AcUEVQOxleyckU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next] wl1251: Replace strncpy with strscpy in wl1251_acx_fw_version
Date: Sun, 11 Jan 2026 14:42:57 +0100
Message-ID: <20260111134301.598839-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated [1] for NUL-terminated destination buffers since
it does not guarantee NUL termination. Remove the manual NUL termination
and replace strncpy() with strscpy() to ensure NUL termination of the
destination buffer.

Using strscpy_pad() to retain the NUL-padding behavior of strncpy() is
not needed because ->fw_ver is only used as a C-string.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/wireless/ti/wl1251/acx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/acx.c b/drivers/net/wireless/ti/wl1251/acx.c
index cb8b3102fa6c..166efac812fe 100644
--- a/drivers/net/wireless/ti/wl1251/acx.c
+++ b/drivers/net/wireless/ti/wl1251/acx.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include "wl1251.h"
 #include "reg.h"
@@ -149,15 +150,7 @@ int wl1251_acx_fw_version(struct wl1251 *wl, char *buf, size_t len)
 		goto out;
 	}
 
-	/* be careful with the buffer sizes */
-	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
-
-	/*
-	 * if the firmware version string is exactly
-	 * sizeof(rev->fw_version) long or fw_len is less than
-	 * sizeof(rev->fw_version) it won't be null terminated
-	 */
-	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
+	strscpy(buf, rev->fw_version, len);
 
 out:
 	kfree(rev);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


