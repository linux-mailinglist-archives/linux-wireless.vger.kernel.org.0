Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA783A5866
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhFMMxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 08:53:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:20206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhFMMxD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 08:53:03 -0400
IronPort-SDR: m2+ZPJ9QMEBVrkjhpmvPtndiQDU4IIPB7+//tT01Fr474d6jJnb6IIsFtXXFjflg/GaH+oYNht
 tizLr0ROiIyA==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="227158467"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="227158467"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 05:51:02 -0700
IronPort-SDR: 423UCvadIEmDDpHdWreQ1Im64n7IqYw8LiZYuKjZZG5mb4czjT4o2Mm0/3UmzNUQzkYA2MBCQj
 DGCGBeuMX8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="scan'208";a="449613002"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2021 05:51:00 -0700
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        linuxwwan@intel.com
Subject: [PATCH V5 07/16] net: iosm: wwan port control device
Date:   Sun, 13 Jun 2021 18:20:14 +0530
Message-Id: <20210613125023.18945-8-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210613125023.18945-1-m.chetan.kumar@intel.com>
References: <20210613125023.18945-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implements wwan port for MBIM & AT protocol communication

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
v5: no change.
v4: no change.
v3:
* Renamed file to iosm_ipc_port.c
* WWAN PORT adaptation for AT & MBIM protocol communication.
v2:
* Renamed iosm_sio struct to iosm_cdev.
* Added memory barriers around atomic operations.
---
 drivers/net/wwan/iosm/iosm_ipc_port.c | 85 +++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_port.h | 50 ++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_port.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_port.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_port.c b/drivers/net/wwan/iosm/iosm_ipc_port.c
new file mode 100644
index 000000000000..beb944847398
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_port.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#include "iosm_ipc_chnl_cfg.h"
+#include "iosm_ipc_imem_ops.h"
+#include "iosm_ipc_port.h"
+
+/* open logical channel for control communication */
+static int ipc_port_ctrl_start(struct wwan_port *port)
+{
+	struct iosm_cdev *ipc_port = wwan_port_get_drvdata(port);
+	int ret = 0;
+
+	ipc_port->channel = ipc_imem_sys_port_open(ipc_port->ipc_imem,
+						   ipc_port->chl_id,
+						   IPC_HP_CDEV_OPEN);
+	if (!ipc_port->channel)
+		ret = -EIO;
+
+	return ret;
+}
+
+/* close logical channel */
+static void ipc_port_ctrl_stop(struct wwan_port *port)
+{
+	struct iosm_cdev *ipc_port = wwan_port_get_drvdata(port);
+
+	ipc_imem_sys_cdev_close(ipc_port);
+}
+
+/* transfer control data to modem */
+static int ipc_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct iosm_cdev *ipc_port = wwan_port_get_drvdata(port);
+
+	return ipc_imem_sys_cdev_write(ipc_port, skb);
+}
+
+static const struct wwan_port_ops ipc_wwan_ctrl_ops = {
+	.start = ipc_port_ctrl_start,
+	.stop = ipc_port_ctrl_stop,
+	.tx = ipc_port_ctrl_tx,
+};
+
+/* Port init func */
+struct iosm_cdev *ipc_port_init(struct iosm_imem *ipc_imem,
+				struct ipc_chnl_cfg ipc_port_cfg)
+{
+	struct iosm_cdev *ipc_port = kzalloc(sizeof(*ipc_port), GFP_KERNEL);
+	enum wwan_port_type port_type = ipc_port_cfg.wwan_port_type;
+	enum ipc_channel_id chl_id = ipc_port_cfg.id;
+
+	if (!ipc_port)
+		return NULL;
+
+	ipc_port->dev = ipc_imem->dev;
+	ipc_port->pcie = ipc_imem->pcie;
+
+	ipc_port->port_type = port_type;
+	ipc_port->chl_id = chl_id;
+	ipc_port->ipc_imem = ipc_imem;
+
+	ipc_port->iosm_port = wwan_create_port(ipc_port->dev, port_type,
+					       &ipc_wwan_ctrl_ops, ipc_port);
+
+	return ipc_port;
+}
+
+/* Port deinit func */
+void ipc_port_deinit(struct iosm_cdev *port[])
+{
+	struct iosm_cdev *ipc_port;
+	u8 ctrl_chl_nr;
+
+	for (ctrl_chl_nr = 0; ctrl_chl_nr < IPC_MEM_MAX_CHANNELS;
+	     ctrl_chl_nr++) {
+		if (port[ctrl_chl_nr]) {
+			ipc_port = port[ctrl_chl_nr];
+			wwan_remove_port(ipc_port->iosm_port);
+			kfree(ipc_port);
+		}
+	}
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_port.h b/drivers/net/wwan/iosm/iosm_ipc_port.h
new file mode 100644
index 000000000000..11bc8ed21616
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_port.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_PORT_H
+#define IOSM_IPC_PORT_H
+
+#include <linux/wwan.h>
+
+#include "iosm_ipc_imem_ops.h"
+
+/**
+ * struct iosm_cdev - State of the char driver layer.
+ * @iosm_port:		Pointer of type wwan_port
+ * @ipc_imem:		imem instance
+ * @dev:		Pointer to device struct
+ * @pcie:		PCIe component
+ * @port_type:		WWAN port type
+ * @channel:		Channel instance
+ * @chl_id:		Channel Indentifier
+ */
+struct iosm_cdev {
+	struct wwan_port *iosm_port;
+	struct iosm_imem *ipc_imem;
+	struct device *dev;
+	struct iosm_pcie *pcie;
+	enum wwan_port_type port_type;
+	struct ipc_mem_channel *channel;
+	enum ipc_channel_id chl_id;
+};
+
+/**
+ * ipc_port_init - Allocate IPC port & register to wwan subsystem for AT/MBIM
+ *		   communication.
+ * @ipc_imem:		Pointer to iosm_imem structure
+ * @ipc_port_cfg:	IPC Port Config
+ *
+ * Returns: 0 on success & NULL on failure
+ */
+struct iosm_cdev *ipc_port_init(struct iosm_imem *ipc_imem,
+				struct ipc_chnl_cfg ipc_port_cfg);
+
+/**
+ * ipc_port_deinit - Free IPC port & unregister port with wwan subsystem.
+ * @ipc_port:	Array of pointer to the ipc port data-struct
+ */
+void ipc_port_deinit(struct iosm_cdev *ipc_port[]);
+
+#endif
-- 
2.25.1

