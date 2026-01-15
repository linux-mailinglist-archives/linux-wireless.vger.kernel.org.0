Return-Path: <linux-wireless+bounces-30846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8815D25B3C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 17:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1023E30BEA52
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C913AEF3C;
	Thu, 15 Jan 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hILxpg2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE752C3268;
	Thu, 15 Jan 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493748; cv=none; b=Xvfk3bKYld9yEEhlAgkEYhC1FK+9oohD04iiNMpsTJPynhWpem9bCG0Gn4Hn7OtvUa1WIUEebNPB6WgmpBty/Vy1ZhLV2fIMak1tnxFU1mi5hb3L7X1kgs0YD8VnZ3fNMLw0UG7bejazzZu84DA4nwXxXqW75rTxJPJGtOMyY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493748; c=relaxed/simple;
	bh=ZGpnvg+G3xAAeLZmH9mflMH1HBmSgd8ebhhvzQYVWdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSK/ozz55Uk4NAmtUYv7DLsq4U4OUHMUcU2SrZ1VN5OI7eEGv2w0HajnwFkJBrtobt5jabesD58X9btQeQnW5oNN6AE5mxZqFEmkrJA6qLLV3cmLQPRS7g92Buul+ysqD2n49M1WCBf8Ft/5Xg31pb8TuqvSlkiaOPmp7zMx/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hILxpg2e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768493748; x=1800029748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZGpnvg+G3xAAeLZmH9mflMH1HBmSgd8ebhhvzQYVWdQ=;
  b=hILxpg2ebIJEPOaMP11liWzN6MSF51uyLjUemBZsQRh5fiTzOIWWncEZ
   mEc74br39rVHq2VtwnYZwOU/MyXMNlLinhBNkrtFtUaxxzt5Wm+dn+9Ba
   Vp/XoXW4pW2vEz6RfIPs+tMvMZ7TVn7gyrf+uPZ+q1emCd/fNx2qdOlrI
   +Plgh4J6564GgUSgboAdiqOWBjxaEQ0lD7HfslBGxV4dGsnB+z3aPBcjb
   5V5TCMdbJOA0DtyZ+9aIhp11Wcy6WMQ6N50mZCy7miWuPxy2iN/hAvsIZ
   qUfzShk1jhPR2Dm4XjNN0ZH5/31V3bhzLaBwwR8Bc0T+a1Qto9r8H9mTi
   A==;
X-CSE-ConnectionGUID: i0ymt/xQT1SerYjYJjRaLg==
X-CSE-MsgGUID: mNXb/g9FR02n2xai9oEPPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81248013"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="81248013"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 08:15:47 -0800
X-CSE-ConnectionGUID: X31GgfJ3T1yqTw0sVy2s7g==
X-CSE-MsgGUID: 4qmu4v/zQPCgxRmKYHmqsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204603476"
Received: from junjie-nuc14rvs.bj.intel.com ([10.238.152.92])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 08:15:43 -0800
From: Junjie Cao <junjie.cao@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP removal
Date: Fri, 16 Jan 2026 00:15:29 +0800
Message-ID: <20260115161529.85720-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwl_mvm_ptp_remove() and iwl_mld_ptp_remove() call
cancel_delayed_work_sync() only after ptp_clock_unregister() and after
partially clearing ptp_data state.

This creates a race where the delayed work (iwl_mvm_ptp_work /
iwl_mld_ptp_work) can run while teardown is in progress and observe a
partially modified PTP state. In addition, the work may re-arm itself,
extending the teardown window and risking execution after driver
resources have been released.

Move cancel_delayed_work_sync() before ptp_clock_unregister() to ensure
the delayed work is fully stopped before any PTP cleanup begins. This
follows the standard pattern used by other Intel PTP drivers such as
e1000e, igb, ixgbe, and ice.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 231920425c06..b40182320801 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -319,10 +319,10 @@ void iwl_mld_ptp_remove(struct iwl_mld *mld)
 			       mld->ptp_data.ptp_clock_info.name,
 			       ptp_clock_index(mld->ptp_data.ptp_clock));
 
+		cancel_delayed_work_sync(&mld->ptp_data.dwork);
 		ptp_clock_unregister(mld->ptp_data.ptp_clock);
 		mld->ptp_data.ptp_clock = NULL;
 		mld->ptp_data.last_gp2 = 0;
 		mld->ptp_data.wrap_counter = 0;
-		cancel_delayed_work_sync(&mld->ptp_data.dwork);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index 1da6260e238c..2b01ca36a1b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -325,11 +325,11 @@ void iwl_mvm_ptp_remove(struct iwl_mvm *mvm)
 			       mvm->ptp_data.ptp_clock_info.name,
 			       ptp_clock_index(mvm->ptp_data.ptp_clock));
 
+		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
 		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
 		mvm->ptp_data.ptp_clock = NULL;
 		memset(&mvm->ptp_data.ptp_clock_info, 0,
 		       sizeof(mvm->ptp_data.ptp_clock_info));
 		mvm->ptp_data.last_gp2 = 0;
-		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
 	}
 }
-- 
2.43.0


