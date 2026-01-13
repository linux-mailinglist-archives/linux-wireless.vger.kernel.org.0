Return-Path: <linux-wireless+bounces-30759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86BD1B3CC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907DB307BD05
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7F2BD5BB;
	Tue, 13 Jan 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="ik9gYarZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDA296BBC
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336533; cv=none; b=gFJRBxjxDwdewqwLfBWa8l9jl9+J81BE7pZdpzyaYQS84io9GR35ArINuLli+DXaOCYCNevG+5wSCqd2s3tLbP5ybrJMYpQRjSDXO5m/Zc7FLeDfVTPoucT3zLDOQnKtIWlcq4EjZYnnJZeRo2tjuGQnynqGwgHWJ6f0j8+5Dck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336533; c=relaxed/simple;
	bh=6CmkBjeE2baudPB+VEj5FKhgINa3bUHz5C83bIx1Vzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy/ybWx255AKZzRiyEt13NCRdfK3NtkfHmyKJYlGo01yp+FWGjTRWHc3EJAFeDoiAOb+HdaeabgYY0lFKP7jbs5sxOlAgnnWYJKBKf/IuhcFpYxFCcWX3WCfM2/rdQVX23CQEiapigqbM7SyZdB/jIjqJiR9BN/IVwgN2vHG2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=ik9gYarZ; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336531; x=1799872531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CmkBjeE2baudPB+VEj5FKhgINa3bUHz5C83bIx1Vzc=;
  b=ik9gYarZaRCfqZuaPoRY+qOyC2vdjAezOTCSDbne0YtANdBQjTtybEuq
   SDyqiJ/VFYK+Pp2F+VfsNfUtwUWbwxsxbpv8+U9gVmjao/0vPk2OXFDMy
   9PnNXuWGO+MmFaR8iyW79juPQLy8Szz0NEpHB85kJB0+kVWgBcwijmEx3
   A=;
X-CSE-ConnectionGUID: 6EdW/HJ7T5CXQkIsSlOC+g==
X-CSE-MsgGUID: 8kZhTMMTT+aE1z1O0PZJ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="113628175"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="113628175"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:35:29 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:35:29 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:35:27 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 05/34] wifi: inffmac: add trxhdr.h
Date: Wed, 14 Jan 2026 02:03:18 +0530
Message-ID: <20260113203350.16734-6-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
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

Definitions of the Metadata in the Device Firmware binary files.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/trxhdr.h    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/trxhdr.h

diff --git a/drivers/net/wireless/infineon/inffmac/trxhdr.h b/drivers/net/wireless/infineon/inffmac/trxhdr.h
new file mode 100644
index 000000000000..edb2a2ee0443
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/trxhdr.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2020-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_TRXHDR_H
+#define INFF_TRXHDR_H
+
+/* Bootloader makes special use of trx header "offsets" array */
+enum {
+	TRX_OFFSET_SIGN_INFO_IDX		= 0,
+	TRX_OFFSET_DATA_FOR_SIGN1_IDX		= 1,
+	TRX_OFFSET_DATA_FOR_SIGN2_IDX		= 2,
+	TRX_OFFSET_ROOT_MODULUS_IDX		= 3,
+	TRX_OFFSET_ROOT_EXPONENT_IDX		= 67,
+	TRX_OFFSET_CONT_MODULUS_IDX		= 68,
+	TRX_OFFSET_CONT_EXPONENT_IDX		= 132,
+	TRX_OFFSET_HASH_FW_IDX			= 133,
+	TRX_OFFSET_FW_LEN_IDX			= 149,
+	TRX_OFFSET_TR_RST_IDX			= 150,
+	TRX_OFFSET_FW_VER_FOR_ANTIROOLBACK_IDX	= 151,
+	TRX_OFFSET_IV_IDX			= 152,
+	TRX_OFFSET_NONCE_IDX			= 160,
+	TRX_OFFSET_SIGN_INFO2_IDX		= 168,
+	TRX_OFFSET_MAX_IDX
+};
+
+#define TRX_MAGIC	0x30524448		/* "HDR0" */
+#define TRX_VERSION	4			/* Version 4 */
+#define TRX_MAX_OFFSET	TRX_OFFSET_MAX_IDX	/* Max number of file offsets */
+
+struct trx_header_le {
+	__le32 magic;		/* "HDR0" */
+	__le32 len;		/* Length of file including header */
+	__le32 crc32;		/* CRC from flag_version to end of file */
+	__le32 flag_version;	/* 0:15 flags, 16:31 version */
+	__le32 offsets[TRX_MAX_OFFSET];	/* Offsets of partitions */
+};
+
+#define TRX_VERSION5	5			/* Version 5 */
+
+struct trxv5_header_le {
+	__le32 magic;		/* "HDR0" */
+	__le32 len;			/* Length of file including header */
+	__le32 crc32;		/* 32-bit CRC from flag_version to end of file */
+	__le32 flag_version;	/* 0:15 flags, 16:31 version */
+	__le32 root_cert_start_offset;	/* Start Offset IDX for Root Certificate */
+	__le32 content_cert_start_offset;	/* Start Offset IDX for Content Certificate */
+	__le32 fw_entry;	/* Firmware Entry Point for CM mode */
+	__le32 reserved;
+};
+
+#endif /* INFF_TRXHDR_H */
-- 
2.25.1


