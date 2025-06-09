Return-Path: <linux-wireless+bounces-23861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481FAD256C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AF91891222
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A92185AA;
	Mon,  9 Jun 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCV0Jfrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9E21CC57
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493313; cv=none; b=fSBtsd6LVlZsb2X5l11h/9lcwg69gX7gNi4cvEgMU1CpvKyufh5VzZI0r5EX+CG/sAHkb5MSLNcAbMHoowNVq86XLW4iIwVsFutqu1A3flqTcn4au//xj5CBxlLY4j7vGwZpcwAefkRTFPStiLCIVXlh5snAADrLZ3M02rNswK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493313; c=relaxed/simple;
	bh=OZWryQbdfge8b1gjtUorsOb8XzpJK2PG0AvYNu3XISw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9MCTJSFNYEa9DpZX61r+4K1Pu00/HTiHz/0t2Fbhm07izr59zwMpehXq17+XB+Z3mqfVH3clnR9D6sz+1PqdpURpzGbmmU6YuhehYMDwSicOSxPyowwOSA7v9jRRacl0IZ3R+PzRWdDurF34dDEQuw4vHCxeAubc+6wKG8zalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCV0Jfrq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493311; x=1781029311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZWryQbdfge8b1gjtUorsOb8XzpJK2PG0AvYNu3XISw=;
  b=cCV0Jfrq6BZ+pR4vUgvlFG7YLgqjhtoyXibb6g4/qf5WrcUC3RaAfXAK
   /bvjkYjG++y7LdzIM8zCdRgWmTPnRhbhmmeMfSBNtfuBkAhLz9STCrw5N
   Aj0WJz3SxAcc7Imylp8vV6mYopALcCxe1AVFfjIFUkfloDPygGQN6Otdq
   9WtbwzYw36/ueCvN/36xHmDNwksLcuGMNqGLqF2j65/kM13+dVK6oJhQ/
   jGaf9RuOiAUDzHjMmFQjIiD4BT3xtvCF0q9GnpCLnrY2qWGK3sV3fVdkj
   dt6Daluv+xovAX2h4rPiGHaFOwEf4XtM88PDrAzqPn3jxuJ73qlQYb03V
   g==;
X-CSE-ConnectionGUID: y+QFUc8dTlqoDRIQLtMnxg==
X-CSE-MsgGUID: VyODJMw4Rsmjr5Zerw5qoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237661"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:50 -0700
X-CSE-ConnectionGUID: t2fiXVY9QkOaMaza3KEspg==
X-CSE-MsgGUID: 6EMvFCCVRH6B5MMyfOBkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510240"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_retry_emlsr()
Date: Mon,  9 Jun 2025 21:21:08 +0300
Message-Id: <20250609211928.b5c7fbdcb15c.Iaa176c49142b46b0b896728005357faec6a55fa6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Respect this flag before initiating MLO scan.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index dba5379ed009..20c2b436039a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -1167,8 +1167,8 @@ void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
-	if (!iwl_mld_vif_has_emlsr_cap(vif) || iwl_mld_emlsr_active(vif) ||
-	    mld_vif->emlsr.blocked_reasons)
+	if (!IWL_MLD_AUTO_EML_ENABLE || !iwl_mld_vif_has_emlsr_cap(vif) ||
+	    iwl_mld_emlsr_active(vif) || mld_vif->emlsr.blocked_reasons)
 		return;
 
 	iwl_mld_int_mlo_scan(mld, vif);
-- 
2.34.1


