Return-Path: <linux-wireless+bounces-5045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB288190A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CD01C20CE1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626D4F8B2;
	Wed, 20 Mar 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LezqsAJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FD85951
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970016; cv=none; b=uKG4nWih37Aq29XaYrt7UtxaLA7mxKko0kiJ12BEBS9uglUDPeJoLdT49yodK19W6UxXDFe7xqU6fu6evP+Ny4hUhjrrgDlJ9Cdlv0kY6Llt2sZBMCbGHJ491l9XRACyf7jHUfXHoQMrsuzQh3d0dMEdEOcyM+YkN7xc5zUPSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970016; c=relaxed/simple;
	bh=YloJ0yHJlIYA83FFwU+9/5UNVyNTxXfBF5MfL/9MX3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLLTYNuU7toGFFZbRr1gtaZlDqo0+kgEh2De8CetcE2kyoGAKPT5Jj4kUMI9j+UcJ+MjgCq7hc2vrFMD76G/agWTdHd/vTnQSnnH6HRP16AX+w1+BENaOZRVaeEk2BzLYYq3Vn2cqq+WrmPk7D1GsFRS51ZUEDuDy/XwEpz3EtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LezqsAJi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970014; x=1742506014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YloJ0yHJlIYA83FFwU+9/5UNVyNTxXfBF5MfL/9MX3M=;
  b=LezqsAJip+BTj4S714/4lICOwH5RY1+HtsmkrGlIwgi1m9tYZNP58FkK
   TtiYpK6D+/yzTeoBMe+/lf4c3xc3smhkdPmiyQ+iOxywarKGBpfjeFG89
   dDW+9QK9DHUtNdi+4vqK6NH/LSF7cXuMqFz7B24/l/DP6WeQH1xJpLl4x
   KlXWjflFsBGI20pY4rvI7EcmrSMzpKaVWDom27buexnG0dlhNZpjKUbPI
   TPX6huKb6ZaFZAJc71s3h3DRRQ0HVFuDeeSyQ6QH9MkFCX0U6qjx+vfa7
   qtoH+O5yawT1inXgP+7f1UbzV35nWrB1WkukEn+/qJ33/c1cwWgjdroTq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698045"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184108"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: mvm: guard against invalid STA ID on removal
Date: Wed, 20 Mar 2024 23:26:23 +0200
Message-Id: <20240320232419.d523167bda9c.I1cffd86363805bf86a95d8bdfd4b438bb54baddc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Guard against invalid station IDs in iwl_mvm_mld_rm_sta_id as that would
result in out-of-bounds array accesses. This prevents issues should the
driver get into a bad state during error handling.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 6f9ba0c18fa3..4ba1599ed71c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -855,10 +855,15 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id)
 {
-	int ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
+		return 0;
+
+	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, sta_id);
+
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta_id], NULL);
 	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
 	return ret;
-- 
2.34.1


