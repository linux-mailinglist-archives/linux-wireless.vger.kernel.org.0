Return-Path: <linux-wireless+bounces-22561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF8AAA9C5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9C11890607
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8036C015;
	Mon,  5 May 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6NJ/pbv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C13579DB;
	Mon,  5 May 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485069; cv=none; b=GDP4aZbq2xRFbQhG0CGoTutKU3PuxuvQxnJ4wj5g247AtWPsYAR+yDkqlZagVUG5mJiFaDTsTPopu9FZEyiwbzV4qDWparS9ygp6fYLjUVtWovQx0hLNH0UuzbeVmBLMYdNLvLQh8XmNU0ZOCdt+bMNwwiwapbgSb5Du40VWYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485069; c=relaxed/simple;
	bh=X7mvAEXiufGLwIN8vKIGxEHKcLOLXKFaRRbGbw+bFgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6v5VWPQpX7R3cKjiAmZZOjH2dwGu9h0h79cjenAPkP2O19JGftJK+oy67P80taw7lhS4wErpQUQzhD1sh6kkTU5Mk5Gtao5hsC5+ifN6TEqpbr5NiZZ3v/nObDBt7zypv0I1uEE92mvV+VPeEOojyrtQA5o0jVB+N5KF792w44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6NJ/pbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F6BC4CEE4;
	Mon,  5 May 2025 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485068;
	bh=X7mvAEXiufGLwIN8vKIGxEHKcLOLXKFaRRbGbw+bFgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6NJ/pbv6ls569/LYf8/SS5tZtM5aShRfXfqIM97nWsP/HAxX5lk2qGE7cifsUqyc
	 4dexnd1VLQVqjMLmkImwtS2nuPuu2rfNsiWhCE/vO/mj6YW1xyCFT3HriOHHrG9jCD
	 DqMxiAJavz3LuGNmDSHMbyJxamNIf6K/JD97jj0q75SmlvYSGXtU1T1fylEFMOt3xL
	 NQLnuQk1IWSb6mRW0v2LGcGoK0pM/nC/KUxkIl00zidvhYA3TtS5r88rEnrURXNZTc
	 a1e5rk9aNyIMwhsiZOQAbmVVLq5z9oLo/yovXG3NHvM5SrKbK4MBFdHhtSCG2g6D6a
	 4zRfwr7lm01PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	somashekhar.puttagangaiah@intel.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 150/486] wifi: iwlwifi: mark Br device not integrated
Date: Mon,  5 May 2025 18:33:46 -0400
Message-Id: <20250505223922.2682012-150-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


