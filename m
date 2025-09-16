Return-Path: <linux-wireless+bounces-27373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A6B7D723
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA77B70E9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBD2E0415;
	Tue, 16 Sep 2025 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Idb2xOaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878F2248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061401; cv=none; b=dAmyyPj4D8kHBNch2XhjkQtQlMDUb05+92M57umZtlU/WPZ0OwA7S624+Z/FL6dQ8rLuE5zC882/EoRYkyO4Rfh8zRVgMlNL4DtuLr0H8utEQb+ijswpzUQpLDHuPKnQvtNyRw0cCEzADiD8YWXKZQf/yGsC3NQ08rGd2f5UWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061401; c=relaxed/simple;
	bh=0cMPtLYnNigOXBUZMTNpOUBBr0WHuG0vHA+1Y6o6x6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmA4Xf+TedKj7ZsCeVOXQXLPKQ1fIQ2MEgSMaFliSmu/8z6oLNKp8WZlHNGww0AMRPVGxFcPLZNyDNIMjD2yo59P44tNtC9FqCON6rGIOK5uQRx6YwfLybZsee+5TP9RkKue12zfxjz8UPm+NcBnWxxNewlxL1Ywp4Zmi/ZV9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Idb2xOaX; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061400; x=1789597400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cMPtLYnNigOXBUZMTNpOUBBr0WHuG0vHA+1Y6o6x6Y=;
  b=Idb2xOaXrg8tk26xVkxacG2Rk0bCzLHIRAhdEjh+wlM/Hnsuy1YDm9c6
   vEFQRj1JTj0k3wv3y3LOXyMSsovIF6iOeJ/Ndyy9Y5nIxEM89/bROTWvZ
   KMfaIrSWCU12uM/z9Lxj+/DGXKZhhHr3pxk6SWKpi5gzGlCInILX+ynOD
   U=;
X-CSE-ConnectionGUID: pP+VrY+MQxSJ9/Wxa5Z0Ng==
X-CSE-MsgGUID: qkuR8vJITBChm8a09oChag==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918400"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918400"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:23:18 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:23:17 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:23:14 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 21/57] wifi: inffmac: add xdp.c/h
Date: Wed, 17 Sep 2025 03:47:38 +0530
Message-ID: <20250916221821.4387-24-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of eXpress Data Path (XDP) for Infineon WLAN Device,
This introduces support for having a programmable network data path, by
allowing native XDP program execution in the WLAN driver layer even before
socket buffer (SKB) allocation for all RX data packets received over the
PCIe bus from the firmware.

The FULLMAC nature of Infineon’s WLAN NIC makes it suitable for XDP
program execution directly on the 802.3 packet received from the device
through DMA, just like an Ethernet NIC.

Currently, the supported XDP actions are XDP_PASS, XDP_DROP, and
XDP_ABORTED. There are plans to further extend this support to XDP_TX and
XDP_REDIRECT actions later. Having support for XDP is beneficial for a
variety of use cases, like being helpful in efficiently dropping unwanted
RX packets and in-place (zero-copy) packet modification before passing the
RX packet to the network stack.

The MSGBUF implementation is the driver has provision to execute the user
XDP program on the RX Data path of the WLAN device connected over PCIe.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/xdp.c | 155 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/xdp.h |  31 ++++
 2 files changed, 186 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/xdp.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/xdp.h

