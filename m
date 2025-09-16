Return-Path: <linux-wireless+bounces-27368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC34B7D902
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2DB3AE887
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F2130DEDC;
	Tue, 16 Sep 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="bxlPdyJ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55C2248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061346; cv=none; b=rHluBf2ZunFW1nBSdxbbv5DdOl+tjm8D2TNauAiaUiGigI1Vxz2eY6rgR520TnH7YlRI8skYxzhg/r8BC5cSUOLLF4ilrGoNZYQsrePfiLxijcPkWcoGW38ZN9xbj9LdURA2GqjKfFbR9BlqwtuesvhkmbAB75L7Z3k21jS/x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061346; c=relaxed/simple;
	bh=9BqoGrZFzjJjMDQZoJZRYwEXYYGoVC/v47awOElYVUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrX82WubBVt18ExtjPx6xeLdBVP4VDK85zSd7Gkmp9jkTnlx16d6Wn0+4tWHJcd4ZVoGi4IKuGRrKEyb8Ai2GB+ZmBfF9I6LX7Jbs/baEcEO/hyssXRsIak3zP4U18O3s1wlE9NzZobPJ0Z8Dpy2ngQnW6shiheWVw1ePF39EVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=bxlPdyJ7; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061345; x=1789597345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9BqoGrZFzjJjMDQZoJZRYwEXYYGoVC/v47awOElYVUs=;
  b=bxlPdyJ7WDAiQ8WanDrSYUFhERKs3Q9UD0SJJXsMtHA4MHSjXIYB3q99
   3KrTq/Hh52mup30/CmpqA6eFv5KavzS81SAJovlowfJdEkxhvG9Cww9SV
   T3iejFF53ywsCgc5NElNhp40LG5TA15b26Qs2DLAiOBhE3ogkt7jRMApq
   U=;
X-CSE-ConnectionGUID: rYPIOGjoTmmCVTdCdsVvow==
X-CSE-MsgGUID: 1Ja87OIfQh6OjxfqJNOosw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99293768"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99293768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:21:14 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:21:14 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:21:11 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 13/57] wifi: inffmac: add trxhdr.h
Date: Wed, 17 Sep 2025 03:47:28 +0530
Message-ID: <20250916221821.4387-14-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE827.infineon.com (172.23.29.20)

Definitions of the Metadata in the Device Firmware binary files.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/trxhdr.h    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/trxhdr.h

diff --git a/drivers/net/wireless/infineon/inffmac/trxhdr.h b/drivers/net/wireless/infineon/inffmac/trxhdr.h
new file mode 100644
index 000000000000..fe724406442d
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/trxhdr.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2020-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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


