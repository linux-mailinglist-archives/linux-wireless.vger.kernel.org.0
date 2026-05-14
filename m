Return-Path: <linux-wireless+bounces-36404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLxnGhpVBWqAVAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 06:52:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B653DC36
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 06:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC94E3036E58
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 04:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F33B6C08;
	Thu, 14 May 2026 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2uVGaxQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00145376494;
	Thu, 14 May 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734360; cv=none; b=Uq9dF4j8TblCphKvvnJzLEXWkhg3Y06yFXlUIer2J7fJvjOQj7PkvLmgRg2frPfJxhv51mDKRn82SWgZ8X2s/b90nwkmXZmry4s3rq3sqV0ozeryfCoC0vi/q4tttrHO+/XeNT1wqntdS0W9Tq9l1B43NKY/llIOWF7mb6iHMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734360; c=relaxed/simple;
	bh=1/zpOikpu7K01PFdOF+RYE+bOzqD7AJ/p59qRdvBRdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LCELRQJBSkziyKogruiqSbMwkUOF+eFXF11qDvKyptKbDgpfsvgnuOyqB8nhNM9IuCiawNZuo0emF0yoc6fd+zsuhALZqM2F3jqmq8/tgr5/ieqyWigU9Arho7eo8QEDhI/FC1UpNZh06bC0lcnEbKRlDEZcZdpMwu7RbNLjn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2uVGaxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F549C2BCC6;
	Thu, 14 May 2026 04:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734359;
	bh=1/zpOikpu7K01PFdOF+RYE+bOzqD7AJ/p59qRdvBRdY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=d2uVGaxQpijiXiMuKBTxIv86TxKo55rB2XvRqVmT3BL3DnHpmD0j33fGJP0PZXrF2
	 dZK3DVAgFlZesU0W4RVI7VaX6JQj1Zo5RBW0pcs6ySEYezLBy4atLj3xeBeCPSAyQp
	 2hw1grMUwU0O6LUF/2ioo5FWXuKIiMP66lZnrDmziswxS8lI7rYflOXlD5BEcEOy+x
	 K9ixJg955NfYbdsoOkL7ZMiPeczwzBDDgc6sRfp7JIPSe7tT3w8g1M+bP8G3azreth
	 0XB9B/SIOTcC2QcDVGRs5OZwQgS3pc18ZPmwwLMltqbftu30QfJ0voxVX4IW+wwmpN
	 FhRzLPmbFb3oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89428CD4F39;
	Thu, 14 May 2026 04:52:39 +0000 (UTC)
From: Kyle Farnung via B4 Relay <devnull+kfarnung.gmail.com@kernel.org>
Date: Wed, 13 May 2026 21:52:12 -0700
Subject: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NywrCQAwAf6XkbGCzUl+/Ih5im7ahkpZkFaH03
 128zVxmNghxlYBbs4HLR0MXq0KHBrqJbRTUvjrklE+ppSPOA7u9bUQuE9GM4ZW7l7DjuqgVcYz
 CRfBK/YWf6SytZKi51WXQ7391f+z7D53Sk4N6AAAA
X-Change-ID: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5e2
To: Jeff Johnson <jjohnson@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, santiagorr@riseup.net, stable@vger.kernel.org, 
 Kyle Farnung <kfarnung@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778734359; l=3434;
 i=kfarnung@gmail.com; s=20260330; h=from:subject:message-id;
 bh=XJuJhNZPkZzqwmUgFybWgxjzGDftVSfNEsebbvGwSDA=;
 b=uj7RAdlKe6Dq/MwIimfTIXag4PerG+bL1bff/qD6gwXGRjbtWzbh36slDaJOSLak3IznIwRpm
 ar/zYfA0NsxAGXHHHBc4Xm9CJt9sATCa6ej8etG2xVD+0f9x5qdbc0l
X-Developer-Key: i=kfarnung@gmail.com; a=ed25519;
 pk=47jis5OdLKFgZynNQVqkx1mTGiEgFTUX+MecmG9rbmE=
X-Endpoint-Received: by B4 Relay for kfarnung@gmail.com/20260330 with
 auth_id=706
X-Original-From: Kyle Farnung <kfarnung@gmail.com>
Reply-To: kfarnung@gmail.com
X-Rspamd-Queue-Id: D88B653DC36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36404-lists,linux-wireless=lfdr.de,kfarnung.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.infradead.org,riseup.net,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kfarnung@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Kyle Farnung <kfarnung@gmail.com>

LMAC rings reuse the shared rdp/wrp pointer buffers without going
through the normal SRNG hw-init path that zeros non-LMAC ring
pointers. After restart, ath11k_hal_srng_clear() can therefore hand
stale hp/tp state from the previous firmware instance back to the new
one.

Clear the shared pointer buffers while keeping the allocations in
place so restart still avoids reallocating SRNG DMA memory, but starts
with fresh ring-pointer state.

Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
---
This patch is the result of investigating suspend/resume failures on a
Lenovo ThinkPad P14s Gen 5 AMD with ath11k.

I originally proposed extending the existing ath11k PM quirk for this
platform, but after discussion in [1] and bisection the issue appears to
be a regression introduced by [2]. There is also a parallel report in [3]
that appears consistent with the same root cause. This patch keeps the
intended no-reallocation behavior from that change, but clears the
preserved shared SRNG pointer state so restart begins from a clean state.

Testing so far has been limited to local suspend/resume cycling on the
affected system. The issue was originally reproduced on v7.0.4, and the
patch was also built and tested on top of ath-current with repeated
suspend/resume cycles on a Lenovo ThinkPad P14s Gen 5 AMD.

[1] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
[2] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1132343
---
 drivers/net/wireless/ath/ath11k/hal.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index e821e5a62c1c0..0c0aeb803018e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1387,14 +1387,21 @@ EXPORT_SYMBOL(ath11k_hal_srng_deinit);
 
 void ath11k_hal_srng_clear(struct ath11k_base *ab)
 {
-	/* No need to memset rdp and wrp memory since each individual
-	 * segment would get cleared in ath11k_hal_srng_src_hw_init()
-	 * and ath11k_hal_srng_dst_hw_init().
+	/* Preserve the shared pointer buffers, but clear the previous
+	 * firmware instance's hp/tp state before handing them back to FW.
+	 * LMAC rings reuse this shared memory without going through the
+	 * normal SRNG hw-init path that zeros non-LMAC ring pointers.
 	 */
 	memset(ab->hal.srng_list, 0,
 	       sizeof(ab->hal.srng_list));
 	memset(ab->hal.shadow_reg_addr, 0,
 	       sizeof(ab->hal.shadow_reg_addr));
+	if (ab->hal.rdp.vaddr)
+		memset(ab->hal.rdp.vaddr, 0,
+		       sizeof(*ab->hal.rdp.vaddr) * HAL_SRNG_RING_ID_MAX);
+	if (ab->hal.wrp.vaddr)
+		memset(ab->hal.wrp.vaddr, 0,
+		       sizeof(*ab->hal.wrp.vaddr) * HAL_SRNG_NUM_LMAC_RINGS);
 	ab->hal.avail_blk_resource = 0;
 	ab->hal.current_blk_index = 0;
 	ab->hal.num_shadow_reg_configured = 0;

---
base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784
change-id: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5e2

Best regards,
-- 
Kyle Farnung <kfarnung@gmail.com>



