Return-Path: <linux-wireless+bounces-30762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD16D1B3DE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78C8430402FC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC824276051;
	Tue, 13 Jan 2026 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="UqcwvtJu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC52BD586
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336575; cv=none; b=Dx7PSw7ncfc7W0dBxraL6qaxAJjI1HJbk0k8BrAonuJQkHKeh+FGZFBJ47SDq0U61+Cu6qb/vZqRMpu5GcXGdGA4BADULeP9GEsLZeryd05en6P8MiJf6VGCPOSQXDovonyi0+H7yaZqzhi+u5eG0wXeHadgqfYpfmWXCGBN/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336575; c=relaxed/simple;
	bh=+3NmAzCN6o3aXI3PBwe75d0Mob0MYNeu69LY1RJLf3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVlshMZZePMhgRbSj2Cn4l3m1LzJczXqyXsC0qlyis4oW0LFEioDO/Fnxll2AdOHGIYWmDcMidcDmZrmHOP6PnT+1QEyo/WpLDZm3SVU4pVdGxTLWHTInp7j/NPGq22QQt+vMtrrPq+4g3XYO26+apV0K7pQGxFp5kHmclWNHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=UqcwvtJu; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336573; x=1799872573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3NmAzCN6o3aXI3PBwe75d0Mob0MYNeu69LY1RJLf3g=;
  b=UqcwvtJuJOqOQ1JeUC/CURC/PRYUOXcxOYdjQlLI+nUKU4cubt35N8PM
   t+DXaU2cG8A9J3yFAU0+24hDDU5fzRFs/1YYbwK+GXgeKIRph97N6B6cA
   LJR0rWSN5RICEkwCWdArnCwUBHbG/rmPVZUY8WNl+qwPIe9shse/YRr9P
   I=;
X-CSE-ConnectionGUID: kkbBhJLWREWCaHIXwWAC9g==
X-CSE-MsgGUID: zw0DLHK7QEiM968b+QEF/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="139541813"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="139541813"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:36:11 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:36:09 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:36:08 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 08/34] wifi: inffmac: add icdc.c/h
Date: Wed, 14 Jan 2026 02:03:21 +0530
Message-ID: <20260113203350.16734-9-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the ICDC protocol used for the Control and Data
communication with Infineon's Chipsets that have the Connectivity processor
(CP) architecture like the CYW5591x sub-family of chipsets, using SDIO.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/icdc.c | 450 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/icdc.h |  34 ++
 2 files changed, 484 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/icdc.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/icdc.h

