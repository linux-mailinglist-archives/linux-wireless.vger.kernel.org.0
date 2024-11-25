Return-Path: <linux-wireless+bounces-15670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA69D7A99
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591A4B21C17
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE60762E0;
	Mon, 25 Nov 2024 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="Q2dlXsmY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F112B9A8;
	Mon, 25 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507224; cv=none; b=U58N04u3XTXULvf1BwDsRgbMS+0HupETB3G1baMK7PxQjSsGzuulAideIke7XZuhcR4n75Vg3AcvxBrKCOOzSHxWBiUhhc9UcPY/LhjV1GYTK4oO1TLPccYymrYbHZA72JY5VkjX8Ap1fNgsWxQLvauMc2BEskF/yy82Pi/57OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507224; c=relaxed/simple;
	bh=WaJt0MbfiLuCLmsPYGY3mx15UPFsO9CVWdVbdNYCpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrIrfzZ0IQEfFZP74fcZcSbYnG88xi72weMgurTnKSDz7u4TVCaUb8amooQK4LlgmlALnjPv0h+TFAyon+Gis+SkrUMSmCZ+s34uv8h8pggwxqjRO5KH6kCV1DCUNaMJbebpUdCvf2YBX7LRBVVel3ZzCbHoSEUhXmn44Kk45ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=Q2dlXsmY; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506708; bh=WaJt0MbfiLuCLmsPYGY3mx15UPFsO9CVWdVbdNYCpxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2dlXsmYZNtjt+BaM/dXnrvh/kDHw8Xwzol01zB9m94ZFaQ2M88DmD4bE137cK/Sz
	 /6rKf6Aia2xOF3UQj3AKKTAy8kL8XLTkFvCbp9xLRo2s+RtOhnBzOYsglpLi6FjCkP
	 TfaNUhiDUBZK1NCjhJbiiTVVtyh80ZmXNeJoHIgw=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id 6BD2314886FD;
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
Subject: [RFC] [PATCH v2 04/13] net: qrtr: tun: register inode as endpoint-specific data
Date: Mon, 25 Nov 2024 04:50:19 +0100
Message-ID: <c9644b9d169c22ccaed87b186ecca0bfc08129b0.1732506261.git.ionic@ionic.de>
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

For the TUN backend, we will use the inode pointer as the
endpoint-specific data.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 net/qrtr/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/tun.c b/net/qrtr/tun.c
index 304b41fea5ab..9dcfecd529f7 100644
--- a/net/qrtr/tun.c
+++ b/net/qrtr/tun.c
@@ -41,6 +41,7 @@ static int qrtr_tun_open(struct inode *inode, struct file *filp)
 	init_waitqueue_head(&tun->readq);
 
 	tun->ep.xmit = qrtr_tun_send;
+	tun->ep.endpoint_data = inode;
 
 	filp->private_data = tun;
 
-- 
2.45.2


