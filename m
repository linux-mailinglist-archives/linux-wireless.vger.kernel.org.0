Return-Path: <linux-wireless+bounces-18529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3BA28B00
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB87188149D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4167376;
	Wed,  5 Feb 2025 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOF08Iti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372A8F5E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760186; cv=none; b=ZltDWruL2YowkYKY1qifuxyFSsY5Rm9DXqu2k1y4OzHvJanK6zPTcZW5JxKHRewdxakOquRbhdofHsGzkg7w96O8RVPMRcVr8f7o1mH+zKTYWqdXWTL7qhlDJvyxBOsTfuf6tyfXFTbGhVLma3SgrS0sBri+adoA+8WId5X3Vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760186; c=relaxed/simple;
	bh=gCmKrnTpA7F8vV81P6MeZ+SNbrfQy9Dn2KUT9EkA1To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JA/Y2iH0NNKR7r5s3oyrQ25xAxK2tP63xYG3DEqMxce6seJxkVrz875KcPoIpRFVlC+6giNDuBEhVb0RpDXp7B3Vlc9cTpOr09Ese/JTBWHmjM8yGHHI77XSCQ1jk1goxVJbxvvPQNWKVrHIrfNVZFwv6frshXd22vfFkZEyVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOF08Iti; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760185; x=1770296185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCmKrnTpA7F8vV81P6MeZ+SNbrfQy9Dn2KUT9EkA1To=;
  b=AOF08ItiXyAwhCxBa+J/ZYgYObYQKOrl4jcvq4EqC5DR/vzzPrE2rUXn
   1UTu/gsh8HlpwEbKkOe1NBnkH2Xab8SOwwysbNvWx4UD/cclACTNAksaV
   IPH9SAgrSIOA4xmSAfQcL5CLDbGgaB3cWGVr4pv5OGhTBXRGUe6iQlsp5
   ec5EZ/PsPvssYaxdq0wHgAwFK64qi+GVdnPzIgeJeeft5nxl/Zoh5Ritf
   9TFzjpEx0wQ5RbXFDHcZY1UNffCJpkFvmjmDrbqPBZIHgzyxV3E2Wvb4b
   2rZJGjhOP0TztKW/k2qjTxSeG2rlo1iwSQNKQ7nU/6GC4nH/aWZrSm9hs
   Q==;
X-CSE-ConnectionGUID: TRCzbUvVRaC0ccqZrm0raw==
X-CSE-MsgGUID: XiE2Wb+dRFWXkKi/EqFh4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159209"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159209"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:25 -0800
X-CSE-ConnectionGUID: jREUvPB0R9qQDVN37W7PJQ==
X-CSE-MsgGUID: fqvTyepXSyiQxfa1k10JCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745485"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 12/19] wifi: iwlwifi: be less aggressive with re-probe
Date: Wed,  5 Feb 2025 14:55:41 +0200
Message-Id: <20250205145347.38f912b047f4.I03f0c10ae9e7ecea639431f3e089b757cc8a4347@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Re-probing if we had 2 firmware crash within 3 minutes is really too
aggressive. Drastically reduce the threshold to 7 seconds.
After 7 seconds, a new firmware crash will be considered "new" and not
cause a PCI re-probe.
This allows to pass tests that cause a firmware crash every 10 seconds
and expect to see no impact on the traffic.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 8ba24903a870..1632ab20a23f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -97,7 +97,7 @@ static void iwl_trans_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-#define IWL_TRANS_RESET_OK_TIME	180 /* seconds */
+#define IWL_TRANS_RESET_OK_TIME	7 /* seconds */
 
 static enum iwl_reset_mode
 iwl_trans_determine_restart_mode(struct iwl_trans *trans)
-- 
2.34.1


