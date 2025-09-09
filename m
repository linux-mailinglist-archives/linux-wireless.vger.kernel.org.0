Return-Path: <linux-wireless+bounces-27129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DCB49FFA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798B84E095C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E22BE7AA;
	Tue,  9 Sep 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1fvr8fk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453ED515
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388131; cv=none; b=BE9jOsGxPowyjPs3ZYzkyxf0bxyK8v3DUdMR2VLi4XsZdROKoCd4bbBJ700mSkaLnbafKAm7E7ee7Y+UYuzraG/k1wfv0wOkML2ODSwplgxRnjpErZFcrFXzARIsR4cReh6Q0KMp6jwSpyjZG5fTGrFBqiVi8x/z8Rii1oHYJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388131; c=relaxed/simple;
	bh=T7yb95q8W9Jda7mRUS7HdLhLBmojiiZcnADDQOFpLYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unxpP8i+rPxsg+JUr9/3i1OLmOARhg8LYWLbPzk6PbbNSIgitk44UoBmKPTg8dXBf4v51Ly+ijaasKYSrnUAJDo3y9zew7kUCMjVm0SjJICp8cLpbeTOvX9AKHPX/fvw2TmRwFOjf8pdREnbuZcERUCM0EhtcZRTFbJpdJYjm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1fvr8fk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388129; x=1788924129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7yb95q8W9Jda7mRUS7HdLhLBmojiiZcnADDQOFpLYU=;
  b=n1fvr8fkteALY1+Tfv/I5TH9FaVUV30DW0TYbOwfdJ39r3e2jfB8Io5a
   sbIUHHsugN8OUy/mlckEFAu7SQJDrJPmV9MEcwybjZvW4Yesj8835E6i1
   XAxeFR2wEHFE9jCQMC8iAV8m1u8E/UqHSk3ll64VW0rNzDkdjqlNVh5fM
   B9BJL+uZ00Gprpq0hoXgZ4nDTyUgICk/j6cPT0GPK26aPsdaQFTg9Qale
   l/uYoA0BWtgPXlpnCOFk3MvI9zy9kxvtlXCviv6n7rAtueLqpLF/XKaq3
   m3Are5EKZ81Fksjd1Gjc5A8g0uSyCnS/lKZYkdZBun+iH6xQaseIt0q9Z
   w==;
X-CSE-ConnectionGUID: OTnavp+NTuKbCrBbgA9xRA==
X-CSE-MsgGUID: vnWOJB9ERqOYobX6ci0NaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281065"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281065"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:09 -0700
X-CSE-ConnectionGUID: HEKKj45bRO+o9+yudrwD7w==
X-CSE-MsgGUID: wh2tzp/6TuqZDtF8julymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950391"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/15] wifi: iwlwifi: mld: don't consider phy cmd version 5
Date: Tue,  9 Sep 2025 06:21:23 +0300
Message-Id: <20250909061931.42501c7b0baa.I207ff53d259cc90781a0082320e2646b35925e5f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

It was planed that iwlmld will be loaded also for HR and GF, which has
versions < 6. But eventually it was decided to keep use iwlmvm for those
devices, so iwlmld doesn't need to support those versions.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index debfb986a387..5725104a53bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -626,7 +626,7 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 					     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	if (vif->p2p || iwl_fw_lookup_cmd_ver(mld->fw, PHY_CONTEXT_CMD, 0) < 5)
+	if (vif->p2p)
 		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
 
 	/*
-- 
2.34.1


