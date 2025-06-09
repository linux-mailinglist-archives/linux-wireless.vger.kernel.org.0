Return-Path: <linux-wireless+bounces-23873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF988AD2577
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B517A700F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C021CC79;
	Mon,  9 Jun 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpRB90Fp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2C21D3CC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493328; cv=none; b=UisQR3GD5/EwNUW/c16M5pJb3KQrmAeCLTHQr/6Gk4jexQmxxcNBlourvoSVsYFPhji0G5/VhmhmrK9afFluYJi+SQ1w4aDzs/kpKprzikyuUP7EkeHFQSuYTW1slrtZyhecxsDP5GBQzXZanK6y+IvgJOp0qWMetNds7YqjJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493328; c=relaxed/simple;
	bh=Ku15rB2WYrkFZHnslgJIczh1RDspwyUf4xcSJab7tf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EaXIRTTNIqgGxYkRvyTPewTSlZeMSA4/HkmWvR8YPg/ZHQ1I7eVgKe8Lf34+9dQ02B2xnw7SB6d6T4LYpxT4n4OCT7QvbLlUiXxhXnwd0ezXP95dw9c1S5lhA1H8VMasnnTXXLDA2Z/pE+Y4LzJCe07e7chdLGlPKW6VjPIbAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpRB90Fp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493326; x=1781029326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ku15rB2WYrkFZHnslgJIczh1RDspwyUf4xcSJab7tf0=;
  b=NpRB90FpSvHk0daATuhRlyAIue0Z+spsGWfmbJRlvz1mLSOA6NYK8wGv
   KSPfJprgR9G4TiqInhJiBgCXK0sDPVtc7Krq5QzFf6Iu01SGnJkv2B3qW
   WlaDatUKZH3n/sbXu+Pl7u1xak76LaePHdmpW8MKneuStr/Bo9+D1Qhi5
   KxVpPWg1fM4nwebMilyNtsMtn7bgjdTMSB3TWO9vPHKhnufrB2kltuzZe
   RRReKYyJo1/v+xWxD8NDwGY8kZQ4d1gia2eonGupkmsVfAOFT1f63Cnjq
   79FvoUDuE366aqWNTJyVhqpJVNiDMWNwFSHIiDgqo4UmqoUjKIncvjHBz
   A==;
X-CSE-ConnectionGUID: V6m620xFRMqarQDwungyWg==
X-CSE-MsgGUID: kCQf0zR+SgaeLvCufhgJGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237694"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:06 -0700
X-CSE-ConnectionGUID: 3TJy+MeRTrSnbOwdkDfIhw==
X-CSE-MsgGUID: few9+398QOmlC6jS0OQtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510405"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: fix misspelling of 'established'
Date: Mon,  9 Jun 2025 21:21:20 +0300
Message-Id: <20250609211928.afbb67d4dda9.Id1412d9336740e6101e672b38411641c6e206999@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This got pretty mangled, fix the spelling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4ba050397632..9b4bdbf40d4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1468,7 +1468,7 @@ void iwl_mld_mac80211_mgd_prepare_tx(struct ieee80211_hw *hw,
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	u32 duration = IWL_MLD_SESSION_PROTECTION_ASSOC_TIME_MS;
 
-	/* After a successful association the connection is etalibeshed
+	/* After a successful association the connection is established
 	 * and we can rely on the quota to send the disassociation frame.
 	 */
 	if (info->was_assoc)
-- 
2.34.1


