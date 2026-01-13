Return-Path: <linux-wireless+bounces-30785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50DD1B455
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF2D9309401A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346F1B3925;
	Tue, 13 Jan 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="AsfsZZ3M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CF276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336880; cv=none; b=TaZTqFzkB6Ko2z9mh/NaCgHFnMFaDiKNFKwMAw7vYFyDKTXuu+cwggH2Z5C/1bDR3yU25fWKhhrzviH07SJBT0qKthwmvzGmgWxtayNJUlGm2LzVyaCKw9BqHTkARyqDod8WzALZ9thrVAFWMIe7X5XsWoNWA4c2bJDqnNeJsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336880; c=relaxed/simple;
	bh=JG7VCDo6Q/C5xVhLxXvOcXJXu1awyBnlFfdbaztPt3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAgdVGOnN+8PvKMHQ/gk/D1MJM91aK7/lW4I7mpnT4KaB/feLu8cZKxJmx/VZhK6yU8OqZ1jJ2b02zU9miso7XA/LuXFgyQJtXm1u+4pktZ9HcyxhKu/eEtnkB/QqCYZs9V0AJ///OIyPppR9zBJLVHpbWjF4GEk7HtLFUWdOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=AsfsZZ3M; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336878; x=1799872878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG7VCDo6Q/C5xVhLxXvOcXJXu1awyBnlFfdbaztPt3U=;
  b=AsfsZZ3MbFUU638ws44QAUbFyO7VzHXlB/pEd8Lx194KmzzsgcZt9c1x
   gDdpOX6ed4OUEMJF+wKucFN8qHbCs0dkejxSTVvGxZh35GXfTuWzJk9Vh
   I4q9MApS8A86YKcT8FRcTEeRUCUhpMksdKqwy5mN7tP7rRSxt4DOYSQ2T
   U=;
X-CSE-ConnectionGUID: PC9DWbp1Tl2ovSlPPs8IFg==
X-CSE-MsgGUID: nlYa4WimT5WT1n1x8i763w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568615"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568615"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:41:16 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:41:15 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:41:13 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 30/34] wifi: inffmac: add bcdc.c/h
Date: Wed, 14 Jan 2026 02:03:43 +0530
Message-ID: <20260113203350.16734-31-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the BCDC protocol used for the Control and Data
communication with Infineon's WLAN Device over the SDIO BUS.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/bcdc.c | 525 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/bcdc.h |  27 +
 2 files changed, 552 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.h

