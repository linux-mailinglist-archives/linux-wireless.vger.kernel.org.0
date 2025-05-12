Return-Path: <linux-wireless+bounces-22872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42524AB41B4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27571B400F4
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA329A9E3;
	Mon, 12 May 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQskM/ky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185229A9DD;
	Mon, 12 May 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073083; cv=none; b=Z2wQNWJwd6QYi7L7DZMmQTprAMOCuhv7mBpcgjo2rZs28mlomDUjSL1SfRz0hCiYv5OHSBijvEOtBtG/IVNSbzAa7R5dSdxP3iGiAsoWlV/tAoJ2iU7913YxxH5BCGMijMre88RTVId2MHT215uAA5ikkV1mVdunLHG/1AoyToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073083; c=relaxed/simple;
	bh=xb7FF4IAwqMmIelFbryrjSBpRZWqcQ2jQVXTGgKyM5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJRu7G7PBFNDl9fWlPgX9ux2M6f/JfNnBaEOaOhkcULiPAt0oM51wc6EHlaPEzK0Ahn1yNnrcdbZEV51z7yVoh3i6x9nPM960qi9t54jIbZR8xTNQu7YVFIs73sI3gusvAZD6O+UBNARg5xbbaLXTGIAae85WNX4loUvqN5TJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQskM/ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FDC4CEEF;
	Mon, 12 May 2025 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073082;
	bh=xb7FF4IAwqMmIelFbryrjSBpRZWqcQ2jQVXTGgKyM5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQskM/kytyOkI2x9xtaSJkQ83oeXC716Tw1+fdaLnxfEg6IUWxCrAmYk/I+c9YclH
	 mANmC38bIYIzXxkd0Hr62US0jSVVk4ErhnZQNbS+/c7KBteV279Mv4zB4vYGv3CmKJ
	 j1k/9I+Y5miIgmPgZLEMCFGnThOlwrVsaBUYygwuFARRc2vHdwboLOUziu0FMRXDkj
	 Lg0/MSl+5yabkQdhja9gwGBNWqyX9XDmlXMva0RLB6UjRzWAGnGMsXQBXcmk7FTsjG
	 WaW94nkJGnpj+/8MSBjmiBySVQP75uudfGQgdM/l94AreSWURtw21B/XrxO9eS61xF
	 +2NMnkfsS1ipg==
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
Subject: [PATCH AUTOSEL 6.12 07/11] wifi: iwlwifi: add support for Killer on MTL
Date: Mon, 12 May 2025 14:04:22 -0400
Message-Id: <20250512180426.437627-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180426.437627-1-sashal@kernel.org>
References: <20250512180426.437627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.28
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
index 9141ea57abfce..68989d183e82a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -587,6 +587,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma, iwl_ax411_killer_1690s_name),
-- 
2.39.5


