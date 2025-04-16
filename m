Return-Path: <linux-wireless+bounces-21592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981FA8AFF6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14553B02B8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA28189B9D;
	Wed, 16 Apr 2025 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="EE50cqCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFA187FFA
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783389; cv=none; b=Ni7lY1lLZBJlXhZp+Ct7+GksWLRq7CloBSgZ3yGm4JDbrx+cyDLS1ACPKi/vJFDV8YPM+pUfj8NvqJZjof0qD9DHXKs4ZbUB/4Y1PKSb+kcYZgIlAMoIGhLqDdn8fIXo0Y5T8mZyworhJOq2K6bFGfOiezfk2vLApBD5+p82BW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783389; c=relaxed/simple;
	bh=Rk7+Pmp4qndCR168t2P2c3WNYJ1mBepOyk9M3NQmSmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=onibfIhwj9JqcvC1wWP4fcAG06X3yZTKfkWDA7wpSUeX/Q9HgNYiCoInaKEuNScu+CQv4va4bjt8Yyhx8CPdYgAsErY4xgKbrsdlL7v5ueeosMsz9CvhlmmCln3FuVYIEwWyGSYzD1zJ1Tqf/TGSspCROZJ00wgUFTTFQQBocpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=EE50cqCA; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1744783388; x=1776319388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rk7+Pmp4qndCR168t2P2c3WNYJ1mBepOyk9M3NQmSmQ=;
  b=EE50cqCAD0pTa8s1aHr3s0AeMMZyQwxfPjd/U1q50ysA5v1ZL3taavQF
   ebRnxSutUFtJTowWNFCgrqwL8KsJ9vTc2ePxecZOAa/SLkJ5oiwpG33fv
   pdeg2cQZ6vYzWNgmjASb5UCogxWafwI+ur/HVN5wuDJYVZlznMsfNnIXi
   4=;
X-CSE-ConnectionGUID: vbvkFHKrTeWI7P6o07Ybqg==
X-CSE-MsgGUID: MoiFTA1PT06UOJASZdvOBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="92108791"
X-IronPort-AV: E=Sophos;i="6.15,215,1739833200"; 
   d="scan'208";a="92108791"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 08:01:57 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 08:01:57 +0200
Received: from ISCN5CG14747PP.blr.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Apr 2025 08:01:55 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH] brcmfmac: fix compilation error seen while building only brcmfmac sub-directory
Date: Wed, 16 Apr 2025 11:30:27 +0530
Message-ID: <20250416060128.15703-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

The function prototypes of brcmf_debug_create_memdump(), brcmf_debugfs_get_devdir()
and brcmf_debugfs_add_entry() are protected by the "DEBUG" config MACRO in debug.h,
while the corresponding function definitions remains unprotected in debug.c, so add
the missing MACRO definition check.

Compilation error seen while building brcmfmac sub-directory with CONFIG_BRCMDBG=y
is captured below.

$ make M=drivers/net/wireless/broadcom/brcm80211/brcmfmac

make[1]: Entering directory '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
  CC [M]  debug.o
debug.c:17:5: error: redefinition of ‘brcmf_debug_create_memdump’
   17 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from bus.h:12,
                 from debug.c:13:
debug.h:136:5: note: previous definition of ‘brcmf_debug_create_memdump’ with type
‘int(struct brcmf_bus *, const void *, size_t)’ {aka ‘int(struct brcmf_bus *, const void *, long unsigned int)’}
  136 | int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
debug.c:45:16: error: redefinition of ‘brcmf_debugfs_get_devdir’
   45 | struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
      |                ^~~~~~~~~~~~~~~~~~~~~~~~
debug.h:127:30: note: previous definition of ‘brcmf_debugfs_get_devdir’ with type
‘struct dentry *(struct brcmf_pub *)’
  127 | static inline struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~
debug.c:50:6: error: redefinition of ‘brcmf_debugfs_add_entry’
   50 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
      |      ^~~~~~~~~~~~~~~~~~~~~~~
debug.h:132:6: note: previous definition of ‘brcmf_debugfs_add_entry’ with type
‘void(struct brcmf_pub *, const char *, int (*)(struct seq_file *, void *))’
  132 | void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
      |      ^~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [/root/wireless-next/scripts/Makefile.build:203: debug.o] Error 1
make[2]: *** [/root/wireless/wireless-next/Makefile:2006: .] Error 2
make[1]: *** [/root/wireless/wireless-next/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/root/wireless-next/drivers/net/wireless/broadcom/brcm80211/brcmfmac'
make: *** [Makefile:248: __sub-make] Error 2

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
index eecf8a38d94a..3cb50140eb2f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
@@ -14,6 +14,7 @@
 #include "fweh.h"
 #include "debug.h"
 
+#ifdef DEBUG
 int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 			       size_t len)
 {
@@ -54,3 +55,4 @@ void brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
 	debugfs_create_devm_seqfile(drvr->bus_if->dev, fn,
 				    drvr->wiphy->debugfsdir, read_fn);
 }
+#endif
-- 
2.47.0


