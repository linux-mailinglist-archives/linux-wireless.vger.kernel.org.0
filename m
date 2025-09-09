Return-Path: <linux-wireless+bounces-27134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341AB49FFF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EBA4E06C7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB07826FDA5;
	Tue,  9 Sep 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crhp/HNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AD2D8384
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388136; cv=none; b=Qt3ZyV17mv2qy8VVmscLppyNqWInpnwweUpb3MCBlMgUI0Pw2KhELvV254s3L+Gr1BwCyQxz+YpdYTP1ewrfi7PBniz1Vk0ixbVlzZw9wThb2qp2Mk/Kz5f9KCeugcmHcVWJULotPpn1tGX4+I9Kyy3RyabSdLd94Ah3JFCBjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388136; c=relaxed/simple;
	bh=XVDWZ9cQVNK+h41HsE6pVlbfnK6WQ/BuzMCevP1M6XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X77QwUDDJCM3Wtt+GmhpbU7Tpg3Aq+8AVyvr59y/fLgjDKBC6WfCwiS6TRFu040UpSxjEs2neowLUG1wQPhHU2tjUfrHiXl4U+vQ9RU++aER6FGWAI2o/LXP2sHkZFzE9kdgL7l00EcSE/KGbseWWVyzrCbr8ecEjg/1iiuuZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crhp/HNR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388135; x=1788924135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XVDWZ9cQVNK+h41HsE6pVlbfnK6WQ/BuzMCevP1M6XQ=;
  b=crhp/HNR9/tVUwPo94hUt860ECYqB+RuI3YhSaZZu+FELlPGwjvwyq2T
   7ahinIxOuf3q4s1gPxYeTFmBVH1vj7DGVbxyQxBqqU3oIoUVbj8YCK1rw
   dV8ml7nxDsBquZv37yjoZ3YnKrzbO6UWTlEwVrsnDJDjTNwc2uBnEOgcj
   eLqCxZ41/zdYGNHRvMcfUhDpYPMSosifDIE6PIJ4rLjWZbXOvn+Gz26eF
   kMcHbxSgtVxd3St+yWMXj7gK2yrsWjAWNvZJJO9wVVN0ACiW4G1HzPo3W
   ZSANCOYbiHzG6deKuJdvjyWQNP4lKrqodEbm1DpF7qM9OQ5QXbq6hK3pN
   A==;
X-CSE-ConnectionGUID: iZgkN+BnSe+jC2sqAAvnUA==
X-CSE-MsgGUID: 0Lkn/EsUTau0VnCBKanWGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281083"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281083"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:15 -0700
X-CSE-ConnectionGUID: /bkslEZ+S3So7audjDkwrA==
X-CSE-MsgGUID: We4i/1R9SkeoLOhPgptoGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950410"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: mld: CHANNEL_SURVEY_NOTIF is always supported
Date: Tue,  9 Sep 2025 06:21:28 +0300
Message-Id: <20250909061931.b43f7da0d63b.I7386aeef5fae70dc4b0901cfb650eeaecb4c1575@changeid>
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

This notification is supported in FW since API 100.
Since we don't support any API older than that, we don't need to check
whether the notification is supported.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 62f97a18a16c..fd1022ddc912 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -504,9 +504,7 @@ iwl_mld_scan_get_cmd_gen_flags2(struct iwl_mld *mld,
 	 */
 	if (scan_status == IWL_MLD_SCAN_REGULAR &&
 	    ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_AP &&
-	    gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE &&
-	    iwl_fw_lookup_notif_ver(mld->fw, SCAN_GROUP,
-				    CHANNEL_SURVEY_NOTIF, 0) >= 1)
+	    gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FORCE_PASSIVE)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS2_COLLECT_CHANNEL_STATS;
 
 	return flags;
-- 
2.34.1


