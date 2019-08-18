Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15F49174D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHROPk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 10:15:40 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:44203 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfHROPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 10:15:39 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 18 Aug 2019 16:15:32 +0200
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg02-ams.qualcomm.com with ESMTP; 18 Aug 2019 16:15:30 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v7 2/2] nl support for dmtool
Date:   Sun, 18 Aug 2019 17:15:19 +0300
Message-Id: <1566137719-3544-3-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566137719-3544-1-git-send-email-ailizaro@codeaurora.org>
References: <1566137719-3544-1-git-send-email-ailizaro@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/Kconfig   |  11 ++
 drivers/net/wireless/ath/wil6210/Makefile  |   1 +
 drivers/net/wireless/ath/wil6210/ioctl.c   | 245 +++++++++++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/netdev.c  |   8 +
 drivers/net/wireless/ath/wil6210/wil6210.h |   1 +
 include/uapi/linux/wil6210_uapi.h          |  77 +++++++++
 6 files changed, 343 insertions(+)
 create mode 100644 drivers/net/wireless/ath/wil6210/ioctl.c
 create mode 100644 include/uapi/linux/wil6210_uapi.h

diff --git a/drivers/net/wireless/ath/wil6210/Kconfig b/drivers/net/wireless/ath/wil6210/Kconfig
index 0d1a8da..48b14de 100644
--- a/drivers/net/wireless/ath/wil6210/Kconfig
+++ b/drivers/net/wireless/ath/wil6210/Kconfig
@@ -53,3 +53,14 @@ config WIL6210_DEBUGFS
 	  option if you are interested in debugging the driver.
 
 	  If unsure, say Y to make it easier to debug problems.
+
+config WIL6210_WRITE_IOCTL
+	bool "wil6210 write ioctl to the device"
+	depends on WIL6210
+	default y
+	help
+	  Say Y here to allow write-access from user-space to
+	  the device memory through ioctl. This is useful for
+	  debugging purposes only.
+
+	  If unsure, say N.
diff --git a/drivers/net/wireless/ath/wil6210/Makefile b/drivers/net/wireless/ath/wil6210/Makefile
index 53a0d995..83a9696 100644
--- a/drivers/net/wireless/ath/wil6210/Makefile
+++ b/drivers/net/wireless/ath/wil6210/Makefile
@@ -12,6 +12,7 @@ wil6210-y += txrx.o
 wil6210-y += txrx_edma.o
 wil6210-y += debug.o
 wil6210-y += rx_reorder.o
+wil6210-y += ioctl.o
 wil6210-y += fw.o
 wil6210-y += pm.o
 wil6210-y += pmc.o
