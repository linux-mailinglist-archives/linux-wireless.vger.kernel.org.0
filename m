Return-Path: <linux-wireless+bounces-26656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42012B3714D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FFD6883C5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263228135B;
	Tue, 26 Aug 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMi3Pw1T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7C2E3AE6
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229153; cv=none; b=TBDz1rzJO16h029OZsV5L2YsxuoLsm3cK+ULr2AaPF/iQttZw4OA9GQzkJlTf7jWop5IamEelEAWeozFkCiNKC059hPODRMLb84zqM2XTuOfs6R4R2fMvBvzGz7v7ilVUsi8+YPM9gWY7cy2c6JvsUghQxFUbbvhefVFvIwS/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229153; c=relaxed/simple;
	bh=AgB0wQ8CrwfPKNQqOUyEa0RUQ678yNyyU4LlKwnjq/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPDbrj10xdyFcE5JrVa+ow9zj/fMFv/DXbI21K2zKzNoJG96lDWYy1CiM1ViQfoc926R36Mzhry8rs3D43vm6/MmUSj2RxJm1ieoV/BM2P0N6okyqWyv9Pr4UbEegyIc5GBACCaerXMAOjFPAjlT4mDPfGNrXtOjeBuFePvywfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMi3Pw1T; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756229151; x=1787765151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AgB0wQ8CrwfPKNQqOUyEa0RUQ678yNyyU4LlKwnjq/4=;
  b=hMi3Pw1Tt1s4pGCCn1GRXn8pWRus2t1oYOOFO2Bi3SJCWTnLElqehzIr
   Ub2+86TK36fSlwqloOF6bTpfgz5IGRwFUOCRbMlLB5HCYB5zSrfs7H+MK
   RLrEsljD2l0itRNiG8pCCdZ5GKe+0+nIxQuPPffX5fTmrWwnblyYHzgr8
   Djxy4+oItIktzg9htUC/A4/+plD4dFx/uZrc3iWQ015VulLfcs+X8KVF9
   yzrC97jAGaisCGeqzJkF6Mk0c+Bxigs34b27DYOMRafSkjw62XKhd4BVK
   jROqM3n7SLIMN9RysAzetrynnyyMx5pr0ItBr9kTETXYK0mhkuj3DJnth
   g==;
X-CSE-ConnectionGUID: ytSgq5FiTJKRyFQ+4bs72Q==
X-CSE-MsgGUID: 9gqSxXPZTl6gLloaMEXJJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="68745134"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68745134"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:25:51 -0700
X-CSE-ConnectionGUID: rNWYfsJHQfqxImSCbymldg==
X-CSE-MsgGUID: hjGslt8dTC2vC85P5LOOwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169562579"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:25:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: count reg connection element in the size
Date: Tue, 26 Aug 2025 20:25:24 +0300
Message-Id: <20250826202512.b14fc82f736b.I03442382e8a07f6f9836bcdac2e22ce8afbe6a21@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We currently don't count the reg connection length in the per-link
capability length. Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1008eb8e9b13..353e89973d1e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2104,8 +2104,11 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_he_mcs_nss_supp) +
 		IEEE80211_HE_PPE_THRES_MAX_LEN;
 
-	if (sband->band == NL80211_BAND_6GHZ)
+	if (sband->band == NL80211_BAND_6GHZ) {
 		size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
+		/* reg connection */
+		size += 4;
+	}
 
 	size += 2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
-- 
2.34.1


