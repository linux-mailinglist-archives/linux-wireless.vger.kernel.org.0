Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90951F34E1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFIHdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 03:33:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25997 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgFIHdz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 03:33:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591688032; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4d3H33TkdoD7DsklxLDeKaF2F/DLkZz2QtakdRZaVl8=; b=FYaGd5GPLZQ18ZFYB40qxgIiN+DkqTu0ul2cGekCYCHx1v+3DLOTK5y92eE4VbtXaoaEvpPi
 4FFqI6scgtaHyePIt4NRoCVsehvz1QLVSbGeBWaEQ+RUE/TKUWC4P43nZ9abuA5mtmgNKHnW
 FUlwG21sf1/yxyg3uOeGofP9e0g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5edf3b5b8bec507768750cc8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 07:33:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 260ABC433CA; Tue,  9 Jun 2020 07:33:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26A5FC433C6;
        Tue,  9 Jun 2020 07:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26A5FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH v2 1/2] ath11k: Add direct buffer ring support
Date:   Tue,  9 Jun 2020 13:03:33 +0530
Message-Id: <1591688014-26441-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add direct buffer ring (dbring) with helper API, which is used by the
spectral scan. Initialise the direct buffer ring based on the dma ring
capability, which get announced in the wmi service ready extended event.
This ring is slightly changed from data path rings. Compare to data path
ring this ring shares the hp and tp address to firmware though WMI commands.
Also the replenish buffer size is derived from firmware announcement.
driver receive indication through WMI event
WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 v2:
   - fix the build error

 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.h   |   4 +
 drivers/net/wireless/ath/ath11k/dbring.c | 353 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dbring.h |  79 +++++++
 drivers/net/wireless/ath/ath11k/dp.c     |   3 +-
 drivers/net/wireless/ath/ath11k/wmi.c    | 226 +++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h    |  81 ++++++-
 7 files changed, 744 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/dbring.c
 create mode 100644 drivers/net/wireless/ath/ath11k/dbring.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index fe7736e..d17a3b4 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -15,7 +15,8 @@ ath11k-y += core.o \
 	    dp_rx.o \
 	    debug.o \
 	    ce.o \
-	    peer.o
+	    peer.o \
+	    dbring.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e7..0671c9b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -21,6 +21,7 @@
 #include "hal_rx.h"
 #include "reg.h"
 #include "thermal.h"
+#include "dbring.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -668,6 +669,9 @@ struct ath11k_base {
 	/* Round robbin based TCL ring selector */
 	atomic_t tcl_ring_selector;
 
