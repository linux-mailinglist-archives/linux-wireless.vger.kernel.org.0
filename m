Return-Path: <linux-wireless+bounces-22874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD82AB41FA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A451B60163
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80592BCF79;
	Mon, 12 May 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAoTut6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD52BCF76;
	Mon, 12 May 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073114; cv=none; b=LSCa3jpjYIa01RiMtIWhdRsjbt7GAylUptJzY3bQw921gD2MUZb1etKN/PeiY0TLVq/golVftyt85uAjFM9iyCKLteDM1v042AEqUZbEsOncp5dFC1/XXk1obljyjDYGxZ5NTWNoJJMps9iZsVKOKfPp2MrT40PLd++x5Q+H5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073114; c=relaxed/simple;
	bh=FFlBadYZXJNC+KMlpiluI8jFwmkJwl/fk4NCvJGOB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOoIgY/LWPzSWq0fBz99ZeOGtxgN2AWL9mc3gr43JbJYIVjOIyj0cvYDLKUUlM1fYh/u5nNhGh60Z+OZHJYnFc4zfjTUvVqXQS8VPeSFhoFoEut5SxaByCovpePu9XcoeK7+qBULpzQzEnfJRdIvOCwnVZUPc8OGJU9KwBZDBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAoTut6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B3C4CEE9;
	Mon, 12 May 2025 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073114;
	bh=FFlBadYZXJNC+KMlpiluI8jFwmkJwl/fk4NCvJGOB+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAoTut6g2A1H/T1/V3rqdWHcIX7cnoIoONP1VmHGrxJjC5qH7eo4GXX2TY4CCELzm
	 TiECeUoxrnIrbIBCy5HN8G8Bys0nxE123bja7D+ff3c/nhYyM0Pcd40BbFsie+2GMh
	 0aSPWmx1OjJfuem3Pf3brW5ph0RtW0EvsWtHXzazG3nMpCkV8NiT2IDE3mdpl1XzTW
	 59qPtusH2P9dtjA+Eu4gX1iEV+/6DIFyiC/lz8GGbtHreQ2X5f95k/L+ZMo1kQrkdO
	 Kbwn0cbOPwhGSjWunWUE5vfdvvWjtdeAfuC758jI9tRipZGuCvbhSr2qNlmcfvdFNp
	 SPUfHwtTUoUIA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	somashekhar.puttagangaiah@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/4] wifi: iwlwifi: add support for Killer on MTL
Date: Mon, 12 May 2025 14:05:05 -0400
Message-Id: <20250512180508.437991-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180508.437991-1-sashal@kernel.org>
References: <20250512180508.437991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.138
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ebedf8b7f05b9c886d68d63025db8d1b12343157 ]

For now, we need another entry for these devices, this
will be changed completely for 6.16.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219926
Link: https://patch.msgid.link/20250506214258.2efbdc9e9a82.I31915ec252bd1c74bd53b89a0e214e42a74b6f2e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7f30e6add9933..39ac9d81d10d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -552,6 +552,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),
-- 
2.39.5


