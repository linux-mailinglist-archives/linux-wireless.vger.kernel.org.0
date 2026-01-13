Return-Path: <linux-wireless+bounces-30777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3ECD1B427
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC35E30056E2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343C276051;
	Tue, 13 Jan 2026 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="cn7sy+WD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115C2BCF6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336770; cv=none; b=m8/ifVRap5OmL2TRJudF4Om+4MrhX49H5f5/ZEIAdllC+g2PDO3r82pzuAnfLD9c6nfEocMU9ugBwWDZbk5URkg3m6xvb3TPK+7c/1VpSK9LgnaCasYRJ6EvUIX3iQ317oypmBJ6msWd7BBZFfjyAhxWF1d5ISl3YyeO3y4mWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336770; c=relaxed/simple;
	bh=ZflETcKupFzF03Y/ijUn7wODE0tfbAJh7Jyo0VFs1mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t53IdJoSSElk+Y2RFK4RgMc98EgNmcgCRNa42V/IUBJYHSaTt4yHIT3a5jfpKB5fKC8CYcJuDeDyAJ7AanulUWA32yP8uTifIhKQVWkFq0+HdhKmK+unOLTUl3CyeW2an1/pltde337ujm9TlQgScKFzGqtwiKQOH42i6noTpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=cn7sy+WD; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336768; x=1799872768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZflETcKupFzF03Y/ijUn7wODE0tfbAJh7Jyo0VFs1mg=;
  b=cn7sy+WD8s0PRi1g22luEQSkzdDPYwGxHwA6mdt7FRgQqW0VnpjIYvu6
   Bb2eL/t5LcebH6Bl9vGCTxlQAkUDIYckqwBFB9UOq/CUvQKm+t8XI2Cqu
   Onlcx0ekkdU5Qi1SBbivi3nE8U3+M52lEeTw1YwR6UCEXmo0s8Of2OvDQ
   I=;
X-CSE-ConnectionGUID: 2kBT6wstSZei8J+EgH/uDQ==
X-CSE-MsgGUID: pKqQpRXWRAyBkIR18yrKaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78107242"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78107242"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:39:26 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:39:25 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:39:23 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 22/34] wifi: inffmac: add bus_proto.c/h
Date: Wed, 14 Jan 2026 02:03:35 +0530
Message-ID: <20260113203350.16734-23-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE827.infineon.com (172.23.29.20)

Provides the generic BUS protocol abstraction layer that is used for
the Control and Data communication with the Infineon's WLAN Device
over the PCIe and SDIO BUS types.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/bus_proto.c | 158 +++++++
 .../net/wireless/infineon/inffmac/bus_proto.h | 428 ++++++++++++++++++
 2 files changed, 586 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus_proto.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus_proto.h

