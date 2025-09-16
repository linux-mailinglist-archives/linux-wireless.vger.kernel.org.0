Return-Path: <linux-wireless+bounces-27392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D29B7D78C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3B87ABD3A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADED31BC8C;
	Tue, 16 Sep 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="LSqhsfxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADB1C5486
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061636; cv=none; b=UxCJg00Xb7B/z3mbcJATuDz2MIokgMb3KP3//0l50YJiylPwC87N83ea4tbhkSHFRDI1aLukQh/bW5o5gkaM5bEU6gdxdEF+E0G57VbcZNoqhvDZH6nwHouRv5kKvWhRz8tKLvfYxjWmNNDQbgIO7jZec+vfyb0Ji744z4sKjxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061636; c=relaxed/simple;
	bh=taWJQifEatowzLpcDfe3rH020s2slU765UT4rl5Tpxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdXtvkLisiLioDIBD3yG2ePLsqfxdSD/prhCoGKoGEPHfoxw8bx1Pf24iGG3rSALFsaTW8jfN2yrjHiMGyLkp2yC8N0ZyJYdEzGBDxZ9Xu4iSKDNryrdAYE2St557uisLfretJ+AbPFsCXvL8v1JtFVbN+kMYVhGPs7f3jVIVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=LSqhsfxt; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061634; x=1789597634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=taWJQifEatowzLpcDfe3rH020s2slU765UT4rl5Tpxw=;
  b=LSqhsfxtIalzr7Sc9hxvW/29kNCWsTWc211zUXIvGY+rmvJC06/kch7d
   2sAgOTkcLEdK6uzgYjIyu2sdtOCqfMKagN/V3v0VMmmLKyO9S9IxKVfxH
   M4hsqypJbFdg/hOS1fJZxSolTXfMM0NUVW6m8OKeEu94hlmpE5zS36ufK
   s=;
X-CSE-ConnectionGUID: ivcW8JESRhazjswy9TwqUQ==
X-CSE-MsgGUID: RpUGNQzwTNqYVTSJ08hRqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093734"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:27:12 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:27:11 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:27:08 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 37/57] wifi: inffmac: add fwil.c/h
Date: Wed, 17 Sep 2025 03:47:57 +0530
Message-ID: <20250916221821.4387-43-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the Device Firmware interface layer used for the
control path communication.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/fwil.c | 539 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/fwil.h | 119 ++++
 2 files changed, 658 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil.h

