Return-Path: <linux-wireless+bounces-15662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCED49D7A76
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BABD16290E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF134AEE0;
	Mon, 25 Nov 2024 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="fOuCpeqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22290EAC7;
	Mon, 25 Nov 2024 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732506719; cv=none; b=fEe3AFAvVSHRRMeibut706tJlI0sivt39n60SU88PEkQXi8C10/fL5OPq1TE3IIPHFGtxJgKjO2D4gcc/0EfsaELG1n10W70xK3keS5D6hF9v04OVg3RAuWhr6/KXPaIPSrROOJGKKRdeqcAWKiHOUBZL9WfVnqjTK6C1qmqWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732506719; c=relaxed/simple;
	bh=UyuABPlzyiqkE23T62xlQISSVDBGgpm7/N5AP3n04ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNMaPrXobqe7dKecTup92lF890FZG+iTWKLt9wugKkBXav7Rc26RJUnr4fo5ocxb+U7agUlnpp84F5wdX6KCEF00qR60EfnSO3LCzZ4bh1YEqBolzbgA9gIRca5sVUO9b30ePktBzLs12DC4X2fkYxmf8lBmQChz9bHuxERj4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=fOuCpeqV; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506709; bh=UyuABPlzyiqkE23T62xlQISSVDBGgpm7/N5AP3n04ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOuCpeqVtL5FKsBHcNc5N1UebrdiEJ/+F/uQBttmoTfpS2aWt829DskHdXSpCT3F2
	 HE/XTHZiYaBx4sqRacNewnMz13cYiptrM27eeUfN6BXk3nFa6yqAAboLRwxjI319n5
	 YuGzb30QQIxQdjZ9+GI+urwnqtgv1ogHNrtmOG5c=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id F028314886FF;
	Mon, 25 Nov 2024 04:51:48 +0100 (CET)
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
Subject: [RFC] [PATCH v2 06/13] soc: qcom: qmi_helpers: optionally bind to QRTR endpoint ID in qmi_sock_create
Date: Mon, 25 Nov 2024 04:50:21 +0100
Message-ID: <cdf0dfb31a80ba20e24686b19f8ffd9aa0996063.1732506261.git.ionic@ionic.de>
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

For clients that already know the QRTR endpoint ID before actually
creating the QMI socket and set it in struct qmi_handle, optionally try
to bind to this QRTR endpoint ID when creating the socket.

This can fail, and qmi_sock_create will issue diagnostic messages, but
otherwise ignore the error.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 drivers/soc/qcom/qmi_interface.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index bb98b06e87f8..dd3978682c09 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -586,6 +586,7 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
 				      struct sockaddr_qrtr *sq)
 {
 	struct socket *sock;
+	const struct proto_ops *ops = NULL;
 	int ret;
 
 	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
@@ -593,6 +594,33 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	ops = READ_ONCE(sock->ops);
+
+	if (!ops) {
+		pr_warn("sock->ops not available for QMI socket\n");
+		pr_warn("will not be able to bind to endpoint ID.\n");
+		/* N.B.: this error value will not be passed out. */
+		ret = -ENXIO;
+	}
+
+	if (!ret && !ops->setsockopt) {
+		pr_warn("ops->setsockopt not available for QMI socket\n");
+		pr_warn("will not be able to bind to endpoint ID.\n");
+		/* N.B.: this error value will not be passed out. */
+		ret = -ENXIO;
+	}
+
+	/* Only bind to a specific endpoint if a valid one was provided. */
+	if (!ret && qmi->endpoint_id) {
+		ret = ops->setsockopt(sock, SOL_QRTR, QRTR_BIND_ENDPOINT,
+				      KERNEL_SOCKPTR(&qmi->endpoint_id),
+				      sizeof(qmi->endpoint_id));
+
+		if (ret < 0)
+			pr_warn("binding to QRTR endpoint ID failed: %d\n",
+				ret);
+	}
+
 	ret = kernel_getsockname(sock, (struct sockaddr *)sq);
 	if (ret < 0) {
 		sock_release(sock);
-- 
2.45.2


