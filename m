Return-Path: <linux-wireless+bounces-24183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A4ADC53D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635761894194
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123D290098;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA08Rkge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4928FFD0;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149890; cv=none; b=Z4kUbXw3zHzfgMueCsb/we0v+AvSrakcChQwEboxxRPDN5Q1LI4i1pnA12wSkZPMwVyq5GG6vOr7vp9FvCRzS0j+QG3+NtIVUUmI5ohVpsGrlEcPrgFTADyzh04qx9RlwK4hgLuQyKLxDc6XqaB1L4stv6rUFrYcjKBgrKdp9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149890; c=relaxed/simple;
	bh=8TdcpNaOAnT6sQbogFZJL8X+FGsz3jK1CDvlMPWZFoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFpayIs3EFGWszsNGYojsOJ60ZVX6CeBfX+0lBmrcUaCMJFvnwCzYNCspuHQ9EBMUcfbu9TobSq0h3zZ4iDmppc78Q/oQpTaNZfqFjSan1fW9FQN1wyYG9zFH4f/VWj+i6+C55OCBRVVhJcqbGmWDqc8t3Hq8N9gsRE39hYeGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA08Rkge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ACEC4CEE3;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149890;
	bh=8TdcpNaOAnT6sQbogFZJL8X+FGsz3jK1CDvlMPWZFoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA08Rkge3dARox3RhosuJBCQhyuXL73DtBFR3JKG1io9kPU4kmY9e+fK+fdx8DeLJ
	 ihcyrRGQ1+pDICNQlSmd+KhRLUrJkdUmC/D7YPJ8FbtGTnHPq3RKcKMgV9rvmwxjRv
	 JFIrjMbkNFmjJk9pm6atz42lj+kK2da4V2fJQMGPf1O6u2LhQ8vBVdLT2WFyd0nvcG
	 h/ZEKNFlYqaZxzJQr6wJiE57x6s63die96wD/04R6nGkik921gExhH8XHxl7mdrQK6
	 CIbkTaeDi3YBdzZCBb/y90r0KW+X63eDjPXO93Ee5keCOasoeQsfFBcM/vrr/80bHn
	 e77S5uLxAG24A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uRRw0-000000003mp-0YYK;
	Tue, 17 Jun 2025 10:44:48 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 2/4] wifi: ath12k: use plain access for descriptor length
Date: Tue, 17 Jun 2025 10:44:00 +0200
Message-ID: <20250617084402.14475-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617084402.14475-1-johan+linaro@kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
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
index f8bd3837b9dc..726969cfcaec 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1950,7 +1950,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
 {
 	u32 len;
 
-	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
+	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
 
 	return len;
-- 
2.49.0