+	struct ath11k_dbring_cap *db_caps;
+	u32 num_db_cap;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
new file mode 100644
index 0000000..b962584
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+#include "debug.h"
+
+static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
+					struct ath11k_dbring *ring,
+					struct ath11k_dbring_element *buff,
+					gfp_t gfp)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct hal_srng *srng;
+	dma_addr_t paddr;
+	void *ptr_aligned, *ptr_unaligned, *desc;
+	int ret;
+	int buf_id;
+	u32 cookie;
+
+	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
+
+	lockdep_assert_held(&srng->lock);
+
+	ath11k_hal_srng_access_begin(ab, srng);
+
+	ptr_unaligned = buff->payload;
+	ptr_aligned = PTR_ALIGN(ptr_unaligned, ring->buf_align);
+	paddr = dma_map_single(ab->dev, ptr_aligned, ring->buf_sz,
+			       DMA_FROM_DEVICE);
+
+	ret = dma_mapping_error(ab->dev, paddr);
+	if (ret)
+		goto err;
+
+	spin_lock_bh(&ring->idr_lock);
+	buf_id = idr_alloc(&ring->bufs_idr, buff, 0, ring->bufs_max, gfp);
+	spin_unlock_bh(&ring->idr_lock);
+	if (buf_id < 0) {
+		ret = -ENOBUFS;
+		goto err_dma_unmap;
+	}
+
+	desc = ath11k_hal_srng_src_get_next_entry(ab, srng);
+	if (!desc) {
+		ret = -ENOENT;
+		goto err_idr_remove;
+	}
+
+	buff->paddr = paddr;
+
+	cookie = FIELD_PREP(DP_RXDMA_BUF_COOKIE_PDEV_ID, ar->pdev_idx) |
+		 FIELD_PREP(DP_RXDMA_BUF_COOKIE_BUF_ID, buf_id);
+
+	ath11k_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
+
+	ath11k_hal_srng_access_end(ab, srng);
+
+	return 0;
+
+err_idr_remove:
+	spin_lock_bh(&ring->idr_lock);
+	idr_remove(&ring->bufs_idr, buf_id);
+	spin_unlock_bh(&ring->idr_lock);
+err_dma_unmap:
+	dma_unmap_single(ab->dev, paddr, ring->buf_sz,
+			 DMA_FROM_DEVICE);
+err:
+	ath11k_hal_srng_access_end(ab, srng);
+	return ret;
+}
+
+static int ath11k_dbring_fill_bufs(struct ath11k *ar,
+				   struct ath11k_dbring *ring,
+				   gfp_t gfp)
+{
+	struct ath11k_dbring_element *buff;
+	struct hal_srng *srng;
+	int num_remain, req_entries, num_free;
+	u32 align;
+	int size, ret;
+
+	srng = &ar->ab->hal.srng_list[ring->refill_srng.ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	num_free = ath11k_hal_srng_src_num_free(ar->ab, srng, true);
+	req_entries = min(num_free, ring->bufs_max);
+	num_remain = req_entries;
+	align = ring->buf_align;
+	size = sizeof(*buff) + ring->buf_sz + align - 1;
+
+	while (num_remain > 0) {
+		buff = kzalloc(size, gfp);
+		if (!buff)
+			break;
+
+		ret = ath11k_dbring_bufs_replenish(ar, ring, buff, gfp);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
+				    num_remain, req_entries);
+			kfree(buff);
+			break;
+		}
+		num_remain--;
+	}
+
+	spin_unlock_bh(&srng->lock);
+
+	return num_remain;
+}
+
+int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
+				struct ath11k_dbring *ring,
+				enum wmi_direct_buffer_module id)
+{
+	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {0};
+	int ret;
+
+	if (id >= WMI_DIRECT_BUF_MAX)
+		return -EINVAL;
+
+	param.pdev_id		= DP_SW2HW_MACID(ring->pdev_id);
+	param.module_id		= id;
+	param.base_paddr_lo	= lower_32_bits(ring->refill_srng.paddr);
+	param.base_paddr_hi	= upper_32_bits(ring->refill_srng.paddr);
+	param.head_idx_paddr_lo	= lower_32_bits(ring->hp_addr);
+	param.head_idx_paddr_hi = upper_32_bits(ring->hp_addr);
+	param.tail_idx_paddr_lo = lower_32_bits(ring->tp_addr);
+	param.tail_idx_paddr_hi = upper_32_bits(ring->tp_addr);
+	param.num_elems		= ring->bufs_max;
+	param.buf_size		= ring->buf_sz;
+	param.num_resp_per_event = ring->num_resp_per_event;
+	param.event_timeout_ms	= ring->event_timeout_ms;
+
+	ret = ath11k_wmi_pdev_dma_ring_cfg(ar, &param);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to setup db ring cfg\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath11k_dbring_set_cfg(struct ath11k *ar, struct ath11k_dbring *ring,
+			  u32 num_resp_per_event, u32 event_timeout_ms,
+			  int (*handler)(struct ath11k *,
+					 struct ath11k_dbring_data *))
+{
+	if (WARN_ON(!ring))
+		return -EINVAL;
+
+	ring->num_resp_per_event = num_resp_per_event;
+	ring->event_timeout_ms = event_timeout_ms;
+	ring->handler = handler;
+
+	return 0;
+}
+
+int ath11k_dbring_buf_setup(struct ath11k *ar,
+			    struct ath11k_dbring *ring,
+			    struct ath11k_dbring_cap *db_cap)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct hal_srng *srng;
+	int ret;
+
+	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
+	ring->bufs_max = ring->refill_srng.size /
+			 ath11k_hal_srng_get_entrysize(HAL_RXDMA_DIR_BUF);
+
+	ring->buf_sz = db_cap->min_buf_sz;
+	ring->buf_align = db_cap->min_buf_align;
+	ring->pdev_id = db_cap->pdev_id;
+	ring->hp_addr = ath11k_hal_srng_get_hp_addr(ar->ab, srng);
+	ring->tp_addr = ath11k_hal_srng_get_tp_addr(ar->ab, srng);
+
+	ret = ath11k_dbring_fill_bufs(ar, ring, GFP_KERNEL);
+
+	return ret;
+}
+
+int ath11k_dbring_srng_setup(struct ath11k *ar, struct ath11k_dbring *ring,
+			     int ring_num, int num_entries)
+{
+	int ret;
+
+	ret = ath11k_dp_srng_setup(ar->ab, &ring->refill_srng, HAL_RXDMA_DIR_BUF,
+				   ring_num, ar->pdev_idx, num_entries);
+	if (ret < 0) {
+		ath11k_warn(ar->ab, "failed to setup srng: %d ring_id %d\n",
+			    ret, ring_num);
+		goto err;
+	}
+
+	return 0;
+err:
+	ath11k_dp_srng_cleanup(ar->ab, &ring->refill_srng);
+	return ret;
+}
+
+int ath11k_dbring_get_cap(struct ath11k_base *ab,
+			  u8 pdev_idx,
+			  enum wmi_direct_buffer_module id,
+			  struct ath11k_dbring_cap *db_cap)
+{
+	int i;
+
+	if (!ab->num_db_cap || !ab->db_caps)
+		return -ENOENT;
+
+	if (id >= WMI_DIRECT_BUF_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < ab->num_db_cap; i++) {
+		if (pdev_idx == ab->db_caps[i].pdev_id &&
+		    id == ab->db_caps[i].id) {
+			*db_cap = ab->db_caps[i];
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
+				       struct ath11k_dbring_buf_release_event *ev)
+{
+	struct ath11k_dbring *ring;
+	struct hal_srng *srng;
+	struct ath11k *ar;
+	struct ath11k_dbring_element *buff;
+	struct ath11k_dbring_data handler_data;
+	struct ath11k_buffer_addr desc;
+	u8 *vaddr_unalign;
+	u32 num_entry, num_buff_reaped;
+	u8 pdev_idx, rbm;
+	u32 cookie;
+	int buf_id;
+	int size;
+	dma_addr_t paddr;
+	int ret = 0;
+
+	pdev_idx = ev->fixed.pdev_id;
+
+	if (pdev_idx >= ab->num_radios) {
+		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
+		return -EINVAL;
+	}
+
+	if (ev->fixed.num_buf_release_entry !=
+	    ev->fixed.num_meta_data_entry) {
+		ath11k_warn(ab, "Buffer entry %d mismatch meta entry %d\n",
+			    ev->fixed.num_buf_release_entry,
+			    ev->fixed.num_meta_data_entry);
+		return -EINVAL;
+	}
+
+	ar = ab->pdevs[pdev_idx].ar;
+
+	rcu_read_lock();
+	if (!rcu_dereference(ab->pdevs_active[pdev_idx])) {
+		ret = -EINVAL;
+		goto rcu_unlock;
+	}
+
+	switch (ev->fixed.module_id) {
+	default:
+		ring = NULL;
+		ath11k_warn(ab, "Recv dma buffer release ev on unsupp module %d\n",
+			    ev->fixed.module_id);
+		break;
+	}
+
+	if (!ring) {
+		ret = -EINVAL;
+		goto rcu_unlock;
+	}
+
+	srng = &ab->hal.srng_list[ring->refill_srng.ring_id];
+	num_entry = ev->fixed.num_buf_release_entry;
+	size = sizeof(*buff) + ring->buf_sz + ring->buf_align - 1;
+	num_buff_reaped = 0;
+
+	spin_lock_bh(&srng->lock);
+
+	while (num_buff_reaped < num_entry) {
+		desc.info0 = ev->buf_entry[num_buff_reaped].paddr_lo;
+		desc.info1 = ev->buf_entry[num_buff_reaped].paddr_hi;
+		handler_data.meta = ev->meta_data[num_buff_reaped];
+
+		num_buff_reaped++;
+
+		ath11k_hal_rx_buf_addr_info_get(&desc, &paddr, &cookie, &rbm);
+
+		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID, cookie);
+
+		spin_lock_bh(&ring->idr_lock);
+		buff = idr_find(&ring->bufs_idr, buf_id);
+		if (!buff) {
+			spin_unlock_bh(&ring->idr_lock);
+			continue;
+		}
+		idr_remove(&ring->bufs_idr, buf_id);
+		spin_unlock_bh(&ring->idr_lock);
+
+		dma_unmap_single(ab->dev, buff->paddr, ring->buf_sz,
+				 DMA_FROM_DEVICE);
+
+		if (ring->handler) {
+			vaddr_unalign = buff->payload;
+			handler_data.data = PTR_ALIGN(vaddr_unalign,
+						      ring->buf_align);
+			handler_data.data_sz = ring->buf_sz;
+
+			ring->handler(ar, &handler_data);
+		}
+
+		memset(buff, 0, size);
+		ath11k_dbring_bufs_replenish(ar, ring, buff, GFP_ATOMIC);
+	}
+
+	spin_unlock_bh(&srng->lock);
+
+rcu_unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void ath11k_dbring_srng_cleanup(struct ath11k *ar, struct ath11k_dbring *ring)
+{
+	ath11k_dp_srng_cleanup(ar->ab, &ring->refill_srng);
+}
+
+void ath11k_dbring_buf_cleanup(struct ath11k *ar, struct ath11k_dbring *ring)
+{
+	struct ath11k_dbring_element *buff;
+	int buf_id;
+
+	spin_lock_bh(&ring->idr_lock);
+	idr_for_each_entry(&ring->bufs_idr, buff, buf_id) {
+		idr_remove(&ring->bufs_idr, buf_id);
+		dma_unmap_single(ar->ab->dev, buff->paddr,
+				 ring->buf_sz, DMA_FROM_DEVICE);
+		kfree(buff);
+	}
+
+	idr_destroy(&ring->bufs_idr);
+	spin_unlock_bh(&ring->idr_lock);
+}
diff --git a/drivers/net/wireless/ath/ath11k/dbring.h b/drivers/net/wireless/ath/ath11k/dbring.h
new file mode 100644
index 0000000..f7fce9e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dbring.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_DBRING_H
+#define ATH11K_DBRING_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include "dp.h"
+
+struct ath11k_dbring_element {
+	dma_addr_t paddr;
+	u8 payload[0];
+};
+
+struct ath11k_dbring_data {
+	void *data;
+	u32 data_sz;
+	struct wmi_dma_buf_release_meta_data meta;
+};
+
+struct ath11k_dbring_buf_release_event {
+	struct ath11k_wmi_dma_buf_release_fixed_param fixed;
+	struct wmi_dma_buf_release_entry *buf_entry;
+	struct wmi_dma_buf_release_meta_data *meta_data;
+	u32 num_buf_entry;
+	u32 num_meta;
+};
+
+struct ath11k_dbring_cap {
+	u32 pdev_id;
+	enum wmi_direct_buffer_module id;
+	u32 min_elem;
+	u32 min_buf_sz;
+	u32 min_buf_align;
+};
+
+struct ath11k_dbring {
+	struct dp_srng refill_srng;
+	struct idr bufs_idr;
+	/* Protects bufs_idr */
+	spinlock_t idr_lock;
+	dma_addr_t tp_addr;
+	dma_addr_t hp_addr;
+	int bufs_max;
+	u32 pdev_id;
+	u32 buf_sz;
+	u32 buf_align;
+	u32 num_resp_per_event;
+	u32 event_timeout_ms;
+	int (*handler)(struct ath11k *, struct ath11k_dbring_data *);
+};
+
+int ath11k_dbring_set_cfg(struct ath11k *ar,
+			  struct ath11k_dbring *ring,
+			  u32 num_resp_per_event,
+			  u32 event_timeout_ms,
+			  int (*handler)(struct ath11k *,
+					 struct ath11k_dbring_data *));
+int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
+				struct ath11k_dbring *ring,
+				enum wmi_direct_buffer_module id);
+int ath11k_dbring_buf_setup(struct ath11k *ar,
+			    struct ath11k_dbring *ring,
+			    struct ath11k_dbring_cap *db_cap);
+int ath11k_dbring_srng_setup(struct ath11k *ar, struct ath11k_dbring *ring,
+			     int ring_num, int num_entries);
+int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
+				       struct ath11k_dbring_buf_release_event *ev);
+int ath11k_dbring_get_cap(struct ath11k_base *ab,
+			  u8 pdev_idx,
+			  enum wmi_direct_buffer_module id,
+			  struct ath11k_dbring_cap *db_cap);
+void ath11k_dbring_srng_cleanup(struct ath11k *ar, struct ath11k_dbring *ring);
+void ath11k_dbring_buf_cleanup(struct ath11k *ar, struct ath11k_dbring *ring);
+#endif /* ATH11K_DBRING_H */
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 9ae743e..1d64c3c 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -172,11 +172,12 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 	case HAL_RXDMA_DST:
 	case HAL_RXDMA_MONITOR_DST:
 	case HAL_RXDMA_MONITOR_DESC:
