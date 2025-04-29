Return-Path: <linux-wireless+bounces-22211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCC5AA1B9E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD01B60B47
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B40D25FA02;
	Tue, 29 Apr 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2QXEK6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEB262FD4
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956453; cv=none; b=MxJYy7dtq12G246OyVbmtM61Z/iQfNSI355qIqcEiMDIDq1+sY+aSMkurQTjSmK2lO+gcuYGZ3GS2igbu9VVVi1NushUb0hyWC3nigMdn6+fdNzQaE5weVUl6jrYBw4DlMABe9wbstG57XxHCGCk+x2a0JPLDW0i0PiUEL8obIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956453; c=relaxed/simple;
	bh=HKj0HCREN75CyPQTvfXMeoXJ4GoZOKCCHpvzkU0CmOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xhf2QzcJwMEBuXr/ASR30ChtjLkerKdjo8bpY5+uwPgWWiWU6WMyLYgvqtHzcX2UXb72x2LS/yV7NS8/fXZdKNOZVeZJfoO4wsDxlpxd6PJKJGs1OuzLcCrIGdVhlMDP3JjPNzLnve2XaVddlIEY7E69zVwgv6UAU/z9FwnKmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2QXEK6E; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956452; x=1777492452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKj0HCREN75CyPQTvfXMeoXJ4GoZOKCCHpvzkU0CmOs=;
  b=h2QXEK6EC88/51UusjNs4eYnD60tHFHwIojYYZYdC9kkB/NJUhX4xM2+
   IMCwP899p1QlTFhBkDF9bXK1nfJMLa2XLFZPlRSrlIksmrCqxMMtUeTGY
   z3JoqiUk+PJ9DaNdCLpTvV2eNoYgIwg6oIqStZ4I5jaBFf8QNSkWVV/p8
   9NnntmzcsQ1rWdS2gUtTJJ3xCbugefTpkw6QODsy2jxCsQxaFzOlO5ZXR
   8OgAalDbLRpDgZ2Ua7wNy0VxA7Udzdwz8gt+TChdgAtt0IKNMGHgcL8wX
   StltyiZylv9VbpnmGfYAQZBRiI4Euhi2bEDyti3ECsTQkjILaSdm8wsuD
   w==;
X-CSE-ConnectionGUID: FliFy+vZRjucmdS2hy3zdg==
X-CSE-MsgGUID: wsSYV2fHQb+el9232pz3MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713547"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:11 -0700
X-CSE-ConnectionGUID: p2+9wvJUSximlpnXH3PZ6A==
X-CSE-MsgGUID: IgPgoH1BTxeYUhhde0ZdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155000"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/14] wifi: iwlwifi: avoid scheduling restart during restart
Date: Tue, 29 Apr 2025 22:53:36 +0300
Message-Id: <20250429224932.db428503ec3c.I3f2be3d72a9d40cfb4e697cdab1cd2866a9262bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a restart is in progress, it can be async due to the next
worker being scheduled in mac80211 (restart work) or the driver
itself (reprobe). Avoid scheduling another restart during this
period.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index c1607b6d0759..75d70021ee03 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -393,6 +393,8 @@ int iwl_trans_start_hw(struct iwl_trans *trans)
 {
 	might_sleep();
 
+	clear_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status);
+
 	return iwl_trans_pcie_start_hw(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_start_hw);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b9dc1b8794ce..8fae7f59a73e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -304,6 +304,8 @@ enum iwl_d3_status {
  *	via iwl_trans_finish_sw_reset()
  * @STATUS_RESET_PENDING: reset worker was scheduled, but didn't dump
  *	the firmware state yet
+ * @STATUS_TRANS_RESET_IN_PROGRESS: reset is still in progress, don't
+ *	attempt another reset yet
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -317,6 +319,7 @@ enum iwl_trans_status {
 	STATUS_SUPPRESS_CMD_ERROR_ONCE,
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
+	STATUS_TRANS_RESET_IN_PROGRESS,
 };
 
 static inline int
@@ -1152,6 +1155,9 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 {
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return;
+	/* clear this on device init, not cleared on any unbind/reprobe */
+	if (test_and_set_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status))
+		return;
 
 	trans->restart.mode.type = type;
 	trans->restart.mode.context = IWL_ERR_CONTEXT_WORKER;
-- 
2.34.1


