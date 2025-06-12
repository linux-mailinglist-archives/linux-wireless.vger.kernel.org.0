Return-Path: <linux-wireless+bounces-24058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B83AD6F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4371BC4E9F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AEE239E8B;
	Thu, 12 Jun 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmW4w0Kf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AA231825
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728962; cv=none; b=fKSNupMKeN6KK1SwapkdNFJKVF3dTXO4PGQ5H0KhuO7rEQMLLLpqvAhajMHO6imRgbakCSDozkiC7tuPBC7tshpkKk+YRKTG8KB/woFuHMEyZjy0i0S0baU2kTf0A0BvUySyRzLxSUhUyW0FJfWs63KsQkpH/oYBFPxN3uOXLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728962; c=relaxed/simple;
	bh=DfJ7ydQOXiwg936MX/3lo+ODXSqxviJ30Kp1uOiNaBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQnA6dxw8YnMydZssolaeNbVH/6vmQ0uEtXymj8b5jHKHl52sk8OtzrkRFAQ/wlrrjMZpoHTD2bH+9pK8uujQh0UPU6KmahMuAzfZgjFblHFs2bGNCEeOTbRxu76JTGE6eoAFrT//W8+/kAUzYh4NXAsr4DP1Iextk57lqJXjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmW4w0Kf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728962; x=1781264962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DfJ7ydQOXiwg936MX/3lo+ODXSqxviJ30Kp1uOiNaBo=;
  b=LmW4w0Kf/DS28eWMsvD3xJrGrJmBwTogSHWBvE3gii9pcgRoCiCo/0E9
   mMIUa1HAmdQ6fW8oZWLicPjalv5Pkj5CEsKxA9/hI3UxX3RBZvtKvp+3G
   R1qmZUheuKbHf9eyv3Akr/QjqnwWIo5uG44dfxvvhM6awU7ekQ6q2v6Ix
   kCoQIq0nqvFsR4NvJ1u/yb9MkUN0I415Fda0GclHCQzszxQGq02szzii+
   e/XEfuDrY61E3d+8HZItMUoUEaYG8S9CFpDB+UQnLgLGfUShy5DQnVMnN
   4EUp9lKzfc/ekQ0zFcVb1btPGw4xR3z5b/kbEDeVo6e/pSevlCTYZTpxS
   Q==;
X-CSE-ConnectionGUID: jvYEuLqNRoWbSN6fjD5f0g==
X-CSE-MsgGUID: VtB6ZRQRTaq9xECHwgLJlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248328"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248328"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:22 -0700
X-CSE-ConnectionGUID: kkpOKY/yRbydvj0mYJ/pUw==
X-CSE-MsgGUID: ng/4afEATTKCFUkzM+7WEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/13] wifi: iwlwifi: mld: use the correct struct size for tracing
Date: Thu, 12 Jun 2025 14:48:50 +0300
Message-Id: <20250612144708.688d95d99ff3.Id3055ca6c19cf8c821cbbd80c09ca2a21d9acec7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

For the iwlmld driver the RX command is using struct iwl_rx_mpdu_desc
and not the much older struct iwl_rx_mpdu_res_start. Adjust the value of
rx_mpdu_cmd_hdr_size accordingly so that the trace data is correct.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 103912c4e4cc..73bb32ec8076 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -356,7 +356,7 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 	trans->conf.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
 	trans->conf.rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
-	trans->conf.rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
+	trans->conf.rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_desc);
 	trans->conf.wide_cmd_header = true;
 
 	iwl_trans_op_mode_enter(trans, op_mode);
-- 
2.34.1


