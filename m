Return-Path: <linux-wireless+bounces-23863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A2AD256D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D418816D3C4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759D21D581;
	Mon,  9 Jun 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fewsclRr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72A21D3C5
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493314; cv=none; b=BeSxcKj0ID7gvyM/NF2Uygy/b7s2+DSo5Q1cJG11p9rQ3zN1ijL6Rt1HNQ201rP6PD2QUu2bpo3R78VA0jMvdx9pmgWtqSutKraSG4+pD0nx+0l2qYt/U180YGp/MPmwzeIQgpGOpwdVZPjEwZdgP/SYJmThXY1hMV9gzGLPRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493314; c=relaxed/simple;
	bh=Mwrt7RVuYb0ao+O7vsqss8yMr48BWvDHYKonNy5/Z7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gH/7dygGJTZGAYMFqyXmq87VyLa6xyeO2+HYtR0neZ3zOngM0oup0qcSqdfSOIOPHhLbwjfKt8pz1SPKfaIpCS4b/wtDzpHx+2v/dMefOcm6FdS1ruu9J3r6ZoFYGbcOMIi4cqMayTbC/JN3m7EgizsjYKndj81dK9LkOig+seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fewsclRr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493313; x=1781029313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mwrt7RVuYb0ao+O7vsqss8yMr48BWvDHYKonNy5/Z7g=;
  b=fewsclRrcXQQUaM29EmDzy1Az1c7BiphizAxZz5vAL2hnMTokvQ427lC
   XMOh0zGe508GG1gn0suuFhbjurRxsHUiJrqcH099lswe5tFltQJd+H2Ww
   pL9zCPLpsw5mJhhs2wNaEUQZ5qItb4fki+nB0DGasp7hY8FTBCA01NCZp
   s2KDs/6vao7mYOzkiMWHpj5g/E8WuMfNNbYcAUY/0dVH9nKUhYHVbHKvI
   XDHhJxEt1vYnfA6WOA12gxIUZ9FF5n0UPuRsNjvHii2nacNUhQNKpMb8m
   kPelzrSPimYkJV+KDUlmA4cVxBoUl5Yhrq7ak65720b9NexthsF2WZRZr
   Q==;
X-CSE-ConnectionGUID: gu5l1Ud5ThGGlJUVPfSNzA==
X-CSE-MsgGUID: ouCR+FQxQBKZDVh9RAirMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237673"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237673"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:52 -0700
X-CSE-ConnectionGUID: xJMPC4oYQbKD+cnDdavx+g==
X-CSE-MsgGUID: L9PfQ8nTSIeFOLJDodmJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510257"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: pcie: add missing TOP reset code
Date: Mon,  9 Jun 2025 21:21:10 +0300
Message-Id: <20250609211928.3f84eb03cc00.If138ceeb8bb178b3931d96b537f746346227e681@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The TOP reset requires code to handle the interrupt, which had
been in my patch at some point, but clearly got lost. As the
test had been running on the wrong hardware and failing due to
that, we missed this. Add the missing code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index f0405eddc367..fefde167c41b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1852,7 +1852,12 @@ static void iwl_trans_pcie_handle_reset_interrupt(struct iwl_trans *trans)
 		}
 		fallthrough;
 	case CSR_IPC_STATE_RESET_TOP_READY:
-		/* FIXME: handle this case when requesting TOP reset */
+		if (trans_pcie->fw_reset_state == FW_RESET_TOP_REQUESTED) {
+			IWL_DEBUG_ISR(trans, "TOP Reset continues\n");
+			trans_pcie->fw_reset_state = FW_RESET_OK;
+			wake_up(&trans_pcie->fw_reset_waitq);
+			break;
+		}
 		fallthrough;
 	case CSR_IPC_STATE_RESET_NONE:
 		IWL_FW_CHECK_FAILED(trans,
-- 
2.34.1


