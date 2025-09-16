Return-Path: <linux-wireless+bounces-27396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B13B7DE63
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11936462720
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963673294E4;
	Tue, 16 Sep 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="A6s7hMru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE611313D6A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061686; cv=none; b=miahNeRvSMsvCLMAzYkvKBz/sFY2FpThY9+WUCvPXgieT0haIW6CQzXUESiEFTUQqK9Ig34bBz+UnwGvNVnVX9oC2FhXmA8uH55F12FsA6YLJMXPonwiLV4BvqZF0DYv5pKv7kGeATfkX/TbVSkjk74VOdHUD7SLZFZ0Xy0S25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061686; c=relaxed/simple;
	bh=4o9QEbYswBECjY+9AfEtpkW/ssCzPWtQpR51m1ztpcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTo6HqLAJaPPen6lFoRcpdrK7NOPfGXRKKC95w5r0P+hRNuiCuXlkjr8X95oRqHnIMRKWAtYcBNGjIdmrfZNDwvn5ElUXAsda+lr2eYNj/Y/bJMViCDTom0Yb502fk4d96cuN/o/+TucxD9IXVVO0Nm9ZD0WJ1DOT1n/yzeX41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=A6s7hMru; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061685; x=1789597685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4o9QEbYswBECjY+9AfEtpkW/ssCzPWtQpR51m1ztpcw=;
  b=A6s7hMruCRdzNLeRnz55e+qYDHXg5Umv2+NZDXadIoE3TtY3tAM5WS/K
   Mkdmjb7QkUpmC0vk6gJWfbxCXcA5YOdHpOQifgadI7I9t+SEsI0yd/wgy
   5C62EzvhUl/PUnLW8vawbv5bK/x+YLuDQZw/YSF3FFjd39g6KlYH4Gk0C
   0=;
X-CSE-ConnectionGUID: Hrs8qBplQ7mhsuej6DYhcg==
X-CSE-MsgGUID: xb5ci83jQEKzi0yNqH51jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918729"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918729"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:28:03 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:28:01 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:27:59 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 41/57] wifi: inffmac: add xtlv.c/h
Date: Wed, 17 Sep 2025 03:48:01 +0530
Message-ID: <20250916221821.4387-47-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

Driver imeplementation for packing the data from the Host Driver to the
Device firmware in the eXtended Type-Length-Value (XTLV) Format.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/xtlv.c | 106 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/xtlv.h |  37 +++++++
 2 files changed, 143 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/xtlv.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/xtlv.h

diff --git a/drivers/net/wireless/infineon/inffmac/xtlv.c b/drivers/net/wireless/infineon/inffmac/xtlv.c
new file mode 100644
index 000000000000..05983783d453
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/xtlv.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2019 Broadcom
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/unaligned.h>
+
+#include <linux/math.h>
+#include <linux/string.h>
+#include <linux/bug.h>
+
+#include "xtlv.h"
+
+static int inff_xtlv_header_size(u16 opts)
+{
+	int len = (int)offsetof(struct inff_xtlv, data);
+
+	if (opts & INFF_XTLV_OPTION_IDU8)
+		--len;
+	if (opts & INFF_XTLV_OPTION_LENU8)
+		--len;
+
+	return len;
+}
+
+int inff_xtlv_data_size(int dlen, u16 opts)
+{
+	int hsz;
+
+	hsz = inff_xtlv_header_size(opts);
+	if (opts & INFF_XTLV_OPTION_ALIGN32)
+		return roundup(dlen + hsz, 4);
+
+	return dlen + hsz;
+}
+
+void inff_xtlv_pack_header(struct inff_xtlv *xtlv, u16 id, u16 len,
+			   const u8 *data, u16 opts)
+{
+	u8 *data_buf;
+	u16 mask = INFF_XTLV_OPTION_IDU8 | INFF_XTLV_OPTION_LENU8;
+
+	if (!(opts & mask)) {
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + sizeof(xtlv->id);
+
+		put_unaligned_le16(id, idp);
+		put_unaligned_le16(len, lenp);
+		data_buf = lenp + sizeof(u16);
+	} else if ((opts & mask) == mask) { /* u8 id and u8 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + 1;
+
+		*idp = (u8)id;
+		*lenp = (u8)len;
+		data_buf = lenp + sizeof(u8);
+	} else if (opts & INFF_XTLV_OPTION_IDU8) { /* u8 id, u16 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + 1;
+
+		*idp = (u8)id;
+		put_unaligned_le16(len, lenp);
+		data_buf = lenp + sizeof(u16);
+	} else if (opts & INFF_XTLV_OPTION_LENU8) { /* u16 id, u8 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + sizeof(u16);
+
+		put_unaligned_le16(id, idp);
+		*lenp = (u8)len;
+		data_buf = lenp + sizeof(u8);
+	} else {
+		WARN(true, "Unexpected xtlv option");
+		return;
+	}
+
+	if (opts & INFF_XTLV_OPTION_LENU8) {
+		WARN_ON(len > 0x00ff);
+		len &= 0xff;
+	}
+
+	if (data)
+		memcpy(data_buf, data, len);
+}
+
+u32 inff_pack_xtlv(u16 id, char *data, u32 len,
+		   char **buf, u16 *buflen)
+{
+	u32 iolen;
+
+	iolen = inff_xtlv_data_size(len, INFF_XTLV_OPTION_ALIGN32);
+
+	if (iolen > *buflen) {
+		WARN(true, "xtlv buffer is too short");
+		return 0;
+	}
+
+	inff_xtlv_pack_header((void *)*buf, id, len, data,
+			      INFF_XTLV_OPTION_ALIGN32);
+
+	*buf = *buf + iolen;
+	*buflen -= iolen;
+	return iolen;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/xtlv.h b/drivers/net/wireless/infineon/inffmac/xtlv.h
new file mode 100644
index 000000000000..eb7564f608ed
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/xtlv.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2019 Broadcom
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_XTLV_H
+#define INFF_XTLV_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+/* inf type(id), length, value with w/16 bit id/len. The structure below
+ * is nominal, and is used to support variable length id and type. See
+ * xtlv options below.
+ */
+struct inff_xtlv {
+	u16 id;
+	u16 len;
+	u8 data[];
+};
+
+enum inff_xtlv_option {
+	INFF_XTLV_OPTION_ALIGN32 = BIT(0),
+	INFF_XTLV_OPTION_IDU8 = BIT(1),
+	INFF_XTLV_OPTION_LENU8 = BIT(2),
+};
+
+int inff_xtlv_data_size(int dlen, u16 opts);
+void inff_xtlv_pack_header(struct inff_xtlv *xtlv, u16 id, u16 len,
+			   const u8 *data, u16 opts);
+u32 inff_pack_xtlv(u16 id, char *data, u32 len,
+		   char **buf, u16 *buflen);
+
+#endif /* INFF_XTLV_H */
-- 
2.25.1


