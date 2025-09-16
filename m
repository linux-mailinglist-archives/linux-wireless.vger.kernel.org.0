Return-Path: <linux-wireless+bounces-27371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D328BB7D721
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53907B6D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20742E0415;
	Tue, 16 Sep 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="gQL4fS4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476602248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061378; cv=none; b=d2W+MFxDNdrVt76AsX+0D8++4VrqWmhZSJhPLOwzBZFb4E2KziqElcG/N7gPyC66tO73fc6MG33w6PLCOMDbFHIWPPBl4YOMmCjv2tz/b+IpRIG4h/wkdeLsmxm+YXTanvfrAGr1dbRXI5qb8J7pww0eBFGh5QUxzudzJZo8+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061378; c=relaxed/simple;
	bh=8/mYf93lrScltq3jAw5k6fmba19dwa+pZvwicDtLkvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyJTwVfaFjJniFhO2FlLXz0ZhxAJ0mFmioc99u7GogQugTPgIdtjOyqFgmrUs0fspnqAW+P26RzaSrC41ZoSlHUwAsw/J8PY7Xwngo4PV8Ckypt82JgC34y9UC5brsUP4NRV8Pknn6rZ2fIdj9gUWpvdPowJc+/iBsAa4COjfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=gQL4fS4i; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061375; x=1789597375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/mYf93lrScltq3jAw5k6fmba19dwa+pZvwicDtLkvs=;
  b=gQL4fS4isVnIQRhQAqx0EHr0T4RMYGNXBskbZMYTdoDL4hZfUe6rCaC8
   4dsf8Gxilmeb47aqctoOSrVOFBs+DYMg6McP+mgB2iqxMBApIF2lLbnvp
   c8Y9FIUwMTz/IdTdzIYkBfPnQtyMVZuSBIdCfIWEyi5rIw7EpEoCpp3Cr
   c=;
X-CSE-ConnectionGUID: fCoXfCG0SaigmLLZeTALxw==
X-CSE-MsgGUID: KGvFEFtSRm6ijE9+ymD2xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918358"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918358"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:22:53 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:22:52 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:22:48 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 20/57] wifi: inffmac: add msgbuf.c/h
Date: Wed, 17 Sep 2025 03:47:36 +0530
Message-ID: <20250916221821.4387-22-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the MSGBUF protocol used for the Control and Data
communication with Infineon's WLAN Device over the PCIe BUS.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/msgbuf.c    | 2205 +++++++++++++++++
 .../net/wireless/infineon/inffmac/msgbuf.h    |  109 +
 2 files changed, 2314 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.h

