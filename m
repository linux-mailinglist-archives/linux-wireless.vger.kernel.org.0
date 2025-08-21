Return-Path: <linux-wireless+bounces-26501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17ECB2F8DF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF423B06C8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04D322A11;
	Thu, 21 Aug 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMy9i5rU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD1321F4A
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780310; cv=none; b=XavWiunmKJLtK6ngCIP7B6ivMsWUI508XqovZdh/Tif4bzH9wqPWwpgbCa+jlQ1O0f4HLg4oeLdhM04yVjoWxJIj0frGa7Kdz7lsh77FBngz39hDkLiGC7XawIl66wdXC+dplbNCHRv89veKyy1hlsVsZNWPL4QWVDsWfeSbHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780310; c=relaxed/simple;
	bh=EFJoisswneMjSQdWwubdNCs1NA5n3hD9HJ4E8uB1HWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZl+b7G4jsNmASiN4b5eAWJlknWI4Ine9LgWff/GmjPSnRgz1DqS1MD1FQ59WZLETkm+Vxpb64pf6kyj4rUF5ycodNW2fUjnOzS4yGEzZfNm0EUdqLg3PhnlsiA7Zmo6QCEX0BoAagvuRMjZXukJMauVtMM5pM9oZZ+tEWXHwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMy9i5rU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780308; x=1787316308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EFJoisswneMjSQdWwubdNCs1NA5n3hD9HJ4E8uB1HWc=;
  b=iMy9i5rUwgI/YCLGj8AC4SIsR6Mw4o259ARnxpN9//XTttxkrUcebq/b
   UEUJIGgH5cSlgjcDUizn7+w5RNTY+ame4kag7NLWH48sCZslpPcBPey2A
   RyDv0eRWbiu/ZOz63mKTmToOh+741g8TelU0wIAwhAyhHdwLj3z3w5PyS
   O8RQaUhBuxoFMhkhKAVzDP58csvGO8q6UxCl1pI6E3HFaSIPGhCeN/vA+
   b12sECnHbAbXBxiKBM6325LzWpnFA1UNm/jlpEuoBAwqYCKvkm/wsPEej
   RHk9sl67E9m9/ucAoihJXgHWQX/wTJ8hm1FThZbnzyiEm6q8Ldf7d4/PZ
   w==;
X-CSE-ConnectionGUID: 8zQU2gqTQYG4x7HSZ43DMQ==
X-CSE-MsgGUID: wsI3QUrhRdaDXAUlPlEIXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895747"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:08 -0700
X-CSE-ConnectionGUID: OZmOxIWxRh2OAnk3OJ6ewQ==
X-CSE-MsgGUID: qzVh5qFMSa+TuuY6XcnBmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622186"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
Date: Thu, 21 Aug 2025 15:44:24 +0300
Message-Id: <20250821154216.e0aea411cd2a.I4220348147541a1478b02389475426047ecf84bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

key->icv_len already includes the pn length and the keyidx length.
In fact it is the size of the MMIE, so subtracting it from the overall
length will actually bring us to the beggining of the MMIE and not of
the keyidx inside it.
Also, we also need to consider a 16 byte long MIC.

Fix the code to correctly retrieve the keyidx.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 13 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 +++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 53cac9d8018c..20d866dd92c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1611,8 +1611,6 @@ iwl_mld_rx_with_sta(struct iwl_mld *mld, struct ieee80211_hdr *hdr,
 	return sta;
 }
 
-#define KEY_IDX_LEN 2
-
 static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 				struct ieee80211_hdr *hdr,
 				struct ieee80211_rx_status *rx_status,
@@ -1626,6 +1624,7 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 	u8 keyidx;
 	struct ieee80211_key_conf *key;
 	const u8 *frame = (void *)hdr;
+	const u8 *mmie;
 	u8 link_id;
 
 	if ((mpdu_status & IWL_RX_MPDU_STATUS_SEC_MASK) ==
@@ -1674,11 +1673,15 @@ static int iwl_mld_rx_mgmt_prot(struct ieee80211_sta *sta,
 			goto report;
 	}
 
-	if (mpdu_len < key->icv_len + IEEE80211_GMAC_PN_LEN + KEY_IDX_LEN)
+	/* get the real key ID */
+	if (mpdu_len < key->icv_len)
 		goto report;
 
-	/* get the real key ID */
-	keyidx = frame[mpdu_len - key->icv_len - IEEE80211_GMAC_PN_LEN - KEY_IDX_LEN];
+	mmie = frame + (mpdu_len - key->icv_len);
+
+	/* the position of the key_id in ieee80211_mmie_16 is the same */
+	keyidx = le16_to_cpu(((const struct ieee80211_mmie *) mmie)->key_id);
+
 	/* and if that's the other key, look it up */
 	if (keyidx != key->keyidx) {
 		/* shouldn't happen since firmware checked, but be safe
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d8be2f6124c1..d35c63a673b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -332,6 +332,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	struct ieee80211_key_conf *key;
 	u32 len = le16_to_cpu(desc->mpdu_len);
 	const u8 *frame = (void *)hdr;
+	const u8 *mmie;
 
 	if ((status & IWL_RX_MPDU_STATUS_SEC_MASK) == IWL_RX_MPDU_STATUS_SEC_NONE)
 		return 0;
@@ -375,11 +376,15 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 			goto report;
 	}
 
-	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
+	if (len < key->icv_len)
 		goto report;
 
 	/* get the real key ID */
-	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
+	mmie = frame + (len - key->icv_len);
+
+	/* the position of the key_id in ieee80211_mmie_16 is the same */
+	keyid = le16_to_cpu(((const struct ieee80211_mmie *) mmie)->key_id);
+
 	/* and if that's the other key, look it up */
 	if (keyid != key->keyidx) {
 		/*
-- 
2.34.1