diff --git a/drivers/net/wireless/ath/wil6210/ioctl.c b/drivers/net/wireless/ath/wil6210/ioctl.c
new file mode 100644
index 0000000..a3af6f5
--- /dev/null
+++ b/drivers/net/wireless/ath/wil6210/ioctl.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (c) 2014,2017 Qualcomm Atheros, Inc.
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/uaccess.h>
+
+#include "wil6210.h"
+#include <uapi/linux/wil6210_uapi.h>
+
+#define wil_hex_dump_ioctl(prefix_str, buf, len) \
+	print_hex_dump_debug("DBG[IOC ]" prefix_str, \
+			     DUMP_PREFIX_OFFSET, 16, 1, buf, len, true)
+#define wil_dbg_ioctl(wil, fmt, arg...) wil_dbg(wil, "DBG[IOC ]" fmt, ##arg)
+
+#define WIL_PRIV_DATA_MAX_LEN	8192
+#define CMD_SET_AP_WPS_P2P_IE	"SET_AP_WPS_P2P_IE"
+/* max memory block for read/write in bytes. BAR size + spare */
+#define WIL_MAX_MEM_BLOCK_SIZE	(8 * 1024 * 1024)
+
+struct wil_android_priv_data {
+	char *buf;
+	int used_len;
+	int total_len;
+};
+
+static void __iomem *wil_ioc_addr(struct wil6210_priv *wil, u32 addr,
+				  u32 size, enum wil_memio_op op)
+{
+	void __iomem *a;
+	u32 off;
+
+	switch (op & wil_mmio_addr_mask) {
+	case wil_mmio_addr_linker:
+		a = wmi_buffer(wil, cpu_to_le32(addr));
+		break;
+	case wil_mmio_addr_ahb:
+		a = wmi_addr(wil, addr);
+		break;
+	case wil_mmio_addr_bar:
+		a = wmi_addr(wil, addr + WIL6210_FW_HOST_OFF);
+		break;
+	default:
+		wil_err(wil, "Unsupported address mode, op = 0x%08x\n", op);
+		return NULL;
+	}
+
+	off = a - wil->csr;
+	if (size >= wil->bar_size - off) {
+		wil_err(wil,
+			"Invalid requested block: off(0x%08x) size(0x%08x)\n",
+			off, size);
+		return NULL;
+	}
+
+	return a;
+}
+
+static int wil_ioc_memio_dword(struct wil6210_priv *wil, void __user *data)
+{
+	struct wil_memio io;
+	void __iomem *a;
+	bool need_copy = false;
+
+	if (copy_from_user(&io, data, sizeof(io)))
+		return -EFAULT;
+
+	wil_dbg_ioctl(wil, "IO: addr = 0x%08x val = 0x%08x op = 0x%08x\n",
+		      io.addr, io.val, io.op);
+
+	a = wil_ioc_addr(wil, io.addr, sizeof(u32), io.op);
+	if (!a) {
+		wil_err(wil, "invalid address 0x%08x, op = 0x%08x\n", io.addr,
+			io.op);
+		return -EINVAL;
+	}
+	/* operation */
+	switch (io.op & wil_mmio_op_mask) {
+	case wil_mmio_read:
+		io.val = readl_relaxed(a);
+		need_copy = true;
+		break;
+#if defined(CONFIG_WIL6210_WRITE_IOCTL)
+	case wil_mmio_write:
+		writel_relaxed(io.val, a);
+		wmb(); /* make sure write propagated to HW */
+		break;
+#endif
+	default:
+		wil_err(wil, "Unsupported operation, op = 0x%08x\n", io.op);
+		return -EINVAL;
+	}
+
+	if (need_copy) {
+		wil_dbg_ioctl(wil,
+			      "IO done: addr(0x%08x) val(0x%08x) op(0x%08x)\n",
+			      io.addr, io.val, io.op);
+		if (copy_to_user(data, &io, sizeof(io)))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int wil_ioc_memio_block(struct wil6210_priv *wil, void __user *data)
+{
+	struct wil_memio_block io;
+	void *block;
+	void __iomem *a;
+	int rc = 0;
+
+	if (copy_from_user(&io, data, sizeof(io)))
+		return -EFAULT;
+
+	wil_dbg_ioctl(wil, "IO: addr = 0x%08x size = 0x%08x op = 0x%08x\n",
+		      io.addr, io.size, io.op);
+
+	/* size */
+	if (io.size > WIL_MAX_MEM_BLOCK_SIZE) {
+		wil_err(wil, "size is too large:  0x%08x\n", io.size);
+		return -EINVAL;
+	}
+	if (io.size % 4) {
+		wil_err(wil, "size is not multiple of 4:  0x%08x\n", io.size);
+		return -EINVAL;
+	}
+
+	a = wil_ioc_addr(wil, io.addr, io.size, io.op);
+	if (!a) {
+		wil_err(wil, "invalid address 0x%08x, op = 0x%08x\n", io.addr,
+			io.op);
+		return -EINVAL;
+	}
+
+	block = kmalloc(io.size, GFP_USER);
+	if (!block)
+		return -ENOMEM;
+
+	/* operation */
+	switch (io.op & wil_mmio_op_mask) {
+	case wil_mmio_read:
+		wil_memcpy_fromio_32(block, a, io.size);
+		wil_hex_dump_ioctl("Read  ", block, io.size);
+		if (copy_to_user(io.block, block, io.size)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+		break;
+#if defined(CONFIG_WIL6210_WRITE_IOCTL)
+	case wil_mmio_write:
+		if (copy_from_user(block, io.block, io.size)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+		wil_memcpy_toio_32(a, block, io.size);
+		wmb(); /* make sure write propagated to HW */
+		wil_hex_dump_ioctl("Write ", block, io.size);
+		break;
+#endif
+	default:
+		wil_err(wil, "Unsupported operation, op = 0x%08x\n", io.op);
+		rc = -EINVAL;
+		break;
+	}
+
+out_free:
+	kfree(block);
+	return rc;
+}
+
+static int wil_ioc_android(struct wil6210_priv *wil, void __user *data)
+{
+	int rc = 0;
+	char *command;
+	struct wil_android_priv_data priv_data;
+
+	wil_dbg_ioctl(wil, "ioc_android\n");
+
+	if (copy_from_user(&priv_data, data, sizeof(priv_data)))
+		return -EFAULT;
+
+	if (priv_data.total_len <= 0 ||
+	    priv_data.total_len >= WIL_PRIV_DATA_MAX_LEN) {
+		wil_err(wil, "invalid data len %d\n", priv_data.total_len);
+		return -EINVAL;
+	}
+
+	command = kmalloc(priv_data.total_len + 1, GFP_KERNEL);
+	if (!command)
+		return -ENOMEM;
+
+	if (copy_from_user(command, priv_data.buf, priv_data.total_len)) {
+		rc = -EFAULT;
+		goto out_free;
+	}
+
+	/* Make sure the command is NUL-terminated */
+	command[priv_data.total_len] = '\0';
+
+	wil_dbg_ioctl(wil, "ioc_android: command = %s\n", command);
+
+	/* P2P not supported, but WPS is (in AP mode).
+	 * Ignore those in order not to block WPS functionality
+	 * in non-P2P mode.
+	 */
+	if (strncasecmp(command, CMD_SET_AP_WPS_P2P_IE,
+			strlen(CMD_SET_AP_WPS_P2P_IE)) == 0)
+		rc = 0;
+	else
+		rc = -ENOIOCTLCMD;
+
+out_free:
+	kfree(command);
+	return rc;
+}
+
+int wil_ioctl(struct wil6210_priv *wil, void __user *data, int cmd)
+{
+	int ret;
+
+	ret = wil_pm_runtime_get(wil);
+	if (ret < 0)
+		return ret;
+
+	switch (cmd) {
+	case WIL_IOCTL_MEMIO:
+		ret = wil_ioc_memio_dword(wil, data);
+		break;
+	case WIL_IOCTL_MEMIO_BLOCK:
+		ret = wil_ioc_memio_block(wil, data);
+		break;
+	case (SIOCDEVPRIVATE + 1):
+		ret = wil_ioc_android(wil, data);
+		break;
+	default:
+		wil_dbg_ioctl(wil, "Unsupported IOCTL 0x%04x\n", cmd);
+		wil_pm_runtime_put(wil);
+		return -ENOIOCTLCMD;
+	}
+
+	wil_pm_runtime_put(wil);
+
+	wil_dbg_ioctl(wil, "ioctl(0x%04x) -> %d\n", cmd, ret);
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 59f041d..bbe5e0a 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -91,12 +91,20 @@ static int wil_stop(struct net_device *ndev)
 	return rc;
 }
 
+static int wil_do_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	struct wil6210_priv *wil = ndev_to_wil(ndev);
+
+	return wil_ioctl(wil, ifr->ifr_data, cmd);
+}
+
 static const struct net_device_ops wil_netdev_ops = {
 	.ndo_open		= wil_open,
 	.ndo_stop		= wil_stop,
 	.ndo_start_xmit		= wil_start_xmit,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_do_ioctl		= wil_do_ioctl,
 };
 
 static int wil6210_netdev_poll_rx(struct napi_struct *napi, int budget)
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index d8c78a0..f200171 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1380,6 +1380,7 @@ void wil_set_crypto_rx(u8 key_index, enum wmi_key_usage key_usage,
 
 int wil_iftype_nl2wmi(enum nl80211_iftype type);
 
+int wil_ioctl(struct wil6210_priv *wil, void __user *data, int cmd);
 int wil_request_firmware(struct wil6210_priv *wil, const char *name,
 			 bool load);
 int wil_request_board(struct wil6210_priv *wil, const char *name);
diff --git a/include/uapi/linux/wil6210_uapi.h b/include/uapi/linux/wil6210_uapi.h
new file mode 100644
index 0000000..860bc7c
--- /dev/null
+++ b/include/uapi/linux/wil6210_uapi.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Qualcomm Atheros, Inc.
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __WIL6210_UAPI_H__
+#define __WIL6210_UAPI_H__
+
+#if !defined(__KERNEL__)
+#define __user
+#endif
+
+#include <linux/sockios.h>
+
+/* Numbers SIOCDEVPRIVATE and SIOCDEVPRIVATE + 1
+ * are used by Android devices to implement PNO (preferred network offload).
+ * Albeit it is temporary solution, use different numbers to avoid conflicts
+ */
+
+/**
+ * Perform 32-bit I/O operation to the card memory
+ *
+ * User code should arrange data in memory like this:
+ *
+ *	struct wil_memio io;
+ *	struct ifreq ifr = {
+ *		.ifr_data = &io,
+ *	};
+ */
+#define WIL_IOCTL_MEMIO (SIOCDEVPRIVATE + 2)
+
+/**
+ * Perform block I/O operation to the card memory
+ *
+ * User code should arrange data in memory like this:
+ *
+ *	void *buf;
+ *	struct wil_memio_block io = {
+ *		.block = buf,
+ *	};
+ *	struct ifreq ifr = {
+ *		.ifr_data = &io,
+ *	};
+ */
+#define WIL_IOCTL_MEMIO_BLOCK (SIOCDEVPRIVATE + 3)
+
+/**
+ * operation to perform
+ *
+ * @wil_mmio_op_mask - bits defining operation,
+ * @wil_mmio_addr_mask - bits defining addressing mode
+ */
+enum wil_memio_op {
+	wil_mmio_read = 0,
+	wil_mmio_write = 1,
+	wil_mmio_op_mask = 0xff,
+	wil_mmio_addr_linker = 0 << 8,
+	wil_mmio_addr_ahb = 1 << 8,
+	wil_mmio_addr_bar = 2 << 8,
+	wil_mmio_addr_mask = 0xff00,
+};
+
+struct wil_memio {
+	uint32_t op; /* enum wil_memio_op */
+	uint32_t addr; /* should be 32-bit aligned */
+	uint32_t val;
+};
+
+struct wil_memio_block {
+	uint32_t op; /* enum wil_memio_op */
+	uint32_t addr; /* should be 32-bit aligned */
+	uint32_t size; /* should be multiple of 4 */
+	void __user *block; /* block address */
+};
+
+#endif /* __WIL6210_UAPI_H__ */
-- 
2.7.4

