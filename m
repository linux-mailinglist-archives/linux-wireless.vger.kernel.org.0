Return-Path: <linux-wireless+bounces-11915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976795E44C
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79FBB21061
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454A42119;
	Sun, 25 Aug 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6sIOJWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5DE16F8E7
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602661; cv=none; b=BVaVV6WV0QlpDNFW27tdLueJcecKcKaa9sWC8K60qtB+ZKEpbQNQh1O1kh89Zkul89qysAPhXma0U0bY8DESIaV+yiDFFnz/mBtG1kL1Ml7TIPxfMEqeRaJKOcCbJBjrY4WX6Bag6GcrK17lLRoQZSn1NL9XDuVfyyZlt+uuxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602661; c=relaxed/simple;
	bh=tNyqzoZ5FVNN2rGcdvVUbIeID/wX5OShLQPVFu86mWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVrBwtcwkhVQ8xUv+alAH2fEznOXSH11E/bugzk9a/soQVj+d31cjylVzSpJjwwcVFpFu9haD1NPp3Xai2OObj0eiPgzA6AABUELCpkj5shAQJyX8BH7gX5fRf91Td3z6AbHhQG7IWBMY+0A5AYW0sDgxyC3clFMyjMIOifMFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6sIOJWL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602656; x=1756138656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNyqzoZ5FVNN2rGcdvVUbIeID/wX5OShLQPVFu86mWg=;
  b=M6sIOJWLBQDAfdoal+u/QgHnxsTXrxVKJiuDkWjdzfp/mVGMymsE4F9r
   Tz6MCyRj3eV8hu4cXstgzsqjCjsTdbRuzx+QcnsF/NSermFSaoguy+OJ4
   Yjw2KPWn2ydBuhA60j+e4WQH2cYhJMAXsqf33URVpamV2iA2gUz4NlaLz
   QYzpRutW3kWhsIohjMbhnXI+Gai5dpdg7y8ySjpOSNLrYgc4rEEoyJhsC
   mQzjf7leS5sXKzwoSpz996QIhGzaz/zgt6PuudmjuZIBL1bE23zdsAJTu
   HCmfhMgimW+SV6bWcH82i0CWIEqJ6BjUuwo3bHwLyAq6Lt6AAOUq8kK3B
   g==;
X-CSE-ConnectionGUID: 4RejxJi5R/2rixNAouyphg==
X-CSE-MsgGUID: Eh1wLl+kTOykExah83n7Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544134"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:36 -0700
X-CSE-ConnectionGUID: j6EBxkXSSsGmzBKkKcVfEg==
X-CSE-MsgGUID: CYiojWsxRX2+rMWHQRX4nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999759"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/13] wifi: iwlwifi: mvm: avoid NULL pointer dereference
Date: Sun, 25 Aug 2024 19:17:09 +0300
Message-Id: <20240825191257.880921ce23b7.I340052d70ab6d3410724ce955eb00da10e08188f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_tx_skb_sta() and iwl_mvm_tx_mpdu() verify that the mvmvsta
pointer is not NULL.
It retrieves this pointer using iwl_mvm_sta_from_mac80211, which is
dereferencing the ieee80211_sta pointer.
If sta is NULL, iwl_mvm_sta_from_mac80211 will dereference a NULL
pointer.
Fix this by checking the sta pointer before retrieving the mvmsta
from it. If sta is not NULL, then mvmsta isn't either.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 7ff5ea5e7aca..db926b2f4d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1203,6 +1203,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	bool is_ampdu = false;
 	int hdrlen;
 
+	if (WARN_ON_ONCE(!sta))
+		return -1;
+
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	fc = hdr->frame_control;
 	hdrlen = ieee80211_hdrlen(fc);
@@ -1210,9 +1213,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
 		return -1;
 
-	if (WARN_ON_ONCE(!mvmsta))
-		return -1;
-
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
@@ -1343,7 +1343,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_tx_info info;
 	struct sk_buff_head mpdus_skbs;
 	struct ieee80211_vif *vif;
@@ -1352,9 +1352,11 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct sk_buff *orig_skb = skb;
 	const u8 *addr3;
 
-	if (WARN_ON_ONCE(!mvmsta))
+	if (WARN_ON_ONCE(!sta))
 		return -1;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
-- 
2.34.1


