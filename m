Return-Path: <linux-wireless+bounces-10785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E8943D36
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D3E1F23099
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEA1AFE57;
	Thu,  1 Aug 2024 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv6MbvrT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF421AFE51;
	Thu,  1 Aug 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471851; cv=none; b=G/sph47R/vGWV8xt1a1WmbmXcrcX0+YDrbmUks9Xj/RTeGY9rO8Awd1l6sFYXHYwUkLBlR6sbp15BwG3EMThN4ScinwLLjlxcqVsQVIgeY+o6nZ3XyCB1LynWv3JKKChKqplaWEwJ3LykKn/yETv8rAZIH3umY73Jz9S53afqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471851; c=relaxed/simple;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHEpg0P8GCerIgZEJYZ11gteiz7201ul+g388If8Bo/vAwtH4i3/Wq9K7PSaYk08Rv6NkckkKz6c/oXhy1PHkx8HGx6qJkJHR6EOifZyjsVJpv6dll3QwfwqdqJPWmSs1gcKU17Zz//IxIY0eYHj5C2a1Z3snNSkwJJf4C94PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv6MbvrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F1BC116B1;
	Thu,  1 Aug 2024 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471850;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uv6MbvrTofCEPZhhChNFXv/EZevib8P5XYzYX4g8zGSxFcC/k+6v4tlUAeCTpXK7b
	 DFuVe5SKF+VdNBaao2mTt8jrJErTgKPn2PAjLWjz4ajofvcmU3f3hkiAH6ZgZFFeV+
	 lGOs8g4cn4K+bhls4B1oEiIwUMKIBXVcVqzLHsVXc5R4+ySLXth8QgZVcaHcatyNjk
	 hjMhhpEbyZfOeN/2JyFF8plsv1FIbERNSMEU58QXJLzRRd/TTJ+Zy3JwvON6YVPiEC
	 mxEw5sL2cLB4yxH6aVo/lTf7HGXdjRCRnv9QrxMNfFsSg+pMmHI6MJ3A3u9Af6qKBL
	 AFM7zs0HC6NBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 36/83] wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
Date: Wed, 31 Jul 2024 20:17:51 -0400
Message-ID: <20240801002107.3934037-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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


