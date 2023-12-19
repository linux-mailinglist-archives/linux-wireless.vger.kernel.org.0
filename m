Return-Path: <linux-wireless+bounces-1038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F51A819127
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22DC2877A6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AA3B19E;
	Tue, 19 Dec 2023 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuHZawuE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688B3B18A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015994; x=1734551994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QDqFliEsUGhxYUDCKFfwBpIMuzDSkilc5Dktx5hDoNk=;
  b=VuHZawuE6jIDu5wqXLXyFAbnKoBVrlmrkAy2UZmFt+VchmwWhCOcuUFw
   Y5Fy64a6ImyatSzSqSKSIpPwQdXrgMvHPOEj78MmwtN+26oPXVgbPSnYq
   jKXqZv5IXXS5zwyuueseJgnSa2hI2J9SnmLA3wZDVSKwsSCynu28/4mby
   da671cx/I5IyQXBiZOfxlwF7AIvFNJ7cKcT9yuZ78Bit5nT1PHlXr9e2M
   mS4vM2l7ZKyJtCk3bxYPZEMOsdqbX+17MNbpkybh72gjpkI4qgwfk0+B0
   zoU2GB6pTeG5NEA6D3qdctSyFzEU6xNMUo4iSF/FXkf1gegRgrS7aKq6T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694975"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694975"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589141"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589141"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: mvm: disallow puncturing in US/Canada
Date: Tue, 19 Dec 2023 21:59:00 +0200
Message-Id: <20231219215605.38955b68b429.I0c4ae99179b271648a747a51eb04853504c7952c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For now, this isn't allowed. The API to mac80211 isn't great
for this, but we need to change the API to move puncturing
into the chanctx/chandef, and will do it better then.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 06de4dc2a915..5276df717ca1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -152,6 +152,16 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	mvm->lar_regdom_set = true;
 	mvm->mcc_src = src_id;
 
+	/* Some kind of regulatory mess means we need to currently disallow
+	 * puncturing in the US and Canada. Do that here, at least until we
+	 * figure out the new chanctx APIs for puncturing.
+	 */
+	if (resp->mcc == cpu_to_le16(IWL_MCC_US) ||
+	    resp->mcc == cpu_to_le16(IWL_MCC_CANADA))
+		ieee80211_hw_set(mvm->hw, DISALLOW_PUNCTURING);
+	else
+		__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING, mvm->hw->flags);
+
 	iwl_mei_set_country_code(__le16_to_cpu(resp->mcc));
 
 out:
-- 
2.34.1


