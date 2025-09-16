Return-Path: <linux-wireless+bounces-27385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B606B7DCE1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414331C05DE8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FE306B1A;
	Tue, 16 Sep 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="g0UAG48Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDB2E2DF2
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061547; cv=none; b=kqnhRHYenc4yxFk7PB+RqH3UfXENXckuTZkxCH7rySSL2DsLfGDB9fETFX4I7lBjXae6lGk0VMA1Fd+Doaay8kfVSJCIfqDgWOSZfTYqMtKPJff5jv4g3tv+6d+f7UFFt1nuLW9ABwKhp9iFuz9si1dFryWSwn4U97fGFR0h7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061547; c=relaxed/simple;
	bh=KIYi/P2xQ4gqoK+Y7eXWAVTt3OiwpeQuc0U0sb8EVLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWTlYoX9IJfSrSEvc6sHo+hD99jTHAIUuCe1uIi9oNUiV64qc5u7nwIH/z0REo8Ht7bhJg0kYEkZgRc363F+kWyQRetrRJlxZ6elMNGebLG/cgjV2W+0TvWPw2KERn7AxVO3Rbu0VhEIu/OV842NDyAHu09I/GwowUqwxgXsiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=g0UAG48Y; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061545; x=1789597545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIYi/P2xQ4gqoK+Y7eXWAVTt3OiwpeQuc0U0sb8EVLE=;
  b=g0UAG48YJ8sVsPTK3LG+QFrDSshIMgHgnIjcVOWEs6lu5/QLUn0e044C
   s49Q5eIsZ/YbfCpHR8OiB70IE8rhT+HKfFii0qyu+4gB6cn7855ycBcFh
   sMGRfJX5phlk4sSKc5ih8AQXY5IfWQJLPOCm3CV7evOp300SPBuTl9vR8
   c=;
X-CSE-ConnectionGUID: 5DpVym8eSA+j0YDBF9LFxA==
X-CSE-MsgGUID: PYeblhtMTemQ+nqEtQLg3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783718"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:25:43 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:25:43 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:25:40 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 30/57] wifi: inffmac: add bus.h
Date: Wed, 17 Sep 2025 03:47:50 +0530
Message-ID: <20250916221821.4387-36-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
 MUCSE827.infineon.com (172.23.29.20)

Provides the generic bus abstraction layer that supports PCIe and SDIO.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/bus.h | 344 ++++++++++++++++++++
 1 file changed, 344 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus.h