diff --git a/drivers/net/wireless/infineon/inffmac/msgbuf.c b/drivers/net/wireless/infineon/inffmac/msgbuf.c
new file mode 100644
index 000000000000..6d5430406906
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/msgbuf.c
@@ -0,0 +1,2205 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+#include <linux/etherdevice.h>
+#include <linux/net_tstamp.h>
+#include <linux/prefetch.h>
+
+#include "utils.h"
+#include "core.h"
+#include "debug.h"
+#include "proto.h"
+#include "msgbuf.h"
+#include "commonring.h"
+#include "flowring.h"
+#include "bus.h"
+#include "tracepoint.h"
+#include "pcie.h"
+#include "common.h"
+#include "xdp.h"
+
+#define MSGBUF_IOCTL_RESP_TIMEOUT		msecs_to_jiffies(2000)
+
+#define MSGBUF_TYPE_GEN_STATUS			0x1
+#define MSGBUF_TYPE_RING_STATUS			0x2
+#define MSGBUF_TYPE_FLOW_RING_CREATE		0x3
+#define MSGBUF_TYPE_FLOW_RING_CREATE_CMPLT	0x4
+#define MSGBUF_TYPE_FLOW_RING_DELETE		0x5
+#define MSGBUF_TYPE_FLOW_RING_DELETE_CMPLT	0x6
+#define MSGBUF_TYPE_FLOW_RING_FLUSH		0x7
+#define MSGBUF_TYPE_FLOW_RING_FLUSH_CMPLT	0x8
+#define MSGBUF_TYPE_IOCTLPTR_REQ		0x9
+#define MSGBUF_TYPE_IOCTLPTR_REQ_ACK		0xA
+#define MSGBUF_TYPE_IOCTLRESP_BUF_POST		0xB
+#define MSGBUF_TYPE_IOCTL_CMPLT			0xC
+#define MSGBUF_TYPE_EVENT_BUF_POST		0xD
+#define MSGBUF_TYPE_WL_EVENT			0xE
+#define MSGBUF_TYPE_TX_POST			0xF
+#define MSGBUF_TYPE_TX_STATUS			0x10
+#define MSGBUF_TYPE_RXBUF_POST			0x11
+#define MSGBUF_TYPE_RX_CMPLT			0x12
+#define MSGBUF_TYPE_LPBK_DMAXFER		0x13
+#define MSGBUF_TYPE_LPBK_DMAXFER_CMPLT		0x14
+#define MSGBUF_TYPE_H2D_MAILBOX_DATA		0x23
+#define MSGBUF_TYPE_D2H_MAILBOX_DATA		0x24
+
+#define NR_TX_PKTIDS				2048
+#define NR_RX_PKTIDS				2048
+
+#define INFF_IOCTL_REQ_PKTID			0xFFFE
+
+#define INFF_MSGBUF_MAX_PKT_SIZE		2048
+#define INFF_MSGBUF_MAX_CTL_PKT_SIZE           8192
+#define INFF_MSGBUF_RXBUFPOST_THRESHOLD	32
+#define INFF_MSGBUF_MAX_IOCTLRESPBUF_POST	8
+#define INFF_MSGBUF_MAX_EVENTBUF_POST		8
+
+#define INFF_MSGBUF_PKT_FLAGS_FRAME_802_3	0x01
+#define INFF_MSGBUF_PKT_FLAGS_FRAME_802_11	0x02
+#define INFF_MSGBUF_PKT_FLAGS_FRAME_MASK	0x07
+#define INFF_MSGBUF_PKT_FLAGS_PRIO_SHIFT	5
+
+#define INFF_MSGBUF_TX_FLUSH_CNT1		32
+#define INFF_MSGBUF_TX_FLUSH_CNT2		96
+
+#define INFF_MSGBUF_DELAY_TXWORKER_THRS	96
+#define INFF_MSGBUF_TRICKLE_TXWORKER_THRS	32
+#define INFF_MSGBUF_UPDATE_RX_PTR_THRS		48
+
+#define INFF_MAX_TXSTATUS_WAIT_RETRIES		10
+
+struct msgbuf_common_hdr {
+	u8				msgtype;
+	u8				ifidx;
+	u8				flags;
+	u8				rsvd0;
+	__le32				request_id;
+};
+
+struct msgbuf_ioctl_req_hdr {
+	struct msgbuf_common_hdr	msg;
+	__le32				cmd;
+	__le16				trans_id;
+	__le16				input_buf_len;
+	__le16				output_buf_len;
+	__le16				rsvd0[3];
+	struct msgbuf_buf_addr		req_buf_addr;
+	__le32				rsvd1[2];
+};
+
+struct msgbuf_tx_msghdr {
+	struct msgbuf_common_hdr	msg;
+	u8				txhdr[ETH_HLEN];
+	u8				flags;
+	u8				seg_cnt;
+	struct msgbuf_buf_addr		metadata_buf_addr;
+	struct msgbuf_buf_addr		data_buf_addr;
+	__le16				metadata_buf_len;
+	__le16				data_len;
+	__le32				rsvd0;
+};
+
+struct msgbuf_h2d_mbdata {
+	struct msgbuf_common_hdr	msg;
+	__le32				mbdata;
+	__le16				rsvd0[7];
+};
+
+struct msgbuf_rx_bufpost {
+	struct msgbuf_common_hdr	msg;
+	__le16				metadata_buf_len;
+	__le16				data_buf_len;
+	__le32				rsvd0;
+	struct msgbuf_buf_addr		metadata_buf_addr;
+	struct msgbuf_buf_addr		data_buf_addr;
+};
+
+struct msgbuf_rx_ioctl_resp_or_event {
+	struct msgbuf_common_hdr	msg;
+	__le16				host_buf_len;
+	__le16				rsvd0[3];
+	struct msgbuf_buf_addr		host_buf_addr;
+	__le32				rsvd1[4];
+};
+
+struct msgbuf_completion_hdr {
+	__le16				status;
+	__le16				flow_ring_id;
+};
+
+/* Data struct for the MSGBUF_TYPE_GEN_STATUS */
+struct msgbuf_gen_status {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				write_idx;
+	__le32				rsvd0[3];
+};
+
+/* Data struct for the MSGBUF_TYPE_RING_STATUS */
+struct msgbuf_ring_status {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				write_idx;
+	__le16				rsvd0[5];
+};
+
+struct msgbuf_rx_event {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				event_data_len;
+	__le16				seqnum;
+	__le16				rsvd0[4];
+};
+
+struct msgbuf_ioctl_resp_hdr {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				resp_len;
+	__le16				trans_id;
+	__le32				cmd;
+	__le32				rsvd0;
+};
+
+struct msgbuf_tx_status {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				metadata_len;
+	__le16				tx_status;
+};
+
+struct msgbuf_rx_complete {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le16				metadata_len;
+	__le16				data_len;
+	__le16				data_offset;
+	__le16				flags;
+	__le32				rx_status_0;
+	__le32				rx_status_1;
+	__le32				rsvd0;
+};
+
+struct msgbuf_tx_flowring_create_req {
+	struct msgbuf_common_hdr	msg;
+	u8				da[ETH_ALEN];
+	u8				sa[ETH_ALEN];
+	u8				tid;
+	u8				if_flags;
+	__le16				flow_ring_id;
+	u8				tc;
+	u8				priority;
+	__le16				int_vector;
+	__le16				max_items;
+	__le16				len_item;
+	struct msgbuf_buf_addr		flow_ring_addr;
+};
+
+struct msgbuf_tx_flowring_delete_req {
+	struct msgbuf_common_hdr	msg;
+	__le16				flow_ring_id;
+	__le16				reason;
+	__le32				rsvd0[7];
+};
+
+struct msgbuf_flowring_create_resp {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le32				rsvd0[3];
+};
+
+struct msgbuf_flowring_delete_resp {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le32				rsvd0[3];
+};
+
+struct msgbuf_flowring_flush_resp {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le32				rsvd0[3];
+};
+
+struct msgbuf_d2h_mailbox_data {
+	struct msgbuf_common_hdr	msg;
+	struct msgbuf_completion_hdr	compl_hdr;
+	__le32				mbdata;
+	__le32				rsvd0[2];
+} d2h_mailbox_data_t;
+
+struct inff_msgbuf_work_item {
+	struct list_head queue;
+	u32 flowid;
+	int ifidx;
+	u8 sa[ETH_ALEN];
+	u8 da[ETH_ALEN];
+};
+
+struct inff_msgbuf_tx_status_entry {
+	struct list_head queue;
+	struct msgbuf_tx_status status;
+};
+
+struct inff_msgbuf {
+	struct inff_pub *drvr;
+
+	struct inff_commonring **commonrings;
+	struct inff_commonring **flowrings;
+	dma_addr_t *flowring_dma_handle;
+
+	u16 max_flowrings;
+	u16 max_submissionrings;
+	u16 max_completionrings;
+
+	u16 rx_dataoffset;
+	u32 max_rxbufpost;
+	u16 rx_metadata_offset;
+	u32 rxbufpost;
+
+	u32 max_ioctlrespbuf;
+	u32 cur_ioctlrespbuf;
+	u32 max_eventbuf;
+	u32 cur_eventbuf;
+
+	void *ioctbuf;
+	dma_addr_t ioctbuf_handle;
+	u32 ioctbuf_phys_hi;
+	u32 ioctbuf_phys_lo;
+	int ioctl_resp_status;
+	u32 ioctl_resp_ret_len;
+	u32 ioctl_resp_pktid;
+
+	u16 data_seq_no;
+	u16 ioctl_seq_no;
+	u32 reqid;
+	wait_queue_head_t ioctl_resp_wait;
+	bool ctl_completed;
+
+	struct inff_msgbuf_pktids *tx_pktids;
+	struct inff_msgbuf_pktids *rx_pktids;
+	struct inff_flowring *flow;
+
+	struct workqueue_struct *txflow_wq;
+	struct work_struct txflow_work;
+	unsigned long *flow_map;
+	unsigned long *txstatus_done_map;
+
+	struct work_struct flowring_work;
+	/* lock for flow ring resource protection */
+	spinlock_t flowring_work_lock;
+	struct list_head work_queue;
+	struct workqueue_struct *rx_wq;
+	struct work_struct rx_work;
+	struct sk_buff_head rx_data_q;
+	struct work_struct tx_compl_work;
+	struct list_head tx_compl_list;
+	/* protect the data of tx complete */
+	spinlock_t tx_compl_work_lock;
+};
+
+struct inff_msgbuf_pktid {
+	atomic_t  allocated;
+	u16 data_offset;
+	struct sk_buff *skb;
+	struct page *page;
+	dma_addr_t physaddr;
+};
+
+struct inff_msgbuf_pktids {
+	u32 array_size;
+	u32 last_allocated_idx;
+	enum dma_data_direction direction;
+	struct inff_msgbuf_pktid *array;
+
+	/* page pool */
+	struct page_pool *page_pool;
+	struct xdp_rxq_info xdp_rxq;
+};
+
+static void inff_msgbuf_rxbuf_ioctlresp_post(struct inff_msgbuf *msgbuf);
+static void inff_msgbuf_process_d2h_mbdata(struct inff_msgbuf *msgbuf,
+					   void *buf);
+static void inff_msgbuf_process_rx(struct inff_msgbuf *msgbuf,
+				   struct inff_commonring *commonring);
+static void inff_msgbuf_process_msgtype(struct inff_msgbuf *msgbuf,
+					void *buf, unsigned int *work_done);
+
+static struct inff_msgbuf_pktids *
+inff_msgbuf_init_tx_pktids(struct inff_msgbuf *msgbuf, u32 nr_array_entries,
+			   enum dma_data_direction direction)
+{
+	struct inff_msgbuf_pktid *array;
+	struct inff_msgbuf_pktids *pktids;
+
+	array = kcalloc(nr_array_entries, sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	pktids = kzalloc(sizeof(*pktids), GFP_KERNEL);
+	if (!pktids) {
+		kfree(array);
+		return NULL;
+	}
+	pktids->array = array;
+	pktids->array_size = nr_array_entries;
+
+	return pktids;
+}
+
+static struct inff_msgbuf_pktids *
+inff_msgbuf_init_rx_pktids(struct inff_msgbuf *msgbuf, u32 nr_array_entries,
+			   enum dma_data_direction direction)
+{
+	struct inff_msgbuf_pktid *array;
+	struct inff_msgbuf_pktids *pktids = NULL;
+	struct device *dev = msgbuf->drvr->bus_if->dev;
+
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = nr_array_entries,
+		.offset = INFF_SKB_HEADROOM,
+		.nid = NUMA_NO_NODE,
+		.dev = dev->parent,
+		.dma_dir = direction,
+		.max_len = INFF_MAX_RX_BUF_SIZE,
+	};
+
+	array = kcalloc(nr_array_entries, sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return NULL;
+
+	pktids = kzalloc(sizeof(*pktids), GFP_KERNEL);
+	if (!pktids) {
+		kfree(array);
+		return NULL;
+	}
+	pktids->array = array;
+	pktids->array_size = nr_array_entries;
+
+	pktids->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(pktids->page_pool)) {
+		pktids->page_pool = NULL;
+		goto fail;
+	}
+
+	return pktids;
+fail:
+	kfree(pktids->array);
+	kfree(pktids);
+
+	return NULL;
+}
+
+static int
+inff_msgbuf_alloc_pktid(struct device *dev,
+			struct inff_msgbuf_pktids *pktids,
+			struct sk_buff *skb, struct page *page,
+			u16 data_offset, dma_addr_t *physaddr, u32 *idx)
+{
+	struct inff_msgbuf_pktid *array;
+	u32 count;
+
+	array = pktids->array;
+
+	if (page) {
+		*physaddr = page_pool_get_dma_addr(page) + INFF_SKB_HEADROOM;
+	} else if (skb) {
+		*physaddr = dma_map_single(dev, skb->data + data_offset,
+					   skb->len - data_offset,
+					   pktids->direction);
+		if (dma_mapping_error(dev, *physaddr)) {
+			inff_err("dma_map_single failed !!\n");
+			return -ENOMEM;
+		}
+	}
+
+	*idx = pktids->last_allocated_idx;
+
+	count = 0;
+	do {
+		(*idx)++;
+		if (*idx == pktids->array_size)
+			*idx = 0;
+		if (array[*idx].allocated.counter == 0)
+			if (atomic_cmpxchg(&array[*idx].allocated, 0, 1) == 0)
+				break;
+		count++;
+	} while (count < pktids->array_size);
+
+	if (count == pktids->array_size) {
+		if (page)
+			page_pool_put_full_page(pktids->page_pool, page, true);
+		else if (skb)
+			dma_unmap_single(dev, *physaddr, skb->len - data_offset,
+					 pktids->direction);
+		return -ENOMEM;
+	}
+
+	array[*idx].data_offset = data_offset;
+	array[*idx].physaddr = *physaddr;
+
+	if (page) {
+		array[*idx].page = page;
+		array[*idx].skb = NULL;
+	} else if (skb) {
+		array[*idx].skb = skb;
+		array[*idx].page = NULL;
+	}
+
+	pktids->last_allocated_idx = *idx;
+
+	return 0;
+}
+
+static void*
+inff_msgbuf_get_pktid(struct device *dev, struct inff_msgbuf_pktids *pktids,
+		      u32 idx)
+{
+	struct inff_msgbuf_pktid *pktid;
+	void *ret;
+
+	if (idx >= pktids->array_size) {
+		inff_err("Invalid packet id %d (max %d)\n", idx,
+			 pktids->array_size);
+		return NULL;
+	}
+	if (pktids->array[idx].allocated.counter) {
+		pktid = &pktids->array[idx];
+
+		if (pktid->page) {
+			enum dma_data_direction dma_dir =
+				page_pool_get_dma_dir(pktids->page_pool);
+			dma_sync_single_for_cpu(dev->parent, pktid->physaddr,
+						INFF_MAX_RX_BUF_SIZE, dma_dir);
+			ret = (void *)pktid->page;
+		} else if (pktid->skb) {
+			dma_unmap_single(dev, pktid->physaddr,
+					 pktid->skb->len - pktid->data_offset,
+					 pktids->direction);
+			ret = (void *)pktid->skb;
+		}
+
+		pktid->allocated.counter = 0;
+		pktid->physaddr = 0;
+	} else {
+		inff_err("Invalid packet id %d (not in use)\n", idx);
+	}
+
+	return ret;
+}
+
+static void
+inff_msgbuf_release_array(struct device *dev,
+			  struct inff_msgbuf_pktids *pktids)
+{
+	struct inff_msgbuf_pktid *array;
+	struct inff_msgbuf_pktid *pktid;
+	u32 count;
+
+	array = pktids->array;
+	count = 0;
+	do {
+		if (array[count].allocated.counter) {
+			pktid = &array[count];
+
+			if (pktid->page) {
+				page_pool_put_full_page(pktids->page_pool,
+							pktid->page, false);
+			} else if (pktid->skb) {
+				dma_unmap_single(dev, pktid->physaddr,
+						 pktid->skb->len -
+						 pktid->data_offset,
+						 pktids->direction);
+				inff_pkt_buf_free_skb(pktid->skb);
+			}
+		}
+		count++;
+	} while (count < pktids->array_size);
+
+	if (pktids->page_pool)
+		page_pool_destroy(pktids->page_pool);
+
+	kfree(array);
+	kfree(pktids);
+}
+
+static void inff_msgbuf_release_pktids(struct inff_msgbuf *msgbuf)
+{
+	if (msgbuf->rx_pktids)
+		inff_msgbuf_release_array(msgbuf->drvr->bus_if->dev,
+					  msgbuf->rx_pktids);
+	if (msgbuf->tx_pktids)
+		inff_msgbuf_release_array(msgbuf->drvr->bus_if->dev,
+					  msgbuf->tx_pktids);
+}
+
+int inff_msgbuf_tx_mbdata(struct inff_pub *drvr, u32 mbdata)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_commonring *commonring;
+	struct msgbuf_h2d_mbdata *h2d_mbdata;
+	void *ret_ptr;
+	int err;
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	inff_commonring_lock(commonring);
+	ret_ptr = inff_commonring_reserve_for_write(commonring);
+	if (!ret_ptr) {
+		inff_err("Failed to reserve space in commonring\n");
+		inff_commonring_unlock(commonring);
+		return -ENOMEM;
+	}
+	h2d_mbdata = (struct msgbuf_h2d_mbdata *)ret_ptr;
+	memset(h2d_mbdata, 0, sizeof(*h2d_mbdata));
+
+	h2d_mbdata->msg.msgtype = MSGBUF_TYPE_H2D_MAILBOX_DATA;
+	h2d_mbdata->mbdata = cpu_to_le32(mbdata);
+
+	err = inff_commonring_write_complete(commonring);
+	inff_commonring_unlock(commonring);
+
+	return err;
+}
+
+static int inff_msgbuf_tx_ioctl(struct inff_pub *drvr, int ifidx,
+				uint cmd, void *buf, uint len)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_commonring *commonring;
+	struct msgbuf_ioctl_req_hdr *request;
+	u16 buf_len;
+	void *ret_ptr;
+	int err;
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	inff_commonring_lock(commonring);
+	ret_ptr = inff_commonring_reserve_for_write(commonring);
+	if (!ret_ptr) {
+		iphy_err(drvr, "Failed to reserve space in commonring\n");
+		inff_commonring_unlock(commonring);
+		return -ENOMEM;
+	}
+
+	msgbuf->reqid++;
+
+	request = (struct msgbuf_ioctl_req_hdr *)ret_ptr;
+	request->msg.msgtype = MSGBUF_TYPE_IOCTLPTR_REQ;
+	request->msg.ifidx = (u8)ifidx;
+	request->msg.flags = 0;
+	request->msg.request_id = cpu_to_le32(INFF_IOCTL_REQ_PKTID);
+	request->cmd = cpu_to_le32(cmd);
+	request->output_buf_len = cpu_to_le16(len);
+	request->trans_id = cpu_to_le16(msgbuf->reqid);
+
+	buf_len = min_t(u16, len, INFF_TX_IOCTL_MAX_MSG_SIZE);
+	request->input_buf_len = cpu_to_le16(buf_len);
+	request->req_buf_addr.high_addr = cpu_to_le32(msgbuf->ioctbuf_phys_hi);
+	request->req_buf_addr.low_addr = cpu_to_le32(msgbuf->ioctbuf_phys_lo);
+	if (buf)
+		memcpy(msgbuf->ioctbuf, buf, buf_len);
+	else
+		memset(msgbuf->ioctbuf, 0, buf_len);
+
+	err = inff_commonring_write_complete(commonring);
+	inff_commonring_unlock(commonring);
+
+	return err;
+}
+
+static int inff_msgbuf_ioctl_resp_wait(struct inff_msgbuf *msgbuf)
+{
+	return wait_event_timeout(msgbuf->ioctl_resp_wait,
+				  msgbuf->ctl_completed,
+				  MSGBUF_IOCTL_RESP_TIMEOUT);
+}
+
+static void inff_msgbuf_ioctl_resp_wake(struct inff_msgbuf *msgbuf)
+{
+	msgbuf->ctl_completed = true;
+	wake_up(&msgbuf->ioctl_resp_wait);
+}
+
+static int inff_msgbuf_query_dcmd(struct inff_pub *drvr, int ifidx,
+				  uint cmd, void *buf, uint len, int *fwerr)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct sk_buff *skb = NULL;
+	int timeout;
+	int err;
+
+	inff_dbg(MSGBUF, "ifidx=%d, cmd=%d, len=%d\n", ifidx, cmd, len);
+	*fwerr = 0;
+	msgbuf->ctl_completed = false;
+	err = inff_msgbuf_tx_ioctl(drvr, ifidx, cmd, buf, len);
+	if (err)
+		return err;
+
+	timeout = inff_msgbuf_ioctl_resp_wait(msgbuf);
+	if (!timeout) {
+		iphy_err(drvr, "Timeout on response for query command\n");
+		return -EIO;
+	}
+
+	skb = (struct sk_buff *)inff_msgbuf_get_pktid(msgbuf->drvr->bus_if->dev,
+						      msgbuf->rx_pktids,
+						      msgbuf->ioctl_resp_pktid);
+	if (msgbuf->ioctl_resp_ret_len != 0) {
+		if (!skb)
+			return -EBADF;
+
+		memcpy(buf, skb->data, (len < msgbuf->ioctl_resp_ret_len) ?
+				       len : msgbuf->ioctl_resp_ret_len);
+	}
+	inff_pkt_buf_free_skb(skb);
+
+	*fwerr = msgbuf->ioctl_resp_status;
+	return 0;
+}
+
+static int inff_msgbuf_set_dcmd(struct inff_pub *drvr, int ifidx,
+				uint cmd, void *buf, uint len, int *fwerr)
+{
+	return inff_msgbuf_query_dcmd(drvr, ifidx, cmd, buf, len, fwerr);
+}
+
+static int inff_msgbuf_hdrpull(struct inff_pub *drvr, bool do_fws,
+			       struct sk_buff *skb, struct inff_if **ifp)
+{
+	return -ENODEV;
+}
+
+static void inff_msgbuf_rxreorder(struct inff_if *ifp, struct sk_buff *skb,
+				  bool inirq)
+{
+}
+
+static void inff_msgbuf_poll_ring(struct inff_msgbuf *msgbuf, struct inff_commonring *ring,
+				  unsigned int *work_done, int budget)
+{
+	void *buf;
+	u16 count;
+	u16 processed = 0;
+
+	buf = inff_commonring_get_read_ptr(ring, &count);
+	while (buf && count) {
+		if (*work_done >= budget)
+			break;
+		inff_msgbuf_process_msgtype(msgbuf,
+					    buf + msgbuf->rx_dataoffset,
+					    work_done);
+		buf += inff_commonring_len_item(ring);
+		processed++;
+		if (processed == INFF_MSGBUF_UPDATE_RX_PTR_THRS) {
+			inff_commonring_read_complete(ring, processed);
+			processed = 0;
+		}
+		count--;
+	}
+	if (processed)
+		inff_commonring_read_complete(ring, processed);
+}
+
+static int inff_msgbuf_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct inff_if *ifp;
+	struct inff_msgbuf *msgbuf;
+	unsigned int work_done = 0;
+
+	inff_dbg(TRACE, "NAPI poll started, work_done %d, budget %d\n",
+		 work_done, budget);
+
+	ifp = container_of(napi, struct inff_if, napi);
+	if (!ifp)
+		return budget;
+
+	msgbuf = ifp->drvr->proto->pd;
+	inff_msgbuf_poll_ring(msgbuf,
+			      msgbuf->commonrings[INFF_D2H_MSGRING_RX_COMPLETE],
+			      &work_done, budget);
+	if (work_done < budget)
+		inff_msgbuf_poll_ring(msgbuf,
+				      msgbuf->commonrings[INFF_D2H_MSGRING_TX_COMPLETE],
+				      &work_done, budget);
+
+	/* If budget fully consumed, continue polling */
+	if (work_done == budget)
+		return budget;
+
+	if (work_done < budget) {
+		napi_complete(napi);
+		inff_dbg(TRACE, "NAPI poll completed, work_done %d, budget %d\n",
+			 work_done, budget);
+	}
+
+	return work_done;
+}
+
+static void inff_msgbuf_napi_add(struct inff_if *ifp)
+{
+	struct net_device *ndev;
+
+	inff_dbg(TRACE, "Enter\n");
+	ndev = ifp->ndev;
+	if (!ndev || !ifp->drvr->settings->napi_enable)
+		return;
+
+	netif_napi_add(ndev, &ifp->napi, inff_msgbuf_napi_poll);
+	napi_enable(&ifp->napi);
+	ifp->napi_gro = true;
+	inff_dbg(TRACE, "Exit\n");
+}
+
+static void inff_msgbuf_napi_del(struct inff_if *ifp)
+{
+	struct net_device *ndev;
+
+	inff_dbg(TRACE, "Enter\n");
+	ndev = ifp->ndev;
+	if (!ndev || !ifp->drvr->settings->napi_enable)
+		return;
+
+	napi_synchronize(&ifp->napi);
+	napi_disable(&ifp->napi);
+	netif_napi_del(&ifp->napi);
+	inff_dbg(TRACE, "Exit\n");
+}
+
+static void inff_msgbuf_napi_schedule(void *info)
+{
+	struct inff_if *ifp = (struct inff_if *)info;
+
+	napi_schedule(&ifp->napi);
+}
+
+static int inff_msgbuf_xdp_init(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_msgbuf_pktids *pktids = msgbuf->rx_pktids;
+
+	return inff_xdp_init(ifp->ndev, &pktids->xdp_rxq, pktids->page_pool);
+}
+
+static void inff_msgbuf_xdp_deinit(struct inff_pub *drvr)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_msgbuf_pktids *pktids = msgbuf->rx_pktids;
+
+	inff_xdp_deinit(&pktids->xdp_rxq);
+}
+
+static void
+inff_msgbuf_remove_flowring(struct inff_msgbuf *msgbuf, u16 flowid)
+{
+	u32 dma_sz;
+	void *dma_buf;
+	struct inff_commonring *commonring = msgbuf->flowrings[flowid];
+
+	inff_dbg(MSGBUF, "Removing flowring %d\n", flowid);
+	/* The flowring addr and dpeth be copied by the inff_commonring_config(),
+	 * while flowring create. To keep the same logic as the commonring buf, so
+	 * the commonring ptr is used in here.
+	 */
+	dma_buf = commonring->buf_addr;
+	if (dma_buf) {
+		dma_sz = commonring->depth * commonring->item_len;
+		dma_free_coherent(msgbuf->drvr->bus_if->dev, dma_sz, dma_buf,
+				  msgbuf->flowring_dma_handle[flowid]);
+	}
+	inff_flowring_delete(msgbuf->flow, flowid);
+}
+
+static struct inff_msgbuf_work_item *
+inff_msgbuf_dequeue_work(struct inff_msgbuf *msgbuf)
+{
+	struct inff_msgbuf_work_item *work = NULL;
+	ulong flags;
+
+	spin_lock_irqsave(&msgbuf->flowring_work_lock, flags);
+	if (!list_empty(&msgbuf->work_queue)) {
+		work = list_first_entry(&msgbuf->work_queue,
+					struct inff_msgbuf_work_item, queue);
+		list_del(&work->queue);
+	}
+	spin_unlock_irqrestore(&msgbuf->flowring_work_lock, flags);
+
+	return work;
+}
+
+static u32
+inff_msgbuf_flowring_create_worker(struct inff_msgbuf *msgbuf,
+				   struct inff_msgbuf_work_item *work)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_tx_flowring_create_req *create;
+	struct inff_commonring *commonring;
+	void *ret_ptr;
+	u32 flowid;
+	void *dma_buf;
+	u32 dma_sz, ring_max_item;
+	u64 address;
+	int err;
+	u32 flowring_depth = msgbuf->drvr->settings->flowring_depth;
+
+	if (flowring_depth >= INFF_RING_MAX_ITEM_LOWER_LIMIT &&
+	    flowring_depth <= INFF_RING_MAX_ITEM_UPPER_LIMIT)
+		ring_max_item = flowring_depth;
+	else
+		ring_max_item = INFF_H2D_TXFLOWRING_MAX_ITEM;
+	flowid = work->flowid;
+	dma_sz = ring_max_item * INFF_H2D_TXFLOWRING_ITEMSIZE;
+	dma_buf = dma_alloc_coherent(msgbuf->drvr->bus_if->dev, dma_sz,
+				     &msgbuf->flowring_dma_handle[flowid],
+				     GFP_KERNEL);
+	if (!dma_buf) {
+		iphy_err(drvr, "dma_alloc_coherent failed\n");
+		inff_flowring_delete(msgbuf->flow, flowid);
+		return INFF_FLOWRING_INVALID_ID;
+	}
+
+	inff_commonring_config(msgbuf->flowrings[flowid],
+			       ring_max_item,
+			       INFF_H2D_TXFLOWRING_ITEMSIZE, dma_buf);
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	inff_commonring_lock(commonring);
+	ret_ptr = inff_commonring_reserve_for_write(commonring);
+	if (!ret_ptr) {
+		iphy_err(drvr, "Failed to reserve space in commonring\n");
+		inff_commonring_unlock(commonring);
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+		return INFF_FLOWRING_INVALID_ID;
+	}
+
+	create = (struct msgbuf_tx_flowring_create_req *)ret_ptr;
+	create->msg.msgtype = MSGBUF_TYPE_FLOW_RING_CREATE;
+	create->msg.ifidx = work->ifidx;
+	create->msg.request_id = 0;
+	create->tid = inff_flowring_tid(msgbuf->flow, flowid);
+	create->flow_ring_id = cpu_to_le16(flowid +
+					   INFF_H2D_MSGRING_FLOWRING_IDSTART);
+	memcpy(create->sa, work->sa, ETH_ALEN);
+	memcpy(create->da, work->da, ETH_ALEN);
+	address = (u64)msgbuf->flowring_dma_handle[flowid];
+	create->flow_ring_addr.high_addr = cpu_to_le32(address >> 32);
+	create->flow_ring_addr.low_addr = cpu_to_le32(address & 0xffffffff);
+	create->max_items = cpu_to_le16(ring_max_item);
+	create->len_item = cpu_to_le16(INFF_H2D_TXFLOWRING_ITEMSIZE);
+
+	inff_dbg(MSGBUF, "Send Flow Create Req flow ID %d for peer %pM prio %d ifindex %d\n",
+		 flowid, work->da, create->tid, work->ifidx);
+
+	err = inff_commonring_write_complete(commonring);
+	inff_commonring_unlock(commonring);
+	if (err) {
+		iphy_err(drvr, "Failed to write commonring\n");
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+		return INFF_FLOWRING_INVALID_ID;
+	}
+
+	return flowid;
+}
+
+static void inff_msgbuf_flowring_worker(struct work_struct *work)
+{
+	struct inff_msgbuf *msgbuf;
+	struct inff_msgbuf_work_item *create;
+
+	msgbuf = container_of(work, struct inff_msgbuf, flowring_work);
+
+	while ((create = inff_msgbuf_dequeue_work(msgbuf))) {
+		inff_msgbuf_flowring_create_worker(msgbuf, create);
+		kfree(create);
+	}
+}
+
+static u32 inff_msgbuf_flowring_create(struct inff_msgbuf *msgbuf, int ifidx,
+				       struct sk_buff *skb)
+{
+	struct inff_msgbuf_work_item *create;
+	struct ethhdr *eh = (struct ethhdr *)(skb->data);
+	u32 flowid;
+	ulong flags;
+
+	create = kzalloc(sizeof(*create), GFP_ATOMIC);
+	if (!create)
+		return INFF_FLOWRING_INVALID_ID;
+
+	flowid = inff_flowring_create(msgbuf->flow, eh->h_dest,
+				      skb->priority, ifidx);
+	if (flowid == INFF_FLOWRING_INVALID_ID) {
+		kfree(create);
+		return flowid;
+	}
+
+	create->flowid = flowid;
+	create->ifidx = ifidx;
+	memcpy(create->sa, eh->h_source, ETH_ALEN);
+	memcpy(create->da, eh->h_dest, ETH_ALEN);
+
+	spin_lock_irqsave(&msgbuf->flowring_work_lock, flags);
+	list_add_tail(&create->queue, &msgbuf->work_queue);
+	spin_unlock_irqrestore(&msgbuf->flowring_work_lock, flags);
+
+	schedule_work_on(inff_work_sched_cpu(msgbuf->drvr->settings->tx_cpu),
+			 &msgbuf->flowring_work);
+
+	return flowid;
+}
+
+static void inff_msgbuf_txflow(struct inff_msgbuf *msgbuf, u16 flowid)
+{
+	struct inff_flowring *flow = msgbuf->flow;
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct device *dev = drvr->bus_if->dev;
+	struct inff_commonring *commonring;
+	void *ret_ptr;
+	u32 count;
+	struct sk_buff *skb;
+	dma_addr_t physaddr;
+	struct inff_msgbuf_pktids *pktids = msgbuf->tx_pktids;
+	u32 pktid;
+	struct msgbuf_tx_msghdr *tx_msghdr;
+	u64 address;
+
+	commonring = msgbuf->flowrings[flowid];
+	if (!inff_commonring_write_available(commonring)) {
+		if (commonring->was_full)
+			iphy_err(drvr, "%d, TXPOST: commonring full !!\n", __LINE__);
+		return;
+	}
+
+	inff_commonring_lock(commonring);
+
+	count = INFF_MSGBUF_TX_FLUSH_CNT2 - INFF_MSGBUF_TX_FLUSH_CNT1;
+	while (inff_flowring_qlen(flow, flowid)) {
+		skb = inff_flowring_dequeue(flow, flowid);
+		if (!skb) {
+			iphy_err(drvr, "No SKB, but qlen %d\n",
+				 inff_flowring_qlen(flow, flowid));
+			break;
+		}
+		skb_tx_timestamp(skb);
+		skb_orphan(skb);
+		if (inff_msgbuf_alloc_pktid(dev, pktids, skb, NULL,
+					    ETH_HLEN, &physaddr, &pktid)) {
+			inff_flowring_reinsert(flow, flowid, skb);
+			iphy_err(drvr, "TXPOST: No PKTID available (last alloc %d) !!\n",
+				 pktids->last_allocated_idx);
+			break;
+		}
+		ret_ptr = inff_commonring_reserve_for_write(commonring);
+		if (!ret_ptr) {
+			if (commonring->was_full)
+				iphy_err(drvr, "%d, TXPOST: commonring full !!\n", __LINE__);
+
+			skb = (struct sk_buff *)inff_msgbuf_get_pktid(dev,
+								      pktids,
+								      pktid);
+			if (skb)
+				inff_flowring_reinsert(flow, flowid, skb);
+			break;
+		}
+		count++;
+
+		tx_msghdr = (struct msgbuf_tx_msghdr *)ret_ptr;
+
+		tx_msghdr->msg.msgtype = MSGBUF_TYPE_TX_POST;
+		tx_msghdr->msg.request_id = cpu_to_le32(pktid + 1);
+		tx_msghdr->msg.ifidx = inff_flowring_ifidx_get(flow, flowid);
+		tx_msghdr->flags = INFF_MSGBUF_PKT_FLAGS_FRAME_802_3;
+		tx_msghdr->flags |= (skb->priority & 0x07) <<
+				    INFF_MSGBUF_PKT_FLAGS_PRIO_SHIFT;
+		tx_msghdr->seg_cnt = 1;
+		memcpy(tx_msghdr->txhdr, skb->data, ETH_HLEN);
+		tx_msghdr->data_len = cpu_to_le16(skb->len - ETH_HLEN);
+		address = (u64)physaddr;
+		tx_msghdr->data_buf_addr.high_addr = cpu_to_le32(address >> 32);
+		tx_msghdr->data_buf_addr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+		tx_msghdr->metadata_buf_len = 0;
+		tx_msghdr->metadata_buf_addr.high_addr = 0;
+		tx_msghdr->metadata_buf_addr.low_addr = 0;
+		atomic_inc(&commonring->outstanding_tx);
+		if (count >= INFF_MSGBUF_TX_FLUSH_CNT2) {
+			inff_commonring_write_complete(commonring);
+			count = 0;
+		}
+	}
+	if (count)
+		inff_commonring_write_complete(commonring);
+	inff_commonring_unlock(commonring);
+}
+
+static void inff_msgbuf_rx(struct inff_msgbuf *msgbuf)
+{
+	struct sk_buff *skb;
+	struct inff_if *ifp;
+
+	while ((skb = skb_dequeue(&msgbuf->rx_data_q))) {
+		ifp = netdev_priv(skb->dev);
+		if (ifp) {
+			inff_netif_rx(ifp, skb, false);
+		} else {
+			iphy_err(msgbuf->drvr, "NULL ifp, unexpected pkt\n");
+			inff_pkt_buf_free_skb(skb);
+			break;
+		}
+	}
+}
+
+static void inff_msgbuf_txflow_worker(struct work_struct *worker)
+{
+	struct inff_msgbuf *msgbuf;
+	u32 flowid;
+
+	msgbuf = container_of(worker, struct inff_msgbuf, txflow_work);
+	for_each_set_bit(flowid, msgbuf->flow_map, msgbuf->max_flowrings) {
+		clear_bit(flowid, msgbuf->flow_map);
+		inff_msgbuf_txflow(msgbuf, flowid);
+	}
+}
+
+static void inff_msgbuf_rx_worker(struct work_struct *worker)
+{
+	struct inff_msgbuf *msgbuf;
+
+	msgbuf = container_of(worker, struct inff_msgbuf, rx_work);
+	inff_msgbuf_rx(msgbuf);
+}
+
+static int inff_msgbuf_schedule_txdata(struct inff_msgbuf *msgbuf, u32 flowid,
+				       bool force)
+{
+	struct inff_commonring *commonring;
+	int qlen;
+
+	set_bit(flowid, msgbuf->flow_map);
+	commonring = msgbuf->flowrings[flowid];
+
+	qlen = inff_flowring_qlen(msgbuf->flow, flowid);
+	inff_dbg(MSGBUF, "force: %u, txflowring[%u] qlen: %u, outstanding_tx: %u",
+		 force, flowid, qlen, atomic_read(&commonring->outstanding_tx));
+
+	if ((force) || (atomic_read(&commonring->outstanding_tx) <
+			INFF_MSGBUF_DELAY_TXWORKER_THRS))
+		queue_work_on(inff_work_sched_cpu(msgbuf->drvr->settings->tx_cpu),
+			      msgbuf->txflow_wq, &msgbuf->txflow_work);
+
+	return 0;
+}
+
+static int inff_msgbuf_schedule_rxdata(struct inff_msgbuf *msgbuf, bool force)
+{
+	if (force)
+		queue_work(msgbuf->rx_wq, &msgbuf->rx_work);
+
+	return 0;
+}
+
+static int inff_msgbuf_tx_queue_data(struct inff_pub *drvr, int ifidx,
+				     struct sk_buff *skb)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_flowring *flow = msgbuf->flow;
+	struct ethhdr *eh = (struct ethhdr *)(skb->data);
+	u32 flowid;
+	u32 queue_count;
+	bool force;
+
+	flowid = inff_flowring_lookup(flow, eh->h_dest, skb->priority, ifidx);
+	if (flowid == INFF_FLOWRING_INVALID_ID) {
+		flowid = inff_msgbuf_flowring_create(msgbuf, ifidx, skb);
+		if (flowid == INFF_FLOWRING_INVALID_ID)
+			return -ENOMEM;
+
+		inff_flowring_enqueue(flow, flowid, skb);
+		return 0;
+	}
+	queue_count = inff_flowring_enqueue(flow, flowid, skb);
+	force = ((queue_count % INFF_MSGBUF_TRICKLE_TXWORKER_THRS) == 0);
+	inff_msgbuf_schedule_txdata(msgbuf, flowid, force);
+
+	return 0;
+}
+
+static void
+inff_msgbuf_configure_addr_mode(struct inff_pub *drvr, int ifidx,
+				enum proto_addr_mode addr_mode)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+
+	inff_flowring_configure_addr_mode(msgbuf->flow, ifidx, addr_mode);
+}
+
+static void
+inff_msgbuf_delete_peer(struct inff_pub *drvr, int ifidx, u8 peer[ETH_ALEN])
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+
+	inff_flowring_delete_peer(msgbuf->flow, ifidx, peer);
+}
+
+static void
+inff_msgbuf_add_tdls_peer(struct inff_pub *drvr, int ifidx, u8 peer[ETH_ALEN])
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+
+	inff_flowring_add_tdls_peer(msgbuf->flow, ifidx, peer);
+}
+
+static void
+inff_msgbuf_process_ioctl_complete(struct inff_msgbuf *msgbuf, void *buf)
+{
+	struct msgbuf_ioctl_resp_hdr *ioctl_resp;
+
+	ioctl_resp = (struct msgbuf_ioctl_resp_hdr *)buf;
+
+	msgbuf->ioctl_resp_status =
+			(s16)le16_to_cpu(ioctl_resp->compl_hdr.status);
+	msgbuf->ioctl_resp_ret_len = le16_to_cpu(ioctl_resp->resp_len);
+	msgbuf->ioctl_resp_pktid = le32_to_cpu(ioctl_resp->msg.request_id);
+
+	inff_msgbuf_ioctl_resp_wake(msgbuf);
+
+	if (msgbuf->cur_ioctlrespbuf)
+		msgbuf->cur_ioctlrespbuf--;
+	inff_msgbuf_rxbuf_ioctlresp_post(msgbuf);
+}
+
+static void
+inff_msgbuf_process_txstatus(struct inff_msgbuf *msgbuf, void *buf, unsigned int *work_done)
+{
+	struct inff_commonring *commonring;
+	struct msgbuf_tx_status *tx_status;
+	u32 idx;
+	struct sk_buff *skb;
+	u16 flowid;
+
+	tx_status = (struct msgbuf_tx_status *)buf;
+	idx = le32_to_cpu(tx_status->msg.request_id) - 1;
+	flowid = le16_to_cpu(tx_status->compl_hdr.flow_ring_id);
+	flowid -= INFF_H2D_MSGRING_FLOWRING_IDSTART;
+	skb = (struct sk_buff *)inff_msgbuf_get_pktid(msgbuf->drvr->bus_if->dev,
+						      msgbuf->tx_pktids, idx);
+	if (!skb)
+		return;
+
+	set_bit(flowid, msgbuf->txstatus_done_map);
+	commonring = msgbuf->flowrings[flowid];
+	atomic_dec(&commonring->outstanding_tx);
+
+	inff_txfinalize(inff_get_ifp(msgbuf->drvr, tx_status->msg.ifidx),
+			skb, true);
+	if (work_done)
+		(*work_done)++;
+}
+
+static struct inff_msgbuf_tx_status_entry *
+inff_msgbuf_dequeue_tx_status(struct inff_msgbuf *msgbuf)
+{
+	struct inff_msgbuf_tx_status_entry *status = NULL;
+	ulong flags;
+
+	spin_lock_irqsave(&msgbuf->tx_compl_work_lock, flags);
+	if (!list_empty(&msgbuf->tx_compl_list)) {
+		status = list_first_entry(&msgbuf->tx_compl_list,
+					  struct inff_msgbuf_tx_status_entry, queue);
+		list_del(&status->queue);
+	}
+	spin_unlock_irqrestore(&msgbuf->tx_compl_work_lock, flags);
+
+	return status;
+}
+
+static void inff_msgbuf_tx_compl_worker(struct work_struct *work)
+{
+	struct inff_msgbuf *msgbuf;
+	struct inff_msgbuf_tx_status_entry *entry = NULL;
+
+	msgbuf = container_of(work, struct inff_msgbuf, tx_compl_work);
+	while ((entry = inff_msgbuf_dequeue_tx_status(msgbuf))) {
+		inff_msgbuf_process_txstatus(msgbuf, &entry->status, NULL);
+		kfree(entry);
+	}
+}
+
+static u32 inff_msgbuf_rxbuf_data_post(struct inff_msgbuf *msgbuf, u32 count)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct inff_commonring *commonring;
+	void *ret_ptr;
+	struct page *page;
+	u16 alloced;
+	u32 pktlen;
+	dma_addr_t physaddr;
+	struct msgbuf_rx_bufpost *rx_bufpost;
+	u64 address;
+	u32 pktid;
+	u32 i;
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_RXPOST_SUBMIT];
+	ret_ptr = inff_commonring_reserve_for_write_multiple(commonring,
+							     count,
+							     &alloced);
+	if (!ret_ptr) {
+		inff_dbg(MSGBUF, "Failed to reserve space in commonring\n");
+		return 0;
+	}
+
+	for (i = 0; i < alloced; i++) {
+		rx_bufpost = (struct msgbuf_rx_bufpost *)ret_ptr;
+		memset(rx_bufpost, 0, sizeof(*rx_bufpost));
+
+		page = page_pool_dev_alloc_pages(msgbuf->rx_pktids->page_pool);
+		if (!page) {
+			iphy_err(drvr, "Failed to alloc PAGE\n");
+			inff_commonring_write_cancel(commonring, alloced - i);
+			break;
+		}
+
+		pktlen = INFF_MAX_RX_BUF_SIZE;
+		if (inff_msgbuf_alloc_pktid(msgbuf->drvr->bus_if->dev,
+					    msgbuf->rx_pktids, NULL, page, 0,
+					    &physaddr, &pktid)) {
+			page_pool_put_full_page(msgbuf->rx_pktids->page_pool,
+						page, true);
+			iphy_err(drvr, "RXPOST: No PKTID available (last alloc %d) !!\n",
+				 msgbuf->rx_pktids->last_allocated_idx);
+			inff_commonring_write_cancel(commonring, alloced - i);
+			break;
+		}
+
+		if (msgbuf->rx_metadata_offset) {
+			address = (u64)physaddr;
+			rx_bufpost->metadata_buf_len =
+				cpu_to_le16(msgbuf->rx_metadata_offset);
+			rx_bufpost->metadata_buf_addr.high_addr =
+				cpu_to_le32(address >> 32);
+			rx_bufpost->metadata_buf_addr.low_addr =
+				cpu_to_le32(address & 0xffffffff);
+
+			pktlen -= msgbuf->rx_metadata_offset;
+			physaddr += msgbuf->rx_metadata_offset;
+		}
+		rx_bufpost->msg.msgtype = MSGBUF_TYPE_RXBUF_POST;
+		rx_bufpost->msg.request_id = cpu_to_le32(pktid);
+
+		address = (u64)physaddr;
+		rx_bufpost->data_buf_len = cpu_to_le16((u16)pktlen);
+		rx_bufpost->data_buf_addr.high_addr =
+			cpu_to_le32(address >> 32);
+		rx_bufpost->data_buf_addr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+
+		ret_ptr += inff_commonring_len_item(commonring);
+	}
+
+	if (i)
+		inff_commonring_write_complete(commonring);
+
+	return i;
+}
+
+static void
+inff_msgbuf_rxbuf_data_fill(struct inff_msgbuf *msgbuf)
+{
+	u32 fillbufs;
+	u32 retcount;
+
+	fillbufs = msgbuf->max_rxbufpost - msgbuf->rxbufpost;
+
+	while (fillbufs) {
+		retcount = inff_msgbuf_rxbuf_data_post(msgbuf, fillbufs);
+		if (!retcount)
+			break;
+		msgbuf->rxbufpost += retcount;
+		fillbufs -= retcount;
+	}
+}
+
+static void
+inff_msgbuf_update_rxbufpost_count(struct inff_msgbuf *msgbuf, u16 rxcnt)
+{
+	msgbuf->rxbufpost -= rxcnt;
+	if (msgbuf->rxbufpost <= (msgbuf->max_rxbufpost -
+				  INFF_MSGBUF_RXBUFPOST_THRESHOLD))
+		inff_msgbuf_rxbuf_data_fill(msgbuf);
+}
+
+static u32
+inff_msgbuf_rxbuf_ctrl_post(struct inff_msgbuf *msgbuf, bool event_buf,
+			    u32 count)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct inff_commonring *commonring;
+	void *ret_ptr;
+	struct sk_buff *skb;
+	u16 alloced;
+	u32 pktlen;
+	dma_addr_t physaddr;
+	struct msgbuf_rx_ioctl_resp_or_event *rx_bufpost;
+	u64 address;
+	u32 pktid;
+	u32 i;
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	inff_commonring_lock(commonring);
+	ret_ptr = inff_commonring_reserve_for_write_multiple(commonring,
+							     count,
+							     &alloced);
+	if (!ret_ptr) {
+		iphy_err(drvr, "Failed to reserve space in commonring\n");
+		inff_commonring_unlock(commonring);
+		return 0;
+	}
+
+	for (i = 0; i < alloced; i++) {
+		rx_bufpost = (struct msgbuf_rx_ioctl_resp_or_event *)ret_ptr;
+		memset(rx_bufpost, 0, sizeof(*rx_bufpost));
+
+		skb = __inff_pkt_buf_get_skb(INFF_MSGBUF_MAX_CTL_PKT_SIZE, GFP_KERNEL);
+		if (!skb) {
+			iphy_err(drvr, "Failed to alloc SKB\n");
+			inff_commonring_write_cancel(commonring, alloced - i);
+			break;
+		}
+
+		pktlen = skb->len;
+		if (inff_msgbuf_alloc_pktid(msgbuf->drvr->bus_if->dev,
+					    msgbuf->rx_pktids, skb, NULL, 0,
+					    &physaddr, &pktid)) {
+			dev_kfree_skb_any(skb);
+			iphy_err(drvr, "CTRLPOST: No PKTID available (last alloc %d) !!\n",
+				 msgbuf->rx_pktids->last_allocated_idx);
+			inff_commonring_write_cancel(commonring, alloced - i);
+			break;
+		}
+		if (event_buf)
+			rx_bufpost->msg.msgtype = MSGBUF_TYPE_EVENT_BUF_POST;
+		else
+			rx_bufpost->msg.msgtype =
+				MSGBUF_TYPE_IOCTLRESP_BUF_POST;
+		rx_bufpost->msg.request_id = cpu_to_le32(pktid);
+
+		address = (u64)physaddr;
+		rx_bufpost->host_buf_len = cpu_to_le16((u16)pktlen);
+		rx_bufpost->host_buf_addr.high_addr =
+			cpu_to_le32(address >> 32);
+		rx_bufpost->host_buf_addr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+
+		ret_ptr += inff_commonring_len_item(commonring);
+	}
+
+	if (i)
+		inff_commonring_write_complete(commonring);
+
+	inff_commonring_unlock(commonring);
+
+	return i;
+}
+
+static void inff_msgbuf_rxbuf_ioctlresp_post(struct inff_msgbuf *msgbuf)
+{
+	u32 count;
+
+	count = msgbuf->max_ioctlrespbuf - msgbuf->cur_ioctlrespbuf;
+	count = inff_msgbuf_rxbuf_ctrl_post(msgbuf, false, count);
+	msgbuf->cur_ioctlrespbuf += count;
+}
+
+static void inff_msgbuf_rxbuf_event_post(struct inff_msgbuf *msgbuf)
+{
+	u32 count;
+
+	count = msgbuf->max_eventbuf - msgbuf->cur_eventbuf;
+	count = inff_msgbuf_rxbuf_ctrl_post(msgbuf, true, count);
+	msgbuf->cur_eventbuf += count;
+}
+
+static void inff_msgbuf_process_event(struct inff_msgbuf *msgbuf, void *buf)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_rx_event *event;
+	u32 idx;
+	u16 buflen;
+	struct sk_buff *skb;
+	struct inff_if *ifp;
+
+	event = (struct msgbuf_rx_event *)buf;
+	idx = le32_to_cpu(event->msg.request_id);
+	buflen = le16_to_cpu(event->event_data_len);
+
+	if (msgbuf->cur_eventbuf)
+		msgbuf->cur_eventbuf--;
+	inff_msgbuf_rxbuf_event_post(msgbuf);
+
+	skb = (struct sk_buff *)inff_msgbuf_get_pktid(msgbuf->drvr->bus_if->dev,
+						      msgbuf->rx_pktids, idx);
+	if (!skb)
+		return;
+
+	if (msgbuf->rx_dataoffset)
+		skb_pull(skb, msgbuf->rx_dataoffset);
+
+	skb_trim(skb, buflen);
+
+	ifp = inff_get_ifp(msgbuf->drvr, event->msg.ifidx);
+	if (!ifp || !ifp->ndev) {
+		iphy_err(drvr, "Received pkt for invalid ifidx %d\n",
+			 event->msg.ifidx);
+		goto exit;
+	}
+
+	skb->protocol = eth_type_trans(skb, ifp->ndev);
+
+	inff_fweh_process_skb(ifp->drvr, skb, 0, GFP_KERNEL);
+
+exit:
+	inff_pkt_buf_free_skb(skb);
+}
+
+static void
+inff_msgbuf_process_rx_complete(struct inff_msgbuf *msgbuf, void *buf,
+				unsigned int *work_done)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_rx_complete *rx_complete;
+	struct sk_buff *skb, *cpskb = NULL;
+	struct ethhdr *eh;
+	u16 data_offset;
+	u16 buflen;
+	u16 flags;
+	u32 idx;
+	struct inff_if *ifp;
+	struct inff_msgbuf_pktids *pktids = msgbuf->rx_pktids;
+	struct page *page;
+	unsigned char *data;
+	struct xdp_buff xdp_buff;
+
+	inff_msgbuf_update_rxbufpost_count(msgbuf, 1);
+
+	rx_complete = (struct msgbuf_rx_complete *)buf;
+	data_offset = le16_to_cpu(rx_complete->data_offset);
+	buflen = le16_to_cpu(rx_complete->data_len);
+	idx = le32_to_cpu(rx_complete->msg.request_id);
+	flags = le16_to_cpu(rx_complete->flags);
+
+	ifp = inff_get_ifp(drvr, rx_complete->msg.ifidx);
+	if (!ifp || !ifp->ndev) {
+		iphy_err(drvr, "Received pkt for invalid ifidx %d\n",
+			 rx_complete->msg.ifidx);
+		return;
+	}
+
+	page = (struct page *)inff_msgbuf_get_pktid(drvr->bus_if->dev,
+						    pktids, idx);
+	if (!page)
+		return;
+
+	data = page_address(page);
+	prefetch(data);
+
+	if (data_offset)
+		data += data_offset;
+	else if (msgbuf->rx_dataoffset)
+		data += msgbuf->rx_dataoffset;
+
+	/* Prepare XDP BUFF from DMA mapped Page having the RX packet */
+	inff_xdp_prepare_buff(&pktids->xdp_rxq, &xdp_buff, data, buflen);
+
+	/* Run the attached XDP Program */
+	if (inff_xdp_run_prog(ifp, &xdp_buff)) {
+		page_pool_put_full_page(pktids->page_pool, page, true);
+		return;
+	}
+
+	/* Create SKB from XDP BUFF */
+	skb = inff_xdp_prepare_skb(&xdp_buff);
+	if (!skb) {
+		page_pool_put_full_page(pktids->page_pool, page, true);
+		return;
+	}
+
+	if (work_done)
+		(*work_done)++;
+
+	if ((flags & INFF_MSGBUF_PKT_FLAGS_FRAME_MASK) ==
+	    INFF_MSGBUF_PKT_FLAGS_FRAME_802_11) {
+		ifp = msgbuf->drvr->mon_if;
+
+		if (!ifp) {
+			iphy_err(drvr, "Received unexpected monitor pkt\n");
+			inff_pkt_buf_free_skb(skb);
+			return;
+		}
+
+		inff_netif_mon_rx(ifp, skb);
+		/* NAPI without gro will use skb queue to handle data */
+		if (!drvr->settings->napi_enable)
+			skb_queue_tail(&msgbuf->rx_data_q, skb);
+
+		return;
+	}
+
+	if (ifp->isap && ifp->fmac_pkt_fwd_en) {
+		eh = (struct ethhdr *)(skb->data);
+		skb_set_network_header(skb, sizeof(struct ethhdr));
+		skb->protocol = eh->h_proto;
+		skb->priority = cfg80211_classify8021d(skb, NULL);
+		if (is_unicast_ether_addr(eh->h_dest)) {
+			if (inff_find_sta(ifp, eh->h_dest)) {
+				 /* determine the priority */
+				if (skb->priority == 0 || skb->priority > 7) {
+					skb->priority =
+						cfg80211_classify8021d(skb,
+								       NULL);
+				}
+				inff_proto_tx_queue_data(ifp->drvr,
+							 ifp->ifidx, skb);
+				return;
+			}
+		} else {
+			cpskb = pskb_copy(skb, GFP_ATOMIC);
+			if (cpskb) {
+				inff_proto_tx_queue_data(ifp->drvr,
+							 ifp->ifidx,
+							 cpskb);
+			} else {
+				inff_err("Unable to do skb copy\n");
+			}
+		}
+	}
+	skb->dev = ifp->ndev;
+	skb->protocol = eth_type_trans(skb, ifp->ndev);
+	/* NAPI disable will use skb queue to handle data */
+	if (drvr->settings->napi_enable)
+		inff_netif_rx(ifp, skb, false);
+	else
+		skb_queue_tail(&msgbuf->rx_data_q, skb);
+}
+
+static void inff_msgbuf_process_gen_status(struct inff_msgbuf *msgbuf,
+					   void *buf)
+{
+	struct msgbuf_gen_status *gen_status = buf;
+	struct inff_pub *drvr = msgbuf->drvr;
+	int err;
+
+	err = le16_to_cpu(gen_status->compl_hdr.status);
+	if (err)
+		iphy_err(drvr, "Firmware reported general error: %d\n", err);
+}
+
+static void inff_msgbuf_process_ring_status(struct inff_msgbuf *msgbuf,
+					    void *buf)
+{
+	struct msgbuf_ring_status *ring_status = buf;
+	struct inff_pub *drvr = msgbuf->drvr;
+	int err;
+
+	err = le16_to_cpu(ring_status->compl_hdr.status);
+	if (err) {
+		int ring = le16_to_cpu(ring_status->compl_hdr.flow_ring_id);
+
+		iphy_err(drvr, "Firmware reported ring %d error: %d\n", ring,
+			 err);
+	}
+}
+
+static void
+inff_msgbuf_process_flow_ring_create_response(struct inff_msgbuf *msgbuf,
+					      void *buf)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_flowring_create_resp *flowring_create_resp;
+	u16 status;
+	u16 flowid;
+
+	flowring_create_resp = (struct msgbuf_flowring_create_resp *)buf;
+
+	flowid = le16_to_cpu(flowring_create_resp->compl_hdr.flow_ring_id);
+	flowid -= INFF_H2D_MSGRING_FLOWRING_IDSTART;
+	status =  le16_to_cpu(flowring_create_resp->compl_hdr.status);
+
+	if (status) {
+		iphy_err(drvr, "Flowring creation failed, code %d\n", status);
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+		return;
+	}
+	inff_dbg(MSGBUF, "Flowring %d Create response status %d\n", flowid,
+		 status);
+
+	inff_flowring_open(msgbuf->flow, flowid);
+
+	inff_msgbuf_schedule_txdata(msgbuf, flowid, true);
+}
+
+static void
+inff_msgbuf_process_flow_ring_delete_response(struct inff_msgbuf *msgbuf,
+					      void *buf)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_flowring_delete_resp *flowring_delete_resp;
+	u16 status;
+	u16 flowid;
+
+	flowring_delete_resp = (struct msgbuf_flowring_delete_resp *)buf;
+
+	flowid = le16_to_cpu(flowring_delete_resp->compl_hdr.flow_ring_id);
+	flowid -= INFF_H2D_MSGRING_FLOWRING_IDSTART;
+	status =  le16_to_cpu(flowring_delete_resp->compl_hdr.status);
+
+	if (status) {
+		iphy_err(drvr, "Flowring deletion failed, code %d\n", status);
+		inff_flowring_delete(msgbuf->flow, flowid);
+		return;
+	}
+	inff_dbg(MSGBUF, "Flowring %d Delete response status %d\n", flowid,
+		 status);
+
+	inff_msgbuf_remove_flowring(msgbuf, flowid);
+}
+
+static void
+inff_msgbuf_process_d2h_mbdata(struct inff_msgbuf *msgbuf,
+			       void *buf)
+{
+	struct msgbuf_d2h_mailbox_data *d2h_mbdata;
+
+	d2h_mbdata = (struct msgbuf_d2h_mailbox_data *)buf;
+
+	if (!d2h_mbdata) {
+		inff_err("d2h_mbdata is null\n");
+		return;
+	}
+
+	inff_pcie_handle_mb_data(msgbuf->drvr->bus_if, d2h_mbdata->mbdata);
+}
+
+static void inff_msgbuf_process_msgtype(struct inff_msgbuf *msgbuf, void *buf,
+					unsigned int *work_done)
+{
+	struct inff_pub *drvr = msgbuf->drvr;
+	struct msgbuf_common_hdr *msg;
+	struct inff_msgbuf_tx_status_entry *entry;
+	ulong flags;
+
+	msg = (struct msgbuf_common_hdr *)buf;
+	switch (msg->msgtype) {
+	case MSGBUF_TYPE_GEN_STATUS:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_GEN_STATUS\n");
+		inff_msgbuf_process_gen_status(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_RING_STATUS:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_RING_STATUS\n");
+		inff_msgbuf_process_ring_status(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_FLOW_RING_CREATE_CMPLT:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_FLOW_RING_CREATE_CMPLT\n");
+		inff_msgbuf_process_flow_ring_create_response(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_FLOW_RING_DELETE_CMPLT:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_FLOW_RING_DELETE_CMPLT\n");
+		inff_msgbuf_process_flow_ring_delete_response(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_IOCTLPTR_REQ_ACK:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_IOCTLPTR_REQ_ACK\n");
+		break;
+	case MSGBUF_TYPE_IOCTL_CMPLT:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_IOCTL_CMPLT\n");
+		inff_msgbuf_process_ioctl_complete(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_WL_EVENT:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_WL_EVENT\n");
+		inff_msgbuf_process_event(msgbuf, buf);
+		break;
+	case MSGBUF_TYPE_TX_STATUS:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_TX_STATUS\n");
+		if (drvr->settings->napi_enable) {
+			inff_msgbuf_process_txstatus(msgbuf, buf, work_done);
+		} else {
+			entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+			if (!entry)
+				return;
+
+			memcpy(&entry->status, buf, sizeof(entry->status));
+			spin_lock_irqsave(&msgbuf->tx_compl_work_lock, flags);
+			list_add_tail(&entry->queue, &msgbuf->tx_compl_list);
+			spin_unlock_irqrestore(&msgbuf->tx_compl_work_lock, flags);
+			schedule_work_on(inff_work_sched_cpu(drvr->settings->tx_cpu),
+					 &msgbuf->tx_compl_work);
+		}
+		break;
+	case MSGBUF_TYPE_RX_CMPLT:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_RX_CMPLT\n");
+		inff_msgbuf_process_rx_complete(msgbuf, buf, work_done);
+		break;
+	case MSGBUF_TYPE_D2H_MAILBOX_DATA:
+		inff_dbg(MSGBUF, "MSGBUF_TYPE_D2H_MAILBOX_DATA\n");
+		inff_msgbuf_process_d2h_mbdata(msgbuf, buf);
+		break;
+
+	default:
+		iphy_err(drvr, "Unsupported msgtype %d\n", msg->msgtype);
+		break;
+	}
+}
+
+static void inff_msgbuf_process_rx(struct inff_msgbuf *msgbuf,
+				   struct inff_commonring *commonring)
+{
+	void *buf;
+	u16 count;
+	u16 processed;
+	struct inff_if *ifp;
+	struct msgbuf_common_hdr *msg;
+	int napi_cpu;
+
+again:
+	buf = inff_commonring_get_read_ptr(commonring, &count);
+	if (!buf)
+		return;
+
+	msg = (struct msgbuf_common_hdr *)(buf + msgbuf->rx_dataoffset);
+	ifp = inff_get_ifp(msgbuf->drvr, msg->ifidx);
+	if (ifp && ifp->napi.poll &&
+	    (count && (msg->msgtype == MSGBUF_TYPE_RX_CMPLT ||
+		       msg->msgtype == MSGBUF_TYPE_TX_STATUS))) {
+		napi_cpu = inff_work_sched_cpu(msgbuf->drvr->settings->napi_cpu);
+		if (napi_cpu == WORK_CPU_UNBOUND)
+			inff_msgbuf_napi_schedule(ifp);
+		else
+			smp_call_function_single(napi_cpu,
+						 inff_msgbuf_napi_schedule,
+						 ifp, 0);
+		return;
+	}
+
+	processed = 0;
+	while (count) {
+		inff_msgbuf_process_msgtype(msgbuf,
+					    buf + msgbuf->rx_dataoffset, NULL);
+		buf += inff_commonring_len_item(commonring);
+		processed++;
+		if (processed == INFF_MSGBUF_UPDATE_RX_PTR_THRS) {
+			inff_commonring_read_complete(commonring, processed);
+			processed = 0;
+		}
+		count--;
+	}
+	if (processed)
+		inff_commonring_read_complete(commonring, processed);
+
+	if (commonring->r_ptr == 0)
+		goto again;
+}
+
+int inff_proto_msgbuf_rx_trigger(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_commonring *commonring;
+	void *buf;
+	u32 flowid;
+	int qlen;
+
+	buf = msgbuf->commonrings[INFF_D2H_MSGRING_RX_COMPLETE];
+	inff_msgbuf_process_rx(msgbuf, buf);
+	/* Schedule workqueue only when NAPI is disabled */
+	if (!drvr->settings->napi_enable) {
+		/* Put rxdata into the workqueue only for RX t-put enhancement. */
+		inff_msgbuf_schedule_rxdata(msgbuf, true);
+	}
+	buf = msgbuf->commonrings[INFF_D2H_MSGRING_TX_COMPLETE];
+	inff_msgbuf_process_rx(msgbuf, buf);
+	buf = msgbuf->commonrings[INFF_D2H_MSGRING_CONTROL_COMPLETE];
+	inff_msgbuf_process_rx(msgbuf, buf);
+
+	for_each_set_bit(flowid, msgbuf->txstatus_done_map,
+			 msgbuf->max_flowrings) {
+		clear_bit(flowid, msgbuf->txstatus_done_map);
+		commonring = msgbuf->flowrings[flowid];
+		qlen = inff_flowring_qlen(msgbuf->flow, flowid);
+		if (qlen > INFF_MSGBUF_TRICKLE_TXWORKER_THRS ||
+		    ((qlen) && (atomic_read(&commonring->outstanding_tx) <
+				INFF_MSGBUF_TRICKLE_TXWORKER_THRS)))
+			inff_msgbuf_schedule_txdata(msgbuf, flowid, true);
+	}
+
+	return 0;
+}
+
+void inff_msgbuf_delete_flowring(struct inff_pub *drvr, u16 flowid)
+{
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct msgbuf_tx_flowring_delete_req *delete;
+	struct inff_commonring *commonring;
+	struct inff_commonring *commonring_del = msgbuf->flowrings[flowid];
+	struct inff_flowring *flow = msgbuf->flow;
+	void *ret_ptr;
+	u8 ifidx;
+	int err;
+	int retry = INFF_MAX_TXSTATUS_WAIT_RETRIES;
+
+	/* make sure it is not in txflow */
+	inff_commonring_lock(commonring_del);
+	flow->rings[flowid]->status = RING_CLOSING;
+	inff_commonring_unlock(commonring_del);
+
+	/* wait for commonring txflow finished */
+	while (retry && atomic_read(&commonring_del->outstanding_tx)) {
+		usleep_range(5000, 10000);
+		retry--;
+	}
+	if (!retry) {
+		inff_err("timed out waiting for txstatus\n");
+		atomic_set(&commonring_del->outstanding_tx, 0);
+	}
+
+	/* no need to submit if firmware can not be reached */
+	if (drvr->bus_if->state != INFF_BUS_UP) {
+		inff_dbg(MSGBUF, "bus down, flowring will be removed\n");
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+		return;
+	}
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	inff_commonring_lock(commonring);
+	ret_ptr = inff_commonring_reserve_for_write(commonring);
+	if (!ret_ptr) {
+		iphy_err(drvr, "FW unaware, flowring will be removed !!\n");
+		inff_commonring_unlock(commonring);
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+		return;
+	}
+
+	delete = (struct msgbuf_tx_flowring_delete_req *)ret_ptr;
+
+	ifidx = inff_flowring_ifidx_get(msgbuf->flow, flowid);
+
+	delete->msg.msgtype = MSGBUF_TYPE_FLOW_RING_DELETE;
+	delete->msg.ifidx = ifidx;
+	delete->msg.request_id = 0;
+
+	delete->flow_ring_id = cpu_to_le16(flowid +
+					   INFF_H2D_MSGRING_FLOWRING_IDSTART);
+	delete->reason = 0;
+
+	inff_dbg(MSGBUF, "Send Flow Delete Req flow ID %d, ifindex %d\n",
+		 flowid, ifidx);
+
+	err = inff_commonring_write_complete(commonring);
+	inff_commonring_unlock(commonring);
+	if (err) {
+		iphy_err(drvr, "Failed to submit RING_DELETE, flowring will be removed\n");
+		inff_msgbuf_remove_flowring(msgbuf, flowid);
+	}
+}
+
+#ifdef DEBUG
+static int inff_msgbuf_stats_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_msgbuf *msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+	struct inff_commonring *commonring;
+	u16 i;
+	struct inff_flowring_ring *ring;
+	struct inff_flowring_hash *hash;
+
+	for (i = 0; i <= INFF_NROF_H2D_COMMON_MSGRINGS; i++) {
+		commonring = msgbuf->commonrings[i];
+		if (commonring->cr_update_rptr)
+			commonring->cr_update_rptr(commonring->cr_ctx);
+	}
+
+	for (i = 0; i <= INFF_NROF_D2H_COMMON_MSGRINGS; i++) {
+		commonring = msgbuf->commonrings[i];
+		if (commonring->cr_update_wptr)
+			commonring->cr_update_wptr(commonring->cr_ctx);
+	}
+
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_CONTROL_SUBMIT];
+	seq_puts(seq, "\nh2d Submission commonrings:\n");
+	seq_printf(seq, "h2d_ctl_submit: rp %4u, wp %4u, depth %4u, was_full %u\n",
+		   commonring->r_ptr, commonring->w_ptr, commonring->depth,
+		   commonring->was_full);
+	commonring = msgbuf->commonrings[INFF_H2D_MSGRING_RXPOST_SUBMIT];
+	seq_printf(seq, "h2d_rx_submit:  rp %4u, wp %4u, depth %4u, was_full %u\n",
+		   commonring->r_ptr, commonring->w_ptr, commonring->depth,
+		   commonring->was_full);
+
+	seq_puts(seq, "\nd2h Completion commonrings:\n");
+	commonring = msgbuf->commonrings[INFF_D2H_MSGRING_CONTROL_COMPLETE];
+	seq_printf(seq, "d2h_ctl_cmplt:  rp %4u, wp %4u, depth %4u, was_full %u\n",
+		   commonring->r_ptr, commonring->w_ptr, commonring->depth,
+		   commonring->was_full);
+	commonring = msgbuf->commonrings[INFF_D2H_MSGRING_TX_COMPLETE];
+	seq_printf(seq, "d2h_tx_cmplt:   rp %4u, wp %4u, depth %4u, was_full %u\n",
+		   commonring->r_ptr, commonring->w_ptr, commonring->depth,
+		   commonring->was_full);
+	commonring = msgbuf->commonrings[INFF_D2H_MSGRING_RX_COMPLETE];
+	seq_printf(seq, "d2h_rx_cmplt:   rp %4u, wp %4u, depth %4u, was_full %u\n",
+		   commonring->r_ptr, commonring->w_ptr, commonring->depth,
+		   commonring->was_full);
+
+	seq_puts(seq, "\n h2d Active flowrings:\n");
+	for (i = 0; i < msgbuf->flow->nrofrings; i++) {
+		if (!msgbuf->flow->rings[i])
+			continue;
+		ring = msgbuf->flow->rings[i];
+		if (ring->status != RING_OPEN)
+			continue;
+		commonring = msgbuf->flowrings[i];
+
+		if (commonring->cr_update_rptr)
+			commonring->cr_update_rptr(commonring->cr_ctx);
+
+		hash = &msgbuf->flow->hash[ring->hash_id];
+		seq_printf(seq, "flowid %3u:     rp %4u, wp %4u, depth %4u, was_full %u, qlen %4u, blocked %u\n"
+				"                ifidx %u, fifo %u, da %pM\n",
+				i, commonring->r_ptr, commonring->w_ptr,
+				commonring->depth, commonring->was_full,
+				skb_queue_len(&ring->skblist), ring->blocked,
+				hash->ifidx, hash->fifo, hash->mac);
+	}
+
+	return 0;
+}
+#else
+static int inff_msgbuf_stats_read(struct seq_file *seq, void *data)
+{
+	return 0;
+}
+#endif
+
+static void inff_msgbuf_debugfs_create(struct inff_pub *drvr)
+{
+	inff_debugfs_add_entry(drvr, "msgbuf_stats", inff_msgbuf_stats_read);
+}
+
+int inff_proto_msgbuf_attach(struct inff_pub *drvr)
+{
+	struct inff_bus_msgbuf *if_msgbuf;
+	struct inff_msgbuf *msgbuf;
+	u64 address;
+	u32 count;
+	unsigned int wq_flags;
+
+	if_msgbuf = drvr->bus_if->msgbuf;
+
+	if (if_msgbuf->max_flowrings >= INFF_FLOWRING_HASHSIZE) {
+		iphy_err(drvr, "driver not configured for this many flowrings %d\n",
+			 if_msgbuf->max_flowrings);
+		if_msgbuf->max_flowrings = INFF_FLOWRING_HASHSIZE - 1;
+	}
+
+	msgbuf = kzalloc(sizeof(*msgbuf), GFP_KERNEL);
+	if (!msgbuf)
+		goto fail;
+
+	wq_flags = WQ_HIGHPRI | WQ_MEM_RECLAIM;
+
+	if (inff_work_sched_cpu(drvr->settings->tx_cpu) == WORK_CPU_UNBOUND)
+		wq_flags |= WQ_UNBOUND;
+	else
+		wq_flags |= WQ_CPU_INTENSIVE;
+
+	msgbuf->txflow_wq = alloc_workqueue("msgbuf_txflow", wq_flags, 1);
+	if (!msgbuf->txflow_wq) {
+		iphy_err(drvr, "workqueue creation failed\n");
+		goto fail;
+	}
+	INIT_WORK(&msgbuf->txflow_work, inff_msgbuf_txflow_worker);
+	if (!drvr->settings->napi_enable) {
+		msgbuf->rx_wq = alloc_workqueue("msgbuf_rx", WQ_HIGHPRI |
+				    WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+		if (!msgbuf->rx_wq) {
+			iphy_err(drvr, "RX workqueue creation failed\n");
+			goto fail;
+		}
+		INIT_WORK(&msgbuf->rx_work, inff_msgbuf_rx_worker);
+	}
+	count = BITS_TO_LONGS(if_msgbuf->max_flowrings);
+	count = count * sizeof(unsigned long);
+	msgbuf->flow_map = kzalloc(count, GFP_KERNEL);
+	if (!msgbuf->flow_map)
+		goto fail;
+
+	msgbuf->txstatus_done_map = kzalloc(count, GFP_KERNEL);
+	if (!msgbuf->txstatus_done_map)
+		goto fail;
+
+	msgbuf->drvr = drvr;
+	msgbuf->ioctbuf = dma_alloc_coherent(drvr->bus_if->dev,
+					     INFF_TX_IOCTL_MAX_MSG_SIZE,
+					     &msgbuf->ioctbuf_handle,
+					     GFP_KERNEL);
+	if (!msgbuf->ioctbuf)
+		goto fail;
+	address = (u64)msgbuf->ioctbuf_handle;
+	msgbuf->ioctbuf_phys_hi = address >> 32;
+	msgbuf->ioctbuf_phys_lo = address & 0xffffffff;
+
+	drvr->proto->hdrpull = inff_msgbuf_hdrpull;
+	drvr->proto->query_dcmd = inff_msgbuf_query_dcmd;
+	drvr->proto->set_dcmd = inff_msgbuf_set_dcmd;
+	drvr->proto->tx_queue_data = inff_msgbuf_tx_queue_data;
+	drvr->proto->configure_addr_mode = inff_msgbuf_configure_addr_mode;
+	drvr->proto->delete_peer = inff_msgbuf_delete_peer;
+	drvr->proto->add_tdls_peer = inff_msgbuf_add_tdls_peer;
+	drvr->proto->rxreorder = inff_msgbuf_rxreorder;
+	drvr->proto->debugfs_create = inff_msgbuf_debugfs_create;
+	drvr->proto->pd = msgbuf;
+	drvr->proto->add_if = inff_msgbuf_napi_add;
+	drvr->proto->del_if = inff_msgbuf_napi_del;
+	drvr->proto->xdp_init = inff_msgbuf_xdp_init;
+	drvr->proto->xdp_deinit = inff_msgbuf_xdp_deinit;
+
+	init_waitqueue_head(&msgbuf->ioctl_resp_wait);
+
+	msgbuf->commonrings =
+		(struct inff_commonring **)if_msgbuf->commonrings;
+	msgbuf->flowrings = (struct inff_commonring **)if_msgbuf->flowrings;
+	msgbuf->max_flowrings = if_msgbuf->max_flowrings;
+	msgbuf->flowring_dma_handle =
+		kcalloc(msgbuf->max_flowrings,
+			sizeof(*msgbuf->flowring_dma_handle), GFP_KERNEL);
+	if (!msgbuf->flowring_dma_handle)
+		goto fail;
+
+	msgbuf->rx_dataoffset = if_msgbuf->rx_dataoffset;
+	msgbuf->max_rxbufpost = if_msgbuf->max_rxbufpost;
+
+	msgbuf->max_ioctlrespbuf = INFF_MSGBUF_MAX_IOCTLRESPBUF_POST;
+	msgbuf->max_eventbuf = INFF_MSGBUF_MAX_EVENTBUF_POST;
+
+	msgbuf->tx_pktids = inff_msgbuf_init_tx_pktids(msgbuf,
+						       NR_TX_PKTIDS,
+						       DMA_TO_DEVICE);
+	if (!msgbuf->tx_pktids)
+		goto fail;
+	msgbuf->rx_pktids = inff_msgbuf_init_rx_pktids(msgbuf,
+						       NR_RX_PKTIDS,
+						       DMA_FROM_DEVICE);
+	if (!msgbuf->rx_pktids)
+		goto fail;
+	msgbuf->flow = inff_flowring_attach(drvr->bus_if->dev,
+					    if_msgbuf->max_flowrings);
+	if (!msgbuf->flow)
+		goto fail;
+
+	/* In NAPI disabled scenario, this skb queue is used to
+	 * handle rx data in rx_flow worker
+	 */
+	if (!drvr->settings->napi_enable)
+		skb_queue_head_init(&msgbuf->rx_data_q);
+
+	inff_dbg(MSGBUF, "Feeding buffers, rx data %d, rx event %d, rx ioctl resp %d\n",
+		 msgbuf->max_rxbufpost, msgbuf->max_eventbuf,
+		 msgbuf->max_ioctlrespbuf);
+	count = 0;
+	do {
+		inff_msgbuf_rxbuf_data_fill(msgbuf);
+		if (msgbuf->max_rxbufpost != msgbuf->rxbufpost)
+			usleep_range(10000, 10001);
+		else
+			break;
+		count++;
+	} while (count < 10);
+	inff_msgbuf_rxbuf_event_post(msgbuf);
+	inff_msgbuf_rxbuf_ioctlresp_post(msgbuf);
+	INIT_WORK(&msgbuf->flowring_work, inff_msgbuf_flowring_worker);
+	spin_lock_init(&msgbuf->flowring_work_lock);
+	INIT_LIST_HEAD(&msgbuf->work_queue);
+	INIT_WORK(&msgbuf->tx_compl_work, inff_msgbuf_tx_compl_worker);
+	INIT_LIST_HEAD(&msgbuf->tx_compl_list);
+	spin_lock_init(&msgbuf->tx_compl_work_lock);
+	return 0;
+
+fail:
+	if (msgbuf) {
+		kfree(msgbuf->flow_map);
+		kfree(msgbuf->txstatus_done_map);
+		inff_msgbuf_release_pktids(msgbuf);
+		kfree(msgbuf->flowring_dma_handle);
+		if (msgbuf->ioctbuf)
+			dma_free_coherent(drvr->bus_if->dev,
+					  INFF_TX_IOCTL_MAX_MSG_SIZE,
+					  msgbuf->ioctbuf,
+					  msgbuf->ioctbuf_handle);
+		if (msgbuf->txflow_wq)
+			destroy_workqueue(msgbuf->txflow_wq);
+		if (msgbuf->rx_wq)
+			destroy_workqueue(msgbuf->rx_wq);
+		kfree(msgbuf);
+	}
+	return -ENOMEM;
+}
+
+void inff_proto_msgbuf_detach(struct inff_pub *drvr)
+{
+	struct inff_msgbuf *msgbuf;
+	struct inff_msgbuf_work_item *work;
+	struct inff_msgbuf_tx_status_entry *status;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (drvr->proto->pd) {
+		msgbuf = (struct inff_msgbuf *)drvr->proto->pd;
+		cancel_work_sync(&msgbuf->flowring_work);
+		cancel_work_sync(&msgbuf->tx_compl_work);
+		if (!drvr->settings->napi_enable)
+			cancel_work_sync(&msgbuf->rx_work);
+		while (!list_empty(&msgbuf->work_queue)) {
+			work = list_first_entry(&msgbuf->work_queue,
+						struct inff_msgbuf_work_item,
+						queue);
+			list_del(&work->queue);
+			kfree(work);
+		}
+		while (!list_empty(&msgbuf->tx_compl_list)) {
+			status = list_first_entry(&msgbuf->tx_compl_list,
+						  struct inff_msgbuf_tx_status_entry,
+						queue);
+			list_del(&status->queue);
+			kfree(status);
+		}
+		kfree(msgbuf->flow_map);
+		kfree(msgbuf->txstatus_done_map);
+		if (msgbuf->txflow_wq)
+			destroy_workqueue(msgbuf->txflow_wq);
+
+		if (msgbuf->rx_wq) {
+			flush_workqueue(msgbuf->rx_wq);
+			destroy_workqueue(msgbuf->rx_wq);
+		}
+		/* In NAPI disabled scenario, this skb queue is used to
+		 * handle rx data in rx_flow worker
+		 */
+		if (!drvr->settings->napi_enable)
+			skb_queue_purge(&msgbuf->rx_data_q);
+
+		inff_flowring_detach(msgbuf->flow);
+		dma_free_coherent(drvr->bus_if->dev,
+				  INFF_TX_IOCTL_MAX_MSG_SIZE,
+				  msgbuf->ioctbuf, msgbuf->ioctbuf_handle);
+		inff_msgbuf_release_pktids(msgbuf);
+		kfree(msgbuf->flowring_dma_handle);
+		kfree(msgbuf);
+		drvr->proto->pd = NULL;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/msgbuf.h b/drivers/net/wireless/infineon/inffmac/msgbuf.h
new file mode 100644
index 000000000000..fd12973a9f68
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/msgbuf.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_MSGBUF_H
+#define INFF_MSGBUF_H
+
+#ifdef CONFIG_INFFMAC_PROTO_MSGBUF
+
+/* IDs of the 6 default common rings of msgbuf protocol */
+#define INFF_H2D_MSGRING_CONTROL_SUBMIT	0
+#define INFF_H2D_MSGRING_RXPOST_SUBMIT		1
+#define INFF_H2D_MSGRING_FLOWRING_IDSTART	2
+#define INFF_D2H_MSGRING_CONTROL_COMPLETE	2
+#define INFF_D2H_MSGRING_TX_COMPLETE		3
+#define INFF_D2H_MSGRING_RX_COMPLETE		4
+
+#define INFF_NROF_H2D_COMMON_MSGRINGS		2
+#define INFF_NROF_D2H_COMMON_MSGRINGS		3
+#define INFF_NROF_COMMON_MSGRINGS	(INFF_NROF_H2D_COMMON_MSGRINGS + \
+					 INFF_NROF_D2H_COMMON_MSGRINGS)
+
+#define INFF_H2D_MSGRING_CONTROL_SUBMIT_MAX_ITEM	64
+#define INFF_H2D_MSGRING_RXPOST_SUBMIT_MAX_ITEM	1024
+#define INFF_D2H_MSGRING_CONTROL_COMPLETE_MAX_ITEM	64
+#define INFF_D2H_MSGRING_TX_COMPLETE_MAX_ITEM		1024
+#define INFF_D2H_MSGRING_RX_COMPLETE_MAX_ITEM		1024
+#define INFF_H2D_TXFLOWRING_MAX_ITEM			512
+#define INFF_RING_MAX_ITEM_LOWER_LIMIT			64
+#define INFF_RING_MAX_ITEM_UPPER_LIMIT				2048
+
+#define INFF_H2D_MSGRING_CONTROL_SUBMIT_ITEMSIZE	40
+#define INFF_H2D_MSGRING_RXPOST_SUBMIT_ITEMSIZE	32
+#define INFF_D2H_MSGRING_CONTROL_COMPLETE_ITEMSIZE	24
+#define INFF_D2H_MSGRING_TX_COMPLETE_ITEMSIZE_PRE_V7	16
+#define INFF_D2H_MSGRING_TX_COMPLETE_ITEMSIZE		24
+#define INFF_D2H_MSGRING_RX_COMPLETE_ITEMSIZE_PRE_V7	32
+#define INFF_D2H_MSGRING_RX_COMPLETE_ITEMSIZE		40
+#define INFF_H2D_TXFLOWRING_ITEMSIZE			48
+
+static const u32 inff_ring_max_item[INFF_NROF_COMMON_MSGRINGS] = {
+	INFF_H2D_MSGRING_CONTROL_SUBMIT_MAX_ITEM,
+	INFF_H2D_MSGRING_RXPOST_SUBMIT_MAX_ITEM,
+	INFF_D2H_MSGRING_CONTROL_COMPLETE_MAX_ITEM,
+	INFF_D2H_MSGRING_TX_COMPLETE_MAX_ITEM,
+	INFF_D2H_MSGRING_RX_COMPLETE_MAX_ITEM
+};
+
+static const u32 inff_ring_itemsize_pre_v7[INFF_NROF_COMMON_MSGRINGS] = {
+	INFF_H2D_MSGRING_CONTROL_SUBMIT_ITEMSIZE,
+	INFF_H2D_MSGRING_RXPOST_SUBMIT_ITEMSIZE,
+	INFF_D2H_MSGRING_CONTROL_COMPLETE_ITEMSIZE,
+	INFF_D2H_MSGRING_TX_COMPLETE_ITEMSIZE_PRE_V7,
+	INFF_D2H_MSGRING_RX_COMPLETE_ITEMSIZE_PRE_V7
+};
+
+static const u32 inff_ring_itemsize[INFF_NROF_COMMON_MSGRINGS] = {
+	INFF_H2D_MSGRING_CONTROL_SUBMIT_ITEMSIZE,
+	INFF_H2D_MSGRING_RXPOST_SUBMIT_ITEMSIZE,
+	INFF_D2H_MSGRING_CONTROL_COMPLETE_ITEMSIZE,
+	INFF_D2H_MSGRING_TX_COMPLETE_ITEMSIZE,
+	INFF_D2H_MSGRING_RX_COMPLETE_ITEMSIZE
+};
+
+struct msgbuf_buf_addr {
+	__le32		low_addr;
+	__le32		high_addr;
+};
+
+/**
+ * struct inff_bus_msgbuf - bus ringbuf if in case of msgbuf.
+ *
+ * @commonrings: commonrings which are always there.
+ * @flowrings: commonrings which are dynamically created and destroyed for data.
+ * @rx_dataoffset: if set then all rx data has this offset.
+ * @max_rxbufpost: maximum number of buffers to post for rx.
+ * @max_flowrings: maximum number of tx flow rings supported.
+ * @max_submissionrings: maximum number of submission rings(h2d) supported.
+ * @max_completionrings: maximum number of completion rings(d2h) supported.
+ */
+struct inff_bus_msgbuf {
+	struct inff_commonring *commonrings[INFF_NROF_COMMON_MSGRINGS];
+	struct inff_commonring **flowrings;
+	u32 rx_dataoffset;
+	u32 max_rxbufpost;
+	u16 max_flowrings;
+	u16 max_submissionrings;
+	u16 max_completionrings;
+};
+
+int inff_proto_msgbuf_rx_trigger(struct device *dev);
+void inff_msgbuf_delete_flowring(struct inff_pub *drvr, u16 flowid);
+int inff_proto_msgbuf_attach(struct inff_pub *drvr);
+void inff_proto_msgbuf_detach(struct inff_pub *drvr);
+#else
+static inline int inff_proto_msgbuf_attach(struct inff_pub *drvr)
+{
+	return 0;
+}
+
+static inline void inff_proto_msgbuf_detach(struct inff_pub *drvr) {}
+#endif
+int inff_msgbuf_tx_mbdata(struct inff_pub *drvr, u32 mbdata);
+
+#endif /* INFF_MSGBUF_H */
-- 
2.25.1


