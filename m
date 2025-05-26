Return-Path: <linux-wireless+bounces-23429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B5AC3EF3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE95F3B5158
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059971FA14E;
	Mon, 26 May 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDoL/kKK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAB1F8ADD;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260336; cv=none; b=DUIAhkwqm4l8gb3VEKCkGuAntvpAZBvoOERsrQ6rkfaHywhE+yICm7JKTYDaOCc4fLcrOp5Jnk8aOC5YvvPkInHoNbmQe+DL4VTTaq63cDUOXOt4tXVDZSiUxqCRWW7I87XabeQX8j5jEYnaD+U/b4Tnw7mSJ4XmdrmWRvfmgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260336; c=relaxed/simple;
	bh=m/OPqTtOeOWGN0cjMWn0CbNb8uPAv1c+dguTeasO26A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YismrGv/mqw6Wk0Fn3iQ8G8ZsR8ona7jqcOZPOAOCU/kRWpfaLfFGsDvfX9E8eEgK+sJ1KKeJ7E+q+1FX9wHrqFngWhbS/Hwzz1O9R4RHRVZThDEq8ZEnUK59cwC5zesyWRkO2QyXrZ40jJiZJ3Af+FD0pggf3GQmTxJvHhdmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDoL/kKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34DC4CEE9;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260336;
	bh=m/OPqTtOeOWGN0cjMWn0CbNb8uPAv1c+dguTeasO26A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDoL/kKKaSk9jl3zUPXAyhGbkth+ySalJ+cLkSgCVOQu1TIsK4btml/Xtl3SunHfd
	 BPuvVTG1m4unmBGKsfSoFpOxSI1ddjqcB/oyUBaRJQjXN/KDpA/Scd5uUdh01+A+ko
	 tUBMkrVPPVHz/21W70lBgvMu8Z8WMRhPiIblJXQdefwUs19mYV1vnWb6ajAkn/Ihkt
	 HjlVa63ASsR1/lnGo4bYB3cQRiA3rVP9T5wX7pZSzjJ6v0+sAhPt49f5BVfwsJHtnM
	 V7dJVgR4xludzUG/HvdM60YvYPeungx0ok1hvMS6jFPclrZKxPIj/pp/4djzBCOzEn
	 JawGvZHhFp02Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWNO-000000000fI-054Q;
	Mon, 26 May 2025 13:52:18 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] wifi: ath12k: use plain access for descriptor length
Date: Mon, 26 May 2025 13:51:37 +0200
Message-ID: <20250526115137.2490-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526115137.2490-1-johan+linaro@kernel.org>
References: <20250526115137.2490-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 91d5126ca149..962111c66a3e 100644
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


