Return-Path: <linux-wireless+bounces-22495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BBAAA274
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D55A5A2E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E02DA848;
	Mon,  5 May 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXTha2ZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D12DA844;
	Mon,  5 May 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483687; cv=none; b=BGn3DYW7vYBpY7PBcr/Ml3b2gBsz93LdQHRM6EiEWQJTmy1XOkHq8JvGy76/z1TCHjPjVMDOl6jMfZN/zrXIjsel7QkY1DKjAWZSCEbfKMn9n+9tdtGP1n2mjgXQJ08+gDahpAZh8Ym/sWN+LGxi7CTCPP3UydQPyk1g+UkNDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483687; c=relaxed/simple;
	bh=r3JPFWvIK9HUC6BvgN3MKDbXMRoiugzxyCxpdrQgPZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+WANdgiKLvGFD04OA67AgZYGdMWMMxXnv76xFYyBtUZgYA6tEE9E7r2EOV1bicIAdo6Y2C3m5WEKQcen8fLiY19fGyIc2RLtiyE1aVetlsekhEGe6uSj33moAW97q6gSZzixm38rtPz0ga7pGOaMUjUBcgqIM3D6DelfejAe80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXTha2ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C41C4CEED;
	Mon,  5 May 2025 22:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483687;
	bh=r3JPFWvIK9HUC6BvgN3MKDbXMRoiugzxyCxpdrQgPZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXTha2ZFR+gpBL/9kzdWBCqWEZD85Fe2pHvIaUyOZhAXDfIKEIZikMfwRQ37mvd3p
	 nyP9SNVdxPXepbXb5DpEudwm9pqqDeXFKjDtRWEj5OT9HwEL2g7OrhoTxsMVoYtgLw
	 b6dS0+fb/3NdLIggCsCJAYZJC3YxumNBXwb9e/OIjqnYlFDYzLdeA6jkezM2mxssmV
	 aXUlNnUorc91gbOehjwenCY8vCj9+4JapZ95kz0xMpNDNvh2cparpHmDIp7DLsbuqm
	 uGOev8MO8LFsqwikSi2gKhgjzJczdlwDxFsnOAqK+D/UahtZJuCpBaTnpBgZugsw8e
	 mwVHeDHOStLEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 181/642] wifi: iwlwifi: don't warn when if there is a FW error
Date: Mon,  5 May 2025 18:06:37 -0400
Message-Id: <20250505221419.2672473-181-sashal@kernel.org>
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
index 47854a36413e1..0ab6b2cfbcbdc 100644
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
@@ -641,6 +641,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_tx);
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


