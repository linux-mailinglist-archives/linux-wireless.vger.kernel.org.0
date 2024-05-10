Return-Path: <linux-wireless+bounces-7471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99E8C2663
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0824DB2361F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A70171E7C;
	Fri, 10 May 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRGi0tiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE2171E61
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350033; cv=none; b=K8aTLeEnFAOslWnp6b0I/xY6AYskj3ISexg65xHSmVPoGiAkts6SVqXNkJX26jlxPbOIl2cwUOfHqqMEXCybPteF4ApvAGdcE7a2e4xdX+w39ejMmbwzH6bBpmdWrMnHQmRGEY2UMNdEiHXyF4PxSo47lu9B4HwtMjXhUMUs72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350033; c=relaxed/simple;
	bh=QSc/7E5BhoUPb8uyhk1R27PsivVec6FiuYt5YixMIhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UE5uIrl54C0fYSRtObbA9C9p65UAp7E2tnEsvWZk8OA2UO72oX4XcnNBh4qMtO+cZUi3XT09JUA8qtXqLuQBDKMNk/C/m4fGXB39UE+OGwapR1LSNHGIxxCQz/y9iM+2O8pbGsHBd233CFXKaJJO2DZbtYegWQtP0xWtbrxt2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRGi0tiO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350032; x=1746886032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSc/7E5BhoUPb8uyhk1R27PsivVec6FiuYt5YixMIhU=;
  b=NRGi0tiOZCw72u1vxp3Kqo0kin4cHpgmwzMabfKx3ADpU10wzwjEpmza
   VFL0obE4SacWC54mOuWTjWXKAVIsUVWs1S628baKilEdAcEHaFP+JTQTr
   Eu/r3t9NbszkvyVHY25aAKxRZ6b15pBGhP+2x7SHCCSQA2nAgIGsNbVG9
   zMiHMYv9kwFtsZ2uU0fqtGCdb8PicbBqQdnYbjXjU1ri/JDPXP0GRR6ud
   qqW3CgWJN4tWUeeUnnG9CIbMbLXVwafWaGcH95K7yYQioTlkfcf8X9V8T
   /JNo8mcRWh0z87CqEGU7GTlnepeeLHCBAEsdMXXP9bs4RSWIKeNHLt35H
   A==;
X-CSE-ConnectionGUID: uS5+TMbRTsuA1dNnnpU2rA==
X-CSE-MsgGUID: XYodZbBqQIi44DNIXeLKaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125595"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125595"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:11 -0700
X-CSE-ConnectionGUID: te6+elvUQqK602VZqnE96Q==
X-CSE-MsgGUID: iVe8kYeTTtWl4gIREmB+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101895"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: mvm: Don't set NO_HT40+/- flags on 6 GHz band
Date: Fri, 10 May 2024 17:06:38 +0300
Message-Id: <20240510170500.b0d51b2229f8.I092e21cde43320ffc2eff17f5748ff9c87c87fcf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

These flags are not needed on 6 GHz channels, and anyway they were set
incorrectly.
This in turn resulted in alternating channel flags, preventing reg domain
rules to be merged together, so cfg80211 couldn't even send them to the
user space, as the regulatory domain was too large.
Fix it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 149903f52567..cf5c9500af8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1625,11 +1625,15 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 			flags &= ~NL80211_RRF_NO_HT40PLUS;
 		if (nvm_chan[ch_idx] >= FIRST_2GHZ_HT_MINUS)
 			flags &= ~NL80211_RRF_NO_HT40MINUS;
-	} else if (nvm_flags & NVM_CHANNEL_40MHZ) {
+	} else if (ch_idx < NUM_2GHZ_CHANNELS + NUM_5GHZ_CHANNELS &&
+		   nvm_flags & NVM_CHANNEL_40MHZ) {
 		if ((ch_idx - NUM_2GHZ_CHANNELS) % 2 == 0)
 			flags &= ~NL80211_RRF_NO_HT40PLUS;
 		else
 			flags &= ~NL80211_RRF_NO_HT40MINUS;
+	} else if (nvm_flags & NVM_CHANNEL_40MHZ) {
+		flags &= ~NL80211_RRF_NO_HT40PLUS;
+		flags &= ~NL80211_RRF_NO_HT40MINUS;
 	}
 
 	if (!(nvm_flags & NVM_CHANNEL_80MHZ))
-- 
2.34.1


