Return-Path: <linux-wireless+bounces-22616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0CAAB1BE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5757AC091
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD841B773;
	Tue,  6 May 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE8/7yPM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAC2D3FBB;
	Mon,  5 May 2025 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485617; cv=none; b=c/m6hFrNPl440e0ldxN3t53WsWptN2+fvyKqk4WkYE2b0QoPADTI5mm5sN7Q4N4d1to1MfCjRtpWJYua+x/yIYgR20PRl48opS2qUuHY0+qTkbLiPMIqCfVF/U5omtRpyhinK5kVcGvCC0+u15l+ze1EenN74xdSBBTyB3PcLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485617; c=relaxed/simple;
	bh=sqCRRX5se34m6d3XsYR9wyca+/LOv0PL2t1VKF+e8lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8XsdEATAREOMXA27NIMP6I98pFhNAaen+bnQRnru6cUbFyZlRsME/tUrwJlbGq/vuFBNWGoOltfJry95Cw+lCITRI1iUaIwp4gZfZ2sEsScqjkOjDyLYRDvs/Vsb8AwB6bdIap+gCbFzQ2Pa6K7Tl2qz/KCkgavTxxHEKmPqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE8/7yPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F81EC4CEED;
	Mon,  5 May 2025 22:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485616;
	bh=sqCRRX5se34m6d3XsYR9wyca+/LOv0PL2t1VKF+e8lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE8/7yPMByzoWkz7Rr+BvbcboPreaguHYqF9E7mCyO60dQjCyPiGlHAwPxDZ6ctc5
	 frno309cxiXF15w9+sWg4l2QKtDVs6aCZQCxaa4UuJ1za5G4Oyw70hu0f0/JHu6EfK
	 OFVonUAtEH0lrQfWXBD73Xoe1yRvnYRi1l6x9IfS3A3tKPUazDku+049QsGl6H4mB5
	 7HNlAbzuTgkGpMG9A897t/ZZe/usnfRrI2TMVNkTRaqmlsqXAUX1XDcjdlrgfWVxmK
	 GakfIiIWK/Nx1ErhAUvRB0jNQ+M0ekZlD0raVnTVK1N9xrR3Cakbk2Ka9oXtcJMW2t
	 y9xFaaWC9b/KA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	eilon.rinat@intel.com,
	emmanuel.grumbach@intel.com,
	daniel.gabay@intel.com,
	yedidya.ben.shimol@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 388/486] wifi: iwlwifi: use correct IMR dump variable
Date: Mon,  5 May 2025 18:37:44 -0400
Message-Id: <20250505223922.2682012-388-sashal@kernel.org>
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

[ Upstream commit 21e4d29ac0def546d57bacebe4a51cbed1209b03 ]

We shouldn't dump the reg_data here which dumps the last
entry again, it should use the imr_reg_data.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205145347.3313b18667d1.Iaa9ab66b1d397912a573525e060d39ea01b29d19@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6594216f873c4..cd284767ff4ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -2691,7 +2691,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	}
 	/* collect DRAM_IMR region in the last */
 	if (imr_reg_data.reg_tlv)
-		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
+		size += iwl_dump_ini_mem(fwrt, list, &imr_reg_data,
 					 &iwl_dump_ini_region_ops[IWL_FW_INI_REGION_DRAM_IMR]);
 
 	if (size) {
-- 
2.39.5


