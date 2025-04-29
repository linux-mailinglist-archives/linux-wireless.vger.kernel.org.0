Return-Path: <linux-wireless+bounces-22216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F8AA1BA7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977CC1728DE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91709263F49;
	Tue, 29 Apr 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt1wwwzs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3F267B07
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956462; cv=none; b=JJtd4r2DLNJDKIwG2iyVAifgdIbSVsBDteeawwkm4TvKt1An4qyoeH+BhCi7ZSgdfaCVgNcG5Y9yLzi3oT5EQk/82L3b+d8mu2GMQstV5O80CjI6h3ujMxJm5q78P/EIov8n4IRrctgs/KD1+kpHgY4CMDbaEh3xGteY8zZ08m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956462; c=relaxed/simple;
	bh=P+5z9/4xDR4bv6/Bh3d2ERrurwI8dYaSLxUvO7fsU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Asmenylmj6gM7s0PkwCqPtVNZ+s18AXQLxA6p5H/bEegdwF39BhWKIa0rf88Ya1cTPlxAPUk2rMhpbjKC/tu491d8nUZp2LZnnjc2I0RciEQWs/SItSH1W0JpRf/vPzBFDonf6ByAXi5jbDOCVR9BuMG67UXzd/sLfCwEEDekhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt1wwwzs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956461; x=1777492461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+5z9/4xDR4bv6/Bh3d2ERrurwI8dYaSLxUvO7fsU7Q=;
  b=Pt1wwwzsANziqQ69zndygYINR4NJz5mKnQKFHFQ3HeyuLgautdRc3Weh
   ETEsaLxOGlRUL1l4zIqXmSKtBsxKTn3VF5rxqmRznXvSl+bkD+RC/KCEl
   yphpaIqMm3PcXu02udxQu2PXR6z36QaKhayJ7JMUT8P+Boa69OvI1ArRL
   PRWoAbAyFnKGVWrIuasaDfjBAXffrRhjxd+TtN+qQMLSjf0we9jOxPhz2
   nOKoLtEmWAov7D39ZOXkmGhoT0iENzpzUNwSVtUn7yWJxICSGXXr7UWV2
   nt7rP0Xvj7hBeAb+pClml/CVqOohD155GeVgacJ/Ds3ALBEFZWy38w4c7
   g==;
X-CSE-ConnectionGUID: hJjl33TpS2OAo4TivTyb0w==
X-CSE-MsgGUID: Y8MMZ2ggQ8CEIxw6+dAX9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713596"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:20 -0700
X-CSE-ConnectionGUID: OXZev2MwQ2ysORfOIZWuqg==
X-CSE-MsgGUID: i7RmPXuBQn+s8MkbAVj+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155024"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/14] wifi: iwlwifi: mld: don't return an error if the FW is dead
Date: Tue, 29 Apr 2025 22:53:41 +0300
Message-Id: <20250429224932.3a362957a4aa.I445bf723e9befc9541b4abd0ec7c72db8f1ff177@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If iwl_mld_change_vif_links failed to add the requested link(s)
because the FW is dead (error before recovery), there is no point
in returning an error value, as the reconfig will re-add the link(s)
after the FW is started.
Return 0 in that case, and WARN in the others.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 284599abf8c6..6710dcacecd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2457,8 +2457,10 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		if (added & BIT(i)) {
 			link_conf = link_conf_dereference_protected(vif, i);
-			if (WARN_ON(!link_conf))
-				return -EINVAL;
+			if (!link_conf) {
+				err = -EINVAL;
+				goto remove_added_links;
+			}
 
 			err = iwl_mld_add_link(mld, link_conf);
 			if (err)
@@ -2493,7 +2495,11 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 		iwl_mld_remove_link(mld, link_conf);
 	}
 
-	return err;
+	if (WARN_ON(!iwl_mld_error_before_recovery(mld)))
+		return err;
+
+	/* reconfig will fix us anyway */
+	return 0;
 }
 
 static int iwl_mld_change_sta_links(struct ieee80211_hw *hw,
-- 
2.34.1


