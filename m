Return-Path: <linux-wireless+bounces-22266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA61AA4C6A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D38C18973E4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BA25D8EC;
	Wed, 30 Apr 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoiO9L5F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035812609D3
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017872; cv=none; b=Aww4ZpSMQqKFHGrrTxVAzjQuJMcN74bkMiYqWXLLoma20nHQZTx72S4RB9l0BO1Qp9lya7ZvBhNqQDoZzjQOk7kIzSTp/Fv90CrsetX7ZAZHbhKCuxhyUKHS7bPrqgbnRNln8W7vzIq3AkO3Eg2SXOAsflon52UHLoR4r8+x9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017872; c=relaxed/simple;
	bh=dfuHT7cVwsYZ2eDnunf2jGG0bed38156J++uRmqK0J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmzpPmFAfggNEVAocLlMgj5SGIto1WrLwjhOYAF9GxLOFKeVwNTaO5UhU4UXSOmknANWSeQ6NVt4+4e6LfNtNL+Z9j4i/hdvPCIYS5WnguyF9K2BZoh77ogrG1Ine9Uurgtgg2QmjKpy0+nat9iVeyh1YXr2BPwnvXfYbM6dWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoiO9L5F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017871; x=1777553871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dfuHT7cVwsYZ2eDnunf2jGG0bed38156J++uRmqK0J0=;
  b=GoiO9L5FR9sZwcNH0G5hrQLMJELrlMaFg+j0iLugbII01wahjAu2NGBM
   fMCmOx7Ha5kwmLPJjNqXNDGy2gWo/c224pEtuQj9oId/o2vjfW10F3k5j
   R2/cC900BsPagT/h76topS+OV/RIFImfbxAbSOtWPCoe2VozPgc6kKINg
   5gnG1La+wxJ9quWxAAqtfcihvl/CAC4jCQwgOB0Cn0Y6Gph6s0Q3djmEH
   h7rIkc+NA2yiBK7g/Yvbfs6zCMvfPY6qELlzRWuM2ZW/60gsZZuQTjgbL
   B1XUFd4c11tTQrkqzuxHgH128l8JsSMVRNuHhDIoCUui5ps9OTzzJHbrM
   Q==;
X-CSE-ConnectionGUID: xJfSPt71Try9XqcrKXrPvw==
X-CSE-MsgGUID: lP+KjmIQRkqpBJL5pMN/5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332335"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:50 -0700
X-CSE-ConnectionGUID: Zq61tCaZTd2ZOvKZ/7WY7Q==
X-CSE-MsgGUID: /mLO6NsUQPOrfrrEzhbvUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632098"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: handle SW reset w/o NIC error
Date: Wed, 30 Apr 2025 15:57:19 +0300
Message-Id: <20250430155443.b732ff4e9f31.I3948c2d892f1ee82b3a6bf9f123be02a1eaa82e5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For the upcoming TOP reset, the sw_reset() method may be
called without nic_error() before it. In this case, also
abort any still pending scans and set in_hw_restart.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 87624730fb50..5d91de598256 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -674,6 +674,13 @@ static bool iwl_mld_sw_reset(struct iwl_op_mode *op_mode,
 {
 	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 
+	/* SW reset can happen for TOP error w/o NIC error, so
+	 * also abort scan here and set in_hw_restart, when we
+	 * had a NIC error both were already done.
+	 */
+	iwl_mld_report_scan_aborted(mld);
+	mld->fw_status.in_hw_restart = true;
+
 	/* Do restart only in the following conditions are met:
 	 * - we consider the FW as running
 	 * - The trigger that brought us here is defined as one that requires
-- 
2.34.1


