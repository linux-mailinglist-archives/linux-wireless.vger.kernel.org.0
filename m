Return-Path: <linux-wireless+bounces-23667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FAACD65B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD151889F7B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E684236A8B;
	Wed,  4 Jun 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJQgfpuZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971292144C4
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006822; cv=none; b=J0LYmw++CGLF/3aqB7E77YZe3QzFnk1kQRra6SUW2vTyNJeYmY9iDI89R8IjWqNCXV5HY+q+dmTWzptW4DTnjTBgWGMp48ib84WbOTgnrvWA+bWoh4gG+8UGVahrlbIDuZo8JrWD0UIL9pH+p+wkPiWpIqJ6E/1tXVc0bfQapNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006822; c=relaxed/simple;
	bh=gUrpGzgF6sYmnUMOullqhTH8FhMNixpEFC6SnUiuSRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I69K0qxEbnbKjhHBArUL4OLCNijtMrqYO28VFvH61jIkCzm6jBjWrc4F6Rw7A1MlS1qXlnuJjSIBslDcliv55m5nR9wMGeU0RQI15s8t88s+X2ypZ/5mJ33CUIW891BNhyvLM0ZrcHDteW2aaJO+xRwVtl1p/OKJao1fERpaTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJQgfpuZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749006820; x=1780542820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUrpGzgF6sYmnUMOullqhTH8FhMNixpEFC6SnUiuSRk=;
  b=NJQgfpuZMlnBOYPqa8hcq6xCBKVx8wP78unAWTr+RkSEupZ2W3SA6Rsa
   Ix2tmVVnZoAQgWrYlub/ESQHSFjFD8aC2cgKv+lpmNADnfrXTxUSq/zEi
   dRzv///AE53F3Vxga/Y/lU0uFGEXD8oAk4+fNWlYzmaeEZA0EU4/Hw95+
   z4x8bTJCQVPUFTAdlpMqLiW2cCu/lYswRqgAmD4pNF43bBbJQO8fnX4SY
   CC5z50xx7/CYpNwmbvbXeCDp+hr1TEWVAekf3M1gINXVTDYeMaHWR91yo
   /YfuHk188jOMpZfHnH2F/zpX/1q4Y/ikhGFYnWeN9ou0+d8ERLNkU5Ojm
   Q==;
X-CSE-ConnectionGUID: BDUChX8jTD6V9W/RhqrsVQ==
X-CSE-MsgGUID: EO0TU/OjRQutngyW7iX6Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68504617"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68504617"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:40 -0700
X-CSE-ConnectionGUID: olhW+Ea5TvmrzY1SkWbuAw==
X-CSE-MsgGUID: pZ+vT5bfTLGjcJ6iG2HURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182227365"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 2/4] wifi: iwlwifi: mld: avoid panic on init failure
Date: Wed,  4 Jun 2025 06:13:19 +0300
Message-Id: <20250604061200.e0040e0a4b09.Iae469a0abe6bfa3c26d8a88c066bad75c2e8f121@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
References: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In case of an error during init, in_hw_restart will be set, but it will
never get cleared.
Instead, we will retry to init again, and then we will act like we are in a
restart when we are actually not.

This causes (among others) to a NULL pointer dereference when canceling
rx_omi::finished_work, that was not even initialized, because we thought
that we are in hw_restart.

Set in_hw_restart to true only if the fw is running, then we know that
FW was loaded successfully and we are not going to the retry loop.

Fixes: 7391b2a4f7db ("wifi: iwlwifi: rework firmware error handling")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 8cdd960c5245..e8820e7cf8fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -653,7 +653,8 @@ iwl_mld_nic_error(struct iwl_op_mode *op_mode,
 	 * It might not actually be true that we'll restart, but the
 	 * setting doesn't matter if we're going to be unbound either.
 	 */
-	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT)
+	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT &&
+	    mld->fw_status.running)
 		mld->fw_status.in_hw_restart = true;
 }
 
-- 
2.34.1