diff --git a/drivers/net/wireless/infineon/inffmac/icdc.c b/drivers/net/wireless/infineon/inffmac/icdc.c
new file mode 100644
index 000000000000..86da37f756ca
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/icdc.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+/*******************************************************************************
+ * Communicates with the dongle by using dcmd (CP and FW) codes.
+ * For certain dcmd codes, the dongle interprets string data from the host.
+ ******************************************************************************/
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+
+#include "main.h"
+#include "net.h"
+#include "utils.h"
+#include "fwsignal.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "icdc.h"
+
+struct inff_proto_icdc_dcmd {
+	__le32 cmd;	/* dongle command value */
+	__le32 len;	/* lower 16: output buflen;
+			 * upper 16: input buflen (excludes header)
+			 */
+	__le32 flags;	/* flag defns given below */
+	__le32 status;	/* status code returned from the device */
+	unsigned char ioc_key[ICDC_GCM_KEY_SIZE_BYTES];	/* key used for ioc enc */
+	unsigned char ioc_iv[ICDC_GCM_IV_SIZE];	/* enc field */
+};
+
+/* ICDC flag definitions */
+#define ICDC_DCMD_ERROR		0x01		/* 1=cmd failed */
+#define ICDC_DCMD_SET		0x02		/* 0=get, 1=set cmd */
+#define ICDC_DCMD_IF_MASK	0xF000		/* I/F index */
+#define ICDC_DCMD_IF_SHIFT	12
+#define ICDC_DCMD_ID_MASK	0xFFFF0000	/* id an cmd pairing */
+#define ICDC_DCMD_ID_SHIFT	16		/* ID Mask shift bits */
+#define ICDC_DCMD_ID(flags)	\
+	(((flags) & ICDC_DCMD_ID_MASK) >> ICDC_DCMD_ID_SHIFT)
+
+/*
+ * ICDC header - Infineon specific extension of CDC.
+ * Used on data packets to convey priority.
+ */
+#define	ICDC_HEADER_LEN		4
+#define ICDC_PROTO_VER		2	/* Protocol version */
+#define ICDC_FLAG_VER_MASK	0xf0	/* Protocol version mask */
+#define ICDC_FLAG_VER_SHIFT	4	/* Protocol version shift */
+#define ICDC_FLAG_SUM_GOOD	0x04	/* Good RX checksums */
+#define ICDC_FLAG_SUM_NEEDED	0x08	/* Dongle needs to do TX checksums */
+#define ICDC_PRIORITY_MASK	0x7
+#define ICDC_FLAG2_IF_MASK	0x0f	/* packet rx interface in APSTA */
+#define ICDC_FLAG2_IF_SHIFT	0
+
+#define ICDC_GET_IF_IDX(hdr) \
+	((int)((((hdr)->flags2) & ICDC_FLAG2_IF_MASK) >> ICDC_FLAG2_IF_SHIFT))
+#define ICDC_SET_IF_IDX(hdr, idx) {\
+	typeof(hdr) _hdr = (hdr); \
+	((_hdr)->flags2 = (((_hdr)->flags2 & ~ICDC_FLAG2_IF_MASK) | \
+	((idx) << ICDC_FLAG2_IF_SHIFT))); \
+	}
+
+/**
+ * struct inff_proto_icdc_header - ICDC header format
+ *
+ * @flags: flags contain protocol and checksum info.
+ * @priority: 802.1d priority.
+ * @flags2: additional flags containing dongle interface index.
+ * @data_offset: start of packet data. header is following by firmware signals.
+ */
+struct inff_proto_icdc_header {
+	u8 flags;
+	u8 priority;
+	u8 flags2;
+	u8 data_offset;
+	unsigned char data_key[ICDC_GCM_KEY_SIZE_BYTES];	/* key used for ioc enc */
+	unsigned char data_iv[ICDC_GCM_IV_SIZE];	/* enc field */
+};
+
+/*
+ * maximum length of firmware signal data between
+ * the ICDC header and packet data in the tx path.
+ */
+#define INFF_PROT_FW_SIGNAL_MAX_TXBYTES	12
+
+#define RETRIES 2 /* # of retries to retrieve matching dcmd response */
+#define BUS_HEADER_LEN	(16 + 64)	/* Must be at least SDPCM_RESERVE
+					 * (amount of header tha might be added)
+					 * plus any space that might be needed
+					 * for bus alignment padding.
+					 */
+#define ROUND_UP_MARGIN 2048
+
+struct inff_icdc {
+	u16 reqid;
+	u8 bus_header[BUS_HEADER_LEN];
+	struct inff_proto_icdc_dcmd msg;
+	unsigned char buf[INFF_DCMD_MAXLEN];
+};
+
+static int
+inff_proto_icdc_msg(struct inff_pub *drvr, int ifidx, uint cmd, void *buf,
+		    uint len, bool set)
+{
+	struct inff_icdc *icdc = (struct inff_icdc *)drvr->proto->pd;
+	struct inff_proto_icdc_dcmd *msg = &icdc->msg;
+	u32 flags;
+
+	memset(msg, 0, sizeof(struct inff_proto_icdc_dcmd));
+
+	msg->cmd = cpu_to_le32(cmd);
+	msg->len = cpu_to_le32(len);
+	flags = (++icdc->reqid << ICDC_DCMD_ID_SHIFT);
+
+	flags = (ICDC_PROTO_VER << ICDC_FLAG_VER_SHIFT);
+	flags |= (++icdc->reqid << ICDC_DCMD_ID_SHIFT);
+
+	if (set)
+		flags |= ICDC_DCMD_SET;
+	flags = (flags & ~ICDC_DCMD_IF_MASK) |
+		(ifidx << ICDC_DCMD_IF_SHIFT);
+	msg->flags = cpu_to_le32(flags);
+
+	if (buf)
+		memcpy(icdc->buf, buf, len);
+
+	len += sizeof(*msg);
+	if (len > INFF_TX_IOCTL_MAX_MSG_SIZE)
+		len = INFF_TX_IOCTL_MAX_MSG_SIZE;
+
+	/* Send request */
+	return inff_bus_txctl(drvr->bus_if, (unsigned char *)&icdc->msg, len);
+}
+
+static int
+inff_proto_icdc_cmplt(struct inff_pub *drvr, u32 id, u32 len)
+{
+	int ret;
+	struct inff_icdc *icdc = (struct inff_icdc *)drvr->proto->pd;
+
+	len += sizeof(struct inff_proto_icdc_dcmd);
+	do {
+		ret = inff_bus_rxctl(drvr->bus_if, (unsigned char *)&icdc->msg,
+				     len);
+		if (ret < 0)
+			break;
+	} while (ICDC_DCMD_ID(le32_to_cpu(icdc->msg.flags)) != id);
+
+	return ret;
+}
+
+static int
+inff_proto_icdc_query_dcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			   void *buf, uint len, int *err)
+{
+	struct inff_icdc *icdc = (struct inff_icdc *)drvr->proto->pd;
+	struct inff_proto_icdc_dcmd *msg = &icdc->msg;
+	void *info;
+	int ret = 0, retries = 0;
+	u32 id, flags;
+
+	*err = 0;
+	ret = inff_proto_icdc_msg(drvr, ifidx, cmd, buf, len, false);
+	if (ret < 0) {
+		iphy_err(drvr, "inff_proto_icdc_msg failed w/status %d\n",
+			 ret);
+		goto done;
+	}
+
+retry:
+	/* wait for interrupt and get first fragment */
+	ret = inff_proto_icdc_cmplt(drvr, icdc->reqid, len);
+	if (ret < 0)
+		goto done;
+
+	flags = le32_to_cpu(msg->flags);
+	id = (flags & ICDC_DCMD_ID_MASK) >> ICDC_DCMD_ID_SHIFT;
+
+	if (id < icdc->reqid && (++retries < RETRIES))
+		goto retry;
+	if (id != icdc->reqid) {
+		iphy_err(drvr, "%s: unexpected request id %d (expected %d)\n",
+			 inff_ifname(inff_get_ifp(drvr, ifidx)), id,
+			 icdc->reqid);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* Check info buffer */
+	info = (void *)&icdc->buf[0];
+
+	/* Copy info buffer */
+	if (buf) {
+		if (ret < (int)len)
+			len = ret;
+		memcpy(buf, info, len);
+	}
+
+	ret = 0;
+
+	/* Check the ERROR flag */
+	if (flags & ICDC_DCMD_ERROR)
+		*err = le32_to_cpu(msg->status);
+done:
+	return ret;
+}
+
+static int
+inff_proto_icdc_query_cpcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			    void *buf, uint len, int *cperr)
+{
+	inff_dbg(ICDC, "cmd %d len %d\n", cmd, len);
+
+	cmd = (CMD_TYPE_CP << CMD_TYPE_SHIFT) | cmd;
+
+	return inff_proto_icdc_query_dcmd(drvr, ifidx, cmd,
+					  buf, len, cperr);
+}
+
+static int
+inff_proto_icdc_query_fwcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			    void *buf, uint len, int *fwerr)
+{
+	inff_dbg(ICDC, "cmd %d len %d\n", cmd, len);
+
+	cmd = (CMD_TYPE_WL << CMD_TYPE_SHIFT) | cmd;
+
+	return inff_proto_icdc_query_dcmd(drvr, ifidx, cmd,
+					  buf, len, fwerr);
+}
+
+static int
+inff_proto_icdc_set_dcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			 void *buf, uint len, int *err)
+{
+	struct inff_icdc *icdc = (struct inff_icdc *)drvr->proto->pd;
+	struct inff_proto_icdc_dcmd *msg = &icdc->msg;
+	int ret;
+	u32 flags, id;
+
+	inff_dbg(ICDC, "cmd %d len %d\n", cmd, len);
+
+	*err = 0;
+	ret = inff_proto_icdc_msg(drvr, ifidx, cmd, buf, len, true);
+	if (ret < 0)
+		goto done;
+
+	ret = inff_proto_icdc_cmplt(drvr, icdc->reqid, len);
+	if (ret < 0)
+		goto done;
+
+	flags = le32_to_cpu(msg->flags);
+	id = (flags & ICDC_DCMD_ID_MASK) >> ICDC_DCMD_ID_SHIFT;
+
+	if (id != icdc->reqid) {
+		iphy_err(drvr, "%s: unexpected request id %d (expected %d)\n",
+			 inff_ifname(inff_get_ifp(drvr, ifidx)), id,
+			 icdc->reqid);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = 0;
+
+	/* Check the ERROR flag */
+	if (flags & ICDC_DCMD_ERROR)
+		*err = le32_to_cpu(msg->status);
+
+done:
+	return ret;
+}
+
+static int
+inff_proto_icdc_set_cpcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			  void *buf, uint len, int *cperr)
+{
+	inff_dbg(ICDC, "cmd %d len %d\n", cmd, len);
+
+	cmd = (CMD_TYPE_CP << CMD_TYPE_SHIFT) | cmd;
+
+	return inff_proto_icdc_set_dcmd(drvr, ifidx, cmd,
+					buf, len, cperr);
+}
+
+static int
+inff_proto_icdc_set_fwcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			  void *buf, uint len, int *fwerr)
+{
+	inff_dbg(ICDC, "cmd %d len %d\n", cmd, len);
+
+	cmd = (CMD_TYPE_WL << CMD_TYPE_SHIFT) | cmd;
+
+	return inff_proto_icdc_set_dcmd(drvr, ifidx, cmd,
+					buf, len, fwerr);
+}
+
+static void
+inff_proto_icdc_hdrpush(struct inff_pub *drvr, int ifidx, u8 offset,
+			struct sk_buff *pktbuf)
+{
+	struct inff_proto_icdc_header *h;
+
+	/* Push BDC header used to convey priority for buses that don't */
+	skb_push(pktbuf, ICDC_HEADER_LEN);
+
+	h = (struct inff_proto_icdc_header *)(pktbuf->data);
+
+	h->flags = (ICDC_PROTO_VER << ICDC_FLAG_VER_SHIFT);
+	if (pktbuf->ip_summed == CHECKSUM_PARTIAL)
+		h->flags |= ICDC_FLAG_SUM_NEEDED;
+
+	h->priority = (pktbuf->priority & ICDC_PRIORITY_MASK);
+	h->flags2 = 0;
+	h->data_offset = offset;
+	ICDC_SET_IF_IDX(h, ifidx);
+}
+
+static int
+inff_proto_icdc_hdrpull(struct inff_pub *drvr, bool do_fws,
+			struct sk_buff *pktbuf, struct inff_if **ifp)
+{
+	struct inff_proto_icdc_header *h;
+	struct inff_if *tmp_if;
+
+	/* Pop ICDC header used to convey priority for buses that don't */
+	if (pktbuf->len <= ICDC_HEADER_LEN) {
+		inff_dbg(INFO, "rx data too short (%d <= %d)\n",
+			 pktbuf->len, ICDC_HEADER_LEN);
+		return -EBADE;
+	}
+
+	h = (struct inff_proto_icdc_header *)(pktbuf->data);
+
+	tmp_if = inff_get_ifp(drvr, ICDC_GET_IF_IDX(h));
+	if (!tmp_if) {
+		inff_dbg(INFO, "no matching ifp found for ifidx: %d\n",
+			 ICDC_GET_IF_IDX(h));
+		return -EBADE;
+	}
+	if (((h->flags & ICDC_FLAG_VER_MASK) >> ICDC_FLAG_VER_SHIFT) !=
+	    ICDC_PROTO_VER) {
+		iphy_err(drvr, "%s: non-ICDC packet received, flags 0x%x\n",
+			 inff_ifname(tmp_if), h->flags);
+		return -EBADE;
+	}
+
+	if (h->flags & ICDC_FLAG_SUM_GOOD) {
+		inff_dbg(ICDC, "%s: BDC rcv, good checksum, flags 0x%x\n",
+			 inff_ifname(tmp_if), h->flags);
+		pktbuf->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	pktbuf->priority = h->priority & ICDC_PRIORITY_MASK;
+
+	skb_pull(pktbuf, ICDC_HEADER_LEN);
+	if (do_fws)
+		inff_fws_hdrpull(tmp_if, h->data_offset << 2, pktbuf);
+	else
+		skb_pull(pktbuf, h->data_offset << 2);
+
+	if (pktbuf->len == 0)
+		return -ENODATA;
+
+	if (ifp)
+		*ifp = tmp_if;
+	return 0;
+}
+
+static int
+inff_proto_icdc_tx_queue_data(struct inff_pub *drvr, int ifidx,
+			      struct sk_buff *skb)
+{
+	return inff_proto_txdata(drvr, ifidx, 0, skb);
+}
+
+static int
+inff_proto_icdc_txdata(struct inff_pub *drvr, int ifidx, u8 offset,
+		       struct sk_buff *pktbuf)
+{
+	inff_proto_icdc_hdrpush(drvr, ifidx, offset, pktbuf);
+	return inff_bus_txdata(drvr->bus_if, pktbuf);
+}
+
+static void
+inff_proto_icdc_configure_addr_mode(struct inff_pub *drvr, int ifidx,
+				    enum proto_addr_mode addr_mode)
+{
+}
+
+static void
+inff_proto_icdc_delete_peer(struct inff_pub *drvr, int ifidx,
+			    u8 peer[ETH_ALEN])
+{
+}
+
+static void
+inff_proto_icdc_debugfs_create(struct inff_pub *drvr)
+{
+}
+
+int
+inff_proto_icdc_attach(struct inff_pub *drvr)
+{
+	struct inff_icdc *icdc;
+
+	icdc = kzalloc(sizeof(*icdc), GFP_ATOMIC);
+	if (!icdc)
+		goto fail;
+
+	/* ensure that the msg buf directly follows the cdc msg struct */
+	if ((unsigned long)(&icdc->msg + 1) != (unsigned long)icdc->buf) {
+		iphy_err(drvr, "struct inff_proto_icdc is not correctly defined\n");
+		goto fail;
+	}
+
+	drvr->proto->query_cpcmd = inff_proto_icdc_query_cpcmd;
+	drvr->proto->set_cpcmd = inff_proto_icdc_set_cpcmd;
+	drvr->proto->query_fwcmd = inff_proto_icdc_query_fwcmd;
+	drvr->proto->set_fwcmd = inff_proto_icdc_set_fwcmd;
+	drvr->proto->hdrpull = inff_proto_icdc_hdrpull;
+	drvr->proto->tx_queue_data = inff_proto_icdc_tx_queue_data;
+	drvr->proto->txdata = inff_proto_icdc_txdata;
+	drvr->proto->configure_addr_mode = inff_proto_icdc_configure_addr_mode;
+	drvr->proto->delete_peer = inff_proto_icdc_delete_peer;
+	drvr->proto->debugfs_create = inff_proto_icdc_debugfs_create;
+	drvr->proto->pd = icdc;
+
+	drvr->hdrlen += ICDC_HEADER_LEN + INFF_PROT_FW_SIGNAL_MAX_TXBYTES;
+	drvr->bus_if->maxctl = INFF_DCMD_MAXLEN +
+			sizeof(struct inff_proto_icdc_dcmd) + ROUND_UP_MARGIN;
+	return 0;
+
+fail:
+	kfree(icdc);
+	return -ENOMEM;
+}
+
+void
+inff_proto_icdc_detach(struct inff_pub *drvr)
+{
+	struct inff_icdc *icdc = drvr->proto->pd;
+
+	drvr->proto->pd = NULL;
+	kfree(icdc);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/icdc.h b/drivers/net/wireless/infineon/inffmac/icdc.h
new file mode 100644
index 000000000000..c1fb4c23a055
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/icdc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_ICDC_H
+#define INFF_ICDC_H
+
+#define ICDC_PROTO_ENC             (0x01)
+#define ICDC_IOC_ENC_MASK          (0x200)
+#define ICDC_IOC_ENC_SHIFT         (0x09)
+
+#define ICDC_DAT_ENC_MASK          (0x20)
+#define ICDC_DAT_ENC_SHIFT         (0x05)
+
+#define ICDC_GCM_KEY_SIZE_BYTES    (16)
+#define ICDC_GCM_IV_SIZE           (12)
+
+#ifdef CONFIG_INFFMAC_PROTO_ICDC
+int inff_proto_icdc_attach(struct inff_pub *drvr);
+void inff_proto_icdc_detach(struct inff_pub *drvr);
+void inff_proto_icdc_txflowblock(struct device *dev, bool state);
+void inff_icdc_process_event(struct device *dev, struct sk_buff *skb);
+struct sk_buff *inff_icdc_rx(struct device *dev, struct sk_buff *skb,
+			     bool handle_event, bool inirq);
+#else
+static inline int inff_proto_icdc_attach(struct inff_pub *drvr) { return 0; }
+static inline void inff_proto_icdc_detach(struct inff_pub *drvr) {}
+#endif
+
+#endif /* INFF_ICDC_H */
-- 
2.25.1