diff --git a/drivers/net/wireless/infineon/inffmac/bcdc.c b/drivers/net/wireless/infineon/inffmac/bcdc.c
new file mode 100644
index 000000000000..8297639b4a02
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bcdc.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+/*******************************************************************************
+ * Communicates with the dongle by using dcmd codes.
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
+#include "bcdc.h"
+
+struct inff_proto_bcdc_dcmd {
+	__le32 cmd;	/* dongle command value */
+	__le32 len;	/* lower 16: output buflen;
+			 * upper 16: input buflen (excludes header)
+			 */
+	__le32 flags;	/* flag defns given below */
+	__le32 status;	/* status code returned from the device */
+};
+
+/* BCDC flag definitions */
+#define BCDC_DCMD_ERROR		0x01		/* 1=cmd failed */
+#define BCDC_DCMD_SET		0x02		/* 0=get, 1=set cmd */
+#define BCDC_DCMD_IF_MASK	0xF000		/* I/F index */
+#define BCDC_DCMD_IF_SHIFT	12
+#define BCDC_DCMD_ID_MASK	0xFFFF0000	/* id an cmd pairing */
+#define BCDC_DCMD_ID_SHIFT	16		/* ID Mask shift bits */
+#define BCDC_DCMD_ID(flags)	\
+	(((flags) & BCDC_DCMD_ID_MASK) >> BCDC_DCMD_ID_SHIFT)
+
+/*
+ * BCDC header - Infineon specific extension of CDC.
+ * Used on data packets to convey priority.
+ */
+#define	BCDC_HEADER_LEN		4
+#define BCDC_PROTO_VER		2	/* Protocol version */
+#define BCDC_FLAG_VER_MASK	0xf0	/* Protocol version mask */
+#define BCDC_FLAG_VER_SHIFT	4	/* Protocol version shift */
+#define BCDC_FLAG_SUM_GOOD	0x04	/* Good RX checksums */
+#define BCDC_FLAG_SUM_NEEDED	0x08	/* Dongle needs to do TX checksums */
+#define BCDC_PRIORITY_MASK	0x7
+#define BCDC_FLAG2_IF_MASK	0x0f	/* packet rx interface in APSTA */
+#define BCDC_FLAG2_IF_SHIFT	0
+
+#define BCDC_GET_IF_IDX(hdr) \
+	((int)((((hdr)->flags2) & BCDC_FLAG2_IF_MASK) >> BCDC_FLAG2_IF_SHIFT))
+#define BCDC_SET_IF_IDX(hdr, idx) {\
+	typeof(hdr) _hdr = (hdr); \
+	((_hdr)->flags2 = (((_hdr)->flags2 & ~BCDC_FLAG2_IF_MASK) | \
+	((idx) << BCDC_FLAG2_IF_SHIFT))); \
+	}
+
+/**
+ * struct inff_proto_bcdc_header - BCDC header format
+ *
+ * @flags: flags contain protocol and checksum info.
+ * @priority: 802.1d priority.
+ * @flags2: additional flags containing dongle interface index.
+ * @data_offset: start of packet data. header is following by firmware signals.
+ */
+struct inff_proto_bcdc_header {
+	u8 flags;
+	u8 priority;
+	u8 flags2;
+	u8 data_offset;
+};
+
+/*
+ * maximum length of firmware signal data between
+ * the BCDC header and packet data in the tx path.
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
+struct inff_bcdc {
+	u16 reqid;
+	u8 bus_header[BUS_HEADER_LEN];
+	struct inff_proto_bcdc_dcmd msg;
+	unsigned char buf[INFF_DCMD_MAXLEN];
+	struct inff_fws_info *fws;
+};
+
+struct inff_fws_info *drvr_to_fws(struct inff_pub *drvr)
+{
+	struct inff_bcdc *bcdc = drvr->proto->pd;
+
+	return bcdc->fws;
+}
+
+static int
+inff_proto_bcdc_msg(struct inff_pub *drvr, int ifidx, uint cmd, void *buf,
+		    uint len, bool set)
+{
+	struct inff_bcdc *bcdc = (struct inff_bcdc *)drvr->proto->pd;
+	struct inff_proto_bcdc_dcmd *msg = &bcdc->msg;
+	u32 flags;
+
+	memset(msg, 0, sizeof(struct inff_proto_bcdc_dcmd));
+
+	msg->cmd = cpu_to_le32(cmd);
+	msg->len = cpu_to_le32(len);
+	flags = (++bcdc->reqid << BCDC_DCMD_ID_SHIFT);
+
+	if (set)
+		flags |= BCDC_DCMD_SET;
+	flags = (flags & ~BCDC_DCMD_IF_MASK) |
+		(ifidx << BCDC_DCMD_IF_SHIFT);
+	msg->flags = cpu_to_le32(flags);
+
+	if (buf)
+		memcpy(bcdc->buf, buf, len);
+
+	len += sizeof(*msg);
+	if (len > INFF_TX_IOCTL_MAX_MSG_SIZE)
+		len = INFF_TX_IOCTL_MAX_MSG_SIZE;
+
+	/* Send request */
+	return inff_bus_txctl(drvr->bus_if, (unsigned char *)&bcdc->msg, len);
+}
+
+static int inff_proto_bcdc_cmplt(struct inff_pub *drvr, u32 id, u32 len)
+{
+	int ret;
+	struct inff_bcdc *bcdc = (struct inff_bcdc *)drvr->proto->pd;
+
+	len += sizeof(struct inff_proto_bcdc_dcmd);
+	do {
+		ret = inff_bus_rxctl(drvr->bus_if, (unsigned char *)&bcdc->msg,
+				     len);
+		if (ret < 0)
+			break;
+	} while (BCDC_DCMD_ID(le32_to_cpu(bcdc->msg.flags)) != id);
+
+	return ret;
+}
+
+static int
+inff_proto_bcdc_query_fwcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			    void *buf, uint len, int *fwerr)
+{
+	struct inff_bcdc *bcdc = (struct inff_bcdc *)drvr->proto->pd;
+	struct inff_proto_bcdc_dcmd *msg = &bcdc->msg;
+	void *info;
+	int ret = 0, retries = 0;
+	u32 id, flags;
+
+	inff_dbg(BCDC, "cmd %d len %d\n", cmd, len);
+
+	*fwerr = 0;
+	ret = inff_proto_bcdc_msg(drvr, ifidx, cmd, buf, len, false);
+	if (ret < 0) {
+		iphy_err(drvr, "inff_proto_bcdc_msg failed w/status %d\n",
+			 ret);
+		goto done;
+	}
+
+retry:
+	/* wait for interrupt and get first fragment */
+	ret = inff_proto_bcdc_cmplt(drvr, bcdc->reqid, len);
+	if (ret < 0)
+		goto done;
+
+	flags = le32_to_cpu(msg->flags);
+	id = (flags & BCDC_DCMD_ID_MASK) >> BCDC_DCMD_ID_SHIFT;
+
+	if (id < bcdc->reqid && (++retries < RETRIES))
+		goto retry;
+	if (id != bcdc->reqid) {
+		iphy_err(drvr, "%s: unexpected request id %d (expected %d)\n",
+			 inff_ifname(inff_get_ifp(drvr, ifidx)), id,
+			 bcdc->reqid);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* Check info buffer */
+	info = (void *)&bcdc->buf[0];
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
+	if (flags & BCDC_DCMD_ERROR)
+		*fwerr = le32_to_cpu(msg->status);
+done:
+	return ret;
+}
+
+static int
+inff_proto_bcdc_set_fwcmd(struct inff_pub *drvr, int ifidx, uint cmd,
+			  void *buf, uint len, int *fwerr)
+{
+	struct inff_bcdc *bcdc = (struct inff_bcdc *)drvr->proto->pd;
+	struct inff_proto_bcdc_dcmd *msg = &bcdc->msg;
+	int ret;
+	u32 flags, id;
+
+	inff_dbg(BCDC, "cmd %d len %d\n", cmd, len);
+
+	*fwerr = 0;
+	ret = inff_proto_bcdc_msg(drvr, ifidx, cmd, buf, len, true);
+	if (ret < 0)
+		goto done;
+
+	ret = inff_proto_bcdc_cmplt(drvr, bcdc->reqid, len);
+	if (ret < 0)
+		goto done;
+
+	flags = le32_to_cpu(msg->flags);
+	id = (flags & BCDC_DCMD_ID_MASK) >> BCDC_DCMD_ID_SHIFT;
+
+	if (id != bcdc->reqid) {
+		iphy_err(drvr, "%s: unexpected request id %d (expected %d)\n",
+			 inff_ifname(inff_get_ifp(drvr, ifidx)), id,
+			 bcdc->reqid);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = 0;
+
+	/* Check the ERROR flag */
+	if (flags & BCDC_DCMD_ERROR)
+		*fwerr = le32_to_cpu(msg->status);
+
+done:
+	return ret;
+}
+
+static void
+inff_proto_bcdc_hdrpush(struct inff_pub *drvr, int ifidx, u8 offset,
+			struct sk_buff *pktbuf)
+{
+	struct inff_proto_bcdc_header *h;
+
+	/* Push BDC header used to convey priority for buses that don't */
+	skb_push(pktbuf, BCDC_HEADER_LEN);
+
+	h = (struct inff_proto_bcdc_header *)(pktbuf->data);
+
+	h->flags = (BCDC_PROTO_VER << BCDC_FLAG_VER_SHIFT);
+	if (pktbuf->ip_summed == CHECKSUM_PARTIAL)
+		h->flags |= BCDC_FLAG_SUM_NEEDED;
+
+	h->priority = (pktbuf->priority & BCDC_PRIORITY_MASK);
+	h->flags2 = 0;
+	h->data_offset = offset;
+	BCDC_SET_IF_IDX(h, ifidx);
+}
+
+static int
+inff_proto_bcdc_hdrpull(struct inff_pub *drvr, bool do_fws,
+			struct sk_buff *pktbuf, struct inff_if **ifp)
+{
+	struct inff_proto_bcdc_header *h;
+	struct inff_if *tmp_if;
+
+	/* Pop BCDC header used to convey priority for buses that don't */
+	if (pktbuf->len <= BCDC_HEADER_LEN) {
+		inff_dbg(INFO, "rx data too short (%d <= %d)\n",
+			 pktbuf->len, BCDC_HEADER_LEN);
+		return -EBADE;
+	}
+
+	h = (struct inff_proto_bcdc_header *)(pktbuf->data);
+
+	tmp_if = inff_get_ifp(drvr, BCDC_GET_IF_IDX(h));
+	if (!tmp_if) {
+		inff_dbg(INFO, "no matching ifp found for ifidx: %d\n",
+			 BCDC_GET_IF_IDX(h));
+		return -EBADE;
+	}
+	if (((h->flags & BCDC_FLAG_VER_MASK) >> BCDC_FLAG_VER_SHIFT) !=
+	    BCDC_PROTO_VER) {
+		iphy_err(drvr, "%s: non-BCDC packet received, flags 0x%x\n",
+			 inff_ifname(tmp_if), h->flags);
+		return -EBADE;
+	}
+
+	if (h->flags & BCDC_FLAG_SUM_GOOD) {
+		inff_dbg(BCDC, "%s: BDC rcv, good checksum, flags 0x%x\n",
+			 inff_ifname(tmp_if), h->flags);
+		pktbuf->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	pktbuf->priority = h->priority & BCDC_PRIORITY_MASK;
+
+	skb_pull(pktbuf, BCDC_HEADER_LEN);
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
+static int inff_proto_bcdc_tx_queue_data(struct inff_pub *drvr, int ifidx,
+					 struct sk_buff *skb)
+{
+	struct inff_if *ifp = inff_get_ifp(drvr, ifidx);
+	struct inff_bcdc *bcdc = drvr->proto->pd;
+
+	if (!inff_fws_queue_skbs(bcdc->fws))
+		return inff_proto_txdata(drvr, ifidx, 0, skb);
+
+	return inff_fws_process_skb(ifp, skb);
+}
+
+static int
+inff_proto_bcdc_txdata(struct inff_pub *drvr, int ifidx, u8 offset,
+		       struct sk_buff *pktbuf)
+{
+	inff_proto_bcdc_hdrpush(drvr, ifidx, offset, pktbuf);
+	return inff_bus_txdata(drvr->bus_if, pktbuf);
+}
+
+void inff_proto_bcdc_txflowblock(struct device *dev, bool state)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_fws_bus_blocked(drvr, state);
+}
+
+void
+inff_proto_bcdc_txcomplete(struct device *dev, struct sk_buff *txp,
+			   bool success)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_bcdc *bcdc = bus_if->drvr->proto->pd;
+	struct inff_if *ifp;
+
+	/* await txstatus signal for firmware if active */
+	if (inff_fws_fc_active(bcdc->fws)) {
+		inff_fws_bustxcomplete(bcdc->fws, txp, success);
+	} else {
+		if (inff_proto_bcdc_hdrpull(bus_if->drvr, false, txp, &ifp))
+			inff_pkt_buf_free_skb(txp);
+		else
+			inff_txfinalize(ifp, txp, success);
+	}
+}
+
+static void
+inff_proto_bcdc_configure_addr_mode(struct inff_pub *drvr, int ifidx,
+				    enum proto_addr_mode addr_mode)
+{
+}
+
+static void
+inff_proto_bcdc_delete_peer(struct inff_pub *drvr, int ifidx,
+			    u8 peer[ETH_ALEN])
+{
+}
+
+static void inff_proto_bcdc_rxreorder(struct inff_if *ifp,
+				      struct sk_buff *skb, bool inirq)
+{
+	inff_fws_rxreorder(ifp, skb, inirq);
+}
+
+static void
+inff_proto_bcdc_add_if(struct inff_if *ifp)
+{
+	inff_fws_add_interface(ifp);
+}
+
+static void
+inff_proto_bcdc_del_if(struct inff_if *ifp)
+{
+	inff_fws_del_interface(ifp);
+}
+
+static void
+inff_proto_bcdc_reset_if(struct inff_if *ifp)
+{
+	inff_fws_reset_interface(ifp);
+}
+
+static void
+inff_proto_bcdc_cleanup_if(struct inff_if *ifp)
+{
+	inff_fws_cleanup_interface(ifp);
+}
+
+static int
+inff_proto_bcdc_init_done(struct inff_pub *drvr)
+{
+	struct inff_bcdc *bcdc = drvr->proto->pd;
+	struct inff_fws_info *fws;
+
+	fws = inff_fws_attach(drvr);
+	if (IS_ERR(fws))
+		return PTR_ERR(fws);
+
+	bcdc->fws = fws;
+	return 0;
+}
+
+static void inff_proto_bcdc_debugfs_create(struct inff_pub *drvr)
+{
+	inff_fws_debugfs_create(drvr);
+}
+
+void inff_bcdc_process_event(struct device *dev, struct sk_buff *skb)
+{
+	struct inff_if *ifp;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_dbg(DEVEVT, "%s: rxp=%p\n", dev_name(dev), skb);
+
+	if (inff_rx_hdrpull(drvr, skb, &ifp))
+		return;
+
+	inff_fwevt_process_skb(ifp->drvr, skb, 0, GFP_KERNEL);
+	inff_pkt_buf_free_skb(skb);
+}
+
+void inff_bcdc_rx(struct device *dev, struct sk_buff *skb, bool handle_event,
+		  bool inirq)
+{
+	struct inff_if *ifp;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	inff_dbg(DATA, "%s: rxp=%p\n", dev_name(dev), skb);
+
+	if (inff_rx_hdrpull(drvr, skb, &ifp))
+		return;
+
+	if (inff_proto_is_reorder_skb(skb)) {
+		inff_proto_rxreorder(ifp, skb, inirq);
+	} else {
+		/* Process special event packets */
+		if (handle_event) {
+			gfp_t gfp = inirq ? GFP_ATOMIC : GFP_KERNEL;
+
+			inff_fwevt_process_skb(ifp->drvr, skb,
+					       INFILCP_SUBTYPE_VENDOR_LONG, gfp);
+		}
+
+		inff_net_rx(ifp, skb, inirq);
+	}
+}
+
+int inff_proto_bcdc_attach(struct inff_pub *drvr)
+{
+	struct inff_bcdc *bcdc;
+
+	bcdc = kzalloc(sizeof(*bcdc), GFP_ATOMIC);
+	if (!bcdc)
+		goto fail;
+
+	/* ensure that the msg buf directly follows the cdc msg struct */
+	if ((unsigned long)(&bcdc->msg + 1) != (unsigned long)bcdc->buf) {
+		iphy_err(drvr, "struct inff_proto_bcdc is not correctly defined\n");
+		goto fail;
+	}
+
+	drvr->proto->query_fwcmd = inff_proto_bcdc_query_fwcmd;
+	drvr->proto->set_fwcmd = inff_proto_bcdc_set_fwcmd;
+	drvr->proto->hdrpull = inff_proto_bcdc_hdrpull;
+	drvr->proto->tx_queue_data = inff_proto_bcdc_tx_queue_data;
+	drvr->proto->txdata = inff_proto_bcdc_txdata;
+	drvr->proto->configure_addr_mode = inff_proto_bcdc_configure_addr_mode;
+	drvr->proto->delete_peer = inff_proto_bcdc_delete_peer;
+	drvr->proto->rxreorder = inff_proto_bcdc_rxreorder;
+	drvr->proto->add_if = inff_proto_bcdc_add_if;
+	drvr->proto->del_if = inff_proto_bcdc_del_if;
+	drvr->proto->reset_if = inff_proto_bcdc_reset_if;
+	drvr->proto->cleanup_if = inff_proto_bcdc_cleanup_if;
+	drvr->proto->init_done = inff_proto_bcdc_init_done;
+	drvr->proto->debugfs_create = inff_proto_bcdc_debugfs_create;
+	drvr->proto->pd = bcdc;
+
+	drvr->hdrlen += BCDC_HEADER_LEN + INFF_PROT_FW_SIGNAL_MAX_TXBYTES;
+	drvr->bus_if->maxctl = INFF_DCMD_MAXLEN +
+			sizeof(struct inff_proto_bcdc_dcmd) + ROUND_UP_MARGIN;
+	return 0;
+
+fail:
+	kfree(bcdc);
+	return -ENOMEM;
+}
+
+void inff_proto_bcdc_detach(struct inff_pub *drvr)
+{
+	struct inff_bcdc *bcdc = drvr->proto->pd;
+
+	drvr->proto->pd = NULL;
+	inff_fws_detach(bcdc->fws);
+	kfree(bcdc);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/bcdc.h b/drivers/net/wireless/infineon/inffmac/bcdc.h
new file mode 100644
index 000000000000..413e2f5e36c9
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bcdc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_BCDC_H
+#define INFF_BCDC_H
+
+#ifdef CONFIG_INFFMAC_PROTO_BCDC
+int inff_proto_bcdc_attach(struct inff_pub *drvr);
+void inff_proto_bcdc_detach(struct inff_pub *drvr);
+void inff_proto_bcdc_txflowblock(struct device *dev, bool state);
+void inff_proto_bcdc_txcomplete(struct device *dev, struct sk_buff *txp,
+				bool success);
+struct inff_fws_info *drvr_to_fws(struct inff_pub *drvr);
+void inff_bcdc_process_event(struct device *dev, struct sk_buff *skb);
+void inff_bcdc_rx(struct device *dev, struct sk_buff *skb,
+		  bool handle_event, bool inirq);
+#else
+static inline int inff_proto_bcdc_attach(struct inff_pub *drvr) { return 0; }
+static inline void inff_proto_bcdc_detach(struct inff_pub *drvr) {}
+#endif
+
+#endif /* INFF_BCDC_H */
-- 
2.25.1