diff --git a/drivers/net/wireless/infineon/inffmac/bus.h b/drivers/net/wireless/infineon/inffmac/bus.h
new file mode 100644
index 000000000000..322de7de1d6c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bus.h
@@ -0,0 +1,344 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_BUS_H
+#define INFF_BUS_H
+
+#include <linux/kernel.h>
+#include <linux/firmware.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include "debug.h"
+#include "msgbuf.h"
+
+/* The interval to poll console */
+#define INFF_CONSOLE	500
+
+/* The maximum console interval value (5 mins) */
+#define MAX_CONSOLE_INTERVAL	(5 * 60 * 1000)
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
+	INFF_PROTO_MSGBUF
+};
+
+/* Types of bus communication with the dongle */
+enum inff_bus_type {
+	INFF_BUSTYPE_SDIO,
+	INFF_BUSTYPE_USB,
+	INFF_BUSTYPE_PCIE
+};
+
+/* Firmware blobs that may be available */
+enum inff_blob_type {
+	INFF_BLOB_CLM,
+};
+
+struct inff_mp_device;
+
+struct inff_bus_dcmd {
+	char *name;
+	char *param;
+	int param_len;
+	struct list_head list;
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
+ * struct inff_bt_dev - bt shared SDIO device.
+ *
+ * @ bt_data: bt internal structure data
+ * @ bt_sdio_int_cb: bt registered interrupt callback function
+ * @ bt_use_count: Counter that tracks whether BT is using the bus
+ */
+struct inff_bt_dev {
+	void	*bt_data;
+	void	(*bt_sdio_int_cb)(void *data);
+	u32	use_count; /* Counter for tracking if BT is using the bus */
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
+ * @bt_dev: bt shared SDIO device
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
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+	struct inff_bt_if *bt_if;
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+	struct inff_chip *chip_pub;
+};
+
+/*
+ * callback wrappers
+ */
+static inline int inff_bus_preinit(struct inff_bus *bus)
+{
+	if (!bus->ops->preinit)
+		return 0;
+	return bus->ops->preinit(bus->dev);
+}
+
+static inline void inff_bus_stop(struct inff_bus *bus)
+{
+	bus->ops->stop(bus->dev);
+}
+
+static inline int inff_bus_txdata(struct inff_bus *bus, struct sk_buff *skb)
+{
+	return bus->ops->txdata(bus->dev, skb);
+}
+
+static inline
+int inff_bus_txctl(struct inff_bus *bus, unsigned char *msg, uint len)
+{
+	return bus->ops->txctl(bus->dev, msg, len);
+}
+
+static inline
+int inff_bus_rxctl(struct inff_bus *bus, unsigned char *msg, uint len)
+{
+	return bus->ops->rxctl(bus->dev, msg, len);
+}
+
+static inline
+struct pktq *inff_bus_gettxq(struct inff_bus *bus)
+{
+	if (!bus->ops->gettxq)
+		return ERR_PTR(-ENOENT);
+
+	return bus->ops->gettxq(bus->dev);
+}
+
+static inline
+void inff_bus_wowl_config(struct inff_bus *bus, bool enabled)
+{
+	if (bus->ops->wowl_config)
+		bus->ops->wowl_config(bus->dev, enabled);
+}
+
+static inline size_t inff_bus_get_ramsize(struct inff_bus *bus)
+{
+	if (!bus->ops->get_ramsize)
+		return 0;
+
+	return bus->ops->get_ramsize(bus->dev);
+}
+
+static inline
+int inff_bus_get_memdump(struct inff_bus *bus, void *data, size_t len)
+{
+	if (!bus->ops->get_memdump)
+		return -EOPNOTSUPP;
+
+	return bus->ops->get_memdump(bus->dev, data, len);
+}
+
+static inline
+int inff_bus_get_blob(struct inff_bus *bus, const struct firmware **fw,
+		      enum inff_blob_type type)
+{
+	return bus->ops->get_blob(bus->dev, fw, type);
+}
+
+static inline
+void inff_bus_debugfs_create(struct inff_bus *bus)
+{
+	if (!bus->ops->debugfs_create)
+		return;
+
+	return bus->ops->debugfs_create(bus->dev);
+}
+
+static inline
+int inff_bus_reset(struct inff_bus *bus)
+{
+	if (!bus->ops->reset)
+		return -EOPNOTSUPP;
+
+	return bus->ops->reset(bus->dev);
+}
+
+static inline void inff_bus_remove(struct inff_bus *bus)
+{
+	if (!bus->ops->remove) {
+		device_release_driver(bus->dev);
+		return;
+	}
+
+	bus->ops->remove(bus->dev);
+}
+
+static inline
+int inff_bus_set_fcmode(struct inff_bus *bus)
+{
+	if (!bus->ops->set_fcmode)
+		return -EOPNOTSUPP;
+
+	return bus->ops->set_fcmode(bus->dev);
+}
+
+static inline
+void inff_bus_interrupt_enable(struct inff_bus *bus)
+{
+	if (!bus->ops->interrupt_enable)
+		return;
+
+	bus->ops->interrupt_enable(bus->dev);
+}
+
+static inline
+void inff_bus_interrupt_disable(struct inff_bus *bus)
+{
+	if (!bus->ops->interrupt_disable)
+		return;
+
+	bus->ops->interrupt_disable(bus->dev);
+}
+
+/*
+ * interface functions from common layer
+ */
+
+/* Receive frame for delivery to OS.  Callee disposes of rxp. */
+struct sk_buff *inff_rx_frame(struct device *dev, struct sk_buff *rxp, bool handle_event,
+			      bool inirq);
+/* Receive async event packet from firmware. Callee disposes of rxp. */
+void inff_rx_event(struct device *dev, struct sk_buff *rxp);
+
+int inff_alloc(struct device *dev, struct inff_mp_device *settings);
+/* Indication from bus module regarding presence/insertion of dongle. */
+int inff_attach(struct device *dev, bool start_bus);
+/* Indication from bus module regarding removal/absence of dongle */
+void inff_detach(struct device *dev);
+void inff_free(struct device *dev);
+/* Indication from bus module that dongle should be reset */
+void inff_dev_reset(struct device *dev);
+/* Request from bus module to initiate a coredump */
+void inff_dev_coredump(struct device *dev);
+/* Indication that firmware has halted or crashed */
+void inff_fw_crashed(struct device *dev);
+
+/* Configure the "global" bus state used by upper layers */
+void inff_bus_change_state(struct inff_bus *bus, enum inff_bus_state state);
+
+s32 inff_iovar_data_set(struct device *dev, char *name, void *data, u32 len);
+void inff_bus_add_txhdrlen(struct device *dev, uint len);
+int inff_fwlog_attach(struct device *dev);
+
+#ifdef CONFIG_INFFMAC_SDIO
+void inff_sdio_exit(void);
+int inff_sdio_register(void);
+#else
+static inline void inff_sdio_exit(void) { }
+static inline int inff_sdio_register(void) { return 0; }
+#endif
+
+#ifdef CONFIG_INFFMAC_PCIE
+void inff_pcie_exit(void);
+int inff_pcie_register(void);
+#else
+static inline void inff_pcie_exit(void) { }
+static inline int inff_pcie_register(void) { return 0; }
+#endif
+
+#endif /* INFF_BUS_H */
-- 
2.25.1


