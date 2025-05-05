Return-Path: <linux-wireless+bounces-22608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD43AAB63C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112193A9E2A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81C321AC9;
	Tue,  6 May 2025 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrN+/0QH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD43582CF;
	Mon,  5 May 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485059; cv=none; b=j/AkIsxs4ulSmcRDqFeHR7Bs+noNmSTGF85a7k4ah2bdxinixLJ8e0yIAfgn9KrfxoYPGvZvkf9rmLeS6k85hJHVqu04qtK03suP77PwH5xQcp/rXSo5ck8nEG4ZzuTU7QizbLQChQhaILdv/unVp1/ojEqmIegkTzP/hJ+XaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485059; c=relaxed/simple;
	bh=kI5nWEEnTlXARRUHFz39uPHB0iJlauY5GoyXACNqpNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMnSwy6gshSVxoMSsH8htQZoLznSqp7vEM4VPx5UZBbYD3nVwfdsa3MvdLro8nt5B6Q7GyibeUHNm2H4saVx1SbKGoODZ0nggwxpZNZmZlwVkKNCg6i1/Xiq/ej+g6V5JCOxLBjwM/5HYYy9EzepUkZypp2e7g3AwP/Mwx8AN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrN+/0QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CADBC4CEEE;
	Mon,  5 May 2025 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485058;
	bh=kI5nWEEnTlXARRUHFz39uPHB0iJlauY5GoyXACNqpNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrN+/0QH8q2FEBnD/nS3t7dIJyJHGt1i7T8vxbc71F9IaRMqL6gkAsmOR86UIA2cO
	 ei8ACc34YEATTbJmqGOFrCClCjUqG6lB/UNNZy+RcBGVRArZum1qyWn8jhs3YFGRbP
	 ltyxexhLsWQ+1gMcNLpCyiIjptnGWYZU1WWnCGMi31XqZ/i0QHoRD0WKmR06csR5gN
	 nzGU+ixzXMtXgUkG1JfC9DG5EINY9I2GymCiRgGcjn4rG7r4839BqZAyoLIhmIpssf
	 J1F7XmxAQXVUDYD7n4Xm5iSqyhf/SbfwVMZoWi1heB29sNBftH/UTbEBGxiBwDvhIX
	 V3kTO+n9I603w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 147/486] wifi: iwlwifi: don't warn when if there is a FW error
Date: Mon,  5 May 2025 18:33:43 -0400
Message-Id: <20250505223922.2682012-147-sashal@kernel.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit c7f50d0433a016d43681592836a3d484817bfb34 ]

iwl_trans_reclaim is warning if it is called when the FW is not alive.
But if it is called when there is a pending restart, i.e. after a FW
error, there is no need to warn, instead - return silently.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.ba3d90b22c25.I9332506af1997faefcf0bdb51d98d5e874051722@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 3c9d91496c826..c88e4c20b505f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2019-2021, 2023-2025 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -420,6 +420,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_tx);
 void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
 		       struct sk_buff_head *skbs, bool is_flush)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return;
-- 
2.39.5