diff --git a/drivers/net/wireless/infineon/inffmac/bus_proto.c b/drivers/net/wireless/infineon/inffmac/bus_proto.c
new file mode 100644
index 000000000000..d5c033e8163b
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bus_proto.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+
+#include "main.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "bcdc.h"
+#include "msgbuf.h"
+#include "icdc.h"
+
+static void inff_core_bus_reset(struct work_struct *work)
+{
+	struct inff_pub *drvr = container_of(work, struct inff_pub,
+					     bus_reset);
+
+	inff_bus_reset(drvr->bus_if);
+}
+
+static ssize_t
+inff_bus_reset_write(struct file *file, const char __user *user_buf,
+		     size_t count, loff_t *ppos)
+{
+	struct inff_pub *drvr = file->private_data;
+	u8 value;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &value))
+		return -EINVAL;
+
+	if (value != 1)
+		return -EINVAL;
+
+	schedule_work(&drvr->bus_reset);
+
+	return count;
+}
+
+static const struct file_operations bus_reset_fops = {
+	.open	= simple_open,
+	.write	= inff_bus_reset_write,
+};
+
+void inff_bus_proto_debugfs_create(struct inff_pub *drvr)
+{
+	struct inff_bus *bus = drvr->bus_if;
+
+	debugfs_create_file("reset", 0600, inff_debugfs_get_devdir(drvr),
+			    drvr, &bus_reset_fops);
+
+	if (bus->ops->debugfs_create)
+		bus->ops->debugfs_create(bus->dev);
+
+	if (drvr->proto->debugfs_create)
+		drvr->proto->debugfs_create(drvr);
+}
+
+void inff_bus_change_state(struct inff_bus *bus, enum inff_bus_state state)
+{
+	struct inff_pub *drvr = bus->drvr;
+	struct net_device *ndev;
+	int ifidx;
+
+	inff_dbg(TRACE, "%d -> %d\n", bus->state, state);
+
+	if (!drvr) {
+		inff_dbg(INFO, "ignoring transition, bus not attached yet\n");
+		return;
+	}
+
+	bus->state = state;
+
+	if (state == INFF_BUS_UP) {
+		for (ifidx = 0; ifidx < INFF_MAX_IFS; ifidx++) {
+			if (drvr->iflist[ifidx] &&
+			    drvr->iflist[ifidx]->ndev) {
+				ndev = drvr->iflist[ifidx]->ndev;
+				if (netif_queue_stopped(ndev))
+					netif_wake_queue(ndev);
+			}
+		}
+	}
+}
+
+void inff_bus_add_txhdrlen(struct device *dev, uint len)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (drvr)
+		drvr->hdrlen += len;
+}
+
+int inff_bus_proto_attach(struct inff_pub *drvr)
+{
+	struct inff_proto *proto;
+
+	proto = kzalloc(sizeof(*proto), GFP_ATOMIC);
+	if (!proto)
+		goto fail;
+
+	drvr->proto = proto;
+
+	if (drvr->bus_if->proto_type == INFF_PROTO_ICDC) {
+		if (inff_proto_icdc_attach(drvr))
+			goto fail;
+	} else if (drvr->bus_if->proto_type == INFF_PROTO_BCDC) {
+		if (inff_proto_bcdc_attach(drvr))
+			goto fail;
+	} else if (drvr->bus_if->proto_type == INFF_PROTO_MSGBUF) {
+		if (inff_proto_msgbuf_attach(drvr))
+			goto fail;
+	} else {
+		iphy_err(drvr, "Unsupported proto type %d\n",
+			 drvr->bus_if->proto_type);
+		goto fail;
+	}
+	if (!proto->tx_queue_data || !proto->hdrpull ||
+	    !proto->query_fwcmd || !proto->set_fwcmd ||
+	    !proto->configure_addr_mode ||
+	    !proto->delete_peer ||
+	    !proto->debugfs_create) {
+		iphy_err(drvr, "Not all proto handlers have been installed\n");
+		goto fail;
+	}
+
+	INIT_WORK(&drvr->bus_reset, inff_core_bus_reset);
+
+	return 0;
+
+fail:
+	kfree(proto);
+	drvr->proto = NULL;
+	return -ENOMEM;
+}
+
+void inff_bus_proto_detach(struct inff_pub *drvr)
+{
+	if (drvr->proto) {
+		if (drvr->bus_if->proto_type == INFF_PROTO_ICDC)
+			inff_proto_icdc_detach(drvr);
+		else if (drvr->bus_if->proto_type == INFF_PROTO_BCDC)
+			inff_proto_bcdc_detach(drvr);
+		else if (drvr->bus_if->proto_type == INFF_PROTO_MSGBUF)
+			inff_proto_msgbuf_detach(drvr);
+
+		kfree(drvr->proto);
+		drvr->proto = NULL;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/bus_proto.h b/drivers/net/wireless/infineon/inffmac/bus_proto.h
new file mode 100644
index 000000000000..0426b739522a
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bus_proto.h
@@ -0,0 +1,428 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_BUS_PROTO_H
+#define INFF_BUS_PROTO_H
+
+/* State of bus for communication with the dongle */
+enum inff_bus_state {
+	INFF_BUS_DOWN,		/* Not ready for frame transfers */
+	INFF_BUS_UP		/* Ready for frame transfers */
+};
+
+/* Protocol of bus communication with the dongle */
+enum inff_bus_protocol_type {
+	INFF_PROTO_BCDC,
+	INFF_PROTO_MSGBUF,
+	INFF_PROTO_ICDC
+};
+
+struct inff_bus_dcmd {
+	char *name;
+	char *param;
+	int param_len;
+	struct list_head list;
+};
+
+/* Firmware blobs that may be available */
+enum inff_blob_type {
+	INFF_BLOB_CLM,
+};
+
+/**
+ * struct inff_bus_ops - bus callback operations.
+ *
+ * @preinit: execute bus/device specific dongle init commands (optional).
+ * @init: prepare for communication with dongle.
+ * @stop: clear pending frames, disable data flow.
+ * @txdata: send a data frame to the dongle. When the data
+ *	has been transferred, the common driver must be
+ *	notified using inff_txcomplete(). The common
+ *	driver calls this function with interrupts
+ *	disabled.
+ * @txctl: transmit a control request message to dongle.
+ * @rxctl: receive a control response message from dongle.
+ * @gettxq: obtain a reference of bus transmit queue (optional).
+ * @wowl_config: specify if dongle is configured for wowl when going to suspend
+ * @get_ramsize: obtain size of device memory.
+ * @get_memdump: obtain device memory dump in provided buffer.
+ * @get_blob: obtain a firmware blob.
+ * @remove: initiate unbind of the device.
+ * @interrupt_enable: enable the interrupts from the device.
+ * @interrupt_disable: disable the interrupts from the device.
+ *
+ * This structure provides an abstract interface towards the
+ * bus specific driver. For control messages to common driver
+ * will assure there is only one active transaction. Unless
+ * indicated otherwise these callbacks are mandatory.
+ */
+struct inff_bus_ops {
+	int (*preinit)(struct device *dev);
+	void (*stop)(struct device *dev);
+	int (*txdata)(struct device *dev, struct sk_buff *skb);
+	int (*txctl)(struct device *dev, unsigned char *msg, uint len);
+	int (*rxctl)(struct device *dev, unsigned char *msg, uint len);
+	struct pktq * (*gettxq)(struct device *dev);
+	void (*wowl_config)(struct device *dev, bool enabled);
+	size_t (*get_ramsize)(struct device *dev);
+	int (*get_memdump)(struct device *dev, void *data, size_t len);
+	int (*get_blob)(struct device *dev, const struct firmware **fw,
+			enum inff_blob_type type);
+	void (*debugfs_create)(struct device *dev);
+	int (*reset)(struct device *dev);
+	void (*remove)(struct device *dev);
+	int (*set_fcmode)(struct device *dev);
+	int (*napi_poll)(struct napi_struct *napi, int budget);
+	void (*interrupt_enable)(struct device *dev);
+	void (*interrupt_disable)(struct device *dev);
+};
+
+/**
+ * struct inff_bus_stats - bus statistic counters.
+ *
+ * @pktcowed: packets cowed for extra headroom/unorphan.
+ * @pktcow_failed: packets dropped due to failed cow-ing.
+ */
+struct inff_bus_stats {
+	atomic_t pktcowed;
+	atomic_t pktcow_failed;
+};
+
+/**
+ * struct inff_bus - interface structure between common and bus layer
+ *
+ * @bus_priv: pointer to private bus device.
+ * @proto_type: protocol type, bcdc or msgbuf
+ * @dev: device pointer of bus device.
+ * @drvr: public driver information.
+ * @state: operational state of the bus interface.
+ * @stats: statistics shared between common and bus layer.
+ * @maxctl: maximum size for rxctl request message.
+ * @chip: device identifier of the dongle chip.
+ * @always_use_fws_queue: bus wants use queue also when fwsignal is inactive.
+ * @wowl_supported: is wowl supported by bus driver.
+ * @chiprev: revision of the dongle chip.
+ * @msgbuf: msgbuf protocol parameters provided by bus layer.
+ */
+struct inff_bus {
+	union {
+		struct inff_sdio_dev *sdio;
+		struct inff_pciedev *pcie;
+	} bus_priv;
+	enum inff_bus_protocol_type proto_type;
+	struct device *dev;
+	struct inff_pub *drvr;
+	enum inff_bus_state state;
+	struct inff_bus_stats stats;
+	uint maxctl;
+	u32 chip;
+	u32 chiprev;
+	bool always_use_fws_queue;
+	bool wowl_supported;
+
+	const struct inff_bus_ops *ops;
+	struct inff_bus_msgbuf *msgbuf;
+	struct inff_chip *chip_pub;
+};
+
+enum proto_addr_mode {
+	ADDR_INDIRECT	= 0,
+	ADDR_DIRECT
+};
+
+struct inff_skb_reorder_data {
+	u8 *reorder;
+};
+
+struct inff_proto {
+	int (*query_cpcmd)(struct inff_pub *drvr, int ifidx, uint cmd,
+			   void *buf, uint len, int *fwerr);
+	int (*set_cpcmd)(struct inff_pub *drvr, int ifidx, uint cmd, void *buf,
+			 uint len, int *fwerr);
+	int (*query_fwcmd)(struct inff_pub *drvr, int ifidx, uint cmd,
+			   void *buf, uint len, int *fwerr);
+	int (*set_fwcmd)(struct inff_pub *drvr, int ifidx, uint cmd, void *buf,
+			 uint len, int *fwerr);
+	int (*hdrpull)(struct inff_pub *drvr, bool do_fws,
+		       struct sk_buff *skb, struct inff_if **ifp);
+	int (*tx_queue_data)(struct inff_pub *drvr, int ifidx,
+			     struct sk_buff *skb);
+	int (*txdata)(struct inff_pub *drvr, int ifidx, u8 offset,
+		      struct sk_buff *skb);
+	void (*configure_addr_mode)(struct inff_pub *drvr, int ifidx,
+				    enum proto_addr_mode addr_mode);
+	void (*delete_peer)(struct inff_pub *drvr, int ifidx,
+			    u8 peer[ETH_ALEN]);
+	void (*rxreorder)(struct inff_if *ifp, struct sk_buff *skb, bool inirq);
+	void (*add_if)(struct inff_if *ifp);
+	void (*del_if)(struct inff_if *ifp);
+	void (*reset_if)(struct inff_if *ifp);
+	void (*cleanup_if)(struct inff_if *ifp);
+	int (*init_done)(struct inff_pub *drvr);
+	void (*debugfs_create)(struct inff_pub *drvr);
+	void *pd;
+};
+
+/*
+ * callback wrappers
+ */
+static inline int
+inff_bus_preinit(struct inff_bus *bus)
+{
+	if (!bus->ops->preinit)
+		return 0;
+	return bus->ops->preinit(bus->dev);
+}
+
+static inline void
+inff_bus_stop(struct inff_bus *bus)
+{
+	bus->ops->stop(bus->dev);
+}
+
+static inline int
+inff_bus_txdata(struct inff_bus *bus, struct sk_buff *skb)
+{
+	return bus->ops->txdata(bus->dev, skb);
+}
+
+static inline int
+inff_bus_txctl(struct inff_bus *bus, unsigned char *msg, uint len)
+{
+	return bus->ops->txctl(bus->dev, msg, len);
+}
+
+static inline int
+inff_bus_rxctl(struct inff_bus *bus, unsigned char *msg, uint len)
+{
+	return bus->ops->rxctl(bus->dev, msg, len);
+}
+
+static inline struct pktq *
+inff_bus_gettxq(struct inff_bus *bus)
+{
+	if (!bus->ops->gettxq)
+		return ERR_PTR(-ENOENT);
+
+	return bus->ops->gettxq(bus->dev);
+}
+
+static inline void
+inff_bus_wowl_config(struct inff_bus *bus, bool enabled)
+{
+	if (bus->ops->wowl_config)
+		bus->ops->wowl_config(bus->dev, enabled);
+}
+
+static inline size_t
+inff_bus_get_ramsize(struct inff_bus *bus)
+{
+	if (!bus->ops->get_ramsize)
+		return 0;
+
+	return bus->ops->get_ramsize(bus->dev);
+}
+
+static inline int
+inff_bus_get_memdump(struct inff_bus *bus, void *data, size_t len)
+{
+	if (!bus->ops->get_memdump)
+		return -EOPNOTSUPP;
+
+	return bus->ops->get_memdump(bus->dev, data, len);
+}
+
+static inline int
+inff_bus_get_blob(struct inff_bus *bus, const struct firmware **fw,
+		  enum inff_blob_type type)
+{
+	return bus->ops->get_blob(bus->dev, fw, type);
+}
+
+static inline int
+inff_bus_reset(struct inff_bus *bus)
+{
+	if (!bus->ops->reset)
+		return -EOPNOTSUPP;
+
+	return bus->ops->reset(bus->dev);
+}
+
+static inline void
+inff_bus_remove(struct inff_bus *bus)
+{
+	if (!bus->ops->remove) {
+		device_release_driver(bus->dev);
+		return;
+	}
+
+	bus->ops->remove(bus->dev);
+}
+
+static inline int
+inff_bus_set_fcmode(struct inff_bus *bus)
+{
+	if (!bus->ops->set_fcmode)
+		return -EOPNOTSUPP;
+
+	return bus->ops->set_fcmode(bus->dev);
+}
+
+static inline void
+inff_bus_interrupt_enable(struct inff_bus *bus)
+{
+	if (!bus->ops->interrupt_enable)
+		return;
+
+	bus->ops->interrupt_enable(bus->dev);
+}
+
+static inline void
+inff_bus_interrupt_disable(struct inff_bus *bus)
+{
+	if (!bus->ops->interrupt_disable)
+		return;
+
+	bus->ops->interrupt_disable(bus->dev);
+}
+
+static inline int
+inff_proto_query_cpcmd(struct inff_pub *drvr, int ifidx,
+		       uint cmd, void *buf, uint len,
+		       int *cperr)
+{
+	return drvr->proto->query_cpcmd(drvr, ifidx, cmd, buf, len, cperr);
+}
+
+static inline int
+inff_proto_set_cpcmd(struct inff_pub *drvr, int ifidx,
+		     uint cmd, void *buf, uint len, int *cperr)
+{
+	return drvr->proto->set_cpcmd(drvr, ifidx, cmd, buf, len, cperr);
+}
+
+static inline int
+inff_proto_query_fwcmd(struct inff_pub *drvr, int ifidx,
+		       uint cmd, void *buf, uint len,
+		       int *fwerr)
+{
+	return drvr->proto->query_fwcmd(drvr, ifidx, cmd, buf, len, fwerr);
+}
+
+static inline int
+inff_proto_set_fwcmd(struct inff_pub *drvr, int ifidx,
+		     uint cmd, void *buf, uint len, int *fwerr)
+{
+	return drvr->proto->set_fwcmd(drvr, ifidx, cmd, buf, len, fwerr);
+}
+
+static inline int
+inff_proto_hdrpull(struct inff_pub *drvr, bool do_fws,
+		   struct sk_buff *skb,
+		   struct inff_if **ifp)
+{
+	struct inff_if *tmp = NULL;
+
+	/* assure protocol is always called with
+	 * non-null initialized pointer.
+	 */
+	if (ifp)
+		*ifp = NULL;
+	else
+		ifp = &tmp;
+	return drvr->proto->hdrpull(drvr, do_fws, skb, ifp);
+}
+
+static inline int
+inff_proto_tx_queue_data(struct inff_pub *drvr, int ifidx,
+			 struct sk_buff *skb)
+{
+	return drvr->proto->tx_queue_data(drvr, ifidx, skb);
+}
+
+static inline int
+inff_proto_txdata(struct inff_pub *drvr, int ifidx,
+		  u8 offset, struct sk_buff *skb)
+{
+	return drvr->proto->txdata(drvr, ifidx, offset, skb);
+}
+
+static inline void
+inff_proto_configure_addr_mode(struct inff_pub *drvr, int ifidx,
+			       enum proto_addr_mode addr_mode)
+{
+	drvr->proto->configure_addr_mode(drvr, ifidx, addr_mode);
+}
+
+static inline void
+inff_proto_delete_peer(struct inff_pub *drvr, int ifidx, u8 peer[ETH_ALEN])
+{
+	drvr->proto->delete_peer(drvr, ifidx, peer);
+}
+
+static inline bool inff_proto_is_reorder_skb(struct sk_buff *skb)
+{
+	struct inff_skb_reorder_data *rd;
+
+	rd = (struct inff_skb_reorder_data *)skb->cb;
+	return !!rd->reorder;
+}
+
+static inline void
+inff_proto_rxreorder(struct inff_if *ifp, struct sk_buff *skb, bool inirq)
+{
+	ifp->drvr->proto->rxreorder(ifp, skb, inirq);
+}
+
+static inline void
+inff_proto_add_if(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	if (!drvr->proto->add_if)
+		return;
+	drvr->proto->add_if(ifp);
+}
+
+static inline void
+inff_proto_del_if(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	if (!drvr->proto->del_if)
+		return;
+	drvr->proto->del_if(ifp);
+}
+
+static inline void
+inff_proto_reset_if(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	if (!drvr->proto->reset_if)
+		return;
+	drvr->proto->reset_if(ifp);
+}
+
+static inline void
+inff_proto_cleanup_if(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	if (!drvr->proto->cleanup_if)
+		return;
+	drvr->proto->cleanup_if(ifp);
+}
+
+static inline int
+inff_proto_init_done(struct inff_pub *drvr)
+{
+	if (!drvr->proto->init_done)
+		return 0;
+	return drvr->proto->init_done(drvr);
+}
+
+void inff_bus_proto_debugfs_create(struct inff_pub *drvr);
+void inff_bus_change_state(struct inff_bus *bus, enum inff_bus_state state);
+void inff_bus_add_txhdrlen(struct device *dev, uint len);
+int inff_bus_proto_attach(struct inff_pub *drvr);
+void inff_bus_proto_detach(struct inff_pub *drvr);
+
+#endif /* INFF_BUS_PROTO_H */
-- 
2.25.1


