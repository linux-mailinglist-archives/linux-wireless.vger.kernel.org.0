Return-Path: <linux-wireless+bounces-31060-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVdKAXpcWkONAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31060-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:08:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785E643C1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD15E5A71
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AA1DF759;
	Thu, 22 Jan 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="LjpozjHQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50F234973;
	Thu, 22 Jan 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072396; cv=none; b=WCBgpeL43sRZr75/rFjqODQb8Yi7FKQGLCx5yVgFGb1zogQpjqOtUiEnnTpQofn2S9VHiVAOAD2e+PMpjjYxN1PlwlQ8Pd8LfWzqg/u1TeBjL2kjBwhSDMdDEPuVpEsdxq3DNDoHmMn3sd7zSiYhLHM4lzryhPqIebszPRj8yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072396; c=relaxed/simple;
	bh=TNsykdaONIIlR4eNt2LJ+0FYYb8J/mUn4gf9mTQzgzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PyuuXGwH9DoQ5V/227guEBDydw45vmZtuW+PKTVnHi8RMLyKPMmgXeAigosrVxqYRLBNdEAO/WYMEUNkJOQNqIYBHlbGFhKu9jiRrNMmG4CNfl034Ce+dundsDH1iEd967+AyadpiJINtpczf+avpxKBeb8my0JGcoF4F/cXRqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LjpozjHQ; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319367b75;
	Thu, 22 Jan 2026 16:59:49 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: chunkeey@googlemail.com
Cc: johannes.berg@intel.com,
	quic_rdevanat@quicinc.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v3] wifi: p54: Fix memory leak in p54_beacon_update()
Date: Thu, 22 Jan 2026 08:59:45 +0000
Message-Id: <20260122085945.444955-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be4ee6ba903a1kunm3e47c58f33e96
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxoaVkJCSksfSB0eHkIfHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=LjpozjHQaDPGWgygp3qJp+INiTqVRx0qI2hVpnTJDkK0FDFBkUrMrO1N+gQKe+QjTB0c8OgdKgQEo8FqCWdU0WcDOw4LUijQLl0qCtpiKwMJbD3Zi0/hQqyDE6EjM1sU7fqBaasQOpSlto2gkEdChYL0HHhAFrcD6O9CL7HP1rg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=oJHAU9mEp9hQIpogoLK30SuGJmBW+Htm38AfsOYxi78=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31060-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: 4785E643C1
X-Rspamd-Action: no action

In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
If p54_beacon_format_ie_tim() fails, the function returns immediately
without freeing the allocated beacon skb, which would lead to a memory
leak.

Since no other references to this memory exist, it must be freed locally
before returning the error. Fix this by freeing the buffer using
dev_kfree_skb_any() in the error path.

Note that this error path is unreachable in practice because mac80211
guarantees a minimum TIM length of 4 bytes for non-S1G devices. This
change primarily serves to silence static analysis warnings and keep
the error handling logic complete.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v3:
- Add a note in the commit message about the code path being unreachable
  in practice.
- Remove the Fixes tag as the issue is theoretical and unreachable.

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


