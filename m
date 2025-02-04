Return-Path: <linux-wireless+bounces-18456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B54A278E4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D58A1881AB8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BF21770E;
	Tue,  4 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZ4QCNlF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0737216E0A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691032; cv=none; b=lHJSZOwBir01uvSbJ/7CC+5RQQa3F0O1REuoufJEFdV2/XB6LCgDA9dNAkAIdSEdOl3X5/NRR38Hvu8RQ5PSb56RtDdC8b7im9j+TGoFNLVHuo+GvYo8dAa76kA2kTc7I1R+LM2CUMdQpxno7drMkNPKczx3bpfvYSTe0W63w3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691032; c=relaxed/simple;
	bh=gZMD+ynmVD5lyQG7Hf4jaCdjR5Sddc/qp4lj1ahTe7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcCPdy2lX5Djbc0b3FD5vEeNbbF/+33G7BoYp+VmDPIra8m5ye9auZs7YMcC8SpmLMvsnK4qdzXoBEQG70IJLqMZGvBhRxZIeQWkq0XfTSTWZaHBZgwLQrNFp8nux9im1uW583nqD8W5a1/yTbnM3zKZq09XeotuPg62uJMRisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZ4QCNlF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691031; x=1770227031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZMD+ynmVD5lyQG7Hf4jaCdjR5Sddc/qp4lj1ahTe7c=;
  b=NZ4QCNlFCLOSshRCVMAl732YykI8rIRs2yAzUNKZYtP3fV4+3FfiLq0h
   CFdNYHXBo3iJk9bCRUpmW8nW6nCpmNAPGkXXUXUd+RXlw+YUmSzUOgWwI
   SteoIFLDR7zf9w7aNJzrvBmVYOUNGxn9O3qFvRZPt++e6sAMdvujo8e0l
   QSFpCaDKNbBlpODoLuvAb+kYG8OpAKAdaHHStSoYaR7R1AhTpGtWJegqA
   cXe6oepti3hA6GXlU2JP9QLiSXl2Ah6AgzZVosUaArWK2kcBV6L6kmRET
   m6N9r/gRBUSIcdNrxFyx7c/3xHv8eo45i6EkcFKHTmE8DBGjtGuicfnO0
   Q==;
X-CSE-ConnectionGUID: aXcsH15yQLClg5XRIUOExQ==
X-CSE-MsgGUID: VCWQXzT7RQeFLZs1mMWEdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585446"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585446"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:58 -0800
X-CSE-ConnectionGUID: KrRwnniJRu6bR4KIvR1zjQ==
X-CSE-MsgGUID: Jb6wA8uTR/qnIUCo2g/6Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696819"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/20] wifi: mac80211: always send max agg subframe num in strict mode
Date: Tue,  4 Feb 2025 19:42:12 +0200
Message-Id: <20250204193721.ae614855f30d.Icd1f93fabc9705e4e760d834095c29b60b934d9e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of only sending the correct number for EHT and up,
always send the correct number as it should be in strict
mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/agg-tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 61f2cac37728..92120f905149 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -464,7 +464,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.deflink.eht_cap.has_eht) {
+	if (sta->sta.deflink.eht_cap.has_eht ||
+	    ieee80211_hw_check(&local->hw, STRICT)) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else if (sta->sta.deflink.he_cap.has_he) {
 		buf_size = min_t(u16, local->hw.max_tx_aggregation_subframes,
-- 
2.34.1