-	case HAL_RXDMA_DIR_BUF:
 		params.intr_batch_cntr_thres_entries =
 					HAL_SRNG_INT_BATCH_THRESHOLD_OTHER;
 		params.intr_timer_thres_us = HAL_SRNG_INT_TIMER_THRESHOLD_OTHER;
 		break;
+	case HAL_RXDMA_DIR_BUF:
+		break;
 	default:
 		ath11k_warn(ab, "Not a valid ring type in dp :%d\n", type);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a9723..fe42d16 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -27,6 +27,11 @@ struct wmi_tlv_svc_ready_parse {
 	bool wmi_svc_bitmap_done;
 };
 
+struct wmi_tlv_dma_ring_caps_parse {
+	struct wmi_dma_ring_capabilities *dma_ring_caps;
+	u32 n_dma_ring_caps;
+};
+
 struct wmi_tlv_svc_rdy_ext_parse {
 	struct ath11k_service_ext_param param;
 	struct wmi_soc_mac_phy_hw_mode_caps *hw_caps;
@@ -39,9 +44,19 @@ struct wmi_tlv_svc_rdy_ext_parse {
 	struct wmi_soc_hal_reg_capabilities *soc_hal_reg_caps;
 	struct wmi_hal_reg_capabilities_ext *ext_hal_reg_caps;
 	u32 n_ext_hal_reg_caps;
+	struct wmi_tlv_dma_ring_caps_parse dma_caps_parse;
 	bool hw_mode_done;
 	bool mac_phy_done;
 	bool ext_hal_reg_done;
+	bool mac_phy_chainmask_combo_done;
+	bool mac_phy_chainmask_cap_done;
+	bool oem_dma_ring_cap_done;
+	bool dma_ring_cap_done;
+};
+
+struct wmi_tlv_svc_rdy_ext2_parse {
+	struct wmi_tlv_dma_ring_caps_parse dma_caps_parse;
+	bool dma_ring_cap_done;
 };
 
 struct wmi_tlv_rdy_parse {
@@ -3265,6 +3280,52 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
 }
 
+int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
+				 struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *param)
+{
+	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_DMA_RING_CFG_REQ) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->pdev_id		= param->pdev_id;
+	cmd->module_id		= param->module_id;
+	cmd->base_paddr_lo	= param->base_paddr_lo;
+	cmd->base_paddr_hi	= param->base_paddr_hi;
+	cmd->head_idx_paddr_lo	= param->head_idx_paddr_lo;
+	cmd->head_idx_paddr_hi	= param->head_idx_paddr_hi;
+	cmd->tail_idx_paddr_lo	= param->tail_idx_paddr_lo;
+	cmd->tail_idx_paddr_hi	= param->tail_idx_paddr_hi;
+	cmd->num_elems		= param->num_elems;
+	cmd->buf_size		= param->buf_size;
+	cmd->num_resp_per_event	= param->num_resp_per_event;
+	cmd->event_timeout_ms	= param->event_timeout_ms;
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb,
+				  WMI_PDEV_DMA_RING_CFG_REQ_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send dma ring cfg req wmi cmd\n");
+		goto err;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI DMA ring cfg req cmd pdev_id 0x%x\n",
+		   param->pdev_id);
+
+	return 0;
+err:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
 static int ath11k_wmi_tlv_hw_mode_caps_parse(struct ath11k_base *soc,
 					     u16 tag, u16 len,
 					     const void *ptr, void *data)
