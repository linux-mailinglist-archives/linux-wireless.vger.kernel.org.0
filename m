Return-Path: <linux-wireless+bounces-22400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8EAA85FD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ED918996FB
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9A1BC3C;
	Sun,  4 May 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4UOPUi9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C91A8F60
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354436; cv=none; b=JgLnSiAxuinnoP999jRW6Nhj6/CASbRVq3dYTHjogyrfnbWe+RwnyiMh3UTIlRrAS9X24+34z+APZsEl9gcUIXxfKWGbn+RJ3B2JySCYVK26pVMtaiTcF1QbbD98zjrP0Pyioz821kE/UaJCQYWwOmHJx+EDI2ncxE2QjTguMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354436; c=relaxed/simple;
	bh=SMYNlK6luVQFDEwpYBnPenY5dqnX/EbdkPIan0npiUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xt0s6BnKj3UkNfS7ZzCYe2T2NIIYf/CO92Mbv/4n/F4cI4Aw2erQ3+RDjaHpRicAlXKqnzI9TICPMWFU2t25XlSMQqFrIqOo1mMllS+g+cAdLilH5eAg5WSzKStJ9NDvIPkLlnz7xT8bEfTvP0vkjGmpQwEUyIC3SWiNzKpBMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4UOPUi9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354435; x=1777890435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMYNlK6luVQFDEwpYBnPenY5dqnX/EbdkPIan0npiUA=;
  b=T4UOPUi95hOGXY3xvr52NtJ1liItPB3LhSjC26aohk7NFB9IzlG/VhRf
   m7QdXtXobTwTluKajl+c5Pc8f9y3lwZZ5zSvaN/ssrtQKefT/VQwBHDt5
   qpXqw0PjGVNSFcfx9Kz4AoOaapj7k4XyOhywxWqkqg79PraJe+62DbzTI
   dis8lNdJN0E7Wqapq9y2V2SuuH6HU4OfBcvxiRhCosZmjYsjX2Bvro6Sl
   dZM07sWs6d8jW2ypahudZGA7smKQU9sBnsHNIx35ZkXedY6qJ2vzORuyz
   eLq4qVOj+/HVCbujXNjtUx3fUWBna97KrJAZy1huQihqmqS8hPURicLfr
   w==;
X-CSE-ConnectionGUID: EBqcQm14QNSoC2swOwfNLA==
X-CSE-MsgGUID: ivaWThu7R6ah2eYNF4sdTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511521"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:14 -0700
X-CSE-ConnectionGUID: ydja9nuuSfSPV/XG+KRjnw==
X-CSE-MsgGUID: 3wX7afKLSZS2X0Kwz3e/rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778922"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: dvm: pair transport op-mode enter/leave
Date: Sun,  4 May 2025 13:26:30 +0300
Message-Id: <20250504132447.714c3517548b.I49557e7ba8c03be2b558cc9fb5efa2a9fbab890e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If there's a failure and the op-mode didn't actually fully
initialize, it should leave the transport again. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 1d811b60162b..38e66e694d52 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1380,14 +1380,14 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 
 	err = iwl_trans_start_hw(priv->trans);
 	if (err)
-		goto out_free_hw;
+		goto out_leave_trans;
 
 	/* Read the EEPROM */
 	err = iwl_read_eeprom(priv->trans, &priv->eeprom_blob,
 			      &priv->eeprom_blob_size);
 	if (err) {
 		IWL_ERR(priv, "Unable to init EEPROM\n");
-		goto out_free_hw;
+		goto out_leave_trans;
 	}
 
 	/* Reset chip to save power until we load uCode during "up". */
@@ -1503,6 +1503,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	kfree(priv->eeprom_blob);
 out_free_eeprom:
 	kfree(priv->nvm_data);
+out_leave_trans:
+	iwl_trans_op_mode_leave(priv->trans);
 out_free_hw:
 	ieee80211_free_hw(priv->hw);
 out:
-- 
2.34.1


