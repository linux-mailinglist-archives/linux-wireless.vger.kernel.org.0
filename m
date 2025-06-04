Return-Path: <linux-wireless+bounces-23704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC13ACE06B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA1516C2B1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B622290DAC;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdBENElc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33722290D96;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047772; cv=none; b=Nvm423kg31OEuUTbGtIsiXkdT9A6fiu4JGXjrMtWVKvIEHdOjzidf8XZclcjyrEiweMJDoO+O+OxyunSpxNMRDsCwArMOMsJdwAJe+aoSCpOg/6ha9JiyBEo6DuIor6k5BtwLoGBUB+nSztcr6hRec/8NsUYXMYTjbu3a1f2ODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047772; c=relaxed/simple;
	bh=/zzi6edlAiK18uDL8yHhaQ7i1Hb+UhqE68J4prJl4Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsZ0wyneg4u5eHudkH/y2fNMdJgYyb1zF6hUi3EDqj46iUiFuiDHXgv5caZ71UmNd7D4MBH5ejTm9g/NmAzGe0dAyeBDAUsjas2dd24yy35WnfTh/Qmpy89Ezz9Tws4BSpKgOtgucBISDjtztgwPdUTkSbFERM3JAwNGQ4y9peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdBENElc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB22BC4CEE7;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047771;
	bh=/zzi6edlAiK18uDL8yHhaQ7i1Hb+UhqE68J4prJl4Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdBENElcS8mRW39RzMtwzygdmcDwxPfh6UUJ7n5r6Dteh2mdRalIvLpn1XjoGw0yx
	 MP4KwJ+tcd/6z1Kk64pnImRMJ5dqyo0NR9u2CrmFRx3gq4h37QPShCsc6eH2DVrqD5
	 U3JfpI6e4cs7Lw76MRQZLSGd1+BDVrZfDuOVBpt653pN3nNIpoZXSPKjl2+MkXTnsw
	 /ZfoTSqzxs9ffrX722j0GIrjUwr6tpMMhSjbuVPLIW+WJEyCfAHiQRKyC/cla/5HYh
	 AiAoR1v3vXNz+6IwNdyAfOPbBqE+DA/30TVG4ML8ToqgSUXLKp4/lXMIaWf6+B+Uak
	 SQ+Tq3wvzXbQA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpDt-000000006nK-2oE5;
	Wed, 04 Jun 2025 16:36:09 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 2/5] wifi: ath11k: use plain access for descriptor length
Date: Wed,  4 Jun 2025 16:34:54 +0200
Message-ID: <20250604143457.26032-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604143457.26032-1-johan+linaro@kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
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

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 921114686ba3..b1f5a927dddd 100644
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