@@ -3445,6 +3506,95 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 	return 0;
 }
 
+static int ath11k_wmi_tlv_dma_ring_caps_parse(struct ath11k_base *soc,
+					      u16 tag, u16 len,
+					      const void *ptr, void *data)
+{
+	struct wmi_tlv_dma_ring_caps_parse *parse = data;
+
+	if (tag != WMI_TAG_DMA_RING_CAPABILITIES)
+		return -EPROTO;
+
+	parse->n_dma_ring_caps++;
+	return 0;
+}
+
+static int ath11k_wmi_alloc_dbring_caps(struct ath11k_base *ab,
+					u32 num_cap)
+{
+	size_t sz;
+	void *ptr;
+
+	sz = num_cap * sizeof(struct ath11k_dbring_cap);
+	ptr = kzalloc(sz, GFP_ATOMIC);
+	if (!ptr)
+		return -ENOMEM;
+
+	ab->db_caps = ptr;
+	ab->num_db_cap = num_cap;
+
+	return 0;
+}
+
+static void ath11k_wmi_free_dbring_caps(struct ath11k_base *ab)
+{
+	kfree(ab->db_caps);
+	ab->db_caps = NULL;
+}
+
+static int ath11k_wmi_tlv_dma_ring_caps(struct ath11k_base *ab,
+					u16 len, const void *ptr, void *data)
+{
+	struct wmi_tlv_dma_ring_caps_parse *dma_caps_parse = data;
+	struct wmi_dma_ring_capabilities *dma_caps;
+	struct ath11k_dbring_cap *dir_buff_caps;
+	int ret;
+	u32 i;
+
+	dma_caps_parse->n_dma_ring_caps = 0;
+	dma_caps = (struct wmi_dma_ring_capabilities *)ptr;
+	ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+				  ath11k_wmi_tlv_dma_ring_caps_parse,
+				  dma_caps_parse);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse dma ring caps tlv %d\n", ret);
+		return ret;
+	}
+
+	if (!dma_caps_parse->n_dma_ring_caps)
+		return 0;
+
+	if (ab->num_db_cap) {
+		ath11k_warn(ab, "Already processed, so ignoring dma ring caps\n");
+		return 0;
+	}
+
+	ret = ath11k_wmi_alloc_dbring_caps(ab, dma_caps_parse->n_dma_ring_caps);
+	if (ret)
+		return ret;
+
+	dir_buff_caps = ab->db_caps;
+	for (i = 0; i < dma_caps_parse->n_dma_ring_caps; i++) {
+		if (dma_caps[i].module_id >= WMI_DIRECT_BUF_MAX) {
+			ath11k_warn(ab, "Invalid module id %d\n", dma_caps[i].module_id);
+			ret = -EINVAL;
+			goto free_dir_buff;
+		}
+
+		dir_buff_caps[i].id = dma_caps[i].module_id;
+		dir_buff_caps[i].pdev_id = DP_HW2SW_MACID(dma_caps[i].pdev_id);
+		dir_buff_caps[i].min_elem = dma_caps[i].min_elem;
+		dir_buff_caps[i].min_buf_sz = dma_caps[i].min_buf_sz;
+		dir_buff_caps[i].min_buf_align = dma_caps[i].min_buf_align;
+	}
+
+	return 0;
+
+free_dir_buff:
+	ath11k_wmi_free_dbring_caps(ab);
+	return ret;
+}
+
 static int ath11k_wmi_tlv_svc_rdy_ext_parse(struct ath11k_base *ab,
 					    u16 tag, u16 len,
 					    const void *ptr, void *data)
