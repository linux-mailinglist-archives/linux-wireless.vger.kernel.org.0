Return-Path: <linux-wireless+bounces-31020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFp9KYlwcGktYAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 07:22:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABE51FEB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 07:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87622669C8E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94942884E;
	Tue, 20 Jan 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bE71EsN8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622C3D648E;
	Tue, 20 Jan 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914122; cv=none; b=Uj+Sz0JlodLgIODy8v3NDs8jo9hVaCS40w8+oKnhIgzLVR6rU0novbPnQ5nHQAI9rgVjbASTILDSFmv10VmiBNOdI1PeagcmbYxhJawmimRPuEDKtkKhZ4KwjmjALjrqrMGsUQovOjwz1c/8RZVMYPzprG5Y0IczD51OeJcM+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914122; c=relaxed/simple;
	bh=ZNAssRtgkcu50hCZlq/bPpfzRaTk3IXveUjfNtOGvQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QcJu5zbcR2EUNSAsN1wiCVHuEL64JdvQnP1FDHDLpakpr8ZkiKcPtdnbQAHps3SqktKOsL/ZCzivzYWYFdiss55Kx9Tqj0WZs2Zy4cZ2HjuTxHLl+weTo5dr+202i7uqcbpCp43JjvdO2OlYBndAazMZtNhFlJUBlAojvoobsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bE71EsN8; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 315033ad9;
	Tue, 20 Jan 2026 21:01:48 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: chunkeey@googlemail.com
Cc: quic_rdevanat@quicinc.com,
	johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] wifi: p54: Fix memory leak in p54_beacon_update()
Date: Tue, 20 Jan 2026 13:01:44 +0000
Message-Id: <20260120130144.2662132-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bdb7f3fa003a1kunm0a90a1732691e8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBhMVhlCSh5DGEoeQx1CGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=bE71EsN8UqWnAD2B3DAdGmT4GN4fxnHAmfbq3pHE+X1aeZAje1yxQbAy6A15ooLbOD9CeYwRumMXm0SoDvaSMhnPo/Jr2LaKT+0yxNrCj4/5BkWMG7wk3hq2jVbs2NSC0zH5kdif9i5untGWMfXrLBdpIbch+ewGyIUrvRhFm00=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PQrz1OkNEDhuyGK4/QK7iCPg8PSJ1wpCLXTGt6r8YAU=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31020-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EFABE51FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
If p54_beacon_format_ie_tim() fails, the function returns immediately
without freeing the allocated beacon skb, leading to a memory leak.

Since no other references to this memory exist, it must be freed locally
before returning the error. Fix this by freeing the buffer using
dev_kfree_skb_any() in the error path.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: e5ea92a7528d ("p54: AP & Ad-hoc testing")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Correct the Fixes tag to point to the commit that introduced this issue.

 drivers/net/wireless/intersil/p54/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 2ec3655f1a9c..57a62108cbc3 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -143,8 +143,10 @@ static int p54_beacon_update(struct p54_common *priv,
 	if (!beacon)
 		return -ENOMEM;
 	ret = p54_beacon_format_ie_tim(beacon);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb_any(beacon);
 		return ret;
+	}
 
 	/*
 	 * During operation, the firmware takes care of beaconing.
-- 
2.34.1


