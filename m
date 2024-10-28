Return-Path: <linux-wireless+bounces-14611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C09B3651
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247161F2310A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB11DE896;
	Mon, 28 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqji1FhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99E18A93A
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132361; cv=none; b=oMsqsyz9fg06eljlYkp/KqHAkSAUbnExtCPhJqvUyXywACh8577gjjO38q5clRbgORhitnj2ubGrZ+/MV3a1+dI0LgdFFyAxeBqHmhCq+DT91hQAayiTmkwlR8Szsny2/XxPNdkBRDORw3wwdHTOqAffdr5nzaZUB2Mi6ZL7Fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132361; c=relaxed/simple;
	bh=iewwAf4l1yyKinmkj6qzxwSTmsBUVeBmOlID+LtZnog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4DWpVji0pWI31yRqFhWfG5UrP9MMTp10xwlpfDVGT3QNZr+qiNKP+56hPSjK+OEGj1SFnwwG5an6IF8TJLUMjoL8PuftoEjtsjDIkc3crrU3ubKStaZQhYYxZWkuuLOwP9lwtDM7D6gDPksbz6cdABmdieUSRWeLZgKeBHnWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqji1FhJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132359; x=1761668359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iewwAf4l1yyKinmkj6qzxwSTmsBUVeBmOlID+LtZnog=;
  b=hqji1FhJ/swD3OGpAVbPEiHUVy/N3V043TXQJkFJteNPrvGt4xXyt2Di
   Tm77P70lH7Y3Z42UGfmMfWnnCliYdc7PJA3nmr0yv/bn8DqGzVKS0feaT
   vWN3l11tEzLmD4WDWbu5Qc46dMw68mEDQqPC6zuclQRDNJnyM2242bORq
   nNH+b71C0sUiH//V/24uuEkyyTyiycpckSXvtaLbs5EhJxB2X3395IpAx
   dCw78AfD0ipEDftuZ5cY1e4EjEA8Hv8OVScwV7Mc7s40Nr4Rd4/Vr2hPD
   xPv4mNyi6COuqgBYefzGuvGV1L0v7BgPtSZjhnfhpRvubCa9I3I6XlLF8
   g==;
X-CSE-ConnectionGUID: +e7P67VKRqW/Zqc6n1vWzQ==
X-CSE-MsgGUID: 7io0COS4SaufrfCJnNcz/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099897"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099897"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:18 -0700
X-CSE-ConnectionGUID: G0aIytcASbW98OlcFI2OZA==
X-CSE-MsgGUID: Y7CaAeCHRnmFMKmZnXU9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561550"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] wifi: iwlwifi: mvm: send the right link id
Date: Mon, 28 Oct 2024 18:18:59 +0200
Message-Id: <20241028181512.d23318da7153.I79fe16a14fa0bb20751ba2526c3195fef39ef772@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

in iwl_mvm_sta_del we call iwl_mvm_sec_key_remove_ap with link id 0,
when it might actually be something else, causing us to skip all
the keys.

Since the call to iwl_mvm_sec_key_remove_ap was mostly skipped (because
for STA mode we are not removing the ap sta immediately, but later when
the vif is set to unassocicated),
this was fine.
The other call to iwl_mvm_sec_key_remove_ap, when we actually do remove the
ap sta, was called with the right link id. So the bug didn't happen so far.

Now that mac80211 is going to change such that we can immediately
remove the ap sta, the call to iwl_mvm_sec_key_remove_ap with link id 0
will not be skipped, so no key will be removed, and then when
mac80211 eventually tells us to remove that keys, we no longer have the
sta ids for them.

Simply pass the right link id to iwl_mvm_sec_key_remove_ap.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 45656132d05c..703d7b2db47a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2070,7 +2070,8 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			return true;
 
 		/* first remove remaining keys */
-		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link, 0);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link,
+					  link_sta->link_id);
 
 		/* unassoc - go ahead - remove the AP STA now */
 		mvm_link->ap_sta_id = IWL_MVM_INVALID_STA;
-- 
2.34.1