@@ -3501,7 +3651,19 @@ static int ath11k_wmi_tlv_svc_rdy_ext_parse(struct ath11k_base *ab,
 				return ret;
 
 			svc_rdy_ext->ext_hal_reg_done = true;
-			complete(&ab->wmi_ab.service_ready);
+		} else if (!svc_rdy_ext->mac_phy_chainmask_combo_done) {
+			svc_rdy_ext->mac_phy_chainmask_combo_done = true;
+		} else if (!svc_rdy_ext->mac_phy_chainmask_cap_done) {
+			svc_rdy_ext->mac_phy_chainmask_cap_done = true;
+		} else if (!svc_rdy_ext->oem_dma_ring_cap_done) {
+			svc_rdy_ext->oem_dma_ring_cap_done = true;
+		} else if (!svc_rdy_ext->dma_ring_cap_done) {
+			ret = ath11k_wmi_tlv_dma_ring_caps(ab, len, ptr,
+							   &svc_rdy_ext->dma_caps_parse);
+			if (ret)
+				return ret;
+
+			svc_rdy_ext->dma_ring_cap_done = true;
 		}
 		break;
 
@@ -3522,11 +3684,66 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 				  &svc_rdy_ext);
 	if (ret) {
 		ath11k_warn(ab, "failed to parse tlv %d\n", ret);
-		return ret;
+		goto err;
 	}
 
