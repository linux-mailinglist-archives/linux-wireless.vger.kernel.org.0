Return-Path: <linux-wireless+bounces-26638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E2B36F4E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C124A3666BD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA382D7BF;
	Tue, 26 Aug 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi4qcyr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B223817F
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223746; cv=none; b=BRaH3aeuILaOM6vq3Fe03oo1/Ypt5TVf15TXneQ50/2K+9WFVJP0qtxB/ZOTN4OvQ38wNYHt3aJyTgsIDPYDXq6mB6rLf7CAvadnMTHml04K/2zsJqUM4hm+g4/W3ve5GxqQm1jMZVPZWh8HY5bwCnCjT50fZf0IkNy/ANuD4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223746; c=relaxed/simple;
	bh=bRvThv8vFQquVZImEEASqd64Fds1oGxI46AchHp10HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3nV8Ir0z1OdRWiOpsibf9OuoUmcaXGnc1qzq12mHFXFg0phsJaFQAHmr6/+M6+yv2askKLc+rvkLrS5Z2bnAOESMlDxxmhBCCzYbZ3uJHbK5pFg2J+pGGy+KUkth7ZU6scfaxcYAB1G7oQU0vsBFhukUTleuWqkS+03qc23FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi4qcyr9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223744; x=1787759744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRvThv8vFQquVZImEEASqd64Fds1oGxI46AchHp10HI=;
  b=Xi4qcyr9tyjytZrkCcy7u3G88RqQogemNLT50ZbzamhOW4SmGMrEVa4M
   Sur5aL43t11CKR57wFcyXiQOPooTIqNM5k9ssJ4Kf6s2RIyG1nDl7xnVO
   8eS26s2pSpzEMCCK+ySSrUbYj9TQ0EKSxLOsioKXgVFVuu8ccxgU3lRjO
   9HPFe1etWyfmH/c/N/j7n5l+mkau8ysHJb7JtCvgRW1OUqktSbF0/32hu
   AfAcQqJ/kx+S0OzRmvuAJ5gdUHcsx+TAvYmRUdAXJ71J0fX0rlcpVvFtP
   qvtVfAIQ2HipdhqfEWJFHHGpMYvg7B7LzbjHLLx8tJ8yIeNE1BCYtvArw
   Q==;
X-CSE-ConnectionGUID: Sm1b7hAuSG6QuX98zIAJ1Q==
X-CSE-MsgGUID: YaSNdEk1Sxa33I78WCHEsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108399"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108399"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:32 -0700
X-CSE-ConnectionGUID: cNH4sUpiSvm1SNbG7rmpyQ==
X-CSE-MsgGUID: 6TesYjEVS6anTn5QSXeQtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218190"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: don't check the cipher on resume
Date: Tue, 26 Aug 2025 18:54:50 +0300
Message-Id: <20250826184046.8c4f9c30242c.Ie34c200f321aae60771476fa9907c333a8a99747@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

On resume, we are iterating all the keys in order to update the PN.
Currently we check the cipher of the key we are currently iterating on
to decide whether the key is PTK, GTK, IGTK or BIGTK.
But we can find the type of the key by the keyidx, and we anyway have to
check the keyidx, so just remove the cipher switch case and check only
the keyidx instead

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 43 +++++++++------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 6a32aa22ffb8..dd8764029581 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -745,37 +745,32 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	struct iwl_mld_wowlan_status *wowlan_status = data->wowlan_status;
 	u8 status_idx;
 
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
-	case WLAN_CIPHER_SUITE_TKIP:
+	if (key->keyidx >= 0 && key->keyidx <= 3) {
+		/* PTK */
 		if (sta) {
 			iwl_mld_update_ptk_rx_seq(data->mld, wowlan_status,
 						  sta, key,
 						  key->cipher ==
 						  WLAN_CIPHER_SUITE_TKIP);
-			return;
-		}
-
-		status_idx = key->keyidx == wowlan_status->gtk[1].id;
-		iwl_mld_update_mcast_rx_seq(key, &wowlan_status->gtk[status_idx]);
-		break;
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		if (key->keyidx == 4 || key->keyidx == 5) {
-			if (key->keyidx == wowlan_status->igtk.id)
-				iwl_mld_update_mcast_rx_seq(key,
-							    &wowlan_status->igtk);
-		}
-		if (key->keyidx == 6 || key->keyidx == 7) {
-			status_idx = key->keyidx == wowlan_status->bigtk[1].id;
+		/* GTK */
+		} else {
+			status_idx = key->keyidx == wowlan_status->gtk[1].id;
 			iwl_mld_update_mcast_rx_seq(key,
-						    &wowlan_status->bigtk[status_idx]);
+						    &wowlan_status->gtk[status_idx]);
 		}
-		break;
+	}
+
+	/* IGTK */
+	if (key->keyidx == 4 || key->keyidx == 5) {
+		if (key->keyidx == wowlan_status->igtk.id)
+			iwl_mld_update_mcast_rx_seq(key, &wowlan_status->igtk);
+	}
+
+	/* BIGTK */
+	if (key->keyidx == 6 || key->keyidx == 7) {
+		status_idx = key->keyidx == wowlan_status->bigtk[1].id;
+		iwl_mld_update_mcast_rx_seq(key,
+					    &wowlan_status->bigtk[status_idx]);
 	}
 }
 
-- 
2.34.1