diff --git a/drivers/net/wireless/infineon/inffmac/xdp.c b/drivers/net/wireless/infineon/inffmac/xdp.c
new file mode 100644
index 000000000000..f23b8a2e263c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/xdp.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "xdp.h"
+#include "bus.h"
+#include "debug.h"
+
+void inff_xdp_prepare_buff(struct xdp_rxq_info *xdp_rxq,
+			   struct xdp_buff *xdp_buff,
+			   unsigned char *data, u16 datalen)
+{
+	xdp_init_buff(xdp_buff, INFF_MAX_RX_BUF_SIZE + INFF_SKB_PAD,
+		      xdp_rxq);
+	xdp_prepare_buff(xdp_buff, data, INFF_SKB_HEADROOM,
+			 datalen, false);
+}
+
+struct sk_buff *inff_xdp_prepare_skb(struct xdp_buff *xdp_buff)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(xdp_buff->data_hard_start, PAGE_SIZE);
+	if (!skb) {
+		inff_err("XDP: Failed to build SKB from XDP BUFF\n");
+		return NULL;
+	}
+
+	/*
+	 * Mark the SKB for recycle since it is created from
+	 * a page pool memory.
+	 */
+	skb_mark_for_recycle(skb);
+
+	/*
+	 * Shift skb->data by the size of XDP Headroom to make
+	 * data pointer point to start of the actual RX data.
+	 */
+	skb_reserve(skb, xdp_buff->data - xdp_buff->data_hard_start);
+
+	 /* Shift skb->tail by the size of skb data to make
+	  * tail pointer point to end of the actual RX data
+	  */
+	skb_put(skb, xdp_buff->data_end - xdp_buff->data);
+
+	return skb;
+}
+
+u32 inff_xdp_run_prog(struct inff_if *ifp, struct xdp_buff *xdp_buff)
+{
+	struct bpf_prog *prog = ifp->xdp_prog;
+	struct net_device *ndev = ifp->ndev;
+	u32 ret, action;
+
+	if (!prog)
+		return 0;
+
+	action = bpf_prog_run_xdp(prog, xdp_buff);
+	inff_dbg(TRACE, "XDP: RX packet XDP Action %d to be taken", action);
+
+	switch (action) {
+	case XDP_PASS:
+		ret = 0;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(ndev, prog, action);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(ndev, prog, action);
+		fallthrough;
+	case XDP_DROP:
+		ret = 1;
+		break;
+	}
+
+	return ret;
+}
+
+static int inff_xdp_setup(struct net_device *ndev, struct bpf_prog *prog,
+			  struct netlink_ext_ack *extack)
+{
+	bool dev_up = netif_running(ndev);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_bus *bus_if = ifp->drvr->bus_if;
+	struct bpf_prog *old_prog;
+
+	if (prog && !prog->aux->xdp_has_frags &&
+	    ndev->mtu > INFF_MAX_RX_BUF_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "prog does not support XDP frags");
+		return -EOPNOTSUPP;
+	}
+
+	/* Check if there is need to update the existing progream */
+	if (!!ifp->xdp_prog == !!prog)
+		return 0;
+
+	if (dev_up)
+		inff_bus_interrupt_disable(bus_if);
+
+	/* Update the existing program with new */
+	old_prog = xchg(&ifp->xdp_prog, prog);
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (dev_up)
+		inff_bus_interrupt_enable(bus_if);
+
+	return 0;
+}
+
+int inff_xdp_bpf_cmd(struct net_device *ndev, struct netdev_bpf *bpf)
+{
+	switch (bpf->command) {
+	case XDP_SETUP_PROG:
+		return inff_xdp_setup(ndev, bpf->prog, bpf->extack);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int inff_xdp_init(struct net_device *ndev, struct xdp_rxq_info *xdp_rxq,
+		  struct page_pool *page_pool)
+{
+	int err;
+
+	err = __xdp_rxq_info_reg(xdp_rxq, ndev, 0, 0, PAGE_SIZE);
+	if (err) {
+		inff_err("XDP: Failed to register XDP RX Queue");
+		goto fail;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 page_pool);
+	if (err) {
+		inff_err("XDP: Failed to register XDP RX Queue");
+		goto fail_unregister_xdp_rxq;
+	}
+
+	return 0;
+
+fail_unregister_xdp_rxq:
+	xdp_rxq_info_unreg(xdp_rxq);
+fail:
+	return err;
+}
+
+void inff_xdp_deinit(struct xdp_rxq_info *xdp_rxq)
+{
+	if (xdp_rxq_info_is_reg(xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(xdp_rxq);
+		xdp_rxq_info_unreg(xdp_rxq);
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/xdp.h b/drivers/net/wireless/infineon/inffmac/xdp.h
new file mode 100644
index 000000000000..0a9eb1642717
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/xdp.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_XDP_H
+#define INFF_XDP_H
+
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
+#include <net/xdp.h>
+#include <net/page_pool/helpers.h>
+
+#include "core.h"
+
+#define INFF_SKB_HEADROOM	ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8)
+#define INFF_SKB_PAD	(SKB_DATA_ALIGN(sizeof(struct skb_shared_info) + \
+			 INFF_SKB_HEADROOM))
+#define INFF_MAX_RX_BUF_SIZE	(PAGE_SIZE - INFF_SKB_PAD)
+
+void inff_xdp_prepare_buff(struct xdp_rxq_info *rxq, struct xdp_buff *buff,
+			   unsigned char *data, u16 datalen);
+struct sk_buff *inff_xdp_prepare_skb(struct xdp_buff *xdp_buff);
+u32 inff_xdp_run_prog(struct inff_if *ifp, struct xdp_buff *xdp_buff);
+int inff_xdp_bpf_cmd(struct net_device *ndev, struct netdev_bpf *xdp);
+int inff_xdp_init(struct net_device *ndev, struct xdp_rxq_info *xdp_rxq,
+		  struct page_pool *page_pool);
+void inff_xdp_deinit(struct xdp_rxq_info *xdp_rxq);
+
+#endif /* INFF_XDP_H */
-- 
2.25.1


