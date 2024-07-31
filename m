Return-Path: <linux-wireless+bounces-10774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D4943B62
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7211C20C7D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314E183CA9;
	Thu,  1 Aug 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhjiY4+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33C171092;
	Thu,  1 Aug 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471272; cv=none; b=uhQCPPiBVlsZ7YyIHkBkloZE8C0Qo7k+qhE6mrRKosaUj8cJYgB6VvgM/BX/3WaFIhVU98htk30BTCLZjpVySJF+SH9ch4ztt0f2hJZBCimwDOXWyVsNmRJ4aURiVmA+d9qBCHatIV/ZD4ZOCLATI48YcOVbzfONFKG/lAcYLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471272; c=relaxed/simple;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO2MlZbvytk/AtEaJPb+jDWf1jB8yB0M2ewwns+7e4usdcYwZqaaKS4IpqBmKLS0av1P5JsTfFqWojRAbQr5OvgBrCX7aDfVNIe6QHI26QEc7jGS7vRYVgOCIbdF+8ehEANg6cYx2dQhitRtO/tOo1h6pEFRKxPgQUcuNyMfRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhjiY4+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D72C116B1;
	Thu,  1 Aug 2024 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471271;
	bh=5HkpZF+C9dwJjcFENfmNhps01cjNjs3wQgezjJIbfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhjiY4+laKCMTM2Ot1UwmvkX/Mww5rl4ZAncTYALcMVR019MA5tEiZTRSbam91UMq
	 qUjr53zc7CG5wwXM/zOCLLlkxi29wsSjw7zgfkxz8AA5DoYWK9B2NEqT3bzV0YtchF
	 vG03BXA6YR476VhNkW7iIPu3ljQEAu/P+W/yD7w/n6V5FwY9HSBM6XW2twajWttAvo
	 GtCdgQDrnqfgj6a0sGVFoQydt00WnNBsXwIUA0BjrAUGEhbknSKpqCpivlzQgFbIc0
	 MQyQGteW/n1jeZNPRWOrV9JmmgY4ZG40/8WjO0lF5L3Xw7rKyoWp+hCzbwjtWk1gQS
	 du8oMinVrRxGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 052/121] wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
Date: Wed, 31 Jul 2024 19:59:50 -0400
Message-ID: <20240801000834.3930818-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


