Return-Path: <linux-wireless+bounces-27386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0950B7DD52
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA41258478A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E431BC8C;
	Tue, 16 Sep 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="P3/rb8fB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B272EAB85
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061560; cv=none; b=L6xN8WIAz+6TA3FtlVetuos9QzuB73tONWQguk0N7ojF3FU9XcLuXm90jdU5acBOvGdd87U79y6Q+v2bDyxpg4eMel/BEPGvz7LpvZkaEDZuShX/vlP9y0hBs8Jy9v1j6pdxnkp9FhluBgE1aP+qeYHIiB01zRkHDZf9ON3vhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061560; c=relaxed/simple;
	bh=NBNzgm3EgiSAx5RwEKuSj2fjDEXtZFHap9Zzh0QLlDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJYJIG1JmokgE0am2NegRpRucgbNJIiHnkGln8+U/jeqM6G9qLwGQku0t9wwPasMqe9ZR0ZM7ON2Od1/G2I4h8cr1OOnI5OEZrrykZMo+x6yAGn8A9JLy1aFu03jn72Z+URZqxd7cFxhBhjewSgUtSt1ZIEoY4t4JyUmx9PM+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=P3/rb8fB; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061559; x=1789597559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBNzgm3EgiSAx5RwEKuSj2fjDEXtZFHap9Zzh0QLlDY=;
  b=P3/rb8fBzMKM72WRtJYsCVx0ehQXJh+emKFkgxmQIlk0iiVrUDSuUwFc
   gFt7Zpqh80o2UqG/4WJhF6DMiKCWduynLJk5bXqowgTxVHKDl4XiYWgYp
   cKmDJq0Fpxubs33VslN9KRaxur1B1478oGrlgEdO7NODMoop5z8QZFBog
   4=;
X-CSE-ConnectionGUID: MZLGlYQwS2m7G305mU8+4Q==
X-CSE-MsgGUID: HVpVyKAqSZi8AKWONI8BNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294111"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294111"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:25:56 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:25:55 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:25:52 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 31/57] wifi: inffmac: add proto.c/h
Date: Wed, 17 Sep 2025 03:47:51 +0530
Message-ID: <20250916221821.4387-37-gokulkumar.sivakumar@infineon.com>
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

Driver implementation of the BUS protocol abstraction, which is used for
the Control and Data communication with the Infineon's WLAN Device.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/proto.c |  71 +++++++
 drivers/net/wireless/infineon/inffmac/proto.h | 192 ++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/proto.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/proto.h

