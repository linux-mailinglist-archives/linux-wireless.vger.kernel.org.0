Return-Path: <linux-wireless+bounces-27362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4ADB7DA30
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F423188F762
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEC32857C;
	Tue, 16 Sep 2025 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="jAg8b1cn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664412877C1
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061267; cv=none; b=Moqmpa5rJEx2I7iPoVkcjt7vpmy7AtMLlh38umxcRRCPzIa5n6lVBXg9Kr7bIsHhW9RJdQBn6XgjVmydAqK0OnEBw9vZDudHWYNtPl2jklvUlHxpYeev4Sy9TJteYtLUzbENmHG4z56f9pY0jUyi5FDlcJnetJaVPFIKSgA2NZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061267; c=relaxed/simple;
	bh=oOP0HbIctTk+MFPC9lA4kiGppCnVLMcSv0mfM347KJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiOIBBIZu/joQ9nZwhEwDAqOri1046YXMYEWrxw+G+qgcCPC0M3S6coHEyzkA7GZ6HRfzlZjHJY17JWd0mNwdY3FtfGOtoLJPlKJHKolc+U1kMITqQOU/k2Cff+Rdby7q+KPb7trYbRwBZcjdE7XxVQ6+9a52cFat3cRDyU7MOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=jAg8b1cn; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061264; x=1789597264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOP0HbIctTk+MFPC9lA4kiGppCnVLMcSv0mfM347KJ4=;
  b=jAg8b1cn0GBdLoOitFrhbZX4Ppk32nb6tzWTkuSYaR9tBXzEMv9DOzuu
   l186u7ICfZdj2HlfHbJ1uupzWNQ726zlUHQ8qYt8pWdan9C0k3VXbmgit
   2/FqLO9Y2CBlfUT1GJvG5Ab3D3+pb5wkfMj5gsrQ/QT6AWte0+ymmnVWm
   o=;
X-CSE-ConnectionGUID: yeT01HMPQI6KpmlPyimgBw==
X-CSE-MsgGUID: Vzpscn0uRKKElpI/QHfAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093303"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:21:02 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:21:02 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:20:59 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 12/57] wifi: inffmac: add bt_shared_sdio.c/h
Date: Wed, 17 Sep 2025 03:47:27 +0530
Message-ID: <20250916221821.4387-13-gokulkumar.sivakumar@infineon.com>
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

Driver implementation of Bluetooth shared SDIO. This feature allows sharing
a common SDIO bus interface between the Bluetooth host Linux driver and
WLAN host Linux driver for any operations to be done in Infineons's
Wi-Fi + Bluetooth combo chipsets.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../infineon/inffmac/bt_shared_sdio.c         | 1009 +++++++++++++++++
 .../infineon/inffmac/bt_shared_sdio.h         |   35 +
 2 files changed, 1044 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/bt_shared_sdio.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bt_shared_sdio.h

