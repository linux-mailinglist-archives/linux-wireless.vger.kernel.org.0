Return-Path: <linux-wireless+bounces-22521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16DCAAA693
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79EC1669A9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE8329D12;
	Mon,  5 May 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEg84qEn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41A329D0C;
	Mon,  5 May 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484494; cv=none; b=mFYtPb13cSCqhHtN2X+cLnHdGo7WTWroMJHgkrxzyFDVkJUcpxPCd4ALV/WGgL/sHMeiPqBW1Rjme0cKxv18EjoWI2jJ0sNvja4gfC53tVZRG46enF5z3CErrfIQuN/6W8foPD47vqaqsX8b7eeYxWNrqrcM4Db4whUg7lrVLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484494; c=relaxed/simple;
	bh=sqCRRX5se34m6d3XsYR9wyca+/LOv0PL2t1VKF+e8lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JEA/I5ndH/tAE4o+ShdsA9u2pti2CKJQ7HwaTxoSc33bU67gwV2EwOYvlEnklzw1ynbwuyjE8nzA7+Ck9ZMb/6RiOvYlS925LOGaBEjeB9wfG+w4eRwK6a7RSFO/ujlMHCbI5sC2w8MlTb5JSGA+tCvw5Tv6683xqePgrcxT7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEg84qEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF7C4CEE4;
	Mon,  5 May 2025 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484494;
	bh=sqCRRX5se34m6d3XsYR9wyca+/LOv0PL2t1VKF+e8lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEg84qEnXpQ4o4DVjxNcQPRUBmwIU+15GCSj6YFJmU6Z6ELsvxuuMX4t28f6Ax+UM
	 5UFaQ4RRjHhVEBI+68S1oksFxfDYEtHjkPIbrdP1IlChX3P2G63LSHgjp9hmYY0Zdh
	 dJwnaxgR4ICXcFthjl8pvPfmJvtPTeC65FJQ9atqVC9LyKZTsgo0Cr8FuY5RNswxlc
	 UkaPtZMvXe4glX5eH4WE+Js5/Z9yBleJIn3SMsFmoaaEjzipbXhMM2cXY9Fq+127R7
	 N6VOLPdd8tzzRqCU1UljzZOjhmASo5zWq4iFPDloR9ReELNLUYicm6rgNnjXnnRdjG
	 5vqH2YcFhwwZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	daniel.gabay@intel.com,
	emmanuel.grumbach@intel.com,
	yedidya.ben.shimol@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 499/642] wifi: iwlwifi: use correct IMR dump variable
Date: Mon,  5 May 2025 18:11:55 -0400
Message-Id: <20250505221419.2672473-499-sashal@kernel.org>
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


