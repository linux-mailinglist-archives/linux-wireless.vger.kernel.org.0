Return-Path: <linux-wireless+bounces-27062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAFB479C0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21489188CCBF
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6C21CC55;
	Sun,  7 Sep 2025 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlkHtwAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE915853B
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233872; cv=none; b=W1Vw1KFRNBJWaRb3Er1j9EGagUq+VtVhzHdcKCEwYKvBFU1OkJuyNGdavi+LI5bF0fjnEy7pcxOVuZVxA4XxTl9Q6Na88t8QKsgd5H8blLJuyWMNC5nkV2eaGyU9K4n5MPRmaMFLE54EPE6XHoTmqXUC/y5xNuR2cOl0Kez+swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233872; c=relaxed/simple;
	bh=XVDWZ9cQVNK+h41HsE6pVlbfnK6WQ/BuzMCevP1M6XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+6Na9Fkxb/iSsRXR9AaCC8NM0qnWTCsmjMCTbFew8S0ic7Zr2hLqNJjf86MKs6Z0OxAhwZ0elkRUod0ohIAH7mnfOEY9mxB8q05c1MmnZ6t0Eg5R8vr8I5tcPuTVZYuwMNXb3SJjAi/tSy61vUhUVJCzSSj7cKIacPEFc4AJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlkHtwAX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233871; x=1788769871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XVDWZ9cQVNK+h41HsE6pVlbfnK6WQ/BuzMCevP1M6XQ=;
  b=TlkHtwAXebszcpRiQ533fFZVL65WpWlMkk1wwP/izSTfyLM7ArDazldN
   gc9K+PzEBuNqquwyZwZ77U2PZnHS1j6PiEhoU4XKgbgqh5r3Y0Om1iKV5
   vg+QqA03Ri1Fdj0SkF65JYpHaq1mL9Rz6pYKvQSn06mJENBHshCkAPTkF
   3Ik7SrxzbzSdxrccXi5iphqbCvQBRIt1FZwIChY8KQxFJul7fBoJ6qoBU
   nOnH5N/NCl0XRkWNK/zTZxfao9Jouu5Ts/5pUjpS/kmso/YZWux0CAmTn
   x6hIgfvEYehP655k+GckJBbGQ5WxFEF6hwL3uNrjIvsPI8xbjzkIpW8Ql
   w==;
X-CSE-ConnectionGUID: tnf99MR1QauVJfvtD8k3EA==
X-CSE-MsgGUID: ICtjGKl9Tl6Q1WVCykRT3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973628"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:11 -0700
X-CSE-ConnectionGUID: oileXQTJRVy+7Mu8NcEZsQ==
X-CSE-MsgGUID: 66G1wk7HRdOsaejgcMQabg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790091"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: CHANNEL_SURVEY_NOTIF is always supported
Date: Sun,  7 Sep 2025 11:30:14 +0300
Message-Id: <20250907112757.2a6f739b40f8.I7386aeef5fae70dc4b0901cfb650eeaecb4c1575@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
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