+	if (!test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
+		complete(&ab->wmi_ab.service_ready);
+
 	kfree(svc_rdy_ext.mac_phy_caps);
 	return 0;
+
+err:
+	ath11k_wmi_free_dbring_caps(ab);
+	return ret;
+}
+
+static int ath11k_wmi_tlv_svc_rdy_ext2_parse(struct ath11k_base *ab,
+					     u16 tag, u16 len,
+					     const void *ptr, void *data)
+{
+	struct wmi_tlv_svc_rdy_ext2_parse *parse = data;
+	int ret;
+
+	switch (tag) {
+	case WMI_TAG_ARRAY_STRUCT:
+		if (!parse->dma_ring_cap_done) {
+			ret = ath11k_wmi_tlv_dma_ring_caps(ab, len, ptr,
+							   &parse->dma_caps_parse);
+			if (ret)
+				return ret;
+
+			parse->dma_ring_cap_done = true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ath11k_service_ready_ext2_event(struct ath11k_base *ab,
+					   struct sk_buff *skb)
+{
+	struct wmi_tlv_svc_rdy_ext2_parse svc_rdy_ext2 = { };
+	int ret;
+
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_tlv_svc_rdy_ext2_parse,
+				  &svc_rdy_ext2);
+	if (ret) {
+		ath11k_warn(ab, "failed to parse ext2 event tlv %d\n", ret);
+		goto err;
+	}
+
+	complete(&ab->wmi_ab.service_ready);
+
+	return 0;
+
+err:
+	ath11k_wmi_free_dbring_caps(ab);
+	return ret;
 }
 
 static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buff *skb,
@@ -5933,6 +6150,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_SERVICE_READY_EXT_EVENTID:
 		ath11k_service_ready_ext_event(ab, skb);
 		break;
+	case WMI_SERVICE_READY_EXT2_EVENTID:
+		ath11k_service_ready_ext2_event(ab, skb);
+		break;
 	case WMI_REG_CHAN_LIST_CC_EVENTID:
 		ath11k_reg_chan_list_event(ab, skb);
 		break;
@@ -6213,4 +6433,6 @@ void ath11k_wmi_detach(struct ath11k_base *ab)
 
 	for (i = 0; i < ab->htc.wmi_ep_count; i++)
 		ath11k_wmi_pdev_detach(ab, i);
+
+	ath11k_wmi_free_dbring_caps(ab);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b9f3e55..5c94135 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -24,6 +24,8 @@
 #define HE_PET_8_USEC            1
 #define HE_PET_16_USEC           2
 
+#define WMI_MAX_CHAINS		 8
+
 #define WMI_MAX_NUM_SS                    MAX_HE_NSS
 #define WMI_MAX_NUM_RU                    MAX_HE_RU
 
@@ -586,6 +588,11 @@ enum wmi_tlv_event_id {
 	WMI_PDEV_DMA_RING_CFG_RSP_EVENTID,
 	WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID,
 	WMI_PDEV_CTL_FAILSAFE_CHECK_EVENTID,
+	WMI_PDEV_CSC_SWITCH_COUNT_STATUS_EVENTID,
+	WMI_PDEV_COLD_BOOT_CAL_DATA_EVENTID,
+	WMI_PDEV_RAP_INFO_EVENTID,
+	WMI_CHAN_RF_CHARACTERIZATION_INFO_EVENTID,
+	WMI_SERVICE_READY_EXT2_EVENTID,
 	WMI_VDEV_START_RESP_EVENTID = WMI_TLV_CMD(WMI_GRP_VDEV),
 	WMI_VDEV_STOPPED_EVENTID,
 	WMI_VDEV_INSTALL_KEY_COMPLETE_EVENTID,
@@ -2013,9 +2020,9 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_DSM_ROAM_FILTER = 211,
 	WMI_TLV_SERVICE_PACKET_CAPTURE_SUPPORT = 212,
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
+	WMI_TLV_SERVICE_EXT2_MSG = 220,
 
 	WMI_MAX_EXT_SERVICE
-
 };
 
 enum {
@@ -2076,6 +2083,14 @@ enum wmi_beacon_gen_mode {
 	WMI_BEACON_BURST_MODE = 1
 };
 
+enum wmi_direct_buffer_module {
+	WMI_DIRECT_BUF_SPECTRAL = 0,
+	WMI_DIRECT_BUF_CFR = 1,
+
+	/* keep it last */
+	WMI_DIRECT_BUF_MAX
+};
+
 struct wmi_host_pdev_band_to_mac {
 	u32 pdev_id;
 	u32 start_freq;
@@ -2382,6 +2397,15 @@ struct wmi_mac_addr {
 	} __packed;
 } __packed;
 
+struct wmi_dma_ring_capabilities {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 module_id;
+	u32 min_elem;
+	u32 min_buf_sz;
+	u32 min_buf_align;
+} __packed;
+
 struct wmi_ready_event_min {
 	struct wmi_abi_version fw_abi_vers;
 	struct wmi_mac_addr mac_addr;
@@ -4734,6 +4758,59 @@ struct ath11k_wmi_pdev_lro_config_cmd {
 	u32 pdev_id;
 } __packed;
 
+struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 module_id;		/* see enum wmi_direct_buffer_module */
+	u32 base_paddr_lo;
+	u32 base_paddr_hi;
+	u32 head_idx_paddr_lo;
+	u32 head_idx_paddr_hi;
+	u32 tail_idx_paddr_lo;
+	u32 tail_idx_paddr_hi;
+	u32 num_elems;		/* Number of elems in the ring */
+	u32 buf_size;		/* size of allocated buffer in bytes */
+
+	/* Number of wmi_dma_buf_release_entry packed together */
+	u32 num_resp_per_event;
+
+	/* Target should timeout and send whatever resp
+	 * it has if this time expires, units in milliseconds
+	 */
+	u32 event_timeout_ms;
+} __packed;
+
+struct ath11k_wmi_dma_buf_release_fixed_param {
+	u32 pdev_id;
+	u32 module_id;
+	u32 num_buf_release_entry;
+	u32 num_meta_data_entry;
+} __packed;
+
+struct wmi_dma_buf_release_entry {
+	u32 tlv_header;
+	u32 paddr_lo;
+
+	/* Bits 11:0:   address of data
+	 * Bits 31:12:  host context data
+	 */
+	u32 paddr_hi;
+} __packed;
+
+#define WMI_SPECTRAL_META_INFO1_FREQ1		GENMASK(15, 0)
+#define WMI_SPECTRAL_META_INFO1_FREQ2		GENMASK(31, 16)
+
+#define WMI_SPECTRAL_META_INFO2_CHN_WIDTH	GENMASK(7, 0)
+
+struct wmi_dma_buf_release_meta_data {
+	u32 tlv_header;
+	s32 noise_floor[WMI_MAX_CHAINS];
+	u32 reset_delay;
+	u32 freq1;
+	u32 freq2;
+	u32 ch_width;
+} __packed;
+
 struct target_resource_config {
 	u32 num_vdevs;
 	u32 num_peers;
@@ -4941,4 +5018,6 @@ int ath11k_wmi_send_obss_color_collision_cfg_cmd(struct ath11k *ar, u32 vdev_id,
 int ath11k_wmi_send_bss_color_change_enable_cmd(struct ath11k *ar, u32 vdev_id,
 						bool enable);
 int ath11k_wmi_pdev_lro_cfg(struct ath11k *ar, int pdev_id);
+int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
+				 struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd *param);
 #endif
-- 
1.9.1