diff --git a/drivers/net/wireless/infineon/inffmac/proto.c b/drivers/net/wireless/infineon/inffmac/proto.c
new file mode 100644
index 000000000000..63f07407dc47
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/proto.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+
+#include "core.h"
+#include "bus.h"
+#include "debug.h"
+#include "proto.h"
+#include "bcdc.h"
+#include "msgbuf.h"
+
+int inff_proto_attach(struct inff_pub *drvr)
+{
+	struct inff_proto *proto;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	proto = kzalloc(sizeof(*proto), GFP_ATOMIC);
+	if (!proto)
+		goto fail;
+
+	drvr->proto = proto;
+
+	if (drvr->bus_if->proto_type == INFF_PROTO_BCDC) {
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
+	    !proto->query_dcmd || !proto->set_dcmd ||
+	    !proto->configure_addr_mode ||
+	    !proto->delete_peer || !proto->add_tdls_peer ||
+	    !proto->debugfs_create) {
+		iphy_err(drvr, "Not all proto handlers have been installed\n");
+		goto fail;
+	}
+	return 0;
+
+fail:
+	kfree(proto);
+	drvr->proto = NULL;
+	return -ENOMEM;
+}
+
+void inff_proto_detach(struct inff_pub *drvr)
+{
+	inff_dbg(TRACE, "Enter\n");
+
+	if (drvr->proto) {
+		if (drvr->bus_if->proto_type == INFF_PROTO_BCDC)
+			inff_proto_bcdc_detach(drvr);
+		else if (drvr->bus_if->proto_type == INFF_PROTO_MSGBUF)
+			inff_proto_msgbuf_detach(drvr);
+		kfree(drvr->proto);
+		drvr->proto = NULL;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/proto.h b/drivers/net/wireless/infineon/inffmac/proto.h
new file mode 100644
index 000000000000..e072c973ec79
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/proto.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_PROTO_H
+#define INFF_PROTO_H
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
+	int (*hdrpull)(struct inff_pub *drvr, bool do_fws,
+		       struct sk_buff *skb, struct inff_if **ifp);
+	int (*query_dcmd)(struct inff_pub *drvr, int ifidx, uint cmd,
+			  void *buf, uint len, int *fwerr);
+	int (*set_dcmd)(struct inff_pub *drvr, int ifidx, uint cmd, void *buf,
+			uint len, int *fwerr);
+	int (*tx_queue_data)(struct inff_pub *drvr, int ifidx,
+			     struct sk_buff *skb);
+	int (*txdata)(struct inff_pub *drvr, int ifidx, u8 offset,
+		      struct sk_buff *skb);
+	void (*configure_addr_mode)(struct inff_pub *drvr, int ifidx,
+				    enum proto_addr_mode addr_mode);
+	void (*delete_peer)(struct inff_pub *drvr, int ifidx,
+			    u8 peer[ETH_ALEN]);
+	void (*add_tdls_peer)(struct inff_pub *drvr, int ifidx,
+			      u8 peer[ETH_ALEN]);
+	void (*rxreorder)(struct inff_if *ifp, struct sk_buff *skb, bool inirq);
+	void (*add_if)(struct inff_if *ifp);
+	void (*del_if)(struct inff_if *ifp);
+	void (*reset_if)(struct inff_if *ifp);
+	void (*cleanup_if)(struct inff_if *ifp);
+	int (*init_done)(struct inff_pub *drvr);
+	void (*debugfs_create)(struct inff_pub *drvr);
+	int (*xdp_init)(struct inff_pub *drvr, struct inff_if *ifp);
+	void (*xdp_deinit)(struct inff_pub *drvr);
+	void *pd;
+};
+
+int inff_proto_attach(struct inff_pub *drvr);
+void inff_proto_detach(struct inff_pub *drvr);
+
+static inline int inff_proto_hdrpull(struct inff_pub *drvr, bool do_fws,
+				     struct sk_buff *skb,
+				     struct inff_if **ifp)
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
+static inline int inff_proto_query_dcmd(struct inff_pub *drvr, int ifidx,
+					uint cmd, void *buf, uint len,
+					int *fwerr)
+{
+	return drvr->proto->query_dcmd(drvr, ifidx, cmd, buf, len, fwerr);
+}
+
+static inline int inff_proto_set_dcmd(struct inff_pub *drvr, int ifidx,
+				      uint cmd, void *buf, uint len,
+				      int *fwerr)
+{
+	return drvr->proto->set_dcmd(drvr, ifidx, cmd, buf, len, fwerr);
+}
+
+static inline int inff_proto_tx_queue_data(struct inff_pub *drvr, int ifidx,
+					   struct sk_buff *skb)
+{
+	return drvr->proto->tx_queue_data(drvr, ifidx, skb);
+}
+
+static inline int inff_proto_txdata(struct inff_pub *drvr, int ifidx,
+				    u8 offset, struct sk_buff *skb)
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
+static inline void
+inff_proto_add_tdls_peer(struct inff_pub *drvr, int ifidx, u8 peer[ETH_ALEN])
+{
+	drvr->proto->add_tdls_peer(drvr, ifidx, peer);
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
+static inline void
+inff_proto_debugfs_create(struct inff_pub *drvr)
+{
+	drvr->proto->debugfs_create(drvr);
+}
+
+static inline int
+inff_proto_xdp_init(struct inff_pub *drvr, struct inff_if *ifp)
+{
+	if (!drvr->proto ||
+	    !drvr->proto->xdp_init)
+		return 0;
+	return drvr->proto->xdp_init(drvr, ifp);
+}
+
+static inline void
+inff_proto_xdp_deinit(struct inff_pub *drvr)
+{
+	if (!drvr->proto ||
+	    !drvr->proto->xdp_deinit)
+		return;
+	drvr->proto->xdp_deinit(drvr);
+}
+
+#endif /* INFF_PROTO_H */
-- 
2.25.1


