Return-Path: <linux-wireless+bounces-19867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90526A547BD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92DF16DFEC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDA1FFC70;
	Thu,  6 Mar 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0yYTMRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB620408A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256765; cv=none; b=LIVISZkdi4nmrD9UtsuluOPo+Q2UogNtVUF6MH6um29RrcU1vtnsXUD+XjHv1J+3Ho9u/z4EirY/oErojRbv1vJfcQrcqMr/UlOzZkvqyxF1pD9kuOKCOYzyGFJtb6EstKNq0E/Z5AKIo6Csx4PrkRUXmziRgkUyy19Vahuyuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256765; c=relaxed/simple;
	bh=zZeOYL228Ua4pyQqLgM2r/C/r3cEF3n9jCXAxuXQesA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLlvTHdbxDCXzcHVpjEdMQ6C5DVu1D5YmLj9pHO14XpkJoS9Cx1drIVJiWJJ+lR4TjjwMghfq+m2JMnzBsZL5K3zQ4pS8HilJH7iC1/cTNsIE31Oz1dof2hKP9YMq3CN3DRNLKvMpsOT4zb38fig72RpB/h+K/jDwzQqRJPTHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0yYTMRB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256764; x=1772792764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZeOYL228Ua4pyQqLgM2r/C/r3cEF3n9jCXAxuXQesA=;
  b=T0yYTMRBP/XFV8yMHO5nAKvXk92gdjwuVbWgngHCSlbiAneCMUnavS6G
   xM7y20ASj+1EBZIostC1wLQcth/2gWryPWSAumvoHqDsx3Ttt/F/1gBqK
   nQy29N1YSohr61tOUfW3fQCWQQ269PzN+sLtEarxzkRgMSZeNReiyiKpg
   0u/L1IEPf3HlXLB8oinCbXY5dhNx9x6BUjAE2RLx0EY6b6omqZxw5BFq2
   a+0WyRypH9VrfqCidcmVFfDI9FJFNq3Kx2Bgs3qiIVhCLVE3B1qBmpf0S
   2R75Uv6df+bR2DFaY+URTgjqKhR9gcxYeGp4uSl/D7rlup3WAisR93oSS
   g==;
X-CSE-ConnectionGUID: BLU0f/khRN2MISB4t8q5Jg==
X-CSE-MsgGUID: p02dT5SDTia4jtp8eXWNdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41433446"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41433446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:04 -0800
X-CSE-ConnectionGUID: gSM5WS3zQumBuq9Jg93Peg==
X-CSE-MsgGUID: IYiuHx/MQa6JxnAUL+T/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142209572"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 3/3] wifi: iwlwifi: trans: cancel restart work on op mode leave
Date: Thu,  6 Mar 2025 12:25:48 +0200
Message-Id: <20250306122425.801301ba1b8b.I6f6143f550b6335b699920c5d4b2b78449607a96@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
References: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If the restart work happens to run after the opmode left
(i.e. called iwl_trans_op_mode_leave), then the opmode memory (including
its mutex) is likely to be freed already, and trans->opmode is NULL.

Although the hw is stopped in that stage, which means that this restart
got aborted (i.e. STATUS_RESET_PENDING will be cleared),
it still can access trans->opmode (NULL pointer dereference)
or the opmodes memory (which is freed).

Fix this by canceling the restart wk in iwl_trans_op_mode_leave.
Also make sure that the restart wk is really aborted.

Fixes: 7391b2a4f7db ("wifi: iwlwifi: rework firmware error handling")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 49c8507d1a6b..47854a36413e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -403,6 +403,8 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 
 	iwl_trans_pcie_op_mode_leave(trans);
 
+	cancel_work_sync(&trans->restart.wk);
+
 	trans->op_mode = NULL;
 
 	trans->state = IWL_TRANS_NO_FW;
-- 
2.34.1


