Return-Path: <linux-wireless+bounces-15673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC39D7AA1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6E52823F5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19E157E9F;
	Mon, 25 Nov 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="f4lEPPq6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8445003;
	Mon, 25 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507225; cv=none; b=Uu0JQn6aIJ5zQ40pnEihVbhlRcXPSogqHmoMLAq8ZATmLeVt+mbQs7Lh0YGxWzMTNmJdW6LKJ96m4IlUqnpeDAty4jFnAiww+bq7Zd525sEXgCajnMxK+bAn8Alxgjb2aNpML0UtDSo0GLWO6CEsxek7bFZKAGmUWQdidqxtISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507225; c=relaxed/simple;
	bh=3yCjE5tdSxEAWWiNtIYYOrdwsDaWqbpFW99BaTLk7HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7hPEckKJViq7iyqUyMVPES8AsUGofUNvBaBV642QfuUHy/veceN3m9EOcn2aG/kPxZ9ggupY6leCGyfJJJCXOM06DMcGVDe9GeWLlta9bAOviBIRn+9haPIFwmnzx19J0SP8Y6TnKIdo4n/PmYWF73UKxL7Xtpule2oaksZw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=f4lEPPq6; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506708; bh=3yCjE5tdSxEAWWiNtIYYOrdwsDaWqbpFW99BaTLk7HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4lEPPq6yN01kQf4+fKAw0YTENFTPo/MlDnzIcFrF0d4czSDRBLx96AgcpwMaMMGc
	 gMSQcKXSNZ3Eed7ETl5vXX+GcQZMcRS/wO2L/JONzHyrqwQVUBB9HpzAfmwY6VT6Qh
	 zhACAhvk/LrEBF6BN/quVmICVol2t4OytK1VT/hk=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id DD3981487FB2;
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
Subject: [RFC] [PATCH v2 02/13] net: qrtr: mhi: register mhi_controller as endpoint-specific data
Date: Mon, 25 Nov 2024 04:50:17 +0100
Message-ID: <90e0394bfd97d28853d17e9c62b6e372b236b760.1732506261.git.ionic@ionic.de>
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

For the MHI backend, we will use the mhi_controller pointer as the
endpoint-specific data.

This means that we can only have one endpoint ID per MHI controller, but
since the MHI controller is the bus master in charge of the physical
link, this is probably okay.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 net/qrtr/mhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 9a23c888e234..fc6869c3a7ec 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -95,6 +95,7 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	qdev->mhi_dev = mhi_dev;
 	qdev->dev = &mhi_dev->dev;
 	qdev->ep.xmit = qcom_mhi_qrtr_send;
+	qdev->ep.endpoint_data = mhi_dev->mhi_cntrl;
 
 	dev_set_drvdata(&mhi_dev->dev, qdev);
 	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
-- 
2.45.2