diff --git a/drivers/net/wireless/infineon/inffmac/fwil.c b/drivers/net/wireless/infineon/inffmac/fwil.c
new file mode 100644
index 000000000000..de8090f871e0
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/fwil.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+/* FWIL is the Firmware Interface Layer. In this module the support functions
+ * are located to set and get variables to and from the firmware.
+ */
+
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include "utils.h"
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+#include "tracepoint.h"
+#include "xtlv.h"
+#include "fwil.h"
+#include "proto.h"
+
+#define MAX_HEX_DUMP_LEN	64
+#define MAX_CMD_RESEND		3
+
+#ifdef DEBUG
+static const char * const inff_fil_errstr[] = {
+	"INFE_OK",
+	"INFE_ERROR",
+	"INFE_BADARG",
+	"INFE_BADOPTION",
+	"INFE_NOTUP",
+	"INFE_NOTDOWN",
+	"INFE_NOTAP",
+	"INFE_NOTSTA",
+	"INFE_BADKEYIDX",
+	"INFE_RADIOOFF",
+	"INFE_NOTBANDLOCKED",
+	"INFE_NOCLK",
+	"INFE_BADRATESET",
+	"INFE_BADBAND",
+	"INFE_BUFTOOSHORT",
+	"INFE_BUFTOOLONG",
+	"INFE_BUSY",
+	"INFE_NOTASSOCIATED",
+	"INFE_BADSSIDLEN",
+	"INFE_OUTOFRANGECHAN",
+	"INFE_BADCHAN",
+	"INFE_BADADDR",
+	"INFE_NORESOURCE",
+	"INFE_UNSUPPORTED",
+	"INFE_BADLEN",
+	"INFE_NOTREADY",
+	"INFE_EPERM",
+	"INFE_NOMEM",
+	"INFE_ASSOCIATED",
+	"INFE_RANGE",
+	"INFE_NOTFOUND",
+	"INFE_WME_NOT_ENABLED",
+	"INFE_TSPEC_NOTFOUND",
+	"INFE_ACM_NOTSUPPORTED",
+	"INFE_NOT_WME_ASSOCIATION",
+	"INFE_SDIO_ERROR",
+	"INFE_DONGLE_DOWN",
+	"INFE_VERSION",
+	"INFE_TXFAIL",
+	"INFE_RXFAIL",
+	"INFE_NODEVICE",
+	"INFE_NMODE_DISABLED",
+	"INFE_NONRESIDENT",
+	"INFE_SCANREJECT",
+	"INFE_USAGE_ERROR",
+	"INFE_IOCTL_ERROR",
+	"INFE_SERIAL_PORT_ERR",
+	"INFE_DISABLED",
+	"INFE_DECERR",
+	"INFE_ENCERR",
+	"INFE_MICERR",
+	"INFE_REPLAY",
+	"INFE_IE_NOTFOUND",
+};
+
+static const char *inff_fil_get_errstr(u32 err)
+{
+	if (err >= ARRAY_SIZE(inff_fil_errstr))
+		return "(unknown)";
+
+	return inff_fil_errstr[err];
+}
+#else
+static const char *inff_fil_get_errstr(u32 err)
+{
+	return "";
+}
+#endif /* DEBUG */
+
+static s32
+inff_fil_cmd_data(struct inff_if *ifp, u32 cmd, void *data, u32 len, bool set)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err, fwerr;
+	u8 resend_cnt = 1;
+
+	if (drvr->bus_if->state != INFF_BUS_UP) {
+		iphy_err(drvr, "bus is down. we have nothing to do.\n");
+		return -EIO;
+	}
+
+	if (data)
+		len = min_t(uint, len, INFF_DCMD_MAXLEN);
+
+	do {
+		if (set)
+			err = inff_proto_set_dcmd(drvr, ifp->ifidx, cmd,
+						  data, len, &fwerr);
+		else
+			err = inff_proto_query_dcmd(drvr, ifp->ifidx, cmd,
+						    data, len, &fwerr);
+		if (!err || resend_cnt > MAX_CMD_RESEND)
+			break;
+
+		inff_err("cmd error %d, resend cmd count %d\n", err, resend_cnt++);
+	} while (true);
+
+	if (err) {
+		inff_dbg(FIL, "Failed: error=%d\n", err);
+	} else if (fwerr < 0) {
+		inff_dbg(FIL, "Firmware error: %s (%d)\n",
+			 inff_fil_get_errstr((u32)(-fwerr)), fwerr);
+		err = -EBADE;
+	}
+	if (ifp->fwil_fwerr)
+		return fwerr;
+
+	return err;
+}
+
+s32
+inff_fil_cmd_data_set(struct inff_if *ifp, u32 cmd, void *data, u32 len)
+{
+	s32 err;
+
+	mutex_lock(&ifp->drvr->proto_block);
+
+	inff_dbg(FIL, "ifidx=%d, cmd=%d, len=%d\n", ifp->ifidx, cmd, len);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	err = inff_fil_cmd_data(ifp, cmd, data, len, true);
+	mutex_unlock(&ifp->drvr->proto_block);
+
+	return err;
+}
+
+s32
+inff_fil_cmd_data_get(struct inff_if *ifp, u32 cmd, void *data, u32 len)
+{
+	s32 err;
+
+	mutex_lock(&ifp->drvr->proto_block);
+	err = inff_fil_cmd_data(ifp, cmd, data, len, false);
+
+	inff_dbg(FIL, "ifidx=%d, cmd=%d, len=%d, err=%d\n", ifp->ifidx, cmd,
+		 len, err);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	mutex_unlock(&ifp->drvr->proto_block);
+
+	return err;
+}
+
+s32
+inff_fil_cmd_int_set(struct inff_if *ifp, u32 cmd, u32 data)
+{
+	s32 err;
+	__le32 data_le = cpu_to_le32(data);
+
+	mutex_lock(&ifp->drvr->proto_block);
+	inff_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, data);
+	err = inff_fil_cmd_data(ifp, cmd, &data_le, sizeof(data_le), true);
+	mutex_unlock(&ifp->drvr->proto_block);
+
+	return err;
+}
+
+s32
+inff_fil_cmd_int_get(struct inff_if *ifp, u32 cmd, u32 *data)
+{
+	s32 err;
+	__le32 data_le = cpu_to_le32(*data);
+
+	mutex_lock(&ifp->drvr->proto_block);
+	err = inff_fil_cmd_data(ifp, cmd, &data_le, sizeof(data_le), false);
+	mutex_unlock(&ifp->drvr->proto_block);
+	*data = le32_to_cpu(data_le);
+	inff_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
+
+	return err;
+}
+
+static u32
+inff_create_iovar(const char *name, const char *data, u32 datalen,
+		  char *buf, u32 buflen)
+{
+	u32 len;
+
+	len = strlen(name) + 1;
+
+	if ((len + datalen) > buflen)
+		return 0;
+
+	memcpy(buf, name, len);
+
+	/* append data onto the end of the name string */
+	if (data && datalen)
+		memcpy(&buf[len], data, datalen);
+
+	return len + datalen;
+}
+
+s32
+inff_fil_iovar_data_set(struct inff_if *ifp, const char *name, const void *data,
+			u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	inff_dbg(FIL, "ifidx=%d, name=%s, len=%d\n", ifp->ifidx, name, len);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	buflen = inff_create_iovar(name, data, len, drvr->proto_buf,
+				   sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_SET_VAR, drvr->proto_buf,
+					buflen, true);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating iovar failed\n");
+	}
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32
+inff_fil_iovar_data_get(struct inff_if *ifp, const char *name, void *data,
+			u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	buflen = inff_create_iovar(name, data, len, drvr->proto_buf,
+				   sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_GET_VAR, drvr->proto_buf,
+					buflen, false);
+		if (err == 0)
+			memcpy(data, drvr->proto_buf, len);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating iovar failed\n");
+	}
+
+	inff_dbg(FIL, "ifidx=%d, name=%s, len=%d, err=%d\n", ifp->ifidx, name,
+		 len, err);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32
+inff_fil_iovar_int_set(struct inff_if *ifp, const char *name, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return inff_fil_iovar_data_set(ifp, name, &data_le, sizeof(data_le));
+}
+
+s32
+inff_fil_iovar_int_get(struct inff_if *ifp, const char *name, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = inff_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
+static u32
+inff_create_bsscfg(s32 bsscfgidx, const char *name, char *data, u32 datalen,
+		   char *buf, u32 buflen)
+{
+	const s8 *prefix = "bsscfg:";
+	s8 *p;
+	u32 prefixlen;
+	u32 namelen;
+	u32 iolen;
+	__le32 bsscfgidx_le;
+
+	if (bsscfgidx == 0)
+		return inff_create_iovar(name, data, datalen, buf, buflen);
+
+	prefixlen = strlen(prefix);
+	namelen = strlen(name) + 1; /* length of iovar  name + null */
+	iolen = prefixlen + namelen + sizeof(bsscfgidx_le) + datalen;
+
+	if (buflen < iolen) {
+		inff_err("buffer is too short\n");
+		return 0;
+	}
+
+	p = buf;
+
+	/* copy prefix, no null */
+	memcpy(p, prefix, prefixlen);
+	p += prefixlen;
+
+	/* copy iovar name including null */
+	memcpy(p, name, namelen);
+	p += namelen;
+
+	/* bss config index as first data */
+	bsscfgidx_le = cpu_to_le32(bsscfgidx);
+	memcpy(p, &bsscfgidx_le, sizeof(bsscfgidx_le));
+	p += sizeof(bsscfgidx_le);
+
+	/* parameter buffer follows */
+	if (datalen)
+		memcpy(p, data, datalen);
+
+	return iolen;
+}
+
+s32
+inff_fil_bsscfg_data_set(struct inff_if *ifp, const char *name,
+			 void *data, u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	inff_dbg(FIL, "ifidx=%d, bsscfgidx=%d, name=%s, len=%d\n", ifp->ifidx,
+		 ifp->bsscfgidx, name, len);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	buflen = inff_create_bsscfg(ifp->bsscfgidx, name, data, len,
+				    drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_SET_VAR, drvr->proto_buf,
+					buflen, true);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating bsscfg failed\n");
+	}
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32
+inff_fil_bsscfg_data_get(struct inff_if *ifp, const char *name,
+			 void *data, u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	buflen = inff_create_bsscfg(ifp->bsscfgidx, name, data, len,
+				    drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_GET_VAR, drvr->proto_buf,
+					buflen, false);
+		if (err == 0)
+			memcpy(data, drvr->proto_buf, len);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating bsscfg failed\n");
+	}
+	inff_dbg(FIL, "ifidx=%d, bsscfgidx=%d, name=%s, len=%d, err=%d\n",
+		 ifp->ifidx, ifp->bsscfgidx, name, len, err);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32
+inff_fil_bsscfg_int_set(struct inff_if *ifp, const char *name, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return inff_fil_bsscfg_data_set(ifp, name, &data_le,
+					 sizeof(data_le));
+}
+
+s32
+inff_fil_bsscfg_int_get(struct inff_if *ifp, const char *name, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = inff_fil_bsscfg_data_get(ifp, name, &data_le,
+				       sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
+static u32 inff_create_xtlv(const char *name, u16 id, char *data, u32 len,
+			    char *buf, u32 buflen)
+{
+	u32 iolen;
+	u32 nmlen;
+
+	nmlen = strlen(name) + 1;
+	iolen = nmlen + inff_xtlv_data_size(len, INFF_XTLV_OPTION_ALIGN32);
+
+	if (iolen > buflen) {
+		inff_err("buffer is too short\n");
+		return 0;
+	}
+
+	memcpy(buf, name, nmlen);
+	inff_xtlv_pack_header((void *)(buf + nmlen), id, len, data,
+			      INFF_XTLV_OPTION_ALIGN32);
+
+	return iolen;
+}
+
+s32 inff_fil_xtlv_data_set(struct inff_if *ifp, const char *name, u16 id,
+			   void *data, u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	inff_dbg(FIL, "ifidx=%d, name=%s, id=%u, len=%u\n", ifp->ifidx, name,
+		 id, len);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	buflen = inff_create_xtlv(name, id, data, len,
+				  drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_SET_VAR, drvr->proto_buf,
+					buflen, true);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating xtlv failed\n");
+	}
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32 inff_fil_xtlv_data_get(struct inff_if *ifp, const char *name, u16 id,
+			   void *data, u32 len)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	buflen = inff_create_xtlv(name, id, data, len,
+				  drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = inff_fil_cmd_data(ifp, INFF_C_GET_VAR, drvr->proto_buf,
+					buflen, false);
+		if (err == 0)
+			memcpy(data, drvr->proto_buf, len);
+	} else {
+		err = -EPERM;
+		iphy_err(drvr, "Creating bsscfg failed\n");
+	}
+	inff_dbg(FIL, "ifidx=%d, name=%s, id=%u, len=%u, err=%d\n",
+		 ifp->ifidx, name, id, len, err);
+	inff_dbg_hex_dump(INFF_FIL_ON(), data,
+			  min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32 inff_fil_xtlv_int_set(struct inff_if *ifp, const char *name, u16 id, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return inff_fil_xtlv_data_set(ifp, name, id, &data_le,
+					 sizeof(data_le));
+}
+
+s32 inff_fil_xtlv_int_get(struct inff_if *ifp, const char *name, u16 id, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = inff_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
+s32 inff_fil_xtlv_int8_get(struct inff_if *ifp, const char *name, u16 id, u8 *data)
+{
+	return inff_fil_xtlv_data_get(ifp, name, id, data, sizeof(*data));
+}
+
+s32 inff_fil_xtlv_int16_get(struct inff_if *ifp, const char *name, u16 id, u16 *data)
+{
+	__le16 data_le = cpu_to_le16(*data);
+	s32 err;
+
+	err = inff_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le16_to_cpu(data_le);
+	return err;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/fwil.h b/drivers/net/wireless/infineon/inffmac/fwil.h
new file mode 100644
index 000000000000..21508cbfc6d0
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/fwil.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FWIL_H
+#define INFF_FWIL_H
+
+#include "debug.h"
+
+/*******************************************************************************
+ * Dongle command codes that are interpreted by firmware
+ ******************************************************************************/
+#define INFF_C_GET_VERSION			1
+#define INFF_C_UP				2
+#define INFF_C_DOWN				3
+#define INFF_C_SET_PROMISC			10
+#define INFF_C_GET_RATE			12
+#define INFF_C_GET_INFRA			19
+#define INFF_C_SET_INFRA			20
+#define INFF_C_GET_AUTH			21
+#define INFF_C_SET_AUTH			22
+#define INFF_C_GET_BSSID			23
+#define INFF_C_GET_SSID			25
+#define INFF_C_SET_SSID			26
+#define INFF_C_TERMINATED			28
+#define INFF_C_GET_CHANNEL			29
+#define INFF_C_SET_CHANNEL			30
+#define INFF_C_GET_SRL				31
+#define INFF_C_SET_SRL				32
+#define INFF_C_GET_LRL				33
+#define INFF_C_SET_LRL				34
+#define INFF_C_GET_RADIO			37
+#define INFF_C_SET_RADIO			38
+#define INFF_C_GET_PHYTYPE			39
+#define INFF_C_SET_KEY				45
+#define INFF_C_GET_REGULATORY			46
+#define INFF_C_SET_REGULATORY			47
+#define INFF_C_SET_PASSIVE_SCAN		49
+#define INFF_C_SCAN				50
+#define INFF_C_SCAN_RESULTS			51
+#define INFF_C_DISASSOC			52
+#define INFF_C_REASSOC				53
+#define INFF_C_SET_ROAM_TRIGGER		55
+#define INFF_C_SET_ROAM_DELTA			57
+#define INFF_C_GET_BCNPRD			75
+#define INFF_C_SET_BCNPRD			76
+#define INFF_C_GET_DTIMPRD			77
+#define INFF_C_SET_DTIMPRD			78
+#define INFF_C_SET_COUNTRY			84
+#define INFF_C_GET_PM				85
+#define INFF_C_SET_PM				86
+#define INFF_C_GET_REVINFO			98
+#define INFF_C_GET_MONITOR			107
+#define INFF_C_SET_MONITOR			108
+#define INFF_C_GET_CURR_RATESET		114
+#define INFF_C_GET_AP				117
+#define INFF_C_SET_AP				118
+#define INFF_C_SET_SCB_AUTHORIZE		121
+#define INFF_C_SET_SCB_DEAUTHORIZE		122
+#define INFF_C_GET_RSSI			127
+#define INFF_C_GET_WSEC			133
+#define INFF_C_SET_WSEC			134
+#define INFF_C_GET_PHY_NOISE			135
+#define INFF_C_GET_BSS_INFO			136
+#define INFF_C_GET_GET_PKTCNTS			137
+#define INFF_C_GET_BANDLIST			140
+#define INFF_C_SET_SCB_TIMEOUT			158
+#define INFF_C_GET_ASSOCLIST			159
+#define INFF_C_GET_UP				162
+#define INFF_C_GET_PHYLIST			180
+#define INFF_C_SET_SCAN_CHANNEL_TIME		185
+#define INFF_C_SET_SCAN_UNASSOC_TIME		187
+#define INFF_C_SCB_DEAUTHENTICATE_FOR_REASON	201
+#define INFF_C_SET_ASSOC_PREFER		205
+#define INFF_C_GET_VALID_CHANNELS		217
+#define INFF_C_GET_FAKEFRAG                    218
+#define INFF_C_SET_FAKEFRAG			219
+#define INFF_C_GET_KEY_PRIMARY			235
+#define INFF_C_SET_KEY_PRIMARY			236
+#define INFF_C_SET_SCAN_PASSIVE_TIME		258
+#define INFF_C_GET_VAR				262
+#define INFF_C_SET_VAR				263
+#define INFF_C_SET_WSEC_PMK			268
+
+#define INFF_FW_BADARG				2
+#define INFF_FW_UNSUPPORTED			23
+
+s32 inff_fil_cmd_data_set(struct inff_if *ifp, u32 cmd, void *data, u32 len);
+s32 inff_fil_cmd_data_get(struct inff_if *ifp, u32 cmd, void *data, u32 len);
+s32 inff_fil_cmd_int_set(struct inff_if *ifp, u32 cmd, u32 data);
+s32 inff_fil_cmd_int_get(struct inff_if *ifp, u32 cmd, u32 *data);
+
+s32 inff_fil_iovar_data_set(struct inff_if *ifp, const char *name, const void *data,
+			    u32 len);
+s32 inff_fil_iovar_data_get(struct inff_if *ifp, const char *name, void *data,
+			    u32 len);
+s32 inff_fil_iovar_int_set(struct inff_if *ifp, const char *name, u32 data);
+s32 inff_fil_iovar_int_get(struct inff_if *ifp, const char *name, u32 *data);
+
+s32 inff_fil_bsscfg_data_set(struct inff_if *ifp, const char *name, void *data,
+			     u32 len);
+s32 inff_fil_bsscfg_data_get(struct inff_if *ifp, const char *name, void *data,
+			     u32 len);
+s32 inff_fil_bsscfg_int_set(struct inff_if *ifp, const char *name, u32 data);
+s32 inff_fil_bsscfg_int_get(struct inff_if *ifp, const char *name, u32 *data);
+s32 inff_fil_xtlv_data_set(struct inff_if *ifp, const char *name, u16 id,
+			   void *data, u32 len);
+s32 inff_fil_xtlv_data_get(struct inff_if *ifp, const char *name, u16 id,
+			   void *data, u32 len);
+s32 inff_fil_xtlv_int_set(struct inff_if *ifp, const char *name, u16 id, u32 data);
+s32 inff_fil_xtlv_int_get(struct inff_if *ifp, const char *name, u16 id, u32 *data);
+s32 inff_fil_xtlv_int8_get(struct inff_if *ifp, const char *name, u16 id, u8 *data);
+s32 inff_fil_xtlv_int16_get(struct inff_if *ifp, const char *name, u16 id, u16 *data);
+
+#endif /* INFF_FWIL_H */
-- 
2.25.1


