Return-Path: <linux-wireless+bounces-21984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A7A9ADAB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD651940957
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55327A920;
	Thu, 24 Apr 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="by2OMU4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848327B4E2
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498336; cv=none; b=COosK+rEqugYZcMIFDVaDp4VCB/0THUTkyrpkuG3Z33yq23Pq2v0tUZOTX8/2V/Bvap4+feO6sT6XSxtSXtdnD3iJjmA8hKOKb3sU59DFFGqk03DwWN6SfJd7gvk3qYoDzPla0ZYYqsN1LYhU+zE8fnDV461BufskXmOzjd4vVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498336; c=relaxed/simple;
	bh=3k8ks/oz01L3vE3YfjSBVbSPUQPh1nVov/5doyocysI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3oJ4CX4dHOsH0ho8c75silMsuRVrry7t56qOrt47cS484P9mQ8ZpDRv+9v3EP1cTHX0qhk03ZjEf+KAAO1KCFMyZFLjdh1+EjH4F1kb6Rzl+V5kuh6KZ7WgWt40KC9rz34mBaFtQDFhs94Q+XL4nlq43r5AAoony/+vWmcrC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=by2OMU4I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498335; x=1777034335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3k8ks/oz01L3vE3YfjSBVbSPUQPh1nVov/5doyocysI=;
  b=by2OMU4I/hI2hvh0Ya/LR+BJIGEj+YBhQW1gVKcJG+xZZj5cPGsR3Umb
   M21Ey5m46+En63B7nd8xXghnPyZidNiN9l9Mv2+Yw407t/qewG8hJtzbt
   /nA+2OqSBvlNAiozc6YxfgveVynCycFslwC2OAFfU3C7a5ky7UzsFA2m8
   dOJAm7FdDatLHWWrjEG1LVFX0s7taQXwHcjNw2/sq64VRB7y8cHr3HPvG
   ev4Ns0LM/YiGv7GIEMVJtYPoz7DA6Eb1eM+thVJfoQHqN/nI/9tc3nFjy
   J1LZ2aIFQyOIXPHEGC3OYPIHtvtwcVa62r5Wn8xim2aBSCmCflDH7wgsN
   g==;
X-CSE-ConnectionGUID: gM6Qp7dlRJ2llkSOS3hKFg==
X-CSE-MsgGUID: 4WepgQPJQramTaLZw3ILMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302416"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302416"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:54 -0700
X-CSE-ConnectionGUID: 8KzgU+oXRsmauSsy3eNUkA==
X-CSE-MsgGUID: Jj+03PEnSGqb7734EF8C2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137408"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/14] wifi: iwlwifi: mld: allow EMLSR on separated 5 GHz subbands
Date: Thu, 24 Apr 2025 15:38:22 +0300
Message-Id: <20250424153620.d568a26661d5.Ie4277945272c5bbf637957704fda34ea03ef28d2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If there are two links on 5 GHz subbands that are separated
enough (using channels 36-64 and 100+) then we can support
EMLSR across those two links. Allow that in the logic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 24 ++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 8f7578bc46b1..da16fff1ce86 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -805,8 +805,28 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 	    iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false))
 		return false;
 
-	if (a->chandef->chan->band == b->chandef->chan->band)
-		reason_mask |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
+	if (a->chandef->chan->band == b->chandef->chan->band) {
+		const struct cfg80211_chan_def *c_low = a->chandef;
+		const struct cfg80211_chan_def *c_high = b->chandef;
+		u32 c_low_upper_edge, c_high_lower_edge;
+
+		if (c_low->chan->center_freq > c_high->chan->center_freq)
+			swap(c_low, c_high);
+
+		c_low_upper_edge = c_low->chan->center_freq +
+				   cfg80211_chandef_get_width(c_low) / 2;
+		c_high_lower_edge = c_high->chan->center_freq -
+				    cfg80211_chandef_get_width(c_high) / 2;
+
+		if (a->chandef->chan->band == NL80211_BAND_5GHZ &&
+		    c_low_upper_edge <= 5330 && c_high_lower_edge >= 5490) {
+			/* This case is fine - HW/FW can deal with it, there's
+			 * enough separation between the two channels.
+			 */
+		} else {
+			reason_mask |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
+		}
+	}
 	if (!iwl_mld_channel_load_allows_emlsr(mld, vif, a, b))
 		reason_mask |= IWL_MLD_EMLSR_EXIT_CHAN_LOAD;
 
-- 
2.34.1


