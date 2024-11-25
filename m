Return-Path: <linux-wireless+bounces-15671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2F9D7A9C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284E3162C5E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D61126C1E;
	Mon, 25 Nov 2024 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="P4jPyIG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C65BE4E;
	Mon, 25 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507225; cv=none; b=mH4c/sg7SgrAavqYUgYbpFxdby8t4m0XbSP+JtV3mT0cL2hjZeNlNQUBGcM4U/uD+KvTco6Xhnmg6obmlxBTEYeh/XzfaO5lUFds4GeQw9kGJIW6nJtfPw86hsZ2bGtyI0M4+liyzAfuAYt6g1c/SEv02QL0BuqxC/JULX9za00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507225; c=relaxed/simple;
	bh=APPsH5pzntsYizn7wbJLWf7AWNXzwzr+IK7xfg0q/Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZbACcPCwrLjJs0jNGMMWj9D02f1HZG0kHUl7MUQgSx2JaytbAUSYB/4+CcYklmwe6GEOdGPME8GFAUgOWFk+j529W9DTKst2s1itvMSMopzfdI05V+qdDSKq/x5vW9MWRec7akONcAn7/eUF6AX6/EYLHidv3b/kyxqKRCRfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=P4jPyIG1; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506707; bh=APPsH5pzntsYizn7wbJLWf7AWNXzwzr+IK7xfg0q/Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4jPyIG17nibxS+0psdv9p6rnm/FodEILE66B3C2IpW8hsORh7Krk/W6pSczoZcER
	 tM8qzynhvX+PCvnMdpwgOI/IIjxS0BCsfGQWxLjm1DoFian4REf03j9h1jfjhXKkt6
	 VBo0jTYeFE22sddCIY/YrfP5HocrtYjbm2miLyR0=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id A1E2314873AA;
	Mon, 25 Nov 2024 04:51:47 +0100 (CET)
From: Mihai Moldovan <ionic@ionic.de>
To: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] [PATCH v2 01/13] net: qrtr: support registering endpoint-specific data
Date: Mon, 25 Nov 2024 04:50:16 +0100
Message-ID: <064e351e175e809e9a774022fa2f104b67862d9e.1732506261.git.ionic@ionic.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732506261.git.ionic@ionic.de>
References: <cover.1732506261.git.ionic@ionic.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the infrastructure for registering endpoint-specific data for
endpoint IDs.

Endpoint-specific data can be used to map an endpoint ID to a specific
endpoint backend.

Additional API is introduced as a common header in include/net to allow
other parts of the kernel to query endpoint IDs for endpoint-specific
data or make the QRTR subsystem assign a new endpoint ID for passed
endpoint-specific data. This will allow other systems to register
endpoint IDs before actual socket creation and usage, which in turn
allows proper binding to endpoint IDs from the start.

The endpoint registration function is changed to re-use endpoint IDs
that match the backend's endpoint-specific data if possible, assign a
new endpoint ID if the endpoint-specific data is not known yet, or
create a new endpoint ID without endpoint-specific data attached to it
if all else fails.

There is one gripe with this implementation: other kernel subsystems
can, theoretically, assign an unlimited number of new endpoint IDs and
thus exhaust endpoint ID space. No API is provided to delete endpoint
IDs and we also do not track which endpoint IDs are in use and which are
not, which means that even the QRTR-internal code cannot easily clean up
unused endpoint IDs. The only exception to this are endpoint IDs
attached to QRTR nodes, which will be deleted when the QRTR nodes
themselves are deleted.

This is probably a potential memory leak that we can live with.

Fixing that is rather difficult. We would either have to add some form
of refcounting, wrap the endpoint-specific data pointer into yet another
structure together with a kref and use that to free unused endpoint IDs,
or periodically clean unused endpoint IDs up in a timer (executing, say,
every 10 minutes), essentially doing garbage collection.

Garbage collection is being frowned upon, especially in the kernel, but
in this case, it really would make the most sense. Clients might
allocate endpoint IDs that are never actually used (for instance because
the client uses a wrong endpoint-specific data pointer, which is not
used by a QRTR backend), and will need to hold a reference to this for
their entire life time, which essentially defeats the concept of
cleanup of unused endpoint IDs via reference counting.

Clients can create endpoint IDs quite some time before the QRTR
subsystem uses them, but there is no way to easily tell when this will
be. The idea is that minutes as orders of magnitude would probably be a
safe value for which to regard an endpoint ID as unused.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Depends-on: 25a7151cdc98 ("net: qrtr: ns: support multiple endpoints")
Link: https://patch.msgid.link/20241018181842.1368394-1-denkenz@gmail.com
---
 MAINTAINERS        |   1 +
 include/net/qrtr.h |  11 ++++
 net/qrtr/af_qrtr.c | 124 +++++++++++++++++++++++++++++++++++++++++++--
 net/qrtr/qrtr.h    |   5 ++
 4 files changed, 138 insertions(+), 3 deletions(-)
 create mode 100644 include/net/qrtr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b9344c3524..6993067c4194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19115,6 +19115,7 @@ QUALCOMM IPC ROUTER (QRTR) DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	include/net/qrtr.h
 F:	include/trace/events/qrtr.h
 F:	include/uapi/linux/qrtr.h
 F:	net/qrtr/