diff --git a/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.c b/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.c
new file mode 100644
index 000000000000..763873083217
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.c
@@ -0,0 +1,1009 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2023-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/host.h>
+#include "bus.h"
+#include "chipcommon.h"
+#include "core.h"
+#include "sdio.h"
+#include "fwil.h"
+#include "common.h"
+#include "bt_shared_sdio.h"
+
+/* make sure BTS version is the same as bt drier */
+#define BTS_VER_MAJOR 2
+#define BTS_VER_MINOR 0
+#define BTS_VER_PATCH 0
+#define BTS_VERSION (BTS_VER_MAJOR << 24 | BTS_VER_MINOR << 16 | BTS_VER_PATCH << 8)
+
+/* make sure bt_shared_info is the same as bt drier */
+struct bt_shared_info {
+	/* bt info */
+	void *bt_data;
+	void (*bt_int_fun)(void *data);
+
+	/* wlan info */
+	void *wlan_bus_if;
+	u16 device_id;
+	u32 enum_addr;
+};
+
+/* list wlan private data below */
+#define SDIOD_ADDR_BOUND		0x1000
+#define SDIOD_ADDR_BOUND_MASK		0xfff
+
+struct inff_bus *glob_bus_if;
+
+#define BTS_MAX_ERR_RECORD_CNT 128
+
+enum bts_err_type {
+	ERR_REG_RB = 0,		/* reg read 1 byte error */
+	ERR_REG_WB = 1,		/* reg write 1 byte error */
+	ERR_REG_RL = 2,		/* reg read 4 bytes error */
+	ERR_REG_WL = 3,		/* reg write 4 bytes error */
+	ERR_BUF_RD = 4,		/* receive buffer error */
+	ERR_BUF_WT = 5,		/* send buffer error */
+	ERR_MEM_RW = 6,		/* r/w memory error */
+	ERR_MAX,
+};
+
+struct bts_err_reg {
+	u8 fn;
+	u32 addr;
+	u32 val;
+};
+
+struct bts_err_buf {
+	u32 nbytes;
+};
+
+struct bts_err_mem {
+	bool set;
+	u32 addr;
+	u32 size;
+};
+
+struct bts_cmd_entity {
+	struct list_head list;  /* link into bt_if->err_list */
+	enum bts_err_type type;
+	int err;
+	struct timespec64 time;
+	union {
+		struct bts_err_reg reg;
+		struct bts_err_buf buf;
+		struct bts_err_mem mem;
+	} u;
+};
+
+/**
+ * struct inff_bt_if - bt shared SDIO information.
+ *
+ * @ bt_data: bt internal structure data
+ * @ bt_sdio_int_cb: bt registered interrupt callback function
+ * @ bt_use_count: Counter that tracks whether BT is using the bus
+ */
+struct inff_bt_if {
+	void *bt_data;
+	void (*bt_sdio_int_cb)(void *data);
+	u32 use_count; /* Counter for tracking if BT is using the bus */
+	bool set_bt_reset; /* set bt reset bit in wlan remove flow */
+
+	/* debug purpose */
+	u32 cnt_attach;				/* number of attach */
+	u32 cnt_detach;				/* number of detach */
+	u32 cnt_total_err;			/* number of error */
+	spinlock_t err_list_lock;
+	struct list_head err_list;
+};
+
+bool inff_btsdio_inited(struct inff_bus *bus_if)
+{
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return false;
+	}
+
+	if (!bus_if->bt_if)
+		return false;
+
+	return true;
+}
+
+static char *inff_btsdio_err_char(enum bts_err_type type)
+{
+	switch (type) {
+	case ERR_REG_RB:
+		return "REG_RB";
+	case ERR_REG_WB:
+		return "REG_WB";
+	case ERR_REG_RL:
+		return "REG_RL";
+	case ERR_REG_WL:
+		return "REG_WL";
+	case ERR_BUF_RD:
+		return "BUF_RD";
+	case ERR_BUF_WT:
+		return "BUF_WT";
+	case ERR_MEM_RW:
+		return "MEM_RW";
+	default:
+		return "unknown";
+	}
+}
+
+static void inff_btsdio_err_free_all(struct inff_bt_if *bt_if)
+{
+	struct bts_cmd_entity *cmd = NULL;
+	struct bts_cmd_entity *next = NULL;
+
+	if (!bt_if) {
+		inff_err("bt_if is null\n");
+		return;
+	}
+
+	spin_lock(&bt_if->err_list_lock);
+	list_for_each_entry_safe(cmd, next, &bt_if->err_list, list) {
+		list_del(&cmd->list);
+		kfree(cmd);
+	}
+	spin_unlock(&bt_if->err_list_lock);
+}
+
+static int inff_btsdio_cmd_alloc(struct inff_bt_if *bt_if,  struct bts_cmd_entity **cmd,
+				 enum bts_err_type type, int err)
+{
+	if (!bt_if || !cmd) {
+		inff_err("bt_if(%p) or cmd(%p) is null\n", bt_if, cmd);
+		return -EINVAL;
+	}
+
+	if (++bt_if->cnt_total_err > BTS_MAX_ERR_RECORD_CNT)
+		return -EPERM;
+
+	*cmd = kzalloc(sizeof(**cmd), GFP_KERNEL);
+	if (!*cmd) {
+		inff_err("alloc failed\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&(*cmd)->list);
+	(*cmd)->type = type;
+	(*cmd)->err = err;
+	ktime_get_ts64(&(*cmd)->time);
+
+	return 0;
+}
+
+static void inff_btsdio_err_enq(struct inff_bt_if *bt_if, struct bts_cmd_entity *cmd)
+{
+	if (!bt_if || !cmd) {
+		inff_err("bt_if(%p) or cmd(%p) is null\n", bt_if, cmd);
+		return;
+	}
+
+	spin_lock(&bt_if->err_list_lock);
+	list_add_tail(&cmd->list, &bt_if->err_list);
+	spin_unlock(&bt_if->err_list_lock);
+}
+
+static void inff_btsdio_err_reg_record(struct inff_bt_if *bt_if, enum bts_err_type type,
+				       int err, u8 fn, u32 addr, u32 val)
+{
+	struct bts_cmd_entity *cmd = NULL;
+	struct bts_err_reg *reg = NULL;
+
+	if (!bt_if) {
+		inff_err("bt_if is null\n");
+		return;
+	}
+
+	if (inff_btsdio_cmd_alloc(bt_if, &cmd, type, err))
+		return;
+
+	reg = &cmd->u.reg;
+	reg->fn = fn;
+	reg->addr = addr;
+	reg->val = val;
+	inff_err("[%5lld.%06ld] %8s err: %d\taddr: 0x%x\tval: 0x%x\n",
+		 (long long)cmd->time.tv_sec, cmd->time.tv_nsec / NSEC_PER_USEC,
+		 inff_btsdio_err_char(cmd->type), err, addr, val);
+
+	inff_btsdio_err_enq(bt_if, cmd);
+}
+
+static void inff_btsdio_err_buf_record(struct inff_bt_if *bt_if, enum bts_err_type type,
+				       int err, u32 nbytes)
+{
+	struct bts_cmd_entity *cmd = NULL;
+	struct bts_err_buf *buf = NULL;
+
+	if (!bt_if) {
+		inff_err("bt_if is null\n");
+		return;
+	}
+
+	if (inff_btsdio_cmd_alloc(bt_if, &cmd, type, err))
+		return;
+
+	buf = &cmd->u.buf;
+	buf->nbytes = nbytes;
+	inff_err("[%5lld.%06ld] %8s err: %d\tnbytes: %d\n",
+		 (long long)cmd->time.tv_sec, cmd->time.tv_nsec / NSEC_PER_USEC,
+		 inff_btsdio_err_char(cmd->type), err, nbytes);
+
+	inff_btsdio_err_enq(bt_if, cmd);
+}
+
+static void inff_btsdio_err_mem_record(struct inff_bt_if *bt_if, int err, bool set,
+				       u32 addr, u32 size)
+{
+	struct bts_cmd_entity *cmd = NULL;
+	struct bts_err_mem *mem = NULL;
+
+	if (!bt_if) {
+		inff_err("bt_if is null\n");
+		return;
+	}
+
+	if (inff_btsdio_cmd_alloc(bt_if, &cmd, ERR_MEM_RW, err))
+		return;
+
+	mem = &cmd->u.mem;
+	mem->set = set;
+	mem->addr = addr;
+	mem->size = size;
+	inff_err("[%5lld.%06ld] %8s err: %d\tset: %d\taddr: 0x%x\tsize: %d\n",
+		 (long long)cmd->time.tv_sec, cmd->time.tv_nsec / NSEC_PER_USEC,
+		 inff_btsdio_err_char(cmd->type), err, set, addr, size);
+
+	inff_btsdio_err_enq(bt_if, cmd);
+}
+
+static void inff_btsdio_err_dump(struct seq_file *seq, struct inff_bt_if *bt_if)
+{
+	struct bts_cmd_entity *cmd = NULL;
+	struct bts_err_reg *reg = NULL;
+	struct bts_err_buf *buf = NULL;
+	struct bts_err_mem *mem = NULL;
+	u8 idx = 0;
+
+	if (!bt_if || !seq) {
+		inff_err("bt_if(%p) or seq(%p) is null\n", bt_if, seq);
+		return;
+	}
+
+	if (bt_if->cnt_total_err > 0)
+		seq_printf(seq, "\ntotal error number: %d\n", bt_if->cnt_total_err);
+
+	spin_lock(&bt_if->err_list_lock);
+	list_for_each_entry(cmd, &bt_if->err_list, list) {
+		seq_printf(seq, "%3d: [%5lld.%06ld] %8s err: %d\t",
+			   ++idx, (long long)cmd->time.tv_sec, cmd->time.tv_nsec / NSEC_PER_USEC,
+			   inff_btsdio_err_char(cmd->type), cmd->err);
+		switch (cmd->type) {
+		case ERR_REG_RB:
+		case ERR_REG_RL:
+			reg = &cmd->u.reg;
+			seq_printf(seq, "F%d addr: 0x%x", reg->fn, reg->addr);
+			break;
+		case ERR_REG_WB:
+		case ERR_REG_WL:
+			reg = &cmd->u.reg;
+			seq_printf(seq, "F%d addr: 0x%x\tval: 0x%x",
+				   reg->fn, reg->addr, reg->val);
+			break;
+		case ERR_BUF_RD:
+			seq_puts(seq, "F3");
+			break;
+		case ERR_BUF_WT:
+			buf = &cmd->u.buf;
+			seq_printf(seq, "F3 nbytes: %d", buf->nbytes);
+			break;
+		case ERR_MEM_RW:
+			mem = &cmd->u.mem;
+			seq_printf(seq, "F1 set: %d\taddr: %d\tsize: %d",
+				   mem->set, mem->addr, mem->size);
+			break;
+		default:
+			break;
+		}
+		seq_puts(seq, "\n");
+	}
+	spin_unlock(&bt_if->err_list_lock);
+}
+
+static int inff_btsdio_debugfs_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = NULL;
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_bt_if *bt_if = NULL;
+	struct mmc_host *host = NULL;
+
+	if (!seq || !data) {
+		inff_err("seq(%p) or data(%p) is null\n", seq, data);
+		return 0;
+	}
+	bus_if = dev_get_drvdata(seq->private);
+
+	if (!inff_btsdio_inited(bus_if)) {
+		seq_printf(seq, "Invalid bus_if (%p) or bt_if\n", bus_if);
+		return 0;
+	}
+
+	sdiodev = bus_if->bus_priv.sdio;
+	bt_if = bus_if->bt_if;
+
+	seq_printf(seq,
+		   "chip: 0x%x\tversion (%d.%d.%d)\n"
+		   "attach: %d\tdetach: %d\n"
+		   "set_bt_reset: %d\n",
+		   sdiodev->func1->device, BTS_VER_MAJOR, BTS_VER_MINOR, BTS_VER_PATCH,
+		   bt_if->cnt_attach, bt_if->cnt_detach,
+		   bt_if->set_bt_reset);
+
+	if (bt_if->cnt_attach > bt_if->cnt_detach)
+		seq_printf(seq, "bt data: 0x%p\tbt cb: 0x%p\n",
+			   bt_if->bt_data, bt_if->bt_sdio_int_cb);
+
+	host = sdiodev->func2->card->host;
+	seq_printf(seq, "\nhost\n"
+		   "%-5s: 0x%08x\t%-5s: 0x%08x\n"
+		   "%-12s:%8d\t%-12s:%8d\t%-12s:%8d\t%-12s:%8d\n",
+		   "caps", host->caps, "caps2", host->caps2,
+		   "max blk cnt", host->max_blk_count,
+		   "max req size", host->max_req_size,
+		   "max seg", host->max_segs,
+		   "max seg size", host->max_seg_size);
+
+	seq_printf(seq, "\ndevice\n"
+		   "%10s: %d\n"
+		   "%-12s: %8d\t%-12s: %8d\t%-12s: %8d\n",
+		   "sg_support", sdiodev->sg_support,
+		   "max req size", sdiodev->max_request_size,
+		   "max seg cnt", sdiodev->max_segment_count,
+		   "max seq size", sdiodev->max_segment_size);
+
+	seq_printf(seq, "\nblock size\n"
+		   "%-3s:%4d\t%-3s:%4d\t%-3s:%4d\n",
+		   "F1", sdiodev->func1->cur_blksize,
+		   "F2", sdiodev->func2->cur_blksize,
+		   "F3", sdiodev->func3->cur_blksize);
+
+	inff_btsdio_err_dump(seq, bt_if);
+
+	return 0;
+}
+
+static void *inff_btsdio_get_func_entity(struct inff_sdio_dev *sdiodev, u8 fn)
+{
+	struct sdio_func *func = NULL;
+
+	if (!sdiodev) {
+		inff_err("sdiodev is null\n");
+		return NULL;
+	}
+
+	if (fn == SDIO_FUNC_1)
+		func = sdiodev->func1;
+	else if (fn == SDIO_FUNC_2)
+		func = sdiodev->func2;
+	else if (fn == SDIO_FUNC_3)
+		func = sdiodev->func3;
+
+	return func;
+}
+
+static void inff_btsdio_int_handler(struct sdio_func *func)
+{
+	struct inff_bus *bus_if = NULL;
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_bt_if *bt_if = NULL;
+
+	if (!func) {
+		inff_err("func is null\n");
+		return;
+	}
+	bus_if = dev_get_drvdata(&func->dev);
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return;
+	}
+	sdiodev = bus_if->bus_priv.sdio;
+	bt_if = bus_if->bt_if;
+
+	if (!bus_if->bt_if)
+		return;
+
+	inff_dbg(INTR, "F%d IB intr triggered\n", func->num);
+
+	if (bt_if->bt_sdio_int_cb)
+		bt_if->bt_sdio_int_cb(bt_if->bt_data);
+}
+
+bool inff_btsdio_is_active(struct inff_bus *bus_if)
+{
+	struct inff_bt_if *bt_if = NULL;
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return false;
+	}
+
+	if (!bus_if->bt_if)
+		return false;
+
+	bt_if = bus_if->bt_if;
+
+	if (bt_if->use_count == 0)
+		return false;
+
+	return true;
+}
+
+bool inff_btsdio_set_bt_reset(struct inff_bus *bus_if)
+{
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return false;
+	}
+
+	if (!bus_if->bt_if)
+		return false;
+
+	return bus_if->bt_if->set_bt_reset;
+}
+
+int inff_bus_attach(u32 ver, void *info)
+{
+	struct bt_shared_info *bts_info = NULL;
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_bt_if *bt_if = NULL;
+
+	inff_dbg(INFO, "Enter\n");
+
+	if (!info) {
+		inff_err("info is null\n");
+		return -EINVAL;
+	}
+	bts_info = (struct bt_shared_info *)info;
+
+	if (!glob_bus_if) {
+		inff_err("btsdio is not initialized\n");
+		return -EINVAL;
+	}
+
+	if (!glob_bus_if->bt_if) {
+		inff_err("bt dev is not allocated\n");
+		return -EINVAL;
+	}
+
+	sdiodev = glob_bus_if->bus_priv.sdio;
+
+	if (ver != BTS_VERSION) {
+		inff_err("version mismatch, bt 0x%x != wlan 0x%x\n",
+			 ver, BTS_VERSION);
+		return -EINVAL;
+	}
+
+	/* Get info from bt dev */
+	bt_if = glob_bus_if->bt_if;
+	bt_if->bt_data = bts_info->bt_data;
+	bt_if->bt_sdio_int_cb = bts_info->bt_int_fun;
+
+	/* Provide wlan info to bt dev */
+	bts_info->wlan_bus_if = glob_bus_if;
+	bts_info->device_id = sdiodev->func1->device;
+	bts_info->enum_addr = inff_sdio_get_enum_addr(sdiodev->bus);
+
+	bt_if->cnt_attach++;
+	inff_dbg(INFO, "Done: device: 0x%x, enum addr: 0x%08x\n",
+		 sdiodev->func1->device, bts_info->enum_addr);
+	return 0;
+}
+EXPORT_SYMBOL(inff_bus_attach);
+
+void inff_bus_detach(struct inff_bus *bus_if)
+{
+	struct inff_bt_if *bt_if = NULL;
+
+	inff_dbg(INFO, "Enter\n");
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return;
+	}
+
+	if (!bus_if->bt_if)
+		return;
+
+	bt_if = bus_if->bt_if;
+
+	if (bt_if->bt_data)
+		bt_if->bt_data = NULL;
+	if (bt_if->bt_sdio_int_cb)
+		bt_if->bt_sdio_int_cb = NULL;
+
+	bt_if->cnt_detach++;
+	inff_dbg(INFO, "Done\n");
+}
+EXPORT_SYMBOL(inff_bus_detach);
+
+u8 inff_bus_reg_readb(struct inff_bus *bus_if, u8 fn, u32 addr, int *err)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct sdio_func *func = NULL;
+	u8 val = 0;
+
+	if (!bus_if || !err) {
+		inff_err("bus_if(%p) or err(%p) is null\n", bus_if, err);
+		*err = -EINVAL;
+		return 0;
+	}
+
+	if (!bus_if->bt_if) {
+		*err = -EINVAL;
+		return 0;
+	}
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	func = inff_btsdio_get_func_entity(sdiodev, fn);
+	if (fn > SDIO_FUNC_3 || (fn != SDIO_FUNC_0 && !func)) {
+		inff_err("invalid function number = %d\n", fn);
+		*err = -EINVAL;
+		return 0;
+	}
+
+	sdio_claim_host(sdiodev->func1);
+	if (fn == SDIO_FUNC_0)
+		val = inff_sdiod_func0_rb(sdiodev, addr, err);
+	else
+		val = inff_sdiod_func_rb(sdiodev, func, addr, err);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(SDIO, "F%d addr: 0x%08x, val: 0x%02x, err: %d\n", fn, addr, val, *err);
+
+	if (*err)
+		inff_btsdio_err_reg_record(bus_if->bt_if, ERR_REG_RB, *err, fn, addr, val);
+
+	return val;
+}
+EXPORT_SYMBOL(inff_bus_reg_readb);
+
+void inff_bus_reg_writeb(struct inff_bus *bus_if, u8 fn, u32 addr, u8 val, int *err)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct sdio_func *func = NULL;
+
+	if (!bus_if || !err) {
+		inff_err("bus_if(%p) or err(%p) is null\n", bus_if, err);
+		*err = -EINVAL;
+		return;
+	}
+
+	if (!bus_if->bt_if) {
+		*err = -EINVAL;
+		return;
+	}
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	func = inff_btsdio_get_func_entity(sdiodev, fn);
+	if (fn > SDIO_FUNC_3 || (fn != SDIO_FUNC_0 && !func)) {
+		inff_err("invalid function number = %d\n", fn);
+		*err = -EINVAL;
+		return;
+	}
+
+	sdio_claim_host(sdiodev->func1);
+	if (fn == SDIO_FUNC_0)
+		inff_sdiod_func0_wb(sdiodev, addr, val, err);
+	else
+		inff_sdiod_func_wb(sdiodev, func, addr, val, err);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(SDIO, "F%d addr: 0x%08x, val: 0x%02x, err: %d\n", fn, addr, val, *err);
+
+	if (*err)
+		inff_btsdio_err_reg_record(bus_if->bt_if, ERR_REG_WB, *err, fn, addr, val);
+}
+EXPORT_SYMBOL(inff_bus_reg_writeb);
+
+u32 inff_bus_reg_readl(struct inff_bus *bus_if, u32 addr, int *err)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	u32 val = 0;
+
+	if (!bus_if || !err) {
+		inff_err("bus_if(%p) or err(%p) is null\n", bus_if, err);
+		*err = -EINVAL;
+		return 0;
+	}
+
+	if (!bus_if->bt_if) {
+		*err = -EINVAL;
+		return 0;
+	}
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	val = inff_sdiod_readl(sdiodev, addr, err);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(SDIO, "addr: 0x%08x, val: 0x%02x, err: %d\n", addr, val, *err);
+
+	if (*err)
+		inff_btsdio_err_reg_record(bus_if->bt_if, ERR_REG_RL, *err, 1, addr, val);
+
+	return val;
+}
+EXPORT_SYMBOL(inff_bus_reg_readl);
+
+void inff_bus_reg_writel(struct inff_bus *bus_if, u32 addr, u32 val, int *err)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+
+	if (!bus_if || !err) {
+		inff_err("bus_if(%p) or err(%p) is null\n", bus_if, err);
+		*err = -EINVAL;
+		return;
+	}
+
+	if (!bus_if->bt_if) {
+		*err = -EINVAL;
+		return;
+	}
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	inff_sdiod_writel(sdiodev, addr, val, err);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(SDIO, "addr: 0x%08x, val: 0x%08x, err: %d\n", addr, val, *err);
+
+	if (*err)
+		inff_btsdio_err_reg_record(bus_if->bt_if, ERR_REG_WL, *err, 1, addr, val);
+}
+EXPORT_SYMBOL(inff_bus_reg_writel);
+
+int inff_bus_recv_buf(struct inff_bus *bus_if, u8 *buf, u32 nbytes)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	int err = 0;
+
+	if (!bus_if || !buf) {
+		inff_err("bus_if(%p) or buf(%p) is null\n", bus_if, buf);
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	err = inff_sdiod_recv_buf(sdiodev, SDIO_FUNC_3, buf, nbytes);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(DATA, "F3 receive nbytes: %d, err: %d\n", nbytes, err);
+
+	if (err)
+		inff_btsdio_err_buf_record(bus_if->bt_if, ERR_BUF_RD, err, 0);
+
+	return err;
+} EXPORT_SYMBOL(inff_bus_recv_buf);
+
+int inff_bus_send_buf(struct inff_bus *bus_if, u8 *buf, u32 nbytes)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	int err = 0;
+
+	if (!bus_if || !buf) {
+		inff_err("bus_if(%p) or buf(%p) is null\n", bus_if, buf);
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	err = inff_sdiod_send_buf(sdiodev, SDIO_FUNC_3, buf, nbytes);
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(DATA, "F3 send nbytes: %d, err: %d\n", nbytes, err);
+
+	if (err)
+		inff_btsdio_err_buf_record(bus_if->bt_if, ERR_BUF_WT, err, nbytes);
+
+	return err;
+} EXPORT_SYMBOL(inff_bus_send_buf);
+
+int inff_bus_membytes(struct inff_bus *bus_if, bool set, u32 address, u8 *data, u32 size)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	int err = 0;
+	u32 block1_offset = 0;
+	u32 block2_addr = 0;
+	u16 block1_size = 0;
+	u16 block2_size = 0;
+	u8 *block2_data = 0;
+
+	if (!bus_if || !data) {
+		inff_err("bus_if(%p) or data(%p) is null\n", bus_if, data);
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	sdiodev = bus_if->bus_priv.sdio;
+	sdio_claim_host(sdiodev->func1);
+	do {
+		/* To avoid SDIO access crosses AXI 4k address boundaries crossing */
+		if (((address & SDIOD_ADDR_BOUND_MASK) + size) > SDIOD_ADDR_BOUND) {
+			inff_dbg(SDIO, "data cross 4K boundary\n");
+			/* The 1st 4k packet */
+			block1_offset = address & SDIOD_ADDR_BOUND_MASK;
+			block1_size = (SDIOD_ADDR_BOUND - block1_offset);
+
+			err = inff_sdiod_ramrw(sdiodev, set, address,
+					       data, block1_size);
+			if (err)
+				break;
+
+			/* The 2nd 4k packet */
+			block2_addr = address + block1_size;
+			block2_size = size - block1_size;
+			block2_data = data + block1_size;
+			err = inff_sdiod_ramrw(sdiodev, set, block2_addr,
+					       block2_data, block2_size);
+		} else {
+			err = inff_sdiod_ramrw(sdiodev, set, address, data, size);
+		}
+	} while (false);
+	sdio_release_host(sdiodev->func1);
+
+	if (err)
+		inff_btsdio_err_mem_record(bus_if->bt_if, err, set, address, size);
+
+	return err;
+}
+EXPORT_SYMBOL(inff_bus_membytes);
+
+int inff_bus_set_blocksz(struct inff_bus *bus_if, u16 blocksz)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	int err = 0;
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	inff_dbg(INFO, "set F3 block size to %d\n", blocksz);
+
+	sdiodev = bus_if->bus_priv.sdio;
+	sdio_claim_host(sdiodev->func1);
+	err = sdio_set_block_size(sdiodev->func3, blocksz);
+	sdio_release_host(sdiodev->func1);
+	if (err)
+		inff_err("set F3 block size failed, err: %d\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(inff_bus_set_blocksz);
+
+/* Function to enable the Bus Clock
+ * This function is not callable from non-sleepable context
+ */
+int inff_bus_clk_enable(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_bt_if *bt_if = NULL;
+	int err = 0;
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	bt_if = bus_if->bt_if;
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	bt_if->use_count++;
+	sdio_release_host(sdiodev->func1);
+	err = inff_sdio_sleep(sdiodev->bus, false);
+
+	return err;
+}
+EXPORT_SYMBOL(inff_bus_clk_enable);
+
+/* Function to disable the Bus Clock
+ * This function is not callable from non-sleepable context
+ */
+int inff_bus_clk_disable(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_bt_if *bt_if = NULL;
+	int err = 0;
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return -EINVAL;
+	}
+
+	if (!bus_if->bt_if)
+		return -EINVAL;
+
+	bt_if = bus_if->bt_if;
+	sdiodev = bus_if->bus_priv.sdio;
+
+	sdio_claim_host(sdiodev->func1);
+	if (bt_if->use_count != 0)
+		bt_if->use_count--;
+	sdio_release_host(sdiodev->func1);
+	err = inff_sdio_sleep(sdiodev->bus, true);
+
+	return err;
+}
+EXPORT_SYMBOL(inff_bus_clk_disable);
+
+static bool inff_btsdio_is_over_sdio(struct inff_bus *bus_if)
+{
+	struct inff_pub *drvr = NULL;
+	struct inff_if *ifp = NULL;
+	struct inff_sdio_dev *sdiodev = NULL;
+	u32 bt_over_sdio_hw = 0;
+	int err = 0;
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return -EINVAL;
+	}
+	drvr = bus_if->drvr;
+	ifp = inff_get_ifp(drvr, 0);
+	sdiodev = bus_if->bus_priv.sdio;
+
+	switch (sdiodev->func1->device) {
+	case SDIO_DEVICE_ID_CYPRESS_43022:
+		/* cannot config in OTP */
+		bt_over_sdio_hw = 1;
+		break;
+	case SDIO_DEVICE_ID_CYPRESS_55500:
+		/* should enable feature in OTP */
+		err = inff_fil_iovar_int_get(ifp, "bt_over_sdio", &bt_over_sdio_hw);
+		if (err < 0) {
+			bt_over_sdio_hw = 0;
+			inff_err("failed to get bt_over_sdio\n");
+		}
+		break;
+	default:
+		bt_over_sdio_hw = 0;
+		break;
+	}
+
+	inff_dbg(INFO, "Device: %d (SW: %d, HW: %d)\n",
+		 sdiodev->func1->device, sdiodev->settings->bt_over_sdio,
+		 bt_over_sdio_hw);
+
+	if (sdiodev->settings->bt_over_sdio & bt_over_sdio_hw)
+		return true;
+	else
+		return false;
+}
+
+void inff_btsdio_init(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_sdio_platform_data *pdata = NULL;
+	struct inff_bt_if *bt_if = NULL;
+
+	inff_dbg(INFO, "Enter\n");
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return;
+	}
+	sdiodev = bus_if->bus_priv.sdio;
+	pdata = &sdiodev->settings->bus.sdio;
+
+	if (!inff_btsdio_is_over_sdio(bus_if)) {
+		inff_err("bt over uart\n");
+		return;
+	}
+
+	/* Allocate bt dev */
+	bt_if = kzalloc(sizeof(*bt_if), GFP_ATOMIC);
+	if (!bt_if)
+		return;
+
+	glob_bus_if = bus_if;
+	bus_if->bt_if = bt_if;
+
+	/* Initialize error list */
+	INIT_LIST_HEAD(&bt_if->err_list);
+	spin_lock_init(&bt_if->err_list_lock);
+
+	/* 43022: set bt reset by bt driver
+	 * 55500: set bt reset by wl driver if hw enable bt over sdio
+	 */
+	if (sdiodev->func1->device == SDIO_DEVICE_ID_CYPRESS_55500)
+		bt_if->set_bt_reset = true;
+
+	sdio_claim_host(sdiodev->func1);
+	/* register interrupt */
+	if (!pdata->oob_irq_supported) {
+		inff_dbg(INFO, "register F3 ib irq\n");
+		sdio_claim_irq(sdiodev->func3, inff_btsdio_int_handler);
+	}
+	sdio_release_host(sdiodev->func1);
+
+	inff_dbg(INFO, "init version (%d.%d.%d) done\n",
+		 BTS_VER_MAJOR, BTS_VER_MINOR, BTS_VER_PATCH);
+}
+
+void inff_btsdio_deinit(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiodev = NULL;
+	struct inff_sdio_platform_data *pdata = NULL;
+
+	inff_dbg(INFO, "Enter\n");
+
+	if (!bus_if) {
+		inff_err("bus_if is null\n");
+		return;
+	}
+
+	if (!bus_if->bt_if)
+		return;
+
+	sdiodev = bus_if->bus_priv.sdio;
+	pdata = &sdiodev->settings->bus.sdio;
+
+	/* unregister interrupt */
+	sdio_claim_host(sdiodev->func1);
+	if (!pdata->oob_irq_supported) {
+		inff_dbg(INFO, "release F3 ib irq\n");
+		sdio_release_irq(sdiodev->func3);
+	}
+	sdio_release_host(sdiodev->func1);
+
+	inff_bus_detach(bus_if);
+
+	/* Free all error info */
+	inff_btsdio_err_free_all(bus_if->bt_if);
+
+	/* Free bt dev */
+	kfree(bus_if->bt_if);
+
+	bus_if->bt_if = NULL;
+	glob_bus_if = NULL;
+
+	inff_dbg(INFO, "deinit done\n");
+}
+
+void inff_btsdio_debugfs_create(struct inff_pub *drvr)
+{
+	inff_debugfs_add_entry(drvr, "bts_info", inff_btsdio_debugfs_read);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.h b/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.h
new file mode 100644
index 000000000000..0e5d3d7b8783
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/bt_shared_sdio.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2023-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_BT_SHARED_SDIO_H
+#define	INFF_BT_SHARED_SDIO_H
+
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+
+bool inff_btsdio_inited(struct inff_bus *bus_if);
+bool inff_btsdio_is_active(struct inff_bus *bus_if);
+bool inff_btsdio_set_bt_reset(struct inff_bus *bus_if);
+
+int inff_bus_attach(u32 ver, void *info);
+void inff_bus_detach(struct inff_bus *bus_if);
+u8 inff_bus_reg_readb(struct inff_bus *bus_if, u8 fn, u32 addr, int *err);
+void inff_bus_reg_writeb(struct inff_bus *bus_if, u8 fn, u32 addr, u8 val, int *err);
+u32 inff_bus_reg_readl(struct inff_bus *bus_if, u32 addr, int *err);
+void inff_bus_reg_writel(struct inff_bus *bus_if, u32 addr, u32 val, int *err);
+int inff_bus_recv_buf(struct inff_bus *bus_if, u8 *buf, u32 nbytes);
+int inff_bus_send_buf(struct inff_bus *bus_if, u8 *buf, u32 nbytes);
+int inff_bus_membytes(struct inff_bus *bus_if, bool set, u32 address, u8 *data, u32 size);
+int inff_bus_set_blocksz(struct inff_bus *bus_if, u16 blocksz);
+int inff_bus_clk_enable(struct inff_bus *bus_if);
+int inff_bus_clk_disable(struct inff_bus *bus_if);
+
+void inff_btsdio_init(struct inff_bus *bus_if);
+void inff_btsdio_deinit(struct inff_bus *bus_if);
+void inff_btsdio_debugfs_create(struct inff_pub *drvr);
+
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+
+#endif /* INFF_BT_SHARED_SDIO_H */
-- 
2.25.1


