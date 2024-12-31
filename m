Return-Path: <linux-wireless+bounces-16939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765C9FEF3E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3621B3A2FD0
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A019D086;
	Tue, 31 Dec 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5vgPz4V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950719D881
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646381; cv=none; b=G5bg6LjWTkqaiDvsofYmko9oyLoj/7D5kKi3Kp0Dk7GwiHvttLe27Dz7VLKVWcdKhVkZZbbCT67Utsmt5sz7/ZwR9rvIjclmIIIleGBVy/knkfm40eyHoRMIac6YaRaiVJRzd2xkv/tq2h50pfrFOrTyCPLNb1psEJZeMFSPd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646381; c=relaxed/simple;
	bh=a8kYeE0tHHgh2Uds53TJYR2clOFQhoH57hO32wdADhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flJ2WGNfhyqKn+G4m16j+t3VrN7l9x7diMRKHEJ5qBOA2ZrWlaZelbHECRkfwKR+oYC9KKbJC452gq4/7KuNfQZFh4L9vZ6ZnPFfxT1tEgpVC6m6z0w1j+wBtXMhn7oiEm5dtAVhYh6EZ6bWaYUw2j0uHfXNGJZ+9Affuvmmwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5vgPz4V; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646380; x=1767182380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8kYeE0tHHgh2Uds53TJYR2clOFQhoH57hO32wdADhM=;
  b=H5vgPz4Vtu73lZjYYMgEsn0oLx/VYAaLLa37bnlgUGYrogKPyy4khADq
   3UFhmS+7jOG4JiEPPbAWgkzwyXSGfNfoZN/jGrlXmydc9ep0d1RfEL/cf
   XvtNt1E9DdDenteK7JyGr7MS2sP7ga7FruAsEehr3r1ezdhNauQ3SC1Vj
   OG1h7QOgpTeX0K7/nBcELOYbr3gwRfqL0IQ74CZ1o6pltmBZU1y7r0S7T
   5Hi+MtmcEavmeSngplkmQ7JKTBj0KOzENJ9Y/YurXpW+WH6eDLSfcdW0Y
   v6ZZ4LEUOQm7uqkk/8hq40phu605AclYR7NiMnj8dhDWehcYfcNrR94ks
   w==;
X-CSE-ConnectionGUID: 6qX/wGqcTX+EICYdnxXUag==
X-CSE-MsgGUID: sc4NN2zdQkyWJh8tb0fS/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330178"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330178"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:40 -0800
X-CSE-ConnectionGUID: OLGfu9DpQ0q809KhVXwCxQ==
X-CSE-MsgGUID: 02ilyXaJTzW+cWjph87JBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380300"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: support EMLSR on WH/PE
Date: Tue, 31 Dec 2024 13:59:07 +0200
Message-Id: <20241231135726.65a3b822e002.I4d6f10e02686f1cc159121cf702d6b747cab5b8a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Unlike FM which only supported EMLSR on B-step and later, here
it can be supported starting from A-step.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7fd51976924d..ee769da72e68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1732,12 +1732,19 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 
 static inline bool iwl_mvm_is_esr_supported(struct iwl_trans *trans)
 {
-	if ((CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM) &&
-	    !CSR_HW_RFID_IS_CDB(trans->hw_rf_id))
+	if (CSR_HW_RFID_IS_CDB(trans->hw_rf_id))
+		return false;
+
+	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_FM:
 		/* Step A doesn't support eSR */
 		return CSR_HW_RFID_STEP(trans->hw_rf_id);
-
-	return false;
+	case IWL_CFG_RF_TYPE_WH:
+	case IWL_CFG_RF_TYPE_PE:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
-- 
2.34.1


