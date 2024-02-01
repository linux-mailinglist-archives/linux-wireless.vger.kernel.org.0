Return-Path: <linux-wireless+bounces-2960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09136845A01
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD2B29A8D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B38665E;
	Thu,  1 Feb 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S20DilHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71C5F464
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797219; cv=none; b=p1WozK3Z0QOCzjMe34Pstm1d+5thEhmQoqPpzMSu4ywMkS08o+kO6cIKoaE8dXZxYxeMGFgaM88wqclPLqudOmBgfrIn2nhlOwbVQbHKj1RLdSLfLt3zDaTObY0IChDKpfvDsCKbwlQozKt+hlW7KdxfAHBlP5i+yHADsJR+tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797219; c=relaxed/simple;
	bh=3If89Nlvrf0tfnelp6A/4OdUPGgfO5HdHAIxXLCVx+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfchQWgXZGKUCAgRqhxzBamw+nly/j67vaz+LgLDd+w6I1JO2EAehXKJaMbeFXDCP4F6lVM1YZMiIR/zPnQ+sxpWlzXyV+dy50jlsU3G4I2t3c/W54Av2nhIw2AJoaYzGO98vJD0bbrB3In/e8K29t5WGEx+kPKnLhzryF7PGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S20DilHk; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797217; x=1738333217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3If89Nlvrf0tfnelp6A/4OdUPGgfO5HdHAIxXLCVx+I=;
  b=S20DilHkvsZAEIUbB7P3bj7RMczovyXqHafwQ/DbJRL13+yIXxh72TLQ
   1mfhvNN0+CbHG7ApC0WRJ3cU6kL7Uj7gvsJJxa4XrmriJ5Z+UICGJx3i7
   NywUOEnzwa0HX/k18i2QBQLDebZS1wM4/78OctCGX7onItFrlRzcy51I+
   detwp2VECOCpGGrnZvQybddDU2MDyoqedn8Me6CpauuADvJrqPdGKzODn
   /OlBUppQHe4tuwZcoHoAnS61UrA6/3mDOu8CZhT/hihFt5Y45zHhh2+Sr
   XAMSmWfEuqBRce2GejaxkeSwDxVooWSND/76I7bIUTP2e0P0UAEinXnMy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062977"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94478"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/17] wifi: iwlwifi: mvm: don't send BT_COEX_CI command on new devices
Date: Thu,  1 Feb 2024 16:17:38 +0200
Message-Id: <20240201155157.4e3e0b52f98b.I7e9481050921d95c38f5a21ccc47112b3698e859@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

AX210 and above have this logic offloaded in the firmware and it just
ignores the command coming from the driver.
Stop sending it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index d26075e3e6ad..2c34c55ca5f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -578,6 +578,11 @@ static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 					mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
 					iwl_mvm_bt_notif_iterator, &data);
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		rcu_read_unlock();
+		return;
+	}
+
 	iwl_mvm_bt_coex_tcm_based_ci(mvm, &data);
 
 	if (data.primary) {
-- 
2.34.1


