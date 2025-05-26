Return-Path: <linux-wireless+bounces-23424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8BAC3EDE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F8F3ADBD6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2991F8EF6;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye30ttZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C61F4725;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260104; cv=none; b=TE3BKmp5OnIR9hjwSCMHNTRrVaLPq8ZjBNv28sSgRHWAUsPJmvXKIy7YJNxwo1xjDqka5H+20sSqVDVsXhvgQTbzzegU0iywOb/WMRoCRXWJ5rzNZSS0XJtHgADIhYay1XrSIDCLnssR+N/HoTD2cpvxlfvMWlm+S6QYBkYnG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260104; c=relaxed/simple;
	bh=Z5e7LYUJWrN8Oqgcyb4aHiiFK/LIDVnO1Tn4lc/8a7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx6TqHVwv4UYf6SlhFP1wyvvsDvML7uEvhioVD48EzzX7YVzlUszFrzwRQjfMpnoSB4bQFCqOjwlwrcJxcvWerfKdy7m3Ht9sd3atSXK5eyHMhWP0Yzzuf/sgNZuga2RBuxGG4aOyc3ob3g0tW+ubWtbGj6Wq5vESTJgZM5f3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye30ttZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50FC4CEF3;
	Mon, 26 May 2025 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260103;
	bh=Z5e7LYUJWrN8Oqgcyb4aHiiFK/LIDVnO1Tn4lc/8a7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ye30ttZAMlNo34zgpSRrajqfBM4RbPOWOy6A87yyedXcwhwZ7mpVd59AFImhQJhTo
	 UBmLp43z0ow17lrUxBqfGK4Cf6/rm13cDeWu9wWfUncSU6ZzmP77EaI24KIM1Rzhx4
	 1f/io6bV48+6kFYvZsueZPywJLRLP+gva1yW+oQS0TuvcXxL5sXU2qSxJDrRnp94v5
	 eCQZCWGuV/txZb8XSueafxQx5FK9yRaEofsu8tbwX8p87I80dvcFCBOwZV2PfNlX/5
	 4PugJNjgKi2RueB0IA8QjcVcAcK5oXnqY5hOL1ftnXetSrw0a3YupEDAJgCth2FBzQ
	 xepCCq71VjhQA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWJd-000000000Yu-1hee;
	Mon, 26 May 2025 13:48:25 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] wifi: ath11k: use plain access for descriptor length
Date: Mon, 26 May 2025 13:48:02 +0200
Message-ID: <20250526114803.2122-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526114803.2122-1-johan+linaro@kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read memory barrier added by commit 6d037a372f81 ("wifi: ath11k: fix
ring-buffer corruption") is enough to guarantee ordering also for plain
descriptor accesses if the length helper is ever inlined so drop the
unnecessary READ_ONCE().

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 8cb1505a5a0c..1ea7c494f387 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
 	struct hal_ce_srng_dst_status_desc *desc = buf;
 	u32 len;
 
-	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(desc->flags));
+	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
 	desc->flags &= ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
 
 	return len;
-- 
2.49.0


