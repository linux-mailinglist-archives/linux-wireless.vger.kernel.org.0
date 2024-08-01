Return-Path: <linux-wireless+bounces-10792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF7943EB0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 03:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A12DB2C0A3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 01:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D691940BE;
	Thu,  1 Aug 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bszhs9Ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C065192B79;
	Thu,  1 Aug 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472209; cv=none; b=DfUVHGp+XcIEMDgiPHHvlfCUWcvATvnjt08I/l8eJdavTRr3xuqSAYVnZP66+QWxW7oT2JOYJDpT1Z0AqYbZkPuMHTdJ7FPiGAfMjCNlO8EGcTTPWVqIp7gOTZqywQeuxrVpyPRGvt1j0dStXny/fgqVuACvniJCv8RXYkmsMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472209; c=relaxed/simple;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZqTx3V6y2/2Q1bbGFZok9d/Vurw5THH9BLhZY7w+tAtTg4RGUMKLkE4tKkg53qoLpOwwglpnbckhkYMGM8hOg/Ko0suvWDRMSFDb6ogj9TfITfISRnK7ad3SxTpBnrz9cDFGhh+cJZZknajtR+XCyKUxA4zWbj9ldFB4BOZxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bszhs9Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23982C4AF0C;
	Thu,  1 Aug 2024 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472209;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bszhs9IpqCOm7+kM+Ju5MWbj+66wCujzRzzELJxDXTcZxLIERYnHRupDHhC3obJlH
	 Mj5AZVKR9svQIvK9AAw/nF5lnKFL11hfUXmxcloL/LU4Ww1QtxVAvGoo5/sEAh3POJ
	 e9/RTSExT+O5qAu8ERdXoWh+mqJHXFsQFaLnxB65dVqFiJFmwF62GQRne1Tuh9hUlF
	 y1/U+/oRbjXErd7YUkzMcjZMZQ/D/AK6h8xjEELGoTidwmH2yLW4WtVlfeEmfBCfZ7
	 CRLFv058Vp12df4cTchm73obgnTcNokTCHJBT1gefTj2xFvjSrXaZaA5AdpIqYJEUI
	 d+eyI12iYOxcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 27/61] wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
Date: Wed, 31 Jul 2024 20:25:45 -0400
Message-ID: <20240801002803.3935985-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 6ccfc7c49b6d99e3b857afb064e56a004b0a5e03 ]

In practice, iwl_trans_get_rxq_dma_data() will not fail,
it only can do that if called with the wrong arguments.
But it does have an error value and doesn't initialize
the argument when it fails, so don't use the value then.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240512072733.faf3a1b87589.I77c950173cb914676fbd28483e5ef420bb9f1bc9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 135bd48bfe9fa..d8b083be5b6b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2021, 2024 Intel Corporation
  */
 #include "iwl-drv.h"
 #include "runtime.h"
@@ -135,7 +135,9 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 		struct iwl_trans_rxq_dma_data data;
 
 		cmd->data[i].q_num = i + 1;
-		iwl_trans_get_rxq_dma_data(fwrt->trans, i + 1, &data);
+		ret = iwl_trans_get_rxq_dma_data(fwrt->trans, i + 1, &data);
+		if (ret)
+			goto out;
 
 		cmd->data[i].fr_bd_cb = cpu_to_le64(data.fr_bd_cb);
 		cmd->data[i].urbd_stts_wrptr =
@@ -149,6 +151,7 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 
 	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
 
+out:
 	kfree(cmd);
 
 	if (ret)
-- 
2.43.0


