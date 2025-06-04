Return-Path: <linux-wireless+bounces-23711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74A4ACE0A4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0376E188BAEE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1620291867;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPpZExvU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177228F51B;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048349; cv=none; b=jnNlG+dgR80RHmJHASYyLaN78M+f0EKDXRWdHuZ1+n4ivseVqLBgws+sduaCfX2sa+wZOPRCu0pJaI6Bd7XZYtLfuTdQNOsrUELiQhZwFPutpuqizNoRXU9RXO8wf6DUPHOYgzfbV7s8joSKYAvixGQCDHbUWcej+dP9s4TThGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048349; c=relaxed/simple;
	bh=y9HygGfhYvQ4+bq3qESNXQX/H9b1zgxy9prCNKq4TX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpNYrHnbp2VTl/EH4vWaFWosPm76l9b75Z4wiKsoYh70D1TH2witewKTx9xLRMePcqAVzW+F5QIeO14b2y+itQ20X33xj61CtWzDmR2ZxKYTm/MxjcalydzTJYztx1zL7xUl09eI7GzCcgFlNRwZxU6LOPBJ/4ibuBNNwRJ7Xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPpZExvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC2FC4AF09;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749048349;
	bh=y9HygGfhYvQ4+bq3qESNXQX/H9b1zgxy9prCNKq4TX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPpZExvUaF9XWORXR5+H4kYbKMlp+Y50XA50lzLec3PlOtXC82GB9RDeYBgpvzW95
	 djGdlXdHZNz1qHAkRPmLpKSjbfegSpqZUdzytcZFQBiFERWt/rl+N7D8ziivuqpuZm
	 mWigyDPy7k1Kt5eIdvobRbb0o8V9wBeI/JFGgYQjfkUekVtGJS2pMMtMz/FGdG+f/j
	 qidmwuHJXXXQe5sRXyXQ/FX0u/3dCgUva2EIliy3FdYgaR7xMBR42BMlfi4fFXsjC5
	 W95dApUrxlqtIWHi6h3oJo1qVYs9nibizMWPjH2z1SWxBgchzNunZs6/kdMeSRL3qC
	 8EPZUv1AK1itA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpND-000000007Oa-1Apm;
	Wed, 04 Jun 2025 16:45:47 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 2/4] wifi: ath12k: use plain access for descriptor length
Date: Wed,  4 Jun 2025 16:45:07 +0200
Message-ID: <20250604144509.28374-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604144509.28374-1-johan+linaro@kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read memory barrier added by commit 6b67d2cf14ea ("wifi: ath12k: fix
ring-buffer corruption") is enough to guarantee ordering also for plain
descriptor accesses if the length helper is ever inlined so drop the
unnecessary READ_ONCE().

Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 9eea13ed5565..8615578bb802 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1962,7 +1962,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
 {
 	u32 len;
 
-	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
+	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 
 	return len;
-- 
2.49.0