diff --git a/include/net/qrtr.h b/include/net/qrtr.h
new file mode 100644
index 000000000000..799c84eb35ad
--- /dev/null
+++ b/include/net/qrtr.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __NET_QRTR_H
+#define __NET_QRTR_H
+
+#include <linux/types.h>
+
+int qrtr_endpoint_id_get(const void *data, u32 *id);
+int qrtr_endpoint_id_assign(void *data, u32 *id);
+int qrtr_endpoint_id_get_or_assign(void *data, u32 *id);
+
+#endif	/* __NET_QRTR_H */
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index cf8b5483ba2c..59227b3d49f4 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 
 #include <net/sock.h>
+#include <net/qrtr.h>
 
 #include "qrtr.h"
 
@@ -649,6 +650,114 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
 	return skb;
 }
 
+/**
+ * qrtr_endpoint_id_get() - get a registered endpoint for given data
+ * @data: endpoint-specific data to fetch ID for
+ * @id: pointer to store endpoint ID into
+ * Return: 0 on success, negative error code on failure
+ *
+ * The endpoint-specific data must not be NULL.
+ * The output parameter id must not be NULL.
+ * If no endpoint ID can be mapped to the endpoint-specific data, id will be
+ * set to 0.
+ */
+int qrtr_endpoint_id_get(const void *data, u32 *id)
+{
+	unsigned long idx = 0;
+	void *iter_data = NULL;
+
+	if (!id)
+		return -EINVAL;
+
+	if (!data)
+		return -EINVAL;
+
+	*id = 0;
+	rcu_read_lock();
+	xa_for_each_range(&qrtr_endpoints, idx, iter_data,
+			  QRTR_ENDPOINT_RANGE.min, QRTR_ENDPOINT_RANGE.max) {
+		if (iter_data == data) {
+			*id = idx;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qrtr_endpoint_id_get);
+
+/**
+ * qrtr_endpoint_id_assign() - assigns a new endpoint ID for given data
+ * @data: endpoint-specific data to assign new ID for
+ * @id: pointer to store endpoint ID into
+ * Return: 0 on success, negative error code on failure
+ *
+ * The endpoint-specific data must not be NULL.
+ * The output parameter id must not be NULL.
+ * On error, id will be set to 0.
+ */
+int qrtr_endpoint_id_assign(void *data, u32 *id)
+{
+	int rc = 0;
+
+	if (!id)
+		return -EINVAL;
+
+	if (!data)
+		return -EINVAL;
+
+	rc = xa_alloc_cyclic(&qrtr_endpoints, id, data, QRTR_ENDPOINT_RANGE,
+			     &next_endpoint_id, GFP_KERNEL);
+	if (rc)
+		*id = 0;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qrtr_endpoint_id_assign);
+
+/**
+ * qrtr_endpoint_id_get_or_assign() - gets or assigns endpoint ID for data
+ * @data: endpoint-specific data to assign new ID for
+ * @id: pointer to store endpoint ID into
+ * Return: positive on success, negative error code on failure
+ *
+ * The endpoint-specific data must not be NULL.
+ *
+ * If the endpoint-specific data is already registered to an endpoint ID, this
+ * ID will be assigned to id. Otherwise, this function assigns a new
+ * endpoint ID and associates it with the given endpoint-specific data.
+ *
+ * The output parameter id must not be NULL. It will either be set to the
+ * fetched or newly assigned endpoint ID on success, or set to 0 on error.
+ */
+int qrtr_endpoint_id_get_or_assign(void *data, u32 *id)
+{
+	int rc = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!id)
+		return -EINVAL;
+
+	rc = qrtr_endpoint_id_get(data, id);
+
+	if (rc) {
+		*id = 0;
+		return rc;
+	}
+
+	if (!*id)
+		rc = qrtr_endpoint_id_assign(data, id);
+
+	if (rc)
+		*id = 0;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qrtr_endpoint_id_get_or_assign);
+
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -670,9 +779,18 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	if (!node)
 		return -ENOMEM;
 
-	rc = xa_alloc_cyclic(&qrtr_endpoints, &endpoint_id, NULL,
-			     QRTR_ENDPOINT_RANGE, &next_endpoint_id,
-			     GFP_KERNEL);
+	rc = qrtr_endpoint_id_get_or_assign(ep->endpoint_data, &endpoint_id);
+
+	/*
+	 * The previous function fails if ep->endpoint_data is NULL, so retry.
+	 *
+	 * We're going to assign an endpoint ID without endpoint-specific data
+	 * set in this case.
+	 */
+	if (rc)
+		rc = xa_alloc_cyclic(&qrtr_endpoints, &endpoint_id, NULL,
+				     QRTR_ENDPOINT_RANGE, &next_endpoint_id,
+				     GFP_KERNEL);
 
 	if (rc < 0)
 		goto free_node;
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index b4f50336ae75..3509168e8a40 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -12,13 +12,18 @@ struct sk_buff;
 /**
  * struct qrtr_endpoint - endpoint handle
  * @xmit: Callback for outgoing packets
+ * @endpoint_data: endpoint-specific data pointer, can be NULL
  *
  * The socket buffer passed to the xmit function becomes owned by the endpoint
  * driver.  As such, when the driver is done with the buffer, it should
  * call kfree_skb() on failure, or consume_skb() on success.
+ *
+ * If endpoint_data is NULL, endpoint IDs can not be directly mapped to a
+ * specific endpoint.
  */
 struct qrtr_endpoint {
 	int (*xmit)(struct qrtr_endpoint *ep, struct sk_buff *skb);
+	void *endpoint_data;
 	/* private: not for endpoint use */
 	struct qrtr_node *node;
 	u32 id;
-- 
2.45.2


