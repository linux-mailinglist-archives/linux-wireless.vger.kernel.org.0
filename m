Return-Path: <linux-wireless+bounces-24316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC5AE311A
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 19:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEB1886A39
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB317A31C;
	Sun, 22 Jun 2025 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HQ3DevQQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186C2AD04;
	Sun, 22 Jun 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613297; cv=none; b=T3Crvv4xgmtn/WL7K29tGRv4LbUPRSY9YPFvROkbMBtnEsivAsHrmr6c3AqoN4PuTCwvBc98wvUGZ3pHn1Js5/7kFaRKyhedEgygjgST3wSb45/4IZX/WQNdbjrjtilxja7JSLYMr2m7fzikVp/nO5pDT6OFwH8/4yEzq9dP734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613297; c=relaxed/simple;
	bh=TCnQAAzzLH7O4iCqF6yCTq2u5GqVeGTsWMO0xFfJdCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDiijyHJxZn4fTC3YvRmKxYZ8/eehOs2E8NKURsdfhusqvIqK7jwv3aqNffHIRjuQMqh3POiDTjqEnNhqVv05ED3KuCZRT97H/WzzQ4J8mZsCrLpRn0pUL1kcI/s/qyzmU67L42O+WVMAd5b/VpatSPXMWPwZ7jjk+rHJBGPBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HQ3DevQQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=I6Gl5KdztgTkU55kZiEyEzJ35KNEfQDaCOV4YsrI3WQ=; b=HQ3DevQQo9kvpf+t
	ptp0M6LGQGxJIBk4s8gEOAshqKQDN3LsfVMxc7weDprX/HVRwsBNeu69hBIel/jwgBvW0xpqIj05C
	h4cui75N12Ekz3SWymR4YVc0cbfzxJ21DKRWmngwPmqn/sCo4+4lK+VRiR500m23BuzOtApPpS9tu
	YNrxa+QAYdJfxovWJ2jnydOYlZzC1QicrSfPC9Tbwxa7/pq+s1dTG0hGfpyPAsitH/jlAjMdmySHk
	lDBVyqKm0rwys/Cjtw4LqqepSamRajDG/qpC8AWbp4MspKnuZ9Ir4qju7ujOr0C+z/OXZEzpKfkPe
	S6cY/N1WFPHITbm0LA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uTOUA-00B7p5-2Q;
	Sun, 22 Jun 2025 17:28:06 +0000
From: linux@treblig.org
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] wl1251: Remove unused wl1251_acx_rate_policies
Date: Sun, 22 Jun 2025 18:28:03 +0100
Message-ID: <20250622172804.116396-2-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622172804.116396-1-linux@treblig.org>
References: <20250622172804.116396-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

wl1251_acx_rate_policies() was added in 2009 by
commit 0e71bb084adc ("wl1251: remove wl1251_ops")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/ti/wl1251/acx.c | 35 ----------------------------
 drivers/net/wireless/ti/wl1251/acx.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/acx.c b/drivers/net/wireless/ti/wl1251/acx.c
index f78fc3880423..cb8b3102fa6c 100644
--- a/drivers/net/wireless/ti/wl1251/acx.c
+++ b/drivers/net/wireless/ti/wl1251/acx.c
@@ -832,41 +832,6 @@ int wl1251_acx_statistics(struct wl1251 *wl, struct acx_statistics *stats)
 	return 0;
 }
 
-int wl1251_acx_rate_policies(struct wl1251 *wl)
-{
-	struct acx_rate_policy *acx;
-	int ret = 0;
-
-	wl1251_debug(DEBUG_ACX, "acx rate policies");
-
-	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
-	if (!acx)
-		return -ENOMEM;
-
-	/* configure one default (one-size-fits-all) rate class */
-	acx->rate_class_cnt = 2;
-	acx->rate_class[0].enabled_rates = ACX_RATE_MASK_UNSPECIFIED;
-	acx->rate_class[0].short_retry_limit = ACX_RATE_RETRY_LIMIT;
-	acx->rate_class[0].long_retry_limit = ACX_RATE_RETRY_LIMIT;
-	acx->rate_class[0].aflags = 0;
-
-	/* no-retry rate class */
-	acx->rate_class[1].enabled_rates = ACX_RATE_MASK_UNSPECIFIED;
-	acx->rate_class[1].short_retry_limit = 0;
-	acx->rate_class[1].long_retry_limit = 0;
-	acx->rate_class[1].aflags = 0;
-
-	ret = wl1251_cmd_configure(wl, ACX_RATE_POLICY, acx, sizeof(*acx));
-	if (ret < 0) {
-		wl1251_warning("Setting of rate policies failed: %d", ret);
-		goto out;
-	}
-
-out:
-	kfree(acx);
-	return ret;
-}
-
 int wl1251_acx_mem_cfg(struct wl1251 *wl)
 {
 	struct wl1251_acx_config_memory *mem_conf;
diff --git a/drivers/net/wireless/ti/wl1251/acx.h b/drivers/net/wireless/ti/wl1251/acx.h
index af5ec7f12231..efe1f61f89bc 100644
--- a/drivers/net/wireless/ti/wl1251/acx.h
+++ b/drivers/net/wireless/ti/wl1251/acx.h
@@ -1469,7 +1469,6 @@ int wl1251_acx_cts_protect(struct wl1251 *wl,
 			    enum acx_ctsprotect_type ctsprotect);
 int wl1251_acx_statistics(struct wl1251 *wl, struct acx_statistics *stats);
 int wl1251_acx_tsf_info(struct wl1251 *wl, u64 *mactime);
-int wl1251_acx_rate_policies(struct wl1251 *wl);
 int wl1251_acx_mem_cfg(struct wl1251 *wl);
 int wl1251_acx_wr_tbtt_and_dtim(struct wl1251 *wl, u16 tbtt, u8 dtim);
 int wl1251_acx_bet_enable(struct wl1251 *wl, enum wl1251_acx_bet_mode mode,
-- 
2.49.0


