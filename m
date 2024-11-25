Return-Path: <linux-wireless+bounces-15672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219D9D7A9F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB335162FED
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E6145B2C;
	Mon, 25 Nov 2024 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="Z6iKAJH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA02AE7F;
	Mon, 25 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507225; cv=none; b=RWLU+cA6Mgya9RspFp5/HY/AhbqvwPYAGHDkt0VrAZ6ipwo0176sEvagzmTaEIytc5r5OtZFhmXKdtpN6YH4IjkyNGgPZuztiOoqO3SfM0ERPop6T5tsvX+GRGHAZQbeS6TQwEwer/DTQkvxv04mwSMHD0CA4e5uhwFbh4Nmaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507225; c=relaxed/simple;
	bh=CcApLCzMROUQU/RunBcPJFusQCj4QXpyFrT2DKnQP7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krjAmOZwkNqfS0dxXQf/Dpd8aB5dFe27kYufXkT0hPbRLEecmTyD3BOowVImxZB9F4pgv5/fTSD5UNz/1eYExNVC0FRvucIQxl8JbrrXUN6xWGNkQ+BD2pOfbTFaK5X7lr+rWR/CW84KklY/TnTwBGyxWRW+cCMva410FDsukBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=Z6iKAJH5; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506708; bh=CcApLCzMROUQU/RunBcPJFusQCj4QXpyFrT2DKnQP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6iKAJH5JsYjx4sr75/4g+0kGMhiOlbPLMXkjy/593ut3Vv9MlfrTHweTGOyyKuVx
	 a7l3hJfWA+3Vu3SQvc1L2CDnRxjAcWmHMe06c6vMEicH+eItRog4Dq2fJCuW9V7s5+
	 qxFIbLzWWVxmZLKUUJPYoQXvbwcOJYueiNdmGegA=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id 28705148839C;
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
Subject: [RFC] [PATCH v2 03/13] net: qrtr: smd: register rpmsg_device as endpoint-specific data
Date: Mon, 25 Nov 2024 04:50:18 +0100
Message-ID: <aa1aa32b42c0d052c907b53e8dae4877e63b2b2f.1732506261.git.ionic@ionic.de>
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

For the SMD backend, we will use the rpmsg_device pointer as the
endpoint-specific data.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 net/qrtr/smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
index c91bf030fbc7..cb3eeb6835ca 100644
--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -68,6 +68,7 @@ static int qcom_smd_qrtr_probe(struct rpmsg_device *rpdev)
 	qdev->channel = rpdev->ept;
 	qdev->dev = &rpdev->dev;
 	qdev->ep.xmit = qcom_smd_qrtr_send;
+	qdev->ep.endpoint_data = rpdev;
 
 	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
 	if (rc)
-- 
2.45.2


