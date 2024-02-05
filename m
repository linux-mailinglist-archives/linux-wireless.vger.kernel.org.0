Return-Path: <linux-wireless+bounces-3172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652184A6DA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421B1F26466
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79D59B41;
	Mon,  5 Feb 2024 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG+G98zM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7559178
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160923; cv=none; b=hpUHV2T3MUTR3rtr/QvDNTytnEToa04g+HxTvpY1TL51QkdaVLFJIonJ+inyEvANN7eYQSQ201M4AAixJd4tFJQChMfCgsR8eU0uGD7qDKmawsWh5SuspMbkEA6S1OBKnCWQ9dsqOe9A+zi9CqXnDOsQ0hGA3vNZnsKrd5W5Qfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160923; c=relaxed/simple;
	bh=/wi6PsCGciTR5FJpWcPXptfxYEfq2FXXxIbBggG0/dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glWVCs23kYawx2LHOI4lUDD1p9oXN0l15xaSxjlBtrBTF2cTuFBogYe1qVnFsZgJurJQxaJNI0QmvFZoLUSVI4GP2VgCqohXcv7+sF98j0C8IeX7zPWqnPm6BMkgirp58oL7pBBbLBko4sP+lepjPxuEBDRTCvNdZlM9x7B9pOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG+G98zM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160918; x=1738696918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/wi6PsCGciTR5FJpWcPXptfxYEfq2FXXxIbBggG0/dE=;
  b=kG+G98zMML8pTtaZYXfSbKAjA6XfmloJdgXJkPfNHzkP8uHnG7YRFUFi
   MBpOGz7DoidtzqARyqYTBCIfz7yyrb5W2ff7wNJuE9uHHI5WHsMtxkJGB
   gHcMsEVsLXeFxQ4868l67BL19GJvE90QkSQCy34uJZgSmUSWybczmVhut
   elGzAuPkuvqUyLcyrqEd4CLsVX1+ORMHT4AgdOPt9xint4oKS2BtYhcXt
   9I+JMyyHQmrimjMgWBA/Zqbz+ZpBIxhMyrQ+cKsi7f1y2K6Vd7irz0szL
   45eHCsW7//F3I3S8oGkyNj31RI62A1r2be3Z20B679ZfeDt2nRRLTcUlb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381639"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381639"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403151"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: fix the key PN index
Date: Mon,  5 Feb 2024 21:21:09 +0200
Message-Id: <20240205211151.bdd0511c007d.I3325288c64c010a4d008ac4429de1c2b14ef764c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

When waking from D3 (and a GTK rekey happened during
D3), the key itself is saved in iwl_wowlan_status_data::gtk
array, but the PN is saved in iwl_wowlan_status_data::gtk_seq
array.
The indices (of the same key) might differ in both arrays.
Fix using the gtk array index in the gtk_seq array.
Rather, iterate and search for the correct key in the
gtk_seq array.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6396fbde03c4..994387eac6f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1958,7 +1958,7 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 			      struct ieee80211_vif *vif,
 			      struct iwl_mvm *mvm, u32 gtk_cipher)
 {
-	int i;
+	int i, j;
 	struct ieee80211_key_conf *key;
 	struct {
 		struct ieee80211_key_conf conf;
@@ -2002,7 +2002,15 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
 		if (IS_ERR(key))
 			return false;
-		iwl_mvm_set_key_rx_seq_idx(key, status, i);
+
+		for (j = 0; j < ARRAY_SIZE(status->gtk_seq); j++) {
+			if (!status->gtk_seq[j].valid ||
+			    status->gtk_seq[j].key_id != key->keyidx)
+				continue;
+			iwl_mvm_set_key_rx_seq_idx(key, status, j);
+			break;
+		}
+		WARN_ON(j == ARRAY_SIZE(status->gtk_seq));
 	}
 
 	return true;
-- 
2.34.1


