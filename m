Return-Path: <linux-wireless+bounces-16864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652D9FDF41
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69933A1797
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AD18E34A;
	Sun, 29 Dec 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ilopc3kr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8B19259A
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483513; cv=none; b=EmmGDF0efUXNiv4j+lgrgs5sIKbCNwPWzRtsZT+S7Z9O80nJMh85I5BcbER12N8r465Dq393YLmLi/VBzUndjRBGCyA+voheFUdI6U0p3iHYJvuGMLhXVIP2cI/Qe5vemVlPIkmtPFVg3zCaIuX2MU2N63Z0KWDCycmCkTTjK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483513; c=relaxed/simple;
	bh=Ul3G9q8SK/lsU1gEPNNwiD9JqH2XDjr8CzN8SRDASPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhA7C+0mrjL6uHQYRKfmw9NEeOe8eS5f2F2+GQi7cSh4UepRseIXRodzsCArEfPTjseyc8hT/Rt67VjLii5Cv69OGz95+KiSeMr8D/C7IHqgZjpbokxJIO8zn+RELUE5knPS+oa0lKBBfHcbuMJiMdNtsKJXQeVXky8Z3ujG6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ilopc3kr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483511; x=1767019511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ul3G9q8SK/lsU1gEPNNwiD9JqH2XDjr8CzN8SRDASPE=;
  b=Ilopc3krPe6l297E53vTC0o1mERzVbc/nddGxR3PVUjg9oeVmIIjF2Mh
   ot6iHaBf7CXs2NAHzjEGeF/ze6DXlSson6mP98IOFC2MjZHRTizhDraCh
   CSnW27X8sW2bmePwgzwgArRmX5t0OqYeO4N/VIe2uRTWJSho/C/ZUKJbi
   jj/WXttVszh4BO9TNh0JpqEb9kvUdZygEe6iAhmT3YPvo/PJwtJASGfba
   OhtB2xPZb2bocZfMxX7iLRbwxgV5FNZcSpcPKo1cEl474XZwlCCTSOLht
   KRnGIgp1vuRpKt0s0pLLWDKE/54mR8EJVFmjsYC8UnU/pMBTEtEQFJyR7
   g==;
X-CSE-ConnectionGUID: YHmHFAONSs2SjXzBZRCPJQ==
X-CSE-MsgGUID: lnoaYI7VTfev1jmyTuEM8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572430"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:11 -0800
X-CSE-ConnectionGUID: FlYl874JSUOSiE0LXKn9Wg==
X-CSE-MsgGUID: rSfgF4RHQZWORFGQjB2lSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656824"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: mvm: don't count mgmt frames as MPDU
Date: Sun, 29 Dec 2024 16:44:38 +0200
Message-Id: <20241229164246.80b119bb5d08.I31b1e8ba25cce15819225e5ac80332e4eaa20c13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

When handling TX_CMD notification, for mgmt frames tid is equal
to IWL_MAX_TID_COUNT, so with the current logic we'll count
that as MPDU, fix that.

Fixes: ec0d43d26f2c ("wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index bd09bd0ca930..f67afb66ef2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1808,7 +1808,9 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "Next reclaimed packet:%d\n",
 						   next_reclaimed);
-				iwl_mvm_count_mpdu(mvmsta, sta_id, 1, true, 0);
+				if (tid < IWL_MAX_TID_COUNT)
+					iwl_mvm_count_mpdu(mvmsta, sta_id, 1,
+							   true, 0);
 			} else {
 				IWL_DEBUG_TX_REPLY(mvm,
 						   "NDP - don't update next_reclaimed\n");
-- 
2.34.1


