Return-Path: <linux-wireless+bounces-22498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42483AAA276
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B467B0AF8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC723280A55;
	Mon,  5 May 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwM1LZoq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8F280A53;
	Mon,  5 May 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483697; cv=none; b=OcITW8io/tlm/x4kgJMjSKx2C1r71sIfN0WEw7L9htwszlOOYsiSHdd/CKm+NstcC6Qn6+P4NjSYgPBphfpMpFNBPPdTfu9gtKQDfKUpz/FcU4iK5j7k0YexkN9tL4IBd4eYNQks9mTufp1iRO4jPUwpt0lqJgR1wtVQUzq9rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483697; c=relaxed/simple;
	bh=X7mvAEXiufGLwIN8vKIGxEHKcLOLXKFaRRbGbw+bFgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nC9OXvx3xDxWSGZop9q+wbWCr03Pbjtsz4ED9b87oe6X57AK6yHvm4m4AiRivBCaZ+uq3HgK5+xxgYPmNVQN4UTNY2dbF9E6+M9ahgtYTerh1ypFkqGb6ZXFyMG6IoDAYbZ+c9IVXMFmG9U5yQGXf9i1YuC6k5zwq3k0rQus5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwM1LZoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C91C4CEE4;
	Mon,  5 May 2025 22:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483697;
	bh=X7mvAEXiufGLwIN8vKIGxEHKcLOLXKFaRRbGbw+bFgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwM1LZoqdAOIa8VCa97Dkx/ZjPMW8Hz1FNd8/KPfoZQ/W9+wEku0IaFxhE1Fj5Guu
	 ciXuWHzIaZbHkHFynLDOWPXCfHOMtv7SAEIsTM6FwfXNw0Nq6pLdJHZslzWzcRiXIP
	 4HP4jGWiGCI2M7TEql2AIztKNtkcAamh2WX4oFjOUUi8S+NaQ0PBIQgPxDH+8BPYNS
	 6EgweNiQ2179zNcdZo34FJMfpWd5r44/KEq3xmxWSeePgKUOviCMgeCZFfvRGeYyLg
	 VPKoIo/C9DZAFX2qN7YG0aXc/K+6AOwYbtGIpPQa1XSWWO9cbRSTzb2B4CR2cBZnDX
	 Gx1sMVHUn2OPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	somashekhar.puttagangaiah@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 184/642] wifi: iwlwifi: mark Br device not integrated
Date: Mon,  5 May 2025 18:06:40 -0400
Message-Id: <20250505221419.2672473-184-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5f0ab2f35a43773a0dfe1297129a8dbff906b932 ]

This is a discrete device, don't mark it as integrated.
This also means we cannot set the LTR delay.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.9bb69393fcc9.I197129383e5441c8139cbb0e810ae0b71198a37c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index ab7c0f8d54f42..d3542af0f625e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -148,11 +148,9 @@ const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
-	.integrated = true,
 	.umac_prph_offset = 0x300000,
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
 const char iwl_br_name[] = "Intel(R) TBD Br device";
-- 
2.39.5


